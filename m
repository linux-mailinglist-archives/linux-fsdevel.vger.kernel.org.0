Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC48740552
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjF0Ux5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjF0Uxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AC2D4F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 13:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A646123A
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 20:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1008C433C9;
        Tue, 27 Jun 2023 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899190;
        bh=uDfTpqtgCWtUzszg8NsN8i3VJhtB66ykQkSTdRnCRjc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AsfRUUBQvlvcfShVqC49ri0eIUchu7MUUwuUxYHcTnlDnaFyZFi9tESuXmfcmsSo9
         IJpfV5N3y5AmG3Pg/Gjgk8dqWZB5Fs7VL6XljyrAT9k5CpbzLdQrYSNrabh2qsuDUa
         +6KFDB0y1HILKAKPU2PiJMIZw/Xh+avyh8TnKNv7d9LmWcsi9h4EPbQqeJddy13Tm5
         YzztQ4Bi9ZBZ96uqJ/9ypl060deYrY/iASHmFqdS7atJi14bAOP+Wr6HuNNW4s0URF
         C/NhCHUAyNNsfGQl1wxE9fQVPredj3zYSJENuTQrmjX3OP9jgus2WETPhSu1l6mR7/
         yOsInYXhHakiA==
Subject: [PATCH v5 1/3] libfs: Add directory operations for stable offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 27 Jun 2023 16:53:09 -0400
Message-ID: <168789918896.157531.14644838088821804546.stgit@manet.1015granger.net>
In-Reply-To: <168789864000.157531.11122232592994999253.stgit@manet.1015granger.net>
References: <168789864000.157531.11122232592994999253.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/libfs.c         |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |   19 ++++
 2 files changed, 271 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 89cf614a3271..9940dce049e6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,6 +239,258 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+static struct stable_offset_ctx *stable_ctx_get(struct inode *inode)
