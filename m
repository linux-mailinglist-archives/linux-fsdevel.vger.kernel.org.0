Return-Path: <linux-fsdevel+bounces-32321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE29A35D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C4C2820B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2911922F0;
	Fri, 18 Oct 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k60k+MRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906D19048A;
	Fri, 18 Oct 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233675; cv=none; b=Bvo2DbU28v0GMvfSE6BV9BS1uLR2dYxB6Yt/rGsQpcgqizW+cOXVWK8xJJcAVUjpWNDyNbVsLCrrKwPEnJ1kWdbsEyOwhaNwpD5eSDVaAQPMtfMwlvN5UjAwtk76+j8zEMjNqRVn+x49vEGSSVBgFYu1YP9zdkdo7MglwfGaXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233675; c=relaxed/simple;
	bh=O8jxodCGMWtrByAFoEsRBLTTLZfK8XqMptqufBIfhNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvpdhE3uAQt9CZedF5wznknv7JkyIzcJIViwBVhhs7SDDw06I3phWvKWM9FtspBzMafRPRGSB6X5vDjQwOMYMFDjXpX6bwS/bmla2ClGhJnO5ggC5mQ4CQw9AzwoFaiVlO1/qoI9ChwO8tQGxxuF4e7bVfQsZZYQ+ukRHxU0HwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k60k+MRu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233673; x=1760769673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8jxodCGMWtrByAFoEsRBLTTLZfK8XqMptqufBIfhNw=;
  b=k60k+MRuZ7rIda8ghpUOzCaLmZ+hepK1mnQBVBiHzrbZPE1UM5lcn109
   phzGrAe6BCSPmSa3QPB6QA8SaRaMDnzc0Q8gKcJ3LYTu0NLtOKMDBKP9v
   62B3ZGcEK1hUG8R5rUtMNpnaqVBwG/DiDQO/VsSmuPpEgEcqLJZr+CWzq
   yfKmU4Iz1lQzWUycXK00oKftq0OA3VkFs7C4qIrhGp0Fmc1xTY0jbHGtn
   /9dmUQbqF9DXxXead5R5iolHrFw3M6EooCIVUGlL/6pUrIDAR2N4DsoRQ
   qKx50DeZYGNEB0ga/jdytlAJe22/hqEBKr4o9esxf+f63Z1wgToO5CgKR
   Q==;
X-CSE-ConnectionGUID: l47qHpM+TjSyBWD/7suNGQ==
X-CSE-MsgGUID: 2QfD2714RzWjewOM/L3XKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884957"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884957"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:04 -0700
X-CSE-ConnectionGUID: +AFCy/XaR8CvOJBAh1gLlQ==
X-CSE-MsgGUID: WK41Ugd7SZ2i1qeniXmNog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607538"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:04 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 12/13] mm: zswap: Compress batching with Intel IAA in zswap_store() of large folios.
Date: Thu, 17 Oct 2024 23:41:00 -0700
Message-Id: <20241018064101.336232-13-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the system has Intel IAA, and if CONFIG_ZSWAP_STORE_BATCHING_ENABLED
is set to "y", zswap_store() will call swap_crypto_acomp_compress_batch()
to batch compress up to SWAP_CRYPTO_SUB_BATCH_SIZE pages in large folios
in parallel using the multiple compress engines available in IAA hardware.

On platforms with multiple IAA devices per socket, compress jobs from all
cores in a socket will be distributed among all IAA devices on the socket
by the iaa_crypto driver.

If zswap_store() is called with a large folio, and if
zswap_store_batching_enabled() returns "true", it will call the
main __zswap_store_batch_core() interface for compress batching. The
interface represents the extensible compress batching architecture that can
potentially be called with a batch of any-order folios from
shrink_folio_list(). In other words, although zswap_store()
calls __zswap_store_batch_core() with exactly one large folio in this
patch, we will reuse this API to reclaim a batch of folios in subsequent
patches.

The newly added functions that implement batched stores follow the
general structure of zswap_store() of a large folio. Some amount of
restructuring and optimization is done to minimize failure points
for a batch, fail early and maximize the zswap store pipeline occupancy
with SWAP_CRYPTO_SUB_BATCH_SIZE pages, potentially from multiple
folios. This is intended to maximize reclaim throughput with the IAA
hardware parallel compressions.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h |  84 ++++++
 mm/zswap.c            | 591 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 671 insertions(+), 4 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 74ad2a24b309..9bbe330686f6 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -24,6 +24,88 @@ struct zswap_lruvec_state {
 	atomic_long_t nr_disk_swapins;
 };
 
