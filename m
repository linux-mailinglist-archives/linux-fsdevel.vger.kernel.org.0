Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F39EBAD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfJaXqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:46:49 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56547 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbfJaXqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:35 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D03C03A23B1;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Cg-Ps; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042K-Nv; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/28] xfs: reclaim inodes from the LRU
Date:   Fri,  1 Nov 2019 10:46:14 +1100
Message-Id: <20191031234618.15403-25-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=CWdGKF79LG_jA4S27w8A:9 a=3olIEYc3oiszChvJ:21 a=oXdPoYE73i3MdTZ7:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Replace the AG radix tree walking reclaim code with a list_lru
walker, giving us both node-aware and memcg-aware inode reclaim
at the XFS level. This requires adding an inode isolation function to
determine if the inode can be reclaim, and a list walker to
dispose of the inodes that were isolated.

We want the isolation function to be non-blocking. If we can't
grab an inode then we either skip it or rotate it. If it's clean
then we skip it, if it's dirty then we rotate to give it time to be
cleaned before it is scanned again.

This congregates the dirty inodes at the tail of the LRU, which
means that if we start hitting a majority of dirty inodes either
there are lots of unlinked inodes in the reclaim list or we've
reclaimed all the clean inodes and we're looped back on the dirty
inodes. Either way, this is an indication we should tell kswapd to
back off.

The non-blocking isolation function introduces a complexity for the
filesystem shutdown case. When the filesystem is shut down, we want
to free the inode even if it is dirty, and this may require
blocking. We already hold the locks needed to do this blocking, so
what we do is that we leave inodes locked - both the ILOCK and the
flush lock - while they are sitting on the dispose list to be freed
after the LRU walk completes.  This allows us to process the
shutdown state outside the LRU walk where we can block safely.

Because we now are reclaiming inodes from the context that it needs
memory in (memcg and/or node), direct reclaim throttling within the
high level reclaim code in now much more effective. Hence we don't
wait on IO for either kswapd or direct reclaim. However, we have to
tell kswapd to back off if we start hitting too many dirty inodes.
This implies we've wrapped around the LRU and don't have many clean
inodes left to reclaim, so it needs to wait a while for the AIL
pushing to clean some of the remaining reclaimable inodes.

Keep in mind we don't have to care about inode lock order or
blocking with inode locks held here because a) we are using
trylocks, and b) once marked with XFS_IRECLAIM they can't be found
via the LRU and inode cache lookups will abort and retry. Hence
nobody will try to lock them in any other context that might also be
holding other inode locks.

Also convert xfs_reclaim_all_inodes() to use a LRU walk to free all
the reclaimable inodes in the filesystem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 404 +++++++++++++-------------------------------
 fs/xfs/xfs_icache.h |  18 +-
 fs/xfs/xfs_inode.h  |  18 ++
 fs/xfs/xfs_super.c  |  46 ++++-
 4 files changed, 190 insertions(+), 296 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 350f42e7730b..05dd292bfdb6 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -968,160 +968,110 @@ xfs_inode_ag_iterator_tag(
 	return last_error;
 }
 
-/*
- * Grab the inode for reclaim.
- *
- * Return false if we aren't going to reclaim it, true if it is a reclaim
- * candidate.
- *
- * If the inode is clean or unreclaimable, return 0 to tell the caller it does
- * not require flushing. Otherwise return the log item lsn of the inode so the
- * caller can determine it's inode flush target.  If we get the clean/dirty
- * state wrong then it will be sorted in xfs_reclaim_inode() once we have locks
- * held.
- */
-STATIC bool
-xfs_reclaim_inode_grab(
-	struct xfs_inode	*ip,
-	int			flags,
-	xfs_lsn_t		*lsn)
+enum lru_status
+xfs_inode_reclaim_isolate(
+	struct list_head	*item,
+	struct list_lru_one	*lru,
+	spinlock_t		*lru_lock,
+	void			*arg)
 {
-	ASSERT(rcu_read_lock_held());
-	*lsn = 0;
+        struct xfs_ireclaim_args *ra = arg;
+        struct inode		*inode = container_of(item, struct inode,
+						      i_lru);
+        struct xfs_inode	*ip = XFS_I(inode);
+	enum lru_status		ret;
+	xfs_lsn_t		lsn = 0;
+
+	/* Careful: inversion of iflags_lock and everything else here */
+	if (!spin_trylock(&ip->i_flags_lock))
+		return LRU_SKIP;
+
+	/* if we are in shutdown, we'll reclaim it even if dirty */
+	ret = LRU_ROTATE;
+	if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE) &&
+	    !XFS_FORCED_SHUTDOWN(ip->i_mount)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_unlock_flags;
+	}
 
