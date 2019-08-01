Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC877D341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfHACSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:30 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35262 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729414AbfHACSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:15 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A20B2361419;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bJ-ES; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lW-Ci; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/24] xfs: use AIL pushing for inode reclaim IO
Date:   Thu,  1 Aug 2019 12:17:48 +1000
Message-Id: <20190801021752.4986-21-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=gx66ZOwSCviGFWpCog4A:9 a=6HkFz5UkQjFoDJN8:21 a=VkB9qLNburQgnVq-:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Inode reclaim currently issues it's own inode IO when it comes
across dirty inodes. This is used to throttle direct reclaim down to
the rate at which we can reclaim dirty inodes. Failure to throttle
in this manner results in the OOM killer being trivial to trigger
even when there is lots of free memory available.

However, having direct reclaimers issue IO causes an amount of
IO thrashing to occur. We can have up to the number of AGs in the
filesystem concurrently issuing IO, plus the AIL pushing thread as
well. This means we can many competing sources of IO and they all
end up thrashing and competing for the request slots in the block
device.

Similar to dirty page throttling and the BDI flusher thread, we can
use the AIL pushing thread the sole place we issue inode writeback
from and everything else waits for it to make progress. To do this,
reclaim will skip over dirty inodes, but in doing so will record the
lowest LSN of all the dirty inodes it skips. It will then push the
AIL to this LSN and wait for it to complete that work.

In doing so, we block direct reclaim on the IO of at least one IO,
thereby providing some level of throttling for when we encounter
dirty inodes. However we gain the ability to scan and reclaim
clean inodes in a non-blocking fashion. This allows us to
remove all the per-ag reclaim locking that avoids excessive direct
reclaim, as repeated concurrent direct reclaim will hit the same
dirty inodes on block waiting on the same IO to complete.

Hence direct reclaim will be throttled directly by the rate at which
dirty inodes are cleaned by AIL pushing, rather than by delays
caused by competing IO submissions. This allows us to remove all the
locking that limits direct reclaim concurrency and greatly
simplifies the inode reclaim code now that it just skips dirty
inodes.

Note: this patch by itself isn't completely able to throttle direct
reclaim sufficiently to prevent OOM killer madness. We can't do that
until we change the way we index reclaimable inodes in the next
patch and can feed back state to the mm core sanely.  However, we
can't change the way we index reclaimable inodes until we have
IO-less non-blocking reclaim for both direct reclaim and kswapd
reclaim.  Catch-22...

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c    | 208 +++++++++++++++++------------------------
 fs/xfs/xfs_mount.c     |   4 -
 fs/xfs/xfs_mount.h     |   1 -
 fs/xfs/xfs_trans_ail.c |   4 +-
 4 files changed, 90 insertions(+), 127 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 0bd4420a7e16..4c4c5bc12147 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -22,6 +22,7 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_log.h"
 
 #include <linux/iversion.h>
 
@@ -967,28 +968,42 @@ xfs_inode_ag_iterator_tag(
 }
 
 /*
- * Grab the inode for reclaim exclusively.
- * Return 0 if we grabbed it, non-zero otherwise.
+ * Grab the inode for reclaim.
+ *
+ * Return false if we aren't going to reclaim it, true if it is a reclaim
+ * candidate.
+ *
+ * If the inode is clean or unreclaimable, return NULLCOMMITLSN to tell the
+ * caller it does not require flushing. Otherwise return the log item lsn of the
+ * inode so the caller can determine it's inode flush target.  If we get the
+ * clean/dirty state wrong then it will be sorted in xfs_reclaim_inode() once we
+ * have locks held.
  */
-STATIC int
+STATIC bool
 xfs_reclaim_inode_grab(
 	struct xfs_inode	*ip,
-	int			flags)
+	int			flags,
+	xfs_lsn_t		*lsn)
 {
 	ASSERT(rcu_read_lock_held());
+	*lsn = 0;
 
 	/* quick check for stale RCU freed inode */
 	if (!ip->i_ino)
-		return 1;
+		return false;
 
 	/*
-	 * If we are asked for non-blocking operation, do unlocked checks to
-	 * see if the inode already is being flushed or in reclaim to avoid
-	 * lock traffic.
+	 * Do unlocked checks to see if the inode already is being flushed or in
+	 * reclaim to avoid lock traffic. If the inode is not clean, return the
+	 * it's position in the AIL for the caller to push to.
 	 */
-	if ((flags & SYNC_TRYLOCK) &&
-	    __xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
-		return 1;
+	if (!xfs_inode_clean(ip)) {
+		*lsn = ip->i_itemp->ili_item.li_lsn;
+		return false;
+	}
+
+	if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
+		return false;
 
 	/*
 	 * The radix tree lock here protects a thread in xfs_iget from racing
@@ -1005,11 +1020,11 @@ xfs_reclaim_inode_grab(
 	    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
 		/* not a reclaim candidate. */
 		spin_unlock(&ip->i_flags_lock);
-		return 1;
+		return false;
 	}
 	__xfs_iflags_set(ip, XFS_IRECLAIM);
 	spin_unlock(&ip->i_flags_lock);
-	return 0;
+	return true;
 }
 
 /*
@@ -1050,92 +1065,67 @@ xfs_reclaim_inode_grab(
  *	clean		=> reclaim
  *	dirty, async	=> requeue
  *	dirty, sync	=> flush, wait and reclaim
+ *
+ * Returns true if the inode was reclaimed, false otherwise.
  */
