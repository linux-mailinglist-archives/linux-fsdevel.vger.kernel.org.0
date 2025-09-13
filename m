Return-Path: <linux-fsdevel+bounces-61165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87850B55B9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1316A1662DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386F405F7;
	Sat, 13 Sep 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc9cMIxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC61459F7
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724666; cv=none; b=P7AmP54V7q5iTcV39OFQ2rXjWvKBp+nNCVg2UAijM5Bv/MZGsvGgbXMr8NuFMFeyRt6O0m5rieSWEX3DiWEurXIuHb3vHXGHMTbG56Z6iKmpkSqRZDDC4NRcjRkUW01CRIu54BAX/bONP7NXp71Essb0GEr2hw4kZfhlwHBKxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724666; c=relaxed/simple;
	bh=tV4nt9hoLByV/HIUuc0gUBUSBu2CmEr56XA56LPl3Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+hd0xRvumLHWxX6NG3+QXWHYFj2trNkz/Jl4uwo/uI5vZsgU/za6WunoHry+v7DrauS7NX5enfeVbehHsyOsWZF0LBynKfGDVHcj+JFULV/3+HxrTPgIsdoBwD6jIdP/GZ7KsSsZ4jFksCq0FzotYNh8MLa/ujodq9lRQsSi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc9cMIxo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07e081d852so67467466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 17:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724657; x=1758329457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SN8Fbr3lsgOHKoe91M3D1QrN7Q3MG8ghhn6m4CViO8A=;
        b=nc9cMIxodtr024PS9gpC7tpeZlBso06vdVJ25wO2Rir+LHqPidCLq+YosKaG2TsLZ1
         /AGAytQr4+p0bZLkGuiSHv+wDI6sk5jMqOYC4a9ZcgnNLdJ/MIOMEUKT50eKb2EWvQ/Z
         CbOOxKKyDa/MpVfVsIh+bO1T9oyuAv/vUwlTtKt+pDHmX0r0JWeFZ1lKmddO3Yi8QHaT
         xzEtyist1h/ojXkIBuKxIBRA9McBgX9nSz51PyRswu76l4sW59IoVJUt+VOPeANGQExk
         bSejXdH99hx8AaZ7ToMGdb+tom3W1O+1GoIWzd1WGritLotCYM0NNK1IncpB/2DJ+btC
         cvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724657; x=1758329457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SN8Fbr3lsgOHKoe91M3D1QrN7Q3MG8ghhn6m4CViO8A=;
        b=YSjIsp7xpRjUo6uZlioKHKawhJxNzgCQ/gVqHxRSSXgK9mcWMyIHpDBFpo3RZMGGcG
         JO7BohhFM2xbadwu987uQ0Ro3E+4wIrV0xpfeboT/hRMO8nqKHMVvTaRLjv/fmhEGtUc
         7bBTUOXQNrm2jTJRXZwrvSQU8mr0Bjt9sPy7Nyu1uG/kDK869dSs2hcZxrC/3VVwi30a
         Gshiu0GJu7KNWwB3rzYnVqVW1a9CTTTBL595Y8hGr11Mljv0k7+WRwbr0wwP/7fjl9Wv
         ntCm3LpV1RJPU/n5Yu14XkiLpVucwZgErb5er6o3JzYxKNd4tcE28rOrbiAN0PXwGeca
         8qhA==
X-Gm-Message-State: AOJu0YzQ0TfhwCvfz1AiIlWf1QjzNuCG15bLuautEvpoRxFiqCNl8iCv
	IcziALtlmNKq6KR10KUBn8nOqgPuZdAOIY+8cn6quTkPKKumrep1AZDFKcgXYVmA
X-Gm-Gg: ASbGnctLhQ2e6VBtBRwWsv1J7Zyu53Zt17Eh9iDuj0zdqQcGf0UOs3hcL2jHg/tsrAQ
	bxiJ6nifu6SfUfvDD5NL1O8SWO+KXjkLi5QhXs0S+BjSm7yOO0z+oniahnSGU7tnjWJug8BFBu9
	zuMjCIHuAEPjAOITcoQt3pDjjj6QI2p43O53DzP4HRswdKfhYDE5ut06fhUUiWQgHJTNg5Muf+s
	azNBfJS0Nqc8hWkAiGJ/CblHCWaa2Nd1jU+aoX7pfLDoSjgmZs3swrO2EijUj1zDjC6vlp2i3XG
	7Ik3RMAgmTFbocNbTgRGnwHFF6/RwRqAKOlp89CD0YFFe5BPod9UTbJZK6hhI9cwHvnu3F5/TsJ
	bwdyDtUS6DCSEuE+WdFm779OPCZn0ig==
