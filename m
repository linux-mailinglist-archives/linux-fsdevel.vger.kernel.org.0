Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB62B40CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 11:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgKPKS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 05:18:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbgKPKSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:32 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3179920888;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=/0UTpmNdjgzB4jiLsbhbyzevPCFzKlmF79DNv+0+NtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VM1AC4LLbB6O6a3PnfxqwLswksfKHn14t8gjmZWYf17Hm7cdPRT/2io5qXXSy9jTg
         edoRIxbfrOdZcdnFE+A21R38lQih2sF0pP3acRLrvw5pi2lhOGCMcLPYGhfSQ8owZo
         pomdl2K0MuOQT0+Xjab8KOJZYOsHXXH7fXq5jnp0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwED-7j; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/27] fs: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:07 +0100
Message-Id: <e5ed3dceb48ab40817db3c876e32183999868236.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two markups are at the wrong place. Kernel-doc only
support having the comment just before the identifier.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/dcache.c   | 72 +++++++++++++++++++++++++--------------------------
 fs/inode.c    |  4 +--
 fs/seq_file.c |  5 ++--
 fs/super.c    | 12 ++++-----
 4 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..6eabb48a49fc 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -439,85 +439,85 @@ static void d_shrink_add(struct dentry *dentry, struct list_head *list)
 static void d_lru_isolate(struct list_lru_one *lru, struct dentry *dentry)
 {
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags &= ~DCACHE_LRU_LIST;
 	this_cpu_dec(nr_dentry_unused);
 	if (d_is_negative(dentry))
 		this_cpu_dec(nr_dentry_negative);
 	list_lru_isolate(lru, &dentry->d_lru);
 }
 
 static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 			      struct list_head *list)
 {
 	D_FLAG_VERIFY(dentry, DCACHE_LRU_LIST);
 	dentry->d_flags |= DCACHE_SHRINK_LIST;
 	if (d_is_negative(dentry))
 		this_cpu_dec(nr_dentry_negative);
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
 }
 
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent dentry hashes, so that it won't
- * be found through a VFS lookup any more. Note that this is different from
- * deleting the dentry - d_delete will try to mark the dentry negative if
- * possible, giving a successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
- * reason (NFS timeouts or autofs deletes).
- *
- * __d_drop requires dentry->d_lock
- * ___d_drop doesn't mark dentry as "unhashed"
- *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
- */
 static void ___d_drop(struct dentry *dentry)
 {
 	struct hlist_bl_head *b;
 	/*
 	 * Hashed dentries are normally on the dentry hashtable,
 	 * with the exception of those newly allocated by
 	 * d_obtain_root, which are always IS_ROOT:
 	 */
 	if (unlikely(IS_ROOT(dentry)))
 		b = &dentry->d_sb->s_roots;
 	else
 		b = d_hash(dentry->d_name.hash);
 
 	hlist_bl_lock(b);
 	__hlist_bl_del(&dentry->d_hash);
 	hlist_bl_unlock(b);
 }
 
 void __d_drop(struct dentry *dentry)
 {
 	if (!d_unhashed(dentry)) {
 		___d_drop(dentry);
 		dentry->d_hash.pprev = NULL;
 		write_seqcount_invalidate(&dentry->d_seq);
 	}
 }
 EXPORT_SYMBOL(__d_drop);
 
