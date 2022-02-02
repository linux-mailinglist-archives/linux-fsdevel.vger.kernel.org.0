Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2014A7338
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbiBBOel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345017AbiBBOek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:34:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E838C06173B
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 06:34:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k17so18519856plk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CF0auyXfFKE1IEYVq03Jkg+soFc4skAhc1lxx6fAtcg=;
        b=zOnd2QjsWbes5CPtqMDtzwXXx4Qnh1nB96Y73gx80JMX1YjE5DYvNj1kR9Rf3wf1Px
         wPuL2t4JGGdjFrn3XZwBVG9F97cAQb8RsouQZBjVNVlljY0CH7I4qVCxJPzanyQSnmuI
         z71LOW9oAQWGsSJ1NUqzh5Vrqxv/E0Jt45Av/0yEAyBFuJciQZXRDGzQkl/3ilBDl5vR
         jKsqrChDzxht2TufcoW2BxuBTd7zqUeVt/m99Tym+LFF8zmYzhKc1GWZowCKaAWNH6FN
         Y8Sz6J6ClIh39VVIbK6GaQ6pwV6GArpJpzIClZo9pXpaDCVMFxz9DSlMeibVUkc8PRwG
         9kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CF0auyXfFKE1IEYVq03Jkg+soFc4skAhc1lxx6fAtcg=;
        b=RQ8FW+xcW5doJ68GVrn7C/jr+iD4/gP0pV1JKokXWuSxCMWWKIY3OPdufc9HZG74U2
         56ZBk7YnYHEDxwQIlaNvPBJ2PUWHuUPC3DavilVbzlQt916NipAV/zyofXC60gx4tw9A
         qYAn68HPV4q12rxh+XPE8J0SZVYXMqul5NDtGJHVKyp019+jvUvnMMR1pi5TgHUfcna2
         J1Swjv/7fii9FhQddnGmbZrqMeUg4HANzA+r9P9oFDiXySDr9NmU1hTdv9TfjdBtCGjc
         hhqaCGXNle/CQADYU+3f7VT4D3jqCypCN/ZblhdWV64Yt3LYO2BQFBdEclpwBDJ8eONv
         W1Uw==
X-Gm-Message-State: AOAM5310dA1P9c8YZmF/jKe2WMhdks+nln57irRGKDSt5hsWWBcuuGxF
        b/u4+SjbAPtDMjR07uR3VOK16A==
X-Google-Smtp-Source: ABdhPJzKJWYQyKWHxR8pIvNPFkTCP1Kls8SRhFx7AdpdZ5ZMRZ5hqgrfl3+Hv7AKQVSi09LI0EwDXA==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mr8341153pjw.39.1643812479607;
        Wed, 02 Feb 2022 06:34:39 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id s9sm29079268pgm.76.2022.02.02.06.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:34:39 -0800 (PST)
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
Subject: [PATCH v2 3/6] mm: page_vma_mapped: support checking if a pfn is mapped into a vma
Date:   Wed,  2 Feb 2022 22:33:04 +0800
Message-Id: <20220202143307.96282-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220202143307.96282-1-songmuchun@bytedance.com>
References: <20220202143307.96282-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

page_vma_mapped_walk() is supposed to check if a page is mapped into a vma.
However, not all page frames (e.g. PFN_DEV) have a associated struct page
with it. There is going to be some duplicate codes similar with this function
if someone want to check if a pfn (without a struct page) is mapped into a
vma. So add support for checking if a pfn is mapped into a vma. In the next
patch, the dax will use this new feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/rmap.h    | 14 ++++++++--
 include/linux/swapops.h | 13 +++++++---
 mm/internal.h           | 28 +++++++++++++-------
 mm/page_vma_mapped.c    | 68 +++++++++++++++++++++++++++++++------------------
 4 files changed, 83 insertions(+), 40 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 221c3c6438a7..78373935ad49 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -204,9 +204,18 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migarion entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Walk the page table by checking the pfn instead of a struct page */
