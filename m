Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58B7D343
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfHACSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 22:18:30 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:32911 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729471AbfHACSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:18:15 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A1AED43EA1D;
        Thu,  1 Aug 2019 12:17:58 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0eB-0003bQ-Gu; Thu, 01 Aug 2019 12:16:51 +1000
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1ht0fH-0001lc-FK; Thu, 01 Aug 2019 12:17:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/24] xfs: track reclaimable inodes using a LRU list
Date:   Thu,  1 Aug 2019 12:17:50 +1000
Message-Id: <20190801021752.4986-23-david@fromorbit.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801021752.4986-1-david@fromorbit.com>
References: <20190801021752.4986-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=FmdZ9Uzk2mMA:10 a=20KFwNOVAAAA:8
        a=iBnADfy8PgdZzd-sFjsA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that we don't do IO from the inode reclaim code, there is no
need to optimise inode scanning order for optimal IO
characteristics. The AIL takes care of that for us, so now reclaim
can focus on selecting the best inodes to reclaim.

Hence we can change the inode reclaim algorithm to a real LRU and
remove the need to use the radix tree to track and walk inodes under
reclaim. This frees up a radix tree bit and simplifies the code that
marks inodes are reclaim candidates. It also simplifies the reclaim
code - we don't need batching anymore and all the reclaim logic
can be added to the LRU isolation callback.

Further, we get node aware reclaim at the xfs_inode level, which
should help the per-node reclaim code free relevant inodes faster.

We can re-use the VFS inode lru pointers - once the inode has been
reclaimed from the VFS, we can use these pointers ourselves. Hence
we don't need to grow the inode to change the way we index
reclaimable inodes.

