Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75FD05EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIDVl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:41 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46731 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730530AbfJIDVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:40 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5674943ECB3;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006Bw-BE; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039o-8x; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/26] xfs: kill background reclaim work
Date:   Wed,  9 Oct 2019 14:21:17 +1100
Message-Id: <20191009032124.10541-20-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=1xoyCpcK-Ekt5S4qF2sA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This function is now entirely done by kswapd, so we don't need the
worker thread to do async reclaim anymore.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 44 --------------------------------------------
 fs/xfs/xfs_icache.h |  2 --
 fs/xfs/xfs_mount.c  |  2 --
 fs/xfs/xfs_mount.h  |  2 --
 fs/xfs/xfs_super.c  | 11 +----------
 5 files changed, 1 insertion(+), 60 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 189cf423fe8f..7e175304e146 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -138,44 +138,6 @@ xfs_inode_free(
 	__xfs_inode_free(ip);
 }
 
-/*
- * Queue a new inode reclaim pass if there are reclaimable inodes and there
- * isn't a reclaim pass already in progress. By default it runs every 5s based
- * on the xfs periodic sync default of 30s. Perhaps this should have it's own
- * tunable, but that can be done if this method proves to be ineffective or too
- * aggressive.
- */
-static void
-xfs_reclaim_work_queue(
-	struct xfs_mount        *mp)
-{
-
-	rcu_read_lock();
-	if (radix_tree_tagged(&mp->m_perag_tree, XFS_ICI_RECLAIM_TAG)) {
-		queue_delayed_work(mp->m_reclaim_workqueue, &mp->m_reclaim_work,
-			msecs_to_jiffies(xfs_syncd_centisecs / 6 * 10));
-	}
-	rcu_read_unlock();
-}
-
-/*
- * This is a fast pass over the inode cache to try to get reclaim moving on as
- * many inodes as possible in a short period of time. It kicks itself every few
- * seconds, as well as being kicked by the inode cache shrinker when memory
- * goes low. It scans as quickly as possible avoiding locked inodes or those
- * already being flushed, and once done schedules a future pass.
- */
-void
-xfs_reclaim_worker(
-	struct work_struct *work)
-{
-	struct xfs_mount *mp = container_of(to_delayed_work(work),
-					struct xfs_mount, m_reclaim_work);
-
-	xfs_reclaim_inodes(mp, SYNC_TRYLOCK);
-	xfs_reclaim_work_queue(mp);
-}
-
 static void
 xfs_perag_set_reclaim_tag(
 	struct xfs_perag	*pag)
@@ -192,9 +154,6 @@ xfs_perag_set_reclaim_tag(
 			   XFS_ICI_RECLAIM_TAG);
 	spin_unlock(&mp->m_perag_lock);
 
-	/* schedule periodic background inode reclaim */
-	xfs_reclaim_work_queue(mp);
-
 	trace_xfs_perag_set_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
 }
 
