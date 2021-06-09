Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DBC3A1C87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFISKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFISKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:10:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC156C061574;
        Wed,  9 Jun 2021 11:08:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a11so39075680ejf.3;
        Wed, 09 Jun 2021 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FjY0ZveY0BlQM+MQuFHufo1r7Pl0Y1a4o9Zmnw9z0Xw=;
        b=ji9KxGGVUCLhYDqEVjkpmoH9HTCI1SYGab9CJZVynhXoPmnUkh9+CwHABDq3zg7PU/
         bRaJMYpalcvBPfkeGWD51+P79M76SsL2kYanI+I6Orlj1zrKuzfH7KIf+L237+/AJTEk
         ffNulI9MK66r1ejhCv9Sr3cOWOJzVE1zjcezhg8gMWLBNWuj3K76kDwt5dZdoKzhxWu0
         gJK9LNWPBVW7ilJ4tVDv7Q9LIr2umkNKN57jEfsOX2eFIQi6mVNNVJ/3IEXWdMDqSexC
         FeAwHF4cKOJ4Eu8umtTF20VWEjmHWjpSrWJ+lkBJD++Rh3JS5ERlWuHMWuE/bY+nUh0k
         W9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FjY0ZveY0BlQM+MQuFHufo1r7Pl0Y1a4o9Zmnw9z0Xw=;
        b=SLigO3/XdYXtBEpsV0gahy2+LpIMpZprIzjyUetXCHR5StxM1t2k4kXxtXmrKc5ouX
         IXLVDMZ4ymwJnF4CuRs5YszixHwkGng1inRJxGvIsW78/QeVM6hjh2uabCQLr0ZH4eLv
         aIFbsF3vKXnyxGXIHVaGpvjS1QVhtIDhJzNlvgB4mzGWDskajLN8TQmM+EzvucmLxM+/
         TB7FeWnDRNKZFf1/soUBNNEHUC+wvASFsqu63tm3xG0DKbnnCcR4uDzzAOuMj59DxTT1
         G8W6gXcGzMqxgLGzYXt4dOE8a+hYLugWLOW1UnMbwJ+cDZIw8FdCXsFYcmGV9Y8CZpTb
         UMhg==
X-Gm-Message-State: AOAM533fliOBqFD0z0SKozd5aDfv/MzB/B4mRQxVMVa9TB1N3Z5tAscu
        WnGnQPzJSZlfwg1rf3/3irT51+QE5uO6yaef+Lw5OmCv914=
X-Google-Smtp-Source: ABdhPJy8xXTJdet5a08AqT0UOBYU1szH9dLaCcYWtJVJoZQrmczsiIv5LAJW3bQomOYrGwaYIj0edeoHvAC13Ju3tG8=
X-Received: by 2002:a17:906:a0d3:: with SMTP id bh19mr1050997ejb.205.1623262105735;
 Wed, 09 Jun 2021 11:08:25 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 9 Jun 2021 23:38:14 +0530
Message-ID: <CAOuPNLiRDZ9M4n3uh=i6FpHXoVEWMHpt0At8YaydrOM=LvSvdg@mail.gmail.com>
Subject: qemu: arm: mounting ubifs using nandsim on busybox
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

I am trying to emulate ubifs using nandsim (built-in), qemu-arm,
busybox and kernel-5.4.
I hope that this combination already works, so I am here to sort out
my booting issues with these.
Few details before I describe my issue:
a) I have already created a working busybox image for arm32 (_install folde=
r).
b) Using this I have created the ubifs image using mkfs.ubifs.
c) Then I have also created the final ubifs-root image using the
ubinize command.
d) I have also built the kernel-5.4 for arm vexpress
e) This kernel is working fine with the same busybox initramfs image.
f) Now I want to use nandsim to emulate ubifs in the same environment.

For (f) I have used the below command:
$ qemu-system-arm -M virt -m 512M -kernel linux/arch/arm/boot/zImage
-append "ubi.mtd=3D1 root=3D/dev/mtdblock0 roottype=3Dubifs
console=3DttyAMA0,115200" -drive
if=3Dmtd,driver=3Draw,cache=3Dwriteback,file=3D./ubi-boot.img,id=3Dmtd1 -de=
vice
nand,chip_id=3D0x39,manufacturer_id=3D0x98,drive=3Dmtd1  -nographic -smp 4