+/*
+ * struct zswap_store_sub_batch_page:
+ *
+ * This represents one "zswap batching element", namely, the
+ * attributes associated with a page in a large folio that will
+ * be compressed and stored in zswap. The term "batch" is reserved
+ * for a conceptual "batch" of folios that can be sent to
+ * zswap_store() by reclaim. The term "sub-batch" is used to describe
+ * a collection of "zswap batching elements", i.e., an array of
+ * "struct zswap_store_sub_batch_page *".
+ *
+ * The zswap compress sub-batch size is specified by
+ * SWAP_CRYPTO_SUB_BATCH_SIZE, currently set as 8UL if the
+ * platform has Intel IAA. This means zswap can store a large folio
+ * by creating sub-batches of up to 8 pages and compressing this
+ * batch using IAA to parallelize the 8 compress jobs in hardware.
+ * For e.g., a 64KB folio can be compressed as 2 sub-batches of
+ * 8 pages each. This can significantly improve the zswap_store()
+ * performance for large folios.
+ *
+ * Although the page itself is represented directly, the structure
+ * adds a "u8 batch_idx" to represent an index for the folio in a
+ * conceptual "batch of folios" that can be passed to zswap_store().
+ * Conceptually, this allows for up to 256 folios that can be passed
+ * to zswap_store(). If this conceptual number of folios sent to
+ * zswap_store() exceeds 256, the "batch_idx" needs to become u16.
+ */
+struct zswap_store_sub_batch_page {
+	u8 batch_idx;
+	swp_entry_t swpentry;
+	struct obj_cgroup *objcg;
+	struct zswap_entry *entry;
+	int error; /* folio error status. */
+};
+
+/*
+ * struct zswap_store_pipeline_state:
+ *
+ * This stores state during IAA compress batching of (conceptually, a batch of)
+ * folios. The term pipelining in this context, refers to breaking down
+ * the batch of folios being reclaimed into sub-batches of
+ * SWAP_CRYPTO_SUB_BATCH_SIZE pages, batch compressing and storing the
+ * sub-batch. This concept could be further evolved to use overlap of CPU
+ * computes with IAA computes. For instance, we could stage the post-compress
+ * computes for sub-batch "N-1" to happen in parallel with IAA batch
+ * compression of sub-batch "N".
+ *
+ * We begin by developing the concept of compress batching. Pipelining with
+ * overlap can be future work.
+ *
+ * @errors: The errors status for the batch of reclaim folios passed in from
+ *          a higher mm layer such as swap_writepage().
+ * @pool: A valid zswap_pool.
+ * @acomp_ctx: The per-cpu pointer to the crypto_acomp_ctx for the @pool.
+ * @sub_batch: This is an array that represents the sub-batch of up to
+ *             SWAP_CRYPTO_SUB_BATCH_SIZE pages that are being stored
+ *             in zswap.
+ * @comp_dsts: The destination buffers for crypto_acomp_compress() for each
+ *             page being compressed.
+ * @comp_dlens: The destination buffers' lengths from crypto_acomp_compress()
+ *              obtained after crypto_acomp_poll() returns completion status,
+ *              for each page being compressed.
+ * @comp_errors: Compression errors for each page being compressed.
+ * @nr_comp_pages: Total number of pages in @sub_batch.
+ *
+ * Note:
+ * The max sub-batch size is SWAP_CRYPTO_SUB_BATCH_SIZE, currently 8UL.
+ * Hence, if SWAP_CRYPTO_SUB_BATCH_SIZE exceeds 256, some of the
+ * u8 members (except @comp_dsts) need to become u16.
+ */
+struct zswap_store_pipeline_state {
+	int *errors;
+	struct zswap_pool *pool;
+	struct crypto_acomp_ctx *acomp_ctx;
+	struct zswap_store_sub_batch_page *sub_batch;
+	struct page **comp_pages;
+	u8 **comp_dsts;
+	unsigned int *comp_dlens;
+	int *comp_errors;
+	u8 nr_comp_pages;
+};
+
 bool zswap_store_batching_enabled(void);
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
@@ -39,6 +121,8 @@ bool zswap_never_enabled(void);
 #else
 
 struct zswap_lruvec_state {};
