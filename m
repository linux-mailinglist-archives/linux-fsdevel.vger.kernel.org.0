Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89288666
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfHIW66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:58:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:62302 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbfHIW65 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:58:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:56 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="326762567"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:56 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 10/19] mm/gup: Pass a NULL vaddr_pin through GUP fast
Date:   Fri,  9 Aug 2019 15:58:24 -0700
Message-Id: <20190809225833.6657-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Internally GUP fast needs to know that fast users will not support file
pins.  Pass NULL for vaddr_pin through the fast call stack so that the
pin code can return an error if it encounters file backed memory within
the address range.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/gup.c | 65 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7a449500f0a6..504af3e9a942 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1813,7 +1813,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
 
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr,
+			 struct vaddr_pin *vaddr_pin)
 {
 	struct dev_pagemap *pgmap = NULL;
 	int nr_start = *nr, ret = 0;
@@ -1894,7 +1895,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
  * useful to have gup_huge_pmd even if we can't operate on ptes.
  */
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr,
+			 struct vaddr_pin *vaddr_pin)
 {
 	return 0;
 }
@@ -1903,7 +1905,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr,
-		unsigned int flags)
+		unsigned int flags, struct vaddr_pin *vaddr_pin)
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
@@ -1938,13 +1940,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr,
-		unsigned int flags)
+		unsigned int flags, struct vaddr_pin *vaddr_pin)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags,
+			       vaddr_pin))
 		return 0;
 
 	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
@@ -1957,13 +1960,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 
 static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr,
-		unsigned int flags)
+		unsigned int flags, struct vaddr_pin *vaddr_pin)
 {
 	unsigned long fault_pfn;
 	int nr_start = *nr;
 
 	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
+	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags,
+			       vaddr_pin))
 		return 0;
 
 	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
@@ -1975,7 +1979,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 #else
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr,
-		unsigned int flags)
+		unsigned int flags, struct vaddr_pin *vaddr_pin)
 {
 	BUILD_BUG();
 	return 0;
@@ -1983,7 +1987,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 
 static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 		unsigned long end, struct page **pages, int *nr,
-		unsigned int flags)
+		unsigned int flags, struct vaddr_pin *vaddr_pin)
 {
 	BUILD_BUG();
 	return 0;
@@ -2075,7 +2079,8 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
 #endif /* CONFIG_ARCH_HAS_HUGEPD */
 
 static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages, int *nr)
+		unsigned long end, unsigned int flags, struct page **pages,
+		int *nr, struct vaddr_pin *vaddr_pin)
 {
 	struct page *head, *page;
 	int refs;
@@ -2087,7 +2092,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
 		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
-					     flags);
+					     flags, vaddr_pin);
 	}
 
 	refs = 0;
@@ -2117,7 +2122,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 }
 
 static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages, int *nr)
+		unsigned long end, unsigned int flags, struct page **pages, int *nr,
+		struct vaddr_pin *vaddr_pin)
 {
 	struct page *head, *page;
 	int refs;
@@ -2129,7 +2135,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 		if (unlikely(flags & FOLL_LONGTERM))
 			return 0;
 		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
-					     flags);
+					     flags, vaddr_pin);
 	}
 
 	refs = 0;
@@ -2196,7 +2202,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 }
 
 static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages, int *nr)
+		unsigned int flags, struct page **pages, int *nr,
+		struct vaddr_pin *vaddr_pin)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -2220,7 +2227,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 				return 0;
 
 			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
-				pages, nr))
+				pages, nr, vaddr_pin))
 				return 0;
 
 		} else if (unlikely(is_hugepd(__hugepd(pmd_val(pmd))))) {
@@ -2231,7 +2238,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
 					 PMD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
+		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr,
+					  vaddr_pin))
 			return 0;
 	} while (pmdp++, addr = next, addr != end);
 
@@ -2239,7 +2247,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 }
 
 static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr,
+			 struct vaddr_pin *vaddr_pin)
 {
 	unsigned long next;
 	pud_t *pudp;
@@ -2253,13 +2262,14 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 			return 0;
 		if (unlikely(pud_huge(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
-					  pages, nr))
+					  pages, nr, vaddr_pin))
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
 			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
 					 PUD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr))
+		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr,
+					  vaddr_pin))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
@@ -2267,7 +2277,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 }
 
 static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
-			 unsigned int flags, struct page **pages, int *nr)
+			 unsigned int flags, struct page **pages, int *nr,
+			 struct vaddr_pin *vaddr_pin)
 {
 	unsigned long next;
 	p4d_t *p4dp;
@@ -2284,7 +2295,8 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
 					 P4D_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr))
+		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr,
+					  vaddr_pin))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
@@ -2292,7 +2304,8 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 }
 
 static void gup_pgd_range(unsigned long addr, unsigned long end,
-		unsigned int flags, struct page **pages, int *nr)
+		unsigned int flags, struct page **pages, int *nr,
+		struct vaddr_pin *vaddr_pin)
 {
 	unsigned long next;
 	pgd_t *pgdp;
@@ -2312,7 +2325,8 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
 					 PGDIR_SHIFT, next, flags, pages, nr))
 				return;
-		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr))
+		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr,
+					  vaddr_pin))
 			return;
 	} while (pgdp++, addr = next, addr != end);
 }
@@ -2374,7 +2388,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_save(flags);
-		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
+		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr,
+			      NULL);
 		local_irq_restore(flags);
 	}
 
@@ -2445,7 +2460,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
 		local_irq_disable();
-		gup_pgd_range(addr, end, gup_flags, pages, &nr);
+		gup_pgd_range(addr, end, gup_flags, pages, &nr, NULL);
 		local_irq_enable();
 		ret = nr;
 	}
-- 
2.20.1