But I get these errors during boot.
---------------------------
ubi0: background thread "ubi_bgt0d" started, PID 55
List of all partitions:
1f00          131072 mtdblock0
 (driver?)
1f01          131072 mtdblock1
 (driver?)
No filesystem could mount root, tried:
 ext3
 ext4
 ext2
 cramfs
 squashfs
 vfat

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3=
1,0)

---------------------------
I also tried to replace the ubifs with squashfs but its the same result.

Here is the complete logs:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Booting Linux on physical CPU 0x0
Linux version 5.4.124 (pintu@blr-ubuntu-498) (gcc version 5.4.0
20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)) #5 SMP Wed Jun 9
18:14:50 IST 2021
CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=3D10c5387d
CPU: div instructions available: patching division code
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
OF: fdt: Machine model: linux,dummy-virt
Memory policy: Data cache writealloc
cma: Reserved 16 MiB at 0x5f000000
psci: probing for conduit method from DT.
psci: PSCIv0.2 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS migration not required
percpu: Embedded 19 pages/cpu s45516 r8192 d24116 u77824
Built 1 zonelists, mobility grouping on.  Total pages: 130048
Kernel command line: ubi.mtd=3D1 root=3D/dev/mtdblock0 roottype=3Dubifs
console=3DttyAMA0,115200
printk: log_buf_len individual max cpu contribution: 4096 bytes
printk: log_buf_len total cpu_extra contributions: 12288 bytes
printk: log_buf_len min size: 16384 bytes
printk: log_buf_len: 32768 bytes
printk: early log buf free: 14740(89%)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
mem auto-init: stack:off, heap alloc:off, heap free:off
Memory: 492100K/524288K available (7168K kernel code, 433K rwdata,
1796K rodata, 1024K init, 159K bss, 15804K reserved, 16384K
cma-reserved)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
rcu: Hierarchical RCU implementation.
rcu:    RCU event tracing is enabled.
rcu:    RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D4.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D4
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
random: get_random_bytes called from start_kernel+0x310/0x4b4 with crng_ini=
t=3D0
arch_timer: WARNING: Invalid trigger for IRQ18, assuming level low
arch_timer: WARNING: Please fix your firmware
arch_timer: cp15 timer(s) running at 62.50MHz (virt).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 56 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
Switching to timer-based delay loop, resolution 16ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer
frequency.. 125.00 BogoMIPS (lpj=3D625000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: firmware did not set auxiliary control register IBE
bit, system vulnerable
/cpus/cpu@0 missing clock-frequency property
/cpus/cpu@1 missing clock-frequency property
/cpus/cpu@2 missing clock-frequency property
/cpus/cpu@3 missing clock-frequency property
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x40100000 - 0x40100060
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
CPU1: Spectre v2: firmware did not set auxiliary control register IBE
bit, system vulnerable
CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
CPU2: Spectre v2: firmware did not set auxiliary control register IBE
bit, system vulnerable
CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
CPU3: Spectre v2: firmware did not set auxiliary control register IBE
bit, system vulnerable
smp: Brought up 1 node, 4 CPUs
SMP: Total of 4 processors activated (500.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
devtmpfs: initialized
VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
cpuidle: using governor ladder
hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
hw-breakpoint: maximum watchpoint size is 8 bytes.
Serial: AMBA PL011 UART driver
9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq =3D 53, base_baud =3D 0) is
a PL011 rev1
printk: console [ttyAMA0] enabled
irq: type mismatch, failed to map hwirq-27 for intc!
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Advanced Linux Sound Architecture Driver Initialized.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, lin=
ear)
TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
TCP bind hash table entries: 4096 (order: 3, 32768 bytes, linear)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
workingset: timestamp_bits=3D30 max_order=3D17 bucket_order=3D0
squashfs: version 4.0 (2009/01/31) Phillip Lougher
jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
9p: Installing v9fs 9p2000 file system support
io scheduler mq-deadline registered
io scheduler kyber registered
pci-host-generic 3f000000.pcie: host bridge /pcie@10000000 ranges:
pci-host-generic 3f000000.pcie:    IO 0x3eff0000..0x3effffff -> 0x00000000
pci-host-generic 3f000000.pcie:   MEM 0x10000000..0x3efeffff -> 0x10000000
pci-host-generic 3f000000.pcie:   MEM 0x8000000000..0xffffffffff -> 0x80000=
00000
pci-host-generic 3f000000.pcie: ECAM at [mem 0x3f000000-0x3fffffff]
for [bus 00-0f]
pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-0f]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
PCI: bus0: Fast back to back transfers disabled
physmap-flash 0.flash: physmap platform flash device: [mem
0x00000000-0x03ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID
0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
physmap-flash 0.flash: physmap platform flash device: [mem
0x04000000-0x07ffffff]
0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID
0x000000 Chip ID 0x000000
Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
Concatenating MTD devices:
(0): "0.flash"
(1): "0.flash"
into device "0.flash"
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
[nandsim] warning: read_byte: unexpected data output cycle, state is
STATE_READY return 0x0
nand: device found, Manufacturer ID: 0x98, Chip ID: 0x39
nand: Toshiba NAND 128MiB 1,8V 8-bit
nand: 128 MiB, SLC, erase size: 16 KiB, page size: 512, OOB size: 16
flash size: 128 MiB
page size: 512 bytes
OOB area size: 16 bytes
sector size: 16 KiB
pages number: 262144
pages per sector: 32
bus width: 8
bits in sector size: 14
bits in page size: 9
bits in OOB size: 4
flash size with OOB: 135168 KiB
page address bytes: 4
sector address bytes: 3
options: 0x42
Scanning device for bad blocks
Creating 1 MTD partitions on "NAND 128MiB 1,8V 8-bit":
0x000000000000-0x000008000000 : "NAND simulator partition 0"
[nandsim] warning: CONFIG_MTD_PARTITIONED_MASTER must be enabled to
expose debugfs stuff
libphy: Fixed MDIO Bus: probed
usbcore: registered new interface driver usb-storage
rtc-pl031 9010000.pl031: registered as rtc0
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
oprofile: no performance counters
oprofile: using timer interrupt.
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Registering SWP/SWPB emulation handler
ubi0: attaching mtd1
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0: attached mtd1 (name "NAND simulator partition 0", size 128 MiB)
ubi0: PEB size: 16384 bytes (16 KiB), LEB size: 15872 bytes
ubi0: min./max. I/O unit sizes: 512/512, sub-page size 256
ubi0: VID header offset: 256 (aligned 256), data offset: 512
ubi0: good PEBs: 8192, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 0, internal volumes: 1, max. volumes count: 92
ubi0: max/mean erase counter: 0/0, WL threshold: 4096, image sequence
number: 1289582509
ubi0: available PEBs: 8028, total reserved PEBs: 164, PEBs reserved
for bad PEB handling: 160
rtc-pl031 9010000.pl031: setting system clock to 2021-06-09T17:52:47
UTC (1623261167)
ALSA device list:
  No soundcards found.
ubi0: background thread "ubi_bgt0d" started, PID 55
List of all partitions:
1f00          131072 mtdblock0
 (driver?)
1f01          131072 mtdblock1
 (driver?)
No filesystem could mount root, tried:
 ext3
 ext4
 ext2
 cramfs
 squashfs
 vfat

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3=
1,0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

If any one has used nandsim on qemu before, please let us know the exact st=
eps.

I even tried to use the machine type as vexpress-a9 but its almost the
same issue.

$ qemu-system-arm -M vexpress-a9 -m 512M -kernel
linux/arch/arm/boot/zImage -dtb
linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -append
"console=3DttyAMA0,115200 ubi.mtd=3D2 root=3D/dev/mtdblock2 rootfstype=3Dub=
ifs
mtdparts=3D=3Dnand:-(rootfs)" -device nand,chip_id=3D0x39,id=3Dmtd2 -drive
if=3Dmtd,driver=3Draw,cache=3Dwriteback,file=3D./ubi-boot.img,id=3Dmtd2
-nographic -smp 4

But with this also I get these errors:
[...]
Warning: Orphaned drive without device:
id=3Dmtd2,file=3D./ubi-boot.img,if=3Dmtd,bus=3D0,unit=3D0
[...]
List of all partitions:
1f00          131072 mtdblock0
 (driver?)
1f01           32768 mtdblock1
 (driver?)
1f02          131072 mtdblock2
 (driver?)
No filesystem could mount root, tried:
 ubifs

Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3=
1,0)


Thanks,
Pintu
