Return-Path: <linux-fsdevel+bounces-44636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E6A6AE7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 20:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A4F7AB49B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59D8227E89;
	Thu, 20 Mar 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtKXVuF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B311227E98;
	Thu, 20 Mar 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498909; cv=none; b=u3CDJgzLNqXvTp8TnySxXxNAxmCvF5qgUKFmDiitKQHV/66a4nlA2YZL1+vHwoHKUUU6lXC8zITWLu2pFdoZcxDODpx08ng464EyS/9v8QhmaatRZNJIJZKjsCyfm8M7HT9o38z6G6gECtxuCpCx3Zj3Ta3tLmtHxkvC+o8RHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498909; c=relaxed/simple;
	bh=D8iocau2N1axFaCMOPfu2U2+YOYlfq5VLw9N0oFkipI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GUTJd5gZjF8k/KG+awG6Gp6F2nk2aaZotbTFCkkeugLAz+NBMd5iqxgR2Nuq3hSkHqWUD/hkavhaRgJn1VG1z6uPcqVGpHdYYDqb7HafEkBqnm1XVEj+IApwC1QP4tW5LpI2Aeyo7qxuQ0QoyHIfPRTi7kpVolYkeTt8adRTe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtKXVuF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9395C4CEDD;
	Thu, 20 Mar 2025 19:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742498908;
	bh=D8iocau2N1axFaCMOPfu2U2+YOYlfq5VLw9N0oFkipI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BtKXVuF2PxYzEkIyIj755XEdZD8rpKBMR45/0OR2e0umnr9FJY0OJj5y1gwSUmPYQ
	 jfXAZIEAbh1/YcajBBXy8xBIlD8oWYyghEauWovfIT6l4N3dclav/sQ0WI5nS59Yfv
	 9QA9U+hJJRSKm+wDqyjEVyV7ovbp7Hu1CijD+/G44j3JxxtoNEiJkDDggRiWyVl6MR
	 i4txtyA8kh8ArzEFkP8A8xODRItg7h2W/gjMQ/r/C7QRBDX7XQlDsyheHaCQfND/+R
	 t6dOILwOOGxzo2yIxnrLWQXo/PTb03HSwSDvZdGHQky1IS8kT8NdfuUg8uR0aA0lFy
	 6Wu1qlwlBp5SQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7C8C28B30;
	Thu, 20 Mar 2025 19:28:28 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Thu, 20 Mar 2025 20:28:23 +0100
Subject: [PATCH] initrd: support erofs as initrd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
X-B4-Tracking: v=1; b=H4sIAFZs3GcC/x3MTQqAIBBA4avIrBPM0H6uEi1Cx5qNxhgRiHdPW
 n6L9wpkZMIMiyjA+FCmFBv6ToA793igJN8MWmmjBq0kRbrZS+QUshwtztoEH+zkoCUXY6D3361
 brR+PanHjXgAAAA==
X-Change-ID: 20250320-initrd-erofs-76e925fdf68c
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742498907; l=2366;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=BUYkfXvGRCCRkCmYxAvEbgWOurQPuzo1uS6OSJk5+3k=;
 b=Mk1jtb+JY2aUM8xqHbUFACnyzukucXfSGBBvDhBwvkFBoRCp91HLZZ6pKPzlf05wSG4VWpQlu
 aByHBVWECyeDT1y5hGEB87X8eMiRRUZXkQhuoqjxNo//TRDew7IjVA0
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Add erofs detection to the initrd mount code. This allows systems to
boot from an erofs-based initrd in the same way as they can boot from
a squashfs initrd.

Just as squashfs initrds, erofs images as initrds are a good option
for systems that are memory-constrained.

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 init/do_mounts_rd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa78c7b7828a78ab2fa3af3611bef3..7c3f8b45b5ed2eea3c534d7f2e65608542009df5 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -11,6 +11,7 @@
 
 #include "do_mounts.h"
 #include "../fs/squashfs/squashfs_fs.h"
+#include "../fs/erofs/erofs_fs.h"
 
 #include <linux/decompress/generic.h>
 
@@ -47,6 +48,7 @@ static int __init crd_load(decompress_fn deco);
  *	romfs
  *	cramfs
  *	squashfs
+ *	erofs
  *	gzip
  *	bzip2
  *	lzma
@@ -63,6 +65,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	struct romfs_super_block *romfsb;
 	struct cramfs_super *cramfsb;
 	struct squashfs_super_block *squashfsb;
+	struct erofs_super_block *erofsb;
 	int nblocks = -1;
 	unsigned char *buf;
 	const char *compress_name;
@@ -77,6 +80,7 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 	romfsb = (struct romfs_super_block *) buf;
 	cramfsb = (struct cramfs_super *) buf;
 	squashfsb = (struct squashfs_super_block *) buf;
+	erofsb = (struct erofs_super_block *) buf;
 	memset(buf, 0xe5, size);
 
 	/*
@@ -165,6 +169,21 @@ identify_ramdisk_image(struct file *file, loff_t pos,
 		goto done;
 	}
 
+	/* Try erofs */
+	pos = (start_block * BLOCK_SIZE) + EROFS_SUPER_OFFSET;
+	kernel_read(file, buf, size, &pos);
+
+	if (erofsb->magic == EROFS_SUPER_MAGIC_V1) {
+		printk(KERN_NOTICE
+		       "RAMDISK: erofs filesystem found at block %d\n",
+		       start_block);
+
+		nblocks = ((erofsb->blocks << erofsb->blkszbits) + BLOCK_SIZE - 1)
+			>> BLOCK_SIZE_BITS;
+
+		goto done;
+	}
+
 	printk(KERN_NOTICE
 	       "RAMDISK: Couldn't find valid RAM disk image starting at %d.\n",
 	       start_block);

---
base-commit: 5fc31936081919a8572a3d644f3fbb258038f337
change-id: 20250320-initrd-erofs-76e925fdf68c

Best regards,
-- 
Julian Stecklina <julian.stecklina@cyberus-technology.de>



