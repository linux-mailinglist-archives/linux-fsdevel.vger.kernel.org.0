Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EB6E50C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjDQTXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 15:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQTXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834074ECA
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 12:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16FD262035
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AADC433EF;
        Mon, 17 Apr 2023 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759392;
        bh=0VkY5T9KJxoLFAqkKIF1YpJyl/z5A8Xa54INiyeld6k=;
        h=Subject:From:To:Cc:Date:From;
        b=imQ+/UsXifoS5G7Ctbkj+YCwy9vnvlbQmuG1CjSQXDlf2RIw1KQW4CQSKNKXluD0Q
         6PSIG4qJfvXAKncQygVOnN2n6MyCA6UjSH4ujBIyUJuNq7GW1PXpdBbgPzI5t7XM9+
         b0e/IyzUMhJ1ys+Zi0gP8AFj2h9xjAP8BpOcWASs1VOqJh+WaLp7dqZBMGkkhMHIj+
         7tlmbMYPkJwC/WavfTriHZbHR8d6Ihm4c6o8I+7DBLXsnVvuvCRVLlkUtueFWQ/WQN
         jan5fUPoO/UOo7ryRsvSwvi2FiTljl8AbbKnR5jgGOaAm4Z3llQJdl+FMFo5MyvohJ
         1Dy1hajv4+KXw==
Subject: [PATCH v1] shmem: stable directory cookies
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Apr 2023 15:23:10 -0400
Message-ID: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The current cursor-based directory cookie mechanism doesn't work
when a tmpfs filesystem is exported via NFS. This is because NFS
clients do not open directories: each READDIR operation has to open
the directory on the server, read it, then close it. The cursor
state for that directory, being associated strictly with the opened
struct file, is then discarded.

Directory cookies are cached not only by NFS clients, but also by
user space libraries on those clients. Essentially there is no way
to invalidate those caches when directory offsets have changed on
an NFS server after the offset-to-dentry mapping changes.

The solution we've come up with is to make the directory cookie for
each file in a tmpfs filesystem stable for the life of the directory
entry it represents.

Add a per-directory xarray. shmem_readdir() uses this to map each
directory offset (an loff_t integer) to the memory address of a
struct dentry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/shmem_fs.h |    2 
 mm/shmem.c               |  213 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 201 insertions(+), 14 deletions(-)

Changes since RFC:
- Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
- A few cosmetic updates

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..682ef885aa89 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -26,6 +26,8 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+	struct xarray		doff_map;	/* dir offset to entry mapping */
+	u32			next_doff;
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..ba4176499e5c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,8 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/xarray.h>
+
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -234,6 +236,7 @@ static const struct super_operations shmem_ops;
 const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
 static const struct inode_operations shmem_inode_operations;
+static const struct file_operations shmem_dir_operations;
 static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
@@ -2397,7 +2400,9 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
+			inode->i_fop = &shmem_dir_operations;
+			xa_init_flags(&info->doff_map, XA_FLAGS_ALLOC1);
+			info->next_doff = 0;
 			break;
 		case S_IFLNK:
 			/*
@@ -2917,6 +2922,71 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static struct xarray *shmem_doff_map(struct inode *dir)
+{
+	return &SHMEM_I(dir)->doff_map;
+}
+
+static int shmem_doff_add(struct inode *dir, struct dentry *dentry)
+{
+	struct shmem_inode_info *info = SHMEM_I(dir);
+	struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	u32 offset;
+	int ret;
+
+	if (dentry->d_fsdata)
+		return -EBUSY;
+
+	offset = 0;
+	ret = xa_alloc_cyclic(shmem_doff_map(dir), &offset, dentry, limit,
+			      &info->next_doff, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	dentry->d_fsdata = (void *)(unsigned long)offset;
+	return 0;
+}
+
+static struct dentry *shmem_doff_find_after(struct dentry *dir,
+					    unsigned long *offset)
+{
+	struct xarray *xa = shmem_doff_map(d_inode(dir));
+	struct dentry *d, *found = NULL;
+
+	spin_lock(&dir->d_lock);
+	d = xa_find_after(xa, offset, ULONG_MAX, XA_PRESENT);
+	if (d) {
+		spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+		if (simple_positive(d))
+			found = dget_dlock(d);
+		spin_unlock(&d->d_lock);
+	}
+	spin_unlock(&dir->d_lock);
+	return found;
+}
+
+static void shmem_doff_remove(struct inode *dir, struct dentry *dentry)
+{
+	u32 offset = (u32)(unsigned long)dentry->d_fsdata;
+
+	if (!offset)
+		return;
+
+	xa_erase(shmem_doff_map(dir), offset);
+	dentry->d_fsdata = NULL;
+}
+
+/*
+ * During fs teardown (eg. umount), a directory's doff_map might still
+ * contain entries. xa_destroy() cleans out anything that remains.
+ */
+static void shmem_doff_map_destroy(struct inode *inode)
+{
+	struct xarray *xa = shmem_doff_map(inode);
+
+	xa_destroy(xa);
+}
+
 /*
  * File creation. Allocate an inode, and we're done..
  */
