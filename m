Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C17D317
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfHACSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34892 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfHACSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:02 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B21B3361C1D;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003az-4z; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lB-2Z; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/24] xfs: synchronous AIL pushing
Date:   Thu,  1 Aug 2019 12:17:41 +1000
Message-Id: <20190801021752.4986-14-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=PhaVPwl61JEQPYHB4h0A:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Provide an interface to push the AIL to a target LSN and wait for
the tail of the log to move past that LSN. This is used to wait for
all items older than a specific LSN to either be cleaned (written
back) or relogged to a higher LSN in the AIL. The primary use for
this is to allow IO free inode reclaim throttling.

Factor the common AIL deletion code that does all the wakeups into a
helper so we only have one copy of this somewhat tricky code to
interface with all the wakeups necessary when the LSN of the log
tail changes.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_inode_item.c | 12 +------
 fs/xfs/xfs_trans_ail.c  | 69 +++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_trans_priv.h |  6 +++-
 3 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index c9a502eed204..7b942a63e992 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -743,17 +743,7 @@ xfs_iflush_done(
 				xfs_clear_li_failed(blip);
 			}
 		}
-
-		if (mlip_changed) {
-			if (!XFS_FORCED_SHUTDOWN(ailp->ail_mount))
-				xlog_assign_tail_lsn_locked(ailp->ail_mount);
-			if (list_empty(&ailp->ail_head))
-				wake_up_all(&ailp->ail_empty);
-		}
-		spin_unlock(&ailp->ail_lock);
-
-		if (mlip_changed)
-			xfs_log_space_wake(ailp->ail_mount);
+		xfs_ail_delete_finish(ailp, mlip_changed);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 6ccfd75d3c24..9e3102179221 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -654,6 +654,37 @@ xfs_ail_push_all(
 		xfs_ail_push(ailp, threshold_lsn);
 }
 
+/*
+ * Push the AIL to a specific lsn and wait for it to complete.
+ */
+void
+xfs_ail_push_sync(
+	struct xfs_ail		*ailp,
+	xfs_lsn_t		threshold_lsn)
+{
+	struct xfs_log_item	*lip;
+	DEFINE_WAIT(wait);
+
+	spin_lock(&ailp->ail_lock);
+	while ((lip = xfs_ail_min(ailp)) != NULL) {
+		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
+		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
+		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
+			break;
+		/* XXX: cmpxchg? */
+		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
+			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);
+		wake_up_process(ailp->ail_task);
+		spin_unlock(&ailp->ail_lock);
+		schedule();
+		spin_lock(&ailp->ail_lock);
+	}
+	spin_unlock(&ailp->ail_lock);
+
+	finish_wait(&ailp->ail_push, &wait);
+}
+
+
 /*
  * Push out all items in the AIL immediately and wait until the AIL is empty.
  */
@@ -764,6 +795,28 @@ xfs_ail_delete_one(
 	return mlip == lip;
 }
 
+void
+xfs_ail_delete_finish(
+	struct xfs_ail		*ailp,
+	bool			do_tail_update) __releases(ailp->ail_lock)
+{
+	struct xfs_mount	*mp = ailp->ail_mount;
+
+	if (!do_tail_update) {
+		spin_unlock(&ailp->ail_lock);
+		return;
+	}
+
+	if (!XFS_FORCED_SHUTDOWN(mp))
+		xlog_assign_tail_lsn_locked(mp);
+
+	wake_up_all(&ailp->ail_push);
+	if (list_empty(&ailp->ail_head))
+		wake_up_all(&ailp->ail_empty);
+	spin_unlock(&ailp->ail_lock);
+	xfs_log_space_wake(mp);
+}
+
 /**
  * Remove a log items from the AIL
  *
@@ -789,10 +842,9 @@ void
 xfs_trans_ail_delete(
 	struct xfs_ail		*ailp,
 	struct xfs_log_item	*lip,
-	int			shutdown_type) __releases(ailp->ail_lock)
+	int			shutdown_type)
 {
 	struct xfs_mount	*mp = ailp->ail_mount;
-	bool			mlip_changed;
 
 	if (!test_bit(XFS_LI_IN_AIL, &lip->li_flags)) {
 		spin_unlock(&ailp->ail_lock);
@@ -805,17 +857,7 @@ xfs_trans_ail_delete(
 		return;
 	}
 
-	mlip_changed = xfs_ail_delete_one(ailp, lip);
-	if (mlip_changed) {
-		if (!XFS_FORCED_SHUTDOWN(mp))
-			xlog_assign_tail_lsn_locked(mp);
-		if (list_empty(&ailp->ail_head))
-			wake_up_all(&ailp->ail_empty);
-	}
-
-	spin_unlock(&ailp->ail_lock);
-	if (mlip_changed)
-		xfs_log_space_wake(ailp->ail_mount);
+	xfs_ail_delete_finish(ailp, xfs_ail_delete_one(ailp, lip));
 }
 
 int
@@ -834,6 +876,7 @@ xfs_trans_ail_init(
 	spin_lock_init(&ailp->ail_lock);
 	INIT_LIST_HEAD(&ailp->ail_buf_list);
 	init_waitqueue_head(&ailp->ail_empty);
+	init_waitqueue_head(&ailp->ail_push);
 
 	ailp->ail_task = kthread_run(xfsaild, ailp, "xfsaild/%s",
 			ailp->ail_mount->m_fsname);
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 2e073c1c4614..5ab70b9b896f 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -61,6 +61,7 @@ struct xfs_ail {
 	int			ail_log_flush;
 	struct list_head	ail_buf_list;
 	wait_queue_head_t	ail_empty;
+	wait_queue_head_t	ail_push;
 };
 
 /*
@@ -92,8 +93,10 @@ xfs_trans_ail_update(
 }
 
 bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
+void xfs_ail_delete_finish(struct xfs_ail *ailp, bool do_tail_update)
+			__releases(ailp->ail_lock);
 void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
-		int shutdown_type) __releases(ailp->ail_lock);
+		int shutdown_type);
 
 static inline void
 xfs_trans_ail_remove(
@@ -111,6 +114,7 @@ xfs_trans_ail_remove(
 }
 
 void			xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
+void			xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
 void			xfs_ail_push_all(struct xfs_ail *);
 void			xfs_ail_push_all_sync(struct xfs_ail *);
 struct xfs_log_item	*xfs_ail_min(struct xfs_ail  *ailp);
-- 
2.22.0

