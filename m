Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6A2CA243
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbgLAMLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 07:11:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgLAMKi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:38 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499DD20C56;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=QYd+u49f+2MKO4X5qwAv4mVC70qp18PRw1gtTOhe1xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XICRPP/SJM+wFLaSU3mUSNgVE2XJyZEOfVX2kcblmOhBOUe4i/bx5X6030IP8vOrI
         VM7wUb2bEpZMlCJLVGwASnkZzzgVQspKK4xYAnOwPxJbSg1h7g8GaRRdg7yACXPMAq
         QkV2PITa65xDu7pZXpli17athnLYnOy19YkGivX0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T2-00DGd2-VP; Tue, 01 Dec 2020 13:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/16] fs: fix kernel-doc markups
Date:   Tue,  1 Dec 2020 13:08:58 +0100
Message-Id: <46ccd8f26eb51b2eb092923d74eadf71fdca43d7.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
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
@@ -427,109 +427,109 @@ static void d_shrink_add(struct dentry *dentry, struct list_head *list)
 	D_FLAG_VERIFY(dentry, 0);
 	list_add(&dentry->d_lru, list);
 	dentry->d_flags |= DCACHE_SHRINK_LIST | DCACHE_LRU_LIST;
 	this_cpu_inc(nr_dentry_unused);
 }
 
 /*
  * These can only be called under the global LRU lock, ie during the
  * callback for freeing the LRU list. "isolate" removes it from the
  * LRU lists entirely, while shrink_move moves it to the indicated
  * private list.
  */
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
 	 * Cursors can move around the list of children.  While we'd been
 	 * a normal list member, it didn't matter - ->d_child.next would've
 	 * been updated.  However, from now on it won't be and for the
 	 * things like d_walk() it might end up with a nasty surprise.
 	 * Normally d_walk() doesn't care about cursors moving around -
 	 * ->d_lock on parent prevents that and since a cursor has no children
 	 * of its own, we get through it without ever unlocking the parent.
 	 * There is one exception, though - if we ascend from a child that
 	 * gets killed as soon as we unlock it, the next sibling is found
 	 * using the value left in its ->d_child.next.  And if _that_
 	 * pointed to a cursor, and cursor got moved (e.g. by lseek())
 	 * before d_walk() regains parent->d_lock, we'll end up skipping
@@ -960,97 +960,97 @@ struct dentry *dget_parent(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dget_parent);
 
 static struct dentry * __d_find_any_alias(struct inode *inode)
 {
 	struct dentry *alias;
 
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
 	alias = hlist_entry(inode->i_dentry.first, struct dentry, d_u.d_alias);
 	__dget(alias);
 	return alias;
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
 restart:
 	spin_lock(&inode->i_lock);
 	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&dentry->d_lock);
 		if (!dentry->d_lockref.count) {
 			struct dentry *parent = lock_parent(dentry);
 			if (likely(!dentry->d_lockref.count)) {
 				__dentry_kill(dentry);
 				dput(parent);
 				goto restart;
 			}
 			if (parent)
diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..aad3dcf2e259 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1467,65 +1467,65 @@ EXPORT_SYMBOL(find_inode_nowait);
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
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_by_ino_rcu() usage");
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
 		    return inode;
 	}
@@ -1749,65 +1749,65 @@ int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
 
 	if (flags & S_ATIME)
 		inode->i_atime = *time;
 	if (flags & S_VERSION)
 		dirty = inode_maybe_inc_iversion(inode, false);
 	if (flags & S_CTIME)
 		inode->i_ctime = *time;
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
 	    !(inode->i_sb->s_flags & SB_LAZYTIME))
 		dirty = true;
 
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
 
 	if (IS_NOATIME(inode))
 		return false;
 	if ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return false;
 
 	if (mnt->mnt_flags & MNT_NOATIME)
 		return false;
 	if ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return false;
 
 	now = current_time(inode);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 03a369ccd28c..cb11a34fb871 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -640,65 +640,66 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
 EXPORT_SYMBOL(__seq_open_private);
 
 int seq_open_private(struct file *filp, const struct seq_operations *ops,
 		int psize)
 {
 	return __seq_open_private(filp, ops, psize) ? 0 : -ENOMEM;
 }
 EXPORT_SYMBOL(seq_open_private);
 
 void seq_putc(struct seq_file *m, char c)
 {
 	if (m->count >= m->size)
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
 			seq_putc(m, delimiter[0]);
 		else
 			seq_puts(m, delimiter);
 	}
 
 	if (!width)
 		width = 1;
 
 	if (m->count + width >= m->size)
 		goto overflow;
 
 	len = num_to_str(m->buf + m->count, m->size - m->count, num, width);
@@ -1015,65 +1016,65 @@ struct hlist_node *seq_hlist_start_head_rcu(struct hlist_head *head,
 
 	return seq_hlist_start_rcu(head, pos - 1);
 }
 EXPORT_SYMBOL(seq_hlist_start_head_rcu);
 
 /**
  * seq_hlist_next_rcu - move to the next position of the hlist protected by RCU
  * @v:    the current iterator
  * @head: the head of the hlist
  * @ppos: the current position
  *
  * Called at seq_file->op->next().
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
 
 /**
  * seq_hlist_next_percpu - move to the next position of the percpu hlist array
  * @v:    pointer to current hlist_node
  * @head: pointer to percpu array of struct hlist_heads
  * @cpu:  pointer to cpu "cursor"
  * @pos:  start position of sequence
  *
  * Called at seq_file->op->next().
  */
 struct hlist_node *
 seq_hlist_next_percpu(void *v, struct hlist_head __percpu *head,
diff --git a/fs/super.c b/fs/super.c
index 98bb0629ee10..912636bbda9e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1742,79 +1742,79 @@ int freeze_super(struct super_block *sb)
 	sb_wait_write(sb, SB_FREEZE_PAGEFAULT);
 
 	/* All writers are done so after syncing there won't be dirty data */
 	sync_filesystem(sb);
 
 	/* Now wait for internal filesystem counter */
 	sb->s_writers.frozen = SB_FREEZE_FS;
 	sb_wait_write(sb, SB_FREEZE_FS);
 
 	if (sb->s_op->freeze_fs) {
 		ret = sb->s_op->freeze_fs(sb);
 		if (ret) {
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

