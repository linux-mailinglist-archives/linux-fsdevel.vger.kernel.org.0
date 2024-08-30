Return-Path: <linux-fsdevel+bounces-28033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8701B966291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DC01F23ECA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD511B2ED5;
	Fri, 30 Aug 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poEiIK4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C321B2EC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023166; cv=none; b=Vm+TYNnfTrN5WoZIDX84GGVED5LSPoLZhz43yBkmYQOgyDHVPWOqWFgY+wcJwVsO3RW7OpkKnlgsbGLdAY7M+mGhKlZNoMhscclMVo+kVXNUfPhmFWqg1Laa5ivMaf+0kl87CX591yVgWszxK4aD/TKT3DT2fuA9+ASXjscfuUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023166; c=relaxed/simple;
	bh=XwzYRfekCC2N/I6St2Xy5oSr+ska1W6v2XklXWJHBb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N64agHLM14SSmfJgzxWZ46NxmZuBXGvmLHbezz44KSu/jDpqBykGZP6kR4g1jcLjjVHnIrl5e0LmB7xBbux+IR8cZ7SN5IpCfvbLJWxDGT1ZoUgZEz6oDrTYwOuZSk1Js9RaRI50IeoKKN85/trjLEcWu+Pg4HFcPzTqVgRx+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poEiIK4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40311C4CEC5;
	Fri, 30 Aug 2024 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023166;
	bh=XwzYRfekCC2N/I6St2Xy5oSr+ska1W6v2XklXWJHBb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=poEiIK4noC3bfw1uigkkucduH4mRPxhqJd3IH4UosWkQcZ3cFOlQ1rks8JbqlLXnK
	 8NjlcxA7zVYcH/kLjAKfe0yhowrAxps8fBi2op2SOi3CYAoYCY7hp1ja87FleF8tUC
	 XMVzOi6oLbTZs99tkpU9Xd8DfgYBMHRqzIkTMHUxxbj3TsSr0DaECT1trn+gUYtxal
	 Sb1Okr/CK5MRzNwg+0cB3heBgGjFLU5HlrKATM2AzTftEtrTDqDXdRMXUqoVGLtaOk
	 UicqK9BHQ6C4af90aqDeeMoLAc6aB3sCqkTGhHkDK0elEhx/F/iMrZAoJtsWzp2/yA
	 q7bBjQB9XZllw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Aug 2024 15:04:52 +0200
Subject: [PATCH RFC 11/20] ext4: store cookie in private data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-vfs-file-f_version-v1-11-6d3e4816aa7b@kernel.org>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
In-Reply-To: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=6123; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XwzYRfekCC2N/I6St2Xy5oSr+ska1W6v2XklXWJHBb0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDxngzSn0il550v31+dJqVZKsS26/3wqa0bBseISO
 92Qz6saOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayIo+R4e2rPrf6VftMqloU
 +8N97+5dUB59fNXL0CnVyW+d5zEm8zIy3NUsnHcstfNvuO8fwY8Gr5l/Jn//y2ax7e30DR9TtnJ
 H8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Store the cookie to detect concurrent seeks on directories in
file->private_data.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/dir.c    | 50 ++++++++++++++++++++++++++++----------------------
 fs/ext4/ext4.h   |  2 ++
 fs/ext4/inline.c |  7 ++++---
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ff4514e4626b..13196afe55ce 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -133,6 +133,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
+	struct dir_private_info *info = file->private_data;
 
 	err = fscrypt_prepare_readdir(inode);
 	if (err)
@@ -229,7 +230,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
-		if (!inode_eq_iversion(inode, file->f_version)) {
+		if (!inode_eq_iversion(inode, info->cookie)) {
 			for (i = 0; i < sb->s_blocksize && i < offset; ) {
 				de = (struct ext4_dir_entry_2 *)
 					(bh->b_data + i);
@@ -249,7 +250,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			offset = i;
 			ctx->pos = (ctx->pos & ~(sb->s_blocksize - 1))
 				| offset;
-			file->f_version = inode_query_iversion(inode);
+			info->cookie = inode_query_iversion(inode);
 		}
 
 		while (ctx->pos < inode->i_size
@@ -384,6 +385,7 @@ static inline loff_t ext4_get_htree_eof(struct file *filp)
 static loff_t ext4_dir_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct dir_private_info *info = file->private_data;
 	int dx_dir = is_dx_dir(inode);
 	loff_t ret, htree_max = ext4_get_htree_eof(file);
 
@@ -392,7 +394,7 @@ static loff_t ext4_dir_llseek(struct file *file, loff_t offset, int whence)
 						    htree_max, htree_max);
 	else
 		ret = ext4_llseek(file, offset, whence);
-	file->f_version = inode_peek_iversion(inode) - 1;
+	info->cookie = inode_peek_iversion(inode) - 1;
 	return ret;
 }
 
@@ -429,18 +431,15 @@ static void free_rb_tree_fname(struct rb_root *root)
 	*root = RB_ROOT;
 }
 
