Return-Path: <linux-fsdevel+bounces-49531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81922ABDF5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58267B16B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE34B25F98A;
	Tue, 20 May 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RkY9WHPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FD25C83D;
	Tue, 20 May 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755749; cv=none; b=eMnD4u2USgR4lF/Z06KDcGKlYFZLsVAzf3xkguk03PvsgQ+jHS0r0cRbq89lT2qH+hDIGLvo9zdaOHKzBrvHneSKHpqd8lCxrejrmyJzGJwZpFq6UW0UCz9PEIiFt6GcqNoeVXH7CEXaV9CZ8aAZxUVKugMnvnIfMYVLfZ5lq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755749; c=relaxed/simple;
	bh=hIZ728TUG1e4Y1MUhugb9X8dcSnrfiUC82Z673RRCzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFiEgGVM7l87YscoxFz3Yz9sTRN4uo5TeRrtB3De5EmTgnQxoYkJA72S4Ps9sqKdhXE2zkNZzFGmJBlLyjx+/zo2LVB9bvz6AoIvw23VP77USg7HDHNqxviB23FfWDGoN+QzA+1auIdYoyVRXY+nRHMAatMManwcM/N0ElKGKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RkY9WHPe; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lJAQ3Yzrj1wGYF/m6y57Z9z5n1XKpuQWyTwzhXHABYM=; b=RkY9WHPeoYBUXf/rNbWp5Lgqnk
	VRdsAdlFaQtYHXzIX7QOo4PHnyub7E0lUuH89M3RxlL05RAywS84eWektwfZ9JFR8dAfZLSUbTOIl
	ycM8ZAPnsPoVQfjaftPQLqmlavs7ACSnuc2J8vJTApQWUctvIZGrCwOSFVwdhS+MCML73YJmmz24Q
	E2zlI0EOQBgedMIcCFi4cdb6Fx3hmI1KIYOUYjZ3mPi7Siaifld6efElWHj6XWMUZwFJbtbVqMvWy
	SqoJbI2F9j3vE8WMSJgQyzJA9xKBFDp7iGGM1H66yHHwFft6iIB3d/Tj5g649x0lnTWz2vVbjxZx4
	aUbhoCpA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHP6Y-00AmCo-Rg; Tue, 20 May 2025 17:42:10 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v3] fuse: new workqueue to periodically invalidate expired dentries
Date: Tue, 20 May 2025 16:42:03 +0100
Message-ID: <20250520154203.31359-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new module parameter 'inval_wq' which is used to start a
workqueue to periodically invalidate expired dentries.  The value of this
new parameter is the period, in seconds, of the workqueue.  When it is set,
every new dentry will be added to an rbtree, sorted by the dentry's expiry
time.

When the workqueue is executed, it will check the dentries in this tree and
invalidate them if:

  - The dentry has timed-out, or if
  - The connection epoch has been incremented.

The workqueue will run for, at most, 5 seconds each time.  It will
reschedule itself if the dentries tree isn't empty.

The workqueue period is set per filesystem with the 'inval_wq' parameter
value when it is mounted.  This value can not be less than 5 seconds.  If
this module parameter is changed later on, the mounted filesystems will
keep using the old value until they are remounted.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

I've been staring at this patch for a while and hopefully it's ready for a
fresh set of eyes to find the bugs that are hiding from me.  I believe I
addressed all Miklos comments, and decided to drop the RFC from the subject.

As before, this patch depends on my previous patch (already in Miklos tree)
with subject: "fuse: add more control over cache invalidation behaviour".

Feedback is welcome.

Cheers,
-- 
Luis

Changes since v2:

- Major rework, the dentries tree nodes are now in fuse_dentry and they are
  tied to the actual dentry lifetime
- Mount option is now a module parameter
- workqueue now runs for at most 5 seconds before rescheduling

 fs/fuse/dir.c    | 180 +++++++++++++++++++++++++++++++++++++++++------
 fs/fuse/fuse_i.h |  12 ++++
 fs/fuse/inode.c  |  21 ++++++
 3 files changed, 190 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1fb0b15a6088..257ca2b36b94 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -34,33 +34,153 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
