Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89211711BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjEZBFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjEZBFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39BB195;
        Thu, 25 May 2023 18:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA1C649F2;
        Fri, 26 May 2023 01:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED8DC4339B;
        Fri, 26 May 2023 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063106;
        bh=1qHFcDcHQhjxqOKRBgvJc8bu4CdrCzwaU7lBiNuE1qk=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=o0+o4sK4ElGInASeQg77I1945HPhARBDmQWrfsUA8kF95d1alAV+QLh+A5Mh8+Obo
         +Tmnu8ruuAbvk5GnWCW6sQub/gWOz9YQRiq0IwtFPLJo3iWqWbDlgx4aDE24UDScop
         v2a9tgAduxoz2ftscOlkqxhd8Wtogw0ynjqODZe41vxh/9SnEgSsWWHj5tr3zS54X+
         EktNtpNkQ5rfda/HaQQcoy4hjf0Evp9nGrNPOaPu8sLRTDyV1wHoRvj/8LuxpaPqqY
         eALKJ9r+i2ZI5JtKhhTUdi0yqRAmy/8Bf3gcd84vzUx6pg5BeYaDvT96r29KAbFBeL
         /XO+j1xZ6XE2A==
Date:   Thu, 25 May 2023 18:05:06 -0700
Subject: [PATCH 2/9] xfs: teach buftargs to maintain their own buffer
 hashtable
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061880.3733082.7782494430395906650.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Currently, cached buffers are indexed by per-AG hashtables.  This works
great for the data device, but won't work for in-memory btrees.  Make it
so that buftargs can index buffers too.

We accomplish this by hoisting the rhashtable and its lock into a
separate xfs_buf_cache structure and reworking various functions to use
it.  Next, we introduce to the buftarg a new XFS_BUFTARG_SELF_CACHED
flag to indicate that the buftarg's cache is active (vs. the per-ag
cache for the regular filesystem).