-
-static struct dir_private_info *ext4_htree_create_dir_info(struct file *filp,
-							   loff_t pos)
+static void ext4_htree_init_dir_info(struct file *filp, loff_t pos)
 {
-	struct dir_private_info *p;
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return NULL;
-	p->curr_hash = pos2maj_hash(filp, pos);
-	p->curr_minor_hash = pos2min_hash(filp, pos);
-	return p;
+	struct dir_private_info *p = filp->private_data;
+
+	if (is_dx_dir(file_inode(filp)) && !p->initialized) {
+		p->curr_hash = pos2maj_hash(filp, pos);
+		p->curr_minor_hash = pos2min_hash(filp, pos);
+		p->initialized = true;
+	}
 }
 
 void ext4_htree_free_dir_info(struct dir_private_info *p)
@@ -552,12 +551,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 	struct fname *fname;
 	int ret = 0;
 
-	if (!info) {
-		info = ext4_htree_create_dir_info(file, ctx->pos);
-		if (!info)
-			return -ENOMEM;
-		file->private_data = info;
-	}
+	ext4_htree_init_dir_info(file, ctx->pos);
 
 	if (ctx->pos == ext4_get_htree_eof(file))
 		return 0;	/* EOF */
@@ -590,10 +584,10 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 		 * cached entries.
 		 */
 		if ((!info->curr_node) ||
-		    !inode_eq_iversion(inode, file->f_version)) {
+		    !inode_eq_iversion(inode, info->cookie)) {
 			info->curr_node = NULL;
 			free_rb_tree_fname(&info->root);
-			file->f_version = inode_query_iversion(inode);
+			info->cookie = inode_query_iversion(inode);
 			ret = ext4_htree_fill_tree(file, info->curr_hash,
 						   info->curr_minor_hash,
 						   &info->next_hash);
@@ -664,7 +658,19 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
 	return 0;
 }
 
+static int ext4_dir_open(struct inode *inode, struct file *file)
+{
+	struct dir_private_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	file->private_data = info;
+	return 0;
+}
+
 const struct file_operations ext4_dir_operations = {
+	.open		= ext4_dir_open,
 	.llseek		= ext4_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= ext4_readdir,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261e..d62a4b9b26ce 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2553,6 +2553,8 @@ struct dir_private_info {
 	__u32		curr_hash;
 	__u32		curr_minor_hash;
 	__u32		next_hash;
+	u64		cookie;
+	bool		initialized;
 };
 
 /* calculate the first block number of the group */
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e7a09a99837b..4282e12dc405 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1460,6 +1460,7 @@ int ext4_read_inline_dir(struct file *file,
 	struct ext4_iloc iloc;
 	void *dir_buf = NULL;
 	int dotdot_offset, dotdot_size, extra_offset, extra_size;
+	struct dir_private_info *info = file->private_data;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -1503,12 +1504,12 @@ int ext4_read_inline_dir(struct file *file,
 	extra_size = extra_offset + inline_size;
 
 	/*
-	 * If the version has changed since the last call to
+	 * If the cookie has changed since the last call to
 	 * readdir(2), then we might be pointing to an invalid
 	 * dirent right now.  Scan from the start of the inline
 	 * dir to make sure.
 	 */
-	if (!inode_eq_iversion(inode, file->f_version)) {
+	if (!inode_eq_iversion(inode, info->cookie)) {
 		for (i = 0; i < extra_size && i < offset;) {
 			/*
 			 * "." is with offset 0 and
@@ -1540,7 +1541,7 @@ int ext4_read_inline_dir(struct file *file,
 		}
 		offset = i;
 		ctx->pos = offset;
-		file->f_version = inode_query_iversion(inode);
+		info->cookie = inode_query_iversion(inode);
 	}
 
 	while (ctx->pos < extra_size) {

-- 
2.45.2


