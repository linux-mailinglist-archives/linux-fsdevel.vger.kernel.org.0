Return-Path: <linux-fsdevel+bounces-40072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F3A1BCC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B2216DD3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF49224AFC;
	Fri, 24 Jan 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhNPcXtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930B225409;
	Fri, 24 Jan 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746403; cv=none; b=avsFPbxhszcvLoQlXYSo/eo4SuvaFJNZzX9Vmoj6fN6d2Rya2Gi63V8JANSRxhy9szVKAGl/dGLwq3rR3C8d6FO8xebjLP/wIDgHxp1qfT5k5UupNK9ef8+V65yYPDK46scbnE+LABuHXI8OYWv66IjwhbAIaAhBfssd1S74HnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746403; c=relaxed/simple;
	bh=pXmfTZBQd8c0darSl23XS7KeuERbHI7o2nY6VDQrO7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTCCyOAgsaNCMeblpY+XA8/vK/9Giap0KendUIwP4zC/+oDy20t0XNbiA7h9+2QRNtuEDX4Rz1mJ6kRtwkVlrIX3oCU0+WpmnycEOu4H4dExYy4iid2W6N7lNHWiWSBU9BJWpOdUVIqRuGBntFFwHLE+L2PxRNY0y3jqMcaj7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhNPcXtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432B7C4CEE4;
	Fri, 24 Jan 2025 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746403;
	bh=pXmfTZBQd8c0darSl23XS7KeuERbHI7o2nY6VDQrO7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhNPcXtLJspy0nprHTzSerMolchY0HHaEn7sAVhiyh/ixaJi7T7DX3CuJDHV/4/qQ
	 8RJKbgdDrLBvcrRI+iFITTG3+SZ6Mp4iLhxmMukjRcKd6Im+fmJisZe7tW29CqJ72P
	 JOqeObPF/+FSbxtrEfNt+pxdkf0wW0kFqqM4CoIZkGcCWlfi406hpCLKIYc1AUMGGQ
	 k5h1VvyWHg9z2bxpd/wf4LOUjfG+2jRK/TixlVua0IYfh+XuVmLHbWciTJdkmHgMlj
	 vOY16NanQBHZURS9Mab22beJeXw8hMgxGlsJ/xNHZD2bsGju3Kc/gKITapmHe9NWNc
	 lyjyFjQDNcbtA==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v6.6 10/10] libfs: Use d_children list to iterate simple_offset directories
Date: Fri, 24 Jan 2025 14:19:45 -0500
Message-ID: <20250124191946.22308-11-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit b9b588f22a0c049a14885399e27625635ae6ef91 ]

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
Link: https://lore.kernel.org/r/20241228175522.1854234-6-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 84 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index d546f3f0c036..f5566964aa7d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -241,12 +241,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
 
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
 
@@ -452,51 +453,84 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, U32_MAX);
 }
 
-static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
+static struct dentry *find_positive_dentry(struct dentry *parent,
+					   struct dentry *dentry,
+					   bool next)
 {
+	struct dentry *found = NULL;
+
+	spin_lock(&parent->d_lock);
+	if (next)
+		dentry = list_next_entry(dentry, d_child);
+	else if (!dentry)
+		dentry = list_first_entry_or_null(&parent->d_subdirs,
+						  struct dentry, d_child);
+	for (; dentry && !list_entry_is_head(dentry, &parent->d_subdirs, d_child);
+	     dentry = list_next_entry(dentry, d_child)) {
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
+
 	XA_STATE(xas, &octx->xa, offset);
 
-	rcu_read_lock();
-	child = xas_next_entry(&xas, DIR_OFFSET_MAX);
-	if (!child)
-		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
-out:
-	rcu_read_unlock();
+	if (offset == DIR_OFFSET_FIRST)
+		found = find_positive_dentry(parent, NULL, false);
+	else {
+		rcu_read_lock();
+		child = xas_next_entry(&xas, DIR_OFFSET_MAX);
+		found = find_positive_dentry(parent, child, false);
+		rcu_read_unlock();
+	}
 	return found;
 }
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-	u32 offset = dentry2offset(dentry);
 	struct inode *inode = d_inode(dentry);
 
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
@@ -535,7 +569,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 	if (ctx->pos != DIR_OFFSET_EOD)
-		offset_iterate_dir(d_inode(dir), ctx);
+		offset_iterate_dir(file, ctx);
 	return 0;
 }
 
-- 
2.47.0


