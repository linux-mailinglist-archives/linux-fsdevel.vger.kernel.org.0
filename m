Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED50C350B90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhDABJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232601AbhDABJK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 240BC61057;
        Thu,  1 Apr 2021 01:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239350;
        bh=WO/Ibayp9wD3mpiGOIRPoFx7iqn3Jcwc5oEnEJlemD0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GOruQRdJLhSC7e1LN6V1oyNgwCBh++a2movEwr+zcvyGiymEteBw8BTSyv+ZS9hrk
         EizD7Qwkbc2B1qG4oPNhiruMCaipdb5ayFUBNnfpA7tuaBVjxuUPhWiY23Y73gCwbX
         /TrJQHUm3lcUgIOqE1YBHQXLE7+E4PF7bybGHmaCRbBafE6Ofj6u7YuhxeZkZ0wLIG
         q9KVRIxa5ovNL2iHm3T7rMYT6oMXR52appm0kN7lQntPPu1Nzg6n8n+towgR+Z2Zqz
         XeJ+0VEL0kZndccyUKKpYL35+CH/UsZNvPOCOkbqeqY0foFDs7oJ0dazwJjnXxHOLD
         PL0eH7LPmGxvA==
Subject: [PATCH 04/18] xfs: clear log incompat feature bits when the log is
 idle
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:09 -0700
Message-ID: <161723934912.3149451.16053630119296453937.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

When there are no ongoing transactions and the log contents have been
checkpointed back into the filesystem, the log performs 'covering',
which is to say that it log a dummy transaction to record the fact that
the tail has caught up with the head.  This is a good time to clear log
incompat feature flags, because they are flags that are temporarily set
to limit the range of kernels that can replay a dirty log.

Since it's possible that some other higher level thread is about to
start logging items protected by a log incompat flag, we create a rwsem
so that upper level threads can coordinate this with the log.  It would
probably be more performant to use a percpu rwsem, but the ability to
/try/ taking the write lock during covering is critical, and percpu
rwsems do not provide that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_shared.h |    6 +++++
 fs/xfs/xfs_log.c           |   49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_log.h           |    3 +++
 fs/xfs/xfs_log_priv.h      |    3 +++
 fs/xfs/xfs_trans.c         |   14 +++++++++----
 5 files changed, 71 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 8c61a461bf7b..c7c9a0cebb04 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -62,6 +62,12 @@ void	xfs_log_get_max_trans_res(struct xfs_mount *mp,
 #define	XFS_TRANS_SB_DIRTY	0x02	/* superblock is modified */
 #define	XFS_TRANS_PERM_LOG_RES	0x04	/* xact took a permanent log res */
 #define	XFS_TRANS_SYNC		0x08	/* make commit synchronous */
+/*
+ * This transaction uses a log incompat feature, which means that we must tell
+ * the log that we've finished using it at the transaction commit or cancel.
+ * Callers must call xlog_use_incompat_feat before setting this flag.
+ */
+#define XFS_TRANS_LOG_INCOMPAT	0x10
 #define XFS_TRANS_RESERVE	0x20    /* OK to use reserved data blocks */
 #define XFS_TRANS_NO_WRITECOUNT 0x40	/* do not elevate SB writecount */
 #define XFS_TRANS_RES_FDBLKS	0x80	/* reserve newly freed blocks */
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index cf73bc9f4d18..cb72be62da3e 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1335,6 +1335,32 @@ xfs_log_work_queue(
 				msecs_to_jiffies(xfs_syncd_centisecs * 10));
 }
 
+/*
+ * Clear the log incompat flags if we have the opportunity.
+ *
+ * This only happens if we're about to log the second dummy transaction as part
+ * of covering the log and we can get the log incompat feature usage lock.
+ */
+static inline void
+xlog_clear_incompat(
+	struct xlog		*log)
+{
+	struct xfs_mount	*mp = log->l_mp;
+
+	if (!xfs_sb_has_incompat_log_feature(&mp->m_sb,
+				XFS_SB_FEAT_INCOMPAT_LOG_ALL))
+		return;
+
+	if (log->l_covered_state != XLOG_STATE_COVER_DONE2)
+		return;
+
+	if (!down_write_trylock(&log->l_incompat_users))
+		return;
+
+	xfs_clear_incompat_log_features(mp);
+	up_write(&log->l_incompat_users);
+}
+
 /*
  * Every sync period we need to unpin all items in the AIL and push them to
  * disk. If there is nothing dirty, then we might need to cover the log to
@@ -1361,6 +1387,7 @@ xfs_log_worker(
 		 * synchronously log the superblock instead to ensure the
 		 * superblock is immediately unpinned and can be written back.
 		 */
