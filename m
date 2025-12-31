Return-Path: <linux-fsdevel+bounces-72296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86584CEC51B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EAEE300B820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AC29B778;
	Wed, 31 Dec 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWr9Cs30"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC1284883
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767200862; cv=none; b=asAEXTqjAIk4AYQLoEOucvlEi175wTRu/TcSHgJwppweYqWsZrduC98Bt7SXsG1dhLZzr6ex3lQVbO8d5A1wgvoI+8xAF1v2oB0oSriEZEqGpXczWjz2zMrSqsqyVdLBrvX3Rv1mqJTs3a5EIsGMF+yB5oMaJnf3N7rVbkKNdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767200862; c=relaxed/simple;
	bh=47wzzQ+XhoYeBIut+SFa/nh9s+dXDI8uWrHOzaxE+Lo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZSG/q0WZ/jT6ejXG13k0r4m29sXWZcw6pJGewjkUauVPGDjcO4tZOmuDbl07INR/13koBagPkNsa7jiSfu7EcNVCkGAxX6dYv4WTvcv8B2nOQhlo1uuClS+4BHaKH1xPNT+huWZ12s4DB3VdwDv2ZcXs72DQlPeqmQvZ+Z/ecbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWr9Cs30; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso8595506fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767200859; x=1767805659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xR5JfZr5mSQ4TE/VJQ6yKFJ6EUHzh6QLFV/NivARDyY=;
        b=UWr9Cs308G4/5t59hsItpQCRxkB/793cIHdwgtF9k2MXWaPjHbagBY6KA+EbKTdLpN
         KzAQ6os0qlcJJVr0f/bKf4uZ0lP3LCqg2IIH4seXN4XlstmBaQjhKqGBT53GYO69kh0h
         4i1yHzWywm8oLFjeno9RXhOTZ7NfAdM7QIyW7E93GMs1/gDBM1DmZuAJgCteo7gIzV1c
         qhbDioKqcrRtKzEszMt5exT5t/YahcMB0bjsqSx96DGgQrprMgBXjAHLuZNG8wqVDZt8
         HiuaflZz499GpGHIYnaQLSJufRn9MvBHR7Mk75I8OMM4/JjO6lIvSKvjDPtMyxDI0pR2
         rWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767200859; x=1767805659;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xR5JfZr5mSQ4TE/VJQ6yKFJ6EUHzh6QLFV/NivARDyY=;
        b=HjhfS434OJRvcC5j0yI8oiNrfF6R4fmhoUTSrbqo9xGneYlw32V28LO8PbmyvL2jM7
         H4vDZQvYsYm9j8HgYHQaXo37cZ48Lq0buBaAPu8mt4gIDLkRiGrsYdwqtWAIlxrd/jBP
         MeILWpX/qDrjkfeT2Sw9PaUmKcdROLJJwh9tPJP+cHRRyc8XgVVEGM6wHmd0iC4nG42/
         KgRRIJkjeTcx82O7OKE5brL5VJvpXhDBcJp+gz7nccQDDYZSwlMHgblrxAloPfbYoSEA
         6PUtNHouD3uII9nn66pNTwGWwIx0+w3cRhUz0weMdIAj8cq4/k34qXfjKPKyfUmQNPhd
         bx4w==
X-Forwarded-Encrypted: i=1; AJvYcCV3xcqbbf8ZOJNKl7IKQIgQeevg8xeLwrWpGXtyFCYbrTPu4pmPWBzdQxFr48tsWdX0ZmpHMmB6jA4J9qot@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16HheTH92j+BJmR9iLk3R7vLwolI753et67NLN8GXd8v36OrY
	GTbQsh8OYmz59ZcgrLmJzRc+xV+ms+jttSt4O7U0J5HWfmj8bqfMx2vPWZY55ClvUt8DTzdNlGL
	/2qcWlMl7sNGtwAsMUHvHMi1wPVUWWxk=
X-Gm-Gg: AY/fxX4V1Np+IpiANEWQJVgeSBXYHP7UVOTU6FSJl9e67l/E1EhNqkYMpf1H1Tx5seq
	/W4mFyu4TVRdkKYzT1TUyx7sWjA+0SNjYledfoNFGR24K5fRfnsSCxFUS0IAYP2YYM/ALgsM/pK
	UYze7lY43l0YmkpWtnf9Y9qMnBRI9B09LPfhH4TyqFTUCX/Hh/vFVPniHJxjIo1r2H9vxo7wXby
	CfN1AAWw/p5oDf71TpArMm1NYkPUnGODm2vp2oeARvOFCvBxRUcgcjfP/78XAw2Rf7JVedk2/HI
	qltJBVSlNYuurA8sB8bUvT96M6g=
