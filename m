Return-Path: <linux-fsdevel+bounces-36486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBBB9E3EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98621283367
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814220C47B;
	Wed,  4 Dec 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfMP5EMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAF20CCF5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327588; cv=none; b=bY79VeniSROqntzzJcKB4uaVBsSctEUf+w1P806rZz5Hakz7nUcKCJItidexGaRN0AIbqkRj4TEzXKF7L7Mr4iv5IBAsJgQZchBAbiel0sm47mYM0O7PME66dF3x/FXfNGhlZRdIQ/0li7KdCMYbwYUw/iehRXg1PAoEQSr5xVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327588; c=relaxed/simple;
	bh=uvo1HVcXQPvOFc+Tys1OpqZ+zabfYR8WnzY6RxmyeLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzRtvvZJu13T5zInoiHnG/iicish37KxwJBFX4ZbycOOdlUUr/QFrQJmLmyzCOD0TbwNjIzSKoANZDOF0z8kSg6ddF2ADlfeZR7J9Qf3INFDY589Rb7FbtgVyWxCOw7ax4h/rxSWgxyHKveXlsR11gJUKTaQOG9TquoCZnW/YCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfMP5EMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0DFC4CEDF;
	Wed,  4 Dec 2024 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327587;
	bh=uvo1HVcXQPvOFc+Tys1OpqZ+zabfYR8WnzY6RxmyeLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfMP5EMFpAz6PQ9Cece/cfrswMGjeexM20kMaqoYqE76POVWpZCG0qVk7E/WxkBUW
	 qYytJOTAKTZwUXhNfqVNydYqn+YQYz/30IALiV0Lm71vw5Ngfl5tvh8YpsMFRDcBck
	 S4Ju5KlZSgq6lQAevI0+FLKrOCQk5Lx9W0WZyQMOHWS7abB729iS/H7JU1epZE9xQ5
	 RnzkOykEvT+xUv3uAQoZLDWXIZ+SZrF0EDdrWDThwntBXSaw6gccKJzT/rAW1KVVwV
	 6EDlv7bivXJ3bqgDZ3eFB02qvqc9+kT0g0OUff0la0HYoGAUObBmoUv5iqB0EDB044
	 5I6Jf7s9pIxDA==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 5/5] libfs: Use d_children list to iterate simple_offset directories
Date: Wed,  4 Dec 2024 10:52:56 -0500
Message-ID: <20241204155257.1110338-6-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
References: <20241204155257.1110338-1-cel@kernel.org>
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
 fs/libfs.c | 77 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index fcb2cdf6e3f3..398eac385094 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -243,12 +243,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
 
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
@@ -456,19 +457,43 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+/* Cf. find_next_child() */
+static struct dentry *find_next_sibling_locked(struct dentry *parent,
+					       struct dentry *dentry)
 {
-	MA_STATE(mas, &octx->mt, offset, offset);
+	struct dentry *found = NULL;
+
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
+	return found;
+}
+
+static noinline_for_stack struct dentry *
+offset_dir_lookup(struct file *file, loff_t offset)
+{
+	struct dentry *parent = file->f_path.dentry;
 	struct dentry *child, *found = NULL;
+	struct inode *inode = d_inode(parent);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+
+	MA_STATE(mas, &octx->mt, offset, offset);
 
 	rcu_read_lock();
 	child = mas_find(&mas, DIR_OFFSET_MAX);
 	if (!child)
 		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
+
+	spin_lock(&parent->d_lock);
+	found = find_next_sibling_locked(parent, child);
+	spin_unlock(&parent->d_lock);
 out:
 	rcu_read_unlock();
 	return found;
@@ -477,30 +502,42 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
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
 
+	if (ctx->pos == DIR_OFFSET_FIRST) {
+		spin_lock(&dir->d_lock);
+		dentry = find_next_sibling_locked(dir, d_first_child(dir));
+		spin_unlock(&dir->d_lock);
+	} else
+		dentry = offset_dir_lookup(file, ctx->pos);
+	if (!dentry)
+		goto out_eod;
+
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
+		spin_lock(&dir->d_lock);
+		next = find_next_sibling_locked(dir, d_next_sibling(dentry));
+		spin_unlock(&dir->d_lock);
 		dput(dentry);
+
+		if (!next)
+			goto out_eod;
+		dentry = next;
 	}
+	dput(dentry);
 	return;
 
 out_eod:
@@ -539,7 +576,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 	if (ctx->pos != DIR_OFFSET_EOD)
-		offset_iterate_dir(d_inode(dir), ctx);
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
-- 
2.47.0


