Return-Path: <linux-fsdevel+bounces-16735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B268A1EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8D2889DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437ED175A6;
	Thu, 11 Apr 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEhoArXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CED56B74
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859980; cv=none; b=mjpFfkNAhRp73Qn0E1MTpOPejbKfysGXWpEMibtTgFxlI1baJ/End/TV5HAFX1hZjRUmE6wDkww5E9PgurpPVA5LXNNbPxQHLpTRzwQ0c8my2Ez6F9jhhoW0CVFdksoJGTEPa5AnsyzQXiNhY16PGgXk97qfhcwVPKo/BUPPM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859980; c=relaxed/simple;
	bh=VdGmUnGjcaV68swXN+OmpHTnsCe0tdeChnd6Ex3+rh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC4t+fFWFZWDWhIwRsKGbRjxDt5e8vVtRdtfwUwY5E+uy1ULpilnv1ZF5FQAsRLVuqNRTlUcN3OHpAhGv085DFO3+kgHinI/eygDyMGj4GXA2QuZ4kEaEVuV7lPJQSpUz448YnQYqZMRk2MSCa7aB0QDENEgP6qaJJayQsH6ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEhoArXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4EEC113CD;
	Thu, 11 Apr 2024 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859979;
	bh=VdGmUnGjcaV68swXN+OmpHTnsCe0tdeChnd6Ex3+rh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEhoArXsL5I7eGfryJZTKs6rAwljeuYjaQnRbCTObI42cXoLjHDPM4FE4/CAmdC2t
	 mEQR4RJ9UJd+toIqzoiJhtyVeNrTeNIOt+lpVwpWqmdOqEXbksYaD8F8aEg8OGEYVU
	 dxVQlxcCW1GPn/l0ekS5pgNL1d9WJym9rcnqeDanmuDEB+ivYtISLHOHiFr/Cz9TIw
	 fZh7tK7t0gYcUw+wpsjNV0FvRPlE6IZpWdYKQMTmEMNbyU+OH+oj00R9kLWHsfM3XF
	 GqecKPsowxghD/c/o1HgY6eguMa16wfbR548zRcK+7P1RSXVROGX8Gb7W2eJC0yFhU
	 4PchqbOmsA7Rg==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/2] libfs: Clean up the simple_offset API
Date: Thu, 11 Apr 2024 14:26:11 -0400
Message-ID: <20240411182611.203328-3-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411182611.203328-1-cel@kernel.org>
References: <20240411182611.203328-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The original plan was to avoid an indirect function call on every
call to simple_offset_add() and simple_offset_remove().

But that clutters the call sites with duplicated code and makes
observability difficult because some API functions take an inode
pointer, and others take an offset_ctx.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 56 +++++++++++++++++++++++++---------------------
 include/linux/fs.h |  8 +++----
 mm/shmem.c         | 14 ++++++------
 3 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ff767288e5dd..1015111657b9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -260,11 +260,13 @@ static struct lock_class_key simple_offset_lock_class;
 
 /**
  * simple_offset_init - initialize an offset_ctx
- * @octx: directory offset map to be initialized
+ * @dir: directory to be initialized
  *
  */
