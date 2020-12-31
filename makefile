make:
	mkdir -p build
	i686-elf-as src/boot/boot.s -o build/boot.o
	i686-elf-gcc -c src/kernel/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-gcc -T linker.ld -o build/myos.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc
	
	mkdir -p build/isodir/boot/grub
	cp build/myos.bin build/isodir/boot/myos.bin
	cp src/boot/grub.cfg build/isodir/boot/grub/grub.cfg
	grub-mkrescue -o build/myos.iso build/isodir
	qemu-system-i386 -cdrom build/myos.iso
