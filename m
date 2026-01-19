Return-Path: <linux-fsdevel+bounces-74372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5AD39EAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5530D3068DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0826E175;
	Mon, 19 Jan 2026 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJ4LI/pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08347242D9D;
	Mon, 19 Jan 2026 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804513; cv=none; b=at1pL4h61ek3BRsFa9elGcB4sxyyxKDEoZLm/tdPbbICkXoDQKQi3acI/U2dZLJ+1eSV3kB+vCRcCpWH1SqvfYo5ANj07YSttgPN1QeTYZrMti4mE0v5xUPIN3s/f3+i00XHpLeg+Hwt/YvW+nqurtWySPFTh/Vu5ffLKEb3FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804513; c=relaxed/simple;
	bh=a5abOE0XeFOEyTETIaxGrTOrOdiAfrb8kXNH975hzK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usd9bUDsK+waOQkzikHF1Uke2vcNrrcoBDAgeC6XfKMGe2mD5NmJB2enPAuhFfg2tEZIJByOAOpooNS2RCaG0+/UOUSPnZ77qeZGeV/36TsEvEXPaurUPyWAPRY9LN1ul9Jg5rTJkoaCz6kTjLoCFleha7chv9vZKzo6hzJnPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJ4LI/pq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768804511; x=1800340511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5abOE0XeFOEyTETIaxGrTOrOdiAfrb8kXNH975hzK0=;
  b=aJ4LI/pqLeDkyHjmuNLmfO/0FUR4gZFUw8pNdkx+ZtxgGbFz0NbrUq6H
   4o29EQfO39fvs1BTnQf+lLvGX6ChcdJFnRlFJkbaDfgclClEK7Mo+0s+G
   tNt7hgY8xigV86j6uFTWwoDnCMWNyPHpGE3YgPD853TbUX3HakyugT//g
   +OhQ/p8uOQsqtFQ5nZuuW0E23tn/0H9asDC071HKrG9pklsVComAKmvMn
   q+OE6cgtfH50HpCfcbjbj93dKsyn7GygYyd7ucy0qOCkGCkla70DqOEBn
   kjEosNvDkf4QcV6YOCa19/F2+cAAHCpSCS3oXSK88vFtXbhsZEVRDLdnh
   w==;
X-CSE-ConnectionGUID: K2ZJjvVESaCXYxTnSX41jA==
X-CSE-MsgGUID: JALRGpQyT4eQrmPe0KnpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="57565308"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="57565308"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 22:35:10 -0800
X-CSE-ConnectionGUID: qU3Bo5F6QBOFIpmXHdfW8A==
X-CSE-MsgGUID: GaYqelzQQTuu6lB6A6GdfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205824307"
Received: from linux-pnp-server-15.sh.intel.com ([10.239.177.153])
  by orviesa007.jf.intel.com with ESMTP; 18 Jan 2026 22:35:05 -0800
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
Subject: [PATCH 1/2] mm/filemap: refactor __filemap_add_folio to separate critical section
Date: Mon, 19 Jan 2026 14:50:24 +0800
Message-ID: <20260119065027.918085-2-zhiguo.zhou@intel.com>
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

This patch refactors __filemap_add_folio() to extract its core
critical section logic into a new helper function,
__filemap_add_folio_xa_locked(). The refactoring maintains the
existing functionality while enabling finer control over locking
granularity for callers.

Key changes:
- Move the xarray insertion logic from __filemap_add_folio() into
  __filemap_add_folio_xa_locked()
- Modify __filemap_add_folio() to accept a pre-initialized xa_state
  and a 'xa_locked' parameter
- Update the function signature in the header file accordingly
- Adjust existing callers (filemap_add_folio() and
  hugetlb_add_to_page_cache()) to use the new interface

The refactoring is functionally equivalent to the previous code:
- When 'xa_locked' is false, __filemap_add_folio() acquires the xarray
  lock internally (existing behavior)
