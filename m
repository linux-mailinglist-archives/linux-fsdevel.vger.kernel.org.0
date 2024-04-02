Return-Path: <linux-fsdevel+bounces-15871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5678953FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EE51F24E58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8307FBBF;
	Tue,  2 Apr 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDmi1QcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F467F46B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062555; cv=none; b=YZhgJmXquWMMC0wyoO19GVX3z377nMPjd2sXm2MzV3nym9ViHArW7dyxzVhZhWPOomWpKUkGSRZQhTWL6i/y4mHNcVZKLcjm/RmuHLArxrrB8ybbo+kVDZpyrl8E+easS7VcRJLzFikF89uvBXnuiZkx2GZcoB9Um4jyrB90vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062555; c=relaxed/simple;
	bh=0DKZN618n5B0aRBNSWgT4HFX/jWJPj1nuR8o4dctxPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeTcVSELzOmHh4urbzbZnbwozMvW1HKPJ5GUo9pz95HgoFVu2CMlzOKO0RnuwTkbv0djCKiul4wDpXvp6X//lkB94ruqJnhjoePzCFKaAxsPM45+1RYWAnSkyWqihKDAwsRnb+ap0ThPE9We+GrNDfzAz0YY+YekyY3GOtdZhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDmi1QcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdYOkjfTZFMKy+tLKKZoC0LHiVahfxet7AumBM/aSVk=;
	b=hDmi1QcNgJDMmBVGeUnWFRc33plOHBuhM3RpSiLvhH+M0+KF1n/cvG1AM6QwvjOM2EMra5
	8nPXeGh3e8om57dbiuKNzu7iUmM3vK1z3xgGnY92DzBua6dfXOYdGboNiPIv1rC0KX9Xa3
	H4ji/NNDbUDfAeHu8CBSMS0Jt7pvvos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-JNUqi7DONq2XGai5HjtGgg-1; Tue, 02 Apr 2024 08:55:47 -0400
X-MC-Unique: JNUqi7DONq2XGai5HjtGgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B1BD805A63;
	Tue,  2 Apr 2024 12:55:46 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A55213C22;
	Tue,  2 Apr 2024 12:55:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
Date: Tue,  2 Apr 2024 14:55:14 +0200
Message-ID: <20240402125516.223131-2-david@redhat.com>
In-Reply-To: <20240402125516.223131-1-david@redhat.com>
References: <20240402125516.223131-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
all relevant internal functions to start with "gup_fast", to make it
clearer that this is not ordinary GUP. The current mixture of
"lockless", "gup" and "gup_fast" is confusing.

Further, avoid the term "huge" when talking about a "leaf" -- for
example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
"hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
stays.

What remains is the "external" interface:
* get_user_pages_fast_only()
* get_user_pages_fast()
* pin_user_pages_fast()

The high-level internal functions for GUP-fast (+slow fallback) are now:
* internal_get_user_pages_fast() -> gup_fast_fallback()
* lockless_pages_from_mm() -> gup_fast()

The basic GUP-fast walker functions:
* gup_pgd_range() -> gup_fast_pgd_range()
* gup_p4d_range() -> gup_fast_p4d_range()
* gup_pud_range() -> gup_fast_pud_range()
* gup_pmd_range() -> gup_fast_pmd_range()
* gup_pte_range() -> gup_fast_pte_range()
* gup_huge_pgd()  -> gup_fast_pgd_leaf()
* gup_huge_pud()  -> gup_fast_pud_leaf()
* gup_huge_pmd()  -> gup_fast_pmd_leaf()

The weird hugepd stuff:
* gup_huge_pd() -> gup_fast_hugepd()
* gup_hugepte() -> gup_fast_hugepte()

The weird devmap stuff:
* __gup_device_huge_pud() -> gup_fast_devmap_pud_leaf()
* __gup_device_huge_pmd   -> gup_fast_devmap_pmd_leaf()
* __gup_device_huge()     -> gup_fast_devmap_leaf()
* undo_dev_pagemap()      -> gup_fast_undo_dev_pagemap()

