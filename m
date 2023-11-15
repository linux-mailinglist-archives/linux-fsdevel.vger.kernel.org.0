Return-Path: <linux-fsdevel+bounces-2918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817957ED1EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89771C2094A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A50433C4;
	Wed, 15 Nov 2023 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRWJNFfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E0433BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 20:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A665C433C8;
	Wed, 15 Nov 2023 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700079774;
	bh=lzWdHL95vklKr9aA+uM9xzDRXnQaZXwtYaUbQTqi7aA=;
	h=Subject:From:To:Cc:Date:From;
	b=dRWJNFfgA9LJs/tMIfQosa2ubKY4wfJUTkQ999MakUB0dGfzcDMPAUmvqQ90dSd7+
	 e2LF7iyNQoJBPuW68dp5U2VcOd0PUo+dNAQSu+mepjRK+gzeP5CbpMoWE/T2wQ/aLR
	 JFSV16QE7se6MS52J60QbGfLTjQkyPU1fa+6BKJ3f1sXmPNEgiqQTyLzhXTQLPlEQY
	 6kOsA4afWIFjBdrjT0Jb+NLUZRB7UpOYfVMJMjx5IDoFCwiq4IENCrD6hPC60E1wVl
	 ELa9qYGqRYcqEQBxv4iVEU23yTtdO73o8pdFwHjfA8Q+4WokH1Iyj8cBAlspj97ODN
	 PTCXGMFPbv0lA==
Subject: [PATCH v2] libfs: getdents() should return 0 after reaching EOD
From: Chuck Lever <cel@kernel.org>
To: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
 jlayton@redhat.com, viro@zeniv.linux.org.uk
Cc: Tavian Barnes <tavianator@tavianator.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 15 Nov 2023 15:22:52 -0500
Message-ID: 
 <170007970281.4975.12356401645395490640.stgit@bazille.1015granger.net>
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
open directory file descriptor once EOD has been reached. Rewinding
resets the mark.

Reported-by: Tavian Barnes <tavianator@tavianator.com>
Closes: https://lore.kernel.org/linux-fsdevel/20231113180616.2831430-1-tavianator@tavianator.com/
Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c             |   16 +++++++++++++---
 include/linux/dcache.h |    1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

Changes since RFC:
- Keep file->private_data stable while directory descriptor remains open


diff --git a/fs/libfs.c b/fs/libfs.c
index e9440d55073c..d4df19b1b666 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -428,7 +428,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static bool offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
@@ -437,7 +437,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			break;
+			return true;
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -447,6 +447,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
+	return false;
 }
 
 /**
@@ -472,6 +473,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
  */
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
+	struct dentry *cursor = file->private_data;
 	struct dentry *dir = file->f_path.dentry;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
@@ -479,11 +481,19 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(d_inode(dir), ctx);
+	if (ctx->pos == 2)
+		cursor->d_flags &= ~DCACHE_EOD;
+	else if (cursor->d_flags & DCACHE_EOD)
+		return 0;
+
+	if (offset_iterate_dir(d_inode(dir), ctx))
+		cursor->d_flags |= DCACHE_EOD;
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..ee1757001583 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -208,6 +208,7 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			0x04000000
+#define DCACHE_EOD			0x08000000 /* Reached end-of-directory */
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000



