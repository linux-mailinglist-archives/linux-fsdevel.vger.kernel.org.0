Return-Path: <linux-fsdevel+bounces-61155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFDB55ADB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 02:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2310EAA1D79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDD450FE;
	Sat, 13 Sep 2025 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7vhDc7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619D70810
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724010; cv=none; b=W0jYJWnWBFKLhYvzTdgfhtuD4OQ+ypISFdsEaiLg9P04lmrVBJaOYiFqkxKv5cQFVs1Wyjb7NELGWAW8tWjm33EEZfW/m/CGha40iZbERinefBx9ZaIGVhM7/Zq348AQ2MuOBeWAudu2Po7bm1rHcxCTqtQr0jLNI5C3tIEupKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724010; c=relaxed/simple;
	bh=qWSJ9cVYeoy/I9YIWeZ/NoeqNv03O5nF69asVgm6nYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTn+c6Wm2TnPxrU6FIIQMQDYdHQhgEdu6CVmo8qP0WFRaPowRru9afIAKctRnk7O1ch3M6OJqFfaghuTjDQy1B/eFMnQqc/eiWqD5ik5TmMGcgdRQJxj/UHBTwQU777lcIhPJubw4S3T+N19Zc+543tWB7aVWMALmInMDVzDvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7vhDc7P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so461192566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724002; x=1758328802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52+cGRj7+PdCBvIKyhk4FPWMxzGxsEuNUe9nubIwFOs=;
        b=d7vhDc7PzrrMP2ybaWcFRBrKZP+UMIacDHxijpl4B2DoXPzq+BeU4ECg7QmWMCPkds
         awECDsz4ynG7HZNR6jLHP/1QM1h47ZGv4kdOezIoZOdgMyQN1ahdqhWV4+dBBW8SVyR/
         BUxb7K5g5Tuq9dVxd9FGd3+B3LFFwu1dXuXft3Q7Du0UJGiNCygwA6WcfDnuOuHQtq1+
         Yg4Nt4G4OniHQHI8jqzIlfaFk+e3TDdloxgwSl0gUxuKT2ANsJ0mlX/wRd6In+doeJBu
         NySANweJLQRaWlCTWxcz6HLeDK0gX4NuWoEdHV31kDBYt1dnihMU1U6swCoSSQ7GQrBx
         qfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724002; x=1758328802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52+cGRj7+PdCBvIKyhk4FPWMxzGxsEuNUe9nubIwFOs=;
        b=PIkseZc3tHt92VveInTLjn3scaLtbSLQQgBhFya+JZ2sd1ZFguakY8rMAmZUMA0eol
         qd2pAQAr8DaNYkiX5i4a/rfQMS2htrdO7fbofoPQYBiSpdmMn5CN79tavVPcJiD62ooG
         rNHZO7BR9p17l1AjELeTLQXXShzY2jmqpDa+aLb+1ohNX95KQBxqelxUh72TDRots+9l
         oV9265oISj9gh0bgayImVFEbSMqF3puvCQl7a5ppSSQnYGp6vbBxDLRaamgbnIDLrn+R
         rbJEV1Yb0JajwKnpi47ugSXQQn0k03XDy9dCEP/V/Vevs1ZL/AzIEEZ+7Az0gOQSO+Nl
         DzQA==
X-Gm-Message-State: AOJu0Yw3Tm7ymfxq7rXH+sJAXpg9mjtG+FcDXpLBarHaazN7Wi/gfWZ/
	UqyIHbsEGoP2ov5y2gIwgclqOSyxGveU3YJbXXzIWzx/9/Xx159OA56NKD1+chfQ
X-Gm-Gg: ASbGnct+t/RH3g5wSnd8cOmRLrRSmNk8AOyC6wnGuS6QqRsf8YWddssh2bhT83rUTYQ
	ewXrJyNApqUopiTI2bx0qX02CQv/s9tqp6ajzMoBQd6U7VWdH5wT3Wj1LSgle6Ehx7QrKJ6qhJu
	gfrVLRmCL2F6V8nNA9qfq2qXn6cTsgf6tN/LxV+RmM/xwJS8bJXI6aMNcskWiQJbf46b/I/EdbS
	2nH+gJQJ1EnS6FSRmYfI85M0lk4sF8qnbDYZK/zZGKktXruRVz+Jd/JjZ0uLSj7ku5tUKP1ytH5
	nctQaszIZU9pO+lVInaIbH9H3oAjkAEV5kD7G+grFs/4vcJ93NQid+mnYVL5lxSPrYlT7HmvZke
	f3dpkTwQrvfMnV56B3n8=
X-Google-Smtp-Source: AGHT+IF4yjCZcgx3PleuGQf+gyje4P5YWuxRl2sdlWt7pYyme8W7tPI+PtyaqBqXZIeov8NIT4wIcw==
X-Received: by 2002:a17:907:d17:b0:b07:87fe:c53f with SMTP id a640c23a62f3a-b07a62910dbmr973672466b.2.1757724001146;
        Fri, 12 Sep 2025 17:40:01 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347b6fsm475414166b.111.2025.09.12.17.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:40:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Sat, 13 Sep 2025 00:37:39 +0000
