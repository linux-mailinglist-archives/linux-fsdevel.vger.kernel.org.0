Return-Path: <linux-fsdevel+bounces-37950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D199F9583
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3208E188A50D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E2218E92;
	Fri, 20 Dec 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDsNQlbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93D219A83
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708803; cv=none; b=WQKxF6aYhnsFwdi8TAcOqC2EqQ7E11lByNRjOM/rFUCkCQK7p+wQ3ml9mjBbUXqhNAvW1K52/hjBBaq/aKJl50mqjUo0H3wNFTJ0ZfvUSE2CQRj5wE7adTtEIiwCDlATv5EXCrVrFIu9GOqVkKVM/gV9E0OsHEKvJo1vD75hlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708803; c=relaxed/simple;
	bh=psAnJLeu3hNfs59sG2ggPtKJEHtiA7mAWB4G4Xrk6tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ9iRr58l5DJAUO1ufjkn/vKezxkjIUc3DNNbHr1bEzC0d2tfGLuhwymJxrt+Lcr6a0ZOIDf5XVzDU80HliG1kFiyXaZ0xg+ft2Cte+dCYXlfBLvkZvCHrOHu27zFK5jRZpEWshMlzEjyQT4aBq3S23Y/nan7dXD8OZ8WsK2RmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDsNQlbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A0C4CED7;
	Fri, 20 Dec 2024 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734708803;
	bh=psAnJLeu3hNfs59sG2ggPtKJEHtiA7mAWB4G4Xrk6tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDsNQlbgHXeuReqCHgXioyS/pdHOy3vGgcJZ6fSGc9D/qnEjc0eOFQPfe+BuxoI8K
	 B2/lmZm1UCzAnbVKGIyiRccGs9V2Rhi6oAUdInqd8PB9bF0tX5vlTMmP/VT0U6uGz/
	 IG+2j9WlhYs4AIhpsAaCYHa4zdwa68C0PcsyeIJW+eIsx92hA3aGuj3S6LeWCDmJMI
	 x1fZ+2072BuqEj0WN/ZUHKPBECkawlGjckWWT31YVtMKaZEV+Zopts0zBRZcEf9F/H
	 8w9VxVd6M0CVDsCrn+/O/EPfgaXYTpjpXsri39GrSWgZksQs46QzD5XQzbt4o6YXeu
	 ZqZizLwzEsVmw==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 5/5] libfs: Use d_children list to iterate simple_offset directories
Date: Fri, 20 Dec 2024 10:33:14 -0500
Message-ID: <20241220153314.5237-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220153314.5237-1-cel@kernel.org>
References: <20241220153314.5237-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The mtree mechanism has been effective at creating directory offsets
that are stable over multiple opendir instances. However, it has not
been able to handle the subtleties of renames that are concurrent
with readdir.

Instead of using the mtree to emit entries in the order of their
offset values, use it only to map incoming ctx->pos to a starting
entry. Then use the directory's d_children list, which is already
maintained properly by the dcache, to find the next child to emit.

One of the sneaky things about this is that when the mtree-allocated
offset value wraps (which is very rare), looking up ctx->pos++ is
not going to find the next entry; it will return NULL. Instead, by
following the d_children list, the offset values can appear in any
order but all of the entries in the directory will be visited
eventually.

Note also that the readdir() is guaranteed to reach the tail of this
list. Entries are added only at the head of d_children, and readdir
walks from its current position in that list towards its tail.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 84 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5c56783c03a5..f7ead02062ad 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
 
 /* simple_offset_add() allocation range */
 enum {
-	DIR_OFFSET_MIN		= 2,
+	DIR_OFFSET_MIN		= 3,
 	DIR_OFFSET_MAX		= LONG_MAX - 1,
 };
 
 /* simple_offset_add() never assigns these to a dentry */
 enum {
+	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
 	DIR_OFFSET_EOD		= LONG_MAX,	/* Marks EOD */
 
 };
@@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+static struct dentry *find_positive_dentry(struct dentry *parent,
+					   struct dentry *dentry,
+					   bool next)
 {
-	MA_STATE(mas, &octx->mt, offset, offset);
+	struct dentry *found = NULL;
+
+	spin_lock(&parent->d_lock);
+	if (next)
+		dentry = d_next_sibling(dentry);
+	else if (!dentry)
+		dentry = d_first_child(parent);
+	hlist_for_each_entry_from(dentry, d_sib) {
+		if (!simple_positive(dentry))
+			continue;
+		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(dentry))
+			found = dget_dlock(dentry);
+		spin_unlock(&dentry->d_lock);
+		if (likely(found))
+			break;
+	}
+	spin_unlock(&parent->d_lock);
+	return found;
+}
+
+static noinline_for_stack struct dentry *
+offset_dir_lookup(struct dentry *parent, loff_t offset)
+{
+	struct inode *inode = d_inode(parent);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *child, *found = NULL;
 
-	rcu_read_lock();
-	child = mas_find(&mas, DIR_OFFSET_MAX);
-	if (!child)
-		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
-out:
-	rcu_read_unlock();
+	MA_STATE(mas, &octx->mt, offset, offset);
+
+	if (offset == DIR_OFFSET_FIRST)
+		found = find_positive_dentry(parent, NULL, false);
+	else {
+		rcu_read_lock();
+		child = mas_find(&mas, DIR_OFFSET_MAX);
+		found = find_positive_dentry(parent, child, false);
+		rcu_read_unlock();
+	}
 	return found;
 }
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	long offset = dentry2offset(dentry);
 
-	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
-			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
+	return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
+			inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct file *file, struct dir_context *ctx)
 {
-	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+	struct dentry *dir = file->f_path.dentry;
 	struct dentry *dentry;
 
+	dentry = offset_dir_lookup(dir, ctx->pos);
+	if (!dentry)
+		goto out_eod;
 	while (true) {
-		dentry = offset_find_next(octx, ctx->pos);
-		if (!dentry)
-			goto out_eod;
+		struct dentry *next;
 
-		if (!offset_dir_emit(ctx, dentry)) {
-			dput(dentry);
+		ctx->pos = dentry2offset(dentry);
+		if (!offset_dir_emit(ctx, dentry))
 			break;
-		}
 
-		ctx->pos = dentry2offset(dentry) + 1;
+		next = find_positive_dentry(dir, dentry, true);
 		dput(dentry);
+
+		if (!next)
+			goto out_eod;
+		dentry = next;
 	}
+	dput(dentry);
 	return;
 
 out_eod:
@@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 	if (ctx->pos != DIR_OFFSET_EOD)
-		offset_iterate_dir(d_inode(dir), ctx);
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
-- 
2.47.0