+		xlog_clear_incompat(log);
 		xfs_sync_sb(mp, true);
 	} else
 		xfs_log_force(mp, 0);
@@ -1443,6 +1470,8 @@ xlog_alloc_log(
 	}
 	log->l_sectBBsize = 1 << log2_size;
 
+	init_rwsem(&log->l_incompat_users);
+
 	xlog_get_iclog_buffer_size(mp, log);
 
 	spin_lock_init(&log->l_icloglock);
@@ -3933,3 +3962,23 @@ xfs_log_in_recovery(
 
 	return log->l_flags & XLOG_ACTIVE_RECOVERY;
 }
+
+/*
+ * Notify the log that we're about to start using a feature that is protected
+ * by a log incompat feature flag.  This will prevent log covering from
+ * clearing those flags.
+ */
+void
+xlog_use_incompat_feat(
+	struct xlog		*log)
+{
+	down_read(&log->l_incompat_users);
+}
+
+/* Notify the log that we've finished using log incompat features. */
+void
+xlog_drop_incompat_feat(
+	struct xlog		*log)
+{
+	up_read(&log->l_incompat_users);
+}
diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
index 044e02cb8921..8b7d0a56cbf1 100644
--- a/fs/xfs/xfs_log.h
+++ b/fs/xfs/xfs_log.h
@@ -145,4 +145,7 @@ bool	xfs_log_in_recovery(struct xfs_mount *);
 
 xfs_lsn_t xlog_grant_push_threshold(struct xlog *log, int need_bytes);
 
+void xlog_use_incompat_feat(struct xlog *log);
+void xlog_drop_incompat_feat(struct xlog *log);
+
 #endif	/* __XFS_LOG_H__ */
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 1c6fdbf3d506..75702c4fa69c 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -436,6 +436,9 @@ struct xlog {
 #endif
 	/* log recovery lsn tracking (for buffer submission */
 	xfs_lsn_t		l_recovery_lsn;
+
+	/* Users of log incompat features should take a read lock. */
+	struct rw_semaphore	l_incompat_users;
 };
 
 #define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index eb2d8e2e5db6..e548d53c2091 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -71,6 +71,9 @@ xfs_trans_free(
 	xfs_extent_busy_sort(&tp->t_busy);
 	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
 
+	if (tp->t_flags & XFS_TRANS_LOG_INCOMPAT)
+		xlog_drop_incompat_feat(tp->t_mountp->m_log);
+
 	trace_xfs_trans_free(tp, _RET_IP_);
 	xfs_trans_clear_context(tp);
 	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
@@ -110,10 +113,13 @@ xfs_trans_dup(
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 	ASSERT(tp->t_ticket != NULL);
 
-	ntp->t_flags = XFS_TRANS_PERM_LOG_RES |
-		       (tp->t_flags & XFS_TRANS_RESERVE) |
-		       (tp->t_flags & XFS_TRANS_NO_WRITECOUNT) |
-		       (tp->t_flags & XFS_TRANS_RES_FDBLKS);
+	ntp->t_flags = tp->t_flags & (XFS_TRANS_PERM_LOG_RES |
+				      XFS_TRANS_RESERVE |
+				      XFS_TRANS_NO_WRITECOUNT |
+				      XFS_TRANS_RES_FDBLKS |
+				      XFS_TRANS_LOG_INCOMPAT);
+	/* Give our LOG_INCOMPAT reference to the new transaction. */
+	tp->t_flags &= ~XFS_TRANS_LOG_INCOMPAT;
 	/* We gave our writer reference to the new transaction */
 	tp->t_flags |= XFS_TRANS_NO_WRITECOUNT;
 	ntp->t_ticket = xfs_log_ticket_get(tp->t_ticket);