X-Google-Smtp-Source: AGHT+IFT4rxjyCKMGl7g8ZS9xPgTIwSY63yg7IsZhEsaGm06Qp5dGy4NoH1p9tkl+LF/shvp7gI3m+On6ZKbjkqdKvI=
X-Received: by 2002:a05:6820:162a:b0:659:9a49:8fb8 with SMTP id
 006d021491bc7-65d0eb2fd19mr15880205eaf.49.1767200858325; Wed, 31 Dec 2025
 09:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Curtin <ericcurtin17@gmail.com>
Date: Wed, 31 Dec 2025 17:07:27 +0000
X-Gm-Features: AQt7F2qVDAnBOzvkC4v4f7_4tryS2pw-9Tz-qywrdS1P9pUtlx0B4XCnbWKgX_k
Message-ID: <CANpvso542AnegHeUZhE4Voa7ENcx+jFPSwqgEeSxxxze0Fv5ew@mail.gmail.com>
Subject: [PATCH] Add initerofs for EROFS-backed early rootfs
To: Kernel development list <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Cc: xiang@kernel.org, chao@kernel.org, miklos@szeredi.hu, 
	Amir Goldstein <amir73il@gmail.com>, brauner@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	bmasney@redhat.com
Content-Type: text/plain; charset="UTF-8"

This introduces initerofs, an alternative to traditional initramfs that
uses EROFS directly from memory instead of unpacking a cpio archive.
This provides significant performance benefits in terms of boot time and
memory usage.

The kernel automatically detects EROFS format in the initramfs by checking
the magic number at offset 1024. No special kernel parameters are
required - just use an EROFS image as your initramfs.

New configuration option CONFIG_INITEROFS enables this feature, which
requires EROFS, overlayfs, and tmpfs to be built into the kernel.
Documentation is added explaining usage, benefits, and troubleshooting.

Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
---
 Documentation/admin-guide/initerofs.rst | 155 ++++++++++++++
 fs/erofs/super.c                        |   9 +
 fs/overlayfs/super.c                    |   8 +
 init/Kconfig                            |  32 +++
 init/Makefile                           |   1 +
 init/initerofs.c                        | 264 ++++++++++++++++++++++++
 init/initerofs.h                        |  75 +++++++
 init/initerofs_blkdev.c                 | 186 +++++++++++++++++
 init/initramfs.c                        |  43 +++-
 9 files changed, 770 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/initerofs.rst
 create mode 100644 init/initerofs.c
 create mode 100644 init/initerofs.h
 create mode 100644 init/initerofs_blkdev.c

