Return-Path: <linux-fsdevel+bounces-11447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9422853D52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA8D1C265CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572216215E;
	Tue, 13 Feb 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG7j61xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3C61688;
	Tue, 13 Feb 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860283; cv=none; b=YIwHcU8lJI3aSxJYwzZdwSntz2388jXmWFK2jVusOxH7l4RcwncNAwcDgaf1gv3QGOijS62HUuHhDJ0Hqby69HeESRri3I9ijT5LL5/7jVmIkWvpxSZOqUO6tcTsm9Lk+ZzK9UrhrcNy6utsD/+L+46ljzf+JP905URRkmViYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860283; c=relaxed/simple;
	bh=KGqt+JHPo7CMimpAfjV92G5RJ+LvokLdXc+VC2S1AlQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVtmvM6R5p00fSWNyB3NcRMssUShTG0KD4rvGPIzpcsBM9swbYpE5jEapSdgf/MBmLmVRFgdKE/2j10ZBETowdFXtZQOwYpbT83gV8tqI8bMY6ESgoGFj7POMWSCssayK4y7FqnXnTQxdVc/GlKCBrktmlos8dVdo1SvzP1H+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG7j61xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6B8C433F1;
	Tue, 13 Feb 2024 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860283;
	bh=KGqt+JHPo7CMimpAfjV92G5RJ+LvokLdXc+VC2S1AlQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FG7j61xv3XzeLrMru1T0AuzhJtumhe7YDI4XxvKqKzZErrZwLX9fcCO+Ik0BsBBKz
	 y2HK3IiVkalN33FSz9+c8RRFS5yv1P/s570qwwK4A1HiYLX+BSffOA/RvoQ+F2QnqB
	 7RgknMYrNxdARbcEimBh6CwC7aBu/Cgct8Rs1vM4/su6p/cBDjro7gKVP3NkCdVTqw
	 kHEYMT3APXIbiLWNXceuQq/2JflUJexQigp2iom0MFZGAA21wJjQa9YREfL4/mNkod
	 R1nvl7c7hVJUnFzZ7I83N503q4+pMhWDj7kVXBYxEnZUNQONDco1zKaW19Mxav9op8
	 Z9F26fNWv5Ulw==
Subject: [PATCH RFC 6/7] libfs: Convert simple directory offsets to use a
 Maple Tree
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:38:01 -0500
Message-ID: 
 <170786028128.11135.4581426129369576567.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
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

Test robot reports:
> kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
>
> commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Feng Tang further clarifies that:
> ... the new simple_offset_add()
> called by shmem_mknod() brings extra cost related with slab,
> specifically the 'radix_tree_node', which cause the regression.

Willy's analysis is that, over time, the test workload causes
xa_alloc_cyclic() to fragment the underlying SLAB cache.

This patch replaces the offset_ctx's xarray with a Maple Tree in the
hope that Maple Tree's dense node mode will handle this scenario
more scalably.

In addition, we can widen the directory offset to an unsigned long
everywhere.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         |   53 ++++++++++++++++++++++++++--------------------------
 include/linux/fs.h |    5 +++--
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3cf773950f93..f073e9aeb2bf 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -245,17 +245,17 @@ enum {
 	DIR_OFFSET_MIN	= 2,
 };
 
-static void offset_set(struct dentry *dentry, u32 offset)
+static void offset_set(struct dentry *dentry, unsigned long offset)
 {
-	dentry->d_fsdata = (void *)((uintptr_t)(offset));
+	dentry->d_fsdata = (void *)offset;
 }
 
-static u32 dentry2offset(struct dentry *dentry)
+static unsigned long dentry2offset(struct dentry *dentry)
 {
-	return (u32)((uintptr_t)(dentry->d_fsdata));
+	return (unsigned long)dentry->d_fsdata;
 }
 
