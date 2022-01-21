Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4B495B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379278AbiAUH5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379281AbiAUH4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:42 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F3C061749
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u130so3884132pfc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LmIcTdcw5bzUgUHpTw2bCJj+na0Z521FW9c8N2esaA=;
        b=22o48qCSnTj2QsxfYrrrbTL2ZLTm+5kp2xt+PBrL9IZCu9VTNf2HZ3MMuvMQFJ6WEJ
         fmNxtfezvbSk4mnjwpp2ukyS+dKOMFksQ028ZzDT1FqcskGpB96N9Bcfy40H6A8ihVhI
         uI9gm4ueLnW6R8rpV6zLadbIH/0jVYVlr1A+5jalDSFrhdR0v7RrQQ068CGvsA6zrPc8
         VCTYJrwrANLegGUjsFr1h+iltnH9DYWPvuBzErK6f8iprm57Mp5la3lraJzZXNihYYFc
         uoixMu00KyHpoxby/B8l6QqpgcXtGuIndYXP9RAS3xwC2Pc492eaA5BtC6zhfXJEKolZ
         jmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LmIcTdcw5bzUgUHpTw2bCJj+na0Z521FW9c8N2esaA=;
        b=kcHtkiSh6phujWJgelzRUfyYBerJ3x1/MbNRQE+aMWJUnoy0y0NrH894MkuaY0Syw2
         WGT+rJ/V+PO2dSIgDFCERVPIkyYAnwHlm2tL16IVoWAET6S5/E2GuxxijqCX8Gj+VBDW
         tvzDLifdxxAo4fNNaUAOtQ03WtSoiLd8TIVL+SbopKjEhEKmIJvDQnPbDiLyzwonouMF
         60qg6ymN67kbjSWq66bGnhhdsLnWN8n8Qsb1rag6eGiUY8qWEB1DiHuX5WJVN5q7PcqL
         p59jaFSH9D1MT5c7rTznzCvD/ssC+wj07apD3WTMH+htwhqjHFc6nnkc3SjOaTkHH2vd
         QIiA==
X-Gm-Message-State: AOAM532KthrfMxRUhHQq1BWSCOocZaYpuuYRpXXNn4WxBnXAo7cs8gQJ
        Pu7C+iiB+BWKNb9je9YiFFhlZg==
X-Google-Smtp-Source: ABdhPJxZsh1kEVKkZgg5mmiTTuA7SA5fu83x81BaMEGYdZzVIbC0H3RSF/yR7MaU91mltsILBevkGg==
X-Received: by 2002:a63:c5e:: with SMTP id 30mr2122312pgm.522.1642751801695;
        Thu, 20 Jan 2022 23:56:41 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t15sm10778178pjy.17.2022.01.20.23.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:56:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/5] mm: page_vma_mapped: support checking if a pfn is mapped into a vma
Date:   Fri, 21 Jan 2022 15:55:13 +0800
Message-Id: <20220121075515.79311-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220121075515.79311-1-songmuchun@bytedance.com>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
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
 include/linux/rmap.h | 13 +++++++++--
 mm/internal.h        | 25 +++++++++++++-------
 mm/page_vma_mapped.c | 65 +++++++++++++++++++++++++++++++++-------------------
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 221c3c6438a7..7628474732e7 100644
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
@@ -218,7 +227,7 @@ struct page_vma_mapped_walk {
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 {
 	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
-	if (pvmw->pte && !PageHuge(pvmw->page))
+	if (pvmw->pte && ((pvmw->flags & PVMW_PFN_WALK) || !PageHuge(pvmw->page)))
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
diff --git a/mm/internal.h b/mm/internal.h
index deb9bda18e59..d6e3e8e1be2d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -478,25 +478,34 @@ vma_address(struct page *page, struct vm_area_struct *vma)
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
 	unsigned long address;
 
-	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
-	pgoff = page_to_pgoff(page) + compound_nr(page);
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	address = vma->vm_start + ((pgoff + nr_pages - vma->vm_pgoff) << PAGE_SHIFT);
 	/* Check for address beyond vma (or wrapped through 0?) */
 	if (address < vma->vm_start || address > vma->vm_end)
 		address = vma->vm_end;
 	return address;
 }
 
+/*
+ * Then at what user virtual address will none of the page be found in vma?
+ * Assumes that vma_address() already returned a good starting address.
+ * If page is a compound head, the entire compound page is considered.
+ */
+static inline unsigned long
+vma_address_end(struct page *page, struct vm_area_struct *vma)
+{
+	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
+	return vma_pgoff_address_end(page_to_pgoff(page), compound_nr(page), vma);
+}
+
 static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 						    struct file *fpin)
 {
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index f7b331081791..c8819770d457 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -53,10 +53,16 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
-static inline bool pfn_is_match(struct page *page, unsigned long pfn)
+static inline bool pfn_is_match(struct page_vma_mapped_walk *pvmw, unsigned long pfn)
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
@@ -116,7 +122,7 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 		pfn = pte_pfn(*pvmw->pte);
 	}
 
-	return pfn_is_match(pvmw->page, pfn);
+	return pfn_is_match(pvmw, pfn);
 }
 
 static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
@@ -127,24 +133,24 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
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
@@ -153,18 +159,27 @@ static void step_forward(struct page_vma_mapped_walk *pvmw, unsigned long size)
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 {
 	struct mm_struct *mm = pvmw->vma->vm_mm;
-	struct page *page = pvmw->page;
+	struct page *page;
 	unsigned long end;
+	unsigned long pfn;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t pmde;
 
+	if (pvmw->flags & PVMW_PFN_WALK) {
+		page = NULL;
+		pfn = pvmw->pfn;
+	} else {
+		page = pvmw->page;
+		pfn = page_to_pfn(page);
+	}
+
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
 
-	if (unlikely(PageHuge(page))) {
+	if (unlikely(page && PageHuge(page))) {
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
@@ -187,9 +202,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
@@ -218,13 +237,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = READ_ONCE(*pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
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
@@ -236,7 +255,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				entry = pmd_to_swp_entry(pmde);
 				if (!is_migration_entry(entry) ||
-				    pfn_swap_entry_to_page(entry) != page)
+				    page_to_pfn(pfn_swap_entry_to_page(entry)) != pfn)
 					return not_found(pvmw);
 				return true;
 			}
@@ -249,7 +268,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
-			if ((pvmw->flags & PVMW_SYNC) &&
+			if ((pvmw->flags & PVMW_SYNC) && page &&
 			    PageTransCompound(page)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
-- 
2.11.0

