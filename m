Return-Path: <linux-fsdevel+bounces-44433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C0FA68BAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1637A4615A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99225486B;
	Wed, 19 Mar 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Umdlcjt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FE8F5A;
	Wed, 19 Mar 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383565; cv=none; b=TXY98arcHW4GcZ6qBLzVvV7/d+sBSM/41yChpNNiV5IhcEhyVOfc0dV409JeAiMmeB5asprlR37wX3/h3qVWy4h/EWLoi9tkQA32Q7FeOAWRHVXycsB2Ts+FlOX/yL7hMJyixHz/siabqnFoK209XsDstIZTQV50PViIAmTyhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383565; c=relaxed/simple;
	bh=Y9Ei/oQUMROOgA9GoJHGY/pEEXQzgr8luxBommeqesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7NfXSMK5ChWTw5ugntAlMk2rMgiZNMGrgh2TDNqaJL6Q9C0rBe03zvseCar2uVnS+e4OLV3gU+HbcclFfDAZjk54xukGmG04JnkkF3Y5Sd+2AodvJ570rZ/3pcXZRaDp52GDajP5E0D11hW28JBJnNgBcfyOHYM/fmYYIizfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Umdlcjt2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7iSOWyxbhrgMenr4rdcguvYnpAuQGxVFaXBMQJ0fptY=; b=Umdlcjt2NIeCgtiUenOskP18ni
	43+3z92ImFElX+EfmjPPzQByCYm1C2swiqzfgzFKK4oUK2g3W++2VXMBjnbLkLyH4EE+6y350Tu5x
	yFZFp2cVY/+LdPRAyfskn0lZjRvm/HMcVtFUVmvdNS/1iFWkMM0FVh1Blo0eiVIdKtIJ0wpAl0iok
	Gm5wUx6rkPG54nWqc4ZBz0QkdKfZl0AMVkHEut7ciPjRLls8AXmitzofVIqshlorGy7OGI742XL+f
	3qni0gKHeKw/KNLhQpYRm1Iae6kk9TJPc5AJtzWME/6F83J6vIkZAJz1/k9180maL7uXpW8CN1cPE
	EU2adMSg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1turYW-003Hwr-KU; Wed, 19 Mar 2025 12:25:52 +0100
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
Subject: [RFC PATCH v1] fuse: add periodic task to invalidate expired dentries
Date: Wed, 19 Mar 2025 11:25:44 +0000
Message-ID: <20250319112544.26962-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dentries may stay around for a long time, and a mechanism to invalidate
them if they have expired is desirable.  This patch adds a task that will
periodically check if there are dentries which have expired and need to be
invalidated.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi Miklos,

I know the 'epoch' patch discussion hasn't yet finished[1], but here's a
follow-up patch.  It's still WIP, it hasn't gone through a lot of testing
yet, but it may help with the whole discussion.

As you suggested, this patch keeps track of all the dentries in a tree
sorted by expiry time.  The workqueue will walk through the expired dentries
and invalidate them.  If the epoch has been incremented, then *all* dentries
are invalidated.

I still have a few questions:

1. Should we have a mount option to enable this task?
2. Should the period (not really 'period', but yeah) be configurable?

Any feedback is welcome.

[1] https://lore.kernel.org/all/20250226091451.11899-1-luis@igalia.com/

 fs/fuse/dir.c    | 138 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h |  11 ++++
 fs/fuse/inode.c  |   4 ++
 3 files changed, 153 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1f578f455364..e51a7340fa5a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -62,6 +62,142 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
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
+	struct rb_node **p, *parent;
+	bool start_work = false;
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
+				      secs_to_jiffies(5));
+}
+
+static void fuse_dentry_tree_del_node(struct dentry *dentry)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct dentry_node *cur;
+	struct rb_node **p, *parent;
+
+	spin_lock(&fc->dentry_tree_lock);
+	p = &fc->dentry_tree.rb_node;
+	while (*p) {
+		parent = *p;
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
+				      FUSE_DENTRY_TREE_WORK_INTERVAL);
+}
+
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
@@ -81,6 +217,7 @@ static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 	}
 
 	__fuse_dentry_settime(dentry, time);
+	fuse_dentry_tree_add_node(dentry);
 }
 
 /*
@@ -280,6 +417,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 
 invalid:
 	ret = 0;
+	fuse_dentry_tree_del_node(entry);
 	goto out;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 06eecc125f89..942a3098111f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -938,6 +938,13 @@ struct fuse_conn {
 	/**  uring connection information*/
 	struct fuse_ring *ring;
 #endif
+
+	/** Cache dentries tree */
+	struct rb_root dentry_tree;
+	/** Look to protect dentry_tree access */
+	spinlock_t dentry_tree_lock;
+	/** Periodic delayed work to invalidate expired dentries */
+	struct delayed_work dentry_tree_work;
 };
 
 /*
@@ -1219,6 +1226,10 @@ void fuse_request_end(struct fuse_req *req);
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
 
+#define FUSE_DENTRY_TREE_WORK_INTERVAL	secs_to_jiffies(5)
+void fuse_dentry_tree_prune(struct fuse_conn *fc);
+void fuse_dentry_tree_work(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5d2d29fad658..8984b7868c62 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -956,15 +956,18 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
 	spin_lock_init(&fc->bg_lock);
+	spin_lock_init(&fc->dentry_tree_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
 	atomic_set(&fc->epoch, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
+	INIT_DELAYED_WORK(&fc->dentry_tree_work, fuse_dentry_tree_work);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
+	fc->dentry_tree = RB_ROOT;
 	atomic_set(&fc->num_waiting, 0);
 	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
@@ -1999,6 +2002,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 
 	fuse_abort_conn(fc);
 	fuse_wait_aborted(fc);
+	fuse_dentry_tree_prune(fc);
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);

