Return-Path: <linux-fsdevel+bounces-74373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B5D39EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B57F305220D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A900270552;
	Mon, 19 Jan 2026 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJCeMgow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD326E175;
	Mon, 19 Jan 2026 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804519; cv=none; b=T1YMN6izTLIUHzWGN8MR2lpWvcIWsXeFIm6D2/tAPK1VggYFR2zDGrdOH7RXD64ZgSb0mtFzPKiI6u7t7RIIBCRXwEX9HqLRO1yTQ+BaYQyc1osGwRkj3qn7bctcuAXbQmHXWL+v4CkRmHj+HdBwLYo2PVOADCOTIzu/NC6XHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804519; c=relaxed/simple;
	bh=2i4jwv95LJfSLU9N5oDj7KqmLz5Pp2tMLrjdxcGCIok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogu5AK3k7JBuLw+x/22Ry8iDNm3GJGIGlDF6g4pfPRx9oyzDtZtsMBHVHqG5MeSoimWOGfnSoOuf5KV8OZS3XjHEO/TtotNCgXfaKWUB3phDewXfaCgbvKPtlrf9+HNl8N5p2KnUmZu2SIXFMQkAZ2swtx6br37+pWA2I4hsBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJCeMgow; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768804517; x=1800340517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2i4jwv95LJfSLU9N5oDj7KqmLz5Pp2tMLrjdxcGCIok=;
  b=BJCeMgowQ80dEITXR20dr+mbLP0YL/tU84vL4s1/WawH/Wo0WAhT+YYS
   To88KlJBd+W6LEQZCDfcGPcTtw1a9IG0bSK9WB9X2D/qqfq5BOQyheRl5
   UeSpvxvy9hF4l0lZvKJ21XOUsV8L2T7rPQqKGMsv4QApqrErFy49GdByj
   U7nH/BjZRCaGQoChwj31QU0rNMfzK86Jt2slQTfQPZvPviMMzrnH7gAiT
   cFwN7a+stldUcSYE0qPV0+jOtfuUY1tKTBypIdYkCs1ERZIPHb8DmMhCb
   ovVL6OYTgiZ/L9HCWG/OKnn+dk0ey717gOmf7/w7BSNQWubyH8fJJ/opn
   A==;
X-CSE-ConnectionGUID: WJm4p1PjRaOHfQ9P+vfW9g==
X-CSE-MsgGUID: hPKI0YXCQ6aievAmZwJaXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="57565325"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="57565325"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 22:35:16 -0800
X-CSE-ConnectionGUID: lufysXv1SxWcJgRDDQu+dA==
X-CSE-MsgGUID: ACq/P8ebQ3SpyWE5eOcZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205824330"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by orviesa007.jf.intel.com with ESMTP; 18 Jan 2026 22:35:12 -0800
From: Zhiguo Zhou <zhiguo.zhou@intel.com>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: willy@infradead.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	gang.deng@intel.com,
	Zhiguo Zhou <zhiguo.zhou@intel.com>
Subject: [PATCH 2/2] mm/readahead: batch folio insertion to improve performance
Date: Mon, 19 Jan 2026 14:50:25 +0800
Message-ID: <20260119065027.918085-3-zhiguo.zhou@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119065027.918085-1-zhiguo.zhou@intel.com>
References: <20260119065027.918085-1-zhiguo.zhou@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `readahead` syscall is invocated, `page_cache_ra_unbounded` would
insert folios into the page cache (`xarray`) individually. The `xa_lock`
protected critical section could be scheduled across different cores,
the cost of cacheline transfer together with lock contention may
contribute significant part of execution time.

To optimize the performance of `readahead`, the folio insertions are
batched into a single critical section. This patch introduces
`filemap_add_folio_range()`, which allows inserting an array of folios
into a contiguous range of `xarray` while holding the lock only once.
`page_cache_ra_unbounded` is updated to pre-allocate folios
and use this new batching interface while keeping the original approach
when memory is under pressure.

The performance of RocksDB's `db_bench` for the `readseq` subcase [1]
was tested on a 32-vCPU instance [2], and the results show:
- Profiling shows the IPC of `page_cache_ra_unbounded` (excluding
  `raw_spin_lock_irq` overhead) improved by 2.18x.
- Throughput (ops/sec) improved by 1.51x.
- Latency reduced significantly: P50 by 63.9%, P75 by 42.1%, P99 by
31.4%.

+------------+------------------+-----------------+-----------+
| Percentile | Latency (before) | Latency (after) | Reduction |
+------------+------------------+-----------------+-----------+
| P50        | 6.15 usec        | 2.22 usec       | 63.92%    |
| P75        | 13.38 usec       | 7.75 usec       | 42.09%    |
| P99        | 507.95 usec      | 348.54 usec     | 31.38%    |
+------------+------------------+-----------------+-----------+

