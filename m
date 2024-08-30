Return-Path: <linux-fsdevel+bounces-28031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287A96628F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70CB1F24011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806EE1B29CD;
	Fri, 30 Aug 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeGf1sej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0B1B252D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023161; cv=none; b=XYrqfq4uKcIYXZO1JzHjRMgevxRzmdMv7/gSI25z3/B7Uy/c25zOu/n6KwTeDwHh/1GW1nrkjCZTAgB7Uyp6eCzdXuTSg/bxI8023+UgHATH7qEXfcX2/vPKF6nHLra16lMqYlngMc0yjn55ojRezTb57avWCUGuJU0rJ3wQP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023161; c=relaxed/simple;
	bh=UfPRvxuAGZjmkL5geC8XQuk8Sjo6h7iIyziW4E0fCug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtb8dpB0XE7EKomDQHT5tI09ErbGQGCCTz0FU3Fl0/HrqNRtJGaTZzr0aTdj4fjsRiyFztZ0FJpRjN8sqit39Yq/kq1VSzLUGkkKCUHdq18rmjJOw9PihgDKFdPCWGKmyDIMrE6h2RGBSjJBKSTkeFhj2kBrjuAzlde/fEBbDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeGf1sej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAACCC4CEC7;
	Fri, 30 Aug 2024 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023160;
	bh=UfPRvxuAGZjmkL5geC8XQuk8Sjo6h7iIyziW4E0fCug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eeGf1sejl0MMt8zH/Bsjx3QpuAOHIGUVF6Y+1M0QsN/Qz2bBWJ1pCWyhWZfa6etL9
	 5uEOguOWBZumvB1gQQjPPJo5gsgCMRbFchnZfZfDNGdKEa4aVJBU2z09RrTMFd8snN
	 pRjmaXMKdzXiMMfUUgYM3jcZM2+18lcnwjVE1VpEXQ6SULIYdDi630S3YPIjEpFwwP
	 by0DDjUarAuqc3bRe3TvpbhiqPkglm50OgFEfvT8NLcp8EMYdLM7In0sgyEahQGWzW
	 nFGfbPQVruSx0VtqRXptiO/49iYjFs6h2ZiFKaQuXd0mTLLldRmbOclbfYCkDHTHXr
	 rzCTZ5YhjqryA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:50 +0200
Subject: [PATCH RFC 09/20] affs: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-9-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UfPRvxuAGZjmkL5geC8XQuk8Sjo6h7iIyziW4E0fCug=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDzHxq9azm8KH/vnTbxcOxK5fG+v3MAZ0+7VdcDJN
 nb97g3MHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5c5uR4cGx+QXR1bsS98sx
 ntrsvqljzZ1r/Up/Ay6Z9skF2N5/E87IsGH35ANcq/8vjZQVOpLVpx5Q7t/kcfb1ryveMds9/Sb
 q8AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/affs/dir.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index b2bf7016e1b3..bd40d5f08810 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -17,13 +17,44 @@
 #include <linux/iversion.h>
 #include "affs.h"
 
+struct affs_dir_data {
+	unsigned long ino;
+	u64 cookie;
+};
+
 static int affs_readdir(struct file *, struct dir_context *);
 
+static loff_t affs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct affs_dir_data *data = file->private_data;
+
+	return generic_llseek_cookie(file, offset, whence, &data->cookie);
+}
+
+static int affs_dir_open(struct inode *inode, struct file *file)
+{
+	struct affs_dir_data	*data;
+
+	data = kzalloc(sizeof(struct affs_dir_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	file->private_data = data;
+	return 0;
+}
+
+static int affs_dir_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
 const struct file_operations affs_dir_operations = {
+	.open		= affs_dir_open,
 	.read		= generic_read_dir,
-	.llseek		= generic_file_llseek,
+	.llseek		= affs_dir_llseek,
 	.iterate_shared	= affs_readdir,
 	.fsync		= affs_file_fsync,
+	.release	= affs_dir_release,
 };
 
 /*
@@ -45,6 +76,7 @@ static int
 affs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode		*inode = file_inode(file);
+	struct affs_dir_data	*data = file->private_data;
 	struct super_block	*sb = inode->i_sb;
 	struct buffer_head	*dir_bh = NULL;
 	struct buffer_head	*fh_bh = NULL;
@@ -59,7 +91,7 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 	pr_debug("%s(ino=%lu,f_pos=%llx)\n", __func__, inode->i_ino, ctx->pos);
 
 	if (ctx->pos < 2) {
-		file->private_data = (void *)0;
+		data->ino = 0;
 		if (!dir_emit_dots(file, ctx))
 			return 0;
 	}
@@ -80,8 +112,8 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 	/* If the directory hasn't changed since the last call to readdir(),
 	 * we can jump directly to where we left off.
 	 */
-	ino = (u32)(long)file->private_data;
-	if (ino && inode_eq_iversion(inode, file->f_version)) {
+	ino = data->ino;
+	if (ino && inode_eq_iversion(inode, data->cookie)) {
 		pr_debug("readdir() left off=%d\n", ino);
 		goto inside;
 	}
@@ -131,8 +163,8 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 		} while (ino);
 	}
 done:
-	file->f_version = inode_query_iversion(inode);
-	file->private_data = (void *)(long)ino;
+	data->cookie = inode_query_iversion(inode);
+	data->ino = ino;
 	affs_brelse(fh_bh);
 
 out_brelse_dir:

-- 
2.45.2


