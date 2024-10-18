Return-Path: <linux-fsdevel+bounces-32322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF559A35D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35DF1F2799F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F1192585;
	Fri, 18 Oct 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+hJXlnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D419066E;
	Fri, 18 Oct 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233676; cv=none; b=Bvfhpd6N5nPi4qtsS2gbSzXblPUPSOo3rOHkX4vFVcxe06y48mCSwlZJCmuqLouDNx9lK+mI2D145SZt+3n8u7ePeQR32TACHvFIvlWyDwv1wtZ9IGDx8cgwXpzJ9BNAElsvt2owZliw3CJoN7Xs6Y+3BAMVIjjnCprvrJHW+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233676; c=relaxed/simple;
	bh=BuyLq29pHWHuKPa34/0++cLrRWSOS8zwsGjaE7bn5mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hX86a9zDI5G0nsRoip2W3aAyVfpAOqzLKDikZAMgVIS6swBmqa9VxoOfRvoYa0sf70fRMGRGwWYZmERSzmzO3YvNfvXs5QTpOqLLa5CT445RaleSiGTUY5LQ6FgescdhlbwiK61EhF2dsKn/R6+aXVKLa8k+yW405/punBjzuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+hJXlnL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233673; x=1760769673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuyLq29pHWHuKPa34/0++cLrRWSOS8zwsGjaE7bn5mU=;
  b=Q+hJXlnLOCSBZOxUbOiiSNPNGieH/yDSUh4XVgsNCoz0WKXr5YVWAjwD
   HupOSg0Ko8qdp2cy2GwOmohAnOCgFLBC95GUgrPX8WVMZ4Gyie2i0eYm6
   HPWZI98J/xcS9lBaEq/VxPU+CrYjLl4Em7/3WkeWUu0MQqiv246AFnTgv
   Aqs2yG+z+SIK025zElBYeRNtUCnu3jR9mXPfW8zOdkM2sqb9svwwX33T2
   62MfZqNQhNxXVHWdqEP9vdlB3GjbxR49ReWq2+6gdGR6pbYYJpXiAa+yo
   eJcvZcZu+UsOI7jzn+w2/yVE4CZNlGxVU93gzkb+b+4s7DoZMcDVKlReZ
   w==;
X-CSE-ConnectionGUID: cpyqjOrlSgaJ5KLkLcILKA==
X-CSE-MsgGUID: G2SQlbTpSJCpRd2PW/lVBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884977"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:05 -0700
X-CSE-ConnectionGUID: SVTtz1sKTHaDZJhI1KvKbg==
X-CSE-MsgGUID: UQHOLBEfRj29Nglbp+9Wnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607542"
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
Subject: [RFC PATCH v1 13/13] mm: vmscan, swap, zswap: Compress batching of folios in shrink_folio_list().
Date: Thu, 17 Oct 2024 23:41:01 -0700
Message-Id: <20241018064101.336232-14-kanchana.p.sridhar@intel.com>
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

This patch enables the use of Intel IAA hardware compression acceleration
to reclaim a batch of folios in shrink_folio_list(). This results in
reclaim throughput and workload/sys performance improvements.

The earlier patches on compress batching deployed multiple IAA compress
engines for compressing up to SWAP_CRYPTO_SUB_BATCH_SIZE pages within a
large folio that is being stored in zswap_store(). This patch further
propagates the efficiency improvements demonstrated with IAA "batching
within folios", to vmscan "batching of folios" which will also use
batching within folios using the extensible architecture of
the __zswap_store_batch_core() procedure added earlier, that accepts
an array of folios.

