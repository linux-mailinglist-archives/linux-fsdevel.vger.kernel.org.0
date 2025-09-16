Return-Path: <linux-fsdevel+bounces-61737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EAB59848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D2462A96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6632F75E;
	Tue, 16 Sep 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Nqo78lpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700031D731;
	Tue, 16 Sep 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030815; cv=none; b=KJxcyLbcbt567P5JBr5JsZLkq4lk1kMoyg5/u2goWq2TkX5N2p34x7FW2L1QzUJWTSpir6NN9C0GGwbDbtrCxH2GCSXKHUYTprcDmLMaR2+yI6p4XSsDLrBp5pusp8XbU1SiGdRMXxz6fQS6dmQJOCxc+Cw0YLKLTMLjRMXGQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030815; c=relaxed/simple;
	bh=cC4ESHmRoPHFx9+ziH5e9pMEerTGhGTntMX0FCi5StQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+w34OuDzIRvDa37s6jb64s7x4TNLpI8SK8Xva2ZUC3mFHcErhU6g1Hao50PfJBxNUCvpQO/bkj+0thJghURWoMFdddbZGvze/RtxfHjYjNjOdIBEerPweIquZolcG8LI4D10c93Hhn6vR9o4T/QIOnyI3jwVfTuMX60vTvmsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Nqo78lpt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Md8EXoCxaeKBb52Cypj7dZ5knzMrAkQ9Bak1BFT2NZg=; b=Nqo78lptMaUCsmy2zv8wIyMusw
	xLiTGvEazTZdr0atiQ5uxYY/mhe8iBr0nCtgPvyk3puZQjbKV/eq3pVtqgrD8PvZq7h5Y3JcnSHHY
	rwn3eWhF87Wn5Q+gZvQ2hYvf1a3hBYHU1r1rbiTVR/iOWuUxg/C/1ndnRPxO+8uvgTq2Hig+ujp+L
	EjuL95hqmZAIvHEQ3w8i22EcHpf8IVNWzAEhFbR0BHqrhnWxINkuTvP5xeUIDFDrr1VPqO5prVH/F
	PQ03vYWt36jOTRK1Tv9MC+c2cYz+GF6+OLcn9vpPd0ac63JXigZ4RObExlxD/QKy4Zr5RSmjHmp8O
	FnRim75A==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyW7T-00CH0u-2T; Tue, 16 Sep 2025 15:53:19 +0200
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
Subject: [RFC PATCH v6 3/4] fuse: new work queue to invalidate dentries from old epochs
Date: Tue, 16 Sep 2025 14:53:09 +0100
Message-ID: <20250916135310.51177-4-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
References: <20250916135310.51177-1-luis@igalia.com>
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
 fs/fuse/dir.c    | 21 +++++++++++++++++++++
 fs/fuse/fuse_i.h |  4 ++++
 fs/fuse/inode.c  |  2 ++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5150aa25e64b..c24e78f86b50 100644
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
index 3e88da803ba6..67e3340a443c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -189,6 +189,27 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 				      secs_to_jiffies(inval_wq));
 }
 
+void fuse_epoch_work(struct work_struct *work)
+{
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+					    epoch_work);
+	struct fuse_mount *fm;
+	struct inode *inode;
+
+	down_read(&fc->killsb);
+
+	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
+	iput(inode);
+
+	if (fm) {
+		/* Remove all possible active references to cached inodes */
+		shrink_dcache_sb(fm->sb);
+	} else
+		pr_warn("Failed to get root inode");
+
+	up_read(&fc->killsb);
+}
+
 void fuse_dentry_tree_init(void)
 {
 	int i;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b34be6f95bbe..53ca87814ef3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -649,6 +649,8 @@ struct fuse_conn {
 	/** Current epoch for up-to-date dentries */
 	atomic_t epoch;
 
+	struct work_struct epoch_work;
+
 	struct rcu_head rcu;
 
 	/** The user id for this mount */
@@ -1276,6 +1278,8 @@ void fuse_check_timeout(struct work_struct *work);
 void fuse_dentry_tree_init(void);
 void fuse_dentry_tree_cleanup(void);
 
+void fuse_epoch_work(struct work_struct *work);
+
 /**
  * Invalidate inode attributes
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index db275a04021d..c054f02e661d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -967,6 +967,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
 	atomic_set(&fc->epoch, 1);
+	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
@@ -1019,6 +1020,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 			fuse_dax_conn_free(fc);
 		if (fc->timeout.req_timeout)
 			cancel_delayed_work_sync(&fc->timeout.work);
+		cancel_work_sync(&fc->epoch_work);
 		if (fiq->ops->release)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);

