Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006E659E7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiL3Xll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiL3Xlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:41:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0C1DDE7;
        Fri, 30 Dec 2022 15:41:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F5CBB81DCB;
        Fri, 30 Dec 2022 23:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5618C433D2;
        Fri, 30 Dec 2022 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672443695;
        bh=iV3LhJ9EAMhW9zWHRgbsuT27rQFSTxz3t2SSyTexDm4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NBtHTug/o5mwivAxoIWIge1m5jkvXYJinnjKSEbMjuSU4JSH7RoTrgrZUoX2FF0pk
         1QaJlYdmaNOFQTAU0azvRMZ1X8Vlws+3JjIcXzquaBgVZJIcrB0bn88iRUuZdxmQ98
         a20sbTmfrLEvoKHRqUYED27onSgy1BJ99ttGX4jcnHPmTenQc6zcMH59d22jnZIR3K
         8ItEx/s4dLGK2sfwRprFCFHPPCz1/9YMyk9QQoHcZWP3nB/FjVeyw/TIOFHa1m0J9K
         uRfEw/2tWGBfp1/zqY2nhIy/tdoVviRjy2pgFuPCqTFPXVPO+OTHckSz1Bo5L1k/y0
         1NsOIF37M9wIA==
Subject: [PATCH 2/7] xfs: teach buftargs to maintain their own buffer
 hashtable
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840627.696535.15938554761194724741.stgit@magnolia>
In-Reply-To: <167243840589.696535.4812770109109400531.stgit@magnolia>
References: <167243840589.696535.4812770109109400531.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Currently, cached buffers are indexed by per-AG hashtables.  This works
great for the data device, but won't work for in-memory btrees.  Make it
so that buftargs can index buffers too.  Introduce XFS_BSTATE_CACHED as
an explicit state flag for buffers that are cached in an rhashtable,
since we can't rely on b_pag being set for buffers that are cached but
not on behalf of an AG.  We'll soon be using the buffer cache for
xfiles.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_buf.c |  142 ++++++++++++++++++++++++++++++++++++++++--------------
 fs/xfs/xfs_buf.h |    9 +++
 2 files changed, 113 insertions(+), 38 deletions(-)


diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 2bea2c3f9ead..7dfc1db566fa 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -570,7 +570,7 @@ xfs_buf_find_lock(
 
 static inline int
 xfs_buf_lookup(
-	struct xfs_perag	*pag,
+	struct rhashtable	*bufhash,
 	struct xfs_buf_map	*map,
 	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
@@ -579,7 +579,7 @@ xfs_buf_lookup(
 	int			error;
 
 	rcu_read_lock();
-	bp = rhashtable_lookup(&pag->pag_buf_hash, map, xfs_buf_hash_params);
+	bp = rhashtable_lookup(bufhash, map, xfs_buf_hash_params);
 	if (!bp || !atomic_inc_not_zero(&bp->b_hold)) {
 		rcu_read_unlock();
 		return -ENOENT;
@@ -605,6 +605,8 @@ static int
 xfs_buf_find_insert(
 	struct xfs_buftarg	*btp,
 	struct xfs_perag	*pag,
+	spinlock_t		*hashlock,
+	struct rhashtable	*bufhash,
 	struct xfs_buf_map	*cmap,
 	struct xfs_buf_map	*map,
 	int			nmaps,
@@ -632,18 +634,18 @@ xfs_buf_find_insert(
 			goto out_free_buf;
 	}
 
-	spin_lock(&pag->pag_buf_lock);
-	bp = rhashtable_lookup_get_insert_fast(&pag->pag_buf_hash,
-			&new_bp->b_rhash_head, xfs_buf_hash_params);
+	spin_lock(hashlock);
+	bp = rhashtable_lookup_get_insert_fast(bufhash, &new_bp->b_rhash_head,
+			xfs_buf_hash_params);
 	if (IS_ERR(bp)) {
 		error = PTR_ERR(bp);
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(hashlock);
 		goto out_free_buf;
 	}
 	if (bp) {
 		/* found an existing buffer */
 		atomic_inc(&bp->b_hold);
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(hashlock);
 		error = xfs_buf_find_lock(bp, flags);
 		if (error)
 			xfs_buf_rele(bp);
@@ -654,14 +656,16 @@ xfs_buf_find_insert(
 
 	/* The new buffer keeps the perag reference until it is freed. */
 	new_bp->b_pag = pag;
-	spin_unlock(&pag->pag_buf_lock);
+	new_bp->b_state |= XFS_BSTATE_CACHED;
+	spin_unlock(hashlock);
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
 
@@ -678,6 +682,8 @@ xfs_buf_get_map(
 	xfs_buf_flags_t		flags,
 	struct xfs_buf		**bpp)
 {
+	spinlock_t		*hashlock;
+	struct rhashtable	*bufhash;
 	struct xfs_perag	*pag;
 	struct xfs_buf		*bp = NULL;
 	struct xfs_buf_map	cmap = { .bm_bn = map[0].bm_bn };
@@ -693,10 +699,18 @@ xfs_buf_get_map(
 	if (error)
 		return error;
 
-	pag = xfs_perag_get(btp->bt_mount,
-			    xfs_daddr_to_agno(btp->bt_mount, cmap.bm_bn));
+	if (btp->bt_flags & XFS_BUFTARG_SELF_CACHED) {
+		pag = NULL;
+		hashlock = &btp->bt_hashlock;
+		bufhash = &btp->bt_bufhash;
+	} else {
+		pag = xfs_perag_get(btp->bt_mount,
+				xfs_daddr_to_agno(btp->bt_mount, cmap.bm_bn));
+		hashlock = &pag->pag_buf_lock;
+		bufhash = &pag->pag_buf_hash;
+	}
 
-	error = xfs_buf_lookup(pag, &cmap, flags, &bp);
+	error = xfs_buf_lookup(bufhash, &cmap, flags, &bp);
 	if (error && error != -ENOENT)
 		goto out_put_perag;
 
@@ -708,13 +722,14 @@ xfs_buf_get_map(
 			goto out_put_perag;
 
 		/* xfs_buf_find_insert() consumes the perag reference. */
-		error = xfs_buf_find_insert(btp, pag, &cmap, map, nmaps,
-				flags, &bp);
+		error = xfs_buf_find_insert(btp, pag, hashlock, bufhash, &cmap,
+				map, nmaps, flags, &bp);
 		if (error)
 			return error;
 	} else {
 		XFS_STATS_INC(btp->bt_mount, xb_get_locked);
-		xfs_perag_put(pag);
+		if (pag)
+			xfs_perag_put(pag);
 	}
 
 	/* We do not hold a perag reference anymore. */
@@ -742,7 +757,8 @@ xfs_buf_get_map(
 	return 0;
 
 out_put_perag:
-	xfs_perag_put(pag);
+	if (pag)
+		xfs_perag_put(pag);
 	return error;
 }
 
@@ -996,12 +1012,14 @@ xfs_buf_rele(
 	struct xfs_buf		*bp)
 {
 	struct xfs_perag	*pag = bp->b_pag;
+	spinlock_t		*hashlock;
+	struct rhashtable	*bufhash;
 	bool			release;
 	bool			freebuf = false;
 
 	trace_xfs_buf_rele(bp, _RET_IP_);
 
-	if (!pag) {
+	if (!(bp->b_state & XFS_BSTATE_CACHED)) {
 		ASSERT(list_empty(&bp->b_lru));
 		if (atomic_dec_and_test(&bp->b_hold)) {
 			xfs_buf_ioacct_dec(bp);
@@ -1012,6 +1030,14 @@ xfs_buf_rele(
 
 	ASSERT(atomic_read(&bp->b_hold) > 0);
 
+	if (bp->b_target->bt_flags & XFS_BUFTARG_SELF_CACHED) {
+		hashlock = &bp->b_target->bt_hashlock;
+		bufhash = &bp->b_target->bt_bufhash;
+	} else {
+		hashlock = &pag->pag_buf_lock;
+		bufhash = &pag->pag_buf_hash;
+	}
+
 	/*
 	 * We grab the b_lock here first to serialise racing xfs_buf_rele()
 	 * calls. The pag_buf_lock being taken on the last reference only
@@ -1023,7 +1049,7 @@ xfs_buf_rele(
 	 * leading to a use-after-free scenario.
 	 */
 	spin_lock(&bp->b_lock);
-	release = atomic_dec_and_lock(&bp->b_hold, &pag->pag_buf_lock);
+	release = atomic_dec_and_lock(&bp->b_hold, hashlock);
 	if (!release) {
 		/*
 		 * Drop the in-flight state if the buffer is already on the LRU
@@ -1048,7 +1074,7 @@ xfs_buf_rele(
 			bp->b_state &= ~XFS_BSTATE_DISPOSE;
 			atomic_inc(&bp->b_hold);
 		}
-		spin_unlock(&pag->pag_buf_lock);
+		spin_unlock(hashlock);
 	} else {
 		/*
 		 * most of the time buffers will already be removed from the
@@ -1063,10 +1089,13 @@ xfs_buf_rele(
 		}
 
 		ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
-		rhashtable_remove_fast(&pag->pag_buf_hash, &bp->b_rhash_head,
-				       xfs_buf_hash_params);
-		spin_unlock(&pag->pag_buf_lock);
-		xfs_perag_put(pag);
+		rhashtable_remove_fast(bufhash, &bp->b_rhash_head,
+				xfs_buf_hash_params);
+		spin_unlock(hashlock);
+		if (pag)
+			xfs_perag_put(pag);
+		bp->b_state &= ~XFS_BSTATE_CACHED;
+		bp->b_pag = NULL;
 		freebuf = true;
 	}
 
@@ -1946,6 +1975,8 @@ xfs_free_buftarg(
 	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
 	percpu_counter_destroy(&btp->bt_io_count);
 	list_lru_destroy(&btp->bt_lru);
+	if (btp->bt_flags & XFS_BUFTARG_SELF_CACHED)
+		rhashtable_destroy(&btp->bt_bufhash);
 
 	blkdev_issue_flush(btp->bt_bdev);
 	invalidate_bdev(btp->bt_bdev);
@@ -1990,24 +2021,20 @@ xfs_setsize_buftarg_early(
 	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
 }
 
-struct xfs_buftarg *
-xfs_alloc_buftarg(
+static struct xfs_buftarg *
+__xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	struct block_device	*bdev)
+	unsigned int		flags)
 {
-	xfs_buftarg_t		*btp;
-	const struct dax_holder_operations *ops = NULL;
+	struct xfs_buftarg	*btp;
+	int			error;
 
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
+	btp->bt_flags = flags;
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
@@ -2016,9 +2043,6 @@ xfs_alloc_buftarg(
 	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
 			     DEFAULT_RATELIMIT_BURST);
 
-	if (xfs_setsize_buftarg_early(btp, bdev))
-		goto error_free;
-
 	if (list_lru_init(&btp->bt_lru))
 		goto error_free;
 
@@ -2032,8 +2056,18 @@ xfs_alloc_buftarg(
 	if (register_shrinker(&btp->bt_shrinker, "xfs-buf:%s",
 			      mp->m_super->s_id))
 		goto error_pcpu;
+
+	if (btp->bt_flags & XFS_BUFTARG_SELF_CACHED) {
+		spin_lock_init(&btp->bt_hashlock);
+		error = rhashtable_init(&btp->bt_bufhash, &xfs_buf_hash_params);
+		if (error)
+			goto error_shrinker;
+	}
+
 	return btp;
 
+error_shrinker:
+	unregister_shrinker(&btp->bt_shrinker);
 error_pcpu:
 	percpu_counter_destroy(&btp->bt_io_count);
 error_lru:
@@ -2043,6 +2077,38 @@ xfs_alloc_buftarg(
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
+	btp = __xfs_alloc_buftarg(mp, 0);
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
index 467ddb2e2f0d..d7bf7f657e99 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -82,6 +82,7 @@ typedef unsigned int xfs_buf_flags_t;
  */
 #define XFS_BSTATE_DISPOSE	 (1 << 0)	/* buffer being discarded */
 #define XFS_BSTATE_IN_FLIGHT	 (1 << 1)	/* I/O in flight */
+#define XFS_BSTATE_CACHED	 (1 << 2)	/* cached buffer */
 
 /*
  * The xfs_buftarg contains 2 notions of "sector size" -
@@ -102,11 +103,16 @@ typedef struct xfs_buftarg {
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
 	struct xfs_mount	*bt_mount;
+	unsigned int		bt_flags;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
 	size_t			bt_logical_sectorsize;
 	size_t			bt_logical_sectormask;
 
+	/* self-caching buftargs */
+	spinlock_t		bt_hashlock;
+	struct rhashtable	bt_bufhash;
+
 	/* LRU control structures */
 	struct shrinker		bt_shrinker;
 	struct list_lru		bt_lru;
@@ -115,6 +121,9 @@ typedef struct xfs_buftarg {
 	struct ratelimit_state	bt_ioerror_rl;
 } xfs_buftarg_t;
 
+/* the xfs_buftarg indexes buffers via bt_buf_hash */
+#define XFS_BUFTARG_SELF_CACHED	(1U << 0)
+
 #define XB_PAGES	2
 
 struct xfs_buf_map {

