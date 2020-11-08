Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A22AAB73
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgKHONO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgKHONM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:12 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D56C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:12 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so5534953pfn.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64D+N+0MVvWM9CdOj8pR+qrCH2heyzoEsv3UfStivXA=;
        b=YHO0BKW1fx79wDC79BAWuug52MyDh/EgB0rN0ElAB9xnF4PrR92u3HE3v40ok0kdac
         Ce2dmTu5RhvZytZ+2S1UUtw4AJtqKON6ls6JXd7gcWeLyI+ac5Uufimi8HjBdZcrFz6/
         tWDZ82uKhV6s2Sy83UaBq7ngmX+THsslF35dEBnMSMkZPN1taDe2wXF0V6Sj3LAdtHdm
         5e4vuoIHAfZTdAUUneBe7MOtWX/v/DQgbnIC9CHVJV9xUpiwdemzcveUC41tAaOmwdKB
         93i05RfYj2lcfS+2rL2a5OJKF2CylWBygSnTkA6tvgVUW6VuUH+nPMRQ1HeJwqIrOIOH
         6jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64D+N+0MVvWM9CdOj8pR+qrCH2heyzoEsv3UfStivXA=;
        b=dbyMhvOWYifQbsxOGaOl9jT70dU8szE91eSpzYRZJsQQR9ghN9sZzgfUc6iW9vGTLc
         CMkqsgzidX5lB1ACse/UksXGDoCfPIrMq/7VLjp+SSgkI3Xq/Hc5kXZqYn6g2ZdPNwrU
         FAvE9oCDROqk+Fldca5L7m/N21+eUqI7ukW0pe+QmYVB5WeHnnKmO2BXyj72Bdo79Q0o
         7VU4z2IP+l0guQPn3biiiknSTWfMpfilJr+/pt0+sUpUv46mv6xAqDFozrSowddW1bJy
         2DFstiDpR8FzuhpqPuMA8r2WWOSDsg31WP0ygCn58cWdGa2EFmJAq+syR8RuSVHV4pbj
         zpUA==
X-Gm-Message-State: AOAM533l7QKY7a3fpiWcXmJnqwlVhHQQARxfmxR9r5iAbXM/3l4pSVzL
        tD/roT9EKXGvaPW8xrzprb30iQ==
X-Google-Smtp-Source: ABdhPJz0e561hXaRylaWrB6gD59rsigwP9Yo2wg0eYXAjwErF0d71vHGZgInuk9nCvTWwBld6fO54A==
X-Received: by 2002:a63:df01:: with SMTP id u1mr9399642pgg.140.1604844791532;
        Sun, 08 Nov 2020 06:13:11 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:11 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 09/21] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
