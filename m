Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA40495B5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379344AbiAUH5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbiAUH4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457CC061753
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so5505108pjl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxhdA6+GNSH3L8fLFneVmiJKUQg5LlLtQjJYK6qW9gQ=;
        b=d4m5wUHhjebtfXqUNg2JEUv0GYabWqPb+pYMY/UZY5EVNTeXWBn14TfqbeTqWYSjHU
         DLk8Gek8ZIKBGlWKp0kkByozNHjPs5bthLGSQdOqjuWapq2C+ateGW4Bo18AZKdrrxrh
         Gz3IxqFY3Ty8GIDiZeDRCEasWDBMbxeTxShd4V4GluVICMczavbVvpZkiHUYgelIAzte
         Th3yQ6vHEvK6v8h2ZYxikaIDG0U4xdJnHrpWSWdZqlXJJBuy4D1XAI5k4U4NG/JCRzyn
         hdVn38s2J5IpekaMWHrqjN/LGJ2y3NZVMKi38Gf5erH47jpxuxgJViot194BegMoFi6U
         E5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxhdA6+GNSH3L8fLFneVmiJKUQg5LlLtQjJYK6qW9gQ=;
        b=4ha1LG2njokiPUoSIiy1pEhMww3mp8+EBOTx29v4vYLO2MyEVUX9X8PoNn+6JasHpQ
         CtRXSM8fc4mALgze/Xp63DK6Cq9WiUtwELC9S02v8Ds8y1XzjLlQ877Xm8av0s9yI+Pg
         a2uftMxOD2o3SWcMOaSRHA83yFSRKhVbmYjzOzpTRZGCCn1s4RwnxL5uXkdOdtRcaFE9
         bKYYR8UBShc2UdsDxJMsx2zbCnR1XT4FsrmtTRqoaoXdg/6m1HrIH7F7Www0qrGBPo/f
         ctXrPgLU6840ReQcsJ6nzv1wQz463y8CPZVKsNYb7gCm+Y+MicXTUs6zY+PBrVosCHTr
         iJ+w==
X-Gm-Message-State: AOAM530gLL5n3jMVOv5RNESDTvqfyP1+dmNMavr+krRimlsfmfLjxiid
        lytHeYm4FuKuloW90GTYa/+jqw==
X-Google-Smtp-Source: ABdhPJwjBFBtUfkbNZS3WuvqaSXfHYYx06TiIenEmLr6NZXnpwBZ9OvA7cRP76QnyQCb1D7JyUFJlQ==
X-Received: by 2002:a17:902:a703:b0:149:7087:9904 with SMTP id w3-20020a170902a70300b0014970879904mr2669682plq.126.1642751807650;
        Thu, 20 Jan 2022 23:56:47 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t15sm10778178pjy.17.2022.01.20.23.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:56:47 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/5] dax: fix missing writeprotect the pte entry
Date:   Fri, 21 Jan 2022 15:55:14 +0800
Message-Id: <20220121075515.79311-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220121075515.79311-1-songmuchun@bytedance.com>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently dax_mapping_entry_mkclean() fails to clean and write protect
the pte entry within a DAX PMD entry during an *sync operation. This
can result in data loss in the following sequence:

  1) process A mmap write to DAX PMD, dirtying PMD radix tree entry and
     making the pmd entry dirty and writeable.
  2) process B mmap with the @offset (e.g. 4K) and @length (e.g. 4K)
     write to the same file, dirtying PMD radix tree entry (already
     done in 1)) and making the pte entry dirty and writeable.
  3) fsync, flushing out PMD data and cleaning the radix tree entry. We
     currently fail to mark the pte entry as clean and write protected
     since the vma of process B is not covered in dax_entry_mkclean().
  4) process B writes to the pte. These don't cause any page faults since
     the pte entry is dirty and writeable. The radix tree entry remains
     clean.
  5) fsync, which fails to flush the dirty PMD data because the radix tree
     entry was clean.
  6) crash - dirty data that should have been fsync'd as part of 5) could
     still have been in the processor cache, and is lost.

Reuse some infrastructure of page_mkclean_one() to let DAX can handle
similar case to fix this issue.

Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dax.c             | 78 +++++-----------------------------------------------
 include/linux/rmap.h |  9 ++++++
 mm/internal.h        | 27 ++++++++++++------
 mm/rmap.c            | 69 ++++++++++++++++++++++++++++++++++------------
 4 files changed, 85 insertions(+), 98 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 2955ec65eb65..7d4e3e68b861 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rmap.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -801,86 +802,21 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