@@ -1393,9 +1352,6 @@ xfs_reclaim_inodes_nr(
 {
 	int			sync_mode = SYNC_TRYLOCK;
 
-	/* kick background reclaimer */
-	xfs_reclaim_work_queue(mp);
-
 	/*
 	 * For kswapd, we kick background inode writeback. For direct
 	 * reclaim, we issue and wait on inode writeback to throttle
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 48f1fd2bb6ad..4c0d8920cc54 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -49,8 +49,6 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
 struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
-void xfs_reclaim_worker(struct work_struct *work);
-
 int xfs_reclaim_inodes(struct xfs_mount *mp, int mode);
 int xfs_reclaim_inodes_count(struct xfs_mount *mp);
 long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index ba5b6f3b2b88..ecbc21af9100 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -988,7 +988,6 @@ xfs_mountfs(
 	 * qm_unmount_quotas and therefore rely on qm_unmount to release the
 	 * quota inodes.
 	 */
-	cancel_delayed_work_sync(&mp->m_reclaim_work);
 	xfs_reclaim_inodes(mp, SYNC_WAIT);
 	xfs_health_unmount(mp);
  out_log_dealloc:
@@ -1071,7 +1070,6 @@ xfs_unmountfs(
 	 * reclaim just to be sure. We can stop background inode reclaim
 	 * here as well if it is still running.
 	 */
-	cancel_delayed_work_sync(&mp->m_reclaim_work);
 	xfs_reclaim_inodes(mp, SYNC_WAIT);
 	xfs_health_unmount(mp);
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fdb60e09a9c5..f0cc952ad527 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -165,7 +165,6 @@ typedef struct xfs_mount {
 	uint			m_chsize;	/* size of next field */
 	atomic_t		m_active_trans;	/* number trans frozen */
 	struct xfs_mru_cache	*m_filestream;  /* per-mount filestream data */
-	struct delayed_work	m_reclaim_work;	/* background inode reclaim */
 	struct delayed_work	m_eofblocks_work; /* background eof blocks
 						     trimming */
 	struct delayed_work	m_cowblocks_work; /* background cow blocks
@@ -182,7 +181,6 @@ typedef struct xfs_mount {
 	struct workqueue_struct *m_buf_workqueue;
 	struct workqueue_struct	*m_unwritten_workqueue;
 	struct workqueue_struct	*m_cil_workqueue;
-	struct workqueue_struct	*m_reclaim_workqueue;
 	struct workqueue_struct *m_eofblocks_workqueue;
 	struct workqueue_struct	*m_sync_workqueue;
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f0aff1f034e6..74767e6f48a7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -823,15 +823,10 @@ xfs_init_mount_workqueues(
 	if (!mp->m_cil_workqueue)
 		goto out_destroy_unwritten;
 
-	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
-			WQ_MEM_RECLAIM|WQ_FREEZABLE, 0, mp->m_fsname);
-	if (!mp->m_reclaim_workqueue)
-		goto out_destroy_cil;
-
 	mp->m_eofblocks_workqueue = alloc_workqueue("xfs-eofblocks/%s",
 			WQ_MEM_RECLAIM|WQ_FREEZABLE, 0, mp->m_fsname);
 	if (!mp->m_eofblocks_workqueue)
-		goto out_destroy_reclaim;
+		goto out_destroy_cil;
 
 	mp->m_sync_workqueue = alloc_workqueue("xfs-sync/%s", WQ_FREEZABLE, 0,
 					       mp->m_fsname);
@@ -842,8 +837,6 @@ xfs_init_mount_workqueues(
 
 out_destroy_eofb:
 	destroy_workqueue(mp->m_eofblocks_workqueue);
-out_destroy_reclaim:
-	destroy_workqueue(mp->m_reclaim_workqueue);
 out_destroy_cil:
 	destroy_workqueue(mp->m_cil_workqueue);
 out_destroy_unwritten:
@@ -860,7 +853,6 @@ xfs_destroy_mount_workqueues(
 {
 	destroy_workqueue(mp->m_sync_workqueue);
 	destroy_workqueue(mp->m_eofblocks_workqueue);
-	destroy_workqueue(mp->m_reclaim_workqueue);
 	destroy_workqueue(mp->m_cil_workqueue);
 	destroy_workqueue(mp->m_unwritten_workqueue);
 	destroy_workqueue(mp->m_buf_workqueue);
@@ -1558,7 +1550,6 @@ xfs_mount_alloc(
 	spin_lock_init(&mp->m_perag_lock);
 	mutex_init(&mp->m_growlock);
 	atomic_set(&mp->m_active_trans, 0);
-	INIT_DELAYED_WORK(&mp->m_reclaim_work, xfs_reclaim_worker);
 	INIT_DELAYED_WORK(&mp->m_eofblocks_work, xfs_eofblocks_worker);
 	INIT_DELAYED_WORK(&mp->m_cowblocks_work, xfs_cowblocks_worker);
 	mp->m_kobj.kobject.kset = xfs_kset;
-- 
2.23.0.rc1