Helper functions:
* unpin_user_pages_lockless() -> gup_fast_unpin_user_pages()
* gup_fast_folio_allowed() is already properly named
* gup_fast_permitted() is already properly named

With "gup_fast()", we now even have a function that is referred to in
comment in mm/mmu_gather.c.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 205 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 103 insertions(+), 102 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 95bd9d4b7cfb..f1ac2c5a7f6d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -440,7 +440,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 }
 EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
 
-static void unpin_user_pages_lockless(struct page **pages, unsigned long npages)
+static void gup_fast_unpin_user_pages(struct page **pages, unsigned long npages)
 {
 	unsigned long i;
 	struct folio *folio;
@@ -525,9 +525,9 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 	return (__boundary - 1 < end - 1) ? __boundary : end;
 }
 
-static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
-		       unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
+static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long pte_end;
 	struct page *page;
@@ -577,7 +577,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
  * of the other folios. See writable_file_mapping_allowed() and
  * gup_fast_folio_allowed() for more information.
  */
-static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+static int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
 {
@@ -588,7 +588,7 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next = hugepte_addr_end(addr, end, sz);
-		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
+		if (!gup_fast_hugepte(ptep, sz, addr, end, flags, pages, nr))
 			return 0;
 	} while (ptep++, addr = next, addr != end);
 
@@ -613,8 +613,8 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	h = hstate_vma(vma);
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
-	ret = gup_huge_pd(hugepd, addr, pdshift, addr + PAGE_SIZE,
-			  flags, &page, &nr);
+	ret = gup_fast_hugepd(hugepd, addr, pdshift, addr + PAGE_SIZE,
+			      flags, &page, &nr);
 	spin_unlock(ptl);
 
 	if (ret) {
@@ -626,7 +626,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	return NULL;
 }
 #else /* CONFIG_ARCH_HAS_HUGEPD */
-static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+static inline int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
 		unsigned int pdshift, unsigned long end, unsigned int flags,
 		struct page **pages, int *nr)
 {
@@ -2753,7 +2753,7 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
 /*
- * Fast GUP
+ * GUP-fast
  *
  * get_user_pages_fast attempts to pin user pages by walking the page
  * tables directly and avoids taking locks. Thus the walker needs to be
@@ -2767,7 +2767,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  *
  * Another way to achieve this is to batch up page table containing pages
  * belonging to more than one mm_user, then rcu_sched a callback to free those
- * pages. Disabling interrupts will allow the fast_gup walker to both block
+ * pages. Disabling interrupts will allow the gup_fast() walker to both block
  * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
  * (which is a relatively rare event). The code below adopts this strategy.
  *
@@ -2876,9 +2876,8 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	return !reject_file_backed || shmem_mapping(mapping);
 }
 
-static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
-					    unsigned int flags,
-					    struct page **pages)
+static void __maybe_unused gup_fast_undo_dev_pagemap(int *nr, int nr_start,
+		unsigned int flags, struct page **pages)
 {
 	while ((*nr) - nr_start) {
 		struct page *page = pages[--(*nr)];
@@ -2893,27 +2892,27 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 /*
- * Fast-gup relies on pte change detection to avoid concurrent pgtable
+ * GUP-fast relies on pte change detection to avoid concurrent pgtable
  * operations.
  *
- * To pin the page, fast-gup needs to do below in order:
+ * To pin the page, GUP-fast needs to do below in order:
  * (1) pin the page (by prefetching pte), then (2) check pte not changed.
  *
  * For the rest of pgtable operations where pgtable updates can be racy
- * with fast-gup, we need to do (1) clear pte, then (2) check whether page
+ * with GUP-fast, we need to do (1) clear pte, then (2) check whether page
  * is pinned.
  *
  * Above will work for all pte-level operations, including THP split.
  *
- * For THP collapse, it's a bit more complicated because fast-gup may be
+ * For THP collapse, it's a bit more complicated because GUP-fast may be
  * walking a pgtable page that is being freed (pte is still valid but pmd
  * can be cleared already).  To avoid race in such condition, we need to
  * also check pmd here to make sure pmd doesn't change (corresponds to
  * pmdp_collapse_flush() in the THP collapse code path).
  */
-static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
-			 unsigned long end, unsigned int flags,
-			 struct page **pages, int *nr)
+static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
 	int nr_start = *nr, ret = 0;