+#define PVMW_PFN_WALK		(1 << 2)
 
 struct page_vma_mapped_walk {
-	struct page *page;
+	union {
+		struct page *page;
+		struct {
+			unsigned long pfn;
+			unsigned int nr;
+			pgoff_t index;
+		};
+	};
 	struct vm_area_struct *vma;
 	unsigned long address;
 	pmd_t *pmd;
@@ -218,7 +227,8 @@ struct page_vma_mapped_walk {
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 {
 	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
-	if (pvmw->pte && !PageHuge(pvmw->page))
+	if (pvmw->pte && (pvmw->flags & PVMW_PFN_WALK ||
+			  !PageHuge(pvmw->page)))
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d356ab4047f7..d28bf65fd6a5 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -247,17 +247,22 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
 
 #endif
 
-static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
+static inline unsigned long pfn_swap_entry_to_pfn(swp_entry_t entry)
 {
-	struct page *p = pfn_to_page(swp_offset(entry));
+	unsigned long pfn = swp_offset(entry);
 
 	/*
 	 * Any use of migration entries may only occur while the
 	 * corresponding page is locked
 	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
+	BUG_ON(is_migration_entry(entry) && !PageLocked(pfn_to_page(pfn)));
+
+	return pfn;
+}
 
-	return p;
+static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
+{
+	return pfn_to_page(pfn_swap_entry_to_pfn(entry));
 }
 
 /*
diff --git a/mm/internal.h b/mm/internal.h
index deb9bda18e59..5458cd08df33 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -478,25 +478,35 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 }
 
 /*
- * Then at what user virtual address will none of the page be found in vma?
- * Assumes that vma_address() already returned a good starting address.
- * If page is a compound head, the entire compound page is considered.
+ * Return the end of user virtual address at the specific offset within
+ * a vma.
  */
 static inline unsigned long
-vma_address_end(struct page *page, struct vm_area_struct *vma)
+vma_pgoff_address_end(pgoff_t pgoff, unsigned long nr_pages,
+		      struct vm_area_struct *vma)
 {
-	pgoff_t pgoff;
-	unsigned long address;
+	unsigned long address = vma->vm_start;
 
-	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
-	pgoff = page_to_pgoff(page) + compound_nr(page);
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	address += (pgoff + nr_pages - vma->vm_pgoff) << PAGE_SHIFT;
 	/* Check for address beyond vma (or wrapped through 0?) */
 	if (address < vma->vm_start || address > vma->vm_end)
 		address = vma->vm_end;
 	return address;
 }
 
+/*
+ * Return the end of user virtual address of a page within a vma. Assumes that
+ * vma_address() already returned a good starting address. If page is a compound
+ * head, the entire compound page is considered.
+ */
+static inline unsigned long
+vma_address_end(struct page *page, struct vm_area_struct *vma)
+{
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	return vma_pgoff_address_end(page_to_pgoff(page), compound_nr(page),
+				     vma);
+}
+
 static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 						    struct file *fpin)
 {
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..bd172268084f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -53,10 +53,17 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
-static inline bool pfn_is_match(struct page *page, unsigned long pfn)
+static inline bool pfn_is_match(struct page_vma_mapped_walk *pvmw,
+				unsigned long pfn)
 {
-	unsigned long page_pfn = page_to_pfn(page);
+	struct page *page;
+	unsigned long page_pfn;
 
+	if (pvmw->flags & PVMW_PFN_WALK)
+		return pfn >= pvmw->pfn && pfn - pvmw->pfn < pvmw->nr;
+
+	page = pvmw->page;
+	page_pfn = page_to_pfn(page);
 	/* normal page and hugetlbfs page */
 	if (!PageTransCompound(page) || PageHuge(page))
 		return page_pfn == pfn;
@@ -116,7 +123,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		pfn = pte_pfn(*pvmw->pte);
 	}
 
-	return pfn_is_match(pvmw->page, pfn);
+	return pfn_is_match(pvmw, pfn);
 }
 
 static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
@@ -127,24 +134,24 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
 }
 
 /**
- * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
- * @pvmw->address
- * @pvmw: pointer to struct page_vma_mapped_walk. page, vma, address and flags
- * must be set. pmd, pte and ptl must be NULL.
+ * page_vma_mapped_walk - check if @pvmw->page or @pvmw->pfn is mapped in
+ * @pvmw->vma at @pvmw->address
+ * @pvmw: pointer to struct page_vma_mapped_walk. page (or pfn and nr and
+ * index), vma, address and flags must be set. pmd, pte and ptl must be NULL.
  *
- * Returns true if the page is mapped in the vma. @pvmw->pmd and @pvmw->pte point
- * to relevant page table entries. @pvmw->ptl is locked. @pvmw->address is
- * adjusted if needed (for PTE-mapped THPs).
+ * Returns true if the page or pfn is mapped in the vma. @pvmw->pmd and
+ * @pvmw->pte point to relevant page table entries. @pvmw->ptl is locked.
+ * @pvmw->address is adjusted if needed (for PTE-mapped THPs).
  *
  * If @pvmw->pmd is set but @pvmw->pte is not, you have found PMD-mapped page
- * (usually THP). For PTE-mapped THP, you should run page_vma_mapped_walk() in
- * a loop to find all PTEs that map the THP.
+ * (usually THP or Huge DEVMAP). For PMD-mapped page, you should run
+ * page_vma_mapped_walk() in a loop to find all PTEs that map the huge page.
  *
  * For HugeTLB pages, @pvmw->pte is set to the relevant page table entry
  * regardless of which page table level the page is mapped at. @pvmw->pmd is
  * NULL.
  *
- * Returns false if there are no more page table entries for the page in
+ * Returns false if there are no more page table entries for the page or pfn in
  * the vma. @pvmw->ptl is unlocked and @pvmw->pte is unmapped.
  *
  * If you need to stop the walk before page_vma_mapped_walk() returned false,
@@ -153,8 +160,9 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 {
 	struct mm_struct *mm = pvmw->vma->vm_mm;
-	struct page *page = pvmw->page;
+	struct page *page = NULL;
 	unsigned long end;
+	unsigned long pfn;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -164,7 +172,11 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
 
-	if (unlikely(PageHuge(page))) {
+	if (!(pvmw->flags & PVMW_PFN_WALK))
+		page = pvmw->page;
+	pfn = page ? page_to_pfn(page) : pvmw->pfn;
+
+	if (unlikely(page && PageHuge(page))) {
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
@@ -187,9 +199,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	 * any PageKsm page: whose page->index misleads vma_address()
 	 * and vma_address_end() to disaster.
 	 */
-	end = PageTransCompound(page) ?
-		vma_address_end(page, pvmw->vma) :
-		pvmw->address + PAGE_SIZE;
+	if (page)
+		end = PageTransCompound(page) ?
+		      vma_address_end(page, pvmw->vma) :
+		      pvmw->address + PAGE_SIZE;
+	else
+		end = vma_pgoff_address_end(pvmw->index, pvmw->nr, pvmw->vma);
+
 	if (pvmw->pte)
 		goto next_pte;
 restart:
@@ -217,14 +233,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 * subsequent update.
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
-
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		if (pmd_leaf(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (likely(pmd_trans_huge(pmde))) {
+			if (likely(pmd_leaf(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
-				if (pmd_page(pmde) != page)
+				if (pmd_pfn(pmde) != pfn)
 					return not_found(pvmw);
 				return true;
 			}
@@ -236,20 +252,22 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
-				    pfn_swap_entry_to_page(entry) != page)
+				    pfn_swap_entry_to_pfn(entry) != pfn)
 					return not_found(pvmw);
 				return true;
 			}
 			/* THP pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
-		} else if (!pmd_present(pmde)) {
+		} else
+#endif
+		if (!pmd_present(pmde)) {
 			/*
 			 * If PVMW_SYNC, take and drop THP pmd lock so that we
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
-			if ((pvmw->flags & PVMW_SYNC) &&
+			if ((pvmw->flags & PVMW_SYNC) && page &&
 			    PageTransCompound(page)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
-- 
2.11.0

