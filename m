Return-Path: <linux-fsdevel+bounces-38208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4EF9FDBCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5D91882C58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55716CD1D;
	Sat, 28 Dec 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaponY1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67986198A22
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735408533; cv=none; b=AcHe2hwcV3+RV4sfI4W68ETg+85FfkdRIthg3ZTu/CJC3i0PhpddemvHODi0lMHK+kSFtYfV4vz6JP3KwzZcQB0GR8OzDZ9DznFYT0pGmsB1iBmSDV+oUkVHkkzBRNNvbvvvmq3LVUNuxxMxFJrgbgNCrDvbvplDE8CP4xPe/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735408533; c=relaxed/simple;
	bh=PJrR9iTSkLO7Ad1cW7Xy5tTxsQkFEv8En0/HpmU5uaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODkVZ+/8NdtShRpXD0nP+3ZNYkrD+cL8sX00V2BsI7S1L6+iKSUD7cpMpK/9X0t0pRYMCagpVsyTuzpn6OBUcO6xW0ZwCGOXE/XPbwdrr5zRJ233NN6ox8aMKto/JilGepbqpIlFAq5h9drsz1C7yS2HnQce1J2G41vgH7N2spI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaponY1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75879C4CED3;
	Sat, 28 Dec 2024 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735408533;
	bh=PJrR9iTSkLO7Ad1cW7Xy5tTxsQkFEv8En0/HpmU5uaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EaponY1DCwvK9kO+sQHd8NmTQhrL3/6Ul2UEQonLWbZ3xmzGWlGLjdUA7Ppd2DgSx
	 xItpQE3/E9HoJzUY6ayuKUxVdAhqk1F3mcSD9WK89Sy8YfMzhMkz4aCzzk0xID/d2X
	 DQ4GH3HL6nZwcwXToopqV3OC1uLtoh8fJMtROQDlEN24kh1ktJZ16HBCiOmLjvtzOy
	 Y9Wm3AyOnAZ+hmM62midzMME6KAUP1wR5T0ZrVs3239RgKlMLEaXEcVvi1ct0eLXkC
	 RASz6cY7NBmfVwjEndQ17MQEGopknO+ZnXy1KLKJnvzMaH3OzBhk4iXSzLnTIUsAcO
	 wXTaNZNNnJp4Q==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Liam.Howlett@oracle.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 5/5] libfs: Use d_children list to iterate simple_offset directories
Date: Sat, 28 Dec 2024 12:55:21 -0500
Message-ID: <20241228175522.1854234-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241228175522.1854234-1-cel@kernel.org>
References: <20241228175522.1854234-1-cel@kernel.org>
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
index 47399f90511a..279442b1fe96 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
 
 /* simple_offset_add() never assigns these to a dentry */
 enum {
+	DIR_OFFSET_FIRST	= 2,		/* Find first real entry */
 	DIR_OFFSET_EOD		= S32_MAX,
 };
 
 /* simple_offset_add() allocation range */
 enum {
-	DIR_OFFSET_MIN		= 2,
+	DIR_OFFSET_MIN		= DIR_OFFSET_FIRST + 1,
 	DIR_OFFSET_MAX		= DIR_OFFSET_EOD - 1,
 };
 
@@ -457,51 +458,82 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
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
@@ -540,7 +572,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 	if (ctx->pos != DIR_OFFSET_EOD)
-		offset_iterate_dir(d_inode(dir), ctx);
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
-- 
2.47.0


