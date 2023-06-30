Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3EA744193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjF3RtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjF3Rsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:48:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F95273B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 10:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E684E617D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 17:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA7CC433C8;
        Fri, 30 Jun 2023 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688147331;
        bh=iWqwcV+eIiSHZmsYQJ7ZBLU/vmsFktEqZ/Wrz1FYplg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HUhP0hIwz6AyB3wZKihKR7oYyPTxeaqu4hC+682b6AJCdhw5r9l09vt5Q2q62lEkm
         3ZyhvBPwC07xag2D7GiO+rizKSmqgXuHDPM3vFE8oW6LS3EPqVUseQC5vxLLmv9MZp
         eQ/ndaaIb0qy8q66pudIL6eu/lNXsNQb1ZZpc0euHZLje7JZMfAgTTiDDxyh8G1CEo
         0KF5qOWm2FCSEDN6+/o20ux3W7v0NvKgRWphqH8cWbqM9gFCG1fFEwEBpt+SdHLBP0
         B6knsRWMigbdZqyzeusk749mHiSCbHWIi1mEZp8gdTqQOH5ldi4GPioohRhYVlF+9z
         ldDlkOHAN1Anw==
Subject: [PATCH v7 1/3] libfs: Add directory operations for stable offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Jun 2023 13:48:49 -0400
Message-ID: <168814732984.530310.11190772066786107220.stgit@manet.1015granger.net>
In-Reply-To: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
References: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
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

Create a vector of directory operations in fs/libfs.c that handles
directory seeks and readdir via stable offsets instead of the
current cursor-based mechanism.

For the moment these are unused.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/filesystems/locking.rst |    2 
 Documentation/filesystems/vfs.rst     |    6 +
 fs/libfs.c                            |  247 +++++++++++++++++++++++++++++++++
 include/linux/fs.h                    |   18 ++
 4 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ed148919e11a..6a928fee3400 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -85,6 +85,7 @@ prototypes::
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
+	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 
 locking rules:
 	all may block
@@ -115,6 +116,7 @@ atomic_open:	shared (exclusive if O_CREAT is set in open flags)
 tmpfile:	no
 fileattr_get:	no or exclusive
 fileattr_set:	exclusive
+get_offset_ctx: no
 ==============	=============================================
 
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index cb2a97e49872..898d0b43109e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -515,6 +515,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*fileattr_set)(struct mnt_idmap *idmap,
 				    struct dentry *dentry, struct fileattr *fa);
 		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	        struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -675,7 +676,10 @@ otherwise noted.
 	called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
 	change miscellaneous file flags and attributes.  Callers hold
 	i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
-
+``get_offset_ctx``
+	called to get the offset context for a directory inode. A
+        filesystem must define this operation to use
+        simple_offset_dir_operations.
 
 The Address Space Object
 ========================
diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..68b0000dc518 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,6 +239,253 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+static void offset_set(struct dentry *dentry, unsigned long offset)
+{
+	dentry->d_fsdata = (void *)offset;
+}
+
+static unsigned long dentry2offset(struct dentry *dentry)
+{
+	return (unsigned long)dentry->d_fsdata;
+}
+
+/**
+ * simple_offset_init - initialize an offset_ctx
+ * @octx: directory offset map to be initialized
+ *
+ */
+void simple_offset_init(struct offset_ctx *octx)
+{
+	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
+
+	/* 0 is '.', 1 is '..', so always start with offset 2 */
+	octx->next_offset = 2;
+}
+
+/**
+ * simple_offset_add - Add an entry to a directory's offset map
+ * @octx: directory offset ctx to be updated
+ * @dentry: new dentry being added
+ *
+ * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Otherwise, a negative errno value is returned.
+ */
+int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
+{
+	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	u32 offset;
+	int ret;
+
+	if (dentry2offset(dentry) != 0)
+		return -EBUSY;
+
+	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
+			      &octx->next_offset, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	offset_set(dentry, offset);
+	return 0;
+}
+
+/**
+ * simple_offset_remove - Remove an entry to a directory's offset map
+ * @octx: directory offset ctx to be updated
+ * @dentry: dentry being removed
+ *
+ */
+void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
+{
+	unsigned long index = dentry2offset(dentry);
+
+	if (index == 0)
+		return;
+
+	xa_erase(&octx->xa, index);
+	offset_set(dentry, 0);
+}
+
+/**
+ * simple_offset_rename_exchange - exchange rename with directory offsets
+ * @old_dir: parent of dentry being moved
+ * @old_dentry: dentry being moved
+ * @new_dir: destination parent
+ * @new_dentry: destination dentry
+ *
+ * Returns zero on success. Otherwise a negative errno is returned and the
+ * rename is rolled back.
+ */
+int simple_offset_rename_exchange(struct inode *old_dir,
+				  struct dentry *old_dentry,
+				  struct inode *new_dir,
+				  struct dentry *new_dentry)
+{
+	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
+	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+	unsigned long old_index = dentry2offset(old_dentry);
+	unsigned long new_index = dentry2offset(new_dentry);
+	int ret;
+
+	simple_offset_remove(old_ctx, old_dentry);
+	simple_offset_remove(new_ctx, new_dentry);
+
+	ret = simple_offset_add(new_ctx, old_dentry);
+	if (ret)
+		goto out_restore;
+
+	ret = simple_offset_add(old_ctx, new_dentry);
+	if (ret) {
+		simple_offset_remove(new_ctx, old_dentry);
+		goto out_restore;
+	}
+
+	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+	if (ret) {
+		simple_offset_remove(new_ctx, old_dentry);
+		simple_offset_remove(old_ctx, new_dentry);
+		goto out_restore;
+	}
+	return 0;
+
+out_restore:
+	offset_set(old_dentry, old_index);
+	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
+	offset_set(new_dentry, new_index);
+	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	return ret;
+}
+
+/**
+ * simple_offset_destroy - Release offset map
+ * @octx: directory offset ctx that is about to be destroyed
+ *
+ * During fs teardown (eg. umount), a directory's offset map might still
+ * contain entries. xa_destroy() cleans out anything that remains.
+ */
+void simple_offset_destroy(struct offset_ctx *octx)
+{
+	xa_destroy(&octx->xa);
+}
+
+/**
+ * offset_dir_llseek - Advance the read position of a directory descriptor
+ * @file: an open directory whose position is to be updated
+ * @offset: a byte offset
+ * @whence: enumerator describing the starting position for this update
+ *
+ * SEEK_END, SEEK_DATA, and SEEK_HOLE are not supported for directories.
+ *
+ * Returns the updated read position if successful; otherwise a
+ * negative errno is returned and the read position remains unchanged.
+ */
+static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
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
+
+	return vfs_setpos(file, offset, U32_MAX);
+}
+
+static struct dentry *offset_find_next(struct xa_state *xas)
+{
+	struct dentry *child, *found = NULL;
+
+	rcu_read_lock();
+	child = xas_next_entry(xas, U32_MAX);
+	if (!child)
+		goto out;
+	spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+	if (simple_positive(child))
+		found = dget_dlock(child);
+	spin_unlock(&child->d_lock);
+out:
+	rcu_read_unlock();
+	return found;
+}
+
+static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
+{
+	loff_t offset = dentry2offset(dentry);
+	struct inode *inode = d_inode(dentry);
+
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
+			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
+}
+
+static void offset_iterate_dir(struct dentry *dir, struct dir_context *ctx)
+{
+	struct inode *inode = d_inode(dir);
+	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
+	XA_STATE(xas, &so_ctx->xa, ctx->pos);
+	struct dentry *dentry;
+
+	while (true) {
+		spin_lock(&dir->d_lock);
+		dentry = offset_find_next(&xas);
+		spin_unlock(&dir->d_lock);
+		if (!dentry)
+			break;
+
+		if (!offset_dir_emit(ctx, dentry)) {
+			dput(dentry);
+			break;
+		}
+
+		dput(dentry);
+		ctx->pos = xas.xa_index + 1;
+	}
+}
+
+/**
+ * offset_readdir - Emit entries starting at offset @ctx->pos
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
+static int offset_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct dentry *dir = file->f_path.dentry;
+
+	lockdep_assert_held(&d_inode(dir)->i_rwsem);
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	offset_iterate_dir(dir, ctx);
+	return 0;
+}
+
+const struct file_operations simple_offset_dir_operations = {
+	.llseek		= offset_dir_llseek,
+	.iterate_shared	= offset_readdir,
+	.read		= generic_read_dir,
+	.fsync		= noop_fsync,
+};
+
 static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
 {
 	struct dentry *child = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6867512907d6..59a4129ce14c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1770,6 +1770,7 @@ struct dir_context {
 
 struct iov_iter;
 struct io_uring_cmd;
+struct offset_ctx;
 
 struct file_operations {
 	struct module *owner;
@@ -1857,6 +1858,7 @@ struct inode_operations {
 	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -2971,6 +2973,22 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+struct offset_ctx {
+	struct xarray		xa;
+	u32			next_offset;
+};
+
+void simple_offset_init(struct offset_ctx *octx);
+int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
+void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+int simple_offset_rename_exchange(struct inode *old_dir,
+				  struct dentry *old_dentry,
+				  struct inode *new_dir,
+				  struct dentry *new_dentry);
+void simple_offset_destroy(struct offset_ctx *octx);
+
+extern const struct file_operations simple_offset_dir_operations;
+
 extern int __generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 


