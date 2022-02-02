Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B24A733D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbiBBOet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbiBBOer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B7CC06173D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h125so1510790pgc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmPXIembDYUQZdiojpjRF6icQ2WPRb2Yss79vxHhOMc=;
        b=w0K0g72cMCrNdP/NHtVjGHimcUtWez4Q0dbbJwob2g29Qm+MKRkXJKsAMPMbvPgiw+
         1YbaDoKvlgrKcV/gNFOt3KX2lNiiWw25pDlU8mCVcAWxtAMLpRxMy8NP4E38IpJl8FSg
         TUtczFKyIKLmpq6xL9Etr29Cyvfj+GoPMjs7AlkoEOTKC+ArBaIROC/64ZODgijemBWU
         xRHE63dtPn+HU71VPAlFooNZcCNJ43alHiCHXv5BXrakTtEXbJv9pWijrQIGmbUJ7pSV
         MRuJPgs/gXVmZkIWpm/BkfpG2RSz5s2MNXzkSHG+fZycTFIEVeTTW6IyU9ny2eL2OoGf
         vL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmPXIembDYUQZdiojpjRF6icQ2WPRb2Yss79vxHhOMc=;
        b=29+9YGxMqehOJnH1qatuf2aX8Mz6IOXjtRwV8lEFyKAQ97V2AWgmkTldBoLhN4Tfkr
         79iFcii525TDH50YSo+/s08muw+mGdXdsRjoiO4NzmQE/rK8RB83tFAHZJNA/Z+/sviX
         sHvND6JyG45+Ln6mEEO1v3G43yshb4xz6TlVgk61p4kbUnc7I09LfLzJOQZ1oTmF7QIk
         n8QvWSAivUjKnkcmtAlW5Ek3mk1NzlaACt+l1nflpqJ5VfZ2stvhp6nduq+hl831I6QY
         kKFv7GjnvYi1o9H8blCHAdlZ7FnyBpM1NeJINfI4JDWym1Esft1m5Nq1O75yBobtd4VA
         stYw==
X-Gm-Message-State: AOAM531SL8yq4tNFu7oK7HrxWh+JWDMLWqkAIsRQvVZHiXnFv5qWo1eo
        B89K7BhqErt7M7GYFFhExzDhQg==
X-Google-Smtp-Source: ABdhPJwtEKR0kboEHhouJDRLQjjqdXwqy8VsDDw7NR+0RyLEXV/5vfpSBnHEVq3onHxjnGD5YWze7Q==
X-Received: by 2002:a63:496:: with SMTP id 144mr25240840pge.380.1643812486551;
        Wed, 02 Feb 2022 06:34:46 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:46 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
Date:   Wed,  2 Feb 2022 22:33:05 +0800
Message-Id: <20220202143307.96282-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220202143307.96282-1-songmuchun@bytedance.com>
References: <20220202143307.96282-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page_mkclean_one() is supposed to be used with the pfn that has a
associated struct page, but not all the pfns (e.g. DAX) have a struct
page. Introduce a new function pfn_mkclean_range() to cleans the PTEs
(including PMDs) mapped with range of pfns which has no struct page
associated with them. This helper will be used by DAX device in the
next patch to make pfns clean.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/rmap.h |  3 ++
 mm/internal.h        | 26 ++++++++++------
 mm/rmap.c            | 84 +++++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 86 insertions(+), 27 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 78373935ad49..668a1e81b442 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -241,6 +241,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
  */
 unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
 
+int pfn_mkclean_range(unsigned long pfn, int npfn, pgoff_t pgoff,
+		      struct vm_area_struct *vma);
+
 /*
  * Cleans the PTEs of shared mappings.
  * (and since clean PTEs should also be readonly, write protects them too)
diff --git a/mm/internal.h b/mm/internal.h
index 5458cd08df33..dc71256e568f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -449,26 +449,22 @@ extern void clear_page_mlock(struct page *page);
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /*
- * At what user virtual address is page expected in vma?
- * Returns -EFAULT if all of the page is outside the range of vma.
- * If page is a compound head, the entire compound page is considered.
+ * Return the start of user virtual address at the specific offset within
+ * a vma.
  */
 static inline unsigned long