Start by adding the list_lru tracking in parallel with the existing
reclaim code. This makes it easier to see the LRU infrastructure
separate to the reclaim algorithm changes. Especially the locking
order, which is ip->i_flags_lock -> list_lru lock.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 31 +++++++------------------------
 fs/xfs/xfs_icache.h |  1 -
 fs/xfs/xfs_mount.h  |  1 +
 fs/xfs/xfs_super.c  | 31 ++++++++++++++++++++++++-------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index aaa1f840a86c..610f643df9f6 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -370,12 +370,11 @@ xfs_iget_cache_hit(
 
 		/*
 		 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
-		 * from stomping over us while we recycle the inode.  We can't
-		 * clear the radix tree reclaimable tag yet as it requires
-		 * pag_ici_lock to be held exclusive.
+		 * from stomping over us while we recycle the inode. Remove it
+		 * from the LRU straight away so we can re-init the VFS inode.
 		 */
 		ip->i_flags |= XFS_IRECLAIM;
-
+		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
 		spin_unlock(&ip->i_flags_lock);
 		rcu_read_unlock();
 
@@ -390,6 +389,7 @@ xfs_iget_cache_hit(
 			spin_lock(&ip->i_flags_lock);
 			wake = !!__xfs_iflags_test(ip, XFS_INEW);
 			ip->i_flags &= ~(XFS_INEW | XFS_IRECLAIM);
+			list_lru_add(&mp->m_inode_lru, &inode->i_lru);
 			if (wake)
 				wake_up_bit(&ip->i_flags, __XFS_INEW_BIT);
 			ASSERT(ip->i_flags & XFS_IRECLAIMABLE);
@@ -1141,6 +1141,9 @@ xfs_reclaim_inode(
 	ino = ip->i_ino; /* for radix_tree_delete */
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
+
+	/* XXX: temporary until lru based reclaim */
+	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
 	spin_unlock(&ip->i_flags_lock);
 
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1330,26 +1333,6 @@ xfs_reclaim_inodes_nr(
 	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
 }
 
-/*
- * Return the number of reclaimable inodes in the filesystem for
- * the shrinker to determine how much to reclaim.
- */
-int
-xfs_reclaim_inodes_count(
-	struct xfs_mount	*mp)
-{
-	struct xfs_perag	*pag;
-	xfs_agnumber_t		ag = 0;
-	int			reclaimable = 0;
-
-	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
-		ag = pag->pag_agno + 1;
-		reclaimable += pag->pag_ici_reclaimable;
-		xfs_perag_put(pag);
-	}
-	return reclaimable;
-}
-
 STATIC int
 xfs_inode_match_id(
 	struct xfs_inode	*ip,
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 1c9b9edb2986..0ab08b58cd45 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -50,7 +50,6 @@ struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
 void xfs_reclaim_inodes(struct xfs_mount *mp);
-int xfs_reclaim_inodes_count(struct xfs_mount *mp);
 long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
 void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 2049e764faed..4a4ecbc22246 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -75,6 +75,7 @@ typedef struct xfs_mount {
 	uint8_t			m_rt_sick;
 
 	struct xfs_ail		*m_ail;		/* fs active log item list */
+	struct list_lru		m_inode_lru;
 
 	struct xfs_sb		m_sb;		/* copy of fs superblock */
 	spinlock_t		m_sb_lock;	/* sb counter lock */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a59d3a21be5c..b5c4c1b6fd19 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -919,28 +919,30 @@ xfs_fs_destroy_inode(
 	struct inode		*inode)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
 
 	trace_xfs_destroy_inode(ip);
 
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
-	XFS_STATS_INC(ip->i_mount, vn_rele);
-	XFS_STATS_INC(ip->i_mount, vn_remove);
+	XFS_STATS_INC(mp, vn_rele);
+	XFS_STATS_INC(mp, vn_remove);
 
 	xfs_inactive(ip);
 
-	if (!XFS_FORCED_SHUTDOWN(ip->i_mount) && ip->i_delayed_blks) {
+	if (!XFS_FORCED_SHUTDOWN(mp) && ip->i_delayed_blks) {
 		xfs_check_delalloc(ip, XFS_DATA_FORK);
 		xfs_check_delalloc(ip, XFS_COW_FORK);
 		ASSERT(0);
 	}
 
-	XFS_STATS_INC(ip->i_mount, vn_reclaim);
+	XFS_STATS_INC(mp, vn_reclaim);
 
 	/*
 	 * We should never get here with one of the reclaim flags already set.
 	 */
-	ASSERT_ALWAYS(!xfs_iflags_test(ip, XFS_IRECLAIMABLE));
-	ASSERT_ALWAYS(!xfs_iflags_test(ip, XFS_IRECLAIM));
+	spin_lock(&ip->i_flags_lock);
+	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIMABLE));
+	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIM));
 
 	/*
 	 * We always use background reclaim here because even if the
@@ -949,6 +951,9 @@ xfs_fs_destroy_inode(
 	 * this more efficiently than we can here, so simply let background
 	 * reclaim tear down all inodes.
 	 */
+	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
+	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
+	spin_unlock(&ip->i_flags_lock);
 	xfs_inode_set_reclaim_tag(ip);
 }
 
@@ -1541,6 +1546,15 @@ xfs_mount_alloc(
 	if (!mp)
 		return NULL;
 
+	/*
+	 * The inode lru needs to be associated with the superblock shrinker,
+	 * and like the rest of the superblock shrinker, it's memcg aware.
+	 */
+	if (list_lru_init_memcg(&mp->m_inode_lru, &sb->s_shrink)) {
+		kfree(mp);
+		return NULL;
+	}
+
 	mp->m_super = sb;
 	spin_lock_init(&mp->m_sb_lock);
 	spin_lock_init(&mp->m_agirotor_lock);
@@ -1748,6 +1762,7 @@ xfs_fs_fill_super(
  out_free_fsname:
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
+	list_lru_destroy(&mp->m_inode_lru);
 	kfree(mp);
  out:
 	return error;
@@ -1780,6 +1795,7 @@ xfs_fs_put_super(
 
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
+	list_lru_destroy(&mp->m_inode_lru);
 	kfree(mp);
 }
 
@@ -1801,7 +1817,8 @@ xfs_fs_nr_cached_objects(
 	/* Paranoia: catch incorrect calls during mount setup or teardown */
 	if (WARN_ON_ONCE(!sb->s_fs_info))
 		return 0;
-	return xfs_reclaim_inodes_count(XFS_M(sb));
+
+	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
 }
 
 static long
-- 
2.22.0

