Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3513EBAC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfJaXqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55593 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbfJaXqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:31 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 898E73A2897;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Ck-SB; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042Q-Q9; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/28] xfs: use xfs_ail_push_all in xfs_reclaim_inodes
Date:   Fri,  1 Nov 2019 10:46:16 +1100
Message-Id: <20191031234618.15403-27-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=WMbJ51up1JB3X8GliIAA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

If we are reclaiming all inodes, it is likely we need to flush the
entire AIL to do that. We have mechanisms to do that without needing
to push to a specific LSN.

Convert xfs_relaim_all_inodes() to use xfs_ail_push_all variant so
we can get rid of the hacky xfs_ail_push_sync() scaffolding we used
to support the intermediate stages of the non-blocking reclaim
changeset.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c     | 17 +++++++++++------
 fs/xfs/xfs_trans_ail.c  | 32 --------------------------------
 fs/xfs/xfs_trans_priv.h |  2 --
 3 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 71a729e29260..11bf4768d491 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -25,6 +25,7 @@
 #include "xfs_log.h"
 
 #include <linux/iversion.h>
+#include <linux/backing-dev.h>	/* for congestion_wait() */
 
 /*
  * Allocate and initialise an xfs_inode.
@@ -1051,6 +1052,10 @@ xfs_dispose_inodes(
 		cond_resched();
 	}
 }
+
+/*
+ * Reclaim all unused inodes in the filesystem.
+ */
 void
 xfs_reclaim_all_inodes(
 	struct xfs_mount	*mp)
@@ -1059,6 +1064,9 @@ xfs_reclaim_all_inodes(
 		struct xfs_ireclaim_args ra;
 		long freed, to_free;
 
+		/* push the AIL to clean dirty reclaimable inodes */
+		xfs_ail_push_all(mp->m_ail);
+
 		xfs_ireclaim_args_init(&ra);
 
 		to_free = list_lru_count(&mp->m_inode_lru);
@@ -1066,13 +1074,10 @@ xfs_reclaim_all_inodes(
 				      xfs_inode_reclaim_isolate, &ra, to_free);
 		xfs_dispose_inodes(&ra.freeable);
 
-		if (freed == 0) {
+		if (freed == 0)
 			xfs_log_force(mp, XFS_LOG_SYNC);
-			xfs_ail_push_all(mp->m_ail);
-		} else if (ra.lowest_lsn != NULLCOMMITLSN) {
-			xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
-		}
-		cond_resched();
+		else if (ra.dirty_skipped)
+			congestion_wait(BLK_RW_ASYNC, HZ/10);
 	}
 }
 
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 3e1d0e1439e2..685a21cd24c0 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -662,36 +662,6 @@ xfs_ail_push_all(
 		xfs_ail_push(ailp, threshold_lsn);
 }
 
-/*
- * Push the AIL to a specific lsn and wait for it to complete.
- */
-void
-xfs_ail_push_sync(
-	struct xfs_ail		*ailp,
-	xfs_lsn_t		threshold_lsn)
-{
-	struct xfs_log_item	*lip;
-	DEFINE_WAIT(wait);
-
-	spin_lock(&ailp->ail_lock);
-	while ((lip = xfs_ail_min(ailp)) != NULL) {
-		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
-		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
-		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
-			break;
-		if (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
-			ailp->ail_target = threshold_lsn;
-		wake_up_process(ailp->ail_task);
-		spin_unlock(&ailp->ail_lock);
-		schedule();
-		spin_lock(&ailp->ail_lock);
-	}
-	spin_unlock(&ailp->ail_lock);
-
-	finish_wait(&ailp->ail_push, &wait);
-}
-
-
 /*
  * Push out all items in the AIL immediately and wait until the AIL is empty.
  */
@@ -732,7 +702,6 @@ xfs_ail_update_finish(
 	if (!XFS_FORCED_SHUTDOWN(mp))
 		xlog_assign_tail_lsn_locked(mp);
 
-	wake_up_all(&ailp->ail_push);
 	if (list_empty(&ailp->ail_head))
 		wake_up_all(&ailp->ail_empty);
 	spin_unlock(&ailp->ail_lock);
@@ -889,7 +858,6 @@ xfs_trans_ail_init(
 	spin_lock_init(&ailp->ail_lock);
 	INIT_LIST_HEAD(&ailp->ail_buf_list);
 	init_waitqueue_head(&ailp->ail_empty);
-	init_waitqueue_head(&ailp->ail_push);
 
 	ailp->ail_task = kthread_run(xfsaild, ailp, "xfsaild/%s",
 			ailp->ail_mount->m_fsname);
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 1b6f4bbd47c0..35655eac01a6 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -61,7 +61,6 @@ struct xfs_ail {
 	int			ail_log_flush;
 	struct list_head	ail_buf_list;
 	wait_queue_head_t	ail_empty;
-	wait_queue_head_t	ail_push;
 };
 
 /*
@@ -114,7 +113,6 @@ xfs_trans_ail_remove(
 }
 
 void			xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
-void			xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
 void			xfs_ail_push_all(struct xfs_ail *);
 void			xfs_ail_push_all_sync(struct xfs_ail *);
 struct xfs_log_item	*xfs_ail_min(struct xfs_ail  *ailp);
-- 
2.24.0.rc0