X-Google-Smtp-Source: AGHT+IGwBv9kpJ07X8t0d529bui6CA1o44YQPv7ZkxxgSRyUsVjcwLK5rfqrILP1RhklHdaMqIUraQ==
X-Received: by 2002:a17:907:7e9a:b0:afe:ea93:ddbb with SMTP id a640c23a62f3a-b07c38673ccmr474649366b.45.1757724657092;
        Fri, 12 Sep 2025 17:50:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c2d043desm299210066b.40.2025.09.12.17.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:50:56 -0700 (PDT)
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
Subject: [PATCH RESEND 10/62] initrd: remove initrd (initial RAM disk) support
Date: Sat, 13 Sep 2025 00:37:49 +0000
Message-ID: <20250913003842.41944-11-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initrd was deprecated in 2020.

Initramfs and (non-initial) RAM disks still work.

Both built-in and bootloader-supplied initramfs still work.

Also remove Documentation/admin-guide/initrd.rst . It contains
paragraph about initramfs, but initramfs already covered in
Documentation/filesystems/ramfs-rootfs-initramfs.rst

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/devices.txt         |   6 -
 Documentation/admin-guide/index.rst           |   1 -
 Documentation/admin-guide/initrd.rst          | 383 ------------------
 Documentation/admin-guide/nfs/nfsroot.rst     |   4 +-
 Documentation/power/swsusp-dmcrypt.rst        |   2 +-
 fs/init.c                                     |  14 -
 include/linux/init_syscalls.h                 |   1 -
 include/linux/initrd.h                        |   2 -
 init/Kconfig                                  |   2 +-
 init/Makefile                                 |   1 -
 init/do_mounts.c                              |   6 +-
 init/do_mounts.h                              |  22 -
 init/do_mounts_initrd.c                       |  83 ----
 init/do_mounts_rd.c                           | 318 ---------------
 init/initramfs.c                              |  31 +-
 .../ktest/examples/bootconfigs/tracing.bconf  |   3 -
 16 files changed, 6 insertions(+), 873 deletions(-)
 delete mode 100644 Documentation/admin-guide/initrd.rst
 delete mode 100644 init/do_mounts_rd.c

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 94c98be1329a..27835389ca49 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -21,12 +21,6 @@
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
 		    ...
-		250 = /dev/initrd	Initial RAM disk
-
-		Older kernels had /dev/ramdisk (1, 1) here.
-		/dev/initrd refers to a RAM disk which was preloaded
-		by the boot loader; newer kernels use /dev/ram0 for
-		the initrd.
 
    2 char	Pseudo-TTY masters
 		  0 = /dev/ptyp0	First PTY master
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb94..b3b2628ea515 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -51,7 +51,6 @@ Booting the kernel
    bootconfig
    kernel-parameters
    efi-stub
-   initrd
 
 
 Tracking down and identifying problems
