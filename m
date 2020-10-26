Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39BE299023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782610AbgJZOyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40284 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782313AbgJZOyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id j5so4856837plk.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBOWUvI64CVkddhS0ymba6FNm4rZpN25m+YjytIcpHw=;
        b=cD6rCx5J9AHr93YCMUekQ1zaeA2YYNgJOjsT/ihum6qcydD4HzFe/+LBspsS8mcD0p
         +FZ5UwCLhtYy7eiTgUSBWE6LX3Ns3so2GmPf2QtOBAk2R7FbELeJ1tznikTj7mBgL4D2
         EsIGG4PSQ+CuJm2EElGrm234AKZW4HN1SAsfIiwkXbhcSR56tEbBwbUfiM2p7LF6/T5n
         F6UKOeoO5EnJmTznuesW+ll0Mk9khtUOmOfXm9n673P040oyAAcVmLeD2Ei5vhT9Mba6
         PEILq0tdaVGTilpvKBpJFye27FzINR/kVCZ/H2p4ddBqQFaA+bjEQdt04myqJcrEe9XW
         Bv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBOWUvI64CVkddhS0ymba6FNm4rZpN25m+YjytIcpHw=;
        b=Q3Q1ZxAi1R8QRKP5gODjIL8mvpQiWjEa0uUrCiBdRKOp1hnpvoiPZJTSM8KoIr9g+B
         DxjgnNAJgWAy7/7m/djWnfSFeXy5eFSytK9g4DxoMKQ+efzLIA/AAPDpHluZSa4jtVU7
         Onic7z2j7xBIzSfgSS9tYTmyNWH//PTThzcD07vkNgdzskcHnk5+680JQM5qieuCaZPN
         etK80TQxXjPR69s2Zk1fZS6qGGCqCTgBJMaCMtJKZbKrEIQYy2lXXXxqrCc2W8NoAy+U
         dZkE0HGrPtaOXYCVW+Dx+XOFUVSG5Iw38dlRF2ulG4cDe3+HquzQ7lfgAATwatxF9CT8
         +xsA==
X-Gm-Message-State: AOAM531yqsIYE0jXtQwPYuButd6zNpJLFwgxTZz6ymeHlqeKBeOCxzNc
        hdw6QfwgUu3Lc9aIvj+P+LBN6w==
X-Google-Smtp-Source: ABdhPJwaHtkSuog973zfhn2PNnZUpQnIFVl1BNtXohx04K2a0S87z8ygehWrmiJg5l0SnkpyhpEcHw==
X-Received: by 2002:a17:90a:9206:: with SMTP id m6mr21586890pjo.42.1603724086406;
        Mon, 26 Oct 2020 07:54:46 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:54:45 -0700 (PDT)
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
Subject: [PATCH v2 10/19] mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
Date:   Mon, 26 Oct 2020 22:51:05 +0800
Message-Id: <20201026145114.59424-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c | 98 +++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 59 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cea580058a16..bd0c4e7fd994 100644
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
@@ -1598,7 +1606,8 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 		split_vmemmap_huge_page(head, pmd);
 	}
 
-	__free_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages);
+	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
+				    __free_huge_page_pte_vmemmap);
 	freed_vmemmap_hpage_inc(pmd_page(*pmd));
 	spin_unlock(ptl);
 
@@ -1638,35 +1647,6 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
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
@@ -1695,8 +1675,8 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
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