-vma_address(struct page *page, struct vm_area_struct *vma)
+vma_pgoff_address(pgoff_t pgoff, unsigned long nr_pages,
+		  struct vm_area_struct *vma)
 {
-	pgoff_t pgoff;
 	unsigned long address;
 
-	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
-	pgoff = page_to_pgoff(page);
 	if (pgoff >= vma->vm_pgoff) {
 		address = vma->vm_start +
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		/* Check for address beyond vma (or wrapped through 0?) */
 		if (address < vma->vm_start || address >= vma->vm_end)
 			address = -EFAULT;
-	} else if (PageHead(page) &&
-		   pgoff + compound_nr(page) - 1 >= vma->vm_pgoff) {
+	} else if (pgoff + nr_pages - 1 >= vma->vm_pgoff) {
 		/* Test above avoids possibility of wrap to 0 on 32-bit */
 		address = vma->vm_start;
 	} else {
@@ -478,6 +474,18 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 }
 
 /*
+ * Return the start of user virtual address of a page within a vma.
+ * Returns -EFAULT if all of the page is outside the range of vma.
+ * If page is a compound head, the entire compound page is considered.
+ */
+static inline unsigned long
+vma_address(struct page *page, struct vm_area_struct *vma)
+{
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	return vma_pgoff_address(page_to_pgoff(page), compound_nr(page), vma);
+}
+
+/*
  * Return the end of user virtual address at the specific offset within
  * a vma.
  */
diff --git a/mm/rmap.c b/mm/rmap.c
index 0ba12dc9fae3..8f1860dc22bc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -928,34 +928,33 @@ int page_referenced(struct page *page,
 	return pra.referenced;
 }
 
-static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
-			    unsigned long address, void *arg)
+static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 {
-	struct page_vma_mapped_walk pvmw = {
-		.page = page,
-		.vma = vma,
-		.address = address,
-		.flags = PVMW_SYNC,
-	};
+	int cleaned = 0;
+	struct vm_area_struct *vma = pvmw->vma;
 	struct mmu_notifier_range range;
-	int *cleaned = arg;
+	unsigned long end;
+
+	if (pvmw->flags & PVMW_PFN_WALK)
+		end = vma_pgoff_address_end(pvmw->index, pvmw->nr, vma);
+	else
+		end = vma_address_end(pvmw->page, vma);
 
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
 	 * the page can not be free from this function.
 	 */
-	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
-				0, vma, vma->vm_mm, address,
-				vma_address_end(page, vma));
+	mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE, 0, vma,
+				vma->vm_mm, pvmw->address, end);
 	mmu_notifier_invalidate_range_start(&range);
 
-	while (page_vma_mapped_walk(&pvmw)) {
+	while (page_vma_mapped_walk(pvmw)) {
 		int ret = 0;
+		unsigned long address = pvmw->address;
 
-		address = pvmw.address;
-		if (pvmw.pte) {
+		if (pvmw->pte) {
 			pte_t entry;
-			pte_t *pte = pvmw.pte;
+			pte_t *pte = pvmw->pte;
 
 			if (!pte_dirty(*pte) && !pte_write(*pte))
 				continue;
@@ -968,7 +967,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			ret = 1;
 		} else {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			pmd_t *pmd = pvmw.pmd;
+			pmd_t *pmd = pvmw->pmd;
 			pmd_t entry;
 
 			if (!pmd_dirty(*pmd) && !pmd_write(*pmd))
@@ -995,11 +994,27 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
 		if (ret)
-			(*cleaned)++;
+			cleaned++;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
 
+	return cleaned;
+}
+
+static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
+			    unsigned long address, void *arg)
+{
+	struct page_vma_mapped_walk pvmw = {
+		.page		= page,
+		.vma		= vma,
+		.address	= address,
+		.flags		= PVMW_SYNC,
+	};
+	int *cleaned = arg;
+
+	*cleaned += page_vma_mkclean_one(&pvmw);
+
 	return true;
 }
 
@@ -1037,6 +1052,39 @@ int folio_mkclean(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_mkclean);
 
 /**
+ * pfn_mkclean_range - Cleans the PTEs (including PMDs) mapped with range of
+ *                     [@pfn, @pfn + @npfn) at the specific offset (@pgoff)
+ *                     within the @vma of shared mappings. And since clean PTEs
+ *                     should also be readonly, write protects them too.
+ * @pfn: start pfn.
+ * @npfn: number of physically contiguous pfns srarting with @pfn.
+ * @pgoff: page offset that the @pfn mapped with.
+ * @vma: vma that @pfn mapped within.
+ *
+ * Returns the number of cleaned PTEs (including PMDs).
+ */
+int pfn_mkclean_range(unsigned long pfn, int npfn, pgoff_t pgoff,
+		      struct vm_area_struct *vma)
+{
+	unsigned long address = vma_pgoff_address(pgoff, npfn, vma);
+	struct page_vma_mapped_walk pvmw = {
+		.pfn		= pfn,
+		.nr		= npfn,
+		.index		= pgoff,
+		.vma		= vma,
+		.address	= address,
+		.flags		= PVMW_SYNC | PVMW_PFN_WALK,
+	};
+
+	if (invalid_mkclean_vma(vma, NULL))
+		return 0;
+
+	VM_BUG_ON_VMA(address == -EFAULT, vma);
+
+	return page_vma_mkclean_one(&pvmw);
+}
+
+/**
  * page_move_anon_rmap - move a page to our anon_vma
  * @page:	the page to move to our anon_vma
  * @vma:	the vma the page belongs to
-- 
2.11.0