- When 'xa_locked' is true, the caller is responsible for holding the
  xarray lock, and __filemap_add_folio() only executes the critical
  section

This separation prepares for the subsequent patch that introduces
batch folio insertion, where multiple folios can be added to the
page cache within a single lock hold.

No performance changes are expected from this patch alone, as it
only reorganizes code without altering the execution flow.

Reported-by: Gang Deng <gang.deng@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
---
 include/linux/pagemap.h |   2 +-
 mm/filemap.c            | 173 +++++++++++++++++++++++-----------------
 mm/hugetlb.c            |   3 +-
 3 files changed, 103 insertions(+), 75 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..59cbf57fb55b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1297,7 +1297,7 @@ loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 
 /* Must be non-static for BPF error injection */
 int __filemap_add_folio(struct address_space *mapping, struct folio *folio,
-		pgoff_t index, gfp_t gfp, void **shadowp);
+		struct xa_state *xas, gfp_t gfp, void **shadowp, bool xa_locked);
 
 bool filemap_range_has_writeback(struct address_space *mapping,
 				 loff_t start_byte, loff_t end_byte);
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..eb9e28e5cbd7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -845,95 +845,114 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
-noinline int __filemap_add_folio(struct address_space *mapping,
-		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
+/*
+ * The critical section for storing a folio in an XArray.
+ * Context: Expects xas->xa->xa_lock to be held.
+ */
+static void __filemap_add_folio_xa_locked(struct xa_state *xas,
+		struct address_space *mapping, struct folio *folio, void **shadowp)
 {
-	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
 	unsigned int forder = folio_order(folio);
+	int order = -1;
+	void *entry, *old = NULL;
 
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
-			folio);
-	mapping_set_update(&xas, mapping);
+	lockdep_assert_held(xas->xa->xa_lock);
 
-	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
-	gfp &= GFP_RECLAIM_MASK;
-	folio_ref_add(folio, nr);
-	folio->mapping = mapping;
-	folio->index = xas.xa_index;
-
-	for (;;) {
-		int order = -1;
-		void *entry, *old = NULL;
-
-		xas_lock_irq(&xas);
-		xas_for_each_conflict(&xas, entry) {
-			old = entry;
-			if (!xa_is_value(entry)) {
-				xas_set_err(&xas, -EEXIST);
-				goto unlock;
-			}
-			/*
-			 * If a larger entry exists,
-			 * it will be the first and only entry iterated.
-			 */
-			if (order == -1)
-				order = xas_get_order(&xas);
+	xas_for_each_conflict(xas, entry) {
+		old = entry;
+		if (!xa_is_value(entry)) {
+			xas_set_err(xas, -EEXIST);
+			return;
 		}
+		/*
+		 * If a larger entry exists,
+		 * it will be the first and only entry iterated.
+		 */
+		if (order == -1)
+			order = xas_get_order(xas);
+	}
 
-		if (old) {
-			if (order > 0 && order > forder) {
-				unsigned int split_order = max(forder,
-						xas_try_split_min_order(order));
-
-				/* How to handle large swap entries? */
-				BUG_ON(shmem_mapping(mapping));
-
-				while (order > forder) {
-					xas_set_order(&xas, index, split_order);
-					xas_try_split(&xas, old, order);
-					if (xas_error(&xas))
-						goto unlock;
-					order = split_order;
-					split_order =
-						max(xas_try_split_min_order(
-							    split_order),
-						    forder);
-				}
-				xas_reset(&xas);
+	if (old) {
+		if (order > 0 && order > forder) {
+			unsigned int split_order = max(forder,
+					xas_try_split_min_order(order));
+
+			/* How to handle large swap entries? */
+			BUG_ON(shmem_mapping(mapping));
+
+			while (order > forder) {
+				xas_set_order(xas, xas->xa_index, split_order);
+				xas_try_split(xas, old, order);
+				if (xas_error(xas))
+					return;
+				order = split_order;
+				split_order =
+					max(xas_try_split_min_order(
+						    split_order),
+					    forder);
 			}
-			if (shadowp)
-				*shadowp = old;
+			xas_reset(xas);
 		}
+		if (shadowp)
+			*shadowp = old;
+	}
 
-		xas_store(&xas, folio);
-		if (xas_error(&xas))
-			goto unlock;
+	xas_store(xas, folio);
+	if (xas_error(xas))
+		return;
 
-		mapping->nrpages += nr;
+	mapping->nrpages += nr;
 
-		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge) {
-			lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-			if (folio_test_pmd_mappable(folio))
-				lruvec_stat_mod_folio(folio,
-						NR_FILE_THPS, nr);
-		}
+	/* hugetlb pages do not participate in page cache accounting */
+	if (!huge) {
+		lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+		if (folio_test_pmd_mappable(folio))
+			lruvec_stat_mod_folio(folio,
+					NR_FILE_THPS, nr);
+	}
+}
 
-unlock:
-		xas_unlock_irq(&xas);
+noinline int __filemap_add_folio(struct address_space *mapping,
+				 struct folio *folio, struct xa_state *xas,
+				 gfp_t gfp, void **shadowp, bool xa_locked)
+{
+	long nr;
 
-		if (!xas_nomem(&xas, gfp))
-			break;
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
+	mapping_set_update(xas, mapping);
+
+	VM_BUG_ON_FOLIO(xas->xa_index & (folio_nr_pages(folio) - 1), folio);
+	nr = folio_nr_pages(folio);
+
+	gfp &= GFP_RECLAIM_MASK;
+	folio_ref_add(folio, nr);
+	folio->mapping = mapping;
+	folio->index = xas->xa_index;
+
+	if (xa_locked) {
+		lockdep_assert_held(xas->xa->xa_lock);
+		__filemap_add_folio_xa_locked(xas, mapping, folio, shadowp);
+	} else {
+		lockdep_assert_not_held(xas->xa->xa_lock);
+		for (;;) {
+			xas_lock_irq(xas);
+			__filemap_add_folio_xa_locked(xas, mapping, folio, shadowp);
+			xas_unlock_irq(xas);
+
+			if (!xas_nomem(xas, gfp))
+				break;
+		}
 	}
 
-	if (xas_error(&xas))
+	if (xas_error(xas))
 		goto error;
 
 	trace_mm_filemap_add_to_page_cache(folio);
@@ -942,12 +961,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation relies upon it */
 	folio_put_refs(folio, nr);
-	return xas_error(&xas);
+	return xas_error(xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-int filemap_add_folio(struct address_space *mapping, struct folio *folio,
-				pgoff_t index, gfp_t gfp)
+static int _filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				struct xa_state *xas, gfp_t gfp, bool xa_locked)
 {
 	void *shadow = NULL;
 	int ret;
@@ -963,7 +982,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		return ret;
 
 	__folio_set_locked(folio);
-	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
+	ret = __filemap_add_folio(mapping, folio, xas, gfp, &shadow, xa_locked);
 	if (unlikely(ret)) {
 		mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
@@ -987,6 +1006,14 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	}
 	return ret;
 }
+
+int filemap_add_folio(struct address_space *mapping, struct folio *folio,
+				pgoff_t index, gfp_t gfp)
+{
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
+
+	return _filemap_add_folio(mapping, folio, &xas, gfp, false);
+}
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 51273baec9e5..5c6c6b9e463f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5657,10 +5657,11 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
 	int err;
+	XA_STATE_ORDER(xas, &mapping->i_pages, idx, folio_order(folio));
 
 	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
-	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
+	err = __filemap_add_folio(mapping, folio, &xas, GFP_KERNEL, NULL, false);
 
 	if (unlikely(err)) {
 		__folio_clear_locked(folio);
-- 
2.43.0