-	/* quick check for stale RCU freed inode */
-	if (!ip->i_ino)
-		return false;
+	ret = LRU_SKIP;
+	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
+		goto out_unlock_flags;
 
-	/*
-	 * Do unlocked checks to see if the inode already is being flushed or in
-	 * reclaim to avoid lock traffic. If the inode is not clean, return the
-	 * position in the AIL for the caller to push to.
-	 */
-	if (!xfs_inode_clean(ip)) {
-		*lsn = ip->i_itemp->ili_item.li_lsn;
-		return false;
+	if (!__xfs_iflock_nowait(ip)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_unlock_inode;
 	}
 
-	if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
-		return false;
+	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
+		goto reclaim;
 
 	/*
-	 * The radix tree lock here protects a thread in xfs_iget from racing
-	 * with us starting reclaim on the inode.  Once we have the
-	 * XFS_IRECLAIM flag set it will not touch us.
-	 *
-	 * Due to RCU lookup, we may find inodes that have been freed and only
-	 * have XFS_IRECLAIM set.  Indeed, we may see reallocated inodes that
-	 * aren't candidates for reclaim at all, so we must check the
-	 * XFS_IRECLAIMABLE is set first before proceeding to reclaim.
+	 * Now the inode is locked, we can actually determine if it is dirty
+	 * without racing with anything.
 	 */
-	spin_lock(&ip->i_flags_lock);
-	if (!__xfs_iflags_test(ip, XFS_IRECLAIMABLE) ||
-	    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
-		/* not a reclaim candidate. */
-		spin_unlock(&ip->i_flags_lock);
-		return false;
+	ret = LRU_ROTATE;
+	if (xfs_ipincount(ip)) {
+		ra->dirty_skipped++;
+		goto out_ifunlock;
+	}
+	if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_ifunlock;
 	}
+
+reclaim:
+	/*
+	 * Once we mark the inode with XFS_IRECLAIM, no-one will grab it again.
+	 * RCU lookups will still find the inode, but they'll stop when they set
+	 * the IRECLAIM flag. Hence we can leave the inode locked as we move it
+	 * to the dispose list so we can deal with shutdown cleanup there
+	 * outside the LRU lock context.
+	 */
 	__xfs_iflags_set(ip, XFS_IRECLAIM);
+	list_lru_isolate_move(lru, &inode->i_lru, &ra->freeable);
 	spin_unlock(&ip->i_flags_lock);
-	return true;
+	return LRU_REMOVED;
+
+out_ifunlock:
+	__xfs_ifunlock(ip);
+out_unlock_inode:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+out_unlock_flags:
+	spin_unlock(&ip->i_flags_lock);
+
+	if (lsn && XFS_LSN_CMP(lsn, ra->lowest_lsn) < 0)
+		ra->lowest_lsn = lsn;
+	return ret;
 }
 