+/**
+ * d_drop - drop a dentry
+ * @dentry: dentry to drop
+ *
+ * d_drop() unhashes the entry from the parent dentry hashes, so that it won't
+ * be found through a VFS lookup any more. Note that this is different from
+ * deleting the dentry - d_delete will try to mark the dentry negative if
+ * possible, giving a successful _negative_ lookup, while d_drop will
+ * just make the cache lookup fail.
+ *
+ * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
+ * reason (NFS timeouts or autofs deletes).
+ *
+ * __d_drop requires dentry->d_lock
+ * ___d_drop doesn't mark dentry as "unhashed"
+ *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
+ */
 void d_drop(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(d_drop);
 
 static inline void dentry_unlist(struct dentry *dentry, struct dentry *parent)
 {
 	struct dentry *next;
 	/*
 	 * Inform d_walk() and shrink_dentry_list() that we are no longer
 	 * attached to the dentry tree
 	 */
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
 	if (unlikely(list_empty(&dentry->d_child)))
 		return;
 	__list_del_entry(&dentry->d_child);
 	/*
@@ -972,73 +972,73 @@ static struct dentry * __d_find_any_alias(struct inode *inode)
 }
 
 /**
  * d_find_any_alias - find any alias for a given inode
  * @inode: inode to find an alias for
  *
  * If any aliases exist for the given inode, take and return a
  * reference for one of them.  If no aliases exist, return %NULL.
  */
 struct dentry *d_find_any_alias(struct inode *inode)
 {
 	struct dentry *de;
 
 	spin_lock(&inode->i_lock);
 	de = __d_find_any_alias(inode);
 	spin_unlock(&inode->i_lock);
 	return de;
 }
 EXPORT_SYMBOL(d_find_any_alias);
 
+static struct dentry *__d_find_alias(struct inode *inode)
+{
+	struct dentry *alias;
+
+	if (S_ISDIR(inode->i_mode))
+		return __d_find_any_alias(inode);
+
+	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+		spin_lock(&alias->d_lock);
+ 		if (!d_unhashed(alias)) {
+			__dget_dlock(alias);
+			spin_unlock(&alias->d_lock);
+			return alias;
+		}
+		spin_unlock(&alias->d_lock);
+	}
+	return NULL;
+}
+
 /**
  * d_find_alias - grab a hashed alias of inode
  * @inode: inode in question
  *
  * If inode has a hashed alias, or is a directory and has any alias,
  * acquire the reference to alias and return it. Otherwise return NULL.
  * Notice that if inode is a directory there can be only one alias and
  * it can be unhashed only if it has no children, or if it is the root
  * of a filesystem, or if the directory was renamed and d_revalidate
  * was the first vfs operation to notice.
  *
  * If the inode has an IS_ROOT, DCACHE_DISCONNECTED alias, then prefer
  * any other hashed alias over that one.
  */
-static struct dentry *__d_find_alias(struct inode *inode)
-{
-	struct dentry *alias;
-
-	if (S_ISDIR(inode->i_mode))
-		return __d_find_any_alias(inode);
-
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		spin_lock(&alias->d_lock);
- 		if (!d_unhashed(alias)) {
-			__dget_dlock(alias);
-			spin_unlock(&alias->d_lock);
-			return alias;
-		}
-		spin_unlock(&alias->d_lock);
-	}
-	return NULL;
-}
-
 struct dentry *d_find_alias(struct inode *inode)
 {
 	struct dentry *de = NULL;
 
 	if (!hlist_empty(&inode->i_dentry)) {
 		spin_lock(&inode->i_lock);
 		de = __d_find_alias(inode);
 		spin_unlock(&inode->i_lock);
 	}
 	return de;
 }
 EXPORT_SYMBOL(d_find_alias);
 
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
  */
 void d_prune_aliases(struct inode *inode)
 {
 	struct dentry *dentry;
diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..aad3dcf2e259 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1479,41 +1479,41 @@ EXPORT_SYMBOL(find_inode_nowait);
 struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 			     int (*test)(struct inode *, void *), void *data)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_rcu() usage");
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
 		    test(inode, data))
 			return inode;
 	}
 	return NULL;
 }
 EXPORT_SYMBOL(find_inode_rcu);
 
 /**
- * find_inode_by_rcu - Find an inode in the inode cache
+ * find_inode_by_ino_rcu - Find an inode in the inode cache
  * @sb:		Super block of file system to search
  * @ino:	The inode number to match
  *
  * Search for the inode specified by @hashval and @data in the inode cache,
  * where the helper function @test will return 0 if the inode does not match
  * and 1 if it does.  The @test function must be responsible for taking the
  * i_lock spin_lock and checking i_state for an inode being freed or being
  * initialized.
  *
  * If successful, this will return the inode for which the @test function
  * returned 1 and NULL otherwise.
  *
  * The @test function is not permitted to take a ref on any inode presented.
  * It is also not permitted to sleep.
  *
  * The caller must hold the RCU read lock.
  */
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 				    unsigned long ino)
 {
@@ -1761,41 +1761,41 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 
 	if (dirty)
 		iflags |= I_DIRTY_SYNC;
 	__mark_inode_dirty(inode, iflags);
 	return 0;
 }
 EXPORT_SYMBOL(generic_update_time);
 
 /*
  * This does the actual work of updating an inodes time or version.  Must have
  * had called mnt_want_write() before calling this.
  */
 static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
 	if (inode->i_op->update_time)
 		return inode->i_op->update_time(inode, time, flags);
 	return generic_update_time(inode, time, flags);
 }
 
 /**
- *	touch_atime	-	update the access time
+ *	atime_needs_update	-	update the access time
  *	@path: the &struct path to update
  *	@inode: inode to update
  *
  *	Update the accessed time on an inode and mark it for writeback.
  *	This function automatically handles read only file systems and media,
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
 bool atime_needs_update(const struct path *path, struct inode *inode)
 {
 	struct vfsmount *mnt = path->mnt;
 	struct timespec64 now;
 
 	if (inode->i_flags & S_NOATIME)
 		return false;
 
 	/* Atime updates will likely cause i_uid and i_gid to be written
 	 * back improprely if their true value is unknown to the vfs.
 	 */
 	if (HAS_UNMAPPED_ID(inode))
 		return false;
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 07b33c1f34a9..7e16eaea999b 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -647,41 +647,42 @@ void seq_putc(struct seq_file *m, char c)
 		return;
 
 	m->buf[m->count++] = c;
 }
 EXPORT_SYMBOL(seq_putc);
 
 void seq_puts(struct seq_file *m, const char *s)
 {
 	int len = strlen(s);
 
 	if (m->count + len >= m->size) {
 		seq_set_overflow(m);
 		return;
 	}
 	memcpy(m->buf + m->count, s, len);
 	m->count += len;
 }
 EXPORT_SYMBOL(seq_puts);
 
 /**
- * A helper routine for putting decimal numbers without rich format of printf().
+ * seq_put_decimal_ull_width - A helper routine for putting decimal numbers
+ * 			       without rich format of printf().
  * only 'unsigned long long' is supported.
  * @m: seq_file identifying the buffer to which data should be written
  * @delimiter: a string which is printed before the number
  * @num: the number
  * @width: a minimum field width
  *
  * This routine will put strlen(delimiter) + number into seq_filed.
  * This routine is very quick when you show lots of numbers.
  * In usual cases, it will be better to use seq_printf(). It's easier to read.
  */
 void seq_put_decimal_ull_width(struct seq_file *m, const char *delimiter,
 			 unsigned long long num, unsigned int width)
 {
 	int len;
 
 	if (m->count + 2 >= m->size) /* we'll write 2 bytes at least */
 		goto overflow;
 
 	if (delimiter && delimiter[0]) {
 		if (delimiter[1] == 0)
@@ -1022,41 +1023,41 @@ EXPORT_SYMBOL(seq_hlist_start_head_rcu);
  *
  * This list-traversal primitive may safely run concurrently with
  * the _rcu list-mutation primitives such as hlist_add_head_rcu()
  * as long as the traversal is guarded by rcu_read_lock().
  */
 struct hlist_node *seq_hlist_next_rcu(void *v,
 				      struct hlist_head *head,
 				      loff_t *ppos)
 {
 	struct hlist_node *node = v;
 
 	++*ppos;
 	if (v == SEQ_START_TOKEN)
 		return rcu_dereference(head->first);
 	else
 		return rcu_dereference(node->next);
 }
 EXPORT_SYMBOL(seq_hlist_next_rcu);
 
 /**
- * seq_hlist_start_precpu - start an iteration of a percpu hlist array
+ * seq_hlist_start_percpu - start an iteration of a percpu hlist array
  * @head: pointer to percpu array of struct hlist_heads
  * @cpu:  pointer to cpu "cursor"
  * @pos:  start position of sequence
  *
  * Called at seq_file->op->start().
  */
 struct hlist_node *
 seq_hlist_start_percpu(struct hlist_head __percpu *head, int *cpu, loff_t pos)
 {
 	struct hlist_node *node;
 
 	for_each_possible_cpu(*cpu) {
 		hlist_for_each(node, per_cpu_ptr(head, *cpu)) {
 			if (pos-- == 0)
 				return node;
 		}
 	}
 	return NULL;
 }
 EXPORT_SYMBOL(seq_hlist_start_percpu);
diff --git a/fs/super.c b/fs/super.c
index 98bb0629ee10..912636bbda9e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1754,67 +1754,67 @@ int freeze_super(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb);
 			wake_up(&sb->s_writers.wait_unfrozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
 	}
 	/*
 	 * For debugging purposes so that fs can warn if it sees write activity
 	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
 	 */
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	lockdep_sb_freeze_release(sb);
 	up_write(&sb->s_umount);
 	return 0;
 }
 EXPORT_SYMBOL(freeze_super);
 
-/**
- * thaw_super -- unlock filesystem
- * @sb: the super to thaw
- *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
- */
 static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
 	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
 		up_write(&sb->s_umount);
 		return -EINVAL;
 	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		goto out;
 	}
 
 	lockdep_sb_freeze_acquire(sb);
 
 	if (sb->s_op->unfreeze_fs) {
 		error = sb->s_op->unfreeze_fs(sb);
 		if (error) {
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
 			up_write(&sb->s_umount);
 			return error;
 		}
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
 	return 0;
 }
 
+/**
+ * thaw_super -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ */
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
-- 
2.28.0