A plug mechanism is introduced in swap_writepage() to aggregate a batch of
up to vm.compress-batchsize ([1, 32]) folios before processing the plug.
The plug will be processed if any of the following is true:

 1) The plug has vm.compress-batchsize folios. If the system has Intel IAA,
    "sysctl vm.compress-batchsize" can be configured to be in [1, 32]. On
    systems without IAA, or if CONFIG_ZSWAP_STORE_BATCHING_ENABLED is not
    set, "sysctl vm.compress-batchsize" can only be 1.
 2) A folio of a different swap type or folio_nid as the current folios in
    the plug, needs to be added to the plug.
 3) A pmd-mappable folio needs to be swapped out. In this case, the
    existing folios in the plug are processed. The pmd-mappable folio is
    swapped out (zswap_store() will batch compress
    SWAP_CRYPTO_SUB_BATCH_SIZE pages in the pmd-mappable folio if system
    has IAA) in a batch of its own.

From zswap's perspective, it now receives a hybrid batch of any-order
(non-pmd-mappable) folios when the plug is processed via
zswap_store_batch() that calls __zswap_store_batch_core(). This makes sure
that the zswap compress batching pipeline occupancy and reclaim throughput
are maximized.

The shrink_folio_list() interface with swap_writepage() is modified to
work with the plug mechanism. When shrink_folio_list() calls pageout(), it
needs to handle new return codes from pageout(), namely, PAGE_BATCHED and
PAGE_BATCH_SUCCESS:

PAGE_BATCHED:
  The page is not yet swapped out, so we need to wait for the "imc_plug"
  batch to be processed, before running the post-pageout computes in
  shrink_folio_list().

PAGE_BATCH_SUCCESS:
  When the "imc_plug" is processed in swap_writepage(), a newly added
  status "AOP_PAGE_BATCH_SUCCESS" is returned to pageout(), which in turn
  returns PAGE_BATCH_SUCCESS to shrink_folio_list().

Upon receiving PAGE_BATCH_SUCCESS from pageout(), shrink_folio_list() must
now serialize and run the post-pageout computes for all the folios in
"imc_plug". To summarize this approach, this patch introduces a plug in
reclaim that aggregates a batch of folios, parallelizes the zswap store of
the folios using IAA hardware acceleration, then returns to run the
serialized flow after the "batch pageout".

The patch attempts to do this with some minimal/necessary amount of code
duplication and by addition of an iteration through the "imc_plug" folios
in shrink_folio_list(). I have validated this extensively, and not seen any
issues. I would appreciate suggestions to improve upon this approach.

Submitting this functionality as a single distinct patch in the RFC
patch-series because all the changes in this specific patch are for
shrink_folio_list() batching; they wouldn't make sense without the
functionality in this patch. Besides the functionality itself, I would also
appreciate comments on whether the patch needs to be organized
differently.

Thanks Ying Huang for suggesting ideas on simplifying the vmscan interface
to the swap_writepage() plug mechanism.

