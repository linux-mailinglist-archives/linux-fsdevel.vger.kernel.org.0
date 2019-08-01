Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B57D336
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfHACSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:23 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:32913 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbfHACSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:18 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A1EE143EBD3;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bW-KC; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001li-ID; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/24] xfs: remove unusued old inode reclaim code
Date:   Thu,  1 Aug 2019 12:17:52 +1000
Message-Id: <20190801021752.4986-25-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=NLq-Pxan09OTZ9pW5F8A:9 a=MM6_kbBQj0QFA03F:21 a=Qvj9VV6_zPZ6olsH:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

We don't use the custom AG radix tree walker, the reclaim radix tree
tag, the reclaimable inode counters, etc, so remove the all now.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 410 +-------------------------------------------
 fs/xfs/xfs_icache.h |   7 +-
 fs/xfs/xfs_mount.h  |   2 -
 fs/xfs/xfs_super.c  |   1 -
 4 files changed, 3 insertions(+), 417 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 891fe3795c8f..ad04de119ac1 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -139,81 +139,6 @@ xfs_inode_free(
 	__xfs_inode_free(ip);
 }
 
-static void
-xfs_perag_set_reclaim_tag(
-	struct xfs_perag	*pag)
-{
-	struct xfs_mount	*mp = pag->pag_mount;
-
-	lockdep_assert_held(&pag->pag_ici_lock);
-	if (pag->pag_ici_reclaimable++)
-		return;
-
-	/* propagate the reclaim tag up into the perag radix tree */
-	spin_lock(&mp->m_perag_lock);
-	radix_tree_tag_set(&mp->m_perag_tree, pag->pag_agno,
-			   XFS_ICI_RECLAIM_TAG);
-	spin_unlock(&mp->m_perag_lock);
-
-	trace_xfs_perag_set_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
-}
-
-static void
-xfs_perag_clear_reclaim_tag(
-	struct xfs_perag	*pag)
-{
-	struct xfs_mount	*mp = pag->pag_mount;
-
-	lockdep_assert_held(&pag->pag_ici_lock);
-	if (--pag->pag_ici_reclaimable)
-		return;
-
-	/* clear the reclaim tag from the perag radix tree */
-	spin_lock(&mp->m_perag_lock);
-	radix_tree_tag_clear(&mp->m_perag_tree, pag->pag_agno,
-			     XFS_ICI_RECLAIM_TAG);
-	spin_unlock(&mp->m_perag_lock);
-	trace_xfs_perag_clear_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
-}
-
-
-/*
- * We set the inode flag atomically with the radix tree tag.
- * Once we get tag lookups on the radix tree, this inode flag
- * can go away.
- */
-void
-xfs_inode_set_reclaim_tag(
-	struct xfs_inode	*ip)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_perag	*pag;
-
-	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
-	spin_lock(&pag->pag_ici_lock);
-	spin_lock(&ip->i_flags_lock);
-
-	radix_tree_tag_set(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ip->i_ino),
-			   XFS_ICI_RECLAIM_TAG);
-	xfs_perag_set_reclaim_tag(pag);
-	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
-
-	spin_unlock(&ip->i_flags_lock);
-	spin_unlock(&pag->pag_ici_lock);
-	xfs_perag_put(pag);
-}
-
-STATIC void
-xfs_inode_clear_reclaim_tag(
-	struct xfs_perag	*pag,
-	xfs_ino_t		ino)
-{
-	radix_tree_tag_clear(&pag->pag_ici_root,
-			     XFS_INO_TO_AGINO(pag->pag_mount, ino),
-			     XFS_ICI_RECLAIM_TAG);
-	xfs_perag_clear_reclaim_tag(pag);
-}
-
 static void
 xfs_inew_wait(
 	struct xfs_inode	*ip)
@@ -397,17 +322,15 @@ xfs_iget_cache_hit(
 			goto out_error;
 		}
 
-		spin_lock(&pag->pag_ici_lock);
-		spin_lock(&ip->i_flags_lock);
 
 		/*
 		 * Clear the per-lifetime state in the inode as we are now
 		 * effectively a new inode and need to return to the initial
 		 * state before reuse occurs.
 		 */
+		spin_lock(&ip->i_flags_lock);
 		ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
 		ip->i_flags |= XFS_INEW;
-		xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
 		inode->i_state = I_NEW;
 		ip->i_sick = 0;
 		ip->i_checked = 0;
