Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EFEEBB07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfJaXsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:48:14 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55729 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728398AbfJaXq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:29 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 178993A288C;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007CS-Ie; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00041y-Gp; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/28] xfs: synchronous AIL pushing
Date:   Fri,  1 Nov 2019 10:46:07 +1100
Message-Id: <20191031234618.15403-18-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=Yw-OB7zFZuFGJ-GQUAcA:9
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
made, the need for this function goes away and it is removed. In
essence, it is only provided to ensure git bisects don't break while
the changes to the reclaim algorithms are in progress.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_trans_ail.c  | 32 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_trans_priv.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 685a21cd24c0..3e1d0e1439e2 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -662,6 +662,36 @@ xfs_ail_push_all(
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
+		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
+			break;
+		if (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
+			ailp->ail_target = threshold_lsn;
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
@@ -702,6 +732,7 @@ xfs_ail_update_finish(
 	if (!XFS_FORCED_SHUTDOWN(mp))
 		xlog_assign_tail_lsn_locked(mp);
 
+	wake_up_all(&ailp->ail_push);
 	if (list_empty(&ailp->ail_head))
 		wake_up_all(&ailp->ail_empty);
 	spin_unlock(&ailp->ail_lock);
@@ -858,6 +889,7 @@ xfs_trans_ail_init(
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
2.24.0.rc0