+struct zswap_store_sub_batch_page {};
+struct zswap_store_pipeline_state {};
 
 static inline bool zswap_store_batching_enabled(void)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index cab3114321f9..1c12a7b9f4ff 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -130,7 +130,7 @@ module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 /*
  * Enable/disable batching of compressions if zswap_store is called with a
  * large folio. If enabled, and if IAA is the zswap compressor, pages are
- * compressed in parallel in batches of say, 8 pages.
+ * compressed in parallel in batches of SWAP_CRYPTO_SUB_BATCH_SIZE pages.
  * If not, every page is compressed sequentially.
  */
 static bool __zswap_store_batching_enabled = IS_ENABLED(
@@ -246,6 +246,12 @@ __always_inline bool zswap_store_batching_enabled(void)
 	return __zswap_store_batching_enabled;
 }
 
+static void __zswap_store_batch_core(
+	int node_id,
+	struct folio **folios,
+	int *errors,
+	unsigned int nr_folios);
+
 /*********************************
 * pool functions
 **********************************/
@@ -906,6 +912,9 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/*
+ * The acomp_ctx->mutex must be locked/unlocked in the calling procedure.
+ */
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -921,8 +930,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 
 	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
 
-	mutex_lock(&acomp_ctx->mutex);
-
 	dst = acomp_ctx->buffer[0];
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
@@ -992,7 +999,6 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	else if (alloc_ret)
 		zswap_reject_alloc_fail++;
 
-	mutex_unlock(&acomp_ctx->mutex);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -1545,10 +1551,17 @@ static ssize_t zswap_store_page(struct page *page,
 	return -EINVAL;
 }
 
