Return-Path: <linux-fsdevel+bounces-63730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64884BCC679
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D503AFF85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9F12D0C7F;
	Fri, 10 Oct 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M67juhzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207902BF011
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089367; cv=none; b=H+u0sMl8dYUNSEvnlKVc+xqsVcNFwnNqQvlFuxTW5KHJZpetwZeKK+1Xa+3+4NeJH2j1eyc1waeqFMlWomvbqQ3/mOXc5pveFI7i4ZeiE0B3Lublb3XSD1RSoQZDqQlvIZt6v9aFwCYpYaKbzANvMrVRwmCeC9fuwMoDow8pwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089367; c=relaxed/simple;
	bh=gjPlGissF6EYFYZPaMD+IJyLT7L2Kw6o1SmPVz9xBaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTRo9HYY5OLjwGc458Xx+fM8QFtQQ/hlRyyAcy1TQLEUsVan0ielMai4EpaP2zwRGM1gkXBDCb1EQ+xS3wVkbvpHdb71NQlHj7ti5azjkKYc8wqXgwIVtcH5p/h+4wzv76pyzxKnAT4m5F2hpn9VF1CSgu3XTHDuu309Wi7PXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M67juhzb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421b93ee372so986867f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760089361; x=1760694161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGor90y5sQmBa6+afLj7nUayHxGY9HpJCoz4p3w31VA=;
        b=M67juhzbW+EksNbNENYBsjEYULuJJiJwyd4z+LPON174cTXkSu29UnLru21DY2wjOR
         t/GvC+7fGPPzENHHCtoGW25nCdPiBkwgrGc+OYs7VD2z8g4qzw24CLoTp1l6/emQJVTW
         r4RDR4nBewy5rUal5YsAbDmenOeiL82lY1d5iUC/5bPiv7i2jXcIHnQ2DBpfuKxyTtma
         /0jz2I2aidpEiQjaiYQQN6rRzJHFysCk5hypK79yRWy6a+qKgW0plx/wgXESKXFx0bTa
         o5S67y1aawV1Y1s/6l21fZePmGOazaUlLZTdUNI1wia0DkMBvjsL/FwOjAzSFLgM/qDL
         pJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089361; x=1760694161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGor90y5sQmBa6+afLj7nUayHxGY9HpJCoz4p3w31VA=;
        b=ndEanj+cK7PHQqSHlc94oLGeo6Sg5TKmQiAWoeWDFxGJvJ+NcdaTOSs3973F4ZFiSX
         fX179GUmhzm+txUyIETn2WhuKkFRdEOMnUECtks8re21gvvq5/N8Rrajz7mmo0PEfbq/
         7HL44XlvI/z4CZjyfYVkVLgi7EAsJIQRSQioffl17t4luajwYoJgvFsYU9LoM9Rsh9f8
         0339fSFDIAUmB4ZNKzZNQbBzT7nAcmxWBqzzflLdyj46e65Xaq5R7Q2H8m96F+S36k0U
         Me95XLkQE0FgQD8Ae0wfEUVDDfkqF390IeLn10n9OYmGFblxE8669C9kIfj8k5toJ45J
         s3fQ==
X-Gm-Message-State: AOJu0YwIoS/27InVEaiKJOfhUw64r8B7YO26ukM2yRQg6URnWXLBd+QV
	hHOBa6VpYbbf3Ce/lVGbsnw+mhm0jiUwFK0z8Em7CoZVhW/FJi3mV8Ue40TBaFTx
X-Gm-Gg: ASbGncsqC6c4mLpfv8dptJbzhDbaSlyirKuiIL43KkvSZOQkVT06/U2Cp8y8o+3z/5H
	kHAezhwHYK6Xma/4CscVxgyvlfmYDPAAKQcvKjufO3DYu/2+FhDet1mfl6Wbvqa3jUkhKhD7wqP
	AxGx+MzSqFTnzWZuM2O+4JbOQqm2Pfajpnto/CtATffGLu9+aKjgaBKePzSrhJn6o3mC2PFSzLu
	jUXzRg8m+t5uiTD7zBpacKRHA9tUBTqiye71H9XvyaOdgk7QZB5aMN5m0T9+LIGTYaRpsX0SlGp
	WOnu4H7da3Pq2QmuqFtzLqO1Xxo3XnpIMDVGq6kAvWoQ0Sf+Cn8lQ0X18CF+V0NaDy56ZOQ5MqF
	1xoWU//5h2+V6y8hRFt4CkHhqnasIeU8JVIOEfQ==
X-Google-Smtp-Source: AGHT+IG5hUlNpNqFmjuCUBM21GrnZZo3v6yQYLN20PP8R9c3EH7G+xd/e7926FvUzEtuyqYUZ8VCzA==
X-Received: by 2002:a05:6000:4305:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-42666ac2ce9mr6828418f8f.11.1760089360889;
        Fri, 10 Oct 2025 02:42:40 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce582b39sm3248294f8f.15.2025.10.10.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:42:40 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
Date: Fri, 10 Oct 2025 09:40:46 +0000
Message-ID: <20251010094047.3111495-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010094047.3111495-1-safinaskar@gmail.com>
References: <20251010094047.3111495-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove linuxrc initrd code path, which was deprecated in 2020.

Initramfs and (non-initial) RAM disks (i. e. brd) still work.

Both built-in and bootloader-supplied initramfs still work.

