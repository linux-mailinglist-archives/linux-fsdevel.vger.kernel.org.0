Return-Path: <linux-fsdevel+bounces-44799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B107A6CC53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BF2189AEBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D92356CC;
	Sat, 22 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/LalmDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97098224236;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=EgzSzcfcSddxcJZ6YAQPdJ03pVHVcoVy9HoXdOdGJhSYKFWQp/K6IBWe2d1mq+VPgwjAdK3QHAqqY/xVmU0DYwTKc6TgWTGKnhGVVvt9eUSe8cz2OpdKGpt9s1WtCEy+ad+hoO2wdp9Y2+7IGpUJDVop6tm8tkG9+cxh+GfdN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=TDhbyo9F/ZSQ2RUuUaTZZ0o9x6DAYOKYzNLlrAq8L1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htkxyKwrU3TzPgfUWP9/qRLGQ2dQY5WkWHvmc9Ak9nrJvs1BpZQ7oyY6PLPZnRY+zp+UoAZnsELvy4BMcnguzmOL3WdOprGmgFJ2W5B4rR88Y7CFWonnl+HTneolcgCaOI5xjf1uQhGGIHMeCwNtwjmF5tkzjnK7TKzL4Z/B0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/LalmDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C191C4CEF0;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=TDhbyo9F/ZSQ2RUuUaTZZ0o9x6DAYOKYzNLlrAq8L1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q/LalmDtJOUAJrZHrgHxJkI2oI09js3AZcqdeCniUFAecfSyWNCit8xl6Gnwf105n
	 9SchH1kvzhhghyYBJYt7i86OHBq6i/rk+MFsh/lSdEplNrDm37JTWV6OvN8XY2dUpd
	 boDRzh6n0bTigRewigYWSR9Bv9Bd7UdU+FcERoZZ6qJKjQW8rLu2mLLuwjNSsc38eg
	 cQ419jrRsQo3YkOtDb3ZV72NDNuJBjH4rNUrFSGYZLQKoliY+Sm9j+ScDmFiMhb+zf
	 H/Qngo6n++qHSxGPo6UGJ7o6bMET9oSN2dxow/lwAtliJdJv4b4tAEJ8hgVnrPMn3C
	 powEUC9VQS67g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEBEC35FFC;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:15 +0100
Subject: [PATCH v2 3/9] initrd: add a generic mechanism to add fs detectors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-3-d66ee4a2c756@cyberus-technology.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=5291;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=55Wh0MWl4j4HdLagTcgFYbNKFaTKj1GqG+lEyJb27TU=;
 b=OGbHoFniZHWRPY2giReYmVqjd13V7KvnyKGwIuoxXzLG+X8S0AOkCmqZtNSa/bEz/ox8kmn5P
 3SEJs2yPUFYAnv2JT9E89Ihwls7xnW3A4QYDVuDzcQopJf7R7NZH9fE
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

So far all filesystems that are supported as initrd have their
filesystem detection code implemented in init/do_mounts_rd.c. A better
approach is to let filesystem implementations register a detection
hook. This allows the filesystem detection code to live with the rest
of the filesystem implementation.

We could have done a more flexible mechanism than passing a block of
data, but this simple solution works for all filesystems and keeps the
boilerplate low.

The following patches will convert each of the filesystems.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 include/asm-generic/vmlinux.lds.h |  6 ++++++
 include/linux/initrd.h            | 37 +++++++++++++++++++++++++++++++++++++
 init/do_mounts_rd.c               | 28 +++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0d5b186abee86d27f3b02a49299155453a8c8e9e..d0816e6c41a9bbedf8f5a68c33b6f3e18014019a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -968,8 +968,13 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
+
+#define INITRD_FS_DETECT()						\
+	. = ALIGN(16);							\
+	BOUNDED_SECTION(_initrd_fs_detect)
 #else
 #define INIT_RAM_FS
+#define INITRD_FS_DETECT()
 #endif
 
 /*
@@ -1170,6 +1175,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		INIT_CALLS						\
 		CON_INITCALL						\
 		INIT_RAM_FS						\
+		INITRD_FS_DETECT()					\
 	}
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index f1a1f4c92ded3921bf56d53bee3e20b549d851fb..25463ce9c26ad4e4e9d3b333aa9f5596585c1762 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -3,6 +3,9 @@
 #ifndef __LINUX_INITRD_H
 #define __LINUX_INITRD_H
 
+#include <linux/init.h>
+#include <linux/types.h>
+
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 /* starting block # of image */
@@ -18,12 +21,46 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+struct file;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 extern void __init reserve_initrd_mem(void);
 extern void wait_for_initramfs(void);
+
+/*
+ * Detect a filesystem on the initrd. You get 1 KiB (BLOCK_SIZE) of
+ * data to work with. The offset of the block is specified in
+ * initrd_fs_detect().
+ *
+ * @block_data: A pointer to BLOCK_SIZE of data
+ *
+ * Returns the size of the filesystem in bytes or 0, if the filesystem
+ * was not detected.
+ */
+typedef size_t initrd_fs_detect_fn(void * const block_data);
+
+struct initrd_detect_fs {
+	initrd_fs_detect_fn *detect_fn;
+	loff_t detect_byte_offset;
+};
+
+extern struct initrd_detect_fs __start_initrd_fs_detect[];
+extern struct initrd_detect_fs __stop_initrd_fs_detect[];
+
+/*
+ * Add a filesystem detector for initrds. See the documentation of
+ * initrd_fs_detect_fn above.
+ */
+#define initrd_fs_detect(fn, byte_offset)					\
+	static const struct initrd_detect_fs __initrd_fs_detect_ ## fn		\
+	__used __section("_initrd_fs_detect") =					\
+		{ .detect_fn = fn, .detect_byte_offset = byte_offset}
+
 #else
 static inline void __init reserve_initrd_mem(void) {}
 static inline void wait_for_initramfs(void) {}
+
+#define initrd_fs_detect(detectfn)
 #endif
 
 extern phys_addr_t phys_initrd_start;
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index d026df401afa0b7458ab1f266b21830aab974b92..56c1fa935c7ee780870142923046a3d2fd2d6d96 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -58,7 +58,7 @@ static int __init
 identify_ramdisk_image(struct file *file, loff_t pos,
 		decompress_fn *decompressor)
 {
-	const int size = 512;
+	const int size = BLOCK_SIZE;
 	struct minix_super_block *minixsb;
 	struct romfs_super_block *romfsb;
 	struct cramfs_super *cramfsb;
@@ -68,6 +68,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	const char *compress_name;
 	unsigned long n;
 	int start_block = rd_image_start;
+	struct initrd_detect_fs *detect_fs;
 
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
@@ -165,6 +166,31 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
+	/* Try to find a filesystem in the initrd */
+	for (detect_fs = __start_initrd_fs_detect;
+	     detect_fs < __stop_initrd_fs_detect;
+	     detect_fs++
+	     ) {
+		size_t fs_size;
+
+		pos = (start_block * BLOCK_SIZE) + detect_fs->detect_byte_offset;
+		kernel_read(file, buf, size, &pos);
+
+		fs_size = detect_fs->detect_fn(buf);
+
+		if (fs_size == 0)
+			continue;
+
+		nblocks = (fs_size + BLOCK_SIZE + 1)
+			>> BLOCK_SIZE_BITS;
+
+		printk(KERN_NOTICE
+		       "RAMDISK: filesystem found (%d blocks)\n",
+		       nblocks);
+
+		goto done;
+	}
+
 	printk(KERN_NOTICE
 	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
 	       start_block);

-- 
2.47.0