+/*
+ * Modified to use the IAA compress batching framework implemented in
+ * __zswap_store_batch_core() if zswap_store_batching_enabled() is true.
+ * The batching code is intended to significantly improve folio store
+ * performance over the sequential code.
+ */
 bool zswap_store(struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
 	swp_entry_t swp = folio->swap;
+	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
@@ -1556,6 +1569,17 @@ bool zswap_store(struct folio *folio)
 	bool ret = false;
 	long index;
 
+	/*
+	 * Improve large folio zswap_store() latency with IAA compress batching.
+	 */
+	if (folio_test_large(folio) && zswap_store_batching_enabled()) {
+		int error = -1;
+		__zswap_store_batch_core(folio_nid(folio), &folio, &error, 1);
+		if (!error)
+			ret = true;
+		return ret;
+	}
+
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
@@ -1588,6 +1612,9 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
+	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
+	mutex_lock(&acomp_ctx->mutex);
+
 	for (index = 0; index < nr_pages; ++index) {
 		struct page *page = folio_page(folio, index);
 		ssize_t bytes;
@@ -1609,6 +1636,7 @@ bool zswap_store(struct folio *folio)
 	ret = true;
 
 put_pool:
+	mutex_unlock(&acomp_ctx->mutex);
 	zswap_pool_put(pool);
 put_objcg:
 	obj_cgroup_put(objcg);
@@ -1638,6 +1666,561 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
+/*
+ * Note: If SWAP_CRYPTO_SUB_BATCH_SIZE exceeds 256, change the
+ * u8 stack variables in the next several functions, to u16.
+ */
+
+/*
+ * Propagate the "sbp" error condition to other batch elements belonging to
+ * the same folio as "sbp".
+ */
+static __always_inline void zswap_store_propagate_errors(
+	struct zswap_store_pipeline_state *zst,
+	u8 error_batch_idx)
+{
+	u8 i;
+
+	if (zst->errors[error_batch_idx])
+		return;
+
+	for (i = 0; i < zst->nr_comp_pages; ++i) {
+		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
+
+		if (sbp->batch_idx == error_batch_idx) {
+			if (!sbp->error) {
+				if (!IS_ERR_VALUE(sbp->entry->handle))
+					zpool_free(zst->pool->zpool, sbp->entry->handle);
+
+				if (sbp->entry) {
+					zswap_entry_cache_free(sbp->entry);
+					sbp->entry = NULL;
+				}
+				sbp->error = -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * Set zswap status for the folio to "error"
+	 * for use in swap_writepage.
+	 */
+	zst->errors[error_batch_idx] = -EINVAL;
+}
+
+static __always_inline void zswap_process_comp_errors(
+	struct zswap_store_pipeline_state *zst)
+{
+	u8 i;
+
+	for (i = 0; i < zst->nr_comp_pages; ++i) {
+		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
+
+		if (zst->comp_errors[i]) {
+			if (zst->comp_errors[i] == -ENOSPC)
+				zswap_reject_compress_poor++;
+			else
+				zswap_reject_compress_fail++;
+
+			if (!sbp->error)
+				zswap_store_propagate_errors(zst,
+							     sbp->batch_idx);
+		}
+	}
+}
+
+static void zswap_compress_batch(struct zswap_store_pipeline_state *zst)
+{
+	/*
+	 * Compress up to SWAP_CRYPTO_SUB_BATCH_SIZE pages.
+	 * If IAA is the zswap compressor, this compresses the
+	 * pages in parallel, leading to significant performance
+	 * improvements as compared to software compressors.
+	 */
+	swap_crypto_acomp_compress_batch(
+		zst->comp_pages,
+		zst->comp_dsts,
+		zst->comp_dlens,
+		zst->comp_errors,
+		zst->nr_comp_pages,
+		zst->acomp_ctx);
+
+	/*
+	 * Scan the sub-batch for any compression errors,
+	 * and invalidate pages with errors, along with other
+	 * pages belonging to the same folio as the error pages.
+	 */
+	zswap_process_comp_errors(zst);
+}
+
+static void zswap_zpool_store_sub_batch(
+	struct zswap_store_pipeline_state *zst)
+{
+	u8 i;
+
+	for (i = 0; i < zst->nr_comp_pages; ++i) {
+		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
+		struct zpool *zpool;
+		unsigned long handle;
+		char *buf;
+		gfp_t gfp;
+		int err;
+
+		/* Skip pages that had compress errors. */
+		if (sbp->error)
+			continue;
+
+		zpool = zst->pool->zpool;
+		gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
+		if (zpool_malloc_support_movable(zpool))
+			gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+		err = zpool_malloc(zpool, zst->comp_dlens[i], gfp, &handle);
+
+		if (err) {
+			if (err == -ENOSPC)
+				zswap_reject_compress_poor++;
+			else
+				zswap_reject_alloc_fail++;
+
+			/*
+			 * An error should be propagated to other pages of the
+			 * same folio in the sub-batch, and zpool resources for
+			 * those pages (in sub-batch order prior to this zpool
+			 * error) should be de-allocated.
+			 */
+			zswap_store_propagate_errors(zst, sbp->batch_idx);
+			continue;
+		}
+
+		buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
+		memcpy(buf, zst->comp_dsts[i], zst->comp_dlens[i]);
+		zpool_unmap_handle(zpool, handle);
+
+		sbp->entry->handle = handle;
+		sbp->entry->length = zst->comp_dlens[i];
+	}
+}
+
+/*
+ * Returns true if the entry was successfully
+ * stored in the xarray, and false otherwise.
+ */
+static bool zswap_store_entry(swp_entry_t page_swpentry,
+			      struct zswap_entry *entry)
+{
+	struct zswap_entry *old = xa_store(swap_zswap_tree(page_swpentry),
+					   swp_offset(page_swpentry),
+					   entry, GFP_KERNEL);
+	if (xa_is_err(old)) {
+		int err = xa_err(old);
+
+		WARN_ONCE(err != -ENOMEM, "unexpected xarray error: %d\n", err);
+		zswap_reject_alloc_fail++;
+		return false;
+	}
+
+	/*
+	 * We may have had an existing entry that became stale when
+	 * the folio was redirtied and now the new version is being
+	 * swapped out. Get rid of the old.
+	 */
+	if (old)
+		zswap_entry_free(old);
+
+	return true;
+}
+
+static void zswap_batch_compress_post_proc(
+	struct zswap_store_pipeline_state *zst)
+{
+	int nr_objcg_pages = 0, nr_pages = 0;
+	struct obj_cgroup *objcg = NULL;
+	size_t compressed_bytes = 0;
+	u8 i;
+
+	zswap_zpool_store_sub_batch(zst);
+
+	for (i = 0; i < zst->nr_comp_pages; ++i) {
+		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
+
+		if (sbp->error)
+			continue;
+
+		if (!zswap_store_entry(sbp->swpentry, sbp->entry)) {
+			zswap_store_propagate_errors(zst, sbp->batch_idx);
+			continue;
+		}
+
+		/*
+		 * The entry is successfully compressed and stored in the tree,
+		 * there is no further possibility of failure. Grab refs to the
+		 * pool and objcg. These refs will be dropped by
+		 * zswap_entry_free() when the entry is removed from the tree.
+		 */
+		zswap_pool_get(zst->pool);
+		if (sbp->objcg)
+			obj_cgroup_get(sbp->objcg);
+
+		/*
+		 * We finish initializing the entry while it's already in xarray.
+		 * This is safe because:
+		 *
+		 * 1. Concurrent stores and invalidations are excluded by folio
+		 *    lock.
+		 *
+		 * 2. Writeback is excluded by the entry not being on the LRU yet.
+		 *    The publishing order matters to prevent writeback from seeing
+		 *    an incoherent entry.
+		 */
+		sbp->entry->pool = zst->pool;
+		sbp->entry->swpentry = sbp->swpentry;
+		sbp->entry->objcg = sbp->objcg;
+		sbp->entry->referenced = true;
+		if (sbp->entry->length) {
+			INIT_LIST_HEAD(&sbp->entry->lru);
+			zswap_lru_add(&zswap_list_lru, sbp->entry);
+		}
+
+		if (!objcg && sbp->objcg) {
+			objcg = sbp->objcg;
+		} else if (objcg && sbp->objcg && (objcg != sbp->objcg)) {
+			obj_cgroup_charge_zswap(objcg, compressed_bytes);
+			count_objcg_events(objcg, ZSWPOUT, nr_objcg_pages);
+			compressed_bytes = 0;
+			nr_objcg_pages = 0;
+			objcg = sbp->objcg;
+		}
+
+		if (sbp->objcg) {
+			compressed_bytes += sbp->entry->length;
+			++nr_objcg_pages;
+		}
+
+		++nr_pages;
+	} /* for sub-batch pages. */
+
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+		count_objcg_events(objcg, ZSWPOUT, nr_objcg_pages);
+	}
+
+	atomic_long_add(nr_pages, &zswap_stored_pages);
+	count_vm_events(ZSWPOUT, nr_pages);
+}
+
+static void zswap_store_sub_batch(struct zswap_store_pipeline_state *zst)
+{
+	u8 i;
+
+	for (i = 0; i < zst->nr_comp_pages; ++i) {
+		zst->comp_dsts[i] = zst->acomp_ctx->buffer[i];
+		zst->comp_dlens[i] = PAGE_SIZE;
+	} /* for sub-batch pages. */
+
+	/*
+	 * Batch compress sub-batch "N". If IAA is the compressor, the
+	 * hardware will compress multiple pages in parallel.
+	 */
+	zswap_compress_batch(zst);
+
+	zswap_batch_compress_post_proc(zst);
+}
+
+static void zswap_add_folio_pages_to_sb(
+	struct zswap_store_pipeline_state *zst,
+	struct folio* folio,
+	u8 batch_idx,
+	struct obj_cgroup *objcg,
+	struct zswap_entry *entries[],
+	long start_idx,
+	u8 add_nr_pages)
+{
+	long index;
+
+	for (index = start_idx; index < (start_idx + add_nr_pages); ++index) {
+		u8 i = zst->nr_comp_pages;
+		struct zswap_store_sub_batch_page *sbp = &zst->sub_batch[i];
+		struct page *page = folio_page(folio, index);
+		zst->comp_pages[i] = page;
+		sbp->swpentry = page_swap_entry(page);
+		sbp->batch_idx = batch_idx;
+		sbp->objcg = objcg;
+		sbp->entry = entries[index - start_idx];
+		sbp->error = 0;
+		++zst->nr_comp_pages;
+	}
+}
+
+static __always_inline void zswap_store_reset_sub_batch(
+	struct zswap_store_pipeline_state *zst)
+{
+	zst->nr_comp_pages = 0;
+}
+
+/* Allocate entries for the next sub-batch. */
+static int zswap_alloc_entries(u8 nr_entries,
+			       struct zswap_entry *entries[],
+			       int node_id)
+{
+	u8 i;
+
+	for (i = 0; i < nr_entries; ++i) {
+		entries[i] = zswap_entry_cache_alloc(GFP_KERNEL, node_id);
+		if (!entries[i]) {
+			u8 j;
+
+			zswap_reject_kmemcache_fail++;
+			for (j = 0; j < i; ++j)
+				zswap_entry_cache_free(entries[j]);
+			return -EINVAL;
+		}
+
+		entries[i]->handle = (unsigned long)ERR_PTR(-EINVAL);
+	}
+
+	return 0;
+}
+
+/*
+ * If the zswap store fails or zswap is disabled, we must invalidate
+ * the possibly stale entries which were previously stored at the
+ * offsets corresponding to each page of the folio. Otherwise,
+ * writeback could overwrite the new data in the swapfile.
+ */
+static void zswap_delete_stored_entries(struct folio *folio)
+{
+	swp_entry_t swp = folio->swap;
+	unsigned type = swp_type(swp);
+	pgoff_t offset = swp_offset(swp);
+	struct zswap_entry *entry;
+	struct xarray *tree;
+	long index;
+
+	for (index = 0; index < folio_nr_pages(folio); ++index) {
+		tree = swap_zswap_tree(swp_entry(type, offset + index));
+		entry = xa_erase(tree, offset + index);
+		if (entry)
+			zswap_entry_free(entry);
+	}
+}
+
+static void zswap_store_process_folio_errors(
+	struct folio **folios,
+	int *errors,
+	unsigned int nr_folios)
+{
+	u8 batch_idx;
+
+	for (batch_idx = 0; batch_idx < nr_folios; ++batch_idx)
+		if (errors[batch_idx])
+			zswap_delete_stored_entries(folios[batch_idx]);
+}
+
+/*
+ * Store a (batch of) any-order large folio(s) in zswap. Each folio will be
+ * broken into sub-batches of SWAP_CRYPTO_SUB_BATCH_SIZE pages, the
+ * sub-batch will be compressed by IAA in parallel, and stored in zpool/xarray.
+ *
+ * This the main procedure for batching of folios, and batching within
+ * large folios.
+ *
+ * This procedure should only be called if zswap supports batching of stores.
+ * Otherwise, the sequential implementation for storing folios as in the
+ * current zswap_store() should be used.
+ *
+ * The signature of this procedure is meant to allow the calling function,
+ * (for instance, swap_writepage()) to pass an array @folios
+ * (the "reclaim batch") of @nr_folios folios to be stored in zswap.
+ * All folios in the batch must have the same swap type and folio_nid @node_id
+ * (simplifying assumptions only to manage code complexity).
+ *
+ * @errors and @folios have @nr_folios number of entries, with one-one
+ * correspondence (@errors[i] represents the error status of @folios[i],
+ * for i in @nr_folios).
+ * The calling function (for instance, swap_writepage()) should initialize
+ * @errors[i] to a non-0 value.
+ * If zswap successfully stores @folios[i], it will set @errors[i] to 0.
+ * If there is an error in zswap, it will set @errors[i] to -EINVAL.
+ */
+static void __zswap_store_batch_core(
+	int node_id,
+	struct folio **folios,
+	int *errors,
+	unsigned int nr_folios)
+{
+	struct zswap_store_sub_batch_page sub_batch[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct page *comp_pages[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	u8 *comp_dsts[SWAP_CRYPTO_SUB_BATCH_SIZE] = { NULL };
+	unsigned int comp_dlens[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	int comp_errors[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct crypto_acomp_ctx *acomp_ctx;
+	struct zswap_pool *pool;
+	/*
+	 * For now, lets say a max of 256 large folios can be reclaimed
+	 * at a time, as a batch. If this exceeds 256, change this to u16.
+	 */
+	u8 batch_idx;
+
+	/* Initialize the compress batching pipeline state. */
+	struct zswap_store_pipeline_state zst = {
+		.errors = errors,
+		.pool = NULL,
+		.acomp_ctx = NULL,
+		.sub_batch = sub_batch,
+		.comp_pages = comp_pages,
+		.comp_dsts = comp_dsts,
+		.comp_dlens = comp_dlens,
+		.comp_errors = comp_errors,
+		.nr_comp_pages = 0,
+	};
+
+	pool = zswap_pool_current_get();
+	if (!pool) {
+		if (zswap_check_limits())
+			queue_work(shrink_wq, &zswap_shrink_work);
+		goto check_old;
+	}
+
+	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
+	mutex_lock(&acomp_ctx->mutex);
+	zst.pool = pool;
+	zst.acomp_ctx = acomp_ctx;
+
+	/*
+	 * Iterate over the folios passed in. Construct sub-batches of up to
+	 * SWAP_CRYPTO_SUB_BATCH_SIZE pages, if necessary, by iterating through
+	 * multiple folios from the input "folios". Process each sub-batch
+	 * with IAA batch compression. Detect errors from batch compression
+	 * and set the impacted folio's error status (this happens in
+	 * zswap_store_process_errors()).
+	 */
+	for (batch_idx = 0; batch_idx < nr_folios; ++batch_idx) {
+		struct folio *folio = folios[batch_idx];
+		BUG_ON(!folio);
+		long folio_start_idx, nr_pages = folio_nr_pages(folio);
+		struct zswap_entry *entries[SWAP_CRYPTO_SUB_BATCH_SIZE];
+		struct obj_cgroup *objcg = NULL;
+		struct mem_cgroup *memcg = NULL;
+
+		VM_WARN_ON_ONCE(!folio_test_locked(folio));
+		VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
+
+		/*
+		 * If zswap is disabled, we must invalidate the possibly stale entry
+		 * which was previously stored at this offset. Otherwise, writeback
+		 * could overwrite the new data in the swapfile.
+		 */
+		if (!zswap_enabled)
+			continue;
+
+		/* Check cgroup limits */
+		objcg = get_obj_cgroup_from_folio(folio);
+		if (objcg && !obj_cgroup_may_zswap(objcg)) {
+			memcg = get_mem_cgroup_from_objcg(objcg);
+			if (shrink_memcg(memcg)) {
+				mem_cgroup_put(memcg);
+				goto put_objcg;
+			}
+			mem_cgroup_put(memcg);
+		}
+
+		if (zswap_check_limits())
+			goto put_objcg;
+
+		if (objcg) {
+			memcg = get_mem_cgroup_from_objcg(objcg);
+			if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
+				mem_cgroup_put(memcg);
+				goto put_objcg;
+			}
+			mem_cgroup_put(memcg);
+		}
+
+		/*
+		 * By default, set zswap status to "success" for use in
+		 * swap_writepage() when this returns. In case of errors,
+		 * a negative error number will over-write this when
+		 * zswap_store_process_errors() is called.
+		 */
+		errors[batch_idx] = 0;
+
+		folio_start_idx = 0;
+
+		while (nr_pages > 0) {
+			u8 add_nr_pages;
+
+			/*
+			 * If we have accumulated SWAP_CRYPTO_SUB_BATCH_SIZE
+			 * pages, process the sub-batch: it could contain pages
+			 * from multiple folios.
+			 */
+			if (zst.nr_comp_pages == SWAP_CRYPTO_SUB_BATCH_SIZE) {
+				zswap_store_sub_batch(&zst);
+				zswap_store_reset_sub_batch(&zst);
+				/*
+				 * Stop processing this folio if it had
+				 * compress errors.
+				 */
+				if (errors[batch_idx])
+					goto put_objcg;
+			}
+
+			add_nr_pages = min3((
+					(long)SWAP_CRYPTO_SUB_BATCH_SIZE -
+					(long)zst.nr_comp_pages),
+					nr_pages,
+					(long)SWAP_CRYPTO_SUB_BATCH_SIZE);
+
+			/*
+			 * Allocate zswap_entries for this sub-batch. If we
+			 * get errors while doing so, we can flag an error
+			 * for the folio, call the shrinker and move on.
+			 */
+			if (zswap_alloc_entries(add_nr_pages,
+						entries, node_id)) {
+				zswap_store_reset_sub_batch(&zst);
+				errors[batch_idx] = -EINVAL;
+				goto put_objcg;
+			}
+
+			zswap_add_folio_pages_to_sb(
+				&zst,
+				folio,
+				batch_idx,
+				objcg,
+				entries,
+				folio_start_idx,
+				add_nr_pages);
+
+			nr_pages -= add_nr_pages;
+			folio_start_idx += add_nr_pages;
+		} /* this folio has pages to be compressed. */
+
+		obj_cgroup_put(objcg);
+		continue;
+
+put_objcg:
+		obj_cgroup_put(objcg);
+		if (zswap_pool_reached_full)
+			queue_work(shrink_wq, &zswap_shrink_work);
+	} /* for batch folios */
+
+	if (!zswap_enabled)
+		goto check_old;
+
+	/*
+	 * Process last sub-batch: it could contain pages from
+	 * multiple folios.
+	 */
+	if (zst.nr_comp_pages)
+		zswap_store_sub_batch(&zst);
+
+	mutex_unlock(&acomp_ctx->mutex);
+	zswap_pool_put(pool);
+check_old:
+	zswap_store_process_folio_errors(folios, errors, nr_folios);
+}
+
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
-- 
2.27.0


