Return-Path: <linux-fsdevel+bounces-59512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2F7B3A656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D131F7C18E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50E3314AD;
	Thu, 28 Aug 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sqcnOE+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F032A3C5;
	Thu, 28 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398612; cv=none; b=asQOsWb/fhAvBcTYzPhZNnp9JDIvbkb2OStTs3A0Vc7Qed4XJE1eDlO/3E96mKzpkoDPwfvZMtQi0A67Tuo09Acl/wRmz3E/dn7Y1EmZMeb+0Ivf3FDlNm5Rx6cM+Xqhg24+aesEmlCGcprYhes3SfrLhtI+ZV53jKmik0Ga7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398612; c=relaxed/simple;
	bh=ZvT78/6xcNLkuvr2I2tyUbbtxqdyiJZRplj7WrpEJv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELGJrnDcrYT5SyJ42to1M42qc66MSzdKEMbeAYFObFPSQWj1SCu73ihA6XB+pYIE3SHZDKb/EgQk76kD5vlHyswpwrmZJx59cBCdJsZrUiw+tLsQhIubKg3irc95kFqVc9QNidkQneevlJ07jx+kKyokMDj0fVZ/OTRcI6x8lV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sqcnOE+L; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6SyhKHg1uT3Y6F2NeXGMO6VV5FnKyJmv38010m3Cams=; b=sqcnOE+Llw6irqfLCVJcFFtmoU
	9HkBZYG+/QvJ00X5EBsmC85fFow8QYCYiRR2iKpABeJeAr9HZuGvSUNKpBo4TDJYl7/3qSTV08H8m
	/r5TJ1CZdjRbCcz4vnonGX3fg+My9QU0dLrpRld8BS8ViR1opT5fpYdDldQPRN3lIYx093yJmJPvM
	KhV/JRLpISRvEIJWsyDpzNYQvOP648Shjh9SPA9pt+QJqZmHUjhCjt6r7NXnckKaI5mq13Za3lzve
	+pxwrhOsBK77lrIo0rHldNrPO0AoHiLzrDy/9uS70qIh6td+3GAPYy5qMfYljeX6FyeES7PABV1uw
	FYRitIHg==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1urfVf-0031Tt-P1; Thu, 28 Aug 2025 18:29:59 +0200
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
Subject: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries from old epochs
Date: Thu, 28 Aug 2025 17:29:51 +0100
Message-ID: <20250828162951.60437-3-luis@igalia.com>
In-Reply-To: <20250828162951.60437-1-luis@igalia.com>
References: <20250828162951.60437-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the infrastructure introduced to periodically invalidate expired
dentries, it is now possible to add an extra work queue to invalidate
dentries when an epoch is incremented.  This work queue will only be
triggered when the 'inval_wq' parameter is set.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dev.c    |  7 ++++---
 fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h |  4 ++++
 fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
 4 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..48c5c01c3e5b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 
 /*
  * Increments the fuse connection epoch.  This will result of dentries from
- * previous epochs to be invalidated.
- *
- * XXX optimization: add call to shrink_dcache_sb()?
+ * previous epochs to be invalidated.  Additionally, if inval_wq is set, a work
+ * queue is scheduled to trigger the invalidation.
  */
 static int fuse_notify_inc_epoch(struct fuse_conn *fc)
 {
 	atomic_inc(&fc->epoch);
+	if (inval_wq)
+		schedule_work(&fc->epoch_work);
 
 	return 0;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b7ddf0f2b3a4..f05cb8f4c555 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -182,6 +182,40 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 	schedule_delayed_work(&dentry_tree_work, secs_to_jiffies(inval_wq));
 }
 
+void fuse_epoch_work(struct work_struct *work)
+{
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+					    epoch_work);
+	struct fuse_dentry *fd;
+	struct rb_node *node, *next;
+	struct dentry *dentry;
+	int epoch;
+	int i;
+
+	epoch = atomic_read(&fc->epoch);
+
+	for (i = 0; i < HASH_SIZE; i++) {
+		spin_lock(&dentry_hash[i].lock);
+		node = rb_first(&dentry_hash[i].tree);
+		while (node) {
+			next = rb_next(node);
+			fd = rb_entry(node, struct fuse_dentry, node);
+			dentry = fd->dentry;
+			if ((fc == get_fuse_conn_super(dentry->d_sb)) &&
+			    (dentry->d_time < epoch)) {
+				rb_erase(&fd->node, &dentry_hash[i].tree);
+				RB_CLEAR_NODE(&fd->node);
+				/* XXX use tmp tree and d_invalidate all at once? */
+				spin_unlock(&dentry_hash[i].lock);
+				d_invalidate(fd->dentry);
+				spin_lock(&dentry_hash[i].lock);
+			}
+			node = next;
+		}
+		spin_unlock(&dentry_hash[i].lock);
+	}
+}
+
 void fuse_dentry_tree_init(void)
 {
 	int i;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 214162f12353..1f102ecdb9ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -642,6 +642,8 @@ struct fuse_conn {
 	/** Current epoch for up-to-date dentries */
 	atomic_t epoch;
 
+	struct work_struct epoch_work;
+
 	struct rcu_head rcu;
 
 	/** The user id for this mount */
@@ -1261,6 +1263,8 @@ void fuse_check_timeout(struct work_struct *work);
 void fuse_dentry_tree_init(void);
 void fuse_dentry_tree_cleanup(void);
 
+void fuse_epoch_work(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 25e51efc82ee..853220413fd8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -962,6 +962,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
 	atomic_set(&fc->epoch, 1);
+	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
@@ -1006,26 +1007,28 @@ static void delayed_release(struct rcu_head *p)
 
 void fuse_conn_put(struct fuse_conn *fc)
 {
-	if (refcount_dec_and_test(&fc->count)) {
-		struct fuse_iqueue *fiq = &fc->iq;
-		struct fuse_sync_bucket *bucket;
-
-		if (IS_ENABLED(CONFIG_FUSE_DAX))
-			fuse_dax_conn_free(fc);
-		if (fc->timeout.req_timeout)
-			cancel_delayed_work_sync(&fc->timeout.work);
-		if (fiq->ops->release)
-			fiq->ops->release(fiq);
-		put_pid_ns(fc->pid_ns);
-		bucket = rcu_dereference_protected(fc->curr_bucket, 1);
-		if (bucket) {
-			WARN_ON(atomic_read(&bucket->count) != 1);
-			kfree(bucket);
-		}
-		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
-			fuse_backing_files_free(fc);
-		call_rcu(&fc->rcu, delayed_release);
+	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_sync_bucket *bucket;
+
+	if (!refcount_dec_and_test(&fc->count))
+		return;
+
+	if (IS_ENABLED(CONFIG_FUSE_DAX))
+		fuse_dax_conn_free(fc);
+	if (fc->timeout.req_timeout)
+		cancel_delayed_work_sync(&fc->timeout.work);
+	cancel_work_sync(&fc->epoch_work);
+	if (fiq->ops->release)
+		fiq->ops->release(fiq);
+	put_pid_ns(fc->pid_ns);
+	bucket = rcu_dereference_protected(fc->curr_bucket, 1);
+	if (bucket) {
+		WARN_ON(atomic_read(&bucket->count) != 1);
+		kfree(bucket);
 	}
+	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		fuse_backing_files_free(fc);
+	call_rcu(&fc->rcu, delayed_release);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_put);
 

