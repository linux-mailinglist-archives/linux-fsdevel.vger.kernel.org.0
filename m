Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711926A5D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIONCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgIONBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0EC06121F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so1864610pfc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsxmZcqzO6oU2083Ec8NK/i5aqIGoDCXPmpK1JpMhHU=;
        b=CIREYWgKG0y5bTAmfbfktZFdPjKSEU5cI0my0xWoAHXu+phapP2kzdoqZzP6oYfOp3
         cb4tRG/CCuRHFZ+6hp7B2cKqVKnxHSahJWMv8b0/e5uL2bgioa+c9ywrNOFjOnuF/npb
         kX9duhMqixMx+wAx3eKjaFg2lHcB5/E4G8bk22aQt9Fj+yhzl8+V7cHeRpa7f4tEMwDj
         bluG5qNuHjNaL/6aL6rzp08uMymBXb3yObzuvpM2y/vs4+sbI+kiqkiA8b6R/BumcJGW
         xVf1CpmkgPa8/mBrF+zK/uzyRXEmqVRi1adqci4i1LHQ6Wq/LVLdGw4A7wkgzlMYjVxX
         C2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsxmZcqzO6oU2083Ec8NK/i5aqIGoDCXPmpK1JpMhHU=;
        b=h5fJJfg0ZzhBzugtZjqcgizWR9bF61w8RCqCrcmZlPZJl5fPEVqXYN7rWW0IOTBg8W
         cIF7mEGGB25ymxfnexv/6LbuPDtV9Ay9oK2LeaEagjdwE2VrPCpP/G59dCL01eS0TFLT
         7DhWuaU1BzDV6ay8fFMsc0poOVLrBF5sqTIKEQm2dskNWrklOsXEk0vmSwlrQQoik8P6
         k6cNFp/QzQl8flFXsd+ukLoXNZ0gXuQ9OAhGlcs4LmabKA7msxbOwxgKNaZAZd4gV/1z
         s+P5OpBgkIRf+hqJh30P1ZuLm1bv7mqezImfOJRge9XErZk0nCxuDtOCvXhz3EUiAPUL
         p68w==
X-Gm-Message-State: AOAM531Bzdj1zsBx5VS/AGGYeINKCNMssea5Zif5GGMU9EzlM0Xi34L0
        3oJMBg8Js8A7srjo1znJsTsvFg==
X-Google-Smtp-Source: ABdhPJzjBmfywPW7QQgadAqZhmFowNmnURIr9fhphcku0u1eDJDwXVAKp3ksTUFTm+nEemFa1C0ZpQ==
X-Received: by 2002:a63:2c44:: with SMTP id s65mr8444889pgs.210.1600174905697;
        Tue, 15 Sep 2020 06:01:45 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:45 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 10/24] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
Date:   Tue, 15 Sep 2020 20:59:33 +0800
Message-Id: <20200915125947.26204-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we allocate a hugetlb page from the buddy, we should free the
unused vmemmap pages associated with it. We can do that in the
prep_new_huge_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  21 ++++
 mm/hugetlb.c            | 231 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ace304a6196c..2561af2ad901 100644
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
@@ -790,6 +797,15 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+int handle_vmemmap_fault(unsigned long page);
+#else
+static inline int handle_vmemmap_fault(unsigned long page)
+{
+	return -EFAULT;
+}
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -943,6 +959,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline int handle_vmemmap_fault(unsigned long page)
+{
+	return -EFAULT;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6ae9b6876be..a628588a075a 100644
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
@@ -1416,6 +1426,222 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
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
+	unsigned long end = start + (nr_free  << PAGE_SHIFT);
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
+	/*
+	 * Up to this point the pmd is present and huge and userland has the
+	 * whole access to the hugepage during the split (which happens in
+	 * place). If we overwrite the pmd with the not-huge version pointing
+	 * to the pte here (which of course we could if all CPUs were bug
+	 * free), userland could trigger a small page size TLB miss on the
+	 * small sized TLB while the hugepage TLB entry is still established in
+	 * the huge TLB. Some CPU doesn't like that.
+	 *
+	 * See http://support.amd.com/us/Processor_TechDocs/41322.pdf, Erratum
+	 * 383 on page 93. Intel should be safe but is also warns that it's
+	 * only safe if the permission and cache attributes of the two entries
+	 * loaded in the two TLB is identical (which should be the case here).
+	 *
+	 * So it is generally safer to never allow small and huge TLB entries
+	 * for the same virtual address to be loaded simultaneously. But here
+	 * we should not set pmd non-present first and flush TLB. Because if
+	 * we do that(maybe trriger IPI to other CPUs to flush TLB), we may be
+	 * deadlocked. So we have to break the above rules. Be careful, Let us
+	 * suppose all CPUs are bug free, otherwise, we should not enable the
+	 * feature of freeing unused vmemmap pages on the bug CPU.
+	 *
+	 * Why we should not set pmd non-present first? Here we already hold
+	 * the vmemmap pgtable spinlock on CPU1 and set pmd non-present. If
+	 * CPU0 access the struct page with irqs disabled and the vmemmap
+	 * pgtable lock is held by CPU1. In this case, the CPU0 can not handle
+	 * the IPI interrupt to flush TLB because of the disabling of irqs.
+	 * Then we can deadlock. In order to avoid this issue, we do not set
+	 * pmd non-present.
+	 *
+	 * The deadlock scene is shown below.
+	 *
+	 *     CPU0:                                        CPU1:
+	 * disable irqs                           hold the vmemmap pgtable lock
+	 *                                        set pmd non-present
+	 * read/write `struct page`(page fault)
+	 * jump to handle_vmemmap_fault
+	 * spin for vmemmap pgtable lock
+	 *                                        flush_tlb(send IPI to CPU0)
+	 *                                        set new pmd(small page)
+	 */
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
@@ -1429,6 +1655,10 @@ static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
 static inline void vmemmap_pgtable_free(struct hstate *h, struct page *page)
 {
 }
+
+static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1637,6 +1867,7 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	free_huge_page_vmemmap(h, page);
 	/* Must be called before the initialization of @page->lru */
 	vmemmap_pgtable_free(h, page);
 
-- 
2.20.1

