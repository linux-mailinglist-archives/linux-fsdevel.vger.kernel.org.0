Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46192B19EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMLSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgKMLCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:09 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A938C061A53
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:52 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so6790843pgr.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgKZ0gBbzr5Y1R6IbjL9V67vQkRA/Xenmaet0eZn1jI=;
        b=WHRw8PZCdlUW+Ct60o/wJTbtCRkWymC3+ozO2o4xnhtWd3zzxeCSnf30bccZp6xzy4
         +tTcOs3I6WX/N6lD5i1sLgTmz/5B/SWP+MWQx04YC4Ha6Uy3+iUH7O79oBW5DZ1Clmko
         z4M5Yj3N+ZfOoHLU3AoUO+kMMaJ+QIXea+8RvHlVVCgk5InzQPNnuy8+6KsqC7vOdwWW
         jny1Ho5Br8/nO5IRAWJGLslGttCNvapDZQkAkdl/MbZZJLnhI6eK7kRUgkqpJIG5zPNy
         M3J2ojBtrl9u09K4ppggcLSNf7lZH7LUTwKtvcqlLLBqVjdGyTgxbmC503UhoiEq63CS
         enQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgKZ0gBbzr5Y1R6IbjL9V67vQkRA/Xenmaet0eZn1jI=;
        b=Ath1iSIqsaJUOATsMHiUHMc2LTczSQMZKxlhMLdf8DtK7ZroD4r5isWc7tOCKDNLm4
         smdaa3B0OZadrIwsH9k90dUd5vl0Ow1HPCdK7LKzck68bXtCzuFx0t90iH0dKDpGsQII
         JVCdwMnf07MHmYvYmP4icbHQwT+ZfMlz2mhIwjzKnr2/kC/BP3WQa11oVSVAOkPWBYpp
         embLsw6DRcteyf3vI8x861o/cKoL2uXhnhy8EDng9jra2+DgPorWNwmApFuqPMyHtYXf
         93XHa9IOHWX3FuH2QwLCdpe5Wa+zeP1ZlUKlCkca+N8p5tIdT/WRiTbS6Qd3mSdnisW8
         pvkQ==
X-Gm-Message-State: AOAM533j+pCd6WyC5P2kHC0zqpaAQPHYq9CkiYhPkC4GiWjF23OxAxEO
        HRFG3peD5R65hkgFxPPA3eeDMw==
X-Google-Smtp-Source: ABdhPJwY3zGp6zFuIGwwhXgYIEFo1bUv9jDKGGKu4tB/Cr++GdoMqEUxYD2qfW+e+Lja4kSHIAKnyA==
X-Received: by 2002:a17:90a:4215:: with SMTP id o21mr2307679pjg.166.1605265312084;
        Fri, 13 Nov 2020 03:01:52 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:01:51 -0800 (PST)
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
Subject: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable allocation/freeing helpers
Date:   Fri, 13 Nov 2020 18:59:36 +0800
Message-Id: <20201113105952.11638-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On x86_64, vmemmap is always PMD mapped if the machine has hugepages
support and if we have 2MB contiguos pages and PMD aligned. If we want
to free the unused vmemmap pages, we have to split the huge pmd firstly.
So we should pre-allocate pgtable to split PMD to PTE.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 12 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a6c9948302e2..b7dfa97b4ea9 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -71,6 +71,8 @@
  */
 #define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
 
+#include <linux/list.h>
+#include <asm/pgalloc.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -83,6 +85,77 @@
  */
 #define RESERVE_VMEMMAP_NR		2U
 
+#ifndef VMEMMAP_HPAGE_SHIFT
+#define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
+#endif
+#define VMEMMAP_HPAGE_ORDER		(VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPAGE_NR		(1 << VMEMMAP_HPAGE_ORDER)
+#define VMEMMAP_HPAGE_SIZE		((1UL) << VMEMMAP_HPAGE_SHIFT)
+#define VMEMMAP_HPAGE_MASK		(~(VMEMMAP_HPAGE_SIZE - 1))
+
+#define page_huge_pte(page)		((page)->pmd_huge_pte)
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
+static inline unsigned int pgtable_pages_to_prealloc_per_hpage(struct hstate *h)
+{
+	unsigned long vmemmap_size = vmemmap_pages_size_per_hpage(h);
+
+	/*
+	 * No need pre-allocate page tables when there is no vmemmap pages
+	 * to free.
+	 */
+	if (!free_vmemmap_pages_per_hpage(h))
+		return 0;
+
+	return ALIGN(vmemmap_size, VMEMMAP_HPAGE_SIZE) >> VMEMMAP_HPAGE_SHIFT;
+}
+
+void vmemmap_pgtable_free(struct page *page)
+{
+	struct page *pte_page, *t_page;
+
+	list_for_each_entry_safe(pte_page, t_page, &page->lru, lru) {
+		list_del(&pte_page->lru);
+		pte_free_kernel(&init_mm, page_to_virt(pte_page));
+	}
+}
+
+int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	/* Store preallocated pages on huge page lru list */
+	INIT_LIST_HEAD(&page->lru);
+
+	while (nr--) {
+		pte_t *pte_p;
+
+		pte_p = pte_alloc_one_kernel(&init_mm);
+		if (!pte_p)
+			goto out;
+		list_add(&virt_to_page(pte_p)->lru, &page->lru);
+	}
+
+	return 0;
+out:
+	vmemmap_pgtable_free(page);
+	return -ENOMEM;
+}
+
 void __init hugetlb_vmemmap_init(struct hstate *h)
 {
 	unsigned int order = huge_page_order(h);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 40c0c7dfb60d..2a72d2f62411 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -9,12 +9,24 @@
 #ifndef _LINUX_HUGETLB_VMEMMAP_H
 #define _LINUX_HUGETLB_VMEMMAP_H
 #include <linux/hugetlb.h>
+#include <linux/mm.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void __init hugetlb_vmemmap_init(struct hstate *h);
+int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page);
+void vmemmap_pgtable_free(struct page *page);
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
+
+static inline int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
+{
+	return 0;
+}
+
+static inline void vmemmap_pgtable_free(struct page *page)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

