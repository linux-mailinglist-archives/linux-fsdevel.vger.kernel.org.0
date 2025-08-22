Return-Path: <linux-fsdevel+bounces-58713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B9B30A13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B42A334A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF035942;
	Fri, 22 Aug 2025 00:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2841373;
	Fri, 22 Aug 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821483; cv=none; b=CDRv+zI3zQBeFs2XTcgFPomCkjFn6LzZOHIf9djHWwSI7Ekvn1o0K+SLrKID1aVTPOm0zvPE7TfZg+aGAqfndUpgCnwom82QDqseNuzyEI6J8NbAjcC+PbWjxP03rCNzHOcp0YMxlCFBpM9dxLxAbQOWrJDrW+TIuRMIwU9rk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821483; c=relaxed/simple;
	bh=6seksQbHnpEHkKSoawkYuBxKLOfnGApYqhYzmA3oVgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxP99mLpDyGS533U3xRu+kWG1DgLocxioW/y/bEFU1Cl3ayZiN58zjltXrln+46ZJaP6UdIyHpDCS+xN0czqKMM3h0Ra7EE48wW1iQt4DzFPIVNGUPUUT74L9Z70QqGnfjqf1HZQKuqRcwyKUl8Ti4HZD3Wi/jiPx/618GhpY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFN9-006naj-JP;
	Fri, 22 Aug 2025 00:11:13 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/16] VFS: use global wait-queue table for d_alloc_parallel()
Date: Fri, 22 Aug 2025 10:00:22 +1000
Message-ID: <20250822000818.1086550-5-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_alloc_parallel() is currently given a wait_queue_head to be used if
other threads need to wait for the lookup resulting dentry to complete.
This must have a life time which extends until the lookup is completed.

Future proposed patches will use d_alloc_parallel() for names being
created/unlinked etc.  Some filesystems combine lookup with create
making a longer code path that the wq needs to live for.  If it is still
to be allocated on-stack this can be cumbersome.

This patch replaces the on-stack wqs with a global array of wqs which
are used as needed.  A wq is NOT allocated when a dentry is first
created but only when a second thread attempts to use the same name and
so is forced to wait.  At this moment a wq is chosen using a hash of the
dentry pointer and that wq is assigned to ->d_wait.  The ->d_lock is
then dropped and the task waits.

When the dentry is finally moved out of "d_in_lookup" a wake up is only
sent if ->d_wait is not NULL.  This avoids an (uncontended) spin
lock/unlock which saves a couple of atomic operations in a common case.

The wake up passes the dentry that the wake up is for as the "key" and
the waiter will only wakes processes waiting on the same key.  This means
that when these global waitqueues are shared (which is inevitable
though unlikely to be frequent), a task will not be woken prematurely.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  6 ++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 82 ++++++++++++++++++++++-----
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +-
 fs/nfs/dir.c                          |  7 +--
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                |  3 +-
 include/linux/nfs_xdr.h               |  1 -
 12 files changed, 84 insertions(+), 40 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..96107c15e928 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,9 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+---
+
+** mandatory**
+
+d_alloc_parallel() signature has changed - it no longer receives a
+waitqueue_head.  It uses one from an internal table when needed.
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 0b80eb93fa40..ce76b3b30850 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -237,13 +237,11 @@ int afs_silly_iput(struct dentry *dentry, struct inode *inode)
 	struct dentry *alias;
 	int ret;
 
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
 
 	down_read(&dvnode->rmdir_lock);
 
-	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 	if (IS_ERR(alias)) {
 		up_read(&dvnode->rmdir_lock);
 		return 0;
diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..df9306c63581 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2137,8 +2137,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2148,7 +2147,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2505,6 +2504,49 @@ void d_rehash(struct dentry * entry)
 }
 EXPORT_SYMBOL(d_rehash);
 
