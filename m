Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382A321FC9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgGNTKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbgGNTJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157AC061755;
        Tue, 14 Jul 2020 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OmCgUOdSsvmHGztW/pN0QYL1W0Hm8w4sIRIjoHrqxng=; b=LKLu+0XYPDhxTj2Kr2CM/h6nGN
        oFsS2HfC1DzPfvaExlEfzQC18M3ItsCWp94GHgM7usiqsBZzetBCb9FGvRhPQ7G9BIHUscUYFfmla
        Q0EW4L0P7lKlZ93XUXveEcJA/Ut2N6ZZcviFhicCAKccUnn6Q2F2TUll3+Ao8R5q6et2+cLdb9erV
        jees1YZuFUGL30NnXYVwHj4WpIPaEJJeSN+DdZWrCNJmUKIgcvu9z7bEeu0PeNhIcuUF7TM87u73M
        rjgEL8+J5wMFr+VQrv3Nt0zYBsTpXIPGKzgu9T3W5sEjBZkE7EQIphISioV0OJzOY6ueCdJclYUiv
        9mXL8CAA==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIY-0005rN-Tz; Tue, 14 Jul 2020 19:09:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/23] initrd: remove support for multiple floppies
Date:   Tue, 14 Jul 2020 21:04:14 +0200
Message-Id: <20200714190427.4332-11-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the special handling for multiple floppies in the initrd code.
No one should be using floppies for booting these days. (famous last
words..)

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/kernel/atags_parse.c |  2 -
 arch/sh/kernel/setup.c        |  2 -
 arch/sparc/kernel/setup_32.c  |  2 -
 arch/sparc/kernel/setup_64.c  |  2 -
 arch/x86/kernel/setup.c       |  2 -
 include/linux/initrd.h        |  6 ---
 init/do_mounts.c              | 69 ++++-------------------------------
 init/do_mounts.h              |  1 -
 init/do_mounts_rd.c           | 20 +++-------
 9 files changed, 12 insertions(+), 94 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index ce02f92f4ab262..6c12d9fe694e3e 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -91,8 +91,6 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
 	rd_image_start = tag->u.ramdisk.start;
