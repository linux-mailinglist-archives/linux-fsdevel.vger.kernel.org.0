Return-Path: <linux-fsdevel+bounces-3123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB27F028D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 20:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53778B209FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692C01DFF7;
	Sat, 18 Nov 2023 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axpIjEbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7AC1DA2C
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 19:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BB3C433CD;
	Sat, 18 Nov 2023 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700336000;
	bh=2u8efAeqRkdyYk6OGbAngLt3+NDkDGes87T6oIEMH54=;
	h=Subject:From:To:Cc:Date:From;
	b=axpIjEbffsfxZpVPTIDOskxwgtVAtFbd7tdF2QGFwzvfn8PmN9gqpIALDOS7dzJYh
	 wm74p+fSgyXJhQHd94pfMkB7+FHqHe5b5YBX9NO7L56D/21TS5xyru0qNCMJASLJ+0
	 XO6mam8c7fIkLMkWAuDa/vbZZQ44ytmuEI5oy/0JPoffyCdipFgwJ5Wi9FBJA02Vmv
	 KKkdXtkN+KnW2qp8uURYYaS8W0tFipP1VRPnHv6HcqlhWfZhNq0r2Us7gaT1yzV6Xi
	 Apb/d33CvlTJ6ku25DMBqmXPQMEqIU92GhnUNgjBjKZJfJf42O1SFkXwpuIWHamNCS
	 aeZgOjKLrD5Dg==
Subject: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
From: Chuck Lever <cel@kernel.org>
To: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
 jlayton@redhat.com, viro@zeniv.linux.org.uk
Cc: Tavian Barnes <tavianator@tavianator.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Date: Sat, 18 Nov 2023 14:33:19 -0500
Message-ID: 
 <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
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
 fs/libfs.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

This patch passes Tavian's reproducer. fstests over NFS shows no
regression. However, generic/676 fails when running directly against
a tmpfs mount:

     QA output created by 676
    -All tests passed
    +Unexpected EOF while reading dir.

I will look into that.

Changes since v2:
- Go back to marking EOD in file->private_data (with a comment)

Changes since RFC:
- Keep file->private_data stable while directory descriptor remains open


diff --git a/fs/libfs.c b/fs/libfs.c
index e9440d55073c..851e29fdd7e7 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -428,7 +428,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
@@ -437,7 +437,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			break;
+			return ERR_PTR(-ENOENT);
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -447,6 +447,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
+	return NULL;
 }
 
 /**
@@ -479,7 +480,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
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
 