diff --git a/Documentation/admin-guide/initrd.rst b/Documentation/admin-guide/initrd.rst
deleted file mode 100644
index 67bbad8806e8..000000000000
--- a/Documentation/admin-guide/initrd.rst
+++ /dev/null
@@ -1,383 +0,0 @@
-Using the initial RAM disk (initrd)
-===================================
-
-Written 1996,2000 by Werner Almesberger <werner.almesberger@epfl.ch> and
-Hans Lermen <lermen@fgan.de>
-
-
-initrd provides the capability to load a RAM disk by the boot loader.
-This RAM disk can then be mounted as the root file system and programs
-can be run from it. Afterwards, a new root file system can be mounted
-from a different device. The previous root (from initrd) is then moved
-to a directory and can be subsequently unmounted.
-
-initrd is mainly designed to allow system startup to occur in two phases,
-where the kernel comes up with a minimum set of compiled-in drivers, and
-where additional modules are loaded from initrd.
-
-This document gives a brief overview of the use of initrd. A more detailed
-discussion of the boot process can be found in [#f1]_.
-
-
-Operation
----------
-
-When using initrd, the system typically boots as follows:
-
-  1) the boot loader loads the kernel and the initial RAM disk
-  2) the kernel converts initrd into a "normal" RAM disk and
-     frees the memory used by initrd
-  3) if the root device is not ``/dev/ram0``, the old (deprecated)
-     change_root procedure is followed. see the "Obsolete root change
-     mechanism" section below.
-  4) root device is mounted. if it is ``/dev/ram0``, the initrd image is
-     then mounted as root
-  5) /sbin/init is executed (this can be any valid executable, including
-     shell scripts; it is run with uid 0 and can do basically everything
-     init can do).
-  6) init mounts the "real" root file system
-  7) init places the root file system at the root directory using the
-     pivot_root system call
-  8) init execs the ``/sbin/init`` on the new root filesystem, performing
-     the usual boot sequence
-  9) the initrd file system is removed
-
-Note that changing the root directory does not involve unmounting it.
-It is therefore possible to leave processes running on initrd during that
-procedure. Also note that file systems mounted under initrd continue to
-be accessible.
-
-
-Boot command-line options
--------------------------
-
-initrd adds the following new options::
-
-  initrd=<path>    (e.g. LOADLIN)
-
-    Loads the specified file as the initial RAM disk. When using LILO, you
-    have to specify the RAM disk image file in /etc/lilo.conf, using the
-    INITRD configuration variable.
-
-  noinitrd
-
-    initrd data is preserved but it is not converted to a RAM disk and
-    the "normal" root file system is mounted. initrd data can be read
-    from /dev/initrd. Note that the data in initrd can have any structure
-    in this case and doesn't necessarily have to be a file system image.
-    This option is used mainly for debugging.
-
-    Note: /dev/initrd is read-only and it can only be used once. As soon
-    as the last process has closed it, all data is freed and /dev/initrd
-    can't be opened anymore.
-
-  root=/dev/ram0
-
-    initrd is mounted as root, and the normal boot procedure is followed,
-    with the RAM disk mounted as root.
-
-Compressed cpio images
-----------------------
-
-Recent kernels have support for populating a ramdisk from a compressed cpio
-archive. On such systems, the creation of a ramdisk image doesn't need to
-involve special block devices or loopbacks; you merely create a directory on
-disk with the desired initrd content, cd to that directory, and run (as an
-example)::
-
-	find . | cpio --quiet -H newc -o | gzip -9 -n > /boot/imagefile.img
-
-Examining the contents of an existing image file is just as simple::
-
-	mkdir /tmp/imagefile
-	cd /tmp/imagefile
-	gzip -cd /boot/imagefile.img | cpio -imd --quiet
-
-Installation
-------------
-
-First, a directory for the initrd file system has to be created on the
-"normal" root file system, e.g.::
-
-	# mkdir /initrd
-
-The name is not relevant. More details can be found on the
-:manpage:`pivot_root(2)` man page.
-
-If the root file system is created during the boot procedure (i.e. if
-you're building an install floppy), the root file system creation
-procedure should create the ``/initrd`` directory.
-
-If initrd will not be mounted in some cases, its content is still
-accessible if the following device has been created::
-
-	# mknod /dev/initrd b 1 250
-	# chmod 400 /dev/initrd
-
-Second, the kernel has to be compiled with RAM disk support and with
-support for the initial RAM disk enabled. Also, at least all components
-needed to execute programs from initrd (e.g. executable format and file
-system) must be compiled into the kernel.
-
-Third, you have to create the RAM disk image. This is done by creating a
-file system on a block device, copying files to it as needed, and then
-copying the content of the block device to the initrd file. With recent
-kernels, at least three types of devices are suitable for that:
-
- - a floppy disk (works everywhere but it's painfully slow)
- - a RAM disk (fast, but allocates physical memory)
- - a loopback device (the most elegant solution)
-
-We'll describe the loopback device method:
-
- 1) make sure loopback block devices are configured into the kernel
- 2) create an empty file system of the appropriate size, e.g.::
-
-	# dd if=/dev/zero of=initrd bs=300k count=1
-	# mke2fs -F -m0 initrd
-
-    (if space is critical, you may want to use the Minix FS instead of Ext2)
- 3) mount the file system, e.g.::
-
-	# mount -t ext2 -o loop initrd /mnt
-
- 4) create the console device::
-
-    # mkdir /mnt/dev
-    # mknod /mnt/dev/console c 5 1
-
- 5) copy all the files that are needed to properly use the initrd
-    environment. Don't forget the most important file, ``/sbin/init``
-
-    .. note:: ``/sbin/init`` permissions must include "x" (execute).
-
- 6) correct operation the initrd environment can frequently be tested
-    even without rebooting with the command::
-
-	# chroot /mnt /sbin/init
-
-    This is of course limited to initrds that do not interfere with the
-    general system state (e.g. by reconfiguring network interfaces,
-    overwriting mounted devices, trying to start already running demons,
-    etc. Note however that it is usually possible to use pivot_root in
-    such a chroot'ed initrd environment.)
- 7) unmount the file system::
-
-	# umount /mnt
-
- 8) the initrd is now in the file "initrd". Optionally, it can now be
-    compressed::
-
-	# gzip -9 initrd
-
-For experimenting with initrd, you may want to take a rescue floppy and
-only add a symbolic link from ``/sbin/init`` to ``/bin/sh``. Alternatively, you
-can try the experimental newlib environment [#f2]_ to create a small
-initrd.
-
-Finally, you have to boot the kernel and load initrd. Almost all Linux
-boot loaders support initrd. Since the boot process is still compatible
-with an older mechanism, the following boot command line parameters
-have to be given::
-
-  root=/dev/ram0 rw
-
-(rw is only necessary if writing to the initrd file system.)
-
-With LOADLIN, you simply execute::
-
-     LOADLIN <kernel> initrd=<disk_image>
-
-e.g.::
-
-	LOADLIN C:\LINUX\BZIMAGE initrd=C:\LINUX\INITRD.GZ root=/dev/ram0 rw
-
-With LILO, you add the option ``INITRD=<path>`` to either the global section
-or to the section of the respective kernel in ``/etc/lilo.conf``, and pass
-the options using APPEND, e.g.::
-
-  image = /bzImage
-    initrd = /boot/initrd.gz
-    append = "root=/dev/ram0 rw"
-
-and run ``/sbin/lilo``
-
-For other boot loaders, please refer to the respective documentation.
-
-Now you can boot and enjoy using initrd.
-
-
-Changing the root device
-------------------------
-
-When finished with its duties, init typically changes the root device
-and proceeds with starting the Linux system on the "real" root device.
-
-The procedure involves the following steps:
- - mounting the new root file system
- - turning it into the root file system
- - removing all accesses to the old (initrd) root file system
- - unmounting the initrd file system and de-allocating the RAM disk
-
-Mounting the new root file system is easy: it just needs to be mounted on
-a directory under the current root. Example::
-
-	# mkdir /new-root
-	# mount -o ro /dev/hda1 /new-root
-
-The root change is accomplished with the pivot_root system call, which
-is also available via the ``pivot_root`` utility (see :manpage:`pivot_root(8)`
-man page; ``pivot_root`` is distributed with util-linux version 2.10h or higher
-[#f3]_). ``pivot_root`` moves the current root to a directory under the new
-root, and puts the new root at its place. The directory for the old root
-must exist before calling ``pivot_root``. Example::
-
-	# cd /new-root
-	# mkdir initrd
-	# pivot_root . initrd
-
-Now, the init process may still access the old root via its
-executable, shared libraries, standard input/output/error, and its
-current root directory. All these references are dropped by the
-following command::
-
-	# exec chroot . what-follows <dev/console >dev/console 2>&1
-
-Where what-follows is a program under the new root, e.g. ``/sbin/init``
-If the new root file system will be used with udev and has no valid
-``/dev`` directory, udev must be initialized before invoking chroot in order
-to provide ``/dev/console``.
-
-Note: implementation details of pivot_root may change with time. In order
-to ensure compatibility, the following points should be observed:
-
- - before calling pivot_root, the current directory of the invoking
-   process should point to the new root directory
- - use . as the first argument, and the _relative_ path of the directory
-   for the old root as the second argument
- - a chroot program must be available under the old and the new root
- - chroot to the new root afterwards
- - use relative paths for dev/console in the exec command
-
-Now, the initrd can be unmounted and the memory allocated by the RAM
-disk can be freed::
-
-	# umount /initrd
-	# blockdev --flushbufs /dev/ram0
-
-It is also possible to use initrd with an NFS-mounted root, see the
-:manpage:`pivot_root(8)` man page for details.
-
-
-Usage scenarios
----------------
-
-The main motivation for implementing initrd was to allow for modular
-kernel configuration at system installation. The procedure would work
-as follows:
-
-  1) system boots from floppy or other media with a minimal kernel
-     (e.g. support for RAM disks, initrd, a.out, and the Ext2 FS) and
-     loads initrd
-  2) ``/sbin/init`` determines what is needed to (1) mount the "real" root FS
-     (i.e. device type, device drivers, file system) and (2) the
-     distribution media (e.g. CD-ROM, network, tape, ...). This can be
-     done by asking the user, by auto-probing, or by using a hybrid
-     approach.
-  3) ``/sbin/init`` loads the necessary kernel modules
-  4) ``/sbin/init`` creates and populates the root file system (this doesn't
-     have to be a very usable system yet)
-  5) ``/sbin/init`` invokes ``pivot_root`` to change the root file system and
-     execs - via chroot - a program that continues the installation
-  6) the boot loader is installed
-  7) the boot loader is configured to load an initrd with the set of
-     modules that was used to bring up the system (e.g. ``/initrd`` can be
-     modified, then unmounted, and finally, the image is written from
-     ``/dev/ram0`` or ``/dev/rd/0`` to a file)
-  8) now the system is bootable and additional installation tasks can be
-     performed
-
-The key role of initrd here is to re-use the configuration data during
-normal system operation without requiring the use of a bloated "generic"
-kernel or re-compiling or re-linking the kernel.
-
-A second scenario is for installations where Linux runs on systems with
-different hardware configurations in a single administrative domain. In
-such cases, it is desirable to generate only a small set of kernels
-(ideally only one) and to keep the system-specific part of configuration
-information as small as possible. In this case, a common initrd could be
-generated with all the necessary modules. Then, only ``/sbin/init`` or a file
-read by it would have to be different.
-
-A third scenario is more convenient recovery disks, because information
-like the location of the root FS partition doesn't have to be provided at
-boot time, but the system loaded from initrd can invoke a user-friendly
-dialog and it can also perform some sanity checks (or even some form of
-auto-detection).
-
-Last not least, CD-ROM distributors may use it for better installation
-from CD, e.g. by using a boot floppy and bootstrapping a bigger RAM disk
-via initrd from CD; or by booting via a loader like ``LOADLIN`` or directly
-from the CD-ROM, and loading the RAM disk from CD without need of
-floppies.
-
-
-Obsolete root change mechanism
-------------------------------
-
-The following mechanism was used before the introduction of pivot_root.
-Current kernels still support it, but you should _not_ rely on its
-continued availability.
-
-It works by mounting the "real" root device (i.e. the one set with rdev
-in the kernel image or with root=... at the boot command line) as the
-root file system when linuxrc exits. The initrd file system is then
-unmounted, or, if it is still busy, moved to a directory ``/initrd``, if
-such a directory exists on the new root file system.
-
-In order to use this mechanism, you do not have to specify the boot
-command options root, init, or rw. (If specified, they will affect
-the real root file system, not the initrd environment.)
-
-If /proc is mounted, the "real" root device can be changed from within
-linuxrc by writing the number of the new root FS device to the special
-file /proc/sys/kernel/real-root-dev, e.g.::
-
-  # echo 0x301 >/proc/sys/kernel/real-root-dev
-
-Note that the mechanism is incompatible with NFS and similar file
-systems.
-
-This old, deprecated mechanism is commonly called ``change_root``, while
-the new, supported mechanism is called ``pivot_root``.
-
-
-Mixed change_root and pivot_root mechanism
-------------------------------------------
-
-In case you did not want to use ``root=/dev/ram0`` to trigger the pivot_root
-mechanism, you may create both ``/linuxrc`` and ``/sbin/init`` in your initrd
-image.
-
-``/linuxrc`` would contain only the following::
-
-	#! /bin/sh
-	mount -n -t proc proc /proc
-	echo 0x0100 >/proc/sys/kernel/real-root-dev
-	umount -n /proc
-
-Once linuxrc exited, the kernel would mount again your initrd as root,
-this time executing ``/sbin/init``. Again, it would be the duty of this init
-to build the right environment (maybe using the ``root= device`` passed on
-the cmdline) before the final execution of the real ``/sbin/init``.
-
-
-Resources
----------
-
-.. [#f1] Almesberger, Werner; "Booting Linux: The History and the Future"
-    https://www.almesberger.net/cv/papers/ols2k-9.ps.gz
-.. [#f2] newlib package (experimental), with initrd example
-    https://www.sourceware.org/newlib/
-.. [#f3] util-linux: Miscellaneous utilities for Linux
-    https://www.kernel.org/pub/linux/utils/util-linux/
diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 135218f33394..60452bdfd454 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -18,8 +18,8 @@ Mounting the root filesystem via NFS (nfsroot)
 In order to use a diskless system, such as an X-terminal or printer server for
 example, it is necessary for the root filesystem to be present on a non-disk
 device. This may be an initramfs (see
-Documentation/filesystems/ramfs-rootfs-initramfs.rst), a ramdisk (see
-Documentation/admin-guide/initrd.rst) or a filesystem mounted via NFS. The
+Documentation/filesystems/ramfs-rootfs-initramfs.rst)
+or a filesystem mounted via NFS. The
 following text describes on how to use NFS for the root filesystem. For the rest
 of this text 'client' means the diskless system, and 'server' means the NFS
 server.
diff --git a/Documentation/power/swsusp-dmcrypt.rst b/Documentation/power/swsusp-dmcrypt.rst
index 426df59172cd..afb29a58fdf8 100644
--- a/Documentation/power/swsusp-dmcrypt.rst
+++ b/Documentation/power/swsusp-dmcrypt.rst
@@ -10,7 +10,7 @@ Some prerequisites:
 You know how dm-crypt works. If not, visit the following web page:
 http://www.saout.de/misc/dm-crypt/
 You have read Documentation/power/swsusp.rst and understand it.
-You did read Documentation/admin-guide/initrd.rst and know how an initrd works.
+You did read Documentation/filesystems/ramfs-rootfs-initramfs.rst and know how an initrd works.
 You know how to create or how to modify an initrd.
 
 Now your system is properly set up, your disk is encrypted except for
diff --git a/fs/init.c b/fs/init.c
index eef5124885e3..dfa50474647c 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -27,20 +27,6 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	return ret;
 }
 
-int __init init_umount(const char *name, int flags)
-{
-	int lookup_flags = LOOKUP_MOUNTPOINT;
-	struct path path;
-	int ret;
-
-	if (!(flags & UMOUNT_NOFOLLOW))
-		lookup_flags |= LOOKUP_FOLLOW;
-	ret = kern_path(name, lookup_flags, &path);
-	if (ret)
-		return ret;
-	return path_umount(&path, flags);
-}
-
 int __init init_chdir(const char *filename)
 {
 	struct path path;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 92045d18cbfc..0bdbc458a881 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -2,7 +2,6 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
-int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index b42235c21444..cc389ef1a738 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,8 +3,6 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
-#define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
-
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
diff --git a/init/Kconfig b/init/Kconfig
index e3eb63eadc87..0263c08960bc 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1441,7 +1441,7 @@ config BLK_DEV_INITRD
 	  boot loader (loadlin or lilo) and that is mounted as root
 	  before the normal boot procedure. It is typically used to
 	  load modules needed to mount the "real" root file system,
-	  etc. See <file:Documentation/admin-guide/initrd.rst> for details.
+	  etc. See <file:Documentation/filesystems/ramfs-rootfs-initramfs.rst> for details.
 
 	  If RAM disk support (BLK_DEV_RAM) is also included, this
 	  also enables initial RAM disk (initrd) support and adds
diff --git a/init/Makefile b/init/Makefile
index d6f75d8907e0..b020154b3d2a 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -17,7 +17,6 @@ obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 obj-y                          += init_task.o
 
 mounts-y			:= do_mounts.o
-mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 
 #
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 0f2f44e6250c..f0b1a83dbda4 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -452,7 +452,7 @@ static dev_t __init parse_root_device(char *root_device_name)
 }
 
 /*
- * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
+ * Prepare the namespace - decide what/where to mount, etc.
  */
 void __init prepare_namespace(void)
 {
@@ -476,13 +476,9 @@ void __init prepare_namespace(void)
 	if (saved_root_name[0])
 		ROOT_DEV = parse_root_device(saved_root_name);
 
-	if (initrd_load(saved_root_name))
-		goto out;
-
 	if (root_wait)
 		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
-out:
 	devtmpfs_mount();
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	init_chroot(".");
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..6c7a535e71ce 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -22,28 +22,6 @@ static inline __init int create_dev(char *name, dev_t dev)
 	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
 }
 
-#ifdef CONFIG_BLK_DEV_RAM
-
-int __init rd_load_disk(int n);
-int __init rd_load_image(char *from);
-
-#else
-
-static inline int rd_load_disk(int n) { return 0; }
-static inline int rd_load_image(char *from) { return 0; }
-
-#endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-bool __init initrd_load(char *root_device_name);
-#else
-static inline bool initrd_load(char *root_device_name)
-{
-	return false;
-	}
-
-#endif
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index f6867bad0d78..308744254c08 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -69,86 +69,3 @@ static int __init early_initrd(char *p)
 	return early_initrdmem(p);
 }
 early_param("initrd", early_initrd);