Suggested-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/fs.h        |   2 +
 include/linux/mm.h        |   8 ++
 include/linux/writeback.h |   5 ++
 include/linux/zswap.h     |  16 ++++
 kernel/sysctl.c           |   9 +++
 mm/page_io.c              | 152 ++++++++++++++++++++++++++++++++++++-
 mm/swap.c                 |  15 ++++
 mm/swap.h                 |  40 ++++++++++
 mm/vmscan.c               | 154 +++++++++++++++++++++++++++++++-------
 mm/zswap.c                |  20 +++++
 10 files changed, 394 insertions(+), 27 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..2868925568a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -303,6 +303,8 @@ struct iattr {
 enum positive_aop_returns {
 	AOP_WRITEPAGE_ACTIVATE	= 0x80000,
 	AOP_TRUNCATED_PAGE	= 0x80001,
+	AOP_PAGE_BATCHED	= 0x80002,
+	AOP_PAGE_BATCH_SUCCESS	= 0x80003,
 };
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4c32003c8404..a8035e163793 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -80,6 +80,14 @@ extern void * high_memory;
 extern int page_cluster;
 extern const int page_cluster_max;
 
+/*
+ * Compress batching of any-order folios in the reclaim path with IAA.
+ * The number of folios to batch reclaim can be set through
+ * "sysctl vm.compress-batchsize" which can be a value in [1, 32].
+ */
+extern int compress_batchsize;
+extern const int compress_batchsize_max;
+
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
 #else
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d6db822e4bb3..41629ea5699d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -82,6 +82,11 @@ struct writeback_control {
 	/* Target list for splitting a large folio */
 	struct list_head *list;
 
+	/*
+	 * Plug for storing reclaim folios for compress batching.
+	 */
+	struct swap_in_memory_cache_cb *swap_in_memory_cache_plug;
+
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
 	pgoff_t index;
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 9bbe330686f6..328a1e09d502 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -11,6 +11,8 @@ extern atomic_long_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
 
+struct swap_in_memory_cache_cb;
+
 struct zswap_lruvec_state {
 	/*
 	 * Number of swapped in pages from disk, i.e not found in the zswap pool.
@@ -107,6 +109,15 @@ struct zswap_store_pipeline_state {
 };
 
 bool zswap_store_batching_enabled(void);
+void __zswap_store_batch(struct swap_in_memory_cache_cb *simc);
+void __zswap_store_batch_single(struct swap_in_memory_cache_cb *simc);
+static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
+{
+	if (zswap_store_batching_enabled())
+		__zswap_store_batch(simc);
+	else
+		__zswap_store_batch_single(simc);
+}
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
@@ -123,12 +134,17 @@ bool zswap_never_enabled(void);
 struct zswap_lruvec_state {};
 struct zswap_store_sub_batch_page {};
 struct zswap_store_pipeline_state {};
+struct swap_in_memory_cache_cb;
 
 static inline bool zswap_store_batching_enabled(void)
 {
 	return false;
 }
 
+static inline void zswap_store_batch(struct swap_in_memory_cache_cb *simc)
+{
+}
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..b8d6b599e9ae 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2064,6 +2064,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= (void *)&page_cluster_max,
 	},
+	{
+		.procname	= "compress-batchsize",
+		.data		= &compress_batchsize,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= (void *)&compress_batchsize_max,
+	},
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
diff --git a/mm/page_io.c b/mm/page_io.c
index a28d28b6b3ce..065db25309b8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,6 +226,131 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
+/*
+ * For batching of folios in reclaim path for zswap batch compressions
+ * with Intel IAA.
+ */
+static void simc_write_in_memory_cache_complete(
+	struct swap_in_memory_cache_cb *simc,
+	struct writeback_control *wbc)
+{
+	int i;
+
+	/* All elements of a plug write batch have the same swap type. */
+	struct swap_info_struct *sis = swp_swap_info(simc->folios[0]->swap);
+
+	VM_BUG_ON(!sis);
+
+	for (i = 0; i < simc->nr_folios; ++i) {
+		struct folio *folio = simc->folios[i];
+
+		if (!simc->errors[i]) {
+			count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
+			folio_unlock(folio);
+		} else {
+			__swap_writepage(simc->folios[i], wbc);
+		}
+	}
+}
+
+void swap_write_in_memory_cache_unplug(struct swap_in_memory_cache_cb *simc,
+				       struct writeback_control *wbc)
+{
+	unsigned long pflags;
+
+	psi_memstall_enter(&pflags);
+
+	zswap_store_batch(simc);
+
+	simc_write_in_memory_cache_complete(simc, wbc);
+
+	psi_memstall_leave(&pflags);
+
+	simc->processed = true;
+}
+
+/*
+ * Only called by swap_writepage() if (wbc && wbc->swap_in_memory_cache_plug)
+ * is true i.e., from shrink_folio_list()->pageout() path.
+ */
+static bool swap_writepage_in_memory_cache(struct folio *folio,
+					   struct writeback_control *wbc)
+{
+	struct swap_in_memory_cache_cb *simc;
+	unsigned type = swp_type(folio->swap);
+	int node_id = folio_nid(folio);
+	int comp_batch_size = READ_ONCE(compress_batchsize);
+	bool ret = false;
+
+	simc = wbc->swap_in_memory_cache_plug;
+
+	if ((simc->nr_folios > 0) &&
+			((simc->type != type) || (simc->node_id != node_id) ||
+			folio_test_pmd_mappable(folio) ||
+			(simc->nr_folios == comp_batch_size))) {
+		swap_write_in_memory_cache_unplug(simc, wbc);
+		ret = true;
+		simc->next_batch_folio = folio;
+	} else {
+		simc->type = type;
+		simc->node_id = node_id;
+		simc->folios[simc->nr_folios] = folio;
+
+		/*
+		 * If zswap successfully stores a page, it should set
+		 * simc->errors[] to 0.
+		 */
+		simc->errors[simc->nr_folios] = -1;
+		simc->nr_folios++;
+	}
+
+	return ret;
+}
+
+void swap_writepage_in_memory_cache_transition(void *arg)
+{
+	struct swap_in_memory_cache_cb *simc =
+		(struct swap_in_memory_cache_cb *) arg;
+	simc->nr_folios = 0;
+	simc->processed = false;
+
+	if (simc->next_batch_folio) {
+		struct folio *folio = simc->next_batch_folio;
+		simc->folios[simc->nr_folios] = folio;
+		simc->type = swp_type(folio->swap);
+		simc->node_id = folio_nid(folio);
+		simc->next_batch_folio = NULL;
+
+		/*
+		 * If zswap successfully stores a page, it should set
+		 * simc->errors[] to 0.
+		 */
+		simc->errors[simc->nr_folios] = -1;
+		simc->nr_folios++;
+	}
+}
+
+void swap_writepage_in_memory_cache_init(void *arg)
+{
+	struct swap_in_memory_cache_cb *simc =
+		(struct swap_in_memory_cache_cb *) arg;
+
+	simc->nr_folios = 0;
+	simc->processed = false;
+	simc->next_batch_folio = NULL;
+	simc->transition = &swap_writepage_in_memory_cache_transition;
+}
+
+/*
+ * zswap batching of folios with IAA:
+ *
+ * Reclaim batching note for pmd-mappable folios:
+ * Any pmd-mappable folio in the reclaim path will be processed in a batch
+ * comprising only that folio. There will be no mixed batches containing
+ * pmd-mappable folios for batch compression with IAA.
+ * There are no restrictions with other large folios: a reclaim batch
+ * can comprise of any-order mix of non-pmd-mappable folios.
+ */
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -268,7 +393,32 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		 */
 		swap_zeromap_folio_clear(folio);
 	}
-	if (zswap_store(folio)) {
+
+	/*
+	 * Batching of compressions with IAA: If reclaim path pageout has
+	 * invoked swap_writepage with a wbc->swap_in_memory_cache_plug,
+	 * add the page to the plug, or invoke zswap_store_batch() if
+	 * "vm.compress-batchsize" elements have been stored in
+	 * the plug.
+	 *
+	 * If swap_writepage has been called from other kernel code without
+	 * a wbc->swap_in_memory_cache_plug, call zswap_store() with the folio
+	 * (i.e. without adding the folio to a plug for batch processing).
+	 */
+	if (wbc && wbc->swap_in_memory_cache_plug) {
+		if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio)) &&
+			!zswap_is_enabled() &&
+			folio_memcg(folio) &&
+			!READ_ONCE(folio_memcg(folio)->zswap_writeback)) {
+			folio_mark_dirty(folio);
+			return AOP_WRITEPAGE_ACTIVATE;
+		}
+
+		if (swap_writepage_in_memory_cache(folio, wbc))
+			return AOP_PAGE_BATCH_SUCCESS;
+		else
+			return AOP_PAGE_BATCHED;
+	} else if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		folio_unlock(folio);
 		return 0;
