Return-Path: <linux-fsdevel+bounces-46484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5405FA89FAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC9E7ADE5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680891A2C0B;
	Tue, 15 Apr 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="s63YWZLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE6195808;
	Tue, 15 Apr 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724302; cv=none; b=tsBC4fNRdvsDvpluVFDJStYPe2eFHNbjWZW68FJqe18KhhYe2P/wuJ17/GWut1lyE7edjNbcAzPUxjKOmBrEiiMaYluZCWSa9vT2ZaEwp4CgFbN1w6FNvyHMQ87PKnaIdYVJEiC14qZNSV9nyI87+7J1xdxlVaZosZ929Bcn1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724302; c=relaxed/simple;
	bh=0i3nh43gkFjeTvRyBIihx/OQAb1XM8Y2tpr5hrHJQQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRQVHgyDjoAiOBWNrST45xJlw4L6YLEnfPEGI2xAdrPz7w/J67TRJwJoacAYwHAQdHbdisVIADFZAsrQSlzSYbfKj7SXHAGA1dcJqn8n/e0Ijfm4xYvylRSRWLmLJyGg3ReYMq6tqbxCru8ldPJBNcjuqyRs8i/CFf8niNSHHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=s63YWZLZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aTIEjcdltv8SrW5XvNeyiR4Um+xskttfarsF54KBUyw=; b=s63YWZLZStL40qV1iNMm1oDTdV
	OCi0Ti3yJhm/wo4439I7nZ/lzPDA0m2Zp49jHe6uSBICD6fHGnH+zH7Y2IPTZzJFCUjcItnGkrx/W
	M/8GTigKZavwbA/y2tlOlRV+ltqZL9lUUd0q9c4GVYC51+z2Zb7kBVhNwAheCdRsnUfzvKx2iJaHb
	Vk+Wa3yLmPtK91oGg7P9EcDZejMPZHCHDFPfyDDs4dEcVmD2gntGFdVgLIpojlMuH5k5c0Y9Nr4ZC
	cwxIV0B0gAiiQe2DXK8BCntZY14n8fu07zckAMSlH1swp9yqONTwZ2U5sfI6tJZG71AXX53+x1POV
	IRXSxs0g==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u4gUK-00GxD7-Q8; Tue, 15 Apr 2025 15:38:08 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2] fuse: add optional workqueue to periodically invalidate expired dentries
Date: Tue, 15 Apr 2025 14:38:01 +0100
Message-ID: <20250415133801.28923-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new mount option that will allow to set a workqueue to
periodically invalidate expired dentries.  When this parameter is set,
every new (or revalidated) dentry will be added to a tree, sorted by
expiry time.  The workqueue period is set when a filesystem is mounted
using this new parameter, and can not be less than 5 seconds.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
* Changes since v1:

- Add mount option to enable the workqueue and set it's period
- 'parent' initialisation missing in fuse_dentry_tree_add_node()

 Documentation/filesystems/fuse.rst |   5 +
 fs/fuse/dir.c                      | 147 +++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h                   |  13 +++
 fs/fuse/inode.c                    |  18 ++++
 4 files changed, 183 insertions(+)

diff --git a/Documentation/filesystems/fuse.rst b/Documentation/filesystems/fuse.rst
index 1e31e87aee68..b0a7be54e611 100644
--- a/Documentation/filesystems/fuse.rst
+++ b/Documentation/filesystems/fuse.rst
@@ -103,6 +103,11 @@ blksize=N
   Set the block size for the filesystem.  The default is 512.  This
   option is only valid for 'fuseblk' type mounts.
 
+inval_wq=N
+  Enable a workqueue that will periodically invalidate dentries that
+  have expired.  'N' is a value in seconds and has to be bigger than
+  5 seconds.
+
 Control filesystem
 ==================
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1fb0b15a6088..e16aafc522ef 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -62,6 +62,151 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 }
 #endif
 
