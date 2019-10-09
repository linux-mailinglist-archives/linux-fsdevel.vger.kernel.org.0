Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D28D0603
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfJIDVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47369 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730557AbfJIDVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:41 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7158143E6C9;
        Wed,  9 Oct 2019 14:21:28 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-0006C4-Eo; Wed, 09 Oct 2019 14:21:27 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XX-00039x-Cz; Wed, 09 Oct 2019 14:21:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/26] xfs: track reclaimable inodes using a LRU list
Date:   Wed,  9 Oct 2019 14:21:20 +1100
Message-Id: <20191009032124.10541-23-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=xxV3NzHXsLv75N6J5P4A:9
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
 fs/xfs/xfs_icache.c | 32 ++++++++------------------------
 fs/xfs/xfs_icache.h |  1 -
 fs/xfs/xfs_mount.h  |  1 +
 fs/xfs/xfs_super.c  | 29 ++++++++++++++++++++++-------
 4 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 39c56200f1ce..06fdaa746674 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -198,6 +198,8 @@ xfs_inode_set_reclaim_tag(
 	xfs_perag_set_reclaim_tag(pag);
 	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
 
+	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
+
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 	xfs_perag_put(pag);
@@ -370,12 +372,10 @@ xfs_iget_cache_hit(
 
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
 		spin_unlock(&ip->i_flags_lock);
 		rcu_read_unlock();
 
@@ -407,6 +407,7 @@ xfs_iget_cache_hit(
 		 */
 		ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
 		ip->i_flags |= XFS_INEW;
+		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
 		xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
 		inode->i_state = I_NEW;
 		ip->i_sick = 0;
@@ -1138,6 +1139,9 @@ xfs_reclaim_inode(
 	ino = ip->i_ino; /* for radix_tree_delete */
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
+
+	/* XXX: temporary until lru based reclaim */
+	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
 	spin_unlock(&ip->i_flags_lock);
 
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1329,26 +1333,6 @@ xfs_reclaim_inodes_nr(
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
index f0cc952ad527..f1e4c2eae984 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -75,6 +75,7 @@ typedef struct xfs_mount {
 	uint8_t			m_rt_sick;
 
 	struct xfs_ail		*m_ail;		/* fs active log item list */
+	struct list_lru		m_inode_lru;
 
 	struct xfs_sb		m_sb;		/* copy of fs superblock */
 	spinlock_t		m_sb_lock;	/* sb counter lock */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d0619bf02a5d..01f08706a3fb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -920,28 +920,31 @@ xfs_fs_destroy_inode(
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
+	spin_unlock(&ip->i_flags_lock);
 
 	/*
 	 * We always use background reclaim here because even if the
@@ -1542,6 +1545,15 @@ xfs_mount_alloc(
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
@@ -1751,6 +1763,7 @@ xfs_fs_fill_super(
  out_free_fsname:
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
+	list_lru_destroy(&mp->m_inode_lru);
 	kfree(mp);
  out:
 	return error;
@@ -1783,6 +1796,7 @@ xfs_fs_put_super(
 
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
+	list_lru_destroy(&mp->m_inode_lru);
 	kfree(mp);
 }
 
@@ -1804,7 +1818,8 @@ xfs_fs_nr_cached_objects(
 	/* Paranoia: catch incorrect calls during mount setup or teardown */
 	if (WARN_ON_ONCE(!sb->s_fs_info))
 		return 0;
-	return xfs_reclaim_inodes_count(XFS_M(sb));
+
+	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
 }
 
 static long
-- 
2.23.0.rc1

