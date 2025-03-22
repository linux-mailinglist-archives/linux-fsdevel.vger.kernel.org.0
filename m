Return-Path: <linux-fsdevel+bounces-44801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C4A6CC56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C463B81DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23323236A7C;
	Sat, 22 Mar 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/wc4fVk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B17235355;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=ieVwaalQxsX+15KOS5+Rdj4iKOZg97R+ds2VutNYN+DBs9wHpFCnKyDXpnyswTZ6ej6XXDvDujOQNhB2eT46cHXSLeEqb0C9H0GWFFtcDo0GnKXuNgXmSXRlx5UkINkU3PO00Ucjb6CGYFyqCWFDL4fOk5ryuYe4PJnpE7ULjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=CGLJl1zEmiCISwzcev9qeEVvn+4xnW6/oap/uXff3ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I70F26dpodX1veivBjU/t62+W0BOXyh+30eqYUCyTzmee/RgxGHjsWw2Bp8NetgVzbZKznx81xhlXX9YtdEAYJpf2sHyU2lLsIM1D9OeU3YyRZ+o2kHzvys7qC7xqMSAzXwZqOC7f4g2OhhIjfUzKhDX2Xcc1IJJN6JUTNPW/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/wc4fVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E4A6C4CEFF;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=CGLJl1zEmiCISwzcev9qeEVvn+4xnW6/oap/uXff3ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R/wc4fVkDIP+pjdeKOjGNRZlhkfRErVXjcoSVJkAhNbpwZ7QyIZbx7sZkeWvbAKai
	 qNNZJNjqbFbJwBxL17trCKvX4uSpPJ7FY4XcWNwa5Bt69/64flpcJJii0vwObyEGUO
	 hXiat1wm3Xg47MSjjy81dVhNZFqjdoyqVnPhgS8fJ9nvnQogvvoV685Y+VEgaH7F85
	 Xc3nguWyTFepgiPs+xAypo+L1hJNwOdh4iEA/AnGdbvegrCmOlUGQBappo7Nv0Js4w
	 W5pJHoaxRrkwp23ExdBNbxOAUxhSWDL5PjCsne5KyKh97YafvB2z5LqqEh8+w3b81e
	 wXKu7gJ3DSVAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241DC35FFC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:19 +0100
Subject: [PATCH v2 7/9] fs: squashfs: register an initrd fs detector
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-7-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=3201;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=zysxuXEy456UHMgFgfSEAGox0ynSn0NVemXDz0PKiSU=;
 b=nZrNbSLcFivZ71KUl0X/nNQRHCoVKonroEdGfu+uTmwQBjJeOyVqHGkumj6SPGTNn0sy1YrD3
 ejVMVfXX5AHAbW52Bbp6N3qM1+EdspO5bbB9w5pauYrKxkHm/r0zGG2
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Port squashfs from to the new initrd_fs_detect API. There are no
functional changes.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/squashfs/Makefile |  5 +++++
 fs/squashfs/initrd.c | 23 +++++++++++++++++++++++
 init/do_mounts_rd.c  | 14 --------------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 477c89a519ee8825e4dfc88f76e09fd733e90625..fa64f0b9a45e52e9b3e78bd16446474c0b3dc158 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -17,3 +17,8 @@ squashfs-$(CONFIG_SQUASHFS_LZO) += lzo_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_XZ) += xz_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_ZLIB) += zlib_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_ZSTD) += zstd_wrapper.o
+
+# If we are built-in, we provide support for squashfs on initrds.
+ifeq ($(CONFIG_SQUASHFS),y)
+squashfs-y += initrd.o
+endif
diff --git a/fs/squashfs/initrd.c b/fs/squashfs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..bb99fc40083c6c5fdf47b2e28bcdc525d36520b4
--- /dev/null
+++ b/fs/squashfs/initrd.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/initrd.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
+
+#include "squashfs_fs.h"
+
+static size_t __init detect_squashfs(void *block_data)
+{
+	struct squashfs_super_block *squashfsb
+		= (struct squashfs_super_block *)block_data;
+	BUILD_BUG_ON(sizeof(*squashfsb) > BLOCK_SIZE);
+
+		/* squashfs is at block zero too */
+	if (le32_to_cpu(squashfsb->s_magic) != SQUASHFS_MAGIC)
+		return 0;
+
+
+	return le64_to_cpu(squashfsb->bytes_used);
+}
+
+initrd_fs_detect(detect_squashfs, 0);
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 9f9a04cce505e532d444e2aef77037bc2b01da08..2a6cb08d0b4872ef8e861a813ef89dc1e9a150af 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 
 #include "do_mounts.h"
-#include "../fs/squashfs/squashfs_fs.h"
 
 #include <linux/decompress/generic.h>
 
@@ -41,7 +40,6 @@ static int __init crd_load(decompress_fn deco);
  *
  * We currently check for the following magic numbers:
  *	ext2
- *	squashfs
  *	gzip
  *	bzip2
  *	lzma
@@ -55,7 +53,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 {
 	const int size = BLOCK_SIZE;
 
-	struct squashfs_super_block *squashfsb;
 	int nblocks = -1;
 	unsigned char *buf;
 	const char *compress_name;
@@ -67,7 +64,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	if (!buf)
 		return -ENOMEM;
 
-	squashfsb = (struct squashfs_super_block *) buf;
 	memset(buf, 0xe5, size);
 
 	/*
@@ -88,16 +84,6 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
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
 	/*
 	 * Read block 1 to test for ext2 superblock
 	 */

-- 
2.47.0



