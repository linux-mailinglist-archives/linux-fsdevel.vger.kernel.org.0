Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD5E5FF76A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJNX7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNX7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:59:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F08EF614B
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791966; x=1697327966;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L0V7SrzCA0aOpbgV+IVU+xT4l6Tx4MRHhVonv4kD3hk=;
  b=S5dDr4EsUhh33MHJJTDQ9rSgTQeIcNzvcTSq2ate64boIVl/Od+1lZGS
   JbVh+FamB0O5eixjFQ6tYaHyQtWUmF79ykk0XMO4IUUpUOL39FoauCAXc
   Piqk8aTOcQaGsfZ7TJHtmjilYR7fl56JCbJpBDpX3yFM+XsvEv0NxyY/Q
   pajkJEJtrl4Jn2dnR5RhKEhywx6V4x/I3J1JNUybDXl1iRcvPok5qFZ/s
   i5CaVxA0nqbe2t7nRrHF/B2Cz27rYDrgThxk8UY7ehoKFcgE3d5AfjvVc
   Os+HkxruwCbqQVQCX4RnGG/pUpu9xPZdHrXzEphOGj6/rwWqJiLSVQxTK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285887976"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="285887976"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605541417"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="605541417"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:23 -0700
Subject: [PATCH v3 25/25] mm/gup: Drop DAX pgmap accounting
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:59:23 -0700
Message-ID: <166579196364.2236710.8984717005481314942.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
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

Now that pgmap accounting is handled at pgmap_request_folios() time, it
can be dropped from gup time.

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
 mm/huge_memory.c        |   48 +--------------------------
 3 files changed, 22 insertions(+), 121 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index aab708996fb0..5d861905df46 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -266,10 +266,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap);
+		pud_t *pud, int flags);
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
@@ -428,14 +426,8 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
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
index e49b1f46faa5..dc5284df3f6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -25,7 +25,6 @@
 #include "internal.h"
 
 struct follow_page_context {
-	struct dev_pagemap *pgmap;
 	unsigned int page_mask;
 };
 
@@ -522,8 +521,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
-		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		unsigned long address, pmd_t *pmd, unsigned int flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *page;
@@ -574,17 +572,13 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
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
@@ -702,15 +696,8 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(flags))
 		return no_page_table(vma, flags);
@@ -728,9 +715,9 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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
@@ -748,7 +735,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		}
 
 		return ret ? ERR_PTR(ret) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags);
 	}
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
@@ -785,7 +772,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	}
 	if (pud_devmap(*pud)) {
 		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
+		page = follow_devmap_pud(vma, address, pud, flags);
 		spin_unlock(ptl);
 		if (page)
 			return page;
@@ -832,9 +819,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
  *
  * @flags can have FOLL_ flags set, defined in <linux/mm.h>
  *
- * When getting pages from ZONE_DEVICE memory, the @ctx->pgmap caches
- * the device's dev_pagemap metadata to avoid repeating expensive lookups.
- *
  * When getting an anonymous page and the caller has to trigger unsharing
  * of a shared anonymous page first, -EMLINK is returned. The caller should
  * trigger a fault with FAULT_FLAG_UNSHARE set. Note that unsharing is only
@@ -889,7 +873,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags)
 {
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 	struct page *page;
 
 	if (vma_is_secretmem(vma))
@@ -899,8 +883,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 		return NULL;
 
 	page = follow_page_mask(vma, address, foll_flags, &ctx);
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return page;
 }
 
@@ -1149,7 +1131,7 @@ static long __get_user_pages(struct mm_struct *mm,
 {
 	long ret = 0, i = 0;
 	struct vm_area_struct *vma = NULL;
-	struct follow_page_context ctx = { NULL };
+	struct follow_page_context ctx = { 0 };
 
 	if (!nr_pages)
 		return 0;
@@ -1264,8 +1246,6 @@ static long __get_user_pages(struct mm_struct *mm,
 		nr_pages -= page_increm;
 	} while (nr_pages);
 out:
-	if (ctx.pgmap)
-		put_dev_pagemap(ctx.pgmap);
 	return i ? i : ret;
 }
 
@@ -2408,9 +2388,8 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			 unsigned long end, unsigned int flags,
 			 struct page **pages, int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
 	pte_t *ptep, *ptem;
+	int ret = 0;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
@@ -2427,12 +2406,6 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
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
 
@@ -2480,8 +2453,6 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
@@ -2509,28 +2480,17 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
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
 
@@ -2539,16 +2499,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
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
 
@@ -2557,16 +2515,13 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
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
index 1cc4a5f4791e..065c0dc03491 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1029,49 +1029,6 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
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
@@ -1188,7 +1145,7 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 }
 
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, int flags, struct dev_pagemap **pgmap)
+			       pud_t *pud, int flags)
 {
 	unsigned long pfn = pud_pfn(*pud);
 	struct mm_struct *mm = vma->vm_mm;
@@ -1222,9 +1179,6 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EEXIST);
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 	if (!try_grab_page(page, flags))
 		page = ERR_PTR(-ENOMEM);