-static struct lock_class_key simple_offset_xa_lock;
+static struct lock_class_key simple_offset_lock_class;
 
 /**
  * simple_offset_init - initialize an offset_ctx
@@ -264,8 +264,8 @@ static struct lock_class_key simple_offset_xa_lock;
  */
 void simple_offset_init(struct offset_ctx *octx)
 {
-	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
+	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
+	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
 	octx->next_offset = DIR_OFFSET_MIN;
 }
 
@@ -279,15 +279,14 @@ void simple_offset_init(struct offset_ctx *octx)
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
-	u32 offset;
+	unsigned long offset;
 	int ret;
 
 	if (dentry2offset(dentry) != 0)
 		return -EBUSY;
 
-	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
-			      &octx->next_offset, GFP_KERNEL);
+	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
+				 ULONG_MAX, &octx->next_offset, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -303,13 +302,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-	u32 offset;
+	unsigned long offset;
 
 	offset = dentry2offset(dentry);
 	if (offset == 0)
 		return;
 
-	xa_erase(&octx->xa, offset);
+	mtree_erase(&octx->mt, offset);
 	offset_set(dentry, 0);
 }
 
@@ -330,9 +329,9 @@ int simple_offset_empty(struct dentry *dentry)
 	if (!inode || !S_ISDIR(inode->i_mode))
 		return ret;
 
-	index = 2;
+	index = DIR_OFFSET_MIN;
 	octx = inode->i_op->get_offset_ctx(inode);
-	xa_for_each(&octx->xa, index, child) {
+	mt_for_each(&octx->mt, child, index, ULONG_MAX) {
 		spin_lock(&child->d_lock);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
@@ -362,8 +361,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
-	u32 old_index = dentry2offset(old_dentry);
-	u32 new_index = dentry2offset(new_dentry);
+	unsigned long old_index = dentry2offset(old_dentry);
+	unsigned long new_index = dentry2offset(new_dentry);
 	int ret;
 
 	simple_offset_remove(old_ctx, old_dentry);
@@ -389,9 +388,9 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 
 out_restore:
 	offset_set(old_dentry, old_index);
-	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
+	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
 	offset_set(new_dentry, new_index);
-	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
 	return ret;
 }
 
@@ -404,7 +403,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
  */
 void simple_offset_destroy(struct offset_ctx *octx)
 {
-	xa_destroy(&octx->xa);
+	mtree_destroy(&octx->mt);
 }
 
 /**
@@ -434,15 +433,15 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	/* In this case, ->private_data is protected by f_pos_lock */
 	file->private_data = NULL;
-	return vfs_setpos(file, offset, U32_MAX);
+	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
 }
 
-static struct dentry *offset_find_next(struct xa_state *xas)
+static struct dentry *offset_find_next(struct ma_state *mas)
 {
 	struct dentry *child, *found = NULL;
 
 	rcu_read_lock();
-	child = xas_next_entry(xas, U32_MAX);
+	child = mas_find(mas, ULONG_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -456,7 +455,7 @@ static struct dentry *offset_find_next(struct xa_state *xas)
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-	u32 offset = dentry2offset(dentry);
+	unsigned long offset = dentry2offset(dentry);
 	struct inode *inode = d_inode(dentry);
 
 	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
@@ -466,11 +465,11 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
-	XA_STATE(xas, &octx->xa, ctx->pos);
+	MA_STATE(mas, &octx->mt, ctx->pos, ctx->pos);
 	struct dentry *dentry;
 
 	while (true) {
-		dentry = offset_find_next(&xas);
+		dentry = offset_find_next(&mas);
 		if (!dentry)
 			return ERR_PTR(-ENOENT);
 
@@ -480,7 +479,7 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		}
 
 		dput(dentry);
-		ctx->pos = xas.xa_index + 1;
+		ctx->pos = mas.index + 1;
 	}
 	return NULL;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03d141809a2c..55144c12ee0f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/maple_tree.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3260,8 +3261,8 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
 struct offset_ctx {
-	struct xarray		xa;
-	u32			next_offset;
+	struct maple_tree	mt;
+	unsigned long		next_offset;
 };
 
 void simple_offset_init(struct offset_ctx *octx);