+{
+	return inode->i_op->get_so_ctx(inode);
+}
+
+static void stable_offset_set(struct dentry *dentry, unsigned long offset)
+{
+	dentry->d_fsdata = (void *)offset;
+}
+
+static unsigned long stable_offset_get(struct dentry *dentry)
+{
+	return (unsigned long)dentry->d_fsdata;
+}
+
+/**
+ * stable_offset_init - initialize a parent directory
+ * @so_ctx: directory offset map to be initialized
+ *
+ */
+void stable_offset_init(struct stable_offset_ctx *so_ctx)
+{
+	xa_init_flags(&so_ctx->xa, XA_FLAGS_ALLOC1);
+
+	/* 0 is '.', 1 is '..', so always start with offset 2 */
+	so_ctx->next_offset = 2;
+}
+
+/**
+ * stable_offset_add - Add an entry to a directory's stable offset map
+ * @so_ctx: directory offset ctx to be updated
+ * @dentry: new dentry being added
+ *
+ * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Otherwise, a negative errno value is returned.
+ */
+int stable_offset_add(struct stable_offset_ctx *so_ctx, struct dentry *dentry)
+{
+	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	u32 offset;
+	int ret;
+
+	if (stable_offset_get(dentry) != 0)
+		return -EBUSY;
+
+	ret = xa_alloc_cyclic(&so_ctx->xa, &offset, dentry, limit,
+			      &so_ctx->next_offset, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	stable_offset_set(dentry, offset);
+	return 0;
+}
+
+/**
+ * stable_offset_remove - Remove an entry to a directory's stable offset map
+ * @so_ctx: directory offset ctx to be updated
+ * @dentry: dentry being removed
+ *
+ */
+void stable_offset_remove(struct stable_offset_ctx *so_ctx,
+			  struct dentry *dentry)
+{
+	unsigned long index = stable_offset_get(dentry);
+
+	if (index == 0)
+		return;
+
+	xa_erase(&so_ctx->xa, index);
+	stable_offset_set(dentry, 0);
+}
+
+/**
+ * stable_offset_rename_exchange - exchange rename with stable directory offsets
+ * @old_dir: parent of dentry being moved
+ * @old_dentry: dentry being moved
+ * @new_dir: destination parent
+ * @new_dentry: destination dentry
+ *
+ * Returns zero on success. Otherwise a negative errno is returned and the
+ * rename is rolled back.
+ */
+int stable_offset_rename_exchange(struct inode *old_dir,
+				  struct dentry *old_dentry,
+				  struct inode *new_dir,
+				  struct dentry *new_dentry)
+{
+	struct stable_offset_ctx *old_ctx = stable_ctx_get(old_dir);
+	struct stable_offset_ctx *new_ctx = stable_ctx_get(new_dir);
+	unsigned long old_index = stable_offset_get(old_dentry);
+	unsigned long new_index = stable_offset_get(new_dentry);
+	int ret;
+
+	stable_offset_remove(old_ctx, old_dentry);
+	stable_offset_remove(new_ctx, new_dentry);
+
+	ret = stable_offset_add(new_ctx, old_dentry);
+	if (ret)
+		goto out_restore;
+
+	ret = stable_offset_add(old_ctx, new_dentry);
+	if (ret) {
+		stable_offset_remove(new_ctx, old_dentry);
+		goto out_restore;
+	}
+
+	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+	if (ret) {
+		stable_offset_remove(new_ctx, old_dentry);
+		stable_offset_remove(old_ctx, new_dentry);
+		goto out_restore;
+	}
+	return 0;
+
+out_restore:
+	stable_offset_set(old_dentry, old_index);
+	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
+	stable_offset_set(new_dentry, new_index);
+	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	return ret;
+}
+
+/**
+ * stable_offset_destroy - Release offset map
+ * @so_ctx: directory offset ctx that is about to be destroyed
+ *
+ * During fs teardown (eg. umount), a directory's offset map might still
+ * contain entries. xa_destroy() cleans out anything that remains.
+ */
+void stable_offset_destroy(struct stable_offset_ctx *so_ctx)
+{
+	xa_destroy(&so_ctx->xa);
+}
+
+/**
+ * stable_dir_llseek - Advance the read position of a directory descriptor
+ * @file: an open directory whose position is to be updated
+ * @offset: a byte offset
+ * @whence: enumerator describing the starting position for this update
+ *
+ * SEEK_END, SEEK_DATA, and SEEK_HOLE are not supported for directories.
+ *
+ * Returns the updated read position if successful; otherwise a
+ * negative errno is returned and the read position remains unchanged.
+ */
+static loff_t stable_dir_llseek(struct file *file, loff_t offset, int whence)
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
+static struct dentry *stable_find_next(struct xa_state *xas)
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
+static bool stable_dir_emit(struct dir_context *ctx, struct dentry *dentry)
+{
+	loff_t offset = stable_offset_get(dentry);
+	struct inode *inode = d_inode(dentry);
+
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
+			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
+}
+
+static void stable_iterate_dir(struct dentry *dir, struct dir_context *ctx)
+{
+	struct stable_offset_ctx *so_ctx = stable_ctx_get(d_inode(dir));
+	XA_STATE(xas, &so_ctx->xa, ctx->pos);
+	struct dentry *dentry;
+
+	while (true) {
+		spin_lock(&dir->d_lock);
+		dentry = stable_find_next(&xas);
+		spin_unlock(&dir->d_lock);
+		if (!dentry)
+			break;
+
+		if (!stable_dir_emit(ctx, dentry)) {
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
+ * stable_readdir - Emit entries starting at offset @ctx->pos
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
+static int stable_readdir(struct file *file, struct dir_context *ctx)
+{
+	struct dentry *dir = file->f_path.dentry;
+
+	lockdep_assert_held(&d_inode(dir)->i_rwsem);
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	stable_iterate_dir(dir, ctx);
+	return 0;
+}
+
+const struct file_operations stable_dir_operations = {
+	.llseek		= stable_dir_llseek,
+	.iterate_shared	= stable_readdir,
+	.read		= generic_read_dir,
+	.fsync		= noop_fsync,
+};
+
 static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
 {
 	struct dentry *child = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..16be31bd81f7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1767,6 +1767,7 @@ struct dir_context {
 
 struct iov_iter;
 struct io_uring_cmd;
+struct stable_offset_ctx;
 
 struct file_operations {
 	struct module *owner;
@@ -1854,6 +1855,7 @@ struct inode_operations {
 	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
+	struct stable_offset_ctx *(*get_so_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -2954,6 +2956,23 @@ extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
+struct stable_offset_ctx {
+	struct xarray		xa;
+	u32			next_offset;
+};
+
+void stable_offset_init(struct stable_offset_ctx *so_ctx);
+int stable_offset_add(struct stable_offset_ctx *so_ctx, struct dentry *dentry);
+void stable_offset_remove(struct stable_offset_ctx *so_ctx,
+			  struct dentry *dentry);
+int stable_offset_rename_exchange(struct inode *old_dir,
+				  struct dentry *old_dentry,
+				  struct inode *new_dir,
+				  struct dentry *new_dentry);
+void stable_offset_destroy(struct stable_offset_ctx *so_ctx);
+
+extern const struct file_operations stable_dir_operations;
+
 extern int __generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 


