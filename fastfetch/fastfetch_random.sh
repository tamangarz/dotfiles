#!/bin/bash
LOGO_DIR="$HOME/.config/fastfetch/logo"
STATE_FILE="$HOME/.config/fastfetch/.logo-index"

mapfile -t LOGOS < <(find "$LOGO_DIR" -name "*.icon" | sort)

if [ ${#LOGOS[@]} -eq 0 ]; then
    fastfetch "$@"
    exit
fi

INDEX=0
[ -f "$STATE_FILE" ] && INDEX=$(<"$STATE_FILE")

if [ "$INDEX" -ge ${#LOGOS[@]} ]; then
    INDEX=0
fi

fastfetch --logo "${LOGOS[$INDEX]}" --logo-type kitty "$@"

echo $(( (INDEX + 1) % ${#LOGOS[@]} )) > "$STATE_FILE"