Finally, make it so that each xfs_buf points to its cache if there is
one.  This is how we distinguish uncached buffers from now on.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c |    6 +-
 fs/xfs/libxfs/xfs_ag.h |    4 -
 fs/xfs/xfs_buf.c       |  140 +++++++++++++++++++++++++++++++++---------------
 fs/xfs/xfs_buf.h       |   10 +++
 fs/xfs/xfs_mount.h     |    3 -
 5 files changed, 110 insertions(+), 53 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index b36ec110ad17..d274ec8bd237 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -264,7 +264,7 @@ xfs_free_perag(
 		xfs_defer_drain_free(&pag->pag_intents_drain);
 
 		cancel_delayed_work_sync(&pag->pag_blockgc_work);
-		xfs_buf_hash_destroy(pag);
+		xfs_buf_cache_destroy(&pag->pag_bcache);
 
 		/* drop the mount's active reference */
 		xfs_perag_rele(pag);
@@ -394,7 +394,7 @@ xfs_initialize_perag(
 		pag->pagb_tree = RB_ROOT;
 #endif /* __KERNEL__ */
 
-		error = xfs_buf_hash_init(pag);
+		error = xfs_buf_cache_init(&pag->pag_bcache);
 		if (error)
 			goto out_remove_pag;
 
@@ -434,7 +434,7 @@ xfs_initialize_perag(
 		pag = radix_tree_delete(&mp->m_perag_tree, index);
 		if (!pag)
 			break;
-		xfs_buf_hash_destroy(pag);
+		xfs_buf_cache_destroy(&pag->pag_bcache);
 		xfs_defer_drain_free(&pag->pag_intents_drain);
 		kmem_free(pag);
 	}
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 616812911a23..a682ddd8fc4c 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -104,9 +104,7 @@ struct xfs_perag {
 	int		pag_ici_reclaimable;	/* reclaimable inodes */
 	unsigned long	pag_ici_reclaim_cursor;	/* reclaim restart point */
 
-	/* buffer cache index */
-	spinlock_t	pag_buf_lock;	/* lock for pag_buf_hash */
-	struct rhashtable pag_buf_hash;
+	struct xfs_buf_cache	pag_bcache;
 
 	/* background prealloc block trimming */
 	struct delayed_work	pag_blockgc_work;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 2a1a641c2b87..dd16dfb669d8 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -499,18 +499,18 @@ static const struct rhashtable_params xfs_buf_hash_params = {
 };
 
 int
-xfs_buf_hash_init(
-	struct xfs_perag	*pag)
+xfs_buf_cache_init(
+	struct xfs_buf_cache	*bch)
 {
-	spin_lock_init(&pag->pag_buf_lock);
-	return rhashtable_init(&pag->pag_buf_hash, &xfs_buf_hash_params);
+	spin_lock_init(&bch->bc_lock);
+	return rhashtable_init(&bch->bc_hash, &xfs_buf_hash_params);
 }
 
 void
-xfs_buf_hash_destroy(
-	struct xfs_perag	*pag)
+xfs_buf_cache_destroy(
+	struct xfs_buf_cache	*bch)
 {
-	rhashtable_destroy(&pag->pag_buf_hash);
+	rhashtable_destroy(&bch->bc_hash);
 }
 
 static int
@@ -569,7 +569,7 @@ xfs_buf_find_lock(
 
 static inline int
 xfs_buf_lookup(
-	struct xfs_perag	*pag,
+	struct xfs_buf_cache	*bch,
 	struct xfs_buf_map	*map,
 	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
@@ -578,7 +578,7 @@ xfs_buf_lookup(
 	int			error;
 
 	rcu_read_lock();
-	bp = rhashtable_lookup(&pag->pag_buf_hash, map, xfs_buf_hash_params);
+	bp = rhashtable_lookup(&bch->bc_hash, map, xfs_buf_hash_params);
 	if (!bp || !atomic_inc_not_zero(&bp->b_hold)) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -603,6 +603,7 @@ xfs_buf_lookup(
 static int
 xfs_buf_find_insert(
 	struct xfs_buftarg	*btp,
+	struct xfs_buf_cache	*bch,
 	struct xfs_perag	*pag,
 	struct xfs_buf_map	*cmap,
 	struct xfs_buf_map	*map,
@@ -631,18 +632,18 @@ xfs_buf_find_insert(
 			goto out_free_buf;
 	}
 
-	spin_lock(&pag->pag_buf_lock);
-	bp = rhashtable_lookup_get_insert_fast(&pag->pag_buf_hash,
+	spin_lock(&bch->bc_lock);
+	bp = rhashtable_lookup_get_insert_fast(&bch->bc_hash,
 			&new_bp->b_rhash_head, xfs_buf_hash_params);
 	if (IS_ERR(bp)) {
 		error = PTR_ERR(bp);
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(&bch->bc_lock);
 		goto out_free_buf;
 	}
 	if (bp) {
 		/* found an existing buffer */
 		atomic_inc(&bp->b_hold);
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(&bch->bc_lock);
 		error = xfs_buf_find_lock(bp, flags);
 		if (error)
 			xfs_buf_rele(bp);
@@ -653,17 +654,38 @@ xfs_buf_find_insert(
 
 	/* The new buffer keeps the perag reference until it is freed. */
 	new_bp->b_pag = pag;
-	spin_unlock(&pag->pag_buf_lock);
+	new_bp->b_cache = bch;
+	spin_unlock(&bch->bc_lock);
 	*bpp = new_bp;
 	return 0;
 
 out_free_buf:
 	xfs_buf_free(new_bp);
 out_drop_pag:
-	xfs_perag_put(pag);
+	if (pag)
+		xfs_perag_put(pag);
 	return error;
 }
 
+/* Find the buffer cache for a particular buftarg and map. */
+static inline struct xfs_buf_cache *
+xfs_buftarg_get_cache(
+	struct xfs_buftarg		*btp,
+	const struct xfs_buf_map	*map,
+	struct xfs_perag		**pagp)
+{
+	struct xfs_mount		*mp = btp->bt_mount;
+
+	if (btp->bt_cache) {
+		*pagp = NULL;
+		return btp->bt_cache;
+	}
+
+	*pagp = xfs_perag_get(mp, xfs_daddr_to_agno(mp, map->bm_bn));
+	ASSERT(*pagp != NULL);
+	return &(*pagp)->pag_bcache;
+}
+
 /*
  * Assembles a buffer covering the specified range. The code is optimised for
  * cache hits, as metadata intensive workloads will see 3 orders of magnitude
@@ -677,6 +699,7 @@ xfs_buf_get_map(
 	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
 {
+	struct xfs_buf_cache	*bch;
 	struct xfs_perag	*pag;
 	struct xfs_buf		*bp = NULL;
 	struct xfs_buf_map	cmap = { .bm_bn = map[0].bm_bn };
@@ -692,10 +715,9 @@ xfs_buf_get_map(
 	if (error)
 		return error;
 
-	pag = xfs_perag_get(btp->bt_mount,
-			    xfs_daddr_to_agno(btp->bt_mount, cmap.bm_bn));
+	bch = xfs_buftarg_get_cache(btp, &cmap, &pag);
 
-	error = xfs_buf_lookup(pag, &cmap, flags, &bp);
+	error = xfs_buf_lookup(bch, &cmap, flags, &bp);
 	if (error && error != -ENOENT)
 		goto out_put_perag;
 
@@ -707,13 +729,14 @@ xfs_buf_get_map(
 			goto out_put_perag;
 
 		/* xfs_buf_find_insert() consumes the perag reference. */
-		error = xfs_buf_find_insert(btp, pag, &cmap, map, nmaps,
+		error = xfs_buf_find_insert(btp, bch, pag, &cmap, map, nmaps,
 				flags, &bp);
 		if (error)
 			return error;
 	} else {
 		XFS_STATS_INC(btp->bt_mount, xb_get_locked);
-		xfs_perag_put(pag);
+		if (pag)
+			xfs_perag_put(pag);
 	}
 
 	/* We do not hold a perag reference anymore. */
@@ -741,7 +764,8 @@ xfs_buf_get_map(
 	return 0;
 
 out_put_perag:
-	xfs_perag_put(pag);
+	if (pag)
+		xfs_perag_put(pag);
 	return error;
 }
 
@@ -995,12 +1019,13 @@ xfs_buf_rele(
 	struct xfs_buf		*bp)
 {
 	struct xfs_perag	*pag = bp->b_pag;
+	struct xfs_buf_cache	*bch = bp->b_cache;
 	bool			release;
 	bool			freebuf = false;
 
 	trace_xfs_buf_rele(bp, _RET_IP_);
 
-	if (!pag) {
+	if (!bch) {
 		ASSERT(list_empty(&bp->b_lru));
 		if (atomic_dec_and_test(&bp->b_hold)) {
 			xfs_buf_ioacct_dec(bp);
@@ -1022,7 +1047,7 @@ xfs_buf_rele(
 	 * leading to a use-after-free scenario.
 	 */
 	spin_lock(&bp->b_lock);
-	release = atomic_dec_and_lock(&bp->b_hold, &pag->pag_buf_lock);
+	release = atomic_dec_and_lock(&bp->b_hold, &bch->bc_lock);
 	if (!release) {
 		/*
 		 * Drop the in-flight state if the buffer is already on the LRU
@@ -1047,7 +1072,7 @@ xfs_buf_rele(
 			bp->b_state &= ~XFS_BSTATE_DISPOSE;
 			atomic_inc(&bp->b_hold);
 		}
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(&bch->bc_lock);
 	} else {
 		/*
 		 * most of the time buffers will already be removed from the
@@ -1062,10 +1087,13 @@ xfs_buf_rele(
 		}
 
 		ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
-		rhashtable_remove_fast(&pag->pag_buf_hash, &bp->b_rhash_head,
-				       xfs_buf_hash_params);
-		spin_unlock(&pag->pag_buf_lock);
-		xfs_perag_put(pag);
+		rhashtable_remove_fast(&bch->bc_hash, &bp->b_rhash_head,
+				xfs_buf_hash_params);
+		spin_unlock(&bch->bc_lock);
+		if (pag)
+			xfs_perag_put(pag);
+		bp->b_cache = NULL;
+		bp->b_pag = NULL;
 		freebuf = true;
 	}
 
@@ -1989,24 +2017,18 @@ xfs_setsize_buftarg_early(
 	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
 }
 
-struct xfs_buftarg *
-xfs_alloc_buftarg(
+static struct xfs_buftarg *
+xfs_alloc_buftarg_common(
 	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	const char		*descr)
 {
-	xfs_buftarg_t		*btp;
-	const struct dax_holder_operations *ops = NULL;
+	struct xfs_buftarg	*btp;
 
-#if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
-	ops = &xfs_dax_holder_operations;
-#endif
 	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
+	if (!btp)
+		return NULL;
 
 	btp->bt_mount = mp;
-	btp->bt_dev =  bdev->bd_dev;
-	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
-					    mp, ops);
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
@@ -2015,9 +2037,6 @@ xfs_alloc_buftarg(
 	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
 			     DEFAULT_RATELIMIT_BURST);
 
-	if (xfs_setsize_buftarg_early(btp, bdev))
-		goto error_free;
-
 	if (list_lru_init(&btp->bt_lru))
 		goto error_free;
 
@@ -2028,9 +2047,10 @@ xfs_alloc_buftarg(
 	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
 	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
-	if (register_shrinker(&btp->bt_shrinker, "xfs-buf:%s",
+	if (register_shrinker(&btp->bt_shrinker, "xfs-%s:%s", descr,
 			      mp->m_super->s_id))
 		goto error_pcpu;
+
 	return btp;
 
 error_pcpu:
@@ -2042,6 +2062,38 @@ xfs_alloc_buftarg(
 	return NULL;
 }
 
+/* Allocate a buffer cache target for a persistent block device. */
+struct xfs_buftarg *
+xfs_alloc_buftarg(
+	struct xfs_mount	*mp,
+	struct block_device	*bdev)
+{
+	struct xfs_buftarg	*btp;
+	const struct dax_holder_operations *ops = NULL;
+
+#if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
+	ops = &xfs_dax_holder_operations;
+#endif
+
+	btp = xfs_alloc_buftarg_common(mp, "buf");
+	if (!btp)
+		return NULL;
+
+	btp->bt_dev =  bdev->bd_dev;
+	btp->bt_bdev = bdev;
+	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
+					    mp, ops);
+
+	if (xfs_setsize_buftarg_early(btp, bdev))
+		goto error_free;
+
+	return btp;
+
+error_free:
+	xfs_free_buftarg(btp);
+	return NULL;
+}
+
 /*
  * Cancel a delayed write list.
  *
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 467ddb2e2f0d..d17ec9274d99 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -83,6 +83,14 @@ typedef unsigned int xfs_buf_flags_t;
 #define XFS_BSTATE_DISPOSE	 (1 << 0)	/* buffer being discarded */
 #define XFS_BSTATE_IN_FLIGHT	 (1 << 1)	/* I/O in flight */
 
+struct xfs_buf_cache {
+	spinlock_t		bc_lock;
+	struct rhashtable	bc_hash;
+};
+
+int xfs_buf_cache_init(struct xfs_buf_cache *bch);
+void xfs_buf_cache_destroy(struct xfs_buf_cache *bch);
+
 /*
  * The xfs_buftarg contains 2 notions of "sector size" -
  *
@@ -102,6 +110,7 @@ typedef struct xfs_buftarg {
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
 	struct xfs_mount	*bt_mount;
+	struct xfs_buf_cache	*bt_cache;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
 	size_t			bt_logical_sectorsize;
@@ -208,6 +217,7 @@ struct xfs_buf {
 	int			b_last_error;
 
 	const struct xfs_buf_ops	*b_ops;
+	struct xfs_buf_cache	*b_cache;
 	struct rcu_head		b_rcu;
 };
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fc8d4de55cd1..622cd805dc48 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -486,9 +486,6 @@ xfs_daddr_to_agbno(struct xfs_mount *mp, xfs_daddr_t d)
 	return (xfs_agblock_t) do_div(ld, mp->m_sb.sb_agblocks);
 }
 
-int xfs_buf_hash_init(struct xfs_perag *pag);
-void xfs_buf_hash_destroy(struct xfs_perag *pag);
-
 extern void	xfs_uuid_table_free(void);
 extern uint64_t xfs_default_resblks(xfs_mount_t *mp);
 extern int	xfs_mountfs(xfs_mount_t *mp);

