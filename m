Return-Path: <linux-fsdevel+bounces-2840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03C7EB421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A11C20A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAA41774;
	Tue, 14 Nov 2023 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhllcM9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9B4176E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B326C433C7;
	Tue, 14 Nov 2023 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699976978;
	bh=PC0cKjpERz+TagjktWu/EvkBPPwibYdZVz71N3b40es=;
	h=Subject:From:To:Cc:Date:From;
	b=QhllcM9AnKqvPK+R7o97c/OhW+5zpebK4evChLwxYbgcP7RF33rQC28z7WVqv8AZJ
	 kzKU43x/vg/xiOIWyem4E6plvGy73CGFALZs6EexOprewWKzXPjySk/kx+doNMPwVx
	 tJ62tm0kdvSu94uUzpChpDJ4HXpYhplYqqrrKXCNUQHoaUydHlW92HrrcxSEb+A3uq
	 5w8KPAhJo+ZU+n5H9d8+LHGWmExhAMZJXQMeHv8vXURxB+98L5y0+H+BfO150O/q/r
	 BKhGm7hDlLjL4SBwwJM1quL8rsdEerbhHZ4E11aSLRWKAFcUOW/U9lw9VNvlh+O1jl
	 ZepgcH5dLy7Ig==
Subject: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
From: Chuck Lever <cel@kernel.org>
To: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
 jlayton@redhat.com, viro@zeniv.linux.org.uk
Cc: Tavian Barnes <tavianator@tavianator.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Date: Tue, 14 Nov 2023 10:49:37 -0500
Message-ID: 
 <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
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
 fs/libfs.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index e9440d55073c..1c866b087f0c 100644
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
@@ -437,7 +437,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			break;
+			/* readdir has reached the current EOD */
+			return (void *)0x10;
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -447,6 +448,7 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
+	return NULL;
 }
 
 /**
@@ -479,7 +481,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(d_inode(dir), ctx);
+	if (ctx->pos == 2)
+		file->private_data = NULL;
+	else if (file->private_data == (void *)0x10)
+		return 0;
+
+	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 