+#define	PAR_LOOKUP_WQ_BITS	8
+#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
+static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
+static inline wait_queue_head_t *par_waitq(struct dentry *dentry)
+{
+	return &par_wait_table[hash_ptr(dentry, PAR_LOOKUP_WQ_BITS)];
+}
+
+static int __init par_wait_init(void)
+{
+	int i;
+
+	for (i = 0; i < PAR_LOOKUP_WQS; i++)
+		init_waitqueue_head(&par_wait_table[i]);
+	return 0;
+}
+
+struct par_wait_key {
+	struct dentry *de;
+	struct wait_queue_entry wqe;
+};
+
+static int d_wait_wake_fn(struct wait_queue_entry *wq_entry,
+			  unsigned mode, int sync, void *key)
+{
+	struct par_wait_key *pwk = container_of(wq_entry,
+						 struct par_wait_key, wqe);
+	if (pwk->de == key)
+		return default_wake_function(wq_entry, mode, sync, key);
+	return 0;
+}
+
+static inline void d_wake_waiters(struct wait_queue_head *d_wait,
+				  struct dentry *dentry)
+{
+	/* ->d_wait is only set if some thread is actually waiting.
+	 * If we find it is NULL - the common case - then there was no
+	 * contention and there are no waiters to be woken.
+	 */
+	if (d_wait)
+		wake_up_key(d_wait, dentry);
+}
+
 static inline unsigned start_dir_add(struct inode *dir)
 {
 	preempt_disable_nested();
@@ -2517,31 +2559,39 @@ static inline unsigned start_dir_add(struct inode *dir)
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       wait_queue_head_t *d_wait, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	if (wq_has_sleeper(d_wait))
-		wake_up_all(d_wait);
+	d_wake_waiters(d_wait, de);
 }
 
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
+		struct par_wait_key wk = {
+			.de = dentry,
+			.wqe = {
+				.private = current,
+				.func = d_wait_wake_fn,
+			},
+		};
+		struct wait_queue_head *wq;
+		if (!dentry->d_wait)
+			dentry->d_wait = par_waitq(dentry);
+		wq = dentry->d_wait;
+		add_wait_queue(wq, &wk.wqe);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock(&dentry->d_lock);
 			schedule();
 			spin_lock(&dentry->d_lock);
 		} while (d_in_lookup(dentry));
+		remove_wait_queue(wq, &wk.wqe);
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+struct dentry *d_alloc_parallel(struct dentry *parent, const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2554,6 +2604,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return ERR_PTR(-ENOMEM);
 
 	new->d_flags |= DCACHE_PAR_LOOKUP;
+	new->d_wait = NULL;
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
@@ -2642,7 +2693,6 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		return dentry;
 	}
 	rcu_read_unlock();
-	new->d_wait = wq;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2680,7 +2730,7 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	d_wake_waiters(__d_lookup_unhash(dentry), dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2711,7 +2761,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode,
 	}
 	__d_rehash(dentry);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2877,7 +2927,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
@@ -3241,6 +3291,8 @@ static void __init dcache_init(void)
 
 	runtime_const_init(shift, d_hash_shift);
 	runtime_const_init(ptr, dentry_hashtable);
+
+	par_wait_init();
 }
 
 /* SLAB cache for __getname() consumers */
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..f588252891af 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -160,7 +160,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int epoch;
 
 	if (!o->nodeid) {
@@ -197,7 +196,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 1d5fdcbe1828..7a2d72ee1af1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1784,13 +1784,12 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry = d_alloc_parallel(dir, name, &wq);
+	dentry = d_alloc_parallel(dir, name);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
@@ -3618,7 +3617,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3627,7 +3625,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..d00b7b2781fa 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -727,7 +727,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -756,7 +755,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2060,7 +2059,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2115,8 +2113,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry)) {
 		d_drop(dentry);
 		switched = true;
-		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
+		dentry = d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 		if (unlikely(!d_in_lookup(dentry)))
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b55467911648..894af85830fa 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -124,7 +124,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct dentry *alias;
 
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
-	alias = d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
+	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
@@ -185,7 +185,6 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr *name)
 
 	data->cred = get_current_cred();
 	data->res.dir_attr = &data->dir_attr;
-	init_waitqueue_head(&data->wq);
 
 	status = -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..0b296c94000e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2129,8 +2129,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 
 	child = try_lookup_noperm(&qname, dir);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			goto end_instantiate;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 49ab74e0bfde..04a382178c65 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -692,8 +692,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 4e5460206397..5a92a1ad317d 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -74,7 +74,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool posix = cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 	bool reparse_need_reval = false;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int rc;
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
@@ -106,7 +105,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name, &wq);
+		dentry = d_alloc_parallel(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index cc3e1c1a3454..c1239af19d68 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -241,8 +241,7 @@ extern void d_delete(struct dentry *);
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ac4bff6e9913..197c9b30dfdf 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1735,7 +1735,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.50.0.107.gf914562f5916.dirty


