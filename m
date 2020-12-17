Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B962DD13E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgLQMRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 07:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQMRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:17:08 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0BC0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:27 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so3046828pgj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dj578UsWVM1a5aMLDM3EP67706qoyFbxAsYRyDIHJks=;
        b=LNBtZQUCmZmD3uyrssYOY84KUqX/8clVAGGSgDhRDr9ltbpoTR8ayWN3A8QM1QbpKS
         V2kQ/gp4whUbxoin7n8uXrRVtFkfd9kZV6KvTxgPegWSSzt8tgiaAmp4wOkc+uO03FnN
         Erb8uOTkfs1i8tg+yqKBkPSSugXygl5qsdHUEH/NwBKPlhpj4c/6rZM4/CrgMiaBC65+
         pVMcDgN3rv1Q5YNDY+fCBa36+DzReATuxDKAnmeIqtvoNkdaICPXjGZkKp4YMobwJuVe
         Eu22Y3RdN9PsYDQJbLurn69v5Z9nmUO/Red+Zh62679uUmCYEFGe0wkQEvaFX9ASwSrs
         ZK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dj578UsWVM1a5aMLDM3EP67706qoyFbxAsYRyDIHJks=;
        b=E1uCnpc0DJUhbqY9zeHLd4AcLRLz1+mPS7cFX5NQ36ABCvyRQZPr0fkzVtdATItBO5
         RsKjFTrwh49hrlQvIzuhKPRiWgWdWuUBs2aHrybWrMTek0wHn8bmZ70AnMcxkbpffUpJ
         QaOB6fTy1/K40BSD97n8u9ehbH0aU6yMCzuPUvUlaBSAO69bEbisBwn3AfgQo7Q8VlI3
         uUdWV23/UxwwR0WS96ew6gq2XmKnt8AaDWqW1Y2srhES4ZyUNvAoXqTdFklnpuvW/1LY
         fSGprxXzL2ajPU3p5A2DjGl/Fz6xb+EZ9R0hxtVvV/4OEwhHvwzRHtTStCZFJoxDiRCm
         ihMQ==
X-Gm-Message-State: AOAM5315IXF01ja//eWfZGF0U6e/qWqnYtQAiYnbXeWEkY0y5nTGAT+i
        47qXXFD6M0FiK0OCF+KChCQpkw==
X-Google-Smtp-Source: ABdhPJyyzPXUFGwfxSIpjE0XjjaxadFSQYvbXxt/MqQvVJemQUqWmzotHqkrw09+XE2e6peWAVwVPA==
X-Received: by 2002:a63:308:: with SMTP id 8mr21855610pgd.15.1608207387377;
        Thu, 17 Dec 2020 04:16:27 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n15sm2775691pgl.31.2020.12.17.04.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 04:16:26 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 05/11] mm/hugetlb: Allocate the vmemmap pages associated with each HugeTLB page
Date:   Thu, 17 Dec 2020 20:12:57 +0800
Message-Id: <20201217121303.13386-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a HugeTLB page to the buddy allocator, we should allocate the
vmemmap pages associated with it. We can do that in the __free_hugepage()
before freeing it to buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |  1 +
 mm/hugetlb.c         |  2 ++
 mm/hugetlb_vmemmap.c | 11 ++++++++
 mm/hugetlb_vmemmap.h |  5 ++++
 mm/sparse-vmemmap.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ecad1a41190..e7d022b67ee1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3006,6 +3006,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 void vmemmap_remap_free(unsigned long start, unsigned long size);
+void vmemmap_remap_alloc(unsigned long start, unsigned long size);
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9f35f34d3195..329f473b929e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1365,6 +1365,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	alloc_huge_page_vmemmap(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c4bbca270453..273816dd95b6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -183,6 +183,17 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_addr = (unsigned long)head;
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	vmemmap_remap_alloc(vmemmap_addr + RESERVE_VMEMMAP_SIZE,
+			    free_vmemmap_pages_size_per_hpage(h));
+}
+
 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 01f8637adbe0..b2c8d2f11d48 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 /*
@@ -25,6 +26,10 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 	return 0;
 }
 #else
+static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6cf2fdfb81e9..01228065b95d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/bootmem_info.h>
+#include <linux/delay.h>
 
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
@@ -40,7 +41,8 @@
  * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
  * @reuse_page:		the page which is reused for the tail vmemmap pages.
  * @reuse_addr:		the virtual address of the @reuse_page page.
- * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
+ * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
+ *			or is mapped from.
  */
 struct vmemmap_remap_walk {
 	void (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
 	struct list_head *vmemmap_pages;
 };
 
+/* The gfp mask of allocating vmemmap page */
+#define GFP_VMEMMAP_PAGE		\
+	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -207,6 +213,71 @@ void vmemmap_remap_free(unsigned long start, unsigned long size)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
+				struct vmemmap_remap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	BUG_ON(pte_page(*pte) != walk->reuse_page);
+
+	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&page->lru);
+	to = page_to_virt(page);
+	copy_page(to, (void *)walk->reuse_addr);
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+}
+
+static void alloc_vmemmap_page_list(struct list_head *list,
+				    unsigned long start, unsigned long end)
+{
+	unsigned long addr;
+	int nid = page_to_nid((const void *)start);
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
+		struct page *page;
+
+retry:
+		page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
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
+/**
+ * vmemmap_remap_alloc - remap the vmemmap virtual address range
+ *                       [start, start + size) to the page respectively
+ *                       which from the @vmemmap_pages
+ * @start:	start address of the vmemmap virtual address range
+ * @size:	size of the vmemmap virtual address range
+ */
+void vmemmap_remap_alloc(unsigned long start, unsigned long size)
+{
+	LIST_HEAD(vmemmap_pages);
+	unsigned long end = start + size;
+
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_restore_pte,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	might_sleep();
+
+	alloc_vmemmap_page_list(&vmemmap_pages, start, end);
+	vmemmap_remap_range(start, end, &walk);
+}
+
 /*
  * Allocate a block of memory to be used to back the virtual memory map
  * or to back the page tables that are used to create the mapping.
-- 
2.11.0

