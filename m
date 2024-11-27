Return-Path: <linux-fsdevel+bounces-36017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628199DAAC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01104B21DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2C20012D;
	Wed, 27 Nov 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT08HImq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB33C488
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721303; cv=none; b=FZDRa6FYoAy2lroZ010Yhg9W675BjyzDUfRZGUcp8GiGZUOL4ywCYTDdBPOy4J+NKhrfL2hVzF7TGD/2dix2qRzxAKN+tAtwE3RhaOpvCnfHSRGcpdrqI+6VFOzCA4nmNYfnzHAbDL5Dx6KMcT3EE1tSgB5CHM1q45e/vtzaPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721303; c=relaxed/simple;
	bh=yaUgVsYqn/+UqS21Ay0PUdvP+2Ovp6VDQCczLqXNXYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJC7ZbltASyM3W7TaRf9ropjRrGaBxD+7rpJM/X0WeXyX7TWmkqSX6aI8UJTLpKh5qkplIWeyicHrSKA1w3ePrWNIzl3s7BXYqd17c/PQwzsw4xJdqYTNgR9bUrQxqGuZZR7rDjJEBZumB/vf1cBL1J47KgOaaDnH5RNVB0uuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT08HImq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A88EC4CED3;
	Wed, 27 Nov 2024 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721303;
	bh=yaUgVsYqn/+UqS21Ay0PUdvP+2Ovp6VDQCczLqXNXYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VT08HImqWvjHVpg0vUPPxkxWgmyqx6FPQSiQJRMNw0IopFVIATgz4coLvIXaQA5w+
	 HttmvTm9x2ggjv3ICKFLH2h80s+uaVVrnaMJSjwVnsR2/fYo0lVxOcpflRO32MDlHv
	 A22VX+RXRrBbmm3pQFuLEaAmcJDB4WsVuQQUMC2PBkwbOD/R2h8tkSbikpz8uryCiI
	 MAOIYikg4eQqyojGl+XUy2EA1W/0bAEc4kVDCJtU3EdmX6y+fDI28xs4E9sT8iNdKn
	 JfH0jERkX0EQp1goCDny+sYUW9vwUuytQPtbRZbr5myfCmnE/xuWTfyt5dnYfvMqJW
	 r9ZGIH9IRFzqQ==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 4/5] libfs: Refactor end-of-directory detection for simple_offset directories
Date: Wed, 27 Nov 2024 10:28:14 -0500
Message-ID: <20241127152815.151781-5-cel@kernel.org>
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

This mechanism seems have been misunderstood more than once. Make
the code more self-documentary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a673427d3416..0deff5390abb 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -449,6 +449,34 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
 }
 
+static void offset_set_eod(struct file *file)
+{
+	file->private_data = ERR_PTR(-ENOENT);
+}
+
+static void offset_clear_eod(struct file *file)
+{
+	file->private_data = NULL;
+}
+
+static bool offset_at_eod(struct file *file)
+{
+	return file->private_data == ERR_PTR(-ENOENT);
+}
+
+/**
+ * offset_dir_open - Open a directory descriptor
+ * @inode: directory to be opened
+ * @file: struct file to instantiate
+ *
+ * Returns zero on success, or a negative errno value.
+ */
+static int offset_dir_open(struct inode *inode, struct file *file)
+{
+	offset_clear_eod(file);
+	return 0;
+}
+
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -474,8 +502,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 		return -EINVAL;
 	}
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
+	/* ->private_data is protected by f_pos_lock */
+	offset_clear_eod(file);
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -506,15 +534,20 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
+	struct dentry *dir = file->f_path.dentry;
+	struct inode *inode = d_inode(dir);
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
 
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
-		if (!dentry)
-			return ERR_PTR(-ENOENT);
+		if (!dentry) {
+			/* ->private_data is protected by f_pos_lock */
+			offset_set_eod(file);
+			return;
+		}
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -524,7 +557,6 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
-	return NULL;
 }
 
 /**
@@ -557,16 +589,14 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == DIR_OFFSET_MIN)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	/* ->private_data is protected by f_pos_lock */
+	if (!offset_at_eod(file))
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
+	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.47.0