+struct dentry_node {
+	struct rb_node node;
+	struct dentry *dentry;
+};
+
+static void fuse_dentry_tree_add_node(struct dentry *dentry)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct dentry_node *dn, *cur;
+	struct rb_node **p, *parent = NULL;
+	bool start_work = false;
+
+	if (!fc->inval_wq)
+		return;
+
+	dn = kmalloc(sizeof(*dn), GFP_KERNEL);
+	if (!dn)
+		return;
+	dn->dentry = dget(dentry);
+	spin_lock(&fc->dentry_tree_lock);
+	start_work = RB_EMPTY_ROOT(&fc->dentry_tree);
+	p = &fc->dentry_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(*p, struct dentry_node, node);
+		if (fuse_dentry_time(dn->dentry) >
+		    fuse_dentry_time(cur->dentry))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&dn->node, parent, p);
+	rb_insert_color(&dn->node, &fc->dentry_tree);
+	spin_unlock(&fc->dentry_tree_lock);
+	if (start_work)
+		schedule_delayed_work(&fc->dentry_tree_work,
+				      secs_to_jiffies(fc->inval_wq));
+}
+
+static void fuse_dentry_tree_del_node(struct dentry *dentry)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct dentry_node *cur;
+	struct rb_node **p;
+
+	if (!fc->inval_wq)
+		return;
+
+	spin_lock(&fc->dentry_tree_lock);
+	p = &fc->dentry_tree.rb_node;
+	while (*p) {
+		cur = rb_entry(*p, struct dentry_node, node);
+		if (fuse_dentry_time(dentry) > fuse_dentry_time(cur->dentry))
+			p = &(*p)->rb_left;
+		else if (fuse_dentry_time(dentry) <
+			 fuse_dentry_time(cur->dentry))
+			p = &(*p)->rb_right;
+		else {
+			rb_erase(*p, &fc->dentry_tree);
+			dput(cur->dentry);
+			kfree(cur);
+			break;
+		}
+	}
+	spin_unlock(&fc->dentry_tree_lock);
+}
+
+void fuse_dentry_tree_prune(struct fuse_conn *fc)
+{
+	struct rb_node *n;
+	struct dentry_node *dn;
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
+		dn = rb_entry(n, struct dentry_node, node);
+		rb_erase(n, &fc->dentry_tree);
+		dput(dn->dentry);
+		kfree(dn);
+	}
+	spin_unlock(&fc->dentry_tree_lock);
+}
+
+/*
+ * Global workqueue task that will periodically check for expired dentries in
+ * the dentries tree.
+ *
+ * A dentry has expired if:
+ *   1) it has been around for too long or
+ *   2) the connection epoch has been incremented
+ * For this second case, all dentries will be expired.
+ *
+ * The task will be rescheduled as long as the dentries tree is not empty.
+ */
+void fuse_dentry_tree_work(struct work_struct *work)
+{
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+					    dentry_tree_work.work);
+	struct dentry_node *dn;
+	struct rb_node *node;
+	struct dentry *entry;
+	u64 now;
+	int epoch;
+	bool expire_all = false;
+	bool is_first = true;
+	bool reschedule;
+
+	spin_lock(&fc->dentry_tree_lock);
+	now = get_jiffies_64();
+	epoch = atomic_read(&fc->epoch);
+
+	node = rb_first(&fc->dentry_tree);
+
+	while (node) {
+		dn = rb_entry(node, struct dentry_node, node);
+		node = rb_next(node);
+		entry = dn->dentry;
+		if (is_first) {
+			/* expire all entries if epoch was incremented */
+			if (entry->d_time < epoch)
+				expire_all = true;
+			is_first = false;
+		}
+		if (expire_all || (fuse_dentry_time(entry) < now)) {
+			rb_erase(&dn->node, &fc->dentry_tree);
+			d_invalidate(entry);
+			dput(entry);
+			kfree(dn);
+		} else
+			break;
+	}
+	reschedule = !RB_EMPTY_ROOT(&fc->dentry_tree);
+	spin_unlock(&fc->dentry_tree_lock);
+
+	if (reschedule)
+		schedule_delayed_work(&fc->dentry_tree_work,
+				      secs_to_jiffies(fc->inval_wq));
+}
+
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
@@ -81,6 +226,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	}
 
 	__fuse_dentry_settime(dentry, time);
+	fuse_dentry_tree_add_node(dentry);
 }
 
 /*
@@ -280,6 +426,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 invalid:
 	ret = 0;
+	fuse_dentry_tree_del_node(entry);
 	goto out;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f870d53a1bcf..60be9d982490 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -603,6 +603,7 @@ struct fuse_fs_context {
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
+	unsigned int inval_wq;
 	const char *subtype;
 
 	/* DAX device, may be NULL */
@@ -978,6 +979,15 @@ struct fuse_conn {
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
@@ -1262,6 +1272,9 @@ void fuse_wait_aborted(struct fuse_conn *fc);
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
 
+void fuse_dentry_tree_prune(struct fuse_conn *fc);
+void fuse_dentry_tree_work(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b399784cca5f..4e9c10e34b2e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -769,6 +769,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_INVAL_WQ,
 	OPT_ERR
 };
 
@@ -783,6 +784,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+	fsparam_u32	("inval_wq",		OPT_INVAL_WQ),
 	{}
 };
 
@@ -878,6 +880,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+	case OPT_INVAL_WQ:
+		if (result.uint_32 < 5)
+			return invalfc(fsc, "Workqueue period is < 5s");
+		ctx->inval_wq = result.uint_32;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -911,6 +919,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_puts(m, ",allow_other");
 		if (fc->max_read != ~0)
 			seq_printf(m, ",max_read=%u", fc->max_read);
+		if (fc->inval_wq != 0)
+			seq_printf(m, ",inval_wq=%u", fc->inval_wq);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
 	}
@@ -959,6 +969,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
 	spin_lock_init(&fc->bg_lock);
+	spin_lock_init(&fc->dentry_tree_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
@@ -968,6 +979,8 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	fc->dentry_tree = RB_ROOT;
+	fc->inval_wq = 0;
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1844,6 +1857,9 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
+	fc->inval_wq = ctx->inval_wq;
+	if (fc->inval_wq > 0)
+		INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
@@ -2009,6 +2025,7 @@ static int fuse_init_fs_context(struct fs_context *fsc)
 		return -ENOMEM;
 
 	ctx->max_read = ~0;
+	ctx->inval_wq = 0;
 	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
 	ctx->legacy_opts_show = true;
 
@@ -2048,6 +2065,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);
+	fuse_dentry_tree_prune(fc);
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);