-STATIC int
+STATIC bool
 xfs_reclaim_inode(
 	struct xfs_inode	*ip,
 	struct xfs_perag	*pag,
-	int			sync_mode)
+	xfs_lsn_t		*lsn)
 {
-	struct xfs_buf		*bp = NULL;
-	xfs_ino_t		ino = ip->i_ino; /* for radix_tree_delete */
-	int			error;
+	xfs_ino_t		ino;
+
+	*lsn = 0;
 
-restart:
-	error = 0;
 	/*
 	 * Don't try to flush the inode if another inode in this cluster has
 	 * already flushed it after we did the initial checks in
 	 * xfs_reclaim_inode_grab().
 	 */
-	if (sync_mode & SYNC_TRYLOCK) {
-		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
-			goto out;
-		if (!xfs_iflock_nowait(ip))
-			goto out_unlock;
-	} else {
-		xfs_ilock(ip, XFS_ILOCK_EXCL);
-		if (!xfs_iflock_nowait(ip)) {
-			if (!(sync_mode & SYNC_WAIT))
-				goto out_unlock;
-			xfs_iflock(ip);
-		}
-	}
+	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
+		goto out;
+	if (!xfs_iflock_nowait(ip))
+		goto out_unlock;
 
+	/* If we are in shutdown, we don't care about blocking. */
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
 		xfs_iunpin_wait(ip);
 		/* xfs_iflush_abort() drops the flush lock */
 		xfs_iflush_abort(ip, false);
 		goto reclaim;
 	}
-	if (xfs_ipincount(ip)) {
-		if (!(sync_mode & SYNC_WAIT))
-			goto out_ifunlock;
-		xfs_iunpin_wait(ip);
-	}
-	if (xfs_iflags_test(ip, XFS_ISTALE) || xfs_inode_clean(ip)) {
-		xfs_ifunlock(ip);
-		goto reclaim;
-	}
 
 	/*
-	 * Never flush out dirty data during non-blocking reclaim, as it would
-	 * just contend with AIL pushing trying to do the same job.
+	 * If it is pinned, we only want to flush this if there's nothing else
+	 * to be flushed as it requires a log force. Hence we essentially set
+	 * the LSN to flush the entire AIL which will end up triggering a log
+	 * force to unpin this inode, but that will only happen if there are not
+	 * other inodes in the scan that only need writeback.
 	 */
-	if (!(sync_mode & SYNC_WAIT))
+	if (xfs_ipincount(ip)) {
+		*lsn = ip->i_itemp->ili_last_lsn;
 		goto out_ifunlock;
+	}
 
 	/*
-	 * Now we have an inode that needs flushing.
-	 *
-	 * Note that xfs_iflush will never block on the inode buffer lock, as
-	 * xfs_ifree_cluster() can lock the inode buffer before it locks the
-	 * ip->i_lock, and we are doing the exact opposite here.  As a result,
-	 * doing a blocking xfs_imap_to_bp() to get the cluster buffer would
-	 * result in an ABBA deadlock with xfs_ifree_cluster().
-	 *
-	 * As xfs_ifree_cluser() must gather all inodes that are active in the
-	 * cache to mark them stale, if we hit this case we don't actually want
-	 * to do IO here - we want the inode marked stale so we can simply
-	 * reclaim it.  Hence if we get an EAGAIN error here,  just unlock the
-	 * inode, back off and try again.  Hopefully the next pass through will
-	 * see the stale flag set on the inode.
+	 * Dirty inode we didn't catch, skip it.
 	 */
