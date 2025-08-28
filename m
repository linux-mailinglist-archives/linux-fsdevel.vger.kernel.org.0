Return-Path: <linux-fsdevel+bounces-59511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD61B3A64F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30921C83BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A060232C331;
	Thu, 28 Aug 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T8SN6q+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D977E32A3CC;
	Thu, 28 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398611; cv=none; b=oXi3ZqFxQ7j/SgNu1OdQ8gCjUJv3y+mKmmDQPoWSxW/2cQxANTVm4AdORrFcaH5hD4PUMytsu9VLYBQIy0ompMwwFvq6GhRtGEAUCqp1jhd+sqgQMpu5zuYPTGiGekXliZYvewk7A6FtkGGZFDEQm4rvDC94TSMUZpEfhYOMRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398611; c=relaxed/simple;
	bh=+9zKVMpylfQNvcbkJwuYOGdZA0ABLTUuM1wFzjzPeB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6nCc/+UGZaKeF5DqbZqW1cdvXy8xm2/3QknV+Kam/Z0dnfnzcjZwwFkyzychhYsSj3PHTeShK8mcMVLZbLu2TRnaOYHr40fNKbA9wS9vexCxGlrALW7/PgPx0SlFJHNYjrso38Xt5lCBPfUbBdEOzCk9qGQOjZ6NGCUsPvxJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T8SN6q+X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KCesoYqK5Nb2ZHseg+FmDzc2B7h3U6VBtUwWAsN/KMM=; b=T8SN6q+XB+G3Fkq1ypppzZ0IIb
	Z8Kn2Uh2eOYyv950joC4m+Bs6SDohCi7ecU2Qpx5tL8kK3OrQwa5WKkl/Aunxf7B2IbKsLEz8hoYz
	MgrnVm1enb86GWiMO1m0p5P10i770wvsyxrT2dvVbEp8fHpbDqcv93OLJ73GCN5xrl0uBwsSW76AK
	oduXCKGEtUlDbbtSU9N13DCTKwcrYznYnfXpnRt457z4M9mFAsnrRsLdQWDuDDryuhWh4obch90jx
	dO6u/jZ2exlvaPZMKV3QlYIJgCZJFY1DDEW+LuQwj5ZlMEMgXLu5zhvQC5D71I/Zg3YTGY/I/Csts
	7fm7aVdQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1urfVf-0031Tq-9p; Thu, 28 Aug 2025 18:29:59 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v5 1/2] fuse: new work queue to periodically invalidate expired dentries
Date: Thu, 28 Aug 2025 17:29:50 +0100
Message-ID: <20250828162951.60437-2-luis@igalia.com>
In-Reply-To: <20250828162951.60437-1-luis@igalia.com>
References: <20250828162951.60437-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the infrastructure to keep track of all dentries created
for FUSE file systems.  A set of rbtrees will be used to keep dentries.

A new module parameter 'inval_wq' is also added.  When set, it will start
a work queue which will periodically invalidate expired dentries.  The
value of this new parameter is the period, in seconds, for this work
queue.  When it is set, every new dentry will be added to one of the
rbtree, sorted by its expiry time.

When the work queue is executed, it will check all the trees where the
dentries are kept and will invalidate those that have timed-out.

The work queue period can not be smaller than 5 seconds, but can be
disabled by setting 'inval_wq' to zero (which is the default).

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c    | 217 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/fuse_i.h |   9 ++
 fs/fuse/inode.c  |   7 ++
 3 files changed, 212 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2d817d7cab26..b7ddf0f2b3a4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -27,6 +27,62 @@ module_param(allow_sys_admin_access, bool, 0644);
 MODULE_PARM_DESC(allow_sys_admin_access,
 		 "Allow users with CAP_SYS_ADMIN in initial userns to bypass allow_other access check");
 
