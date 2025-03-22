Return-Path: <linux-fsdevel+bounces-44797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C0A6CC50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8E2189ADDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E32356CA;
	Sat, 22 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkiUbIiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDD145A03;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=nNZ935CtIShf1d8X7c3h00tEjwIkN5d53fIjLGCvA312lhTXcqs95DoIeaBzTvms5S8whVDkkKR/qEdn2Xpe5+VII7yIPh8BnBfNfJgm53m+92erDE+1jel3YAxFlpTETroM0HX8x14/8HoPoZHbcf2PttfjD7pR/gkmkkR2GV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=b7JI85xRpP1bLGtHtYPbhcaoaNVuyWClE1wqc+y12dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqDJxayjJ2vIH3zjhbYiY8HjqTo0MO9qLvmVUu6VGEwazHCekGTDshxMdMN8Tfk7TtbiSIaheH46pTfFG2WZd1mrFt2nJebjWYlBlNevfBOLV7ggFbAQ+w0Bh0yaU05gEtTx6fwB+9/58I5uUFsKD6pXHAd/RYqbrANBi3v3/Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkiUbIiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FF10C4CEF6;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=b7JI85xRpP1bLGtHtYPbhcaoaNVuyWClE1wqc+y12dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PkiUbIiy1F2jWy+vsjaTli7aXJSmRUSTgsE/+oz0WOxvw1B9SJ0HJ0aGgf8Vklwok
	 Y2bgLnUq0VjBg1xW4Ev0ft7/b2kmMn01iYcJ0t3XSbdyFE417lRSKSAZQSm+fx+k83
	 jzx5kztieVfWl0Vt+I/Rl1DdW/EfLQhUc4dtr+iEl17fHmXQh8TBFxE65bwIvemvuS
	 ayaDlnkjPZvzUQMNIEK62OfLhNdMZhoJAlgir1qbhZAeMbp9+XgTnr235+BHtOc7GZ
	 Klzpfv1rBY7w5ASRpLOgtJdi1KnzdSFu6KaH0WS3m0NRdTyigI+faaitaRPIJZyio1
	 jadKyrHtHRzWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3321AC3600A;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:16 +0100
Subject: [PATCH v2 4/9] fs: minix: register an initrd fs detector
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-4-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=3689;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=3zpODlrg8j0+m1aMvTBZ6a+FkLj5kE2s9qVHm6gavTI=;
 b=RK7CpwXGolb7amFsuhped3Wg2O4qk4HHkEiGLZYmGhlRWSGT/c3+VOQSXeOamqt73w1pTHf3Y
 GLNFj/9f0xZBXTeTlTZiA+v9cdaZ2Z+AAbSKnSXLqW7gkN2jrLUNoqM
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Port minix to the new initrd_fs_detect API. There are no functional
changes.

This code only supports the minix filesystem v1. This means 64 MiB
filesystem size limit. This would be a good candidate to drop support
for.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/minix/Makefile   |  5 +++++
 fs/minix/initrd.c   | 23 +++++++++++++++++++++++
 init/do_mounts_rd.c | 16 +---------------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/minix/Makefile b/fs/minix/Makefile
index a2d3ab58d1873eeada679a33a65b6cd0c421b3ad..cdd6a1a5b57a0205a1946faa676994c367380c97 100644
--- a/fs/minix/Makefile
+++ b/fs/minix/Makefile
@@ -6,3 +6,8 @@
 obj-$(CONFIG_MINIX_FS) += minix.o
 
 minix-objs := bitmap.o itree_v1.o itree_v2.o namei.o inode.o file.o dir.o
+
+# If we are built-in, we provide support for minix filesystem on initrds.
+ifeq ($(CONFIG_MINIX_FS),y)
+minix-objs += initrd.o
+endif
diff --git a/fs/minix/initrd.c b/fs/minix/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..18b39b9afe9994ec3dd9770eb516f9c25c183140
--- /dev/null
+++ b/fs/minix/initrd.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/fs.h>
+#include <linux/initrd.h>
+#include <linux/magic.h>
+#include <linux/minix_fs.h>
+
+static size_t __init detect_minixfs(void *block_data)
+{
+	struct minix_super_block *minixsb =
+		(struct minix_super_block *)block_data;
+	BUILD_BUG_ON(sizeof(*minixsb) > BLOCK_SIZE);
+
+	if (minixsb->s_magic != MINIX_SUPER_MAGIC &&
+	    minixsb->s_magic != MINIX_SUPER_MAGIC2)
+		return 0;
+
+
+	return minixsb->s_nzones
+		<< (minixsb->s_log_zone_size + BLOCK_SIZE_BITS);
+}
+
+initrd_fs_detect(detect_minixfs, BLOCK_SIZE);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 56c1fa935c7ee780870142923046a3d2fd2d6d96..f7e5d4ccf029b2707bc8524ecdbe200c8b305b00 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/fs.h>
-#include <linux/minix_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/romfs_fs.h>
 #include <uapi/linux/cramfs_fs.h>
@@ -42,7 +41,6 @@ static int __init crd_load(decompress_fn deco);
  * numbers could not be found.
  *
  * We currently check for the following magic numbers:
- *	minix
  *	ext2
  *	romfs
  *	cramfs
@@ -59,7 +57,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		decompress_fn *decompressor)
 {
 	const int size = BLOCK_SIZE;
-	struct minix_super_block *minixsb;
 	struct romfs_super_block *romfsb;
 	struct cramfs_super *cramfsb;
 	struct squashfs_super_block *squashfsb;
@@ -74,7 +71,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	if (!buf)
 		return -ENOMEM;
 
-	minixsb = (struct minix_super_block *) buf;
 	romfsb = (struct romfs_super_block *) buf;
 	cramfsb = (struct cramfs_super *) buf;
 	squashfsb = (struct squashfs_super_block *) buf;
@@ -141,21 +137,11 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	}
 
 	/*
-	 * Read block 1 to test for minix and ext2 superblock
+	 * Read block 1 to test for ext2 superblock
 	 */
 	pos = (start_block + 1) * BLOCK_SIZE;
 	kernel_read(file, buf, size, &pos);
 
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
 	/* Try ext2 */
 	n = ext2_image_size(buf);
 	if (n) {

-- 
2.47.0



