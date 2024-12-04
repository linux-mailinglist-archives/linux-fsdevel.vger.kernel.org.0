Return-Path: <linux-fsdevel+bounces-36484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930A9E3F4E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311B0B37385
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A320CCF0;
	Wed,  4 Dec 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzTVy/46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C620C480
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327587; cv=none; b=ux0vmCkzvmssOFutz5ngX7BApYWRfQ/QDMuP3owUe4lhFfgkHJDTg9OEtn+yNNWLVFRZUGeZLfrlY/i1WH97CDP7PBvZMy8ZB1I7N+GbRA0b6yIgEFupVgZpEfkg2JjccpKpfRWEZZWN8gwE1Ts85242tSkUCb72NMc9HlEX1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327587; c=relaxed/simple;
	bh=TsKe5WX9BiwgOVGJ1aGUhOHwVeN/D0/6ISUO68pxyBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCSkeoL0pmv2M1yz6QUvpYUYOr3qm95/Re0xiIBh9zX+Bqu0LoHuWdOJJSkDTc8Nzr8bI+7L6hhdWVtRioGcwsmIw3GLPler6vi6jdciwN1g7LYxUU1AoJvVZiLU/i8ZECCPKHhw3HwvvulndGdUOIu2WEgJQ257t140n3XjIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzTVy/46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC74C4CEDD;
	Wed,  4 Dec 2024 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327585;
	bh=TsKe5WX9BiwgOVGJ1aGUhOHwVeN/D0/6ISUO68pxyBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzTVy/46mX0vtQ9cmM5USXoMMooJ1KLKQZkpf3oLyao/4qdPVY/7rtwZenbA2YDAY
	 cX3TmG1nK4kY/xoSzqinYQ6TuE15iSm3PgFaFd0TNCbvFlErHAnNUQC5+da3lQvmR5
	 ANPRdGieOzXdv0BbgQU2g2rLaaccGk3PzVKuP203sRD9qmkuQiU4WNeU3goWstnVW+
	 1TxqyAkImDkfOZa3eYwK6CROcOsupgBrH1o626gO/rs2rN3a4qF2fO0y3F0RaIE0SH
	 +A4IeFU6F/XXfj70g/EzeqRNer66Ue79gfyuW1Cs2vIFg0B/H1l6X2ovepb5Yb1eJC
	 Vn3ikyW1bNE6A==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 3/5] Revert "libfs: fix infinite directory reads for offset dir"
Date: Wed,  4 Dec 2024 10:52:54 -0500
Message-ID: <20241204155257.1110338-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
References: <20241204155257.1110338-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The current directory offset allocator (based on mtree_alloc_cyclic)
stores the next offset value to return in octx->next_offset. This
mechanism typically returns values that increase monotonically over
time. Eventually, though, the newly allocated offset value wraps
back to a low number (say, 2) which is smaller than other already-
allocated offset values.

Yu Kuai <yukuai3@huawei.com> reports that, after commit 64a7ce76fb90
("libfs: fix infinite directory reads for offset dir"), if a
directory's offset allocator wraps, existing entries are no longer
visible via readdir/getdents because offset_readdir() stops listing
entries once an entry's offset is larger than octx->next_offset.
These entries vanish persistently -- they can be looked up, but will
never again appear in readdir(3) output.

The reason for this is that the commit treats directory offsets as
monotonically increasing integer values rather than opaque cookies,
and introduces this comparison:

	if (dentry2offset(dentry) >= last_index) {

On 64-bit platforms, the directory offset value upper bound is
2^63 - 1. Directory offsets will monotonically increase for millions
of years without wrapping.

On 32-bit platforms, however, LONG_MAX is 2^31 - 1. The allocator
can wrap after only a few weeks (at worst).

Revert commit 64a7ce76fb90 ("libfs: fix infinite directory reads for
offset dir") to prepare for a fix that can work properly on 32-bit
systems and might apply to recent LTS kernels where shmem employs
the simple_offset mechanism.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index b668a4f5bbc9..461384fb6119 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -420,14 +420,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
 }
 
-static int offset_dir_open(struct inode *inode, struct file *file)
-{
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
-	file->private_data = (void *)ctx->next_offset;
-	return 0;
-}
-
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -441,9 +433,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -457,8 +446,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
+	file->private_data = NULL;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -489,7 +477,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -497,21 +485,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
-			return;
-
-		if (dentry2offset(dentry) >= last_index) {
-			dput(dentry);
-			return;
-		}
+			return ERR_PTR(-ENOENT);
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
-			return;
+			break;
 		}
 
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
+	return NULL;
 }
 
 /**
@@ -538,19 +522,22 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dir = file->f_path.dentry;
-	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(d_inode(dir), ctx, last_index);
+	/* In this case, ->private_data is protected by f_pos_lock */
+	if (ctx->pos == DIR_OFFSET_MIN)
+		file->private_data = NULL;
+	else if (file->private_data == ERR_PTR(-ENOENT))
+		return 0;
+	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
-	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.47.0