Non-linuxrc initrd code path (i. e. using /dev/ram as final root
filesystem) still works, but I put deprecation message into it

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +-
 fs/init.c                                     | 14 ---
 include/linux/init_syscalls.h                 |  1 -
 include/linux/initrd.h                        |  2 -
 init/do_mounts.c                              |  4 +-
 init/do_mounts.h                              | 18 +---
 init/do_mounts_initrd.c                       | 85 ++-----------------
 init/do_mounts_rd.c                           | 17 +---
 8 files changed, 17 insertions(+), 128 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 521ab3425504..24d8899d8a39 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4285,7 +4285,7 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
-	noinitrd	[RAM] Tells the kernel not to load any configured
+	noinitrd	[Deprecated,RAM] Tells the kernel not to load any configured
 			initial RAM disk.
 
 	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
@@ -5299,7 +5299,7 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
-	ramdisk_start=	[RAM] RAM disk image start address
+	ramdisk_start=	[Deprecated,RAM] RAM disk image start address
 
 	random.trust_cpu=off
 			[KNL,EARLY] Disable trusting the use of the CPU's
diff --git a/fs/init.c b/fs/init.c
index 07f592ccdba8..60719494d9a0 100644
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
index f1a1f4c92ded..7e5d26c8136f 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,8 +3,6 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
-#define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
-
 /* starting block # of image */
 extern int rd_image_start;
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 0f2f44e6250c..1054ad3c905a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -476,13 +476,11 @@ void __init prepare_namespace(void)
 	if (saved_root_name[0])
 		ROOT_DEV = parse_root_device(saved_root_name);
 
-	if (initrd_load(saved_root_name))
-		goto out;
+	initrd_load();
 
 	if (root_wait)
 		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
-out:
 	devtmpfs_mount();
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	init_chroot(".");
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..a386ee5314c9 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -23,25 +23,15 @@ static inline __init int create_dev(char *name, dev_t dev)
 }
 
 #ifdef CONFIG_BLK_DEV_RAM
-
-int __init rd_load_disk(int n);
-int __init rd_load_image(char *from);
-
+int __init rd_load_image(void);
 #else
-
-static inline int rd_load_disk(int n) { return 0; }
-static inline int rd_load_image(char *from) { return 0; }
-
+static inline int rd_load_image(void) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-bool __init initrd_load(char *root_device_name);
+void __init initrd_load(void);
 #else
-static inline bool initrd_load(char *root_device_name)
-{
-	return false;
-	}
-
+static inline void initrd_load(void) { }
 #endif
 
 /* Ensure that async file closing finished to prevent spurious errors. */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index f6867bad0d78..d4f5f4c60a22 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -2,13 +2,7 @@
 #include <linux/unistd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/minix_fs.h>
-#include <linux/romfs_fs.h>
 #include <linux/initrd.h>
-#include <linux/sched.h>
-#include <linux/freezer.h>
-#include <linux/kmod.h>
-#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
@@ -41,6 +35,7 @@ late_initcall(kernel_do_mounts_initrd_sysctls_init);
 
 static int __init no_initrd(char *str)
 {
+	pr_warn("noinitrd option is deprecated and will be removed soon\n");
 	mount_initrd = 0;
 	return 1;
 }
@@ -70,85 +65,17 @@ static int __init early_initrd(char *p)
 }
 early_param("initrd", early_initrd);
 
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
+void __init initrd_load(void)
 {
 	if (mount_initrd) {
 		create_dev("/dev/ram", Root_RAM0);
 		/*
-		 * Load the initrd data into /dev/ram0. Execute it as initrd
-		 * unless /dev/ram0 is supposed to be our actual root device,
-		 * in that case the ram disk is just set up here, and gets
-		 * mounted in the normal path.
+		 * Load the initrd data into /dev/ram0.
 		 */
-		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			init_unlink("/initrd.image");
-			handle_initrd(root_device_name);
-			return true;
+		if (rd_load_image()) {
+			pr_warn("using deprecated initrd support, will be removed in September 2026; "
+				"use initramfs instead or (as a last resort) /sys/firmware/initrd.\n");
 		}
 	}
 	init_unlink("/initrd.image");
-	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 5311f2d7edc8..0a021bbcd501 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -22,6 +22,7 @@ int __initdata rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
 {
+	pr_warn("ramdisk_start= option is deprecated and will be removed soon\n");
 	rd_image_start = simple_strtol(str,NULL,0);
 	return 1;
 }
@@ -177,7 +178,7 @@ static unsigned long nr_blocks(struct file *file)
 	return i_size_read(inode) >> 10;
 }
 
-int __init rd_load_image(char *from)
+int __init rd_load_image(void)
 {
 	int res = 0;
 	unsigned long rd_blocks, devblocks, nr_disks;
@@ -191,7 +192,7 @@ int __init rd_load_image(char *from)
 	if (IS_ERR(out_file))
 		goto out;
 
-	in_file = filp_open(from, O_RDONLY, 0);
+	in_file = filp_open("/initrd.image", O_RDONLY, 0);
 	if (IS_ERR(in_file))
 		goto noclose_input;
 
@@ -220,10 +221,7 @@ int __init rd_load_image(char *from)
 	/*
 	 * OK, time to copy in the data
 	 */
-	if (strcmp(from, "/initrd.image") == 0)
-		devblocks = nblocks;
-	else
-		devblocks = nr_blocks(in_file);
+	devblocks = nblocks;
 
 	if (devblocks == 0) {
 		printk(KERN_ERR "RAMDISK: could not determine device size\n");
@@ -267,13 +265,6 @@ int __init rd_load_image(char *from)
 	return res;
 }
 
-int __init rd_load_disk(int n)
-{
-	create_dev("/dev/root", ROOT_DEV);
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
-	return rd_load_image("/dev/root");
-}
-
 static int exit_code;
 static int decompress_error;
 
-- 
2.47.3


