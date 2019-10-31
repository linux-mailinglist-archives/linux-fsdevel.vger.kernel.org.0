Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04091EBB03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJaXq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:29 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40131 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728443AbfJaXq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:29 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 699FD7EA73F;
        Fri,  1 Nov 2019 10:46:20 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007C6-6J; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041R-3r; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/28] xfs: factor common AIL item deletion code
Date:   Fri,  1 Nov 2019 10:45:56 +1100
Message-Id: <20191031234618.15403-7-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=MYL0kNLdbJVOrCnBhk4A:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Factor the common AIL deletion code that does all the wakeups into a
helper so we only have one copy of this somewhat tricky code to
interface with all the wakeups necessary when the LSN of the log
tail changes.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_inode_item.c | 12 +----------
 fs/xfs/xfs_trans_ail.c  | 48 ++++++++++++++++++++++-------------------
 fs/xfs/xfs_trans_priv.h |  4 +++-
 3 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index bb8f076805b9..ab12e526540a 100644
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
+		xfs_ail_update_finish(ailp, mlip_changed);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 6ccfd75d3c24..656819523bbd 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -678,6 +678,27 @@ xfs_ail_push_all_sync(
 	finish_wait(&ailp->ail_empty, &wait);
 }
 
+void
+xfs_ail_update_finish(
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
+	if (list_empty(&ailp->ail_head))
+		wake_up_all(&ailp->ail_empty);
+	spin_unlock(&ailp->ail_lock);
+	xfs_log_space_wake(mp);
+}
+
 /*
  * xfs_trans_ail_update - bulk AIL insertion operation.
  *
@@ -737,15 +758,7 @@ xfs_trans_ail_update_bulk(
 	if (!list_empty(&tmp))
 		xfs_ail_splice(ailp, cur, &tmp, lsn);
 
-	if (mlip_changed) {
-		if (!XFS_FORCED_SHUTDOWN(ailp->ail_mount))
-			xlog_assign_tail_lsn_locked(ailp->ail_mount);
-		spin_unlock(&ailp->ail_lock);
-
-		xfs_log_space_wake(ailp->ail_mount);
-	} else {
-		spin_unlock(&ailp->ail_lock);
-	}
+	xfs_ail_update_finish(ailp, mlip_changed);
 }
 
 bool
@@ -789,10 +802,10 @@ void
 xfs_trans_ail_delete(
 	struct xfs_ail		*ailp,
 	struct xfs_log_item	*lip,
-	int			shutdown_type) __releases(ailp->ail_lock)
+	int			shutdown_type)
 {
 	struct xfs_mount	*mp = ailp->ail_mount;
-	bool			mlip_changed;
+	bool			need_update;
 
 	if (!test_bit(XFS_LI_IN_AIL, &lip->li_flags)) {
 		spin_unlock(&ailp->ail_lock);
@@ -805,17 +818,8 @@ xfs_trans_ail_delete(
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
+	need_update = xfs_ail_delete_one(ailp, lip);
+	xfs_ail_update_finish(ailp, need_update);
 }
 
 int
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 2e073c1c4614..64ffa746730e 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -92,8 +92,10 @@ xfs_trans_ail_update(
 }
 
 bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
+void xfs_ail_update_finish(struct xfs_ail *ailp, bool do_tail_update)
+			__releases(ailp->ail_lock);
 void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
-		int shutdown_type) __releases(ailp->ail_lock);
+		int shutdown_type);
 
 static inline void
 xfs_trans_ail_remove(
-- 
2.24.0.rc0