Date:   Sun,  8 Nov 2020 22:11:01 +0800
Message-Id: <20201108141113.65450-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we allocate a hugetlb page from the buddy, we should free the
unused vmemmap pages associated with it. We can do that in the
prep_new_huge_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h          |   9 ++
 arch/x86/include/asm/pgtable_64_types.h |   8 ++
 include/linux/hugetlb.h                 |   8 ++
 include/linux/mm.h                      |   4 +
 mm/hugetlb.c                            | 166 ++++++++++++++++++++++++++++++++
 mm/sparse-vmemmap.c                     |  31 ++++++
 6 files changed, 226 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 1721b1aadeb1..c601fe042832 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -4,6 +4,15 @@
 
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
+#include <asm/pgtable.h>
+
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#define vmemmap_pmd_huge vmemmap_pmd_huge
+static inline bool vmemmap_pmd_huge(pmd_t *pmd)
+{
+	return pmd_large(*pmd);
+}
+#endif
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f2240d..bedbd2e7d06c 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -139,6 +139,14 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+/*
+ * VMEMMAP_SIZE - allows the whole linear region to be covered by
+ *                a struct page array.
+ */
+#define VMEMMAP_SIZE		(1UL << (__VIRTUAL_MASK_SHIFT - PAGE_SHIFT - \
+					 1 + ilog2(sizeof(struct page))))
+#define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
+
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d81c262418db..afb9b18771c4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -594,6 +594,14 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 #include <asm/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#ifndef vmemmap_pmd_huge
+#define vmemmap_pmd_huge vmemmap_pmd_huge
+static inline bool vmemmap_pmd_huge(pmd_t *pmd)
+{
+	return pmd_huge(*pmd);
+}
+#endif
+
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce429614d1ab..480faca94c23 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3025,6 +3025,10 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+pmd_t *vmemmap_to_pmd(const void *page);
+#endif
+
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c7be2ee7e15..27f0269aab70 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,6 +1293,8 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#include <linux/bootmem_info.h>
+
 /*
  * There are 512 struct page structs(8 pages) associated with each 2MB
  * hugetlb page. For tail pages, the value of compound_dtor is the same.
@@ -1305,6 +1307,13 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 
 #define page_huge_pte(page)	((page)->pmd_huge_pte)
 
+#define vmemmap_hpage_addr_end(addr, end)				\
+({									\
+	unsigned long __boundary;					\
+	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK;\
+	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
+})
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -1424,6 +1433,147 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_debug("HugeTLB: can free %d vmemmap pages for %s\n",
 		 h->nr_free_vmemmap_pages, h->name);
 }
+
+static inline int freed_vmemmap_hpage(struct page *page)
+{
+	return atomic_read(&page->_mapcount) + 1;
+}
+
+static inline int freed_vmemmap_hpage_inc(struct page *page)
+{
+	return atomic_inc_return_relaxed(&page->_mapcount) + 1;
+}
+
+static inline int freed_vmemmap_hpage_dec(struct page *page)
+{
+	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
+}
+
+static inline void free_vmemmap_page_list(struct list_head *list)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, list, lru) {
+		list_del(&page->lru);
+		free_vmemmap_page(page);
+	}
+}
+
+static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					 unsigned long start,
+					 unsigned int nr_free,
+					 struct list_head *free_pages)
+{
+	/* Make the tail pages are mapped read-only. */
+	pgprot_t pgprot = PAGE_KERNEL_RO;
+	pte_t entry = mk_pte(reuse, pgprot);
+	unsigned long addr;
+	unsigned long end = start + (nr_free << PAGE_SHIFT);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct page *page;
+		pte_t old = *ptep;
+
+		VM_WARN_ON(!pte_present(old));
+		page = pte_page(old);
+		list_add(&page->lru, free_pages);
+
+		set_pte_at(&init_mm, addr, ptep, entry);
+	}
+}
+
+static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					 unsigned long addr,
+					 struct list_head *free_pages)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+	struct page *reuse = NULL;
+
+	addr = start;
+	do {
+		unsigned int nr_pages;
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse)
+			reuse = pte_page(ptep[-1]);
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		nr_pages = (next - addr) >> PAGE_SHIFT;
+		__free_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
+					     free_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long addr)
+{
+	int i;
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct mm_struct *mm = &init_mm;
+	struct page *page;
+	pmd_t old_pmd, _pmd;
+
+	old_pmd = READ_ONCE(*pmd);
+	page = pmd_page(old_pmd);
+	pmd_populate_kernel(mm, &_pmd, pte_p);
+
+	for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
+		pte_t entry, *pte;
+
+		entry = mk_pte(page + i, pgprot);
+		pte = pte_offset_kernel(&_pmd, addr);
+		VM_BUG_ON(!pte_none(*pte));
+		set_pte_at(mm, addr, pte, entry);
+	}
+
+	/* make pte visible before pmd */
+	smp_wmb();
+	pmd_populate_kernel(mm, pmd, pte_p);
+}
+
+static void split_vmemmap_huge_page(struct hstate *h, struct page *head,
+				    pmd_t *pmd)
+{
+	pgtable_t pgtable;
+	unsigned long start = (unsigned long)head & VMEMMAP_HPAGE_MASK;
+	unsigned long addr = start;
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	while (nr-- && (pgtable = vmemmap_pgtable_withdraw(head))) {
+		VM_BUG_ON(freed_vmemmap_hpage(pgtable));
+		split_vmemmap_pmd(pmd++, page_to_virt(pgtable), addr);
+		addr += VMEMMAP_HPAGE_SIZE;
+	}
+
+	flush_tlb_kernel_range(start, addr);
+}
+
+static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	spinlock_t *ptl;
+	LIST_HEAD(free_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	pmd = vmemmap_to_pmd(head);
+	ptl = vmemmap_pmd_lock(pmd);
+	if (vmemmap_pmd_huge(pmd)) {
+		VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));
+		split_vmemmap_huge_page(h, head, pmd);
+	}
+
+	__free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages);
+	freed_vmemmap_hpage_inc(pmd_page(*pmd));
+	spin_unlock(ptl);
+
+	free_vmemmap_page_list(&free_pages);
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -1437,6 +1587,10 @@ static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
 static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 {
 }
+
+static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1645,6 +1799,10 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	free_huge_page_vmemmap(h, page);
+	/* Must be called before the initialization of @page->lru */
+	vmemmap_pgtable_free(h, page);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
@@ -1897,6 +2055,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
 	if (!page)
 		return NULL;
 
+	if (vmemmap_pgtable_prealloc(h, page)) {
+		if (hstate_is_gigantic(h))
+			free_gigantic_page(page, huge_page_order(h));
+		else
+			put_page(page);
+		return NULL;
+	}
+
 	if (hstate_is_gigantic(h))
 		prep_compound_gigantic_page(page, huge_page_order(h));
 	prep_new_huge_page(h, page, page_to_nid(page));
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 16183d85a7d5..4b35d1655a2f 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -263,3 +263,34 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 
 	return pfn_to_page(pfn);
 }
+
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+/*
+ * Walk a vmemmap address to the pmd it maps.
+ */
+pmd_t *vmemmap_to_pmd(const void *page)
+{
+	unsigned long addr = (unsigned long)page;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (addr < VMEMMAP_START || addr >= VMEMMAP_END)
+		return NULL;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return NULL;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return NULL;
+	pud = pud_offset(p4d, addr);
+
+	if (pud_none(*pud) || pud_bad(*pud))
+		return NULL;
+	pmd = pmd_offset(pud, addr);
+
+	return pmd;
+}
+#endif
-- 
2.11.0