-
-static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
-{
-	ksys_unshare(CLONE_FS | CLONE_FILES);
-	console_on_rootfs();
-	/* move initrd over / and chdir/chroot in initrd root */
-	init_chdir("/root");
-	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	init_chroot(".");
-	ksys_setsid();
-	return 0;
-}
-
-static void __init handle_initrd(char *root_device_name)
-{
-	struct subprocess_info *info;
-	static char *argv[] = { "linuxrc", NULL, };
-	extern char *envp_init[];
-	int error;
-
-	pr_warn("using deprecated initrd support, will be removed soon.\n");
-
-	real_root_dev = new_encode_dev(ROOT_DEV);
-	create_dev("/dev/root.old", Root_RAM0);
-	/* mount initrd on rootfs' /root */
-	mount_root_generic("/dev/root.old", root_device_name,
-			   root_mountflags & ~MS_RDONLY);
-	init_mkdir("/old", 0700);
-	init_chdir("/old");
-
-	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
-					 GFP_KERNEL, init_linuxrc, NULL, NULL);
-	if (!info)
-		return;
-	call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
-
-	/* move initrd to rootfs' /old */
-	init_mount("..", ".", NULL, MS_MOVE, NULL);
-	/* switch root and cwd back to / of rootfs */
-	init_chroot("..");
-
-	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-		init_chdir("/old");
-		return;
-	}
-
-	init_chdir("/");
-	ROOT_DEV = new_decode_dev(real_root_dev);
-	mount_root(root_device_name);
-
-	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
-	error = init_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
-	if (!error)
-		printk("okay\n");
-	else {
-		if (error == -ENOENT)
-			printk("/initrd does not exist. Ignored.\n");
-		else
-			printk("failed\n");
-		printk(KERN_NOTICE "Unmounting old root\n");
-		init_umount("/old", MNT_DETACH);
-	}
-}
-
-bool __init initrd_load(char *root_device_name)
-{
-	if (mount_initrd) {
-		create_dev("/dev/ram", Root_RAM0);
-		/*
-		 * Load the initrd data into /dev/ram0. Execute it as initrd
-		 * unless /dev/ram0 is supposed to be our actual root device,
-		 * in that case the ram disk is just set up here, and gets
-		 * mounted in the normal path.
-		 */
-		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			init_unlink("/initrd.image");
-			handle_initrd(root_device_name);
-			return true;
-		}
-	}
-	init_unlink("/initrd.image");
-	return false;
-}
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
deleted file mode 100644
index 864fa88d9f89..000000000000
--- a/init/do_mounts_rd.c
+++ /dev/null
@@ -1,318 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/kernel.h>
-#include <linux/fs.h>
-#include <linux/minix_fs.h>
-#include <linux/ext2_fs.h>
-#include <linux/romfs_fs.h>
-#include <uapi/linux/cramfs_fs.h>
-#include <linux/initrd.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-
-#include "do_mounts.h"
-#include "../fs/squashfs/squashfs_fs.h"
-
-#include <linux/decompress/generic.h>
-
-static struct file *in_file, *out_file;
-static loff_t in_pos, out_pos;
-
-static int __init crd_load(decompress_fn deco);
-
-/*
- * This routine tries to find a RAM disk image to load, and returns the
- * number of blocks to read for a non-compressed image, 0 if the image
- * is a compressed image, and -1 if an image with the right magic
- * numbers could not be found.
- *
- * We currently check for the following magic numbers:
- *	minix
- *	ext2
- *	romfs
- *	cramfs
- *	squashfs
- *	gzip
- *	bzip2
- *	lzma
- *	xz
- *	lzo
- *	lz4
- */
-static int __init
-identify_ramdisk_image(struct file *file, loff_t pos,
-		decompress_fn *decompressor)
-{
-	const int size = 512;
-	struct minix_super_block *minixsb;
-	struct romfs_super_block *romfsb;
-	struct cramfs_super *cramfsb;
-	struct squashfs_super_block *squashfsb;
-	int nblocks = -1;
-	unsigned char *buf;
-	const char *compress_name;
-	unsigned long n;
-	int start_block = 0;
-
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	minixsb = (struct minix_super_block *) buf;
-	romfsb = (struct romfs_super_block *) buf;
-	cramfsb = (struct cramfs_super *) buf;
-	squashfsb = (struct squashfs_super_block *) buf;
-	memset(buf, 0xe5, size);
-
-	/*
-	 * Read block 0 to test for compressed kernel
-	 */
-	pos = start_block * BLOCK_SIZE;
-	kernel_read(file, buf, size, &pos);
-
-	*decompressor = decompress_method(buf, size, &compress_name);
-	if (compress_name) {
-		printk(KERN_NOTICE "RAMDISK: %s image found at block %d\n",
-		       compress_name, start_block);
-		if (!*decompressor)
-			printk(KERN_EMERG
-			       "RAMDISK: %s decompressor not configured!\n",
-			       compress_name);
-		nblocks = 0;
-		goto done;
-	}
-
-	/* romfs is at block zero too */
-	if (romfsb->word0 == ROMSB_WORD0 &&
-	    romfsb->word1 == ROMSB_WORD1) {
-		printk(KERN_NOTICE
-		       "RAMDISK: romfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (ntohl(romfsb->size)+BLOCK_SIZE-1)>>BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/* squashfs is at block zero too */
-	if (le32_to_cpu(squashfsb->s_magic) == SQUASHFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: squashfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (le64_to_cpu(squashfsb->bytes_used) + BLOCK_SIZE - 1)
-			 >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/*
-	 * Read 512 bytes further to check if cramfs is padded
-	 */
-	pos = start_block * BLOCK_SIZE + 0x200;
-	kernel_read(file, buf, size, &pos);
-
-	if (cramfsb->magic == CRAMFS_MAGIC) {
-		printk(KERN_NOTICE
-		       "RAMDISK: cramfs filesystem found at block %d\n",
-		       start_block);
-		nblocks = (cramfsb->size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS;
-		goto done;
-	}
-
-	/*
-	 * Read block 1 to test for minix and ext2 superblock
-	 */
-	pos = (start_block + 1) * BLOCK_SIZE;
-	kernel_read(file, buf, size, &pos);
-
-	/* Try minix */
-	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
-	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
-		printk(KERN_NOTICE
-		       "RAMDISK: Minix filesystem found at block %d\n",
-		       start_block);
-		nblocks = minixsb->s_nzones << minixsb->s_log_zone_size;
-		goto done;
-	}
-
-	/* Try ext2 */
-	n = ext2_image_size(buf);
-	if (n) {
-		printk(KERN_NOTICE
-		       "RAMDISK: ext2 filesystem found at block %d\n",
-		       start_block);
-		nblocks = n;
-		goto done;
-	}
-
-	printk(KERN_NOTICE
-	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
-	       start_block);
-
-done:
-	kfree(buf);
-	return nblocks;
-}
-
-static unsigned long nr_blocks(struct file *file)
-{
-	struct inode *inode = file->f_mapping->host;
-
-	if (!S_ISBLK(inode->i_mode))
-		return 0;
-	return i_size_read(inode) >> 10;
-}
-
-int __init rd_load_image(char *from)
-{
-	int res = 0;
-	unsigned long rd_blocks, devblocks;
-	int nblocks, i;
-	char *buf = NULL;
-	unsigned short rotate = 0;
-	decompress_fn decompressor = NULL;
-#if !defined(CONFIG_S390)
-	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
-
-	out_file = filp_open("/dev/ram", O_RDWR, 0);
-	if (IS_ERR(out_file))
-		goto out;
-
-	in_file = filp_open(from, O_RDONLY, 0);
-	if (IS_ERR(in_file))
-		goto noclose_input;
-
-	in_pos = 0;
-	nblocks = identify_ramdisk_image(in_file, in_pos, &decompressor);
-	if (nblocks < 0)
-		goto done;
-
-	if (nblocks == 0) {
-		if (crd_load(decompressor) == 0)
-			goto successful_load;
-		goto done;
-	}
-
-	/*
-	 * NOTE NOTE: nblocks is not actually blocks but
-	 * the number of kibibytes of data to load into a ramdisk.
-	 */
-	rd_blocks = nr_blocks(out_file);
-	if (nblocks > rd_blocks) {
-		printk("RAMDISK: image too big! (%dKiB/%ldKiB)\n",
-		       nblocks, rd_blocks);
-		goto done;
-	}
-
-	/*
-	 * OK, time to copy in the data
-	 */
-	if (strcmp(from, "/initrd.image") == 0)
-		devblocks = nblocks;
-	else
-		devblocks = nr_blocks(in_file);
-
-	if (devblocks == 0) {
-		printk(KERN_ERR "RAMDISK: could not determine device size\n");
-		goto done;
-	}
-
-	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
-	if (!buf) {
-		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
-		goto done;
-	}
-
-	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
-		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
-	for (i = 0; i < nblocks; i++) {
-		if (i && (i % devblocks == 0)) {
-			pr_cont("done disk #1.\n");
-			rotate = 0;
-			fput(in_file);
-			break;
-		}
-		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
-		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
-#if !defined(CONFIG_S390)
-		if (!(i % 16)) {
-			pr_cont("%c\b", rotator[rotate & 0x3]);
-			rotate++;
-		}
-#endif
-	}
-	pr_cont("done.\n");
-
-successful_load:
-	res = 1;
-done:
-	fput(in_file);
-noclose_input:
-	fput(out_file);
-out:
-	kfree(buf);
-	init_unlink("/dev/ram");
-	return res;
-}
-
-int __init rd_load_disk(int n)
-{
-	create_dev("/dev/root", ROOT_DEV);
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
-	return rd_load_image("/dev/root");
-}
-
-static int exit_code;
-static int decompress_error;
-
-static long __init compr_fill(void *buf, unsigned long len)
-{
-	long r = kernel_read(in_file, buf, len, &in_pos);
-	if (r < 0)
-		printk(KERN_ERR "RAMDISK: error while reading compressed data");
-	else if (r == 0)
-		printk(KERN_ERR "RAMDISK: EOF while reading compressed data");
-	return r;
-}
-
-static long __init compr_flush(void *window, unsigned long outcnt)
-{
-	long written = kernel_write(out_file, window, outcnt, &out_pos);
-	if (written != outcnt) {
-		if (decompress_error == 0)
-			printk(KERN_ERR
-			       "RAMDISK: incomplete write (%ld != %ld)\n",
-			       written, outcnt);
-		decompress_error = 1;
-		return -1;
-	}
-	return outcnt;
-}
-
-static void __init error(char *x)
-{
-	printk(KERN_ERR "%s\n", x);
-	exit_code = 1;
-	decompress_error = 1;
-}
-
-static int __init crd_load(decompress_fn deco)
-{
-	int result;
-
-	if (!deco) {
-		pr_emerg("Invalid ramdisk decompression routine.  "
-			 "Select appropriate config option.\n");
-		panic("Could not decompress initial ramdisk image.");
-	}
-
-	result = deco(NULL, 0, compr_fill, compr_flush, NULL, NULL, error);
-	if (decompress_error)
-		result = 1;
-	return result;
-}
diff --git a/init/initramfs.c b/init/initramfs.c
index 097673b97784..850cb0de873e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -692,28 +692,6 @@ static inline bool kexec_free_initrd(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-#ifdef CONFIG_BLK_DEV_RAM
-static void __init populate_initrd_image(char *err)
-{
-	ssize_t written;
-	struct file *file;
-	loff_t pos = 0;
-
-	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
-			err);
-	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
-	if (IS_ERR(file))
-		return;
-
-	written = xwrite(file, (char *)initrd_start, initrd_end - initrd_start,
-			&pos);
-	if (written != initrd_end - initrd_start)
-		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-		       written, initrd_end - initrd_start);
-	fput(file);
-}
-#endif /* CONFIG_BLK_DEV_RAM */
-
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
@@ -724,18 +702,11 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
 		goto done;
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
-		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
-	else
-		printk(KERN_INFO "Unpacking initramfs...\n");
+	printk(KERN_INFO "Unpacking initramfs...\n");
 
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
-#ifdef CONFIG_BLK_DEV_RAM
-		populate_initrd_image(err);
-#else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-#endif
 	}
 
 done:
diff --git a/tools/testing/ktest/examples/bootconfigs/tracing.bconf b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
index bf117c78115a..c81ee5e30d2d 100644
--- a/tools/testing/ktest/examples/bootconfigs/tracing.bconf
+++ b/tools/testing/ktest/examples/bootconfigs/tracing.bconf
@@ -16,9 +16,6 @@ ftrace {
 			myevent2 {
 				probes = "vfs_write $arg2 +0($arg2):ustring $arg3";
 			}
-			myevent3 {
-				probes = "initrd_load";
-			}
 			enable
 		}
 	}
-- 
2.47.2