-	rd_doload = (tag->u.ramdisk.flags & 1) == 0;
-	rd_prompt = (tag->u.ramdisk.flags & 2) == 0;
 
 	if (tag->u.ramdisk.size)
 		rd_size = tag->u.ramdisk.size;
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 67f5a3b44c2eff..4144be650d4106 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -290,8 +290,6 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 
 	if (!MOUNT_ROOT_RDONLY)
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 6d07b85b9e2470..eea43a1aef1b9a 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -353,8 +353,6 @@ void __init setup_arch(char **cmdline_p)
 	ROOT_DEV = old_decode_dev(root_dev);
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);	
 #endif
 
 	prom_setsync(prom_sync_me);
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f765fda871eb61..d87244197d5cbb 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -659,8 +659,6 @@ void __init setup_arch(char **cmdline_p)
 	ROOT_DEV = old_decode_dev(root_dev);
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = ram_flags & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((ram_flags & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((ram_flags & RAMDISK_LOAD_FLAG) != 0);
 #endif
 
 	task_thread_info(&init_task)->kregs = &fake_swapper_regs;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758c0..b9a68d8e06d8d1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -870,8 +870,6 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((boot_params.hdr.ram_size & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((boot_params.hdr.ram_size & RAMDISK_LOAD_FLAG) != 0);
 #endif
 #ifdef CONFIG_EFI
 	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index aa591435572868..8db6f8c8030b68 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -2,12 +2,6 @@
 
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
-/* 1 = load ramdisk, 0 = don't load */
-extern int rd_doload;
-
-/* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_prompt;
-
 /* starting block # of image */
 extern int rd_image_start;
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 1a4dfa17fb2899..4f4ceb35805503 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -28,8 +28,6 @@
 
 #include "do_mounts.h"
 
-int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
-
 int root_mountflags = MS_RDONLY | MS_SILENT;
 static char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
@@ -39,7 +37,7 @@ dev_t ROOT_DEV;
 
 static int __init load_ramdisk(char *str)
 {
-	rd_doload = simple_strtol(str,NULL,0) & 3;
+	pr_warn("ignoring the depreated load_ramdisk= option\n");
 	return 1;
 }
 __setup("load_ramdisk=", load_ramdisk);
@@ -553,66 +551,20 @@ static int __init mount_cifs_root(void)
 }
 #endif
 
-#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
-void __init change_floppy(char *fmt, ...)
-{
-	struct termios termios;
-	char buf[80];
-	char c;
-	int fd;
-	va_list args;
-	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
-	va_end(args);
-	fd = ksys_open("/dev/root", O_RDWR | O_NDELAY, 0);
-	if (fd >= 0) {
-		ksys_ioctl(fd, FDEJECT, 0);
-		ksys_close(fd);
-	}
-	printk(KERN_NOTICE "VFS: Insert %s and press ENTER\n", buf);
-	fd = ksys_open("/dev/console", O_RDWR, 0);
-	if (fd >= 0) {
-		ksys_ioctl(fd, TCGETS, (long)&termios);
-		termios.c_lflag &= ~ICANON;
-		ksys_ioctl(fd, TCSETSF, (long)&termios);
-		ksys_read(fd, &c, 1);
-		termios.c_lflag |= ICANON;
-		ksys_ioctl(fd, TCSETSF, (long)&termios);
-		ksys_close(fd);
-	}
-}
-#endif
-
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
 	if (ROOT_DEV == Root_NFS) {
-		if (mount_nfs_root())
-			return;
-
-		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
-		ROOT_DEV = Root_FD0;
+		if (!mount_nfs_root())
+			printk(KERN_ERR "VFS: Unable to mount root fs via NFS.\n");
+		return;
 	}
 #endif
 #ifdef CONFIG_CIFS_ROOT
 	if (ROOT_DEV == Root_CIFS) {
-		if (mount_cifs_root())
-			return;
-
-		printk(KERN_ERR "VFS: Unable to mount root fs via SMB, trying floppy.\n");
-		ROOT_DEV = Root_FD0;
-	}
-#endif
-#ifdef CONFIG_BLK_DEV_FD
-	if (MAJOR(ROOT_DEV) == FLOPPY_MAJOR) {
-		/* rd_doload is 2 for a dual initrd/ramload setup */
-		if (rd_doload==2) {
-			if (rd_load_disk(1)) {
-				ROOT_DEV = Root_RAM1;
-				root_device_name = NULL;
-			}
-		} else
-			change_floppy("root floppy");
+		if (!mount_cifs_root())
+			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
+		return;
 	}
 #endif
 #ifdef CONFIG_BLOCK
@@ -631,8 +583,6 @@ void __init mount_root(void)
  */
 void __init prepare_namespace(void)
 {
-	int is_floppy;
-
 	if (root_delay) {
 		printk(KERN_INFO "Waiting %d sec before mounting root device...\n",
 		       root_delay);
@@ -675,11 +625,6 @@ void __init prepare_namespace(void)
 		async_synchronize_full();
 	}
 
-	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
-
-	if (is_floppy && rd_doload && rd_load_disk(0))
-		ROOT_DEV = Root_RAM0;
-
 	mount_root();
 out:
 	devtmpfs_mount();
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 50d6c8941e15a1..c855b3f0e06d19 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -9,7 +9,6 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 
-void  change_floppy(char *fmt, ...);
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
 extern int root_mountflags;
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 32fb049d18f9b4..27b1bccf6f12a8 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -15,11 +15,9 @@
 #include <linux/decompress/generic.h>
 
 
-int __initdata rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
-
 static int __init prompt_ramdisk(char *str)
 {
-	rd_prompt = simple_strtol(str,NULL,0) & 1;
+	pr_warn("ignoring the depreated prompt_ramdisk= option\n");
 	return 1;
 }
 __setup("prompt_ramdisk=", prompt_ramdisk);
@@ -178,7 +176,7 @@ int __init rd_load_image(char *from)
 	int res = 0;
 	int in_fd, out_fd;
 	unsigned long rd_blocks, devblocks;
-	int nblocks, i, disk;
+	int nblocks, i;
 	char *buf = NULL;
 	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
@@ -243,21 +241,15 @@ int __init rd_load_image(char *from)
 
 	printk(KERN_NOTICE "RAMDISK: Loading %dKiB [%ld disk%s] into ram disk... ",
 		nblocks, ((nblocks-1)/devblocks)+1, nblocks>devblocks ? "s" : "");
-	for (i = 0, disk = 1; i < nblocks; i++) {
+	for (i = 0; i < nblocks; i++) {
 		if (i && (i % devblocks == 0)) {
-			pr_cont("done disk #%d.\n", disk++);
+			pr_cont("done disk #1.\n");
 			rotate = 0;
 			if (ksys_close(in_fd)) {
 				printk("Error closing the disk.\n");
 				goto noclose_input;
 			}
-			change_floppy("disk #%d", disk);
-			in_fd = ksys_open(from, O_RDONLY, 0);
-			if (in_fd < 0)  {
-				printk("Error opening disk.\n");
-				goto noclose_input;
-			}
-			printk("Loading disk #%d... ", disk);
+			break;
 		}
 		ksys_read(in_fd, buf, BLOCK_SIZE);
 		ksys_write(out_fd, buf, BLOCK_SIZE);
@@ -284,8 +276,6 @@ int __init rd_load_image(char *from)
 
 int __init rd_load_disk(int n)
 {
-	if (rd_prompt)
-		change_floppy("root floppy disk to be loaded into RAM disk");
 	create_dev("/dev/root", ROOT_DEV);
 	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n));
 	return rd_load_image("/dev/root");
-- 
2.27.0

