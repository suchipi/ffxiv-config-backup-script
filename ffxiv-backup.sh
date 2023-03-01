#!/usr/bin/env bash

set -e

FROM_DIR=${1:-"$HOME/.xlcore"}
TO_DIR=${2:-"./backup"}

echo FROM_DIR: $FROM_DIR
echo TO_DIR: $TO_DIR

mkdir -p "$TO_DIR"

FROM_DIR_ABSOLUTE=$(realpath "$FROM_DIR")
TO_DIR_ABSOLUTE=$(realpath "$TO_DIR")

cd "$FROM_DIR_ABSOLUTE"

FILES=(
  ffxivConfig/FFXIV_CH*
  ffxivConfig/MACROSYS.dat
  ffxiv/game/dxgi.dll
  ffxiv/game/d3dcompiler_47.dll
  ffxiv/game/GShade.ini
  ffxiv/game/gshade-presets/
  ffxiv/game/gshade-shaders/
  ffxiv/game/notification.wav
)

for path in "${FILES[@]}"; do
  src="$FROM_DIR_ABSOLUTE/$path"
  dest="$TO_DIR_ABSOLUTE/$path"

  echo "$src -> $dest"

  mkdir -p $(dirname "$dest")
  cp --recursive --remove-destination "$src" "$dest"
done
