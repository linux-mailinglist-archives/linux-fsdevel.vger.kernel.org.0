Return-Path: <linux-fsdevel+bounces-61734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFDB59840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24734E4D00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB59327790;
	Tue, 16 Sep 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EqkMsZyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7D280A56;
	Tue, 16 Sep 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030813; cv=none; b=Sn5y5j57zUgSG+BuEGJUi8Y93gogVB5vVvWA8twVJqC9gA1aJOCNGKSLqGQ1HXrqjBur3fiuj5COS4WBLczt+sIqteywjEgqzacZVO+alQxFLQm2kkzhu1aAteKJoRDKSE+1Y5uei8a+sjtHgXW5E7d7uBiksghtGcO/ZVCfcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030813; c=relaxed/simple;
	bh=ey3QI2O8xbexbjj2lzhcybZNAsBQVeMYDniWM4Ti+qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCvqcvvoYM1foCZIpObsYh3Tv5xR6w/ni09lMBgts8E7T2CZLGZXUTMJqhF0SMBT8I1OTHtEf4T1E0IEvFaRaNsPe6BSRvze1I4XnzC+15ZkHyagp+q/tkZwFnxHw+35XT753TosdTYrbeSYqVXcQqKB+mL9FIpw4y0NOyzYtTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EqkMsZyW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tDBARSDEyWPHsPyE4kya3wzrOFMq8CWupsWD4ape51I=; b=EqkMsZyWe3X2hGupi5hYBo4hGV
	+ItO29sf/hNCucYANDJNCJhetlrNQIBRRWFEQhHbgq4bcYdnWe/U2ke0iQQ0DXTE8d5u1Z+gOU07n
	+T2TqEBNqzEchzfBMD9iFJlIBto1jdbVfWzwL4tmUcK27OuC3GIwEZDYdODtmKpVTtfOvbVUepWvX
	OJPaKfIydt8hY8FVdzfLbEm5HNzBNNKLq8k7L/YG5WewIxTST2jowo+P0a+tgWnheS54lEtT80z+Q
	mymaR+roIruYWMP9aL8NCwcN72F+Ab4iBHRV8rUaeywrfnQ13xo98IUartFSbQLZC+V7yTu3559Wl
	+OxZRYZw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyW7S-00CH0r-Jy; Tue, 16 Sep 2025 15:53:18 +0200
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
Subject: [RFC PATCH v6 2/4] fuse: new work queue to periodically invalidate expired dentries
Date: Tue, 16 Sep 2025 14:53:08 +0100
Message-ID: <20250916135310.51177-3-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
References: <20250916135310.51177-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the necessary infrastructure to keep track of all dentries
created for FUSE file systems.  A set of rbtrees, protected by hashed
locks, will be used to keep all these dentries sorted by expiry time.

A new module parameter 'inval_wq' is also added.  When set, it will start
a work queue which will periodically invalidate expired dentries.  The
value of this new parameter is the period, in seconds, for this work
queue.  Once this parameter is set, every new dentry will be added to one
of the rbtrees.

When the work queue is executed, it will check all the rbtrees and will
invalidate those dentries that have timed-out.

The work queue period can not be smaller than 5 seconds, but can be
disabled by setting 'inval_wq' to zero (which is the default).

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c    | 216 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/fuse/fuse_i.h |  10 +++
 fs/fuse/inode.c  |   3 +
 3 files changed, 208 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..3e88da803ba6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -27,6 +27,67 @@ module_param(allow_sys_admin_access, bool, 0644);
 MODULE_PARM_DESC(allow_sys_admin_access,
 		 "Allow users with CAP_SYS_ADMIN in initial userns to bypass allow_other access check");
 
+struct dentry_bucket {
+	struct rb_root tree;
+	spinlock_t lock;
+};
+
+#define HASH_BITS	5
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
+	/* This should prevent overflow in secs_to_jiffies() */
+	if (num > USHRT_MAX)
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
+		 "Dentries invalidation work queue period in secs (>= "
+		 __stringify(FUSE_DENTRY_INVAL_FREQ_MIN) ").");
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
@@ -34,33 +95,131 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
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
+	struct dentry_bucket *bucket;
+	struct fuse_dentry *cur;
+	struct rb_node **p, *parent = NULL;
+
+	if (!inval_wq)
+		return;
+
+	bucket = get_dentry_bucket(dentry);
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
+		else
+			p = &(*p)->rb_right;
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
+	LIST_HEAD(dispose);
+	struct fuse_dentry *fd;
+	struct rb_node *node;
+	int i;
+
+	for (i = 0; i < HASH_SIZE; i++) {
+		spin_lock(&dentry_hash[i].lock);
+		node = rb_first(&dentry_hash[i].tree);
+		while (node) {
+			fd = rb_entry(node, struct fuse_dentry, node);
+			if (time_after64(get_jiffies_64(), fd->time)) {
+				rb_erase(&fd->node, &dentry_hash[i].tree);
+				RB_CLEAR_NODE(&fd->node);
+				spin_unlock(&dentry_hash[i].lock);
+				d_dispose_if_unused(fd->dentry, &dispose);
+				cond_resched();
+				spin_lock(&dentry_hash[i].lock);
+			} else
+				break;
+			node = rb_first(&dentry_hash[i].tree);
+		}
+		spin_unlock(&dentry_hash[i].lock);
+		shrink_dentry_list(&dispose);
+	}
+
+	if (inval_wq)
+		schedule_delayed_work(&dentry_tree_work,
+				      secs_to_jiffies(inval_wq));
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
+	int i;
+
+	inval_wq = 0;
+	cancel_delayed_work_sync(&dentry_tree_work);
+
+	for (i = 0; i < HASH_SIZE; i++)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&dentry_hash[i].tree));
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
@@ -81,6 +240,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	}
 
 	__fuse_dentry_settime(dentry, time);
+	fuse_dentry_tree_add_node(dentry);
 }
 
 /*
@@ -283,21 +443,36 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
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
@@ -331,10 +506,9 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
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
index cc428d04be3e..b34be6f95bbe 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -54,6 +54,13 @@
 /** Frequency (in jiffies) of request timeout checks, if opted into */
 extern const unsigned long fuse_timeout_timer_freq;
 
+/*
+ * Dentries invalidation workqueue period, in seconds.  The value of this
+ * parameter shall be >= FUSE_DENTRY_INVAL_FREQ_MIN seconds, or 0 (zero), in
+ * which case no workqueue will be created.
+ */
+extern unsigned inval_wq __read_mostly;
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 /*
@@ -1266,6 +1273,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
+void fuse_dentry_tree_init(void);
+void fuse_dentry_tree_cleanup(void);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c..db275a04021d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -2256,6 +2256,8 @@ static int __init fuse_init(void)
 	if (res)
 		goto err_sysfs_cleanup;
 
+	fuse_dentry_tree_init();
+
 	sanitize_global_limit(&max_user_bgreq);
 	sanitize_global_limit(&max_user_congthresh);
 
@@ -2275,6 +2277,7 @@ static void __exit fuse_exit(void)
 {
 	pr_debug("exit\n");
 
+	fuse_dentry_tree_cleanup();
 	fuse_ctl_cleanup();
 	fuse_sysfs_cleanup();
 	fuse_fs_cleanup();