-static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
-		unsigned long pfn)
+static void dax_entry_mkclean(struct address_space *mapping, unsigned long pfn,
+			      unsigned long npfn, pgoff_t pgoff_start)
 {
 	struct vm_area_struct *vma;
-	pte_t pte, *ptep = NULL;
-	pmd_t *pmdp = NULL;
-	spinlock_t *ptl;
+	pgoff_t pgoff_end = pgoff_start + npfn - 1;
 
 	i_mmap_lock_read(mapping);
-	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
-		struct mmu_notifier_range range;
-		unsigned long address;
-
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff_start, pgoff_end) {
 		cond_resched();
 
 		if (!(vma->vm_flags & VM_SHARED))
 			continue;
 
-		address = pgoff_address(index, vma);
-
-		/*
-		 * follow_invalidate_pte() will use the range to call
-		 * mmu_notifier_invalidate_range_start() on our behalf before
-		 * taking any lock.
-		 */
-		if (follow_invalidate_pte(vma->vm_mm, address, &range, &ptep,
-					  &pmdp, &ptl))
-			continue;
-
-		/*
-		 * No need to call mmu_notifier_invalidate_range() as we are
-		 * downgrading page table protection not changing it to point
-		 * to a new page.
-		 *
-		 * See Documentation/vm/mmu_notifier.rst
-		 */
-		if (pmdp) {
-#ifdef CONFIG_FS_DAX_PMD
-			pmd_t pmd;
-
-			if (pfn != pmd_pfn(*pmdp))
-				goto unlock_pmd;
-			if (!pmd_dirty(*pmdp) && !pmd_write(*pmdp))
-				goto unlock_pmd;
-
-			flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
-			pmd = pmdp_invalidate(vma, address, pmdp);
-			pmd = pmd_wrprotect(pmd);
-			pmd = pmd_mkclean(pmd);
-			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
-unlock_pmd:
-#endif
-			spin_unlock(ptl);
-		} else {
-			if (pfn != pte_pfn(*ptep))
-				goto unlock_pte;
-			if (!pte_dirty(*ptep) && !pte_write(*ptep))
-				goto unlock_pte;
-
-			flush_cache_page(vma, address, pfn);
-			pte = ptep_clear_flush(vma, address, ptep);
-			pte = pte_wrprotect(pte);
-			pte = pte_mkclean(pte);
-			set_pte_at(vma->vm_mm, address, ptep, pte);
-unlock_pte:
-			pte_unmap_unlock(ptep, ptl);
-		}
-
-		mmu_notifier_invalidate_range_end(&range);
+		pfn_mkclean_range(pfn, npfn, pgoff_start, vma);
 	}
 	i_mmap_unlock_read(mapping);
 }
@@ -948,7 +884,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
-	dax_entry_mkclean(mapping, index, pfn);
+	dax_entry_mkclean(mapping, pfn, count, index);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7628474732e7..db41b7392e02 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -236,6 +236,15 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
 
 /*
+ * Cleans the PTEs of shared mappings.
+ * (and since clean PTEs should also be readonly, write protects them too)
+ *
+ * returns the number of cleaned PTEs.
+ */
+int pfn_mkclean_range(unsigned long pfn, int npfn, pgoff_t pgoff_start,
+		      struct vm_area_struct *vma);
+
+/*
  * Used by swapoff to help locate where page is expected in vma.
  */
 unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
diff --git a/mm/internal.h b/mm/internal.h
index d6e3e8e1be2d..6acf3a45feaf 100644
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
@@ -477,6 +473,19 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	return address;
 }
 
+
+/*
+ * At what user virtual address is page expected in vma?
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
 /*
  * Return the end of user virtual address at the specific offset within
  * a vma.
diff --git a/mm/rmap.c b/mm/rmap.c
index 65670cb805d6..ee37cff13143 100644
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
@@ -994,11 +993,45 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
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
+int pfn_mkclean_range(unsigned long pfn, int npfn, pgoff_t pgoff_start,
+		      struct vm_area_struct *vma)
+{
+	unsigned long address = vma_pgoff_address(pgoff_start, npfn, vma);
+	struct page_vma_mapped_walk pvmw = {
+		.pfn		= pfn,
+		.nr		= npfn,
+		.index		= pgoff_start,
+		.vma		= vma,
+		.address	= address,
+		.flags		= PVMW_SYNC | PVMW_PFN_WALK,
+	};
+
+	VM_BUG_ON_VMA(address == -EFAULT, vma);
+
+	return page_vma_mkclean_one(&pvmw);
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
 
-- 
2.11.0

