Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4926B864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIPAmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgIONCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084CC061223
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so1690022pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkXzMD+NhY0rrv1EIRPbwCaZ1TTYsXnyGu+SkY1Mf24=;
        b=K6eEVu6polJsOytMXuHPIjuG3TFrs/6N5WUI0ZBBKC74qkO0sruMQ1T0TpXQbjcveW
         V7Yf5dcMI0SKa3/DAk/anYDfj6yRV/HTjUOOA0qbT6abv0okqUkNWwawOXp3DFhTL32d
         fb5oq5SdPT/cZ2/LBiidsxUx3rZYPzTCJqdYbiRJLpjiUKtcc61zGRGaMVYN7Yq2AysS
         mW5AmVG93RK3f5VeskZafXZB5UX+R/WEaQYOF+2nyqVZuNKbI11lQYyoWv/7aESzFVzI
         MXEbmt9TxtVJeKdqVeVu3/roaQT+6AT3rwfdNvJUfm5RkEXUO2l5GTdkRRl6H0/8Hhkc
         wQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkXzMD+NhY0rrv1EIRPbwCaZ1TTYsXnyGu+SkY1Mf24=;
        b=L+MmVNX9itjunyMvJk59BBosKKSyV2aA2CYIBwN0LptI70v9z5ChsBzi7F8HkUJb6m
         yRkZO9Bo9fde3zulOMOJZvka3g36bdYvTM1PDWqLvvlwzlGxngNgZ0ju3Uhmy5wzIoIb
         eB6RSOQjQ/6x4MOsN5ivKdot6hmz0eFJvsGWSaF0goVkV//nva2bh4DfY4Q8a0fGrI6c
         b583O8ylIiODJWYGhbGVTMCBWXhog4JNE7FbMVmECLlpkIcF1zM01z/lzYcHN8KIt+7G
         ZKsrzl5S3Q41CGwAj8Jd5W5mUtJvtXwG84nFFan7NAPm9oLd7/lJEC7NuSXgr5v/BafX
         IKcQ==
X-Gm-Message-State: AOAM532eRyODpi9/JyUPtmn9w+9kWbM5NBv8rbnNowIJHKCeEbznMcxl
        OzBfxmYwPIBPx8iTx0V1FC1HHg==
X-Google-Smtp-Source: ABdhPJzuCDVnx9gwW0vptu4yfb3717i/f+89GR/L7KYBny+0fPn83Ui2UVeaXboaZe1vqz4P5kT+mQ==
X-Received: by 2002:a17:902:7896:b029:d0:b9dd:edae with SMTP id q22-20020a1709027896b02900d0b9ddedaemr18610201pll.0.1600174944140;
        Tue, 15 Sep 2020 06:02:24 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:23 -0700 (PDT)
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
Subject: [RFC PATCH 14/24] mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
Date:   Tue, 15 Sep 2020 20:59:37 +0800
Message-Id: <20200915125947.26204-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The __free_huge_page_pmd_vmemmap and __remap_huge_page_pmd_vmemmap are
almost the same code. So introduce remap_free_huge_page_pmd_vmemmap
helper to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 98 +++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0f09fe531fc..5cc796dc3a0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1482,6 +1482,41 @@ static inline int freed_vmemmap_hpage_dec(struct page *page)
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
+	unsigned long end = addr + nr_vmemmap_size(h);
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
@@ -1513,33 +1548,6 @@ static void __free_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __free_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					 unsigned long addr,
-					 struct list_head *free_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
-	unsigned long end = addr + nr_vmemmap_size(h);
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
 	struct mm_struct *mm = &init_mm;
@@ -1639,7 +1647,8 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 		split_vmemmap_huge_page(head, pmd);
 	}
 
-	__free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
+				    __free_huge_page_pte_vmemmap);
 	freed_vmemmap_hpage_inc(pmd_page(*pmd));
 	spin_unlock(ptl);
 
@@ -1679,35 +1688,6 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 	}
 }
 
-static void __remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
-					  unsigned long addr,
-					  struct list_head *remap_pages)
-{
-	unsigned long next;
-	unsigned long start = addr + RESERVE_VMEMMAP_NR * PAGE_SIZE;
-	unsigned long end = addr + nr_vmemmap_size(h);
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
@@ -1736,8 +1716,8 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	ptl = vmemmap_pmd_lockptr(pmd);
 
 	spin_lock(ptl);
-	__remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head,
-				      &remap_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
+				    __remap_huge_page_pte_vmemmap);
 	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
 		/*
 		 * Todo:
-- 
2.20.1