-	error = xfs_iflush(ip, &bp);
-	if (error == -EAGAIN) {
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		/* backoff longer than in xfs_ifree_cluster */
-		delay(2);
-		goto restart;
+	if (!xfs_inode_clean(ip) && !xfs_iflags_test(ip, XFS_ISTALE)) {
+		*lsn = ip->i_itemp->ili_item.li_lsn;
+		goto out_ifunlock;
 	}
 
-	if (!error) {
-		error = xfs_bwrite(bp);
-		xfs_buf_relse(bp);
-	}
+	/*
+	 * It's clean, we have it locked, we can now drop the flush lock
+	 * and reclaim it.
+	 */
+	xfs_ifunlock(ip);
 
 reclaim:
 	ASSERT(!xfs_isiflocked(ip));
+	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE));
+	ASSERT(ip->i_ino != 0);
 
 	/*
 	 * Because we use RCU freeing we need to ensure the inode always appears
@@ -1148,6 +1138,7 @@ xfs_reclaim_inode(
 	 * will see an invalid inode that it can skip.
 	 */
 	spin_lock(&ip->i_flags_lock);
+	ino = ip->i_ino; /* for radix_tree_delete */
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
 	spin_unlock(&ip->i_flags_lock);
@@ -1182,7 +1173,7 @@ xfs_reclaim_inode(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
 	__xfs_inode_free(ip);
-	return error;
+	return true;
 
 out_ifunlock:
 	xfs_ifunlock(ip);
@@ -1190,14 +1181,7 @@ xfs_reclaim_inode(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 out:
 	xfs_iflags_clear(ip, XFS_IRECLAIM);
-	/*
-	 * We could return -EAGAIN here to make reclaim rescan the inode tree in
-	 * a short while. However, this just burns CPU time scanning the tree
-	 * waiting for IO to complete and the reclaim work never goes back to
-	 * the idle state. Instead, return 0 to let the next scheduled
-	 * background reclaim attempt to reclaim the inode again.
-	 */
-	return 0;
+	return false;
 }
 
 /*
@@ -1205,39 +1189,28 @@ xfs_reclaim_inode(
  * corrupted, we still want to try to reclaim all the inodes. If we don't,
  * then a shut down during filesystem unmount reclaim walk leak all the
  * unreclaimed inodes.
+ *
+ * Return the number of inodes freed.
  */
 STATIC int
 xfs_reclaim_inodes_ag(
 	struct xfs_mount	*mp,
 	int			flags,
-	int			*nr_to_scan)
+	int			nr_to_scan)
 {
 	struct xfs_perag	*pag;
-	int			error = 0;
-	int			last_error = 0;
 	xfs_agnumber_t		ag;
-	int			trylock = flags & SYNC_TRYLOCK;
-	int			skipped;
+	xfs_lsn_t		lsn, lowest_lsn = NULLCOMMITLSN;
+	long			freed = 0;
 
-restart:
 	ag = 0;
-	skipped = 0;
 	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
 		unsigned long	first_index = 0;
 		int		done = 0;
 		int		nr_found = 0;
 
 		ag = pag->pag_agno + 1;
-
-		if (trylock) {
-			if (!mutex_trylock(&pag->pag_ici_reclaim_lock)) {
-				skipped++;
-				xfs_perag_put(pag);
-				continue;
-			}
-			first_index = pag->pag_ici_reclaim_cursor;
-		} else
-			mutex_lock(&pag->pag_ici_reclaim_lock);
+		first_index = pag->pag_ici_reclaim_cursor;
 
 		do {
 			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
@@ -1262,9 +1235,13 @@ xfs_reclaim_inodes_ag(
 			for (i = 0; i < nr_found; i++) {
 				struct xfs_inode *ip = batch[i];
 
-				if (done || xfs_reclaim_inode_grab(ip, flags))
+				if (done ||
+				    !xfs_reclaim_inode_grab(ip, flags, &lsn))
 					batch[i] = NULL;
 
+				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
+					lowest_lsn = lsn;
+
 				/*
 				 * Update the index for the next lookup. Catch
 				 * overflows into the next AG range which can
@@ -1293,37 +1270,28 @@ xfs_reclaim_inodes_ag(
 			for (i = 0; i < nr_found; i++) {
 				if (!batch[i])
 					continue;
-				error = xfs_reclaim_inode(batch[i], pag, flags);
-				if (error && last_error != -EFSCORRUPTED)
-					last_error = error;
+				if (xfs_reclaim_inode(batch[i], pag, &lsn))
+					freed++;
+				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
+					lowest_lsn = lsn;
 			}
 
-			*nr_to_scan -= XFS_LOOKUP_BATCH;
-
+			nr_to_scan -= XFS_LOOKUP_BATCH;
 			cond_resched();
 
-		} while (nr_found && !done && *nr_to_scan > 0);
+		} while (nr_found && !done && nr_to_scan > 0);
 
-		if (trylock && !done)
+		if (!done)
 			pag->pag_ici_reclaim_cursor = first_index;
 		else
 			pag->pag_ici_reclaim_cursor = 0;
-		mutex_unlock(&pag->pag_ici_reclaim_lock);
 		xfs_perag_put(pag);
 	}
 
-	/*
-	 * if we skipped any AG, and we still have scan count remaining, do
-	 * another pass this time using blocking reclaim semantics (i.e
-	 * waiting on the reclaim locks and ignoring the reclaim cursors). This
-	 * ensure that when we get more reclaimers than AGs we block rather
-	 * than spin trying to execute reclaim.
-	 */
-	if (skipped && (flags & SYNC_WAIT) && *nr_to_scan > 0) {
-		trylock = 0;
-		goto restart;
-	}
-	return last_error;
+	if ((flags & SYNC_WAIT) && lowest_lsn != NULLCOMMITLSN)
+		xfs_ail_push_sync(mp->m_ail, lowest_lsn);
+
+	return freed;
 }
 
 int
@@ -1331,9 +1299,7 @@ xfs_reclaim_inodes(
 	xfs_mount_t	*mp,
 	int		mode)
 {
-	int		nr_to_scan = INT_MAX;
-
-	return xfs_reclaim_inodes_ag(mp, mode, &nr_to_scan);
+	return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
 }
 
 /*
@@ -1350,7 +1316,7 @@ xfs_reclaim_inodes_nr(
 	struct xfs_mount	*mp,
 	int			nr_to_scan)
 {
-	int			sync_mode = SYNC_TRYLOCK;
+	int			sync_mode = 0;
 
 	/*
 	 * For kswapd, we kick background inode writeback. For direct
@@ -1362,7 +1328,7 @@ xfs_reclaim_inodes_nr(
 	else
 		sync_mode |= SYNC_WAIT;
 
-	return xfs_reclaim_inodes_ag(mp, sync_mode, &nr_to_scan);
+	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
 }
 
 /*
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index a1805021c92f..bcf8f64d1b1f 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -148,7 +148,6 @@ xfs_free_perag(
 		ASSERT(atomic_read(&pag->pag_ref) == 0);
 		xfs_iunlink_destroy(pag);
 		xfs_buf_hash_destroy(pag);
-		mutex_destroy(&pag->pag_ici_reclaim_lock);
 		call_rcu(&pag->rcu_head, __xfs_free_perag);
 	}
 }
@@ -200,7 +199,6 @@ xfs_initialize_perag(
 		pag->pag_agno = index;
 		pag->pag_mount = mp;
 		spin_lock_init(&pag->pag_ici_lock);
-		mutex_init(&pag->pag_ici_reclaim_lock);
 		INIT_RADIX_TREE(&pag->pag_ici_root, GFP_ATOMIC);
 		if (xfs_buf_hash_init(pag))
 			goto out_free_pag;
@@ -242,7 +240,6 @@ xfs_initialize_perag(
 out_hash_destroy:
 	xfs_buf_hash_destroy(pag);
 out_free_pag:
-	mutex_destroy(&pag->pag_ici_reclaim_lock);
 	kmem_free(pag);
 out_unwind_new_pags:
 	/* unwind any prior newly initialized pags */
@@ -252,7 +249,6 @@ xfs_initialize_perag(
 			break;
 		xfs_buf_hash_destroy(pag);
 		xfs_iunlink_destroy(pag);
-		mutex_destroy(&pag->pag_ici_reclaim_lock);
 		kmem_free(pag);
 	}
 	return error;
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index f0cc952ad527..2049e764faed 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -383,7 +383,6 @@ typedef struct xfs_perag {
 	spinlock_t	pag_ici_lock;	/* incore inode cache lock */
 	struct radix_tree_root pag_ici_root;	/* incore inode cache root */
 	int		pag_ici_reclaimable;	/* reclaimable inodes */
-	struct mutex	pag_ici_reclaim_lock;	/* serialisation point */
 	unsigned long	pag_ici_reclaim_cursor;	/* reclaim restart point */
 
 	/* buffer cache index */
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 00d66175f41a..5802139f786b 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -676,8 +676,10 @@ xfs_ail_push_sync(
 	spin_lock(&ailp->ail_lock);
 	while ((lip = xfs_ail_min(ailp)) != NULL) {
 		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
+	trace_printk("lip lsn 0x%llx thres 0x%llx targ 0x%llx",
+			lip->li_lsn, threshold_lsn, ailp->ail_target);
 		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
-		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
+		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) < 0)
 			break;
 		/* XXX: cmpxchg? */
 		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
-- 
2.22.0