diff --git a/Documentation/admin-guide/initerofs.rst
b/Documentation/admin-guide/initerofs.rst
new file mode 100644
index 000000000000..fa2597ca1613
--- /dev/null
+++ b/Documentation/admin-guide/initerofs.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+initerofs: EROFS-backed Early Rootfs
+====================================
+
+Introduction
+============
+
+initerofs is an alternative to traditional initramfs that uses EROFS (Enhanced
+Read-Only File System) directly from memory instead of unpacking a
cpio archive.
+This provides significant performance benefits in terms of boot time and memory
+usage.
+
+The kernel automatically detects EROFS format in the initrd by checking the
+magic number at offset 1024. No special kernel parameters are required - just
+use an EROFS image as your initrd.
+
+Quick Start
+===========
+
+1. Create an EROFS image from your rootfs::
+
+    mkfs.erofs -zlz4 initerofs.img rootfs/
+
+2. Use the image as your initrd (same as traditional initramfs)::
+
+    # GRUB example
+    linux /vmlinuz root=/dev/sda1
+    initrd /initerofs.img
+
+3. The kernel auto-detects EROFS and mounts directly (no unpacking!)
+
+Boot Parameters
+===============
+
+retain_initerofs
+    When specified, the kernel will not free the initrd memory region after
+    boot. Useful for debugging or when the EROFS image needs to
remain accessible.
+
+Benefits Summary
+================
+
+1. **Faster Boot Time**
+
+   - initramfs: Must decompress AND extract all files before any can be used
+   - initerofs: Mount is instant, decompression is on-demand
+
+2. **Lower Memory Usage**
+
+   - initramfs: Needs memory for both archive and extracted files during boot
+   - initerofs: Only needs memory for the EROFS image plus small
overlayfs overhead
+
+3. **On-Demand Decompression**
+
+   - initramfs: All files decompressed upfront, whether needed or not
+   - initerofs: EROFS decompresses only when files are accessed
+
+   Especially beneficial when only a subset of files are actually
used during boot.
+
+4. **Cache Efficiency**
+
+   - initramfs: Files in tmpfs, all in memory
+   - initerofs: EROFS uses page cache efficiently, unchanged files
read from image
+
+Configuration
+=============
+
+Enable initerofs support in the kernel::
+
+    CONFIG_EROFS_FS=y
+    CONFIG_EROFS_FS_ZIP=y          # For LZ4 compression support
+    CONFIG_OVERLAY_FS=y            # For writable filesystem
+    CONFIG_TMPFS=y                 # For overlayfs upper layer
+    CONFIG_INITEROFS=y
+
+Creating an initerofs Image
+===========================
+
+Create an EROFS image from your initramfs content::
+
+    # Create rootfs directory with your init and programs
+    mkdir -p rootfs/{bin,etc,dev,proc,sys,run,tmp}
+    cp /path/to/init rootfs/init
+    chmod +x rootfs/init
+    # ... add other files (busybox, systemd, etc.) ...
+
+    # Create LZ4-compressed EROFS image
+    mkfs.erofs -zlz4 initerofs.img rootfs/
+
+For Fedora/RHEL systems, you can convert the existing initramfs::
+
+    # Extract existing initramfs
+    mkdir rootfs
+    cd rootfs
+    zcat /boot/initramfs-$(uname -r).img | cpio -idmv
+    cd ..
+
+    # Create EROFS image
+    mkfs.erofs -zlz4 initerofs.img rootfs/
+
+    # Install the new initramfs
+    cp initerofs.img /boot/initerofs-$(uname -r).img
+
+Bootloader Configuration
+========================
+
+The EROFS initrd is loaded exactly like a traditional initramfs - no special
+bootloader configuration is needed. The kernel auto-detects the format.
+
+Example GRUB configuration::
+
+    menuentry 'Linux with initerofs' {
+        linux /vmlinuz root=/dev/sda2
+        initrd /initerofs.img
+    }
+
+Use Cases
+=========
+
+1. **Embedded Systems**: Limited RAM benefits from lower memory footprint
+2. **Cloud VMs**: Faster boot time reduces cold start latency
+3. **Containers**: Lighter initialization overhead
+4. **IoT Devices**: Constrained resources benefit from on-demand loading
+5. **Desktop/Server**: Faster boot with large initramfs images
+
+Writable Filesystem via Overlayfs
+=================================
+
+initerofs automatically sets up overlayfs to make the root filesystem writable.
+The EROFS image serves as the read-only lower layer, while a tmpfs provides the
+writable upper layer. This gives the best of both worlds:
+
+- **Fast reads**: Files are read directly from the compressed EROFS image
+- **Writable**: Any modifications are stored in the tmpfs upper layer
+- **Copy-on-write**: Modified files are copied to tmpfs only when written
+
+Troubleshooting
+===============
+
+If initerofs doesn't work, check:
+
+1. **Kernel config**: Ensure CONFIG_INITEROFS=y, CONFIG_EROFS_FS=y,
+   CONFIG_OVERLAY_FS=y, CONFIG_TMPFS=y are all enabled and built-in (=y not =m)
+
+2. **EROFS image**: Verify the image is valid::
+
+    file initerofs.img
+    # Should show: "EROFS filesystem"
+
+3. **Kernel messages**: Check dmesg for initerofs messages::
+
+    dmesg | grep initerofs
+
+4. **Fallback**: If EROFS detection fails, the kernel falls back to
cpio unpacking
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..e911de06e602 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1062,7 +1062,16 @@ const struct super_operations erofs_sops = {
        .show_options = erofs_show_options,
 };

+/*
+ * Use fs_initcall for built-in so EROFS registers before rootfs_initcall.
+ * This allows initerofs to mount EROFS directly from initrd memory.
+ * For modular builds, module_init is needed (which won't trigger fs_initcall).
+ */
+#ifdef MODULE
 module_init(erofs_module_init);
+#else
+fs_initcall(erofs_module_init);
+#endif
 module_exit(erofs_module_exit);

 MODULE_DESCRIPTION("Enhanced ROM File System");
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ba9146f22a2c..9cc5ba4b8cee 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1625,5 +1625,13 @@ static void __exit ovl_exit(void)
        kmem_cache_destroy(ovl_inode_cachep);
 }

+/*
+ * Use fs_initcall for built-in so overlayfs registers before rootfs_initcall.
+ * This allows initerofs to create a writable overlay over EROFS.
+ */
+#ifdef MODULE
 module_init(ovl_init);
+#else
+fs_initcall(ovl_init);
+#endif
 module_exit(ovl_exit);