@@ -2938,6 +3008,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
+		error = shmem_doff_add(dir, dentry);
+		if (error)
+			goto out_iput;
+
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3015,6 +3089,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	ret = shmem_doff_add(dir, dentry);
+	if (ret)
+		goto out;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3033,6 +3111,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
+	shmem_doff_remove(dir, dentry);
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3091,24 +3171,37 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
+	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
-	if (flags & RENAME_EXCHANGE)
+	if (flags & RENAME_EXCHANGE) {
+		shmem_doff_remove(old_dir, old_dentry);
+		shmem_doff_remove(new_dir, new_dentry);
+		error = shmem_doff_add(new_dir, old_dentry);
+		if (error)
+			return error;
+		error = shmem_doff_add(old_dir, new_dentry);
+		if (error)
+			return error;
 		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+	}
 
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-		int error;
-
 		error = shmem_whiteout(idmap, old_dir, old_dentry);
 		if (error)
 			return error;
 	}
 
+	shmem_doff_remove(old_dir, old_dentry);
+	error = shmem_doff_add(new_dir, old_dentry);
+	if (error)
+		return error;
+
 	if (d_really_is_positive(new_dentry)) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs) {
@@ -3149,26 +3242,22 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	error = security_inode_init_security(inode, dir, &dentry->d_name,
 					     shmem_initxattrs, NULL);
-	if (error && error != -EOPNOTSUPP) {
-		iput(inode);
-		return error;
-	}
+	if (error && error != -EOPNOTSUPP)
+		goto out_iput;
 
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
 		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
 		if (!inode->i_link) {
-			iput(inode);
-			return -ENOMEM;
+			error = -ENOMEM;
+			goto out_iput;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
 		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
-		if (error) {
-			iput(inode);
-			return error;
-		}
+		if (error)
+			goto out_iput;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
@@ -3177,12 +3266,20 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
+
+	error = shmem_doff_add(dir, dentry);
+	if (error)
+		goto out_iput;
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
+out_iput:
+	iput(inode);
+	return error;
 }
 
 static void shmem_put_link(void *arg)
@@ -3224,6 +3321,77 @@ static const char *shmem_get_link(struct dentry *dentry,
 	return folio_address(folio);
 }
 
+static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	switch (whence) {
+	case SEEK_CUR:
+		offset += file->f_pos;
+		fallthrough;
+	case SEEK_SET:
+		if (offset >= 0)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+	return vfs_setpos(file, offset, U32_MAX);
+}
+
+static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
+			  (loff_t)dentry->d_fsdata, inode->i_ino,
+			  fs_umode_to_dtype(inode->i_mode));
+}
+
+/**
+ * shmem_readdir - Emit entries starting at offset @ctx->pos
+ * @file: an open directory to iterate over
+ * @ctx: directory iteration context
+ *
+ * Caller must hold @file's i_rwsem to prevent insertion or removal of
+ * entries during this call.
+ *
+ * On entry, @ctx->pos contains an offset that represents the first entry
+ * to be read from the directory.
+ *
+ * The operation continues until there are no more entries to read, or
+ * until the ctx->actor indicates there is no more space in the caller's
+ * output buffer.
+ *
+ * On return, @ctx->pos contains an offset that will read the next entry
+ * in this directory when shmem_readdir() is called again with @ctx.
+ *
+ * Return values:
+ *   %0 - Complete
+ */
+static int shmem_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct dentry *dentry, *dir = file->f_path.dentry;
+	unsigned long offset;
+
+	lockdep_assert_held(&d_inode(dir)->i_rwsem);
+
+	if (!dir_emit_dots(file, ctx))
+		goto out;
+	for (offset = ctx->pos - 1; offset < ULONG_MAX - 1;) {
+		dentry = shmem_doff_find_after(dir, &offset);
+		if (!dentry)
+			break;
+		if (!shmem_dir_emit(ctx, dentry)) {
+			dput(dentry);
+			break;
+		}
+		ctx->pos = offset + 1;
+		dput(dentry);
+	}
+
+out:
+	return 0;
+}
+
 #ifdef CONFIG_TMPFS_XATTR
 
 static int shmem_fileattr_get(struct dentry *dentry, struct fileattr *fa)
@@ -3742,6 +3910,12 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#else /* CONFIG_TMPFS */
+
+static inline void shmem_doff_map_destroy(struct inode *dir)
+{
+}
+
 #endif /* CONFIG_TMPFS */
 
 static void shmem_put_super(struct super_block *sb)
@@ -3888,6 +4062,8 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if (S_ISDIR(inode->i_mode))
+		shmem_doff_map_destroy(inode);
 }
 
 static void shmem_init_inode(void *foo)
@@ -3955,6 +4131,15 @@ static const struct inode_operations shmem_inode_operations = {
 #endif
 };
 
+static const struct file_operations shmem_dir_operations = {
+#ifdef CONFIG_TMPFS
+	.llseek		= shmem_dir_llseek,
+	.iterate_shared	= shmem_readdir,
+#endif
+	.read		= generic_read_dir,
+	.fsync		= noop_fsync,
+};
+
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.getattr	= shmem_getattr,