diff --git a/mm/swap.c b/mm/swap.c
index 835bdf324b76..095630d6c35e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -38,6 +38,7 @@
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
 
+#include "swap.h"
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -47,6 +48,14 @@
 int page_cluster;
 const int page_cluster_max = 31;
 
+/*
+ * Number of pages in a reclaim batch for pageout.
+ * If zswap is enabled, this is the batch-size for zswap
+ * compress batching of multiple any-order folios.
+ */
+int compress_batchsize;
+const int compress_batchsize_max = SWAP_CRYPTO_MAX_COMP_BATCH_SIZE;
+
 struct cpu_fbatches {
 	/*
 	 * The following folio batches are grouped together because they are protected
@@ -1105,4 +1114,10 @@ void __init swap_setup(void)
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
+
+	/*
+	 * Initialize the number of pages in a reclaim batch
+	 * for pageout.
+	 */
+	compress_batchsize = 1;
 }
diff --git a/mm/swap.h b/mm/swap.h
index 4dcb67e2cc33..08c04954304f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -20,6 +20,13 @@ struct mempolicy;
 #define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
 #endif
 
+/* Set the vm.compress-batchsize limits. */
+#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED)
+#define SWAP_CRYPTO_MAX_COMP_BATCH_SIZE SWAP_CLUSTER_MAX
+#else
+#define SWAP_CRYPTO_MAX_COMP_BATCH_SIZE 1UL
+#endif
+
 /* linux/mm/swap_state.c, zswap.c */
 struct crypto_acomp_ctx {
 	struct crypto_acomp *acomp;
@@ -53,6 +60,20 @@ void swap_crypto_acomp_compress_batch(
 	int nr_pages,
 	struct crypto_acomp_ctx *acomp_ctx);
 
+/* linux/mm/vmscan.c, linux/mm/page_io.c, linux/mm/zswap.c */
+/* For batching of compressions in reclaim path. */
+struct swap_in_memory_cache_cb {
+	unsigned int type;
+	int node_id;
+	struct folio *folios[SWAP_CLUSTER_MAX];
+	int errors[SWAP_CLUSTER_MAX];
+	unsigned int nr_folios;
+	bool processed;
+	struct folio *next_batch_folio;
+	void (*transition)(void *);
+	void (*init)(void *);
+};
+
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -63,6 +84,10 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 	if (unlikely(plug))
 		__swap_read_unplug(plug);
 }