[1] Command to launch the test
./db_bench --benchmarks=readseq,stats --use_existing_db=1
--num_multi_db=32 --threads=32 --num=1600000 --value_size=8192
--cache_size=16GB

[2] Hardware: Intel Ice Lake server
    Kernel  : v6.19-rc5
    Memory  : 256GB

Reported-by: Gang Deng <gang.deng@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
---
 include/linux/pagemap.h |   2 +
 mm/filemap.c            |  65 +++++++++++++
 mm/readahead.c          | 196 +++++++++++++++++++++++++++++++---------
 3 files changed, 222 insertions(+), 41 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 59cbf57fb55b..62cb90471372 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1286,6 +1286,8 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
+long filemap_add_folio_range(struct address_space *mapping, struct folio **folios,
+		pgoff_t start, pgoff_t end, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
 void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_folio(struct folio *old, struct folio *new);
diff --git a/mm/filemap.c b/mm/filemap.c
index eb9e28e5cbd7..d0d79599c7fa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1016,6 +1016,71 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
+/**
+ * filemap_add_folio_range - add folios to the page range [start, end) of filemap.
+ * @mapping:	The address space structure to add folios to.
+ * @folios:	The array of folios to add to page cache.
+ * @start:	The starting page cache index.
+ * @end:	The ending page cache index (exclusive).
+ * @gfp:	The memory allocator flags to use.
+ *
+ * This function adds folios to mapping->i_pages with contiguous indices.
+ *
+ * If an entry for an index in the range [start, end) already exists, a folio is
+ * invalid, or _filemap_add_folio fails, this function aborts. All folios up
+ * to the point of failure will have been inserted, the rest are left uninserted.
+ *
+ * Return: If the pages are partially or fully added to the page cache, the number
+ * of pages (instead of folios) is returned. Elsewise, if no pages are inserted,
+ * the error number is returned.
+ */
+long filemap_add_folio_range(struct address_space *mapping, struct folio **folios,
+			     pgoff_t start, pgoff_t end, gfp_t gfp)
+{
+	int ret;
+	XA_STATE_ORDER(xas, &mapping->i_pages, start, mapping_min_folio_order(mapping));
+	unsigned long min_nrpages = mapping_min_folio_nrpages(mapping);
+
+	do {
+		xas_lock_irq(&xas);
+
+		while (xas.xa_index < end) {
+			unsigned long index = (xas.xa_index - start) / min_nrpages;
+			struct folio *folio;
+
+			folio = xas_load(&xas);
+			if (folio && !xa_is_value(folio)) {
+				ret = -EEXIST;
+				break;
+			}
+
+			folio = folios[index];
+			if (!folio) {
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = _filemap_add_folio(mapping, folio, &xas, gfp, true);
+
+			if (unlikely(ret))
+				break;
+
+			/*
+			 * On successful insertion, the folio's array entry is set to NULL.
+			 * The caller is responsible for reclaiming any uninserted folios.
+			 */
+			folios[index] = NULL;
+			for (unsigned int i = 0; i < min_nrpages; i++)
+				xas_next(&xas);
+		}
+
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp & GFP_RECLAIM_MASK));
+
+	return xas.xa_index > start ? (long) xas.xa_index - start : ret;
+}
+EXPORT_SYMBOL_GPL(filemap_add_folio_range);
+
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *policy)
diff --git a/mm/readahead.c b/mm/readahead.c
index b415c9969176..4fe87b467d61 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -193,6 +193,149 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 	return folio;
 }
 