-/*
- * Inodes in different states need to be treated differently. The following
- * table lists the inode states and the reclaim actions necessary:
- *
- *	inode state	     iflush ret		required action
- *      ---------------      ----------         ---------------
- *	bad			-		reclaim
- *	shutdown		EIO		unpin and reclaim
- *	clean, unpinned		0		reclaim
- *	stale, unpinned		0		reclaim
- *	clean, pinned(*)	0		requeue
- *	stale, pinned		EAGAIN		requeue
- *	dirty, async		-		requeue
- *	dirty, sync		0		reclaim
- *
- * (*) dgc: I don't think the clean, pinned state is possible but it gets
- * handled anyway given the order of checks implemented.
- *
- * Also, because we get the flush lock first, we know that any inode that has
- * been flushed delwri has had the flush completed by the time we check that
- * the inode is clean.
- *
- * Note that because the inode is flushed delayed write by AIL pushing, the
- * flush lock may already be held here and waiting on it can result in very
- * long latencies.  Hence for sync reclaims, where we wait on the flush lock,
- * the caller should push the AIL first before trying to reclaim inodes to
- * minimise the amount of time spent waiting.  For background relaim, we only
- * bother to reclaim clean inodes anyway.
- *
- * Hence the order of actions after gaining the locks should be:
- *	bad		=> reclaim
- *	shutdown	=> unpin and reclaim
- *	pinned, async	=> requeue
- *	pinned, sync	=> unpin
- *	stale		=> reclaim
- *	clean		=> reclaim
- *	dirty, async	=> requeue
- *	dirty, sync	=> flush, wait and reclaim
- *
- * Returns true if the inode was reclaimed, false otherwise.
- */
-STATIC bool
-xfs_reclaim_inode(
-	struct xfs_inode	*ip,
-	struct xfs_perag	*pag,
-	xfs_lsn_t		*lsn)
+static void
+xfs_dispose_inode(
+	struct xfs_inode	*ip)
 {
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_perag	*pag;
 	xfs_ino_t		ino;
 
-	*lsn = 0;
+	ASSERT(xfs_isiflocked(ip));
+	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE) ||
+	       XFS_FORCED_SHUTDOWN(mp));
+	ASSERT(ip->i_ino != 0);
 
 	/*
-	 * Don't try to flush the inode if another inode in this cluster has
-	 * already flushed it after we did the initial checks in
-	 * xfs_reclaim_inode_grab().
+	 * Process the shutdown reclaim work we deferred from the LRU isolation
+	 * callback before we go any further.
 	 */
-	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
-		goto out;
-	if (!xfs_iflock_nowait(ip))
-		goto out_unlock;
-
-	/* If we are in shutdown, we don't care about blocking. */
-	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
+	if (XFS_FORCED_SHUTDOWN(mp)) {
 		xfs_iunpin_wait(ip);
-		/* xfs_iflush_abort() drops the flush lock */
 		xfs_iflush_abort(ip, false);
-		goto reclaim;
-	}
-
-	/* Can't do anything to pinned inodes without blocking, skip it. */
-	if (xfs_ipincount(ip)) {
-		*lsn = ip->i_itemp->ili_item.li_lsn;
-		goto out_ifunlock;
-	}
-
-	/*
-	 * Dirty inode we didn't catch, skip it.
-	 */
-	if (!xfs_inode_clean(ip) && !xfs_iflags_test(ip, XFS_ISTALE)) {
-		*lsn = ip->i_itemp->ili_item.li_lsn;
-		goto out_ifunlock;
+	} else {
+		xfs_ifunlock(ip);
 	}
 
-	/*
-	 * It's clean, we have it locked, we can now drop the flush lock
-	 * and reclaim it.
-	 */
-	xfs_ifunlock(ip);
-
-reclaim:
-	ASSERT(!xfs_isiflocked(ip));
-	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE));
-	ASSERT(ip->i_ino != 0);
-
 	/*
 	 * Because we use RCU freeing we need to ensure the inode always appears
 	 * to be reclaimed with an invalid inode number when in the free state.
@@ -1136,27 +1086,20 @@ xfs_reclaim_inode(
 	ino = ip->i_ino; /* for radix_tree_delete */
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
-
-	/* XXX: temporary until lru based reclaim */
-	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
 	spin_unlock(&ip->i_flags_lock);
-
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
-	XFS_STATS_INC(ip->i_mount, xs_ig_reclaims);
+	XFS_STATS_INC(mp, xs_ig_reclaims);
+
 	/*
 	 * Remove the inode from the per-AG radix tree.
-	 *
-	 * Because radix_tree_delete won't complain even if the item was never
-	 * added to the tree assert that it's been there before to catch
-	 * problems with the inode life time early on.
 	 */
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ino));
 	spin_lock(&pag->pag_ici_lock);