+void swap_writepage_in_memory_cache_init(void *arg);
+void swap_writepage_in_memory_cache_transition(void *arg);
+void swap_write_in_memory_cache_unplug(struct swap_in_memory_cache_cb *simc,
+				       struct writeback_control *wbc);
 void swap_write_unplug(struct swap_iocb *sio);
 int swap_writepage(struct page *page, struct writeback_control *wbc);
 void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
@@ -164,6 +189,21 @@ static inline void swap_crypto_acomp_compress_batch(
 {
 }
 
+struct swap_in_memory_cache_cb {};
+static void swap_writepage_in_memory_cache_init(void *arg)
+{
+}
+
+static void swap_writepage_in_memory_cache_transition(void *arg)
+{
+}
+
+static inline void swap_write_in_memory_cache_unplug(
+	struct swap_in_memory_cache_cb *simc,
+	struct writeback_control *wbc)
+{
+}
+
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fd3908d43b07..145e6cde78cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -619,6 +619,13 @@ typedef enum {
 	PAGE_ACTIVATE,
 	/* folio has been sent to the disk successfully, folio is unlocked */
 	PAGE_SUCCESS,
+	/*
+	 * reclaim folio batch has been sent to swap successfully,
+	 * folios are unlocked
+	 */
+	PAGE_BATCH_SUCCESS,
+	/* folio has been added to the reclaim batch. */
+	PAGE_BATCHED,
 	/* folio is clean and locked */
 	PAGE_CLEAN,
 } pageout_t;
@@ -628,7 +635,8 @@ typedef enum {
  * Calls ->writepage().
  */
 static pageout_t pageout(struct folio *folio, struct address_space *mapping,
-			 struct swap_iocb **plug, struct list_head *folio_list)
+			 struct swap_iocb **plug, struct list_head *folio_list,
+			 struct swap_in_memory_cache_cb *imc_plug)
 {
 	/*
 	 * If the folio is dirty, only perform writeback if that write
@@ -674,6 +682,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			.range_end = LLONG_MAX,
 			.for_reclaim = 1,
 			.swap_plug = plug,
+			.swap_in_memory_cache_plug = imc_plug,
 		};
 
 		/*
@@ -693,6 +702,23 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			return PAGE_ACTIVATE;
 		}
 
+		if (res == AOP_PAGE_BATCHED)
+			return PAGE_BATCHED;
+
+		if (res == AOP_PAGE_BATCH_SUCCESS) {
+			int r;
+			for (r = 0; r < imc_plug->nr_folios; ++r) {
+				struct folio *rfolio = imc_plug->folios[r];
+				if (!folio_test_writeback(rfolio)) {
+					/* synchronous write or broken a_ops? */
+					folio_clear_reclaim(rfolio);
+				}
+				trace_mm_vmscan_write_folio(rfolio);
+				node_stat_add_folio(rfolio, NR_VMSCAN_WRITE);
+			}
+			return PAGE_BATCH_SUCCESS;
+		}
+
 		if (!folio_test_writeback(folio)) {
 			/* synchronous write or broken a_ops? */
 			folio_clear_reclaim(folio);
@@ -1035,6 +1061,12 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 	return !data_race(folio_swap_flags(folio) & SWP_FS_OPS);
 }
 
