Return-Path: <linux-fsdevel+bounces-3173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7FF7F09E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83E7B207E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003D1B268;
	Sun, 19 Nov 2023 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl5mBXt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF019BAE
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 23:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40F1C433C7;
	Sun, 19 Nov 2023 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700438179;
	bh=EtcwSMC+2X05pmB2XZm956sPJJv7BwUf2YkTNGJ38Es=;
	h=Subject:From:To:Cc:Date:From;
	b=Tl5mBXt2ZuhV2UXwJohYFa4npkQ+9I5tbjkfwdfH7ZTJ1VCuqFsw/kcXAtvycd3V2
	 VtuJhnRWC9unIUrLGgxnyYKsxm73qr7pHT0owU3mJQxvpq1FdB47XEnyzWSchCP+F2
	 c/XEP6NTBesnOquzS8lEktnLsAEF82RJnVMuK66IajcziI6+HUSqvwifKdYqkiW+8W
	 NE5NLiHEElKQl9VBLnpvFi8kWc9SfU+XHK9ABP7MXYKxqj1i2J3chZnPlbEcSXuYd0
	 uLwSDQksIE7JqLL/N/esjX4GFxBB01baK+ld2lemvJx8Xtrh6NBglTSLo122A71Zv1
	 EivHA2HNbM16w==
Subject: [PATCH v4] libfs: getdents() should return 0 after reaching EOD
From: Chuck Lever <cel@kernel.org>
To: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
 jlayton@redhat.com, viro@zeniv.linux.org.uk
Cc: Tavian Barnes <tavianator@tavianator.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Date: Sun, 19 Nov 2023 18:56:17 -0500
Message-ID: 
 <170043792492.4628.15646203084646716134.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

The new directory offset helpers don't conform with the convention
of getdents() returning no more entries once a directory file
descriptor has reached the current end-of-directory.

To address this, copy the logic from dcache_readdir() to mark the
open directory file descriptor once EOD has been reached. Seeking
resets the mark.

Reported-by: Tavian Barnes <tavianator@tavianator.com>
Closes: https://lore.kernel.org/linux-fsdevel/20231113180616.2831430-1-tavianator@tavianator.com/
Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

v4 of this patch passes Tavian's reproducer and fstests over NFS and
directly on a tmpfs mount.

Changes since v3:
- Ensure that llseek() resets the EOD mark too

Changes since v2:
- Go back to marking EOD in the file->private_data field

Changes since RFC:
- Keep file->private_data stable while directory descriptor remains open

diff --git a/fs/libfs.c b/fs/libfs.c
index e9440d55073c..c2aa6fd4795c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -399,6 +399,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 		return -EINVAL;
 	}
 
+	/* In this case, ->private_data is protected by f_pos_lock */
+	file->private_data = NULL;
 	return vfs_setpos(file, offset, U32_MAX);
 }
 
@@ -428,7 +430,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
@@ -437,7 +439,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			break;
+			return ERR_PTR(-ENOENT);
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -447,6 +449,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
+	return NULL;
 }
 
 /**
@@ -479,7 +482,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(d_inode(dir), ctx);
+	/* In this case, ->private_data is protected by f_pos_lock */
+	if (ctx->pos == 2)
+		file->private_data = NULL;
+	else if (file->private_data == ERR_PTR(-ENOENT))
+		return 0;
+	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 



