Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC0EBAF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfJaXrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:47:41 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55489 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728618AbfJaXqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0FFA3A28AD;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Ce-Ol; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042H-Mz; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/28] xfs: track reclaimable inodes using a LRU list
Date:   Fri,  1 Nov 2019 10:46:13 +1100
Message-Id: <20191031234618.15403-24-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=1_kZ1czCliemkzvEU9sA:9
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
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_icache.c | 32 ++++++++------------------------
 fs/xfs/xfs_icache.h |  1 -
 fs/xfs/xfs_mount.h  |  1 +
 fs/xfs/xfs_super.c  | 30 ++++++++++++++++++++++--------
 4 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 048f7f1b54ff..350f42e7730b 100644
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
@@ -1135,6 +1136,9 @@ xfs_reclaim_inode(
 	ino = ip->i_ino; /* for radix_tree_delete */
 	ip->i_flags = XFS_IRECLAIM;
 	ip->i_ino = 0;
+
+	/* XXX: temporary until lru based reclaim */
+	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
 	spin_unlock(&ip->i_flags_lock);
 
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1324,26 +1328,6 @@ xfs_reclaim_inodes_nr(
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
index 37cd33741bee..afd692b06c13 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -50,7 +50,6 @@ struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
 void xfs_inode_free(struct xfs_inode *ip);
 
 void xfs_reclaim_all_inodes(struct xfs_mount *mp);
-int xfs_reclaim_inodes_count(struct xfs_mount *mp);
 long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
 
 void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 8c6885d3b085..4f153ee17e18 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -75,6 +75,7 @@ typedef struct xfs_mount {
 	uint8_t			m_rt_sick;
 
 	struct xfs_ail		*m_ail;		/* fs active log item list */
+	struct list_lru		m_inode_lru;
 
 	struct xfs_sb		m_sb;		/* copy of fs superblock */
 	spinlock_t		m_sb_lock;	/* sb counter lock */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 456a398aad82..98ffbe42f8ae 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -891,28 +891,31 @@ xfs_fs_destroy_inode(
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
@@ -1544,9 +1547,16 @@ xfs_fs_fill_super(
 		goto out;
 	sb->s_fs_info = mp;
 
+	/*
+	 * The inode lru needs to be associated with the superblock shrinker,
+	 * and like the rest of the superblock shrinker, it's memcg aware.
+	 */
+	if (list_lru_init_memcg(&mp->m_inode_lru, &sb->s_shrink))
+		goto out_free_fsname;
+
 	error = xfs_parseargs(mp, (char *)data);
 	if (error)
-		goto out_free_fsname;
+		goto out_free_lru;
 
 	sb_min_blocksize(sb, BBSIZE);
 	sb->s_xattr = xfs_xattr_handlers;
@@ -1710,6 +1720,8 @@ xfs_fs_fill_super(
 	xfs_destroy_mount_workqueues(mp);
  out_close_devices:
 	xfs_close_devices(mp);
+ out_free_lru:
+	list_lru_destroy(&mp->m_inode_lru);
  out_free_fsname:
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
@@ -1743,6 +1755,7 @@ xfs_fs_put_super(
 	xfs_destroy_mount_workqueues(mp);
 	xfs_close_devices(mp);
 
+	list_lru_destroy(&mp->m_inode_lru);
 	sb->s_fs_info = NULL;
 	xfs_free_fsname(mp);
 	kfree(mp);
@@ -1766,7 +1779,8 @@ xfs_fs_nr_cached_objects(
 	/* Paranoia: catch incorrect calls during mount setup or teardown */
 	if (WARN_ON_ONCE(!sb->s_fs_info))
 		return 0;
-	return xfs_reclaim_inodes_count(XFS_M(sb));
+
+	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
 }
 
 static long
-- 
2.24.0.rc0