Message-ID: <20250913003842.41944-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intro
====
This patchset removes classic initrd (initial RAM disk) support,
which was deprecated in 2020.
Initramfs still stays, and RAM disk itself (brd) still stays, too.
init/do_mounts* and init/*initramfs* are listed in VFS entry in
MAINTAINERS, so I think this patchset should go through VFS tree.
This patchset touchs every subdirectory in arch/, so I tested it
on 8 (!!!) archs in Qemu (see details below).
Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_INITRAMFS
and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
If you still use initrd, see below for workaround.

Details
====
I not only removed initrd, I also removed a lot of code, which
became dead, including a lot of code in arch/.

Still I think the only two architectures I touched in non-trivial
way are sh and 32-bit arm.

Also I renamed some files, functions and variables (which became misnomers) to proper names,
moved some code around, removed a lot of mentions of initrd
in code and comments. Also I cleaned up some docs.

For example, I renamed the following global variables:

__initramfs_start
__initramfs_size
phys_initrd_start
phys_initrd_size
initrd_start
initrd_end

to:

__builtin_initramfs_start
__builtin_initramfs_size
phys_external_initramfs_start
phys_external_initramfs_size
virt_external_initramfs_start
virt_external_initramfs_end

New names precisely capture meaning of these variables.

Also I renamed CONFIG_BLK_DEV_INITRD (which became total misnomer)
to CONFIG_INITRAMFS. And CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_*.
This will break all configs out there (update your configs!).
Still I think this is okay,
because config names never were part of stable API.
Still, I don't have strong opinion here, so I can drop these renamings
if needed.

Other user-visible changes:

- Removed kernel command line parameters "load_ramdisk" and
"prompt_ramdisk", which did nothing and were deprecated
- Removed kernel command line parameter "ramdisk_start",
which was used for initrd only (not for initramfs)
- Removed kernel command line parameter "noinitrd",
which was inconsistent: it controlled initrd only
(not initramfs), except for EFI boot, where it
controlled both initramfs and initrd. EFI users
still can disable initramfs simply by not passing it
- Removed kernel command line parameter "ramdisk_size",
which used for controlling ramdisk (brd), but only
in non-modular mode. Use brd.rd_size instead, it
always works
- Removed /proc/sys/kernel/real-root-dev . It was used
for initrd only

This patchset is based on v6.17-rc5.

Testing
====
I tested my patchset on many architectures in Qemu using my Rust
program, heavily based on mkroot [1].

I used the following cross-compilers:

aarch64-linux-musleabi
armv4l-linux-musleabihf
armv5l-linux-musleabihf
armv7l-linux-musleabihf
i486-linux-musl
i686-linux-musl
mips-linux-musl
mips64-linux-musl
mipsel-linux-musl
powerpc-linux-musl
powerpc64-linux-musl
powerpc64le-linux-musl
riscv32-linux-musl
riscv64-linux-musl
s390x-linux-musl
sh4-linux-musl
sh4eb-linux-musl
x86_64-linux-musl

taken from this directory [2].

So, as you can see, there are 18 triplets, which correspond to 8 subdirs in arch/.

And note that this list contains two archs (arm and sh) touched in non-trivial way.

For every triplet I tested that:
- Initramfs still works (both builtin and external)
- Direct boot from disk still works

Workaround
====
If "retain_initrd" is passed to kernel, then initramfs/initrd,
passed by bootloader, is retained and becomes available after boot
as read-only magic file /sys/firmware/initrd [3].

No copies are involved. I. e. /sys/firmware/initrd is simply
a reference to original blob passed by bootloader.

This works even if initrd/initramfs is not recognized by kernel
in any way, i. e. even if it is not valid cpio archive, nor
a fs image supported by classic initrd.

This works both with my patchset and without it.

This means that you can emulate classic initrd so:
link builtin initramfs to kernel. In /init in this initramfs
copy /sys/firmware/initrd to some file in / and loop-mount it.

This is even better than classic initrd, because:
- You can use fs not supported by classic initrd, for example erofs
- One copy is involved (from /sys/firmware/initrd to some file in /)
as opposed to two when using classic initrd

Still, I don't recommend using this workaround, because
I want everyone to migrate to proper modern initramfs.
But still you can use this workaround if you want.

Also: it is not possible to directly loop-mount
/sys/firmware/initrd . Theoretically kernel can be changed
to allow this (and/or to make it writable), but I think nobody needs this.
And I don't want to implement this.

P. S. When I sent this patchset first time, zoho mail banned me for
too much email. So I resend this using gmail. The only change is
email change, there are no other changes

[1] https://github.com/landley/toybox/tree/master/mkroot
[2] https://landley.net/toybox/downloads/binaries/toolchains/latest
[3] https://lore.kernel.org/all/20231207235654.16622-1-graf@amazon.com/

Askar Safin (62):
  init: remove deprecated "load_ramdisk" command line parameter, which
    does nothing
  init: remove deprecated "prompt_ramdisk" command line parameter, which
    does nothing
  init: sh, sparc, x86: remove unused constants RAMDISK_PROMPT_FLAG and
    RAMDISK_LOAD_FLAG
  init: x86, arm, sh, sparc: remove variable rd_image_start, which
    controls starting block number of initrd
  init: remove "ramdisk_start" command line parameter, which controls
    starting block number of initrd
  arm: init: remove special logic for setting brd.rd_size
  arm: init: remove ATAG_RAMDISK
  arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
  arm: init: document rd_start (in param_struct) as obsolete
  initrd: remove initrd (initial RAM disk) support
  init, efi: remove "noinitrd" command line parameter
  init: remove /proc/sys/kernel/real-root-dev
  ext2: remove ext2_image_size and associated code
  init: m68k, mips, powerpc, s390, sh: remove Root_RAM0
  doc: modernize Documentation/admin-guide/blockdev/ramdisk.rst
  brd: remove "ramdisk_size" command line parameter
  doc: modernize Documentation/filesystems/ramfs-rootfs-initramfs.rst
  doc: modernize
    Documentation/driver-api/early-userspace/early_userspace_support.rst
  init: remove mentions of "ramdisk=" command line parameter
  doc: remove Documentation/power/swsusp-dmcrypt.rst
  init: remove all mentions of root=/dev/ram*
  doc: remove obsolete mentions of pivot_root
  init: rename __initramfs_{start,size} to
    __builtin_initramfs_{start,size}
  init: remove wrong comment
  init: rename phys_initrd_{start,size} to
    phys_external_initramfs_{start,size}
  init: move phys_external_initramfs_{start,size} to init/initramfs.c
  init: alpha: remove "extern unsigned long initrd_start, initrd_end"
  init: alpha, arc, arm, arm64, csky, m68k, microblaze, mips, nios2,
    openrisc, parisc, powerpc, s390, sh, sparc, um, x86, xtensa: rename
    initrd_{start,end} to virt_external_initramfs_{start,end}
  init: move virt_external_initramfs_{start,end} to init/initramfs.c
  doc: remove documentation for block device 4 0
  init: rename initrd_below_start_ok to initramfs_below_start_ok
  init: move initramfs_below_start_ok to init/initramfs.c
  init: remove init/do_mounts_initrd.c
  init: inline create_dev into the only caller
  init: make mount_root_generic static
  init: make mount_root static
  init: remove root_mountflags from init/do_mounts.h
  init: remove most headers from init/do_mounts.h
  init: make console_on_rootfs static
  init: rename free_initrd_mem to free_initramfs_mem
  init: rename reserve_initrd_mem to reserve_initramfs_mem
  init: rename <linux/initrd.h> to <linux/initramfs.h>
  setsid: inline ksys_setsid into the only caller
  doc: kernel-parameters: remove [RAM] from reserve_mem=
  doc: kernel-parameters: replace [RAM] with [INITRAMFS]
  init: edit docs for initramfs-related configs
  init: fix typo: virtul => virtual
  init: fix comment
  init: rename ramdisk_execute_command to initramfs_execute_command
  init: rename ramdisk_command_access to initramfs_command_access
  init: rename get_boot_config_from_initrd to
    get_boot_config_from_initramfs
  init: rename do_retain_initrd to retain_initramfs
  init: rename kexec_free_initrd to kexec_free_initramfs
  init: arm, x86: deal with some references to initrd
  init: rename CONFIG_BLK_DEV_INITRD to CONFIG_INITRAMFS
  init: rename CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP
  init: rename CONFIG_RD_BZIP2 to CONFIG_INITRAMFS_DECOMPRESS_BZIP2
  init: rename CONFIG_RD_LZMA to CONFIG_INITRAMFS_DECOMPRESS_LZMA
  init: rename CONFIG_RD_XZ to CONFIG_INITRAMFS_DECOMPRESS_XZ
  init: rename CONFIG_RD_LZO to CONFIG_INITRAMFS_DECOMPRESS_LZO
  init: rename CONFIG_RD_LZ4 to CONFIG_INITRAMFS_DECOMPRESS_LZ4
  init: rename CONFIG_RD_ZSTD to CONFIG_INITRAMFS_DECOMPRESS_ZSTD

 .../admin-guide/blockdev/ramdisk.rst          | 104 +----
 .../admin-guide/device-mapper/dm-init.rst     |   4 +-
 Documentation/admin-guide/devices.txt         |  12 -
 Documentation/admin-guide/index.rst           |   1 -
 Documentation/admin-guide/initrd.rst          | 383 ------------------
 .../admin-guide/kernel-parameters.rst         |   4 +-
 .../admin-guide/kernel-parameters.txt         |  38 +-
 Documentation/admin-guide/nfs/nfsroot.rst     |   4 +-
 Documentation/admin-guide/sysctl/kernel.rst   |   6 -
 Documentation/arch/arm/ixp4xx.rst             |   4 +-
 Documentation/arch/arm/setup.rst              |   6 +-
 Documentation/arch/m68k/kernel-options.rst    |  29 +-
 Documentation/arch/x86/boot.rst               |   4 +-
 .../early_userspace_support.rst               |  18 +-
 .../filesystems/ramfs-rootfs-initramfs.rst    |  20 +-
 Documentation/power/index.rst                 |   1 -
 Documentation/power/swsusp-dmcrypt.rst        | 140 -------
 Documentation/security/ipe.rst                |   2 +-
 .../translations/zh_CN/power/index.rst        |   1 -
 arch/alpha/kernel/core_irongate.c             |  12 +-
 arch/alpha/kernel/proto.h                     |   2 +-
 arch/alpha/kernel/setup.c                     |  32 +-
 arch/arc/configs/axs101_defconfig             |   2 +-
 arch/arc/configs/axs103_defconfig             |   2 +-
 arch/arc/configs/axs103_smp_defconfig         |   2 +-
 arch/arc/configs/haps_hs_defconfig            |   2 +-
 arch/arc/configs/haps_hs_smp_defconfig        |   2 +-
 arch/arc/configs/hsdk_defconfig               |   2 +-
 arch/arc/configs/nsim_700_defconfig           |   2 +-
 arch/arc/configs/nsimosci_defconfig           |   2 +-
 arch/arc/configs/nsimosci_hs_defconfig        |   2 +-
 arch/arc/configs/nsimosci_hs_smp_defconfig    |   2 +-
 arch/arc/configs/tb10x_defconfig              |   4 +-
 arch/arc/configs/vdk_hs38_defconfig           |   2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig       |   2 +-
 arch/arc/mm/init.c                            |  14 +-
 arch/arm/Kconfig                              |   2 +-
 arch/arm/boot/dts/arm/integratorap.dts        |   2 +-
 arch/arm/boot/dts/arm/integratorcp.dts        |   2 +-
 .../dts/aspeed/aspeed-bmc-facebook-cmm.dts    |   2 +-
 .../aspeed/aspeed-bmc-facebook-galaxy100.dts  |   2 +-
 .../aspeed/aspeed-bmc-facebook-minipack.dts   |   2 +-
 .../aspeed/aspeed-bmc-facebook-wedge100.dts   |   2 +-
 .../aspeed/aspeed-bmc-facebook-wedge40.dts    |   2 +-
 .../dts/aspeed/aspeed-bmc-facebook-yamp.dts   |   2 +-
 .../ast2600-facebook-netbmc-common.dtsi       |   2 +-
 arch/arm/boot/dts/hisilicon/hi3620-hi4511.dts |   2 +-
 .../ixp/intel-ixp42x-welltech-epbx100.dts     |   2 +-
 arch/arm/boot/dts/nspire/nspire-classic.dtsi  |   2 +-
 arch/arm/boot/dts/nspire/nspire-cx.dts        |   2 +-
 .../boot/dts/samsung/exynos4210-origen.dts    |   2 +-
 .../boot/dts/samsung/exynos4210-smdkv310.dts  |   2 +-
 .../boot/dts/samsung/exynos4412-smdk4412.dts  |   2 +-
 .../boot/dts/samsung/exynos5250-smdk5250.dts  |   2 +-
 arch/arm/boot/dts/st/ste-nomadik-nhk15.dts    |   2 +-
 arch/arm/boot/dts/st/ste-nomadik-s8815.dts    |   2 +-
 arch/arm/boot/dts/st/stm32429i-eval.dts       |   2 +-
 arch/arm/boot/dts/st/stm32746g-eval.dts       |   2 +-
 arch/arm/boot/dts/st/stm32f429-disco.dts      |   2 +-
 arch/arm/boot/dts/st/stm32f469-disco.dts      |   2 +-
 arch/arm/boot/dts/st/stm32f746-disco.dts      |   2 +-
 arch/arm/boot/dts/st/stm32f769-disco.dts      |   2 +-
 arch/arm/boot/dts/st/stm32h743i-disco.dts     |   2 +-
 arch/arm/boot/dts/st/stm32h743i-eval.dts      |   2 +-
 arch/arm/boot/dts/st/stm32h747i-disco.dts     |   2 +-
 arch/arm/boot/dts/st/stm32h750i-art-pi.dts    |   2 +-
 arch/arm/configs/aspeed_g4_defconfig          |   8 +-
 arch/arm/configs/aspeed_g5_defconfig          |   8 +-
 arch/arm/configs/assabet_defconfig            |   4 +-
 arch/arm/configs/at91_dt_defconfig            |   4 +-
 arch/arm/configs/axm55xx_defconfig            |   2 +-
 arch/arm/configs/bcm2835_defconfig            |   2 +-
 arch/arm/configs/clps711x_defconfig           |   4 +-
 arch/arm/configs/collie_defconfig             |   4 +-
 arch/arm/configs/davinci_all_defconfig        |   2 +-
 arch/arm/configs/exynos_defconfig             |   4 +-
 arch/arm/configs/footbridge_defconfig         |   2 +-
 arch/arm/configs/gemini_defconfig             |   2 +-
 arch/arm/configs/h3600_defconfig              |   2 +-
 arch/arm/configs/hisi_defconfig               |   4 +-
 arch/arm/configs/imx_v4_v5_defconfig          |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig          |   4 +-
 arch/arm/configs/integrator_defconfig         |   2 +-
 arch/arm/configs/ixp4xx_defconfig             |   2 +-
 arch/arm/configs/keystone_defconfig           |   2 +-
 arch/arm/configs/lpc18xx_defconfig            |  12 +-
 arch/arm/configs/lpc32xx_defconfig            |   4 +-
 arch/arm/configs/milbeaut_m10v_defconfig      |   2 +-
 arch/arm/configs/multi_v4t_defconfig          |   2 +-
 arch/arm/configs/multi_v5_defconfig           |   2 +-
 arch/arm/configs/multi_v7_defconfig           |   2 +-
 arch/arm/configs/mvebu_v7_defconfig           |   2 +-
 arch/arm/configs/mxs_defconfig                |   2 +-
 arch/arm/configs/neponset_defconfig           |   4 +-
 arch/arm/configs/nhk8815_defconfig            |   2 +-
 arch/arm/configs/omap1_defconfig              |   2 +-
 arch/arm/configs/omap2plus_defconfig          |   2 +-
 arch/arm/configs/pxa910_defconfig             |   2 +-
 arch/arm/configs/pxa_defconfig                |   4 +-
 arch/arm/configs/qcom_defconfig               |   2 +-
 arch/arm/configs/rpc_defconfig                |   2 +-
 arch/arm/configs/s3c6400_defconfig            |   4 +-
 arch/arm/configs/s5pv210_defconfig            |   4 +-
 arch/arm/configs/sama5_defconfig              |   4 +-
 arch/arm/configs/sama7_defconfig              |   2 +-
 arch/arm/configs/shmobile_defconfig           |   2 +-
 arch/arm/configs/socfpga_defconfig            |   2 +-
 arch/arm/configs/sp7021_defconfig             |  12 +-
 arch/arm/configs/spear13xx_defconfig          |   2 +-
 arch/arm/configs/spear3xx_defconfig           |   2 +-
 arch/arm/configs/spear6xx_defconfig           |   2 +-
 arch/arm/configs/spitz_defconfig              |   2 +-
 arch/arm/configs/stm32_defconfig              |   2 +-
 arch/arm/configs/sunxi_defconfig              |   2 +-
 arch/arm/configs/tegra_defconfig              |   2 +-
 arch/arm/configs/u8500_defconfig              |   4 +-
 arch/arm/configs/versatile_defconfig          |   2 +-
 arch/arm/configs/vexpress_defconfig           |   2 +-
 arch/arm/configs/vf610m4_defconfig            |  10 +-
 arch/arm/configs/vt8500_v6_v7_defconfig       |   2 +-
 arch/arm/configs/wpcm450_defconfig            |   2 +-
 arch/arm/include/uapi/asm/setup.h             |  10 -
 arch/arm/kernel/atags_compat.c                |  10 -
 arch/arm/kernel/atags_parse.c                 |  16 +-
 arch/arm/kernel/setup.c                       |   2 +-
 arch/arm/mm/init.c                            |  24 +-
 arch/arm64/configs/defconfig                  |   2 +-
 arch/arm64/kernel/setup.c                     |   2 +-
 arch/arm64/mm/init.c                          |  17 +-
 arch/csky/kernel/setup.c                      |  24 +-
 arch/csky/mm/init.c                           |   2 +-
 arch/hexagon/configs/comet_defconfig          |   2 +-
 arch/loongarch/configs/loongson3_defconfig    |   2 +-
 arch/loongarch/kernel/mem.c                   |   2 +-
 arch/loongarch/kernel/setup.c                 |   4 +-
 arch/m68k/configs/amiga_defconfig             |   2 +-
 arch/m68k/configs/apollo_defconfig            |   2 +-
 arch/m68k/configs/atari_defconfig             |   2 +-
 arch/m68k/configs/bvme6000_defconfig          |   2 +-
 arch/m68k/configs/hp300_defconfig             |   2 +-
 arch/m68k/configs/mac_defconfig               |   2 +-
 arch/m68k/configs/multi_defconfig             |   2 +-
 arch/m68k/configs/mvme147_defconfig           |   2 +-
 arch/m68k/configs/mvme16x_defconfig           |   2 +-
 arch/m68k/configs/q40_defconfig               |   2 +-
 arch/m68k/configs/stmark2_defconfig           |   2 +-
 arch/m68k/configs/sun3_defconfig              |   2 +-
 arch/m68k/configs/sun3x_defconfig             |   2 +-
 arch/m68k/kernel/setup_mm.c                   |  12 +-
 arch/m68k/kernel/setup_no.c                   |  12 +-
 arch/m68k/kernel/uboot.c                      |  17 +-
 arch/microblaze/kernel/cpu/mb.c               |   2 +-
 arch/microblaze/kernel/setup.c                |   2 +-
 arch/microblaze/mm/init.c                     |  12 +-
 arch/mips/ath79/prom.c                        |  12 +-
 arch/mips/configs/ath25_defconfig             |  12 +-
 arch/mips/configs/ath79_defconfig             |   4 +-
 arch/mips/configs/bcm47xx_defconfig           |   2 +-
 arch/mips/configs/bigsur_defconfig            |   2 +-
 arch/mips/configs/bmips_be_defconfig          |   2 +-
 arch/mips/configs/bmips_stb_defconfig         |  14 +-
 arch/mips/configs/cavium_octeon_defconfig     |   2 +-
 arch/mips/configs/eyeq5_defconfig             |   2 +-
 arch/mips/configs/eyeq6_defconfig             |   2 +-
 arch/mips/configs/generic_defconfig           |   2 +-
 arch/mips/configs/gpr_defconfig               |   2 +-
 arch/mips/configs/lemote2f_defconfig          |   2 +-
 arch/mips/configs/loongson2k_defconfig        |   2 +-
 arch/mips/configs/loongson3_defconfig         |   2 +-
 arch/mips/configs/malta_defconfig             |   2 +-
 arch/mips/configs/mtx1_defconfig              |   2 +-
 arch/mips/configs/rb532_defconfig             |   2 +-
 arch/mips/configs/rbtx49xx_defconfig          |   2 +-
 arch/mips/configs/rt305x_defconfig            |   4 +-
 arch/mips/configs/sb1250_swarm_defconfig      |   2 +-
 arch/mips/configs/xway_defconfig              |   4 +-
 arch/mips/kernel/setup.c                      |  53 ++-
 arch/mips/mm/init.c                           |   2 +-
 arch/mips/sibyte/common/cfe.c                 |  36 +-
 arch/mips/sibyte/swarm/setup.c                |   2 +-
 arch/nios2/kernel/setup.c                     |  20 +-
 arch/openrisc/configs/or1klitex_defconfig     |   2 +-
 arch/openrisc/configs/or1ksim_defconfig       |   4 +-
 arch/openrisc/configs/simple_smp_defconfig    |  14 +-
 arch/openrisc/configs/virt_defconfig          |   2 +-
 arch/openrisc/kernel/setup.c                  |  24 +-
 arch/openrisc/kernel/vmlinux.h                |   2 +-
 arch/parisc/boot/compressed/misc.c            |   2 +-
 arch/parisc/configs/generic-32bit_defconfig   |   2 +-
 arch/parisc/configs/generic-64bit_defconfig   |   2 +-
 arch/parisc/defpalo.conf                      |   2 +-
 arch/parisc/kernel/pdt.c                      |   6 +-
 arch/parisc/kernel/setup.c                    |   8 +-
 arch/parisc/mm/init.c                         |  32 +-
 arch/powerpc/configs/44x/akebono_defconfig    |   2 +-
 arch/powerpc/configs/44x/arches_defconfig     |   2 +-
 arch/powerpc/configs/44x/bamboo_defconfig     |   2 +-
 arch/powerpc/configs/44x/bluestone_defconfig  |   2 +-
 .../powerpc/configs/44x/canyonlands_defconfig |   2 +-
 arch/powerpc/configs/44x/ebony_defconfig      |   2 +-
 arch/powerpc/configs/44x/eiger_defconfig      |   2 +-
 arch/powerpc/configs/44x/fsp2_defconfig       |  10 +-
 arch/powerpc/configs/44x/icon_defconfig       |   2 +-
 arch/powerpc/configs/44x/iss476-smp_defconfig |   2 +-
 arch/powerpc/configs/44x/katmai_defconfig     |   2 +-
 arch/powerpc/configs/44x/rainier_defconfig    |   2 +-
 arch/powerpc/configs/44x/redwood_defconfig    |   2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig   |   2 +-
 arch/powerpc/configs/44x/sequoia_defconfig    |   2 +-
 arch/powerpc/configs/44x/taishan_defconfig    |   2 +-
 arch/powerpc/configs/44x/warp_defconfig       |   2 +-
 arch/powerpc/configs/52xx/cm5200_defconfig    |   2 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig |   2 +-
 arch/powerpc/configs/52xx/motionpro_defconfig |   2 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   2 +-
 arch/powerpc/configs/83xx/asp8347_defconfig   |   2 +-
 .../configs/83xx/mpc8313_rdb_defconfig        |   2 +-
 .../configs/83xx/mpc8315_rdb_defconfig        |   2 +-
 .../configs/83xx/mpc832x_rdb_defconfig        |   2 +-
 .../configs/83xx/mpc834x_itx_defconfig        |   2 +-
 .../configs/83xx/mpc834x_itxgp_defconfig      |   2 +-
 .../configs/83xx/mpc836x_rdk_defconfig        |   2 +-
 .../configs/83xx/mpc837x_rdb_defconfig        |   2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig  |   2 +-
 arch/powerpc/configs/85xx/ksi8560_defconfig   |   2 +-
 arch/powerpc/configs/85xx/socrates_defconfig  |   2 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig   |   2 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig   |   2 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig   |   2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig   |   2 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig   |   2 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig   |   2 +-
 .../configs/85xx/xes_mpc85xx_defconfig        |   2 +-
 arch/powerpc/configs/amigaone_defconfig       |   2 +-
 arch/powerpc/configs/cell_defconfig           |   2 +-
 arch/powerpc/configs/chrp32_defconfig         |   2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config     |   2 +-
 arch/powerpc/configs/g5_defconfig             |   2 +-
 arch/powerpc/configs/gamecube_defconfig       |   2 +-
 arch/powerpc/configs/holly_defconfig          |   2 +-
 arch/powerpc/configs/linkstation_defconfig    |   2 +-
 arch/powerpc/configs/mgcoge_defconfig         |   4 +-
 arch/powerpc/configs/microwatt_defconfig      |   2 +-
 arch/powerpc/configs/mpc512x_defconfig        |   2 +-
 arch/powerpc/configs/mpc5200_defconfig        |   2 +-
 arch/powerpc/configs/mpc83xx_defconfig        |   2 +-
 arch/powerpc/configs/pasemi_defconfig         |   2 +-
 arch/powerpc/configs/pmac32_defconfig         |   2 +-
 arch/powerpc/configs/powernv_defconfig        |   2 +-
 arch/powerpc/configs/ppc44x_defconfig         |   2 +-
 arch/powerpc/configs/ppc64_defconfig          |   2 +-
 arch/powerpc/configs/ppc64e_defconfig         |   2 +-
 arch/powerpc/configs/ppc6xx_defconfig         |   2 +-
 arch/powerpc/configs/ps3_defconfig            |   2 +-
 arch/powerpc/configs/skiroot_defconfig        |  12 +-
 arch/powerpc/configs/wii_defconfig            |   2 +-
 arch/powerpc/kernel/prom.c                    |  22 +-
 arch/powerpc/kernel/prom_init.c               |   6 +-
 arch/powerpc/kernel/setup-common.c            |  25 +-
 arch/powerpc/kernel/setup_32.c                |   2 +-
 arch/powerpc/kernel/setup_64.c                |   2 +-
 arch/powerpc/mm/init_32.c                     |   2 +-
 arch/powerpc/platforms/52xx/lite5200.c        |   2 +-
 arch/powerpc/platforms/83xx/km83xx.c          |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   2 +-
 arch/powerpc/platforms/chrp/setup.c           |   2 +-
 .../platforms/embedded6xx/linkstation.c       |   2 +-
 .../platforms/embedded6xx/storcenter.c        |   2 +-
 arch/powerpc/platforms/powermac/setup.c       |   8 +-
 arch/riscv/configs/defconfig                  |   2 +-
 arch/riscv/configs/nommu_k210_defconfig       |  16 +-
 arch/riscv/configs/nommu_virt_defconfig       |  12 +-
 arch/riscv/mm/init.c                          |   4 +-
 arch/s390/boot/ipl_parm.c                     |   2 +-
 arch/s390/boot/startup.c                      |   4 +-
 arch/s390/configs/zfcpdump_defconfig          |   2 +-
 arch/s390/kernel/setup.c                      |  10 +-
 arch/s390/mm/init.c                           |   2 +-
 arch/sh/configs/apsh4a3a_defconfig            |   2 +-
 arch/sh/configs/apsh4ad0a_defconfig           |   2 +-
 arch/sh/configs/ecovec24-romimage_defconfig   |   2 +-
 arch/sh/configs/edosk7760_defconfig           |   2 +-
 arch/sh/configs/kfr2r09-romimage_defconfig    |   2 +-
 arch/sh/configs/kfr2r09_defconfig             |   2 +-
 arch/sh/configs/magicpanelr2_defconfig        |   2 +-
 arch/sh/configs/migor_defconfig               |   2 +-
 arch/sh/configs/rsk7201_defconfig             |   2 +-
 arch/sh/configs/rsk7203_defconfig             |   2 +-
 arch/sh/configs/sdk7786_defconfig             |   8 +-
 arch/sh/configs/se7206_defconfig              |   2 +-
 arch/sh/configs/se7705_defconfig              |   2 +-
 arch/sh/configs/se7722_defconfig              |   2 +-
 arch/sh/configs/se7751_defconfig              |   2 +-
 arch/sh/configs/secureedge5410_defconfig      |   2 +-
 arch/sh/configs/sh03_defconfig                |   2 +-
 arch/sh/configs/sh7757lcr_defconfig           |   2 +-
 arch/sh/configs/titan_defconfig               |   2 +-
 arch/sh/configs/ul2_defconfig                 |   2 +-
 arch/sh/configs/urquell_defconfig             |   2 +-
 arch/sh/include/asm/setup.h                   |   1 -
 arch/sh/kernel/head_32.S                      |   2 +-
 arch/sh/kernel/setup.c                        |  27 +-
 arch/sparc/boot/piggyback.c                   |   4 +-
 arch/sparc/configs/sparc32_defconfig          |   2 +-
 arch/sparc/configs/sparc64_defconfig          |   2 +-
 arch/sparc/kernel/head_32.S                   |   4 +-
 arch/sparc/kernel/head_64.S                   |   6 +-
 arch/sparc/kernel/setup_32.c                  |   9 +-
 arch/sparc/kernel/setup_64.c                  |   9 +-
 arch/sparc/mm/init_32.c                       |  22 +-
 arch/sparc/mm/init_64.c                       |  20 +-
 arch/um/kernel/Makefile                       |   2 +-
 arch/um/kernel/initrd.c                       |   6 +-
 arch/x86/Kconfig                              |   2 +-
 arch/x86/boot/header.S                        |   2 +-
 arch/x86/boot/startup/sme.c                   |   2 +-
 arch/x86/configs/i386_defconfig               |   2 +-
 arch/x86/configs/x86_64_defconfig             |   2 +-
 arch/x86/include/uapi/asm/bootparam.h         |   7 +-
 arch/x86/kernel/cpu/microcode/amd.c           |   2 +-
 arch/x86/kernel/cpu/microcode/core.c          |  12 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   2 +-
 arch/x86/kernel/cpu/microcode/internal.h      |   2 +-
 arch/x86/kernel/devicetree.c                  |   2 +-
 arch/x86/kernel/setup.c                       |  39 +-
 arch/x86/mm/init.c                            |   8 +-
 arch/x86/mm/init_32.c                         |   2 +-
 arch/x86/mm/init_64.c                         |   2 +-
 arch/x86/tools/relocs.c                       |   2 +-
 arch/xtensa/Kconfig                           |   2 +-
 arch/xtensa/boot/dts/csp.dts                  |   2 +-
 arch/xtensa/configs/audio_kc705_defconfig     |   2 +-
 arch/xtensa/configs/cadence_csp_defconfig     |  12 +-
 arch/xtensa/configs/generic_kc705_defconfig   |   2 +-
 arch/xtensa/configs/nommu_kc705_defconfig     |  12 +-
 arch/xtensa/configs/smp_lx200_defconfig       |   2 +-
 arch/xtensa/configs/virt_defconfig            |   2 +-
 arch/xtensa/configs/xip_kc705_defconfig       |   2 +-
 arch/xtensa/kernel/setup.c                    |  26 +-
 drivers/acpi/Kconfig                          |   2 +-
 drivers/acpi/tables.c                         |  10 +-
 drivers/base/firmware_loader/main.c           |   2 +-
 drivers/block/Kconfig                         |   8 +-
 drivers/block/brd.c                           |  20 +-
 drivers/firmware/efi/efi.c                    |  10 +-
 .../firmware/efi/libstub/efi-stub-helper.c    |   5 +-
 drivers/gpu/drm/ci/arm.config                 |   2 +-
 drivers/gpu/drm/ci/arm64.config               |   2 +-
 drivers/gpu/drm/ci/x86_64.config              |   2 +-
 drivers/of/fdt.c                              |  18 +-
 fs/ext2/ext2.h                                |   9 -
 fs/init.c                                     |  14 -
 include/asm-generic/vmlinux.lds.h             |   8 +-
 include/linux/ext2_fs.h                       |  13 -
 include/linux/init_syscalls.h                 |   1 -
 include/linux/initramfs.h                     |  26 ++
 include/linux/initrd.h                        |  37 --
 include/linux/root_dev.h                      |   1 -
 include/linux/syscalls.h                      |   1 -
 include/uapi/linux/sysctl.h                   |   1 -
 init/.kunitconfig                             |   2 +-
 init/Kconfig                                  |  28 +-
 init/Makefile                                 |   6 +-
 init/do_mounts.c                              |  28 +-
 init/do_mounts.h                              |  42 --
 init/do_mounts_initrd.c                       | 154 -------
 init/do_mounts_rd.c                           | 334 ---------------
 init/initramfs.c                              | 152 ++++---
 init/main.c                                   |  66 +--
 kernel/sys.c                                  |   7 +-
 kernel/sysctl.c                               |   2 +-
 kernel/umh.c                                  |   2 +-
 scripts/package/builddeb                      |   2 +-
 .../ktest/examples/bootconfigs/tracing.bconf  |   3 -
 tools/testing/selftests/bpf/config.aarch64    |   2 +-
 tools/testing/selftests/bpf/config.ppc64el    |   2 +-
 tools/testing/selftests/bpf/config.riscv64    |   2 +-
 tools/testing/selftests/bpf/config.s390x      |   2 +-
 tools/testing/selftests/kho/vmtest.sh         |   2 +-
 .../testing/selftests/nolibc/Makefile.nolibc  |   4 +-
 tools/testing/selftests/vsock/config          |   2 +-
 .../selftests/wireguard/qemu/kernel.config    |   2 +-
 usr/Kconfig                                   |  70 ++--
 usr/Makefile                                  |   2 +-
 usr/initramfs_data.S                          |   4 +-
 385 files changed, 969 insertions(+), 2346 deletions(-)
 delete mode 100644 Documentation/admin-guide/initrd.rst
 delete mode 100644 Documentation/power/swsusp-dmcrypt.rst
 create mode 100644 include/linux/initramfs.h
 delete mode 100644 include/linux/initrd.h
 delete mode 100644 init/do_mounts_initrd.c
 delete mode 100644 init/do_mounts_rd.c


base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
-- 
2.47.2


