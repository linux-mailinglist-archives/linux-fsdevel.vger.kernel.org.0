Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516215AC215
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiIDCRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiIDCRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:17:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820954E860
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257836; x=1693793836;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7cUPCFRfEM51i7BRJG+0ccdu8jS149l2Tkf0+0JoZ4=;
  b=NKd3oshaX7nU6kA7ROgyuXGspn5ysv/Ugla0EuJzd0zDXeM5yqLv+oIi
   sWP28qsbSQNjxp2qdttc3giakYe4NFsXsfazJlnP2P+aYZuBuVeNdRejM
   SuPQH5dJQo0yAoQgtUXPnZHwC1PZ7gr06CoHxVNDKMWVaBXJGJxAGu4hp
   lWpEGyKc38rsOS65L/mhcODfcHwAxJLcSKhvNPSP26duhavy/O2e5x7iR
   ymwUzTDBi0ARdd6rlLFjY+vHUbO5BPfKs6IXgrCdiWIAEQUrf7X46LhNG
   uelMJHgZNCTz+tqSflADHWUsq1X2OQEeW/TwSGe6d7rjEKrY7VKT71sRR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296207768"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="296207768"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:17:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="609343164"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:17:15 -0700
Subject: [PATCH 13/13] mm/gup: Drop DAX pgmap accounting
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:17:15 -0700
Message-ID: <166225783530.2351842.9198292974545499645.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 67dfffe97917..3832edd27dfd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,7 +25,6 @@
 #include "internal.h"
 
 struct follow_page_context {
-	struct dev_pagemap *pgmap;
 	unsigned int page_mask;
 };
 
@@ -490,8 +489,7 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
@@ -535,17 +533,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
@@ -663,15 +657,8 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
@@ -689,9 +676,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
@@ -709,7 +696,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		}
 
 		return ret ? ERR_PTR(ret) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags);
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
@@ -746,7 +733,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	}
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
+		page = follow_devmap_pud(vma, address, pud, flags);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -793,9 +780,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  *
  * @flags can have FOLL_ flags set, defined in <linux/mm.h>
  *
- * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
- * the device's dev_pagemap metadata to avoid repeating expensive lookups.
- *
  * When getting an anonymous page and the caller has to trigger unsharing
  * of a shared anonymous page first, -EMLINK is returned. The caller should
  * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
@@ -850,7 +834,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags)
 {
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 	struct page *page;
 
 	if (vma_is_secretmem(vma))
@@ -860,8 +844,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 		return NULL;
 
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return page;
 }
 
@@ -1121,7 +1103,7 @@ static long __get_user_pages(struct mm_struct *mm,
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 
 	if (!nr_pages)
 		return 0;
@@ -1244,8 +1226,6 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
 
@@ -2325,9 +2305,8 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
 	pte_t *ptep, *ptem;
+	int ret = 0;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
@@ -2348,12 +2327,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
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
 
@@ -2400,8 +2373,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
@@ -2428,28 +2399,17 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
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
 
@@ -2458,16 +2418,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
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
 
@@ -2476,16 +2434,13 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
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