-	if (!radix_tree_delete(&pag->pag_ici_root,
-				XFS_INO_TO_AGINO(ip->i_mount, ino)))
+	if (!radix_tree_delete(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ino)))
 		ASSERT(0);
-	xfs_perag_clear_reclaim_tag(pag);
 	spin_unlock(&pag->pag_ici_lock);
+	xfs_perag_put(pag);
 
 	/*
 	 * Here we do an (almost) spurious inode lock in order to coordinate
@@ -1165,167 +1108,52 @@ xfs_reclaim_inode(
 	 *
 	 * We make that OK here by ensuring that we wait until the inode is
 	 * unlocked after the lookup before we go ahead and free it.
+	 *
+	 * XXX: need to check this is still true. Not sure it is.
 	 */
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_qm_dqdetach(ip);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
 	__xfs_inode_free(ip);
-	return true;
-
-out_ifunlock:
-	xfs_ifunlock(ip);
-out_unlock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-out:
-	xfs_iflags_clear(ip, XFS_IRECLAIM);
-	return false;
 }
 
-/*
- * Walk the AGs and reclaim the inodes in them. Even if the filesystem is
- * corrupted, we still want to try to reclaim all the inodes. If we don't,
- * then a shut down during filesystem unmount reclaim walk leak all the
- * unreclaimed inodes.
- *
- * Return the number of inodes freed.
- */
-STATIC int
-xfs_reclaim_inodes_ag(
-	struct xfs_mount	*mp,
-	int			flags,
-	int			nr_to_scan)
+void
+xfs_dispose_inodes(
+	struct list_head	*freeable)
 {
-	struct xfs_perag	*pag;
-	xfs_agnumber_t		ag;
-	xfs_lsn_t		lsn, lowest_lsn = NULLCOMMITLSN;
-	long			freed = 0;
-
-	ag = 0;
-	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
-		unsigned long	first_index = 0;
-		int		done = 0;
-		int		nr_found = 0;
-
-		ag = pag->pag_agno + 1;
-		do {
-			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
-			int	i;
-
-			mutex_lock(&pag->pag_ici_reclaim_lock);
-			first_index = pag->pag_ici_reclaim_cursor;
+	struct inode		*inode;
 
-			rcu_read_lock();
-			nr_found = radix_tree_gang_lookup_tag(
-					&pag->pag_ici_root,
-					(void **)batch, first_index,
-					XFS_LOOKUP_BATCH,
-					XFS_ICI_RECLAIM_TAG);
-			if (!nr_found)
-				done = 1;
-
-			/*
-			 * Grab the inodes before we drop the lock. if we found
-			 * nothing, nr == 0 and the loop will be skipped.
-			 */
-			for (i = 0; i < nr_found; i++) {
-				struct xfs_inode *ip = batch[i];
-
-				if (done ||
-				    !xfs_reclaim_inode_grab(ip, flags, &lsn))
-					batch[i] = NULL;
-
-				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
-					lowest_lsn = lsn;
-
-				/*
-				 * Update the index for the next lookup. Catch
-				 * overflows into the next AG range which can
-				 * occur if we have inodes in the last block of
-				 * the AG and we are currently pointing to the
-				 * last inode.
-				 *
-				 * Because we may see inodes that are from the
-				 * wrong AG due to RCU freeing and
-				 * reallocation, only update the index if it
-				 * lies in this AG. It was a race that lead us
-				 * to see this inode, so another lookup from
-				 * the same index will not find it again.
-				 */
-				if (XFS_INO_TO_AGNO(mp, ip->i_ino) !=
-								pag->pag_agno)
-					continue;
-				first_index = XFS_INO_TO_AGINO(mp, ip->i_ino + 1);
-				if (first_index < XFS_INO_TO_AGINO(mp, ip->i_ino))
-					done = 1;
-			}
-
-			/* unlock now we've grabbed the inodes. */
-			rcu_read_unlock();
-			if (!done)
-				pag->pag_ici_reclaim_cursor = first_index;
-			else
-				pag->pag_ici_reclaim_cursor = 0;
-			mutex_unlock(&pag->pag_ici_reclaim_lock);
-
-			for (i = 0; i < nr_found; i++) {
-				if (!batch[i])
-					continue;
-				if (xfs_reclaim_inode(batch[i], pag, &lsn))
-					freed++;
-				if (lsn && (lowest_lsn == NULLCOMMITLSN ||
-				            XFS_LSN_CMP(lsn, lowest_lsn) < 0))
-					lowest_lsn = lsn;
-			}
-
-			nr_to_scan -= XFS_LOOKUP_BATCH;
-			cond_resched();
-
-		} while (nr_found && !done && nr_to_scan > 0);
-
-		xfs_perag_put(pag);
+	while ((inode = list_first_entry_or_null(freeable,
+						 struct inode, i_lru))) {
+		list_del_init(&inode->i_lru);
+		xfs_dispose_inode(XFS_I(inode));
+		cond_resched();
 	}
-
-	if ((flags & SYNC_WAIT) && lowest_lsn != NULLCOMMITLSN)
-		xfs_ail_push_sync(mp->m_ail, lowest_lsn);
-
-	return freed;
 }