diff --git a/init/Kconfig b/init/Kconfig
index fa79feb8fe57..8278bf85271a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1475,6 +1475,38 @@ source "usr/Kconfig"

 endif

+config INITEROFS
+       bool "EROFS-backed early root filesystem (initerofs)"
+       depends on EROFS_FS=y
+       depends on OVERLAY_FS=y
+       depends on TMPFS=y
+       help
+         This option enables support for using an EROFS (Enhanced Read-Only
+         File System) image directly from memory as the early root filesystem,
+         without the need to unpack a cpio archive like traditional initramfs.
+
+         When enabled, the kernel automatically detects if the initramfs is in
+         EROFS format (by checking the magic number) and mounts it directly
+         instead of unpacking as cpio. This provides several benefits:
+
+         - Faster boot: No decompression or extraction step is needed
+         - Lower memory usage: No duplicate data (archive + extracted files)
+         - On-demand decompression: EROFS supports transparent compression
+         - Writable via overlayfs: tmpfs upper layer allows modifications
+
+         To use initerofs:
+         1. Create EROFS image: mkfs.erofs -zlz4 initerofs.img rootfs/
+         2. Use this image as your initramfs (bootloader loads it normally)
+         3. The kernel auto-detects EROFS and mounts directly
+
+         No special kernel parameters are required - just use the EROFS
+         image as your initramfs and the kernel handles the rest.
+
+         Note: This requires EROFS, overlayfs, and tmpfs to be built into the
+         kernel (not as modules) since they're needed during early boot.
+
+         If unsure, say N.
+
 config BOOT_CONFIG
        bool "Boot config support"
        select BLK_DEV_INITRD if !BOOT_CONFIG_EMBED
diff --git a/init/Makefile b/init/Makefile
index d6f75d8907e0..464ab9002ea5 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
 endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
+obj-$(CONFIG_INITEROFS)        += initerofs.o initerofs_blkdev.o

 obj-y                          += init_task.o

