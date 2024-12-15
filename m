Return-Path: <linux-fsdevel+bounces-37444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867769F2577
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 19:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B016316482D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40D1BCA11;
	Sun, 15 Dec 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFNIkygx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90E1BB6BC
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289104; cv=none; b=vGorFU2k0N8ox3afUs7Nr+ZZLwHnu2JIzeGN4CVYA9/3egxqHDzZE1RgNGvFXxCpO/EPGUwQ82ebjKd2pXAMpdvidAVYcHBQzDKRts9WW2AkP5iGEGWuVzE1KBZFw0aVR+Hqf8knID5GxjtJNGPHOF5FbG/8b9oRd8G6E1wNi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289104; c=relaxed/simple;
	bh=Tq/R8xawPLnGo8zVwtB0/wJRvW6e6MlVfxOtKQzQZB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJBhwf2/GiOE7zgttK1Vn7/cHbunMHC2ETirIIxxOjTwHKP1UjqbquNUFUxFLKgFyLPmOvzSHmxRnrB8c+AQPDyJ44Q0IlejZDvNxGHrPym8vKaxxLgK35Awn31N3SMxhUy8pHxsPrC94q/MG+H2CAoTEWGpY3aa1gx9GzSUczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFNIkygx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B3AC4CEDD;
	Sun, 15 Dec 2024 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734289104;
	bh=Tq/R8xawPLnGo8zVwtB0/wJRvW6e6MlVfxOtKQzQZB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFNIkygxYg9NNwhU5zG2gWvQ5bGYpwy0Q4sSDv94OIAKu0Zzn6kHknu10sOtrBnPF
	 bcv3Z58YLBc0XHfJUNBHPIXXbuSHCc82SIN2ugR5NEaoivReeP+HFz+oeUpMpKJnoo
	 9eTOdX2fDuQ3SzqU0IeI4lfY4cukyYUFDFGqdBYRDXZsDabXj+ALcbOD6PwA0ObMdQ
	 NjrkEf7rJrQARagY2MyMnIdzFTQ9najo79jQhN/Swb8v02DaKvUVJm8W6pBldI83j2
	 i9BgRNXB86h8PVQJzlW88rEyHX+AWQG8bl5SHkg/Dr/5n472H+1f5mv2+vHWGJ0/r7
	 a4YEOykfeIWaw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 4/5] libfs: Replace simple_offset end-of-directory detection
Date: Sun, 15 Dec 2024 13:58:15 -0500
Message-ID: <20241215185816.1826975-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241215185816.1826975-1-cel@kernel.org>
References: <20241215185816.1826975-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

According to getdents(3), the d_off field in each returned directory
entry points to the next entry in the directory. The d_off field in
the last returned entry in the readdir buffer must contain a valid
offset value, but if it points to an actual directory entry, then
readdir/getdents can loop.

This patch introduces a specific fixed offset value that is placed
in the d_off field of the last entry in a directory. Some user space
applications assume that the EOD offset value is larger than the
offsets of real directory entries, so the largest possible offset
value is reserved for this purpose. This new value is never
allocated by simple_offset_add().

When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
value into the d_off field of the last valid entry in the readdir
buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
offset value so the last entry is updated to point to the EOD marker.

When trying to read the entry at the EOD offset, offset_readdir()
terminates immediately.

It is worth noting that using a Maple tree for directory offset
value allocation does not guarantee a 63-bit range of values --
on platforms where "long" is a 32-bit type, the directory offset
value range is still 0..(2^31 - 1).

Fixes: 796432efab1e ("libfs: getdents() should return 0 after reaching EOD")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index fdf6ba305112..00dfcfa97edf 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -245,9 +245,16 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+/* simple_offset_add() allocation range */
 enum {
-	DIR_OFFSET_MIN	= 2,
+	DIR_OFFSET_MIN		= 2,
+	DIR_OFFSET_MAX		= LONG_MAX - 1,
+};
+
+/* simple_offset_add() never assigns these to a dentry */
+enum {
+	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
+
 };
 
 static void offset_set(struct dentry *dentry, long offset)
@@ -291,7 +298,8 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 		return -EBUSY;
 
 	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
-				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
+				 DIR_OFFSET_MAX, &octx->next_offset,
+				 GFP_KERNEL);
 	if (unlikely(ret == -EBUSY))
 		return -ENOSPC;
 	if (unlikely(ret < 0))
@@ -449,8 +457,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 		return -EINVAL;
 	}
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -460,7 +466,7 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 	struct dentry *child, *found = NULL;
 
 	rcu_read_lock();
-	child = mas_find(&mas, LONG_MAX);
+	child = mas_find(&mas, DIR_OFFSET_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -481,7 +487,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -489,7 +495,7 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
-			return ERR_PTR(-ENOENT);
+			goto out_eod;
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -499,7 +505,10 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
-	return NULL;
+	return;
+
+out_eod:
+	ctx->pos = DIR_OFFSET_EOD;
 }
 
 /**
@@ -519,6 +528,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
  *
  * On return, @ctx->pos contains an offset that will read the next entry
  * in this directory when offset_readdir() is called again with @ctx.
+ * Caller places this value in the d_off field of the last entry in the
+ * user's buffer.
  *
  * Return values:
  *   %0 - Complete
@@ -531,13 +542,8 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == DIR_OFFSET_MIN)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	if (ctx->pos != DIR_OFFSET_EOD)
+		offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 
-- 
2.47.0