-
 void
 xfs_reclaim_all_inodes(
 	struct xfs_mount	*mp)
 {
-	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
-}
-
-/*
- * Scan a certain number of inodes for reclaim.
- *
- * When called we make sure that there is a background (fast) inode reclaim in
- * progress, while we will throttle the speed of reclaim via doing synchronous
- * reclaim of inodes. That means if we come across dirty inodes, we wait for
- * them to be cleaned, which we hope will not be very long due to the
- * background walker having already kicked the IO off on those dirty inodes.
- */
-long
-xfs_reclaim_inodes_nr(
-	struct xfs_mount	*mp,
-	int			nr_to_scan)
-{
-	int			sync_mode = 0;
-
-	/*
-	 * For kswapd, we kick background inode writeback. For direct
-	 * reclaim, we issue and wait on inode writeback to throttle
-	 * reclaim rates and avoid shouty OOM-death.
-	 */
-	if (current_is_kswapd())
-		xfs_ail_push_all(mp->m_ail);
-	else
-		sync_mode |= SYNC_WAIT;
-
-	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
+	while (list_lru_count(&mp->m_inode_lru)) {
+		struct xfs_ireclaim_args ra;
+		long freed, to_free;
+
+		xfs_ireclaim_args_init(&ra);
+
+		to_free = list_lru_count(&mp->m_inode_lru);
+		freed = list_lru_walk(&mp->m_inode_lru,
+				      xfs_inode_reclaim_isolate, &ra, to_free);
+		xfs_dispose_inodes(&ra.freeable);
+
+		if (freed == 0) {
+			xfs_log_force(mp, XFS_LOG_SYNC);
+			xfs_ail_push_all(mp->m_ail);
+		} else if (ra.lowest_lsn != NULLCOMMITLSN) {
+			xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
+		}
+		cond_resched();
+	}
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index afd692b06c13..86e858e4a281 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -49,8 +49,24 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
 struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
+struct xfs_ireclaim_args {
+	struct list_head	freeable;
+	xfs_lsn_t		lowest_lsn;
+	unsigned long		dirty_skipped;
+};
+
+static inline void
+xfs_ireclaim_args_init(struct xfs_ireclaim_args *ra)
+{
+	INIT_LIST_HEAD(&ra->freeable);
+	ra->lowest_lsn = NULLCOMMITLSN;
+	ra->dirty_skipped = 0;
+}
+
+enum lru_status xfs_inode_reclaim_isolate(struct list_head *item,
+		struct list_lru_one *lru, spinlock_t *lru_lock, void *arg);
+void xfs_dispose_inodes(struct list_head *freeable);
 void xfs_reclaim_all_inodes(struct xfs_mount *mp);
-long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
 void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bcfb35a9c5ca..00145debf820 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -270,6 +270,15 @@ static inline int xfs_isiflocked(struct xfs_inode *ip)
 
 extern void __xfs_iflock(struct xfs_inode *ip);
 
+static inline int __xfs_iflock_nowait(struct xfs_inode *ip)
+{
+	lockdep_assert_held(&ip->i_flags_lock);
+	if (ip->i_flags & XFS_IFLOCK)
+		return false;
+	ip->i_flags |= XFS_IFLOCK;
+	return true;
+}
+
 static inline int xfs_iflock_nowait(struct xfs_inode *ip)
 {
 	return !xfs_iflags_test_and_set(ip, XFS_IFLOCK);
@@ -281,6 +290,15 @@ static inline void xfs_iflock(struct xfs_inode *ip)
 		__xfs_iflock(ip);
 }
 
+static inline void __xfs_ifunlock(struct xfs_inode *ip)
+{
+	lockdep_assert_held(&ip->i_flags_lock);
+	ASSERT(ip->i_flags & XFS_IFLOCK);
+	ip->i_flags &= ~XFS_IFLOCK;
+	smp_mb();
+	wake_up_bit(&ip->i_flags, __XFS_IFLOCK_BIT);
+}
+
 static inline void xfs_ifunlock(struct xfs_inode *ip)
 {
 	ASSERT(xfs_isiflocked(ip));
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 98ffbe42f8ae..096ae31b5436 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -17,6 +17,7 @@
 #include "xfs_alloc.h"
 #include "xfs_fsops.h"
 #include "xfs_trans.h"
+#include "xfs_trans_priv.h"
 #include "xfs_buf_item.h"
 #include "xfs_log.h"
 #include "xfs_log_priv.h"
@@ -1772,23 +1773,54 @@ xfs_fs_mount(
 }
 
 static long
-xfs_fs_nr_cached_objects(
+xfs_fs_free_cached_objects(
 	struct super_block	*sb,
 	struct shrink_control	*sc)
 {
-	/* Paranoia: catch incorrect calls during mount setup or teardown */
-	if (WARN_ON_ONCE(!sb->s_fs_info))
-		return 0;
+	struct xfs_mount	*mp = XFS_M(sb);
+	struct xfs_ireclaim_args ra;
+	long			freed;
 
-	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
+	xfs_ireclaim_args_init(&ra);
+
+	freed = list_lru_shrink_walk(&mp->m_inode_lru, sc,
+					xfs_inode_reclaim_isolate, &ra);
+	xfs_dispose_inodes(&ra.freeable);
+
+	/*
+	 * Deal with dirty inodes. We will have the LSN of
+	 * the oldest dirty inode in our reclaim args if we skipped any.
+	 *
+	 * For kswapd, if we skipped too many dirty inodes (i.e. more dirty than
+	 * we freed) then we need kswapd to back off once it's scan has been
+	 * completed. That way it will have some clean inodes once it comes back
+	 * and can make progress, but make sure we have inode cleaning in
+	 * progress.
+	 *
+	 * Direct reclaim will be throttled by the caller as it winds the
+	 * priority up. All we need to do is keep pushing on dirty inodes
+	 * in the background so when we come back progress will be made.
+	 */
+	if (current_is_kswapd() && ra.dirty_skipped >= freed) {
+		if (current->reclaim_state)
+			current->reclaim_state->need_backoff = true;
+	}
+	if (ra.lowest_lsn != NULLCOMMITLSN)
+		xfs_ail_push(mp->m_ail, ra.lowest_lsn);
+
+	return freed;
 }
 
 static long
-xfs_fs_free_cached_objects(
+xfs_fs_nr_cached_objects(
 	struct super_block	*sb,
 	struct shrink_control	*sc)
 {
-	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
+	/* Paranoia: catch incorrect calls during mount setup or teardown */
+	if (WARN_ON_ONCE(!sb->s_fs_info))
+		return 0;
+
+	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
 }
 
 static const struct super_operations xfs_super_operations = {
-- 
2.24.0.rc0