-#if BITS_PER_LONG >= 64
-static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
+struct fuse_dentry {
+	u64 time;
+	struct rcu_head rcu;
+	struct rb_node node;
+	struct dentry *dentry;
+};
+
+static void __fuse_dentry_tree_del_node(struct fuse_conn *fc,
+					struct fuse_dentry *fd)
 {
-	entry->d_fsdata = (void *) time;
+	if (!RB_EMPTY_NODE(&fd->node)) {
+		rb_erase(&fd->node, &fc->dentry_tree);
+		RB_CLEAR_NODE(&fd->node);
+	}
 }
 
-static inline u64 fuse_dentry_time(const struct dentry *entry)
+static void fuse_dentry_tree_del_node(struct dentry *dentry)
 {
-	return (u64)entry->d_fsdata;
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct fuse_dentry *fd = dentry->d_fsdata;
+
+	if (!fc->inval_wq)
+		return;
+
+	spin_lock(&fc->dentry_tree_lock);
+	__fuse_dentry_tree_del_node(fc, fd);
+	spin_unlock(&fc->dentry_tree_lock);
 }
 
-#else
-union fuse_dentry {
-	u64 time;
-	struct rcu_head rcu;
-};
+static void fuse_dentry_tree_add_node(struct dentry *dentry)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct fuse_dentry *fd = dentry->d_fsdata;
+	struct fuse_dentry *cur;
+	struct rb_node **p, *parent = NULL;
+	bool start_work = false;
+
+	if (!fc->inval_wq)
+		return;
+
+	spin_lock(&fc->dentry_tree_lock);
+
+	if (!fc->inval_wq) {
+		spin_unlock(&fc->dentry_tree_lock);
+		return;
+	}
+
+	start_work = RB_EMPTY_ROOT(&fc->dentry_tree);
+	__fuse_dentry_tree_del_node(fc, fd);
+
+	p = &fc->dentry_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(*p, struct fuse_dentry, node);
+		if (fd->time > cur->time)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&fd->node, parent, p);
+	rb_insert_color(&fd->node, &fc->dentry_tree);
+	spin_unlock(&fc->dentry_tree_lock);
+
+	if (start_work)
+		schedule_delayed_work(&fc->dentry_tree_work,
+				      secs_to_jiffies(fc->inval_wq));
+}
+
+void fuse_dentry_tree_prune(struct fuse_conn *fc)
+{
+	struct rb_node *n;
+
+	if (!fc->inval_wq)
+		return;
+
+	fc->inval_wq = 0;
+	cancel_delayed_work_sync(&fc->dentry_tree_work);
+
+	spin_lock(&fc->dentry_tree_lock);
+	while (!RB_EMPTY_ROOT(&fc->dentry_tree)) {
+		n = rb_first(&fc->dentry_tree);
+		rb_erase(n, &fc->dentry_tree);
+		RB_CLEAR_NODE(&rb_entry(n, struct fuse_dentry, node)->node);
+	}
+	spin_unlock(&fc->dentry_tree_lock);
+}
+
+/*
+ * workqueue that, when enabled, will periodically check for expired dentries in
+ * the dentries tree.
+ *
+ * A dentry has expired if:
+ *
+ *   1) it has been around for too long (timeout) or if
+ *
+ *   2) the connection epoch has been incremented.
+ *
+ * The workqueue will be rescheduled itself as long as the dentries tree is not
+ * empty.  Also, it will not spend more than 5 seconds invalidating dentries on
+ * each run.
+ */
+void fuse_dentry_tree_work(struct work_struct *work)
+{
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+					    dentry_tree_work.work);
+	struct fuse_dentry *fd;
+	struct rb_node *node;
+	u64 start, end;
+	int epoch;
+	bool reschedule;
+
+	spin_lock(&fc->dentry_tree_lock);
+	start = get_jiffies_64();
+	/* Don't spend too much time invalidating dentries */
+	end = start + secs_to_jiffies(5);
+	epoch = atomic_read(&fc->epoch);
+
+	node = rb_first(&fc->dentry_tree);
+	while (node && time_after64(end, get_jiffies_64())) {
+		fd = rb_entry(node, struct fuse_dentry, node);
+		if ((fd->dentry->d_time < epoch) || (fd->time < start)) {
+			rb_erase(&fd->node, &fc->dentry_tree);
+			RB_CLEAR_NODE(&fd->node);
+			spin_unlock(&fc->dentry_tree_lock);
+			d_invalidate(fd->dentry);
+			spin_lock(&fc->dentry_tree_lock);
+		} else
+			break;
+		node = rb_first(&fc->dentry_tree);
+	}
+	reschedule = !RB_EMPTY_ROOT(&fc->dentry_tree);
+	spin_unlock(&fc->dentry_tree_lock);
+
+	if (reschedule)
+		schedule_delayed_work(&fc->dentry_tree_work,
+				      secs_to_jiffies(fc->inval_wq));
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
@@ -81,6 +201,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	}
 
 	__fuse_dentry_settime(dentry, time);
