Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D032C224D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgKXJ6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731701AbgKXJ6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:58:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DFC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so3485654pfd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbFCNgyPE8nizGGDJDZBGUHg6UO+mJRBaj4BfE6x8So=;
        b=FwWSJi2cHVLIvbiOkLH6oUoM/YtuKQ9XtRGesAdYMI8WK/9ZQRRLTsMwEun+e1dW4R
         WJf3KMSYagwqAkOJl39z+uBWiCKjtOVdYqd84WGW33xAGCtWyyZ2MZhj6ghdETJ5mX9W
         pk+kX0lq3SP2kWM2s9gwaHeBiQtgXFDcMw4o+CygYAAuqpgs1ZY+czuXaEoAnUX7ob8x
         0ldPerB5AR0kLOKkKWUacv2367EhY1Wp1ejTVHv9/y31UF1L6b2arv+hIs4WcRP8FpDG
         WRmEK1V0zzx4XPrAM9G0UE8kTphJnNhaheePBt+e/IPjR7xKioUsJnKUfFwtm9y6vAJT
         JtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbFCNgyPE8nizGGDJDZBGUHg6UO+mJRBaj4BfE6x8So=;
        b=hwq074QPSyPReKadSHgXaNGw3xmybyu8SgFtRR+TDd6Npk6T5CsdMrRC37niMEYNaD
         BTTGW/llZ02ZXJcPIArf3w6wjHlhNyjM4gt6alnVV48tlcl8vLzuHssp4fzX6dKKa83b
         yOfv3nubTQQ6r42uxHC+a+agpcUXK5H8ofZcDtyGwh1ZUzRxndrfNODAk3WZaKU3lx+C
         xLe/qCR/AuVXik7F8TbktBYY6B/V0jZuMs6zPU+gScJynS+RFeGokpYPa/48qqlsGlIv
         YaJOQsv84w0Vp51Xd2HQ61IdVPPA6vsJR3yAmLrVCxOChctb4IhlNZJaroz4yXik/4tV
         KysQ==
X-Gm-Message-State: AOAM532ufuz55XcxrnpaBaVy3toWCY6tugsTQuicm887zvY9voCkQQ8j
        3MlLfdpP4wIaaChHLXa59hFrEA==
X-Google-Smtp-Source: ABdhPJwX9HQ0VjDIqeOVrfmO9iIZzoKa4yniFwFtNwTWpg2A7NszkjO8GLva5IH0THXOXslntQZcCQ==
X-Received: by 2002:a17:90a:fd0e:: with SMTP id cv14mr3877515pjb.182.1606211886807;
        Tue, 24 Nov 2020 01:58:06 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:58:06 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 08/16] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
Date:   Tue, 24 Nov 2020 17:52:51 +0800
Message-Id: <20201124095259.58755-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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
 arch/x86/include/asm/pgtable_64_types.h |   8 ++
 mm/hugetlb.c                            |   2 +
 mm/hugetlb_vmemmap.c                    | 133 +++++++++++++++++++++++++++++++-
 mm/hugetlb_vmemmap.h                    |   5 ++
 4 files changed, 147 insertions(+), 1 deletion(-)

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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f88032c24667..9662b5535f3a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1499,6 +1499,8 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	free_huge_page_vmemmap(h, page);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fd60cfdf3d40..1576f69bd1d3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -92,8 +92,9 @@
  * to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
  * pages.
  */
-#define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
+#define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
 
+#include <linux/bootmem_info.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -105,6 +106,136 @@
  * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
  */
 #define RESERVE_VMEMMAP_NR		2U
+#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+#define TAIL_PAGE_REUSE			-1
+
+#ifndef VMEMMAP_HPAGE_SHIFT
+#define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
+#endif
+#define VMEMMAP_HPAGE_ORDER		(VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPAGE_NR		(1 << VMEMMAP_HPAGE_ORDER)
+#define VMEMMAP_HPAGE_SIZE		((1UL) << VMEMMAP_HPAGE_SHIFT)
+#define VMEMMAP_HPAGE_MASK		(~(VMEMMAP_HPAGE_SIZE - 1))
+
+#define vmemmap_hpage_addr_end(addr, end)				 \
+({									 \
+	unsigned long __boundary;					 \
+	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK; \
+	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
+})
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return h->nr_free_vmemmap_pages;
+}
+
+static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
+}
+
+static inline unsigned long vmemmap_pages_size_per_hpage(struct hstate *h)
+{
+	return (unsigned long)vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
+}
+
+/*
+ * Walk a vmemmap address to the pmd it maps.
+ */
+static pmd_t *vmemmap_to_pmd(unsigned long page)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	if (page < VMEMMAP_START || page >= VMEMMAP_END)
+		return NULL;
+
+	pgd = pgd_offset_k(page);
+	if (pgd_none(*pgd))
+		return NULL;
+	p4d = p4d_offset(pgd, page);
+	if (p4d_none(*p4d))
+		return NULL;
+	pud = pud_offset(p4d, page);
+	if (pud_none(*pud) || pud_bad(*pud))
+		return NULL;
+
+	return pmd_offset(pud, page);
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
+					 unsigned long end,
+					 struct list_head *free_pages)
+{
+	/* Make the tail pages are mapped read-only. */
+	pgprot_t pgprot = PAGE_KERNEL_RO;
+	pte_t entry = mk_pte(reuse, pgprot);
+	unsigned long addr;
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
+static void __free_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					 unsigned long end,
+					 struct list_head *vmemmap_pages)
+{
+	unsigned long next, addr = start;
+	struct page *reuse = NULL;
+
+	do {
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse)
+			reuse = pte_page(ptep[TAIL_PAGE_REUSE]);
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		__free_huge_page_pte_vmemmap(reuse, ptep, addr, next,
+					     vmemmap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	unsigned long start, end;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	LIST_HEAD(free_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	pmd = vmemmap_to_pmd(vmemmap_addr);
+	BUG_ON(!pmd);
+
+	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
+	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
+	__free_huge_page_pmd_vmemmap(pmd, start, end, &free_pages);
+	free_vmemmap_page_list(&free_pages);
+}
 
 void __init hugetlb_vmemmap_init(struct hstate *h)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 40c0c7dfb60d..67113b67495f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,9 +12,14 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void __init hugetlb_vmemmap_init(struct hstate *h);
+void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
+
+static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

