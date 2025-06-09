Return-Path: <linux-fsdevel+bounces-50986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60239AD1978
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE42169359
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C32820CA;
	Mon,  9 Jun 2025 08:00:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5328137D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456008; cv=none; b=qmJJRhDTBubTzWx9/9LwGplm6auIU1iIvWn0ujSnEyfy8nlu2WRB0v4eCkbOCMpB8p+Qlw3FypCPCA1ObCYbJO0dB52+sezl8yV3H4mQHbSNqiRuyCJWpqBUn4NvixX8mzMPG19g39Bp53eaP5PzACfJvKYz7huoatixuePqskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456008; c=relaxed/simple;
	bh=VVRTBBqVPvOTLzL49tQ+zplhpa2iSgKhPorCTVuM0XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfKB5vZn/Axp01I4O7yFLW7Iqp4nck0dYTBb5+owELXZVl1ctF/0g86GBlbS3POmW8TV45kpYlBtrQYvzPU49S97CFnSYyKBrC9SSSBcYAl3WXMtmiCwZjaX5IfFRmQQyJpjMKHnfLNoJYkEykSpCk1mRL8m9ODky5LHL9eJbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOXQI-006HTW-UE;
	Mon, 09 Jun 2025 08:00:02 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] VFS: use global wait-queue table for d_alloc_parallel()
Date: Mon,  9 Jun 2025 17:34:06 +1000
Message-ID: <20250609075950.159417-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609075950.159417-1-neil@brown.name>
References: <20250609075950.159417-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
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

When the dentry is finally moved out of "in_lookup" a wake up is only
sent if ->d_wait is not NULL.  This avoids an (uncontended) spin
lock/unlock which saves a couple of atomic operations in a common case.

The wake up passes the dentry that the wake up is for as the "key" and
the waiter will only wake processes waiting on the same key.  This means
that when these global waitqueues are shared (which is inevitable
though unlikely to be frequent), a task will not be woken prematurely.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst |  6 +++
 fs/afs/dir_silly.c                    |  4 +-
 fs/dcache.c                           | 78 ++++++++++++++++++++++-----
 fs/fuse/readdir.c                     |  3 +-
 fs/namei.c                            |  6 +--
 fs/nfs/dir.c                          |  3 +-
 fs/nfs/unlink.c                       |  3 +-
 fs/proc/base.c                        |  3 +-
 fs/proc/proc_sysctl.c                 |  3 +-
 fs/proc/self.c                        |  3 +-
 fs/proc/thread_self.c                 |  4 +-
 fs/smb/client/readdir.c               |  3 +-
 include/linux/dcache.h                |  3 +-
 include/linux/nfs_xdr.h               |  1 -
 14 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 2cdd9e9ad7f9..385ca21e230e 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1265,3 +1265,9 @@ d_splice_alias() now works on a hashed dentry.  d_drop() need not, and
 must not, be called before d_splice_alias().  In general d_drop() must
 not be called in a directory-modifying operation until the operation has
 completed - typically when it completes with failure.
+---
+
+** mandatory**
+
+d_alloc_parallel() no longer requires a waitqueue_head.  It used one
+from an internal table when needed.
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index b0504bd45fa2..68e38429cf49 100644
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
index 246b00d3a2fb..c21122ccea4f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2121,8 +2121,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2132,7 +2131,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2489,6 +2488,46 @@ void d_rehash(struct dentry * entry)
 }
 EXPORT_SYMBOL(d_rehash);
 
+#define	PAR_LOOKUP_WQ_BITS	8
+#define PAR_LOOKUP_WQS (1 << PAR_LOOKUP_WQ_BITS)
+static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
+
+static int __init par_wait_init(void)
+{
+	int i;
+
+	for (i = 0; i < PAR_LOOKUP_WQS; i++)
+		init_waitqueue_head(&par_wait_table[i]);
+	return 0;
+}
+fs_initcall(par_wait_init);
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
+		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
+}
+
 static inline unsigned start_dir_add(struct inode *dir)
 {
 	preempt_disable_nested();
@@ -2501,31 +2540,41 @@ static inline unsigned start_dir_add(struct inode *dir)
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
+			dentry->d_wait = &par_wait_table[hash_ptr(dentry,
+								  PAR_LOOKUP_WQ_BITS)];
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
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2622,7 +2671,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	rcu_read_unlock();
 	/* we can't take ->d_lock here; it's OK, though. */
 	new->d_flags |= DCACHE_PAR_LOOKUP;
-	new->d_wait = wq;
+	/* Don't set a wait_queue until someone is actually waiting */
+	new->d_wait = NULL;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2660,7 +2710,7 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	d_wake_waiters(__d_lookup_unhash(dentry), dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2692,7 +2742,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 			   (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2858,7 +2908,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
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
index afba27fcf94e..0703568339d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1970,13 +1970,12 @@ static struct dentry *__lookup_slow(const struct qstr *name,
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
@@ -3953,7 +3952,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3962,7 +3960,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 311e517f822f..b435c3b627af 100644
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
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 2db8839b16ff..a67df3ae74ab 100644
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
index c667702dc69b..6a847ce8d718 100644
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
index cc9d74a06ff0..9f1088f138f4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -693,8 +693,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/self.c b/fs/proc/self.c
index b034f28506c9..08f7ea161eea 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -37,11 +37,10 @@ static unsigned self_inum __ro_after_init;
 int proc_setup_self(struct super_block *s)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(s);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *self;
 	int ret = -ENOMEM;
 
-	self = d_alloc_parallel(s->s_root, &QSTR_HASH(s->s_root, "self"), &wq);
+	self = d_alloc_parallel(s->s_root, &QSTR_HASH(s->s_root, "self"));
 	if (self && lock_and_check_dentry(self, s->s_root)) {
 		struct inode *inode = new_inode(s);
 		if (inode) {
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index 34bc7dd07632..6b08bd83490b 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -38,13 +38,11 @@ static unsigned thread_self_inum __ro_after_init;
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(s);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
 	thread_self = d_alloc_parallel(s->s_root,
-				       &QSTR_HASH(s->s_root,"thread-self"),
-				       &wq);
+				       &QSTR_HASH(s->s_root,"thread-self"));
 	if (thread_self && lock_and_check_dentry(thread_self, s->s_root)) {
 		struct inode *inode = new_inode(s);
 		if (inode) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index f9f11cbf89be..ae1c60efc475 100644
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
index 8c9ad0da0e02..2b8f8641e1f8 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -244,8 +244,7 @@ extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 67f6632f723b..d1c9c569a03e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1732,7 +1732,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.49.0