+	fuse_dentry_tree_add_node(dentry);
 }
 
 /*
@@ -283,21 +404,36 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	goto out;
 }
 
-#if BITS_PER_LONG < 64
 static int fuse_dentry_init(struct dentry *dentry)
 {
-	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
-				   GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
+	struct fuse_dentry *fd;
+
+	fd = kzalloc(sizeof(struct fuse_dentry),
+			  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
+	if (!fd)
+		return -ENOMEM;
+
+	fd->dentry = dentry;
+	RB_CLEAR_NODE(&fd->node);
+	dentry->d_fsdata = fd;
 
-	return dentry->d_fsdata ? 0 : -ENOMEM;
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
@@ -334,18 +470,16 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
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
 
 const struct dentry_operations fuse_root_dentry_operations = {
-#if BITS_PER_LONG < 64
 	.d_init		= fuse_dentry_init,
+	.d_prune	= fuse_dentry_prune,
 	.d_release	= fuse_dentry_release,
-#endif
 };
 
 int fuse_valid_type(int m)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f870d53a1bcf..3b7794f21573 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -978,6 +978,15 @@ struct fuse_conn {
 		/* Request timeout (in jiffies). 0 = no timeout */
 		unsigned int req_timeout;
 	} timeout;
+
+	/** Cache dentries tree */
+	struct rb_root dentry_tree;
+	/** Look to protect dentry_tree access */
+	spinlock_t dentry_tree_lock;
+	/** Periodic delayed work to invalidate expired dentries */
+	struct delayed_work dentry_tree_work;
+	/** Period for the invalidation workqueue */
+	unsigned int inval_wq;
 };
 
 /*
@@ -1262,6 +1271,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
+void fuse_dentry_tree_prune(struct fuse_conn *fc);
+void fuse_dentry_tree_work(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b399784cca5f..7dbb11937344 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -57,6 +57,20 @@ MODULE_PARM_DESC(max_user_congthresh,
  "Global limit for the maximum congestion threshold an "
  "unprivileged user can set");
 
+static unsigned __read_mostly inval_wq;
+static int inval_wq_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 5, (unsigned int)(-1));
+}
+static const struct kernel_param_ops inval_wq_ops = {
+	.set = inval_wq_set,
+	.get = param_get_uint,
+};
+module_param_cb(inval_wq, &inval_wq_ops, &inval_wq, 0644);
+__MODULE_PARM_TYPE(inval_wq, "uint");
+MODULE_PARM_DESC(inval_wq,
+		 "Dentries invalidation workqueue period in secs (>= 5).");
+
 #define FUSE_DEFAULT_BLKSIZE 512
 
 /** Maximum number of outstanding background requests */
@@ -959,6 +973,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
 	spin_lock_init(&fc->bg_lock);
+	spin_lock_init(&fc->dentry_tree_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
@@ -968,6 +983,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	fc->dentry_tree = RB_ROOT;
+	fc->inval_wq = 0;
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1844,6 +1861,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
+	fc->inval_wq = inval_wq;
+	if (fc->inval_wq > 0)
+		INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
@@ -2048,6 +2068,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);
+	fuse_dentry_tree_prune(fc);
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);

