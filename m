Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0B2AAB7D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKHONp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728805AbgKHONo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:44 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so4598822pgr.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n905scZFhDOuPwwrdQvDwceEL03IJm1237IQYKLWR9Q=;
        b=DDuZvysPKyn254ParwTu/jxJqFPkNKkOsOy/7+3NXXhB/+VScSBq4iaKjala1WLFKR
         J9KVfXjoUy7SOStqoV+5oB9YuBJJChQKZ3Ohnsbx0VsjQh2V3dO3U4jQzIPHhE4VJDzH
         syFI8GCi67SJ7t8A7KEAhWx0Gm7yLZ2aVVikpemy/iZZjEByXP6Rj4Su9vLjrK4zIqSW
         Ki6SWeiUDT5/vGmOmukr00QN+qSX8uokarvnA+SRLxkKkcrH6QmgcXFze+7Y1udTVDfX
         IePXc/1pbli3HWjUUB8czx/VlqI6GLZIV8g/BnqQ52uSD+DZqwfv1T8Wwab/HzmuUUD7
         lEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n905scZFhDOuPwwrdQvDwceEL03IJm1237IQYKLWR9Q=;
        b=TDB++wuefHlCIgghIq1JiIOEmsYsMZGzXJlLGNibunlNSC4MO4SmKHAh5cDsE0zuVF
         5riOfn9h2GYffWLIVd5IbnLr7KSuWlxYfY1PB2sQJo2jQQ9bVtG/vu5iRiWPTdk3fYUW
         sEtn/fDoasLrHj8bouDZ1BNtH0gl0M8HFINqUqyyBv0fJjZt2/AoT+L1uG8i0vMwYKfD
         bvDqFRLpEcGJ2pj6c50jmbAQ8GBJPPHkXk8LIfDbf2PyBRVbv/zqNpYrBXsno4FiE5GL
         b83oBKposaFWKrvmXUC3BhGDuWCBgdcLKB3+FKX/8+FPtgpo3piiZIdSS3BDbhn6Paye
         4fTw==
X-Gm-Message-State: AOAM531lOuzEv0aI4l4e0nCOXCwT/KACr/qpJ5q2KVY/kQ96ef+YJgaQ
        NFSuwJkUrPbbL3Ks1fO2OmXfIA==
X-Google-Smtp-Source: ABdhPJw2atSYFKgDsZDzHgv8quDlXR0V063XteNki3ZFjJ3D0dnZjq9C4fCxJ1So1yirQCgH8pBUwQ==
X-Received: by 2002:aa7:8259:0:b029:18b:cf29:4658 with SMTP id e25-20020aa782590000b029018bcf294658mr6020286pfn.70.1604844823766;
        Sun, 08 Nov 2020 06:13:43 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:43 -0800 (PST)
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
Subject: [PATCH v3 12/21] mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
Date:   Sun,  8 Nov 2020 22:11:04 +0800
Message-Id: <20201108141113.65450-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __free_huge_page_pmd_vmemmap and __remap_huge_page_pmd_vmemmap are
almost the same code. So introduce remap_free_huge_page_pmd_vmemmap
helper to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 98 ++++++++++++++++++++++++------------------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8295911fe76e..5d3806476212 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1454,6 +1454,41 @@ static inline int freed_vmemmap_hpage_dec(struct page *page)
 	return atomic_dec_return_relaxed(&page->_mapcount) + 1;
 }
 
+typedef void (*remap_pte_fn)(struct page *reuse, pte_t *ptep,
+			     unsigned long start, unsigned int nr_pages,
+			     struct list_head *pages);
+
+static void remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
+					unsigned long addr,
+					struct list_head *pages,
+					remap_pte_fn remap_fn)
+{
+	unsigned long next;
+	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
+	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
+	struct page *reuse = NULL;
+
+	flush_cache_vunmap(start, end);
+
+	addr = start;
+	do {
+		unsigned int nr_pages;
+		pte_t *ptep;
+
+		ptep = pte_offset_kernel(pmd, addr);
+		if (!reuse) {
+			reuse = pte_page(ptep[-1]);
+			set_page_private(reuse, addr - PAGE_SIZE);
+		}
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		nr_pages = (next - addr) >> PAGE_SHIFT;
+		remap_fn(reuse, ptep, addr, nr_pages, pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
 static inline void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
@@ -1487,33 +1522,6 @@ static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					 unsigned long addr,
-					 struct list_head *free_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_SIZE;
-	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
-	struct page *reuse = NULL;
-
-	addr = start;
-	do {
-		unsigned int nr_pages;
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse)
-			reuse = pte_page(ptep[-1]);
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		nr_pages = (next - addr) >> PAGE_SHIFT;
-		__free_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
-					     free_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 static void split_vmemmap_pmd(pmd_t *pmd, pte_t *pte_p, unsigned long addr)
 {
 	int i;
@@ -1573,7 +1581,8 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 		split_vmemmap_huge_page(h, head, pmd);
 	}
 
-	__free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
+				    __free_huge_page_pte_vmemmap);
 	freed_vmemmap_hpage_inc(pmd_page(*pmd));
 	spin_unlock(ptl);
 
@@ -1614,35 +1623,6 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					  unsigned long addr,
-					  struct list_head *remap_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
-	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
-	struct page *reuse = NULL;
-
-	addr = start;
-	do {
-		unsigned int nr_pages;
-		pte_t *ptep;
-
-		ptep = pte_offset_kernel(pmd, addr);
-		if (!reuse) {
-			reuse = pte_page(ptep[-1]);
-			set_page_private(reuse, addr - PAGE_SIZE);
-		}
-
-		next = vmemmap_hpage_addr_end(addr, end);
-		nr_pages = (next - addr) >> PAGE_SHIFT;
-		__remap_huge_page_pte_vmemmap(reuse, ptep, addr, nr_pages,
-					      remap_pages);
-	} while (pmd++, addr = next, addr != end);
-
-	flush_tlb_kernel_range(start, end);
-}
-
 static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
 {
 	int i;
@@ -1669,8 +1649,8 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	pmd = vmemmap_to_pmd(head);
 	ptl = vmemmap_pmd_lock(pmd);
-	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
-				      &remap_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
+				    __remap_huge_page_pte_vmemmap);
 	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
 		/*
 		 * Todo:
-- 
2.11.0