+struct dentry_bucket {
+	struct rb_root tree;
+	spinlock_t lock;
+};
+
+#define HASH_BITS	12
+#define HASH_SIZE	(1 << HASH_BITS)
+static struct dentry_bucket dentry_hash[HASH_SIZE];
+struct delayed_work dentry_tree_work;
+
+/* Minimum invalidation work queue frequency */
+#define FUSE_DENTRY_INVAL_FREQ_MIN 5
+
+unsigned __read_mostly inval_wq;
+static int inval_wq_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int num;
+	unsigned int old = inval_wq;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtouint(val, 0, &num);
+	if (ret)
+		return ret;
+
+	if ((num < FUSE_DENTRY_INVAL_FREQ_MIN) && (num != 0))
+		return -EINVAL;
+
+	*((unsigned int *)kp->arg) = num;
+
+	if (num && !old)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(num));
+	else if (!num && old)
+		cancel_delayed_work_sync(&dentry_tree_work);
+
+	return 0;
+}
+static const struct kernel_param_ops inval_wq_ops = {
+	.set = inval_wq_set,
+	.get = param_get_uint,
+};
+module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
+__MODULE_PARM_TYPE(inval_wq, "uint");
+MODULE_PARM_DESC(inval_wq,
+		 "Dentries invalidation work queue period in secs (>= 5).");
+
+static inline struct dentry_bucket *get_dentry_bucket(struct dentry *dentry)
+{
+	int i = hash_ptr(dentry, HASH_BITS);
+
+	return &dentry_hash[i];
+}
+
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
 	struct fuse_inode *fi = get_fuse_inode(dir);
@@ -34,33 +90,137 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
-#if BITS_PER_LONG >= 64
-static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
+struct fuse_dentry {
+	u64 time;
+	union {
+		struct rcu_head rcu;
+		struct rb_node node;
+	};
+	struct dentry *dentry;
+};
+
+static void __fuse_dentry_tree_del_node(struct fuse_dentry *fd,
+					struct dentry_bucket *bucket)
 {
-	entry->d_fsdata = (void *) time;
+	if (!RB_EMPTY_NODE(&fd->node)) {
+		rb_erase(&fd->node, &bucket->tree);
+		RB_CLEAR_NODE(&fd->node);
+	}
 }
 
-static inline u64 fuse_dentry_time(const struct dentry *entry)
+static void fuse_dentry_tree_del_node(struct dentry *dentry)
 {
-	return (u64)entry->d_fsdata;
+	struct fuse_dentry *fd = dentry->d_fsdata;
+	struct dentry_bucket *bucket = get_dentry_bucket(dentry);
+
+	if (!inval_wq && RB_EMPTY_NODE(&fd->node))
+		return;
+
+	spin_lock(&bucket->lock);
+	__fuse_dentry_tree_del_node(fd, bucket);
+	spin_unlock(&bucket->lock);
 }
 
-#else
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
-};
+static void fuse_dentry_tree_add_node(struct dentry *dentry)
+{
+	struct fuse_dentry *fd = dentry->d_fsdata;
+	struct dentry_bucket *bucket = get_dentry_bucket(dentry);
+	struct fuse_dentry *cur;
+	struct rb_node **p, *parent = NULL;
+
+	if (!inval_wq)
+		return;
+
+	spin_lock(&bucket->lock);
+
+	__fuse_dentry_tree_del_node(fd, bucket);
+
+	p = &bucket->tree.rb_node;
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(*p, struct fuse_dentry, node);
+		if (fd->time < cur->time)
+			p = &(*p)->rb_left;
+		else if (fd->time > cur->time)
+			p = &(*p)->rb_right;
+		else
+			break;
+	}
+	rb_link_node(&fd->node, parent, p);
+	rb_insert_color(&fd->node, &bucket->tree);
+	spin_unlock(&bucket->lock);
+}
+
+/*
+ * work queue which, when enabled, will periodically check for expired dentries
+ * in the dentries tree.
+ */
+static void fuse_dentry_tree_work(struct work_struct *work)
+{
+	struct fuse_dentry *fd;
+	struct rb_node *node;
+	int i;
+
+	for (i = 0; i < HASH_SIZE; i++) {
+		spin_lock(&dentry_hash[i].lock);
+		node = rb_first(&dentry_hash[i].tree);
+		while (node && !need_resched()) {
+			fd = rb_entry(node, struct fuse_dentry, node);
+			if (time_after64(get_jiffies_64(), fd->time)) {
+				rb_erase(&fd->node, &dentry_hash[i].tree);
+				RB_CLEAR_NODE(&fd->node);
+				spin_unlock(&dentry_hash[i].lock);
+				d_invalidate(fd->dentry);
+				spin_lock(&dentry_hash[i].lock);
+			} else
+				break;
+			node = rb_first(&dentry_hash[i].tree);
+		}
+		spin_unlock(&dentry_hash[i].lock);
+	}
+
+	schedule_delayed_work(&dentry_tree_work, secs_to_jiffies(inval_wq));
+}
+
+void fuse_dentry_tree_init(void)
+{
+	int i;
+
+	for (i = 0; i < HASH_SIZE; i++) {
+		spin_lock_init(&dentry_hash[i].lock);
+		dentry_hash[i].tree = RB_ROOT;
+	}
+	INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
+}
+
+void fuse_dentry_tree_cleanup(void)
+{
+	struct rb_node *n;
+	int i;
+
+	inval_wq = 0;
+	cancel_delayed_work_sync(&dentry_tree_work);
+
+	for (i = 0; i < HASH_SIZE; i++) {
+		spin_lock(&dentry_hash[i].lock);
+		while (!RB_EMPTY_ROOT(&dentry_hash[i].tree)) {
+			n = rb_first(&dentry_hash[i].tree);
+			rb_erase(n, &dentry_hash[i].tree);
+			RB_CLEAR_NODE(n);
+		}
+		spin_unlock(&dentry_hash[i].lock);
+	}
+}
 
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
-	((union fuse_dentry *) dentry->d_fsdata)->time = time;
+	((struct fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
 static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
-	return ((union fuse_dentry *) entry->d_fsdata)->time;
+	return ((struct fuse_dentry *) entry->d_fsdata)->time;
 }
-#endif
 
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
@@ -81,6 +241,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	}
 
 	__fuse_dentry_settime(dentry, time);