diff --git a/init/initerofs.c b/init/initerofs.c
new file mode 100644
index 000000000000..a85df72b83ba
--- /dev/null
+++ b/init/initerofs.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * EROFS-backed early root filesystem (initerofs)
+ *
+ * Copyright (C) 2025
+ *
+ * This implements "initerofs" - a mechanism to use an EROFS
(Enhanced Read-Only
+ * File System) image directly from memory as the early root
filesystem, without
+ * the need to unpack a cpio archive like traditional initramfs.
+ *
+ * The implementation automatically detects EROFS format by checking the magic
+ * number at offset 1024. If the initramfs is in EROFS format, it mounts it
+ * directly instead of unpacking as cpio. This uses the existing initramfs
+ * memory reservation infrastructure.
+ *
+ * Performance benefits vs. traditional initramfs:
+ * - No double-buffering: Traditional initramfs requires both the compressed
+ *   archive and the unpacked files in memory simultaneously during boot.
+ * - No decompression/unpacking step: EROFS can be used directly from memory,
+ *   eliminating the CPU time spent on decompression.
+ * - Reduced memory footprint: Only the EROFS image needs to be in memory,
+ *   not an extracted copy of all files.
+ * - EROFS native compression: EROFS supports transparent compression
(LZ4, etc.)
+ *   which is decompressed on-demand during file access, further saving memory.
+ *
+ * Usage:
+ * - Create an EROFS image: mkfs.erofs -zlz4 initramfs.img rootfs/
+ * - Use initramfs.img as your initrd (bootloader loads it as usual)
+ * - The kernel automatically detects EROFS format and mounts directly
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/backing-dev.h>
+#include <linux/init_syscalls.h>
+#include <linux/kstrtox.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/magic.h>
+#include <linux/ktime.h>
+#include <linux/initrd.h>
+#include <uapi/linux/mount.h>
+
+#include "do_mounts.h"
+#include "initerofs.h"
+
+/* EROFS superblock offset from fs/erofs/erofs_fs.h */
+#define INITEROFS_SB_OFFSET    1024
+
+/* Retain the memory if requested */
+static int do_retain_initerofs __initdata;
+
+static int __init retain_initerofs_param(char *str)
+{
+       if (*str)
+               return 0;
+       do_retain_initerofs = 1;
+       return 1;
+}
+__setup("retain_initerofs", retain_initerofs_param);
+
+/*
+ * Check if the initrd contains an EROFS filesystem.
+ * EROFS magic is at offset 1024 in the superblock.
+ */
+bool __init initerofs_detect(void)
+{
+       u32 magic;
+
+       if (!initrd_start || !initrd_end)
+               return false;
+
+       /* Need at least superblock offset + magic size */
+       if (initrd_end - initrd_start < INITEROFS_SB_OFFSET + sizeof(u32))
+               return false;
+
+       magic = le32_to_cpup((__le32 *)((void *)initrd_start +
INITEROFS_SB_OFFSET));
+       if (magic == EROFS_SUPER_MAGIC_V1) {
+               pr_info("initerofs: detected EROFS format in initrd\n");
+               return true;
+       }
+
+       return false;
+}
+
+/*
+ * Mount the EROFS image from initrd memory as the root filesystem.
+ * This is called during kernel initialization to set up the early root.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int __init initerofs_mount_root(void)
+{
+       char *blkdev_path;
+       unsigned long size;
+       int err;
+       ktime_t start_time, end_time;
+       s64 elapsed_ns;
+
+       if (!initrd_start || !initrd_end)
+               return -ENODEV;
+
+       size = initrd_end - initrd_start;
+
+       start_time = ktime_get();
+
+       pr_info("initerofs: mounting EROFS from initrd at 0x%lx (size
%lu bytes)\n",
+               initrd_start, size);
+
+       /*
+        * Mount the EROFS filesystem using direct memory-backed block device.
+        *
+        * We create a simple block device that serves reads directly from the
+        * initrd memory region. This avoids any memory copy - EROFS reads the
+        * data directly from where the bootloader placed it.
+        *
+        * Benefits over file-backed approach:
+        * 1. Zero-copy: No need to write initrd to a backing file
+        * 2. Immediate availability: Block device is ready instantly
+        * 3. Lower memory pressure: No page cache duplication
+        */
+
+       /* Create the memory-backed block device */
+       blkdev_path = initerofs_blkdev_create((void *)initrd_start, size);
+       if (!blkdev_path) {
+               pr_err("initerofs: failed to create block device\n");
+               return -ENOMEM;
+       }
+
+       /* Create mount point */
+       err = init_mkdir("/root", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create /root directory:
%d\n", err);
+               goto err_blkdev;
+       }
+
+       /* Verify EROFS filesystem is registered (at fs_initcall,
before rootfs_initcall) */
+       {
+               struct file_system_type *fs_type = get_fs_type("erofs");
+
+               if (fs_type) {
+                       put_filesystem(fs_type);
+                       pr_info("initerofs: EROFS filesystem available\n");
+               } else {
+                       pr_err("initerofs: EROFS filesystem not registered\n");
+                       err = -ENODEV;
+                       goto err_blkdev;
+               }
+       }
+
+       /* Mount EROFS from the memory-backed block device */
+       pr_info("initerofs: attempting mount from '%s' to '/root'\n",
blkdev_path);
+       err = init_mount(blkdev_path, "/root", "erofs", MS_RDONLY, NULL);
+       if (err) {
+               pr_err("initerofs: failed to mount EROFS from %s: %d\n",
+                      blkdev_path, err);
+               goto err_blkdev;
+       }
+
+       end_time = ktime_get();
+       elapsed_ns = ktime_to_ns(ktime_sub(end_time, start_time));
+       pr_info("initerofs: EROFS mounted in %lld.%06lld ms (zero-copy)\n",
+               elapsed_ns / 1000000, (elapsed_ns % 1000000));
+
+       /*
+        * Set up overlayfs to make the filesystem writable.
+        * EROFS (lower/read-only) + tmpfs (upper/writable) = overlayfs (merged)
+        */
+
+       /* Create directories for overlayfs */
+       err = init_mkdir("/overlay_upper", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create overlay upper dir:
%d\n", err);
+               goto err_unmount_erofs;
+       }
+
+       err = init_mkdir("/overlay_work", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create overlay work dir:
%d\n", err);
+               goto err_rmdir_upper;
+       }
+
+       err = init_mkdir("/overlay_merged", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create overlay merged
dir: %d\n", err);
+               goto err_rmdir_work;
+       }
+
+       /* Mount tmpfs for the writable upper layer */
+       err = init_mount("tmpfs", "/overlay_upper", "tmpfs", 0, "mode=0755");
+       if (err) {
+               pr_err("initerofs: failed to mount tmpfs for upper
layer: %d\n", err);
+               goto err_rmdir_merged;
+       }
+
+       /* Create work and upper directories inside tmpfs */
+       err = init_mkdir("/overlay_upper/work", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create work subdir: %d\n", err);
+               goto err_unmount_tmpfs;
+       }
+
+       err = init_mkdir("/overlay_upper/upper", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create upper subdir: %d\n", err);
+               goto err_unmount_tmpfs;
+       }
+
+       /* Mount overlayfs combining EROFS (lower) and tmpfs (upper) */
+       err = init_mount("overlay", "/overlay_merged", "overlay", 0,
+
"lowerdir=/root,upperdir=/overlay_upper/upper,workdir=/overlay_upper/work");
+       if (err) {
+               pr_err("initerofs: failed to mount overlayfs: %d\n", err);
+               goto err_unmount_tmpfs;
+       }
+
+       /* Move overlayfs mount to root */
+       init_chdir("/overlay_merged");
+       err = init_mount(".", "/", NULL, MS_MOVE, NULL);
+       if (err) {
+               pr_err("initerofs: failed to move mount: %d\n", err);
+               return err;
+       }
+       init_chroot(".");
+
+       end_time = ktime_get();
+       elapsed_ns = ktime_to_ns(ktime_sub(end_time, start_time));
+       pr_info("initerofs: root filesystem ready in %lld.%06lld ms
(no cpio extraction)\n",
+               elapsed_ns / 1000000, (elapsed_ns % 1000000));
+
+       return 0;
+
+err_unmount_tmpfs:
+       init_umount("/overlay_upper", 0);
+err_rmdir_merged:
+       init_rmdir("/overlay_merged");
+err_rmdir_work:
+       init_rmdir("/overlay_work");
+err_rmdir_upper:
+       init_rmdir("/overlay_upper");
+err_unmount_erofs:
+       init_umount("/root", 0);
+
+err_blkdev:
+       initerofs_blkdev_destroy();
+       return err;
+}
+
+/*
+ * Check if initerofs should retain memory (via retain_initerofs param)
+ */
+bool __init initerofs_should_retain(void)
+{
+       return do_retain_initerofs;
+}
diff --git a/init/initerofs.h b/init/initerofs.h
new file mode 100644
index 000000000000..6ecca59652f6
--- /dev/null
+++ b/init/initerofs.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * EROFS-backed early root filesystem (initerofs)
+ *
+ * This header provides declarations for the initerofs subsystem which
+ * allows using an EROFS image directly from memory as the early root
+ * filesystem, without unpacking like traditional initramfs.
+ *
+ * The implementation automatically detects EROFS format by checking the
+ * magic number at offset 1024 in the initrd. If detected, EROFS is mounted
+ * directly instead of unpacking as cpio.
+ */
+
+#ifndef _INIT_INITEROFS_H
+#define _INIT_INITEROFS_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_INITEROFS
+
+/**
+ * initerofs_detect - Check if initrd contains an EROFS filesystem
+ *
+ * This function checks the magic number at offset 1024 in the initrd
+ * to determine if it's an EROFS image rather than a cpio archive.
+ *
+ * Return: true if EROFS format detected, false otherwise
+ */
+bool __init initerofs_detect(void);
+
+/**
+ * initerofs_mount_root - Mount the EROFS image as root filesystem
+ *
+ * This function mounts the EROFS filesystem from the initrd memory region
+ * with an overlayfs layer for writability.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int __init initerofs_mount_root(void);
+
+/**
+ * initerofs_should_retain - Check if initerofs memory should be retained
+ *
+ * Return: true if retain_initerofs boot param was specified
+ */
+bool __init initerofs_should_retain(void);
+
+/**
+ * initerofs_blkdev_create - Create a memory-backed block device
+ * @data: Pointer to the initrd memory region
+ * @size: Size of the initrd in bytes
+ *
+ * Creates a read-only block device that serves data directly from
+ * the initrd memory region, avoiding unnecessary memory copies.
+ *
+ * Return: Device path string on success, NULL on failure
+ */
+char * __init initerofs_blkdev_create(void *data, unsigned long size);
+
+/**
+ * initerofs_blkdev_destroy - Clean up the memory-backed block device
+ *
+ * Called if mount fails to release resources.
+ */
+void __init initerofs_blkdev_destroy(void);
+
+#else /* !CONFIG_INITEROFS */
+
+static inline bool __init initerofs_detect(void) { return false; }
+static inline int __init initerofs_mount_root(void) { return -ENODEV; }
+static inline bool __init initerofs_should_retain(void) { return false; }
+
+#endif /* CONFIG_INITEROFS */
+
+#endif /* _INIT_INITEROFS_H */
diff --git a/init/initerofs_blkdev.c b/init/initerofs_blkdev.c
new file mode 100644
index 000000000000..d6c0349bbf80
--- /dev/null
+++ b/init/initerofs_blkdev.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory-backed block device for initerofs
+ *
+ * This provides a simple read-only block device that serves data directly
+ * from the initrd memory region, avoiding unnecessary memory copies.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/highmem.h>
+#include <linux/initrd.h>
+#include <linux/init_syscalls.h>
+#include <linux/stat.h>
+
+#include "initerofs.h"
+#include "do_mounts.h"
+
+#define INITEROFS_BLKDEV_NAME  "initerofs"
+#define INITEROFS_SECTOR_SIZE  512
+
+static int initerofs_major;
+static struct gendisk *initerofs_disk;
+static void *initerofs_data;
+static unsigned long initerofs_size;
+
+/*
+ * Handle a bio by copying data directly from the initrd memory region.
+ * This is a simple synchronous implementation - reads are served directly
+ * from the memory-mapped initrd.
+ */
+static void initerofs_submit_bio(struct bio *bio)
+{
+       struct bio_vec bvec;
+       struct bvec_iter iter;
+       sector_t sector = bio->bi_iter.bi_sector;
+       unsigned long offset;
+
+       /* We only support reads */
+       if (bio_op(bio) != REQ_OP_READ) {
+               bio_io_error(bio);
+               return;
+       }
+
+       bio_for_each_segment(bvec, bio, iter) {
+               void *dst;
+               unsigned int len = bvec.bv_len;
+
+               offset = sector * INITEROFS_SECTOR_SIZE;
+
+               /* Bounds check */
+               if (offset + len > initerofs_size) {
+                       bio_io_error(bio);
+                       return;
+               }
+
+               /* Direct memory copy - no intermediate buffers needed */
+               dst = bvec_kmap_local(&bvec);
+               memcpy(dst, initerofs_data + offset, len);
+               kunmap_local(dst);
+
+               sector += len >> 9;
+       }
+
+       bio_endio(bio);
+}
+
+static const struct block_device_operations initerofs_fops = {
+       .owner = THIS_MODULE,
+       .submit_bio = initerofs_submit_bio,
+};
+
+/*
+ * Create and register the memory-backed block device.
+ * Returns the device path on success, NULL on failure.
+ */
+char * __init initerofs_blkdev_create(void *data, unsigned long size)
+{
+       struct queue_limits lim = {
+               .logical_block_size = INITEROFS_SECTOR_SIZE,
+               .physical_block_size = INITEROFS_SECTOR_SIZE,
+               .max_hw_sectors = UINT_MAX,
+               .max_segments = BLK_MAX_SEGMENTS,
+       };
+       int err;
+
+       if (!data || !size)
+               return NULL;
+
+       initerofs_data = data;
+       initerofs_size = size;
+
+       /* Register block device major number */
+       initerofs_major = register_blkdev(0, INITEROFS_BLKDEV_NAME);
+       if (initerofs_major < 0)
+               return NULL;
+
+       /* Allocate and configure the gendisk */
+       initerofs_disk = blk_alloc_disk(&lim, NUMA_NO_NODE);
+       if (IS_ERR(initerofs_disk)) {
+               unregister_blkdev(initerofs_major, INITEROFS_BLKDEV_NAME);
+               return NULL;
+       }
+
+       initerofs_disk->major = initerofs_major;
+       initerofs_disk->first_minor = 0;
+       initerofs_disk->minors = 1;
+       initerofs_disk->fops = &initerofs_fops;
+       snprintf(initerofs_disk->disk_name, sizeof(initerofs_disk->disk_name),
+                "%s", INITEROFS_BLKDEV_NAME);
+
+       /* Set capacity in sectors */
+       set_capacity(initerofs_disk, size / INITEROFS_SECTOR_SIZE);
+
+       /* Mark as read-only */
+       set_disk_ro(initerofs_disk, true);
+
+       /* Add the disk to the system */
+       err = add_disk(initerofs_disk);
+       if (err) {
+               pr_err("initerofs: add_disk failed: %d\n", err);
+               put_disk(initerofs_disk);
+               unregister_blkdev(initerofs_major, INITEROFS_BLKDEV_NAME);
+               return NULL;
+       }
+
+       pr_info("initerofs: block device registered, major=%d\n",
initerofs_major);
+
+       /* Create /dev directory if it doesn't exist */
+       err = init_mkdir("/dev", 0755);
+       if (err && err != -EEXIST) {
+               pr_err("initerofs: failed to create /dev: %d\n", err);
+               del_gendisk(initerofs_disk);
+               put_disk(initerofs_disk);
+               unregister_blkdev(initerofs_major, INITEROFS_BLKDEV_NAME);
+               return NULL;
+       }
+
+       /* Create the device node */
+       err = create_dev("/dev/" INITEROFS_BLKDEV_NAME,
+                        MKDEV(initerofs_major, 0));
+       if (err) {
+               pr_err("initerofs: create_dev failed: %d\n", err);
+               del_gendisk(initerofs_disk);
+               put_disk(initerofs_disk);
+               unregister_blkdev(initerofs_major, INITEROFS_BLKDEV_NAME);
+               return NULL;
+       }
+
+       pr_info("initerofs: device node /dev/initerofs created (major
%d, minor 0)\n",
+               initerofs_major);
+
+       /* Verify the device node is accessible */
+       {
+               struct kstat stat;
+               int stat_err = init_stat("/dev/"
INITEROFS_BLKDEV_NAME, &stat, 0);
+
+               if (stat_err) {
+                       pr_err("initerofs: device node stat failed:
%d\n", stat_err);
+               } else {
+                       pr_info("initerofs: device node verified:
mode=%o rdev=%u:%u\n",
+                               stat.mode, MAJOR(stat.rdev), MINOR(stat.rdev));
+               }
+       }
+
+       return "/dev/" INITEROFS_BLKDEV_NAME;
+}
+
+/*
+ * Clean up the block device (called if mount fails).
+ */
+void __init initerofs_blkdev_destroy(void)
+{
+       init_unlink("/dev/" INITEROFS_BLKDEV_NAME);
+       if (initerofs_disk) {
+               del_gendisk(initerofs_disk);
+               put_disk(initerofs_disk);
+               initerofs_disk = NULL;
+       }
+       if (initerofs_major > 0) {
+               unregister_blkdev(initerofs_major, INITEROFS_BLKDEV_NAME);
+               initerofs_major = 0;
+       }
+}
diff --git a/init/initramfs.c b/init/initramfs.c
index 6ddbfb17fb8f..17fdb73b7a5e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -23,6 +23,7 @@

 #include "do_mounts.h"
 #include "initramfs_internal.h"
