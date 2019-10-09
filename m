Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C78D05D7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfJIDVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:32 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57561 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730274AbfJIDVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:32 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4039F362956;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006Bm-7A; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039f-5C; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/26] xfs: synchronous AIL pushing
Date:   Wed,  9 Oct 2019 14:21:14 +1100
Message-Id: <20191009032124.10541-17-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=LpVGDu2G9yASKScQ9C8A:9
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

xfs_ail_push_sync() is temporary infrastructure to facilitate
non-blocking, IO-less inode reclaim throttling that allows further
structural changes to be made. Once those structural changes are
made, the need for this function goes away and it is removed,
leaving us with only the xfs_ail_update_finish() factoring when this
is all done.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_trans_ail.c  | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_trans_priv.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 685a21cd24c0..5e500a75b62b 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -662,6 +662,37 @@ xfs_ail_push_all(
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
@@ -702,6 +733,7 @@ xfs_ail_update_finish(
 	if (!XFS_FORCED_SHUTDOWN(mp))
 		xlog_assign_tail_lsn_locked(mp);
 
+	wake_up_all(&ailp->ail_push);
 	if (list_empty(&ailp->ail_head))
 		wake_up_all(&ailp->ail_empty);
 	spin_unlock(&ailp->ail_lock);
@@ -858,6 +890,7 @@ xfs_trans_ail_init(
 	spin_lock_init(&ailp->ail_lock);
 	INIT_LIST_HEAD(&ailp->ail_buf_list);
 	init_waitqueue_head(&ailp->ail_empty);
+	init_waitqueue_head(&ailp->ail_push);
 
 	ailp->ail_task = kthread_run(xfsaild, ailp, "xfsaild/%s",
 			ailp->ail_mount->m_fsname);
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 35655eac01a6..1b6f4bbd47c0 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -61,6 +61,7 @@ struct xfs_ail {
 	int			ail_log_flush;
 	struct list_head	ail_buf_list;
 	wait_queue_head_t	ail_empty;
+	wait_queue_head_t	ail_push;
 };
 
 /*
@@ -113,6 +114,7 @@ xfs_trans_ail_remove(
 }
 
 void			xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
+void			xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
 void			xfs_ail_push_all(struct xfs_ail *);
 void			xfs_ail_push_all_sync(struct xfs_ail *);
 struct xfs_log_item	*xfs_ail_min(struct xfs_ail  *ailp);
-- 
2.23.0.rc1