+static __always_inline bool reclaim_batch_being_processed(
+	struct swap_in_memory_cache_cb *imc_plug)
+{
+	return imc_plug->nr_folios && imc_plug->processed;
+}
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -1049,22 +1081,54 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
+	struct swap_in_memory_cache_cb imc_plug;
+	bool imc_plug_path = false;
+	struct folio *folio;
+	int r;
 
+	imc_plug.init = &swap_writepage_in_memory_cache_init;
+	imc_plug.init(&imc_plug);
 	folio_batch_init(&free_folios);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
 
 retry:
-	while (!list_empty(folio_list)) {
+	while (!list_empty(folio_list) || (imc_plug.nr_folios && !imc_plug.processed)) {
 		struct address_space *mapping;
-		struct folio *folio;
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		imc_plug_path = false;
 
 		cond_resched();
 
+		/* Reclaim path zswap/zram batching using IAA. */
+		if (list_empty(folio_list)) {
+			struct writeback_control wbc = {
+				.sync_mode = WB_SYNC_NONE,
+				.nr_to_write = SWAP_CLUSTER_MAX,
+				.range_start = 0,
+				.range_end = LLONG_MAX,
+				.for_reclaim = 1,
+				.swap_plug = &plug,
+				.swap_in_memory_cache_plug = &imc_plug,
+			};
+
+			swap_write_in_memory_cache_unplug(&imc_plug, &wbc);
+
+			for (r = 0; r < imc_plug.nr_folios; ++r) {
+				struct folio *rfolio = imc_plug.folios[r];
+				if (!folio_test_writeback(rfolio)) {
+					/* synchronous write or broken a_ops? */
+					folio_clear_reclaim(rfolio);
+				}
+				trace_mm_vmscan_write_folio(rfolio);
+				node_stat_add_folio(rfolio, NR_VMSCAN_WRITE);
+			}
+			goto serialize_post_batch_pageout;
+		}
+
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 
@@ -1363,7 +1427,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(folio, mapping, &plug, folio_list)) {
+			switch (pageout(folio, mapping, &plug, folio_list, &imc_plug)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
@@ -1377,34 +1441,66 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					nr_pages = 1;
 				}
 				goto activate_locked;
+			case PAGE_BATCHED:
+				continue;
 			case PAGE_SUCCESS:
-				if (nr_pages > 1 && !folio_test_large(folio)) {
-					sc->nr_scanned -= (nr_pages - 1);
-					nr_pages = 1;
-				}
-				stat->nr_pageout += nr_pages;
-
-				if (folio_test_writeback(folio))
-					goto keep;
-				if (folio_test_dirty(folio))
-					goto keep;
-
-				/*
-				 * A synchronous write - probably a ramdisk.  Go
-				 * ahead and try to reclaim the folio.
-				 */
-				if (!folio_trylock(folio))
-					goto keep;
-				if (folio_test_dirty(folio) ||
-				    folio_test_writeback(folio))
-					goto keep_locked;
-				mapping = folio_mapping(folio);
-				fallthrough;
+				goto post_single_pageout;
+			case PAGE_BATCH_SUCCESS:
+				goto serialize_post_batch_pageout;
 			case PAGE_CLEAN:
+				goto folio_is_clean;
 				; /* try to free the folio below */
 			}
+		} else {
+			goto folio_is_clean;
+		}
+
+serialize_post_batch_pageout:
+		imc_plug_path = reclaim_batch_being_processed(&imc_plug);
+		if (!imc_plug_path) {
+			pr_err("imc_plug: type %u node_id %d \
+				nr_folios %u processed %d next_batch_folio %px",
+				imc_plug.type, imc_plug.node_id,
+				imc_plug.nr_folios, imc_plug.processed,
+				imc_plug.next_batch_folio);
+		}
+		BUG_ON(!imc_plug_path);
+		r = -1;
+
+next_folio_in_batch:
+		while (++r < imc_plug.nr_folios) {
+			folio = imc_plug.folios[r];
+			goto post_single_pageout;
+		} /* while imc_plug folios. */
+
+		imc_plug.transition(&imc_plug);
+		continue;
+
+post_single_pageout:
+		mapping = folio_mapping(folio);
+		nr_pages = folio_nr_pages(folio);
+		if (nr_pages > 1 && !folio_test_large(folio)) {
+			sc->nr_scanned -= (nr_pages - 1);
+			nr_pages = 1;
 		}
