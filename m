Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4E2BA295
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKTGs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKTGs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:26 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCD2C061A04
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so6952345pfn.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPRCn8/kiXAueLuQQpe5BNdwIIijLQR0RASycvhGpiY=;
        b=Hdg9qI+B/zArNnptrPOekO3F5Sv+7WQ850J/5YBXdZBHBc3v8aXdpEebbBU+ZNUvu9
         kBaASy+YQSDYvO+l3cAkvWy8afEN1dYK9ZNDa3Eukh9Lb8cT+8ZSHdyR1PlcgH6Q5YOm
         GBMhHVk3LwTwXq+yPufzgU6rHL0c1VMDrEkBWD6N1kege8+75amTfwFh4ZkpzCqUwMmd
         nSRKZOJ0yG0/NQ0W+xhMVtdoTRx/KEFW0uFBuSbYJKHypluo0aCz3H4HiJM7zWGF/EsM
         8iYDpQdcRIuRsH2viPUOTUG8LIWyyAR0oFh1rbnvK/Ews3d+1eTir/b1kh97ITDUESDb
         o0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPRCn8/kiXAueLuQQpe5BNdwIIijLQR0RASycvhGpiY=;
        b=BTNeCjwJy8fruLdR6JssSzs0j1nr3fGKa+KaqBP3ml9zaYNkqi5fxLMtB2g1E8n0xS
         XYbVoRmwtSpXGd4mZy6mS1Pop50abqKVVzxk0Ge8Ak8uU+D8WbFK8leEAZoGIaBLYSXO
         4cOA5v0hISHlX5DJ8MI7l1FVGMWjx28I/x91xKG3f6HgSt6nquC6DijVYuV4h0cPD/zD
         8rUzRR9/XqRQDOE883oHxj4y1+fbFBPb9WX4B85aL+rfPkzoXzVnENLJeKb1zYB81B5t
         bqXuC7sNxiRU45vXAgFTirq7Tj/E4U0fqyp57Ivd0q194wPdV5/sIosCyQgxPiGZ+Hoc
         do7A==
X-Gm-Message-State: AOAM5334PRg6uR5V1GSeTwAlTuRJWShDJeSaEsflbg3E8d+kQLCZTIIk
        yREQWkjq9BbFM05ovCwzsplT4g==
X-Google-Smtp-Source: ABdhPJx4u46vHQNchdnfimXCIyMWc/51pYcv2O01OlE739ipscOuIyXRdkQKW5MvYwDW6CRWcxH3mQ==
X-Received: by 2002:a63:504f:: with SMTP id q15mr12829737pgl.119.1605854905654;
        Thu, 19 Nov 2020 22:48:25 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:25 -0800 (PST)
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
Subject: [PATCH v5 14/21] mm/hugetlb: Support freeing vmemmap pages of gigantic page
Date:   Fri, 20 Nov 2020 14:43:18 +0800
Message-Id: <20201120064325.34492-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The gigantic page is allocated by bootmem, if we want to free the
unused vmemmap pages. We also should allocate the page table. So
we also allocate page tables from bootmem.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  5 +++++
 mm/hugetlb_vmemmap.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 13 +++++++++++
 4 files changed, 81 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index eed3dd3bd626..da18fc9ed152 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -506,6 +506,9 @@ struct hstate {
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	pte_t *vmemmap_pte;
+#endif
 };
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ba927ae7f9bd..055604d07046 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2607,6 +2607,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(page_count(page) != 1);
 		prep_compound_huge_page(page, h->order);
 		WARN_ON(PageReserved(page));
+		gather_vmemmap_pgtable_init(m, page);
 		prep_new_huge_page(h, page, page_to_nid(page));
 		put_page(page); /* free it into the hugepage allocator */
 
@@ -2659,6 +2660,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 			break;
 		cond_resched();
 	}
+
+	if (hstate_is_gigantic(h))
+		i -= gather_vmemmap_pgtable_prealloc();
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e2ddc73ce25f..3629165d8158 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -103,6 +103,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/bootmem_info.h>
+#include <linux/memblock.h>
 #include <asm/pgalloc.h>
 #include "hugetlb_vmemmap.h"
 
@@ -204,6 +205,65 @@ int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
 	return -ENOMEM;
 }
 
+unsigned long __init gather_vmemmap_pgtable_prealloc(void)
+{
+	struct huge_bootmem_page *m, *tmp;
+	unsigned long nr_free = 0;
+
+	list_for_each_entry_safe(m, tmp, &huge_boot_pages, list) {
+		struct hstate *h = m->hstate;
+		unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+		unsigned int pgtable_size;
+
+		if (!nr)
+			continue;
+
+		pgtable_size = nr << PAGE_SHIFT;
+		m->vmemmap_pte = memblock_alloc_try_nid(pgtable_size,
+				PAGE_SIZE, 0, MEMBLOCK_ALLOC_ACCESSIBLE,
+				NUMA_NO_NODE);
+		if (!m->vmemmap_pte) {
+			nr_free++;
+			list_del(&m->list);
+			memblock_free_early(__pa(m), huge_page_size(h));
+		}
+	}
+
+	return nr_free;
+}
+
+void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					struct page *page)
+{
+	struct hstate *h = m->hstate;
+	unsigned long pte = (unsigned long)m->vmemmap_pte;
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	/*
+	 * Use the huge page lru list to temporarily store the preallocated
+	 * pages. The preallocated pages are used and the list is emptied
+	 * before the huge page is put into use. When the huge page is put
+	 * into use by prep_new_huge_page() the list will be reinitialized.
+	 */
+	INIT_LIST_HEAD(&page->lru);
+
+	while (nr--) {
+		struct page *pte_page = virt_to_page(pte);
+
+		__ClearPageReserved(pte_page);
+		list_add(&pte_page->lru, &page->lru);
+		pte += PAGE_SIZE;
+	}
+
+	/*
+	 * If we had gigantic hugepages allocated at boot time, we need
+	 * to restore the 'stolen' pages to totalram_pages in order to
+	 * fix confusing memory reports from free(1) and another
+	 * side-effects, like CommitLimit going negative.
+	 */
+	adjust_managed_page_count(page, nr);
+}
+
 /*
  * Walk a vmemmap address to the pmd it maps.
  */
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 6dfa7ed6f88a..779d3cb9333f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -14,6 +14,9 @@
 void __init hugetlb_vmemmap_init(struct hstate *h);
 int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
 void vmemmap_pgtable_free(struct page *page);
+unsigned long __init gather_vmemmap_pgtable_prealloc(void);
+void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					struct page *page);
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
@@ -35,6 +38,16 @@ static inline void vmemmap_pgtable_free(struct page *page)
 {
 }
 
+static inline unsigned long gather_vmemmap_pgtable_prealloc(void)
+{
+	return 0;
+}
+
+static inline void gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
+					       struct page *page)
+{
+}
+
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
-- 
2.11.0

