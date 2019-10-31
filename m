Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F51EBAEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 00:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfJaXre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 19:47:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56153 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728648AbfJaXqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:46:32 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 547253A01A1;
        Fri,  1 Nov 2019 10:46:25 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-0007Ci-RT; Fri, 01 Nov 2019 10:46:19 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQK8x-00042N-Oz; Fri, 01 Nov 2019 10:46:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/28] xfs: remove unusued old inode reclaim code
Date:   Fri,  1 Nov 2019 10:46:15 +1100
Message-Id: <20191031234618.15403-26-david@fromorbit.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191031234618.15403-1-david@fromorbit.com>
References: <20191031234618.15403-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=20KFwNOVAAAA:8
        a=Mk_DjsQrHyw8X3MnIygA:9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that the custom AG radix tree walker has been replaced and
removed, we don't need the radix tree tags anymore, nor the reclaim
cursors or the locks taht protect it. Remove all remaining traces of
these things.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_icache.c | 82 +--------------------------------------------
 fs/xfs/xfs_icache.h |  7 ++--
 fs/xfs/xfs_mount.c  |  4 ---
 fs/xfs/xfs_mount.h  |  3 --
 fs/xfs/xfs_super.c  |  5 +--
 5 files changed, 6 insertions(+), 95 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 05dd292bfdb6..71a729e29260 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -139,83 +139,6 @@ xfs_inode_free(
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
-	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
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
@@ -397,18 +320,16 @@ xfs_iget_cache_hit(
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
 		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
-		xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
 		inode->i_state = I_NEW;
 		ip->i_sick = 0;
 		ip->i_checked = 0;
@@ -417,7 +338,6 @@ xfs_iget_cache_hit(
 		init_rwsem(&inode->i_rwsem);
 
 		spin_unlock(&ip->i_flags_lock);
-		spin_unlock(&pag->pag_ici_lock);
 	} else {
 		/* If the VFS inode is being torn down, pause and try again. */
 		if (!igrab(inode)) {
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 86e858e4a281..ec646b9e88b7 100644
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
@@ -68,8 +67,6 @@ enum lru_status xfs_inode_reclaim_isolate(struct list_head *item,
 void xfs_dispose_inodes(struct list_head *freeable);
 void xfs_reclaim_all_inodes(struct xfs_mount *mp);
 
-void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
-
 void xfs_inode_set_eofblocks_tag(struct xfs_inode *ip);
 void xfs_inode_clear_eofblocks_tag(struct xfs_inode *ip);
 int xfs_icache_free_eofblocks(struct xfs_mount *, struct xfs_eofblocks *);
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 5f3fd1d8f63f..9d60a4e033a0 100644
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
index 4f153ee17e18..dea05cd867bf 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -343,9 +343,6 @@ typedef struct xfs_perag {
 
 	spinlock_t	pag_ici_lock;	/* incore inode cache lock */
 	struct radix_tree_root pag_ici_root;	/* incore inode cache root */
-	int		pag_ici_reclaimable;	/* reclaimable inodes */
-	struct mutex	pag_ici_reclaim_lock;	/* serialisation point */
-	unsigned long	pag_ici_reclaim_cursor;	/* reclaim restart point */
 
 	/* buffer cache index */
 	spinlock_t	pag_buf_lock;	/* lock for pag_buf_hash */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 096ae31b5436..d2200fbce139 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -916,7 +916,6 @@ xfs_fs_destroy_inode(
 	spin_lock(&ip->i_flags_lock);
 	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIMABLE));
 	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIM));
-	spin_unlock(&ip->i_flags_lock);
 
 	/*
 	 * We always use background reclaim here because even if the
@@ -925,7 +924,9 @@ xfs_fs_destroy_inode(
 	 * this more efficiently than we can here, so simply let background
 	 * reclaim tear down all inodes.
 	 */
-	xfs_inode_set_reclaim_tag(ip);
+	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
+	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
+	spin_unlock(&ip->i_flags_lock);
 }
 
 static void
-- 
2.24.0.rc0