+		stat->nr_pageout += nr_pages;
+
+		if (folio_test_writeback(folio))
+			goto keep;
+		if (folio_test_dirty(folio))
+			goto keep;
+
+		/*
+		 * A synchronous write - probably a ramdisk.  Go
+		 * ahead and try to reclaim the folio.
+		 */
+		if (!folio_trylock(folio))
+			goto keep;
+		if (folio_test_dirty(folio) ||
+		    folio_test_writeback(folio))
+			goto keep_locked;
 
+folio_is_clean:
 		/*
 		 * If the folio has buffers, try to free the buffer
 		 * mappings associated with this folio. If we succeed
@@ -1444,6 +1540,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * leave it off the LRU).
 					 */
 					nr_reclaimed += nr_pages;
+					if (imc_plug_path)
+						goto next_folio_in_batch;
 					continue;
 				}
 			}
@@ -1481,6 +1579,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			try_to_unmap_flush();
 			free_unref_folios(&free_folios);
 		}
+		if (imc_plug_path)
+			goto next_folio_in_batch;
 		continue;
 
 activate_locked_split:
@@ -1510,6 +1610,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		list_add(&folio->lru, &ret_folios);
 		VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
 				folio_test_unevictable(folio), folio);
+		if (imc_plug_path)
+			goto next_folio_in_batch;
 	}
 	/* 'folio_list' is always empty here */
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 1c12a7b9f4ff..68ce498ad000 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1666,6 +1666,26 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
+/*
+ * The batch contains <= vm.compress-batchsize nr of folios.
+ * All folios in the batch have the same swap type and folio_nid.
+ */
+void __zswap_store_batch(struct swap_in_memory_cache_cb *simc)
+{
+	__zswap_store_batch_core(simc->node_id, simc->folios,
+				 simc->errors, simc->nr_folios);
+}
+
+void __zswap_store_batch_single(struct swap_in_memory_cache_cb *simc)
+{
+	u8 i;
+
+	for (i = 0; i < simc->nr_folios; ++i) {
+		if (zswap_store(simc->folios[i]))
+			simc->errors[i] = 0;
+	}
+}
+
 /*
  * Note: If SWAP_CRYPTO_SUB_BATCH_SIZE exceeds 256, change the
  * u8 stack variables in the next several functions, to u16.
-- 
2.27.0


