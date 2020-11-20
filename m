Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2582BA27B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKTGrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKTGq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:46:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFFC0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:58 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f18so6477234pgi.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88Vyf1Pcm29kb9drVzemkW2MmMhaFRrGbBNvTcfU0mI=;
        b=VmrGqdVEOmmHQIibPHpVJJjw83uIZZNbNV7ajzRc+ac94AKkBDewjWcEn0w1pLdNww
         SYgU3lDsbdUs2nBjB9CVxNVWksSQOgZSz7RhoKAsntzXOatfNxp/bnOl96fstM6HxRWc
         Qw55+TZP9tbhXQXk7PXbT3kZFCGah5DtZGIH2jzYKhqRynAxkqd+qkdAPrV/wo8sBlhw
         5V1y3bMzOQSzjsuoyXb5S74L1+IlvSnynuGzUEpYLTQJy1tZjK0CxMF9LfsMR2ILa70e
         Fpc7/r2DvD1XMTOSAbac2R+eixL4bGYtNgC6cBB2bYxFmZ0F5CgUSwqb6xIeeGSJ7a70
         7dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88Vyf1Pcm29kb9drVzemkW2MmMhaFRrGbBNvTcfU0mI=;
        b=Xocbem55uRv+l44R2qoTFLv9HOESdIDl+pECW7Ja7umm/Lq5TDUQu+f7Zn44KGmwls
         ldhJy/PjtGU65cC9qnIBdoRfg2mwG+tvJE2GRNZFaKpZrGXBnVaG2FuK3RrZNnZjHYpT
         wvCsZnybSPjyjywPistYrKYXHtPrH1FgmaPWrcPHTcURM5BB8VM3NSpWHdUyd+HiV3zm
         YRxSJ2YBympS7r0OYDPTBdn2+yGCWyVWF4OFkHQrWmS5SYMfa6DL0lldWKiePyL08ENK
         Yp+oQQ2IIejCFF0gzA5epejgrRD57vnXT18NnaqHSsxzjxVXvzGMNnxPGFEAqW/i49Jt
         6I7g==
X-Gm-Message-State: AOAM530xqJgCwi3+gZ0c3KFveDM64eOJnuyopba2s6OVYSy/KiGHCzlJ
        SbduNjKzraJ8p8GXgBqGG1tuuw==
X-Google-Smtp-Source: ABdhPJyA2pbz2sUo0O1TKkJnOt8g0Z0zF62vjdl9xLhDjvD5IAhMOMWolvPOKpNYn7tiG+C8sefhJw==
X-Received: by 2002:aa7:8552:0:b029:18e:f030:e514 with SMTP id y18-20020aa785520000b029018ef030e514mr12036552pfn.2.1605854818095;
        Thu, 19 Nov 2020 22:46:58 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.46.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:46:57 -0800 (PST)
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
Subject: [PATCH v5 05/21] mm/hugetlb: Introduce pgtable allocation/freeing helpers
Date:   Fri, 20 Nov 2020 14:43:09 +0800
Message-Id: <20201120064325.34492-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On x86_64, vmemmap is always PMD mapped if the machine has hugepages
support and if we have 2MB contiguous pages and PMD alignment. If we
want to free the unused vmemmap pages, we have to split the huge PMD
firstly. So we should pre-allocate pgtable to split PMD to PTE.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 ++++++++
 2 files changed, 87 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 1afe245395e5..ec70980000d8 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -99,6 +99,8 @@
  */
 #define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
 
+#include <linux/list.h>
+#include <asm/pgalloc.h>
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -111,6 +113,80 @@
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
+	/*
+	 * Use the huge page lru list to temporarily store the preallocated
+	 * pages. The preallocated pages are used and the list is emptied
+	 * before the huge page is put into use. When the huge page is put
+	 * into use by prep_new_huge_page() the list will be reinitialized.
+	 */
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
index 40c0c7dfb60d..9eca6879c0a4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,9 +12,20 @@
 
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