@@ -2946,7 +2945,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 
 			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
 			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, flags, pages);
+				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 				goto pte_unmap;
 			}
 		} else if (pte_special(pte))
@@ -3010,20 +3009,19 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
  *
  * For a futex to be placed on a THP tail page, get_futex_key requires a
  * get_user_pages_fast_only implementation that can pin pages. Thus it's still
- * useful to have gup_huge_pmd even if we can't operate on ptes.
+ * useful to have gup_fast_pmd_leaf even if we can't operate on ptes.
  */
-static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
-			 unsigned long end, unsigned int flags,
-			 struct page **pages, int *nr)
+static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int __gup_device_huge(unsigned long pfn, unsigned long addr,
-			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
+static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
+	unsigned long end, unsigned int flags, struct page **pages, int *nr)
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
@@ -3033,19 +3031,19 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
+			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
 
 		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
+			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
 
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(try_grab_page(page, flags))) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
+			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
 		(*nr)++;
@@ -3056,62 +3054,62 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 	return addr == end;
 }
 
-static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
+static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
+	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
+		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
 }
 
-static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
+static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
+	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		undo_dev_pagemap(nr, nr_start, flags, pages);
+		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 		return 0;
 	}
 	return 1;
 }
 #else
-static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
+static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	BUILD_BUG();
 	return 0;
 }
 
-static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
-				 unsigned long end, unsigned int flags,
-				 struct page **pages, int *nr)
+static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	BUILD_BUG();
 	return 0;
 }
 #endif
 
-static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-			unsigned long end, unsigned int flags,
-			struct page **pages, int *nr)
+static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	struct page *page;
 	struct folio *folio;
@@ -3123,8 +3121,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
-					     pages, nr);
+		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
+					        pages, nr);
 	}
 
 	page = pmd_page(orig);
@@ -3153,9 +3151,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	return 1;
 }
 
-static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-			unsigned long end, unsigned int flags,
-			struct page **pages, int *nr)
+static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	struct page *page;
 	struct folio *folio;
@@ -3167,8 +3165,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_devmap(orig)) {
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
-		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
-					     pages, nr);
+		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
+					        pages, nr);
 	}
 
 	page = pud_page(orig);
@@ -3198,9 +3196,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	return 1;
 }
 
-static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
-			unsigned long end, unsigned int flags,
-			struct page **pages, int *nr)
+static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	int refs;
 	struct page *page;
@@ -3238,8 +3236,9 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	return 1;
 }
 
-static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages, int *nr)
+static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -3253,11 +3252,11 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 			return 0;
 
 		if (unlikely(pmd_leaf(pmd))) {
-			/* See gup_pte_range() */
+			/* See gup_fast_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
 
-			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
+			if (!gup_fast_pmd_leaf(pmd, pmdp, addr, next, flags,
 				pages, nr))
 				return 0;
 
@@ -3266,18 +3265,20 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 			 * architecture have different format for hugetlbfs
 			 * pmd format and THP pmd format
 			 */
-			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
-					 PMD_SHIFT, next, flags, pages, nr))
+			if (!gup_fast_hugepd(__hugepd(pmd_val(pmd)), addr,
+					     PMD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
+		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
+					       pages, nr))
 			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
 	return 1;
 }
 
-static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
@@ -3290,22 +3291,24 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_leaf(pud))) {
-			if (!gup_huge_pud(pud, pudp, addr, next, flags,
-					  pages, nr))
+			if (!gup_fast_pud_leaf(pud, pudp, addr, next, flags,
+					       pages, nr))
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
-			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
-					 PUD_SHIFT, next, flags, pages, nr))
+			if (!gup_fast_hugepd(__hugepd(pud_val(pud)), addr,
+					     PUD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pmd_range(pudp, pud, addr, next, flags, pages, nr))
+		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
+					       pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
 	return 1;
 }
 