+static void ractl_free_folios(struct folio **folios, unsigned long folio_count)
+{
+	unsigned long i;
+
+	if (!folios)
+		return;
+
+	for (i = 0; i < folio_count; ++i) {
+		if (folios[i])
+			folio_put(folios[i]);
+	}
+	kvfree(folios);
+}
+
+static struct folio **ractl_alloc_folios(struct readahead_control *ractl,
+					 gfp_t gfp_mask, unsigned int order,
+					 unsigned long folio_count)
+{
+	struct folio **folios;
+	unsigned long i;
+
+	folios = kvcalloc(folio_count, sizeof(struct folio *), GFP_KERNEL);
+
+	if (!folios)
+		return NULL;
+
+	for (i = 0; i < folio_count; ++i) {
+		struct folio *folio = ractl_alloc_folio(ractl, gfp_mask, order);
+
+		if (!folio)
+			break;
+		folios[i] = folio;
+	}
+
+	if (i != folio_count) {
+		ractl_free_folios(folios, i);
+		i = 0;
+		folios = NULL;
+	}
+
+	return folios;
+}
+
+static void ra_fill_folios_batched(struct readahead_control *ractl,
+				   struct folio **folios, unsigned long nr_to_read,
+				   unsigned long start_index, unsigned long mark,
+				   gfp_t gfp_mask)
+{
+	struct address_space *mapping = ractl->mapping;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned long added_folios = 0;
+	unsigned long i = 0;
+
+	while (i < nr_to_read) {
+		long ret;
+		unsigned long added_nrpages;
+
+		ret = filemap_add_folio_range(mapping, folios + added_folios,
+					      start_index + i,
+					      start_index + nr_to_read,
+					      gfp_mask);
+
+		if (unlikely(ret < 0)) {
+			if (ret == -ENOMEM)
+				break;
+			read_pages(ractl);
+			ractl->_index += min_nrpages;
+			i = ractl->_index + ractl->_nr_pages - start_index;
+			continue;
+		}
+
+		if (unlikely(ret == 0))
+			break;
+
+		added_nrpages = ret;
+		/*
+		 * `added_nrpages` is multiple of min_nrpages.
+		 */
+		added_folios += added_nrpages / min_nrpages;
+
+		if (i <= mark && mark < i + added_nrpages)
+			folio_set_readahead(xa_load(&mapping->i_pages,
+						    start_index + mark));
+		for (unsigned long j = i; j < i + added_nrpages; j += min_nrpages)
+			ractl->_workingset |= folio_test_workingset(xa_load(&mapping->i_pages,
+									    start_index + j));
+		ractl->_nr_pages += added_nrpages;
+
+		i += added_nrpages;
+	}
+}
+
+static void ra_fill_folios_single(struct readahead_control *ractl,
+				  unsigned long nr_to_read,
+				  unsigned long start_index, unsigned long mark,
+				  gfp_t gfp_mask)
+{
+	struct address_space *mapping = ractl->mapping;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned long i = 0;
+
+	while (i < nr_to_read) {
+		struct folio *folio = xa_load(&mapping->i_pages, start_index + i);
+		int ret;
+
+		if (folio && !xa_is_value(folio)) {
+			/*
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.  This page may be the one we would
+			 * have intended to mark as Readahead, but we don't
+			 * have a stable reference to this page, and it's
+			 * not worth getting one just for that.
+			 */
+			read_pages(ractl);
+			ractl->_index += min_nrpages;
+			i = ractl->_index + ractl->_nr_pages - start_index;
+			continue;
+		}
+
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					  mapping_min_folio_order(mapping));
+		if (!folio)
+			break;
+
+		ret = filemap_add_folio(mapping, folio, start_index + i, gfp_mask);
+		if (ret < 0) {
+			folio_put(folio);
+			if (ret == -ENOMEM)
+				break;
+			read_pages(ractl);
+			ractl->_index += min_nrpages;
+			i = ractl->_index + ractl->_nr_pages - start_index;
+			continue;
+		}
+		if (i == mark)
+			folio_set_readahead(folio);
+		ractl->_workingset |= folio_test_workingset(folio);
+		ractl->_nr_pages += min_nrpages;
+		i += min_nrpages;
+	}
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -213,8 +356,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long mark = ULONG_MAX, i = 0;
+	unsigned long mark = ULONG_MAX;
 	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	struct folio **folios = NULL;
+	unsigned long alloc_folios = 0;
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -249,49 +394,18 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	}
 	nr_to_read += readahead_index(ractl) - index;
 	ractl->_index = index;
-
+	alloc_folios = DIV_ROUND_UP(nr_to_read, min_nrpages);
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
-	while (i < nr_to_read) {
-		struct folio *folio = xa_load(&mapping->i_pages, index + i);
-		int ret;
-
-		if (folio && !xa_is_value(folio)) {
-			/*
-			 * Page already present?  Kick off the current batch
-			 * of contiguous pages before continuing with the
-			 * next batch.  This page may be the one we would
-			 * have intended to mark as Readahead, but we don't
-			 * have a stable reference to this page, and it's
-			 * not worth getting one just for that.
-			 */
-			read_pages(ractl);
-			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
-			continue;
-		}
-
-		folio = ractl_alloc_folio(ractl, gfp_mask,
-					mapping_min_folio_order(mapping));
-		if (!folio)
-			break;
-
-		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
-		if (ret < 0) {
-			folio_put(folio);
-			if (ret == -ENOMEM)
-				break;
-			read_pages(ractl);
-			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
-			continue;
-		}
-		if (i == mark)
-			folio_set_readahead(folio);
-		ractl->_workingset |= folio_test_workingset(folio);
-		ractl->_nr_pages += min_nrpages;
-		i += min_nrpages;
+	folios = ractl_alloc_folios(ractl, gfp_mask,
+				    mapping_min_folio_order(mapping),
+				    alloc_folios);
+	if (folios) {
+		ra_fill_folios_batched(ractl, folios, nr_to_read, index, mark, gfp_mask);
+		ractl_free_folios(folios, alloc_folios);
+	} else {
+		ra_fill_folios_single(ractl, nr_to_read, index, mark, gfp_mask);
 	}
 
 	/*
-- 
2.43.0


