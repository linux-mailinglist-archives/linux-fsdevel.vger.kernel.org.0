Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E2F73E81B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjFZSXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFZSW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960D171F
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8923A60F6D
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 18:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C32C433CB;
        Mon, 26 Jun 2023 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687803688;
        bh=1wHRscUWByrnZ9ONV+EzuEel/ddXYcfwzYGKwxTIgBo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iJ/EtPCcGyRNY0O7oTdG/ed8r9FNUIU5QbUQbLPmOq07D300LFC66jOFK1xIhRQ12
         qo9DcHw8W/Pv77gIpWkwfjufhZXoNBfp7VP+4uubFwk02nbqwBJUtJ4XqHTzUa5hgg
         B0xClO4nSA8bTQp3yLpWrJunwMQPUhy1yTnVaSVsMz7Aefb8mb0glzmSMBbOmlD0gB
         GBCMH/ADbZDkJCKhaX5mV6ME+XnuVOf8xp3KIoBLSV0d5JVkhP3XdKxjV9eZ3ct/bV
         cOavoCOSiitED+w58+wdqPVnYqZnxk1ghKUKJJk3gJvOXMiWhY/71BjTGjKZdpn8xh
         ZI5SH2UajmO2A==
Subject: [PATCH v4 1/3] libfs: Add directory operations for stable offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 26 Jun 2023 14:21:27 -0400
Message-ID: <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
In-Reply-To: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
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
 fs/dcache.c            |    1 
 fs/libfs.c             |  185 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |    1 
 include/linux/fs.h     |    9 ++
 4 files changed, 196 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6b..9c9a801f3b33 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1813,6 +1813,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_sb = sb;
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
+	dentry->d_offset = 0;
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
diff --git a/fs/libfs.c b/fs/libfs.c
index 89cf614a3271..07317bbe1668 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,6 +239,191 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+/**
+ * stable_offset_init - initialize a parent directory
+ * @dir: parent directory to be initialized
+ *
+ */
+void stable_offset_init(struct inode *dir)
+{
+	xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
+	dir->i_next_offset = 0;
+}
+EXPORT_SYMBOL(stable_offset_init);
+
+/**
+ * stable_offset_add - Add an entry to a directory's stable offset map
+ * @dir: parent directory being modified
+ * @dentry: new dentry being added
+ *
+ * Returns zero on success. Otherwise, a negative errno value is returned.
+ */
+int stable_offset_add(struct inode *dir, struct dentry *dentry)
+{
+	struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	u32 offset = 0;
+	int ret;
+
+	if (dentry->d_offset)
+		return -EBUSY;
+
+	ret = xa_alloc_cyclic(&dir->i_doff_map, &offset, dentry, limit,
+			      &dir->i_next_offset, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	dentry->d_offset = offset;
+	return 0;
+}
+EXPORT_SYMBOL(stable_offset_add);
+
+/**
+ * stable_offset_remove - Remove an entry to a directory's stable offset map
+ * @dir: parent directory being modified
+ * @dentry: dentry being removed
+ *
+ */
+void stable_offset_remove(struct inode *dir, struct dentry *dentry)
+{
+	if (!dentry->d_offset)
+		return;
+
+	xa_erase(&dir->i_doff_map, dentry->d_offset);
+	dentry->d_offset = 0;
+}
+EXPORT_SYMBOL(stable_offset_remove);
+
+/**
+ * stable_offset_destroy - Release offset map
+ * @dir: parent directory that is about to be destroyed
+ *
+ * During fs teardown (eg. umount), a directory's offset map might still
+ * contain entries. xa_destroy() cleans out anything that remains.
+ */
+void stable_offset_destroy(struct inode *dir)
+{
+	xa_destroy(&dir->i_doff_map);
+}
+EXPORT_SYMBOL(stable_offset_destroy);
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
+	struct inode *inode = d_inode(dentry);
+
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
+			  dentry->d_offset, inode->i_ino,
+			  fs_umode_to_dtype(inode->i_mode));
+}
+
+static void stable_iterate_dir(struct dentry *dir, struct dir_context *ctx)
+{
+	XA_STATE(xas, &((d_inode(dir))->i_doff_map), ctx->pos);
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
+EXPORT_SYMBOL(stable_dir_operations);
+
 static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
 {
 	struct dentry *child = NULL;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..579ce1800efe 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -96,6 +96,7 @@ struct dentry {
 	struct super_block *d_sb;	/* The root of the dentry tree */
 	unsigned long d_time;		/* used by d_revalidate */
 	void *d_fsdata;			/* fs-specific data */
+	u32 d_offset;			/* directory offset in parent */
 
 	union {
 		struct list_head d_lru;		/* LRU list */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..3fc2c04ed8ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -719,6 +719,10 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
+
+	/* simplefs stable directory offset tracking */
+	struct xarray		i_doff_map;
+	u32			i_next_offset;
 } __randomize_layout;
 
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
@@ -2924,6 +2928,10 @@ extern int simple_rename(struct mnt_idmap *, struct inode *,
 			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
+extern void stable_offset_init(struct inode *dir);
+extern int stable_offset_add(struct inode *dir, struct dentry *dentry);
+extern void stable_offset_remove(struct inode *dir, struct dentry *dentry);
+extern void stable_offset_destroy(struct inode *dir);
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
@@ -2939,6 +2947,7 @@ extern const struct dentry_operations simple_dentry_operations;
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);
 extern const struct file_operations simple_dir_operations;
+extern const struct file_operations stable_dir_operations;
 extern const struct inode_operations simple_dir_inode_operations;
 extern void make_empty_dir_inode(struct inode *inode);
 extern bool is_empty_dir_inode(struct inode *inode);