-static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr)
 {
 	unsigned long next;
 	p4d_t *p4dp;
@@ -3319,17 +3322,18 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
 			return 0;
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
-					 P4D_SHIFT, next, flags, pages, nr))
+			if (!gup_fast_hugepd(__hugepd(p4d_val(p4d)), addr,
+					     P4D_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pud_range(p4dp, p4d, addr, next, flags, pages, nr))
+		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
+					       pages, nr))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
 	return 1;
 }
 
-static void gup_pgd_range(unsigned long addr, unsigned long end,
+static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 		unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
@@ -3343,19 +3347,20 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_leaf(pgd))) {
-			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
-					  pages, nr))
+			if (!gup_fast_pgd_leaf(pgd, pgdp, addr, next, flags,
+					       pages, nr))
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
-			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
-					 PGDIR_SHIFT, next, flags, pages, nr))
+			if (!gup_fast_hugepd(__hugepd(pgd_val(pgd)), addr,
+					      PGDIR_SHIFT, next, flags, pages, nr))
 				return;
-		} else if (!gup_p4d_range(pgdp, pgd, addr, next, flags, pages, nr))
+		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
+					       pages, nr))
 			return;
 	} while (pgdp++, addr = next, addr != end);
 }
 #else
-static inline void gup_pgd_range(unsigned long addr, unsigned long end,
+static inline void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 		unsigned int flags, struct page **pages, int *nr)
 {
 }
@@ -3372,10 +3377,8 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
 }
 #endif
 
-static unsigned long lockless_pages_from_mm(unsigned long start,
-					    unsigned long end,
-					    unsigned int gup_flags,
-					    struct page **pages)
+static unsigned long gup_fast(unsigned long start, unsigned long end,
+		unsigned int gup_flags, struct page **pages)
 {
 	unsigned long flags;
 	int nr_pinned = 0;
@@ -3403,16 +3406,16 @@ static unsigned long lockless_pages_from_mm(unsigned long start,
 	 * that come from THPs splitting.
 	 */
 	local_irq_save(flags);
-	gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
+	gup_fast_pgd_range(start, end, gup_flags, pages, &nr_pinned);
 	local_irq_restore(flags);
 
 	/*
 	 * When pinning pages for DMA there could be a concurrent write protect
-	 * from fork() via copy_page_range(), in this case always fail fast GUP.
+	 * from fork() via copy_page_range(), in this case always fail GUP-fast.
 	 */
 	if (gup_flags & FOLL_PIN) {
 		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
-			unpin_user_pages_lockless(pages, nr_pinned);
+			gup_fast_unpin_user_pages(pages, nr_pinned);
 			return 0;
 		} else {
 			sanity_check_pinned_pages(pages, nr_pinned);
@@ -3421,10 +3424,8 @@ static unsigned long lockless_pages_from_mm(unsigned long start,
 	return nr_pinned;
 }
 
-static int internal_get_user_pages_fast(unsigned long start,
-					unsigned long nr_pages,
-					unsigned int gup_flags,
-					struct page **pages)
+static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
+		unsigned int gup_flags, struct page **pages)
 {
 	unsigned long len, end;
 	unsigned long nr_pinned;
@@ -3452,7 +3453,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-	nr_pinned = lockless_pages_from_mm(start, end, gup_flags, pages);
+	nr_pinned = gup_fast(start, end, gup_flags, pages);
 	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
 		return nr_pinned;
 
@@ -3506,7 +3507,7 @@ int get_user_pages_fast_only(unsigned long start, int nr_pages,
 			       FOLL_GET | FOLL_FAST_ONLY))
 		return -EINVAL;
 
-	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
+	return gup_fast_fallback(start, nr_pages, gup_flags, pages);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast_only);
 
@@ -3537,7 +3538,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	 */
 	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_GET))
 		return -EINVAL;
-	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
+	return gup_fast_fallback(start, nr_pages, gup_flags, pages);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
 
@@ -3565,7 +3566,7 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 {
 	if (!is_valid_gup_args(pages, NULL, &gup_flags, FOLL_PIN))
 		return -EINVAL;
-	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
+	return gup_fast_fallback(start, nr_pages, gup_flags, pages);
 }
 EXPORT_SYMBOL_GPL(pin_user_pages_fast);
 
-- 
2.44.0