+	fuse_dentry_tree_add_node(dentry);
 }
 
 /*
@@ -283,21 +444,36 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	goto out;
 }
 
-#if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
-				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
+	struct fuse_dentry *fd;
 
-	return dentry->d_fsdata ? 0 : -ENOMEM;
+	fd = kzalloc(sizeof(struct fuse_dentry),
+			  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
+	if (!fd)
+		return -ENOMEM;
+
+	fd->dentry = dentry;
+	RB_CLEAR_NODE(&fd->node);
+	dentry->d_fsdata = fd;
+
+	return 0;
+}
+
+static void fuse_dentry_prune(struct dentry *dentry)
+{
+	struct fuse_dentry *fd = dentry->d_fsdata;
+
+	if (!RB_EMPTY_NODE(&fd->node))
+		fuse_dentry_tree_del_node(dentry);
 }
+
 static void fuse_dentry_release(struct dentry *dentry)
 {
-	union fuse_dentry *fd = dentry->d_fsdata;
+	struct fuse_dentry *fd = dentry->d_fsdata;
 
 	kfree_rcu(fd, rcu);
 }
-#endif
 
 static int fuse_dentry_delete(const struct dentry *dentry)
 {
@@ -331,10 +507,9 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
-#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
+	.d_prune	= fuse_dentry_prune,
 	.d_release	= fuse_dentry_release,
-#endif
 	.d_automount	= fuse_dentry_automount,
 };
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..214162f12353 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -54,6 +54,12 @@
 /** Frequency (in jiffies) of request timeout checks, if opted into */
 extern const unsigned long fuse_timeout_timer_freq;
 
+/*
+ * Dentries invalidation workqueue period, in seconds.  It shall be >= 5
+ * seconds, or 0 (zero), in which case no workqueue will be created.
+ */
+extern unsigned inval_wq __read_mostly;
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 /*
@@ -1252,6 +1258,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
+void fuse_dentry_tree_init(void);
+void fuse_dentry_tree_cleanup(void);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 67c2318bfc42..25e51efc82ee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2045,6 +2045,10 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);
+	/*
+	 * XXX prune dentries:
+	 * fuse_dentry_tree_prune(fc);
+	 */
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);
@@ -2240,6 +2244,8 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_sysfs_cleanup;
 
+	fuse_dentry_tree_init();
+
 	sanitize_global_limit(&max_user_bgreq);
 	sanitize_global_limit(&max_user_congthresh);
 
@@ -2259,6 +2265,7 @@ static void __exit fuse_exit(void)
 {
 	pr_debug("exit\n");
 
+	fuse_dentry_tree_cleanup();
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();

