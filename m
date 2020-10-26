Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DC2299014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782280AbgJZOyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46916 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782277AbgJZOyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id n16so6182457pgv.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOQBPrLea1xYh30g5dbI5dHqQ1Tf/OIcvAEX9V/audc=;
        b=c14kVtBdL860AzkmibdXeFk+Fd0yeHG5hqqQgtx9DBmsaDQa7jUhRw8qhRRFgJ2dui
         jf0yJsVqoKmTlnnug9pzmEkBSWlHbfPlV6qTj4qZ1IOBNwm0MkS5l8efAIq4CSfzcW34
         rIPpXUMfccQxzf/HBLLvTiaw8lB0XWPx1f0ERFnnq/YdTWL8i+SigJPwADTknI0GbiTk
         Vql9TDCtsCIEaBsdtErRY88sYVUDPM4AyGcFo/H1AM8FhMMpcicRsijllQend2o0QlyY
         gejLTgm1AK0OOayZMnP3DW5xhFs8QPyXNmjck8ZLhhtfoK16iz8fqpaCjANkBYY6fzjI
         syxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOQBPrLea1xYh30g5dbI5dHqQ1Tf/OIcvAEX9V/audc=;
        b=lFyviKtT6cc6yLf27grJCS/sybjb6y3/S+vPM+cCVU/U8LHSRYsFW2sH/blnjTdRAs
         f98yS6AvhDQzJ+mNoW/b96HOW8YUzdWS+5EvhoYYryOhQFDmI6Lge52WoerokHpdoXvX
         N7Bm6NfPAwUYLMU9EPQV9qoOGEEWplbn5ZY0FJeyw1DAB5ESGxEReJHsBymCOJtuY6+f
         B6AW5uAdFex8lz6KbEsloHrLr6foogVki/we6KhottXwYQlz7tXL6N5H3p8asjxjWC2o
         2bEIyUuGIBR7oyyYih55Ab9BimnRsqsR3APe0Uan/cZB/Puxitcv3CrARKKj7T2gdlyi
         aYfA==
X-Gm-Message-State: AOAM533cfDmBQv6/nPhvOj0MYCt43KaB7zR0os9ecIF7KZot8J7oZf6s
        gbqTkIJbKpR0usHtOZ5/9aTo+g==
X-Google-Smtp-Source: ABdhPJziMcFX+OA+HsStpcuaJ+RhW9PGzdHIeCdjh8oDIaMgdqx1Ps886AFsKgucjHa2K6hPtULvOQ==
X-Received: by 2002:a63:3346:: with SMTP id z67mr13659142pgz.172.1603724058133;
        Mon, 26 Oct 2020 07:54:18 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:54:17 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
Date:   Mon, 26 Oct 2020 22:51:02 +0800
Message-Id: <20201026145114.59424-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
 arch/x86/include/asm/hugetlb.h          |   7 +
 arch/x86/include/asm/pgtable_64_types.h |   8 +
 include/linux/hugetlb.h                 |   7 +
 mm/hugetlb.c                            | 190 ++++++++++++++++++++++++
 4 files changed, 212 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index f5e882f999cd..7c3eb60c2198 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -4,10 +4,17 @@
 
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
+#include <asm/pgtable.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
 #define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)
+
+#define vmemmap_pmd_huge vmemmap_pmd_huge
+static inline bool vmemmap_pmd_huge(pmd_t *pmd)
+{
+	return pmd_large(*pmd);
+}
 #endif
 
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
index ace304a6196c..919f47d77117 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -601,6 +601,13 @@ static inline bool arch_vmemmap_support_huge_mapping(void)
 }
 #endif
 
+#ifndef vmemmap_pmd_huge
+static inline bool vmemmap_pmd_huge(pmd_t *pmd)
+{
+	return pmd_huge(*pmd);
+}
+#endif
+
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		PMD_SHIFT
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6ae9b6876be..aa012d603e06 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,10 +1293,20 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#include <linux/bootmem_info.h>
+
 #define RESERVE_VMEMMAP_NR	2U
+#define RESERVE_VMEMMAP_SIZE	(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
 #define page_huge_pte(page)	((page)->pmd_huge_pte)
 
+#define vmemmap_hpage_addr_end(addr, end)				\
+({									\
+	unsigned long __boundary;					\
+	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK;\
+	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
+})
+
 static inline unsigned int nr_free_vmemmap(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -1416,6 +1426,181 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
 		h->nr_free_vmemmap_pages, h->name);
 }
+
+static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
+{
+	static DEFINE_SPINLOCK(pgtable_lock);
+
+	return &pgtable_lock;
+}
+
+/*
+ * Walk a vmemmap address to the pmd it maps.
+ */
+static pmd_t *vmemmap_to_pmd(const void *page)
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
+	WARN_ON_ONCE(pud_bad(*pud));
+	if (pud_none(*pud) || pud_bad(*pud))
+		return NULL;
+	pmd = pmd_offset(pud, addr);
+
+	return pmd;
+}
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
+	pte_t entry = mk_pte(reuse, PAGE_KERNEL);
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
+	unsigned long end = addr + nr_vmemmap_size(h);
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
+	struct mm_struct *mm = &init_mm;
+	struct page *page;
+	pmd_t old_pmd, _pmd;
+	int i;
+
+	old_pmd = READ_ONCE(*pmd);
+	page = pmd_page(old_pmd);
+	pmd_populate_kernel(mm, &_pmd, pte_p);
+
+	for (i = 0; i < VMEMMAP_HPAGE_NR; i++, addr += PAGE_SIZE) {
+		pte_t entry, *pte;
+
+		entry = mk_pte(page + i, PAGE_KERNEL);
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
+static void split_vmemmap_huge_page(struct page *head, pmd_t *pmd)
+{
+	pte_t *pte_p;
+	unsigned long start = (unsigned long)head & VMEMMAP_HPAGE_MASK;
+	unsigned long addr = start;
+
+	while ((pte_p = vmemmap_pgtable_withdraw(head))) {
+		VM_BUG_ON(freed_vmemmap_hpage(virt_to_page(pte_p)));
+		split_vmemmap_pmd(pmd++, pte_p, addr);
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
+	if (!nr_free_vmemmap(h))
+		return;
+
+	pmd = vmemmap_to_pmd(head);
+	ptl = vmemmap_pmd_lockptr(pmd);
+
+	spin_lock(ptl);
+	if (vmemmap_pmd_huge(pmd)) {
+		VM_BUG_ON(!nr_pgtable(h));
+		split_vmemmap_huge_page(head, pmd);
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
@@ -1429,6 +1614,10 @@ static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
 static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 {
 }
+
+static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1637,6 +1826,7 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	free_huge_page_vmemmap(h, page);
 	/* Must be called before the initialization of @page->lru */
 	vmemmap_pgtable_free(h, page);
 
-- 
2.20.1