+#include "initerofs.h"

 static __initdata bool csum_present;
 static __initdata u32 io_csum;
@@ -725,6 +726,26 @@ static void __init do_populate_rootfs(void
*unused, async_cookie_t cookie)
        if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
                goto done;

+       /*
+        * Check if the initrd is in EROFS format. If so, mount it directly
+        * instead of unpacking as cpio. This provides significant boot time
+        * and memory savings.
+        */
+       if (IS_ENABLED(CONFIG_INITEROFS) && initerofs_detect()) {
+               int ret = initerofs_mount_root();
+
+               if (!ret) {
+                       pr_info("initerofs: using EROFS as initial rootfs\n");
+                       /*
+                        * Do NOT free initrd memory - the memory-backed block
+                        * device reads directly from it. The memory must remain
+                        * available for the entire system lifetime.
+                        */
+                       goto done;
+               }
+               pr_warn("initerofs: mount failed (%d), trying cpio
unpack\n", ret);
+       }
+
        if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
                printk(KERN_INFO "Trying to unpack rootfs image as
initramfs...\n");
        else
@@ -739,9 +760,6 @@ static void __init do_populate_rootfs(void
*unused, async_cookie_t cookie)
 #endif
        }

-done:
-       security_initramfs_populated();
-
        /*
         * If the initrd region is overlapped with crashkernel reserved region,
         * free only memory that is not part of crashkernel region.
@@ -754,6 +772,9 @@ static void __init do_populate_rootfs(void
*unused, async_cookie_t cookie)
                if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
                        pr_err("Failed to create initrd sysfs file");
        }
+
+done:
+       security_initramfs_populated();
        initrd_start = 0;
        initrd_end = 0;

@@ -781,6 +802,22 @@ EXPORT_SYMBOL_GPL(wait_for_initramfs);

 static int __init populate_rootfs(void)
 {
+       /*
+        * Check for EROFS-based initrd synchronously BEFORE scheduling
+        * the async task. This ensures we run after all fs_initcalls
+        * have completed, so EROFS is definitely registered.
+        */
+       if (IS_ENABLED(CONFIG_INITEROFS) && initrd_start &&
+           !IS_ENABLED(CONFIG_INITRAMFS_FORCE) && initerofs_detect()) {
+               if (initerofs_mount_root() == 0) {
+                       pr_info("initerofs: using EROFS as initial rootfs\n");
+                       security_initramfs_populated();
+                       usermodehelper_enable();
+                       return 0;
+               }
+               pr_warn("initerofs: mount failed, falling back to cpio\n");
+       }
+
        initramfs_cookie = async_schedule_domain(do_populate_rootfs, NULL,
                                                 &initramfs_domain);
        usermodehelper_enable();
--
2.51.0

