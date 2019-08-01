Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE67D33E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfHACSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:24 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33655 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729501AbfHACSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:18 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A345643EC85;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003b2-6Z; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lE-44; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/24] xfs: tail updates only need to occur when LSN changes
Date:   Thu,  1 Aug 2019 12:17:42 +1000
Message-Id: <20190801021752.4986-15-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=yAjffBypbmNlQjcpRW8A:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

We currently wake anything waiting on the log tail to move whenever
the log item at the tail of the log is removed. Historically this
was fine behaviour because there were very few items at any given
LSN. But with delayed logging, there may be thousands of items at
any given LSN, and we can't move the tail until they are all gone.

Hence if we are removing them in near tail-first order, we might be
waking up processes waiting on the tail LSN to change (e.g. log
space waiters) repeatedly without them being able to make progress.
This also occurs with the new sync push waiters, and can result in
thousands of spurious wakeups every second when under heavy direct
reclaim pressure.

To fix this, check that the tail LSN has actually changed on the
AIL before triggering wakeups. This will reduce the number of
spurious wakeups when doing bulk AIL removal and make this code much
more efficient.

XXX: occasionally get a temporary hang in xfs_ail_push_sync() with
this change - log force from log worker gets things moving again.
Only happens under extreme memory pressure - possibly push racing
with a tail update on an empty log. Needs further investigation.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_inode_item.c | 18 +++++++++++++-----
 fs/xfs/xfs_trans_ail.c  | 37 ++++++++++++++++++++++++++++---------
 fs/xfs/xfs_trans_priv.h |  4 ++--
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 7b942a63e992..16a7d6f752c9 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -731,19 +731,27 @@ xfs_iflush_done(
 	 * holding the lock before removing the inode from the AIL.
 	 */
 	if (need_ail) {
-		bool			mlip_changed = false;
+		xfs_lsn_t	tail_lsn = 0;
 
 		/* this is an opencoded batch version of xfs_trans_ail_delete */
 		spin_lock(&ailp->ail_lock);
 		list_for_each_entry(blip, &tmp, li_bio_list) {
 			if (INODE_ITEM(blip)->ili_logged &&
-			    blip->li_lsn == INODE_ITEM(blip)->ili_flush_lsn)
-				mlip_changed |= xfs_ail_delete_one(ailp, blip);
-			else {
+			    blip->li_lsn == INODE_ITEM(blip)->ili_flush_lsn) {
+				/*
+				 * xfs_ail_delete_finish() only cares about the
+				 * lsn of the first tail item removed, any others
+				 * will be at the same or higher lsn so we just
+				 * ignore them.
+				 */
+				xfs_lsn_t lsn = xfs_ail_delete_one(ailp, blip);
+				if (!tail_lsn && lsn)
+					tail_lsn = lsn;
+			} else {
 				xfs_clear_li_failed(blip);
 			}
 		}
-		xfs_ail_delete_finish(ailp, mlip_changed);
+		xfs_ail_delete_finish(ailp, tail_lsn);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 9e3102179221..00d66175f41a 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -108,17 +108,25 @@ xfs_ail_next(
  * We need the AIL lock in order to get a coherent read of the lsn of the last
  * item in the AIL.
  */
+static xfs_lsn_t
+__xfs_ail_min_lsn(
+	struct xfs_ail		*ailp)
+{
+	struct xfs_log_item	*lip = xfs_ail_min(ailp);
+
+	if (lip)
+		return lip->li_lsn;
+	return 0;
+}
+
 xfs_lsn_t
 xfs_ail_min_lsn(
 	struct xfs_ail		*ailp)
 {
-	xfs_lsn_t		lsn = 0;
-	struct xfs_log_item	*lip;
+	xfs_lsn_t		lsn;
 
 	spin_lock(&ailp->ail_lock);
-	lip = xfs_ail_min(ailp);
-	if (lip)
-		lsn = lip->li_lsn;
+	lsn = __xfs_ail_min_lsn(ailp);
 	spin_unlock(&ailp->ail_lock);
 
 	return lsn;
@@ -779,12 +787,20 @@ xfs_trans_ail_update_bulk(
 	}
 }
 
-bool
+/*
+ * Delete one log item from the AIL.
+ *
+ * If this item was at the tail of the AIL, return the LSN of the log item so
+ * that we can use it to check if the LSN of the tail of the log has moved
+ * when finishing up the AIL delete process in xfs_ail_delete_finish().
+ */
+xfs_lsn_t
 xfs_ail_delete_one(
 	struct xfs_ail		*ailp,
 	struct xfs_log_item	*lip)
 {
 	struct xfs_log_item	*mlip = xfs_ail_min(ailp);
+	xfs_lsn_t		lsn = lip->li_lsn;
 
 	trace_xfs_ail_delete(lip, mlip->li_lsn, lip->li_lsn);
 	xfs_ail_delete(ailp, lip);
@@ -792,17 +808,20 @@ xfs_ail_delete_one(
 	clear_bit(XFS_LI_IN_AIL, &lip->li_flags);
 	lip->li_lsn = 0;
 
-	return mlip == lip;
+	if (mlip == lip)
+		return lsn;
+	return 0;
 }
 
 void
 xfs_ail_delete_finish(
 	struct xfs_ail		*ailp,
-	bool			do_tail_update) __releases(ailp->ail_lock)
+	xfs_lsn_t		old_lsn) __releases(ailp->ail_lock)
 {
 	struct xfs_mount	*mp = ailp->ail_mount;
 
-	if (!do_tail_update) {
+	/* if the tail lsn hasn't changed, don't do updates or wakeups. */
+	if (!old_lsn || old_lsn == __xfs_ail_min_lsn(ailp)) {
 		spin_unlock(&ailp->ail_lock);
 		return;
 	}
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 5ab70b9b896f..db589bb7468d 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -92,8 +92,8 @@ xfs_trans_ail_update(
 	xfs_trans_ail_update_bulk(ailp, NULL, &lip, 1, lsn);
 }
 
-bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
-void xfs_ail_delete_finish(struct xfs_ail *ailp, bool do_tail_update)
+xfs_lsn_t xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
+void xfs_ail_delete_finish(struct xfs_ail *ailp, xfs_lsn_t old_lsn)
 			__releases(ailp->ail_lock);
 void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
 		int shutdown_type);
-- 
2.22.0