@@ -416,7 +339,6 @@ xfs_iget_cache_hit(
 		init_rwsem(&inode->i_rwsem);
 
 		spin_unlock(&ip->i_flags_lock);
-		spin_unlock(&pag->pag_ici_lock);
 	} else {
 		/* If the VFS inode is being torn down, pause and try again. */
 		if (!igrab(inode)) {
@@ -967,336 +889,6 @@ xfs_inode_ag_iterator_tag(
 	return last_error;
 }
 
-/*
- * Grab the inode for reclaim.
- *
- * Return false if we aren't going to reclaim it, true if it is a reclaim
- * candidate.
- *
- * If the inode is clean or unreclaimable, return NULLCOMMITLSN to tell the
- * caller it does not require flushing. Otherwise return the log item lsn of the
- * inode so the caller can determine it's inode flush target.  If we get the
- * clean/dirty state wrong then it will be sorted in xfs_reclaim_inode() once we
- * have locks held.
- */
-STATIC bool
-xfs_reclaim_inode_grab(
-	struct xfs_inode	*ip,
-	int			flags,
-	xfs_lsn_t		*lsn)
-{
-	ASSERT(rcu_read_lock_held());
-	*lsn = 0;
-
-	/* quick check for stale RCU freed inode */
-	if (!ip->i_ino)
-		return false;
-
-	/*
-	 * Do unlocked checks to see if the inode already is being flushed or in
-	 * reclaim to avoid lock traffic. If the inode is not clean, return the
-	 * it's position in the AIL for the caller to push to.
-	 */
-	if (!xfs_inode_clean(ip)) {
-		*lsn = ip->i_itemp->ili_item.li_lsn;
-		return false;
-	}
-
-	if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
-		return false;
-
-	/*
-	 * The radix tree lock here protects a thread in xfs_iget from racing
-	 * with us starting reclaim on the inode.  Once we have the
-	 * XFS_IRECLAIM flag set it will not touch us.
-	 *
-	 * Due to RCU lookup, we may find inodes that have been freed and only
-	 * have XFS_IRECLAIM set.  Indeed, we may see reallocated inodes that
-	 * aren't candidates for reclaim at all, so we must check the
-	 * XFS_IRECLAIMABLE is set first before proceeding to reclaim.
-	 */
-	spin_lock(&ip->i_flags_lock);
-	if (!__xfs_iflags_test(ip, XFS_IRECLAIMABLE) ||
-	    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
-		/* not a reclaim candidate. */
-		spin_unlock(&ip->i_flags_lock);
-		return false;
-	}
-	__xfs_iflags_set(ip, XFS_IRECLAIM);
-	spin_unlock(&ip->i_flags_lock);
-	return true;
-}
-
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
-{
-	xfs_ino_t		ino;
-
-	*lsn = 0;
-
-	/*
-	 * Don't try to flush the inode if another inode in this cluster has
-	 * already flushed it after we did the initial checks in
-	 * xfs_reclaim_inode_grab().
-	 */
-	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
-		goto out;
-	if (!xfs_iflock_nowait(ip))
-		goto out_unlock;
-
-	/* If we are in shutdown, we don't care about blocking. */
-	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
-		xfs_iunpin_wait(ip);
-		/* xfs_iflush_abort() drops the flush lock */
-		xfs_iflush_abort(ip, false);
-		goto reclaim;
-	}
-
-	/*
-	 * If it is pinned, we only want to flush this if there's nothing else
-	 * to be flushed as it requires a log force. Hence we essentially set
-	 * the LSN to flush the entire AIL which will end up triggering a log
-	 * force to unpin this inode, but that will only happen if there are not
-	 * other inodes in the scan that only need writeback.
-	 */
-	if (xfs_ipincount(ip)) {
-		*lsn = ip->i_itemp->ili_last_lsn;
-		goto out_ifunlock;
-	}
-
-	/*
-	 * Dirty inode we didn't catch, skip it.
-	 */
-	if (!xfs_inode_clean(ip) && !xfs_iflags_test(ip, XFS_ISTALE)) {
-		*lsn = ip->i_itemp->ili_item.li_lsn;
-		goto out_ifunlock;
-	}
-
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
-	/*
-	 * Because we use RCU freeing we need to ensure the inode always appears
-	 * to be reclaimed with an invalid inode number when in the free state.
-	 * We do this as early as possible under the ILOCK so that
-	 * xfs_iflush_cluster() and xfs_ifree_cluster() can be guaranteed to
-	 * detect races with us here. By doing this, we guarantee that once
-	 * xfs_iflush_cluster() or xfs_ifree_cluster() has locked XFS_ILOCK that
-	 * it will see either a valid inode that will serialise correctly, or it
-	 * will see an invalid inode that it can skip.
-	 */
-	spin_lock(&ip->i_flags_lock);
-	ino = ip->i_ino; /* for radix_tree_delete */
-	ip->i_flags = XFS_IRECLAIM;
-	ip->i_ino = 0;
-
-	/* XXX: temporary until lru based reclaim */
-	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
-	spin_unlock(&ip->i_flags_lock);
-
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-
-	XFS_STATS_INC(ip->i_mount, xs_ig_reclaims);
-	/*
-	 * Remove the inode from the per-AG radix tree.
-	 *
-	 * Because radix_tree_delete won't complain even if the item was never
-	 * added to the tree assert that it's been there before to catch
-	 * problems with the inode life time early on.
-	 */
-	spin_lock(&pag->pag_ici_lock);
-	if (!radix_tree_delete(&pag->pag_ici_root,
-				XFS_INO_TO_AGINO(ip->i_mount, ino)))
-		ASSERT(0);
-	xfs_perag_clear_reclaim_tag(pag);
-	spin_unlock(&pag->pag_ici_lock);
-
-	/*
-	 * Here we do an (almost) spurious inode lock in order to coordinate
-	 * with inode cache radix tree lookups.  This is because the lookup
-	 * can reference the inodes in the cache without taking references.
-	 *
-	 * We make that OK here by ensuring that we wait until the inode is
-	 * unlocked after the lookup before we go ahead and free it.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_qm_dqdetach(ip);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-
-	__xfs_inode_free(ip);
-	return true;
-
-out_ifunlock:
-	xfs_ifunlock(ip);
-out_unlock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-out:
-	xfs_iflags_clear(ip, XFS_IRECLAIM);
-	return false;
-}
-
-/*
- * Walk the AGs and reclaim the inodes in them. Even if the filesystem is
- * corrupted, we still want to try to reclaim all the inodes. If we don't,
- * then a shut down during filesystem unmount reclaim walk leak all the
- * unreclaimed inodes.
- *
- * Return the number of inodes freed.
- */
-int
-xfs_reclaim_inodes_ag(
-	struct xfs_mount	*mp,
-	int			flags,
-	int			nr_to_scan)
-{
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
-		first_index = pag->pag_ici_reclaim_cursor;
-
-		do {
-			struct xfs_inode *batch[XFS_LOOKUP_BATCH];
-			int	i;
-
-			rcu_read_lock();
-			nr_found = radix_tree_gang_lookup_tag(
-					&pag->pag_ici_root,
-					(void **)batch, first_index,
-					XFS_LOOKUP_BATCH,
-					XFS_ICI_RECLAIM_TAG);
-			if (!nr_found) {
-				done = 1;
-				rcu_read_unlock();
-				break;
-			}
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
-
-			for (i = 0; i < nr_found; i++) {
-				if (!batch[i])
-					continue;
-				if (xfs_reclaim_inode(batch[i], pag, &lsn))
-					freed++;
-				if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
-					lowest_lsn = lsn;
-			}
-
-			nr_to_scan -= XFS_LOOKUP_BATCH;
-			cond_resched();
-
-		} while (nr_found && !done && nr_to_scan > 0);
-
-		if (!done)
-			pag->pag_ici_reclaim_cursor = first_index;
-		else
-			pag->pag_ici_reclaim_cursor = 0;
-		xfs_perag_put(pag);
-	}
-
-	if ((flags & SYNC_WAIT) && lowest_lsn != NULLCOMMITLSN)
-		xfs_ail_push_sync(mp->m_ail, lowest_lsn);
-
-	return freed;
-}
-
 enum lru_status
 xfs_inode_reclaim_isolate(
 	struct list_head	*item,
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index dadc69a30f33..0b4d06691275 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -25,9 +25,8 @@ struct xfs_eofblocks {
  */
 #define XFS_ICI_NO_TAG		(-1)	/* special flag for an untagged lookup
 					   in xfs_inode_ag_iterator */
-#define XFS_ICI_RECLAIM_TAG	0	/* inode is to be reclaimed */
-#define XFS_ICI_EOFBLOCKS_TAG	1	/* inode has blocks beyond EOF */
-#define XFS_ICI_COWBLOCKS_TAG	2	/* inode can have cow blocks to gc */
+#define XFS_ICI_EOFBLOCKS_TAG	0	/* inode has blocks beyond EOF */
+#define XFS_ICI_COWBLOCKS_TAG	1	/* inode can have cow blocks to gc */
 
 /*
  * Flags for xfs_iget()
@@ -60,8 +59,6 @@ enum lru_status xfs_inode_reclaim_isolate(struct list_head *item,
 void xfs_dispose_inodes(struct list_head *freeable);
 void xfs_reclaim_inodes(struct xfs_mount *mp);
 
-void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
-
 void xfs_inode_set_eofblocks_tag(struct xfs_inode *ip);
 void xfs_inode_clear_eofblocks_tag(struct xfs_inode *ip);
 int xfs_icache_free_eofblocks(struct xfs_mount *, struct xfs_eofblocks *);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 4a4ecbc22246..ef63357da7af 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -383,8 +383,6 @@ typedef struct xfs_perag {
 
 	spinlock_t	pag_ici_lock;	/* incore inode cache lock */
 	struct radix_tree_root pag_ici_root;	/* incore inode cache root */
-	int		pag_ici_reclaimable;	/* reclaimable inodes */
-	unsigned long	pag_ici_reclaim_cursor;	/* reclaim restart point */
 
 	/* buffer cache index */
 	spinlock_t	pag_buf_lock;	/* lock for pag_buf_hash */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e3e898a2896c..0559fb686e9d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -955,7 +955,6 @@ xfs_fs_destroy_inode(
 	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
 	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
 	spin_unlock(&ip->i_flags_lock);
-	xfs_inode_set_reclaim_tag(ip);
 }
 
 static void
-- 
2.22.0