-void simple_offset_init(struct offset_ctx *octx)
+void simple_offset_init(struct inode *dir)
 {
+	struct offset_ctx *octx = dir->i_op->get_offset_ctx(dir);
+
 	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
 	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
 	octx->next_offset = DIR_OFFSET_MIN;
@@ -272,14 +274,15 @@ void simple_offset_init(struct offset_ctx *octx)
 
 /**
  * simple_offset_add - Add an entry to a directory's offset map
- * @octx: directory offset ctx to be updated
+ * @dir: directory to be updated
  * @dentry: new dentry being added
  *
- * Returns zero on success. @octx and the dentry's offset are updated.
+ * Returns zero on success. @dir and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
-int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
+int simple_offset_add(struct inode *dir, struct dentry *dentry)
 {
+	struct offset_ctx *octx = dir->i_op->get_offset_ctx(dir);
 	unsigned long offset;
 	int ret;
 
@@ -299,21 +302,24 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  * Internal helper for use when it is known that the tree entry at
  * @index is already NULL.
  */
-static int simple_offset_store(struct offset_ctx *octx, struct dentry *dentry,
+static int simple_offset_store(struct inode *dir, struct dentry *dentry,
 			       long index)
 {
+	struct offset_ctx *octx = dir->i_op->get_offset_ctx(dir);
+
 	offset_set(dentry, index);
 	return mtree_store(&octx->mt, index, dentry, GFP_KERNEL);
 }
 
 /**
  * simple_offset_remove - Remove an entry to a directory's offset map
- * @octx: directory offset ctx to be updated
+ * @dir: directory to be updated
  * @dentry: dentry being removed
  *
  */
-void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
+void simple_offset_remove(struct inode *dir, struct dentry *dentry)
 {
+	struct offset_ctx *octx = dir->i_op->get_offset_ctx(dir);
 	long offset;
 
 	offset = dentry2offset(dentry);
@@ -370,19 +376,17 @@ int simple_offset_empty(struct dentry *dentry)
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
-	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
 	long new_index = dentry2offset(new_dentry);
 
-	simple_offset_remove(old_ctx, old_dentry);
+	simple_offset_remove(old_dir, old_dentry);
 
 	/*
 	 * When the destination entry already exists, user space expects
 	 * its directory offset value to be unchanged after the rename.
 	 */
 	if (new_index)
-		return simple_offset_store(new_ctx, old_dentry, new_index);
-	return simple_offset_add(new_ctx, old_dentry);
+		return simple_offset_store(new_dir, old_dentry, new_index);
+	return simple_offset_add(new_dir, old_dentry);
 }
 
 /**
@@ -403,48 +407,48 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct inode *new_dir,
 				  struct dentry *new_dentry)
 {
-	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
-	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
 	long old_index = dentry2offset(old_dentry);
 	long new_index = dentry2offset(new_dentry);
 	int ret;
 
-	simple_offset_remove(old_ctx, old_dentry);
-	simple_offset_remove(new_ctx, new_dentry);
+	simple_offset_remove(old_dir, old_dentry);
+	simple_offset_remove(new_dir, new_dentry);
 
-	ret = simple_offset_store(new_ctx, old_dentry, new_index);
+	ret = simple_offset_store(new_dir, old_dentry, new_index);
 	if (ret)
 		goto out_restore;
 
-	ret = simple_offset_store(old_ctx, new_dentry, old_index);
+	ret = simple_offset_store(old_dir, new_dentry, old_index);
 	if (ret) {
-		simple_offset_remove(new_ctx, old_dentry);
+		simple_offset_remove(new_dir, old_dentry);
 		goto out_restore;
 	}
 
 	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
 	if (ret) {
-		simple_offset_remove(new_ctx, old_dentry);
-		simple_offset_remove(old_ctx, new_dentry);
+		simple_offset_remove(new_dir, old_dentry);
+		simple_offset_remove(old_dir, new_dentry);
 		goto out_restore;
 	}
 	return 0;
 
 out_restore:
-	(void)simple_offset_store(old_ctx, old_dentry, old_index);
-	(void)simple_offset_store(new_ctx, new_dentry, new_index);
+	(void)simple_offset_store(old_dir, old_dentry, old_index);
+	(void)simple_offset_store(new_dir, new_dentry, new_index);
 	return ret;
 }
 
 /**
  * simple_offset_destroy - Release offset map
- * @octx: directory offset ctx that is about to be destroyed
+ * @dir: directory that is about to be destroyed
  *
  * During fs teardown (eg. umount), a directory's offset map might still
  * contain entries. xa_destroy() cleans out anything that remains.
  */
-void simple_offset_destroy(struct offset_ctx *octx)
+void simple_offset_destroy(struct inode *dir)
 {
+	struct offset_ctx *octx = dir->i_op->get_offset_ctx(dir);
+
 	mtree_destroy(&octx->mt);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b09f14132110..26c98dfa3397 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3336,9 +3336,9 @@ struct offset_ctx {
 	unsigned long		next_offset;
 };
 
-void simple_offset_init(struct offset_ctx *octx);
-int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
-void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+void simple_offset_init(struct inode *dir);
+int simple_offset_add(struct inode *dir, struct dentry *dentry);
+void simple_offset_remove(struct inode *dir, struct dentry *dentry);
 int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
@@ -3346,7 +3346,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
 				  struct dentry *new_dentry);
-void simple_offset_destroy(struct offset_ctx *octx);
+void simple_offset_destroy(struct inode *dir);
 
 extern const struct file_operations simple_offset_dir_operations;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index c0fb65223963..ac4f59f536cd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2555,7 +2555,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 		inode->i_size = 2 * BOGO_DIRENT_SIZE;
 		inode->i_op = &shmem_dir_inode_operations;
 		inode->i_fop = &simple_offset_dir_operations;
-		simple_offset_init(shmem_get_offset_ctx(inode));
+		simple_offset_init(inode);
 		break;
 	case S_IFLNK:
 		/*
@@ -3284,7 +3284,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error && error != -EOPNOTSUPP)
 		goto out_iput;
 
-	error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+	error = simple_offset_add(dir, dentry);
 	if (error)
 		goto out_iput;
 
@@ -3368,7 +3368,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 			goto out;
 	}
 
-	ret = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+	ret = simple_offset_add(dir, dentry);
 	if (ret) {
 		if (inode->i_nlink)
 			shmem_free_inode(inode->i_sb, 0);
@@ -3394,7 +3394,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb, 0);
 
-	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
+	simple_offset_remove(dir, dentry);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir,
@@ -3518,7 +3518,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error && error != -EOPNOTSUPP)
 		goto out_iput;
 
-	error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+	error = simple_offset_add(dir, dentry);
 	if (error)
 		goto out_iput;
 
@@ -3551,7 +3551,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return 0;
 
 out_remove_offset:
-	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
+	simple_offset_remove(dir, dentry);
 out_iput:
 	iput(inode);
 	return error;
@@ -4490,7 +4490,7 @@ static void shmem_destroy_inode(struct inode *inode)
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
 	if (S_ISDIR(inode->i_mode))
-		simple_offset_destroy(shmem_get_offset_ctx(inode));
+		simple_offset_destroy(inode);
 }
 
 static void shmem_init_inode(void *foo)
-- 
2.44.0


