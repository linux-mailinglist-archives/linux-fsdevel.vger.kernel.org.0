Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51515BA578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIPDiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIPDhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:37:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819D9E0DB;
        Thu, 15 Sep 2022 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299419; x=1694835419;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shTt/uNd4pi9Ct2gNVWBBoQz77p4cEL4DPuvM6dkcww=;
  b=fVQpPTu6xRLB42XdMaWSav7NeKLffvWUAZ8CUH2aLg/bE+b4nHB9vb6C
   Z/9CmzWRiAwjeb0Fztk4c8jdcSTwnsY6yJFhThGBFRUwDyLljH/BvHjKP
   U0BlysFLx91tAoYJoxZ4wvpy7OWlIZQzMnVUkBf/4Wx1dqlIgGfNY7j4f
   UBdOyYzZeqZRhl8gRNYSOpDwpBxHYF/8WCvYgWT3tNS5FJ8SgIh9WdQM1
   Iv6HSxfQ0oDWL/ZAql2pyzqp4+clnzrCMtDyTmIIGC1L7PGLevyEdCKfB
   HEUJPyiT3uAbVLDzusBoTWqYS9Ck3FKU4dKCub1lDiB/vMnzl5BVP0kaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360643403"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="360643403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="743194587"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:56 -0700
Subject: [PATCH v2 18/18] mm/gup: Drop DAX pgmap accounting
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 15 Sep 2022 20:36:56 -0700
Message-ID: <166329941594.2786261.16402766003789003164.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that pgmap accounting is handled at map time, it can be dropped from
gup time.

A hurdle still remains that filesystem-DAX huge pages are not compound
pages which still requires infrastructure like
__gup_device_huge_p{m,u}d() to stick around.

Additionally, ZONE_DEVICE pages with this change are still not suitable
to be returned from vm_normal_page(), so this cleanup is limited to
deleting pgmap reference manipulation. This is an incremental step on
the path to removing pte_devmap() altogether.

Note that follow_pmd_devmap() can be deleted entirely since a few
additions of pmd_devmap() allows the transparent huge page path to be
reused.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/huge_mm.h |   12 +------
 mm/gup.c                |   83 +++++++++++------------------------------------
 mm/huge_memory.c        |   54 +------------------------------
 3 files changed, 22 insertions(+), 127 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de73f5a16252..b8ed373c6090 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -263,10 +263,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap);
+		pud_t *pud, int flags);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
@@ -418,14 +416,8 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
 	return;
 }
 
-static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
-	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	return NULL;
-}
-
 static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
-	unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
+	unsigned long addr, pud_t *pud, int flags)
 {
 	return NULL;
 }
diff --git a/mm/gup.c b/mm/gup.c
index c6d060dee9e0..8e6dd4308e19 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,7 +25,6 @@
 #include "internal.h"
 
 struct follow_page_context {
-	struct dev_pagemap *pgmap;
 	unsigned int page_mask;
 };
 
@@ -487,8 +486,7 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
@@ -532,17 +530,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 
 	page = vm_normal_page(vma, address, pte);
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
+	if (!page && pte_devmap(pte)) {
 		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
+		 * ZONE_DEVICE pages are not yet treated as vm_normal_page()
+		 * instances, with respect to mapcount and compound-page
+		 * metadata
 		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
+		page = pte_page(pte);
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
@@ -660,15 +654,8 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 			return no_page_table(vma, flags);
 		goto retry;
 	}
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-	}
-	if (likely(!pmd_trans_huge(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+	if (likely(!(pmd_trans_huge(pmdval) || pmd_devmap(pmdval))))
+		return follow_page_pte(vma, address, pmd, flags);
 
 	if ((flags & FOLL_NUMA) && pmd_protnone(pmdval))
 		return no_page_table(vma, flags);
@@ -686,9 +673,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		pmd_migration_entry_wait(mm, pmd);
 		goto retry_locked;
 	}
-	if (unlikely(!pmd_trans_huge(*pmd))) {
+	if (unlikely(!(pmd_trans_huge(*pmd) || pmd_devmap(pmdval)))) {
 		spin_unlock(ptl);
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags);
 	}
 	if (flags & FOLL_SPLIT_PMD) {
 		int ret;
@@ -706,7 +693,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		}
 
 		return ret ? ERR_PTR(ret) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags);
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
@@ -743,7 +730,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	}
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
+		page = follow_devmap_pud(vma, address, pud, flags);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -790,9 +777,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  *
  * @flags can have FOLL_ flags set, defined in <linux/mm.h>
  *
- * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
- * the device's dev_pagemap metadata to avoid repeating expensive lookups.
- *
  * When getting an anonymous page and the caller has to trigger unsharing
  * of a shared anonymous page first, -EMLINK is returned. The caller should
  * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
@@ -847,7 +831,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags)
 {
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 	struct page *page;
 
 	if (vma_is_secretmem(vma))
@@ -857,8 +841,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 		return NULL;
 
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return page;
 }
 
@@ -1118,7 +1100,7 @@ static long __get_user_pages(struct mm_struct *mm,
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 
 	if (!nr_pages)
 		return 0;
@@ -1241,8 +1223,6 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
 
@@ -2322,9 +2302,8 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
 	pte_t *ptep, *ptem;
+	int ret = 0;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
@@ -2345,12 +2324,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (pte_devmap(pte)) {
 			if (unlikely(flags & FOLL_LONGTERM))
 				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
 		} else if (pte_special(pte))
 			goto pte_unmap;
 
@@ -2397,8 +2370,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
@@ -2425,28 +2396,17 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			     unsigned long end, unsigned int flags,
 			     struct page **pages, int *nr)
 {
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
 	do {
 		struct page *page = pfn_to_page(pfn);
 
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
-		if (unlikely(!try_grab_page(page, flags))) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
+		if (unlikely(!try_grab_page(page, flags)))
 			break;
-		}
 		(*nr)++;
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	put_dev_pagemap(pgmap);
 	return addr == end;
 }
 
@@ -2455,16 +2415,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
-	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
 
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
+	if (unlikely(pmd_val(orig) != pmd_val(*pmdp)))
 		return 0;
-	}
+
 	return 1;
 }
 
@@ -2473,16 +2431,13 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 				 struct page **pages, int *nr)
 {
 	unsigned long fault_pfn;
-	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
 
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
+	if (unlikely(pud_val(orig) != pud_val(*pudp)))
 		return 0;
-	}
 	return 1;
 }
 #else
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a7c1b344abe..ef68296f2158 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1031,55 +1031,6 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	/*
-	 * When we COW a devmap PMD entry, we split it into PTEs, so we should
-	 * not be in this function with `flags & FOLL_COW` set.
-	 */
-	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
-
-	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
-	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
-			 (FOLL_PIN | FOLL_GET)))
-		return NULL;
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	if (!try_grab_page(page, flags))
-		page = ERR_PTR(-ENOMEM);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1196,7 +1147,7 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 }
 
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap)
+			       pud_t *pud, int flags)
 {
 	unsigned long pfn = pud_pfn(*pud);
 	struct mm_struct *mm = vma->vm_mm;
@@ -1230,9 +1181,6 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	if (!try_grab_page(page, flags))
 		page = ERR_PTR(-ENOMEM);

