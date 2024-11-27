Return-Path: <linux-fsdevel+bounces-36016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A351C9DAABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E225F1679C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0707200125;
	Wed, 27 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUF1FZnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2E20011B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721302; cv=none; b=OYnH3CPUKxoM49gG3F6x34VbYYS8nXTg2vyvJgC1yDmQ7k71DqqrS2qwuZ5LWoPyedvQP/fvmcGBMTdsygI5POmZqH2/UFWhYxIC3croLxJLtWJ4blJ9heRWIAa1Td2hLwiPZxMtAhOu8drnK5rtIjnvbLLkSnEsEgXGZwstUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721302; c=relaxed/simple;
	bh=VKlx/q6S0TZnqYbdlXcPYo2H5Z6zTd8jSftplsjeB2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4zHyh9icMGdCE5ZJ9rpOG9e4f+03eR21buHlJT2iI/6pKFS/2LtXKcFQjl97whuWRJcd6OVKC9yvBwMWSZd+A2OdqSDIVuT5c/asHCJNXyfBUfRZ3u8vXUPhPIgwM+yWWoXRtShjkz6XPmOMgaB341dzlWMx+FiN9p7cySxDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUF1FZnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F9C4CED4;
	Wed, 27 Nov 2024 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721302;
	bh=VKlx/q6S0TZnqYbdlXcPYo2H5Z6zTd8jSftplsjeB2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUF1FZnEbEpTpG79Oe/YjbbeeVfCsXJ/5xBFkexLOTBtxQVGlfx9MOJwh3G2/j/by
	 UYpk2NVmI1OKMIJ7nv+n3tQnlk0qayYy4skYlF6AfnIk+FcSfxCKxwyse3Z2xLthro
	 ljQctQEOJeORXjPDZnfmr7M2dgXbM0vocnmmVjq9ZueoUhhpTxPrY+f2lgZ9nUVTiy
	 1Df+8URO5rh2kPGypKBxQ5BMX6PiCCd4sMyxsMgQuHFJGZwkvZjvzY8AINLKwTQs/c
	 DhXZdZysUC89taQn6jHsQa7UAL0gArN4EXazDKH6Q2UlEvpLDn71hi2vxH8QyVXmL8
	 4VrymohnnAQbQ==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 3/5] Revert "libfs: fix infinite directory reads for offset dir"
Date: Wed, 27 Nov 2024 10:28:13 -0500
Message-ID: <20241127152815.151781-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127152815.151781-1-cel@kernel.org>
References: <20241127152815.151781-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Using octx->next_offset to determine the newest entries works only
because the offset value range is 63-bits. If an offset were to
wrap, existing entries are no longer visible to readdir because
offset_readdir() stops listing entries once an entry's offset is
larger than octx->next_offset.

This fix is effective, but it would be better not to use next_offset
at all when iterating a directory. Revert this fix to prepare for
replacing the current offset_readdir() mechanism. Reverting also
makes it easier to apply the replacement code to v6.6.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f686336489a3..a673427d3416 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -449,14 +449,6 @@ void simple_offset_destroy(struct offset_ctx *octx)
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
@@ -470,9 +462,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
-	struct inode *inode = file->f_inode;
-	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
-
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -486,8 +475,7 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (!offset)
-		file->private_data = (void *)ctx->next_offset;
+	file->private_data = NULL;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -518,7 +506,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -526,21 +514,17 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
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
@@ -567,19 +551,22 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
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


