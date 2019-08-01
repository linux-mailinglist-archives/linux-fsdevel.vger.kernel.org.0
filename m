Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6877D337
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfHACSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35724 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729435AbfHACSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:15 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A1981361273;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bT-IZ; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lf-GM; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/24] xfs: reclaim inodes from the LRU
Date:   Thu,  1 Aug 2019 12:17:51 +1000
Message-Id: <20190801021752.4986-24-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=nKCprb0aSrhUHDyOBuUA:9 a=a_hQLlXCV-XpzTWr:21 a=8NxpYfFRAdJzUREW:21
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

Keep in mind we don't have to care about inode lock order or
blocking with inode locks held here because a) we are using
trylocks, and b) once marked with XFS_IRECLAIM they can't be found
via the LRU and inode cache lookups will abort and retry. Hence
nobody will try to lock them in any other context that might also be
holding other inode locks.

Also convert xfs_reclaim_inodes() to use a LRU walk to free all
the reclaimable inodes in the filesystem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 199 ++++++++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_icache.h |  10 ++-
 fs/xfs/xfs_inode.h  |   8 ++
 fs/xfs/xfs_super.c  |  50 +++++++++--
 4 files changed, 232 insertions(+), 35 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 610f643df9f6..891fe3795c8f 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1195,7 +1195,7 @@ xfs_reclaim_inode(
  *
  * Return the number of inodes freed.
  */
-STATIC int
+int
 xfs_reclaim_inodes_ag(
 	struct xfs_mount	*mp,
 	int			flags,
@@ -1297,40 +1297,185 @@ xfs_reclaim_inodes_ag(
 	return freed;
 }
 
-void
-xfs_reclaim_inodes(
-	struct xfs_mount	*mp)
+enum lru_status
+xfs_inode_reclaim_isolate(
+	struct list_head	*item,
+	struct list_lru_one	*lru,
+	spinlock_t		*lru_lock,
+	void			*arg)
 {
-	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
+        struct xfs_ireclaim_args *ra = arg;
+        struct inode		*inode = container_of(item, struct inode, i_lru);
+        struct xfs_inode	*ip = XFS_I(inode);
+	enum lru_status		ret;
+	xfs_lsn_t		lsn = 0;
+
+	/* Careful: inversion of iflags_lock and everything else here */
+	if (!spin_trylock(&ip->i_flags_lock))
+		return LRU_SKIP;
+
+	ret = LRU_ROTATE;
+	if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_unlock_flags;
+	}
+
+	ret = LRU_SKIP;
+	if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
+		goto out_unlock_flags;
+
+	if (!__xfs_iflock_nowait(ip)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_unlock_inode;
+	}
+
+	/* if we are in shutdown, we'll reclaim it even if dirty */
+	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
+		goto reclaim;
+
+	/*
+	 * Now the inode is locked, we can actually determine if it is dirty
+	 * without racing with anything.
+	 */
+	ret = LRU_ROTATE;
+	if (xfs_ipincount(ip)) {
+		ra->dirty_skipped++;
+		goto out_ifunlock;
+	}
+	if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE)) {
+		lsn = ip->i_itemp->ili_item.li_lsn;
+		ra->dirty_skipped++;
+		goto out_ifunlock;
+	}
+
+reclaim:
+	/*
+	 * Once we mark the inode with XFS_IRECLAIM, no-one will grab it again.
+	 * RCU lookups will still find the inode, but they'll stop when they set
+	 * the IRECLAIM flag. Hence we can leave the inode locked as we move it
+	 * to the dispose list so we can deal with shutdown cleanup there
+	 * outside the LRU lock context.
+	 */
+	__xfs_iflags_set(ip, XFS_IRECLAIM);
+	list_lru_isolate_move(lru, &inode->i_lru, &ra->freeable);
+	spin_unlock(&ip->i_flags_lock);
+	return LRU_REMOVED;
+
+out_ifunlock:
+	xfs_ifunlock(ip);
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
+static void
+xfs_dispose_inode(
+	struct xfs_inode	*ip)
 {
-	int			sync_mode = 0;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_perag	*pag;
+	xfs_ino_t		ino;
+
+	ASSERT(xfs_isiflocked(ip));
+	ASSERT(xfs_inode_clean(ip) || xfs_iflags_test(ip, XFS_ISTALE));
+	ASSERT(ip->i_ino != 0);
 
 	/*
-	 * For kswapd, we kick background inode writeback. For direct
-	 * reclaim, we issue and wait on inode writeback to throttle
-	 * reclaim rates and avoid shouty OOM-death.
+	 * Process the shutdown reclaim work we deferred from the LRU isolation
+	 * callback before we go any further.
 	 */
-	if (current_is_kswapd())
-		xfs_ail_push_all(mp->m_ail);
-	else
-		sync_mode |= SYNC_WAIT;
+	if (XFS_FORCED_SHUTDOWN(mp)) {
+		xfs_iunpin_wait(ip);
+		xfs_iflush_abort(ip, false);
+	} else {
+		xfs_ifunlock(ip);
+	}
 
-	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
+	/*
+	 * Because we use RCU freeing we need to ensure the inode always appears
+	 * to be reclaimed with an invalid inode number when in the free state.
+	 * We do this as early as possible under the ILOCK so that
+	 * xfs_iflush_cluster() and xfs_ifree_cluster() can be guaranteed to
+	 * detect races with us here. By doing this, we guarantee that once
+	 * xfs_iflush_cluster() or xfs_ifree_cluster() has locked XFS_ILOCK that
+	 * it will see either a valid inode that will serialise correctly, or it
+	 * will see an invalid inode that it can skip.
+	 */
+	spin_lock(&ip->i_flags_lock);
+	ino = ip->i_ino; /* for radix_tree_delete */
+	ip->i_flags = XFS_IRECLAIM;
+	ip->i_ino = 0;
+	spin_unlock(&ip->i_flags_lock);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	XFS_STATS_INC(mp, xs_ig_reclaims);
+	/*
+	 * Remove the inode from the per-AG radix tree.
+	 *
+	 * Because radix_tree_delete won't complain even if the item was never
+	 * added to the tree assert that it's been there before to catch
+	 * problems with the inode life time early on.
+	 */
+	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ino));
+	spin_lock(&pag->pag_ici_lock);
+	if (!radix_tree_delete(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ino)))
+		ASSERT(0);
+	spin_unlock(&pag->pag_ici_lock);
+	xfs_perag_put(pag);
+
+	/*
+	 * Here we do an (almost) spurious inode lock in order to coordinate
+	 * with inode cache radix tree lookups.  This is because the lookup
+	 * can reference the inodes in the cache without taking references.
+	 *
+	 * We make that OK here by ensuring that we wait until the inode is
+	 * unlocked after the lookup before we go ahead and free it.
+	 *
+	 * XXX: need to check this is still true. Not sure it is.
+	 */
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_qm_dqdetach(ip);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	__xfs_inode_free(ip);
+}
+
+void
+xfs_dispose_inodes(
+	struct list_head	*freeable)
+{
+	while (!list_empty(freeable)) {
+		struct inode *inode;
+
+		inode = list_first_entry(freeable, struct inode, i_lru);
+		list_del_init(&inode->i_lru);
+
+		xfs_dispose_inode(XFS_I(inode));
+		cond_resched();
+	}
+}
+void
+xfs_reclaim_inodes(
+	struct xfs_mount	*mp)
+{
+	while (list_lru_count(&mp->m_inode_lru)) {
+		struct xfs_ireclaim_args ra;
+
+		INIT_LIST_HEAD(&ra.freeable);
+		ra.lowest_lsn = NULLCOMMITLSN;
+		list_lru_walk(&mp->m_inode_lru, xfs_inode_reclaim_isolate,
+				&ra, LONG_MAX);
+		xfs_dispose_inodes(&ra.freeable);
+		if (ra.lowest_lsn != NULLCOMMITLSN)
+			xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
+	}
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 0ab08b58cd45..dadc69a30f33 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -49,8 +49,16 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
 struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
+struct xfs_ireclaim_args {
+	struct list_head	freeable;
+	xfs_lsn_t		lowest_lsn;
+	unsigned long		dirty_skipped;
+};
+
+enum lru_status xfs_inode_reclaim_isolate(struct list_head *item,
+		struct list_lru_one *lru, spinlock_t *lru_lock, void *arg);
+void xfs_dispose_inodes(struct list_head *freeable);
 void xfs_reclaim_inodes(struct xfs_mount *mp);
-long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
 void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 558173f95a03..463170dc4c02 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -263,6 +263,14 @@ static inline int xfs_isiflocked(struct xfs_inode *ip)
 
 extern void __xfs_iflock(struct xfs_inode *ip);
 
+static inline int __xfs_iflock_nowait(struct xfs_inode *ip)
+{
+	if (ip->i_flags & XFS_IFLOCK)
+		return false;
+	ip->i_flags |= XFS_IFLOCK;
+	return true;
+}
+
 static inline int xfs_iflock_nowait(struct xfs_inode *ip)
 {
 	return !xfs_iflags_test_and_set(ip, XFS_IFLOCK);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b5c4c1b6fd19..e3e898a2896c 100644
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
@@ -1810,23 +1811,58 @@ xfs_fs_mount(
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
+        struct xfs_ireclaim_args ra;
+	long freed;
 
-	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
+	INIT_LIST_HEAD(&ra.freeable);
+	ra.lowest_lsn = NULLCOMMITLSN;
+	ra.dirty_skipped = 0;
+
+	freed = list_lru_shrink_walk(&mp->m_inode_lru, sc,
+					xfs_inode_reclaim_isolate, &ra);
+	xfs_dispose_inodes(&ra.freeable);
+
+	/*
+	 * Deal with dirty inodes if we skipped any. We will have the LSN of
+	 * the oldest dirty inode in our reclaim args if we skipped any.
+	 *
+	 * For direct reclaim, wait on an AIL push to clean some inodes.
+	 *
+	 * For kswapd, if we skipped too many dirty inodes (i.e. more dirty than
+	 * we freed) then we need kswapd to back off once it's scan has been
+	 * completed. That way it will have some clean inodes once it comes back
+	 * and can make progress, but make sure we have inode cleaning in
+	 * progress....
+	 */
+	if (current_is_kswapd()) {
+		if (ra.dirty_skipped >= freed) {
+			if (current->reclaim_state)
+				current->reclaim_state->need_backoff = true;
+			if (ra.lowest_lsn != NULLCOMMITLSN)
+				xfs_ail_push(mp->m_ail, ra.lowest_lsn);
+		}
+	} else if (ra.lowest_lsn != NULLCOMMITLSN) {
+		xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
+	}
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
2.22.0

