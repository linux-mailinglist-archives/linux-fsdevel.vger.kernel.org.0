Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213D2C2253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKXJ62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731731AbgKXJ61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:58:27 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE4C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:27 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w202so2183955pff.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpttDQ3+UpRWFZGIokSg/wUkYwNYHQgTk6UVKoBkeLU=;
        b=Gm0mjZUZo7zA0izrHNveruNSQpbuz5ojd5lRvjZkLwR0sKbaTIRLwKpZEXmqd+1d81
         5e1PHD0YUicJwnVh/wuHh4JiLhY1/A627ofFS8cxdsQjeMpmX03OkJ3aGK9MrbfrDDkK
         lvWchEmQh6eOTBP6pl2QPC+E7TbtkEfWPGdQotIQhNG2uOdY4dJNN4vfam6//Wmnf/wa
         DC0Rk6sE/dIvBxNyAP1PxoSnIReJQdF+9Ctxl1NVTVYnbckZYmXhQP7DFe0imgIl0Dly
         d6Z9Qn8jYZawRcSKTjHPRhawGY0J/UKmsv0bJrw9kkQe3dMZlD7iuOi49kzFGgxFlDv9
         yXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpttDQ3+UpRWFZGIokSg/wUkYwNYHQgTk6UVKoBkeLU=;
        b=nXGr8WPKti918/5YW/Ju+E/n2fimzZlWRnbdhADQ3nD1mKfHaurGodDTJz/IscNdF5
         M62iNSbCywvBKKYEdjOFSF0DBrHXu0X/ci6bgIXEuhHNXHrfzbJztqpaWXuPc4IbaKBE
         6JCwudXjhenH2yy2YTSgYJtwtwX0H0aBItrnQ2Ka+tZgo8YT+wQ0FaTjINbW3a7H1lVQ
         Rw/gDi0SHcypyoFZVDyEzdh6U+TJHtPPl/scrvYDdD2Kc+CUCPzo3KNfj8VZw6f9jXWW
         TTvJjmdp870hZVwQ+dqktKveIiYVIVE5uipcpLyr3LX+Qzjrwt3lyBtfLyA1mlcdKwVD
         S/Vg==
X-Gm-Message-State: AOAM530dvPvl4FQzotP+u840ovllZpkGoMzyFYkS5F0hWTsxW27D5aJt
        74vNnZg7AwsWoyvjSIChUBipIQ==
X-Google-Smtp-Source: ABdhPJz3kRh7lpNK/DAxol80hx9LY0gJYD6O17ncIwy1kSZ2WnppJR53a574t27X7WEHzvtZF0+IHg==
X-Received: by 2002:a17:90a:4283:: with SMTP id p3mr4150189pjg.174.1606211907222;
        Tue, 24 Nov 2020 01:58:27 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:58:26 -0800 (PST)
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
Subject: [PATCH v6 10/16] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
Date:   Tue, 24 Nov 2020 17:52:53 +0800
Message-Id: <20201124095259.58755-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a hugetlb page to the buddy, we should allocate the vmemmap
pages associated with it. We can do that in the __free_hugepage().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |   2 +
 mm/hugetlb_vmemmap.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h |   5 +++
 3 files changed, 109 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 41056b4230f1..3fafa39fcac6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1382,6 +1382,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f6ba288966d4..d6a1b06c1322 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -95,6 +95,7 @@
 #define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
 
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -108,6 +109,8 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 #define TAIL_PAGE_REUSE			-1
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_HIGH)
 
 #ifndef VMEMMAP_HPAGE_SHIFT
 #define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
@@ -159,6 +162,105 @@ static pmd_t *vmemmap_to_pmd(unsigned long page)
 	return pmd_offset(pud, page);
 }
 
+static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
+					  unsigned long start,
+					  unsigned long end,
+					  struct list_head *remap_pages)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	void *from = page_to_virt(reuse);
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		void *to;
+		struct page *page;
+		pte_t entry, old = *ptep;
+
+		page = list_first_entry(remap_pages, struct page, lru);
+		list_del(&page->lru);
+		to = page_to_virt(page);
+		copy_page(to, from);
+
+		/*
+		 * Make sure that any data that writes to the @to is made
+		 * visible to the physical page.
+		 */
+		flush_kernel_vmap_range(to, PAGE_SIZE);
+
+		prepare_vmemmap_page(page);
+
+		entry = mk_pte(page, pgprot);
+		set_pte_at(&init_mm, addr, ptep++, entry);
+
+		VM_BUG_ON(!pte_present(old) || pte_page(old) != reuse);
+	}
+}
+
+static void __remap_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
+					  unsigned long end,
+					  struct list_head *vmemmap_pages)
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
+		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, next,
+					      vmemmap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
+{
+	unsigned int nr = free_vmemmap_pages_per_hpage(h);
+
+	while (nr--) {
+		struct page *page;
+
+retry:
+		page = alloc_page(GFP_VMEMMAP_PAGE);
+		if (unlikely(!page)) {
+			msleep(100);
+			/*
+			 * We should retry infinitely, because we cannot
+			 * handle allocation failures. Once we allocate
+			 * vmemmap pages successfully, then we can free
+			 * a HugeTLB page.
+			 */
+			goto retry;
+		}
+		list_add_tail(&page->lru, list);
+	}
+}
+
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	pmd_t *pmd;
+	unsigned long start, end;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	LIST_HEAD(map_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	alloc_vmemmap_pages(h, &map_pages);
+
+	pmd = vmemmap_to_pmd(vmemmap_addr);
+	BUG_ON(!pmd);
+
+	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
+	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
+	__remap_huge_page_pmd_vmemmap(pmd, start, end, &map_pages);
+}
+
 static inline void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 293897b9f1d8..7887095488f4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,6 +12,7 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void __init hugetlb_vmemmap_init(struct hstate *h);
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
@@ -23,6 +24,10 @@ static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
 
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
-- 
2.11.0

