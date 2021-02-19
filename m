Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3486031F7B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBSKzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 05:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhBSKx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:53:57 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6EBC06121D
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:53:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p21so3752950pgl.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1EnHU5l0+wf4gHvbzG2Daa/11YOmitNSipgSuyv6Rw=;
        b=k2iAD+DDOgC50ZgifQfOLtysdrRGzS1m6KtfOdyYvhUGFTwrUW6SFmXejlTHeSMcgL
         1aGkGGKPDRHM9ME/jQr54u6oaTr9a5cxSL1E2xkDOvHEG+dIXqFYdtwSIhQDSQ1YqF+Y
         CTICY3Sj7Extok2q3Aev7E1g1rjMUf80qZL6gQvsaf06v46tsxC7hFpwM2vpNw84VXvq
         WXb81w6wd2Vggin6Gg+Sb38qM141Z5fAghCCMoEebg8I2UG5KPN2sG2GCZH/OAcFG4Ej
         u5Uyz/IEvxanuuDvFTZK6/kE255EJeOVYi9rkaQqj4DIh7LwYDDQ7KXVaGzjluzZ8Eg8
         4/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1EnHU5l0+wf4gHvbzG2Daa/11YOmitNSipgSuyv6Rw=;
        b=bG44Reg4qsvwoHb9Aj7cnQc5Zg0Wvxf3WnL8MHpBXgFKF3/tMZ2CjNY/7H3hUy5CB4
         keJTs0OwY/o++S+fLs6e7IZVNmY0RFmah30QR2gzJkypfRXJJnYM28W2XfOFTeiAwtEO
         ad6kiQKLjQskzV0Y4PuhGMUTNJvQpkaaVkaVnTYIuzMpR7OFkLkQDNe0ZHgWle7QD9tj
         J0LvudMtMttcKPG35G+MPBFu2WLlVlMsvir2453BfHOSIoPhtsSSmbVHg7HYsK25PBMV
         4qg2G8No1Ld0Vjsf3VDZw8HQS07HqF50cWvV+lxiZP2vUSw0pJynza+4kKjiDOdfmMYI
         0Yaw==
X-Gm-Message-State: AOAM533fsGIFbq3NW3bXviY9kngnrF/Q7iTOtyr+rmIkYZOrCtQTX37V
        trsHsdhOEgjsyFq9mz02TNN5pw==
X-Google-Smtp-Source: ABdhPJyGRhAicHyu583XL/VSN6FGDLqFQX+AnLbdigI7h63liujMTzdvW7psPraCIEZiJxRfYmuOzA==
X-Received: by 2002:a63:585d:: with SMTP id i29mr8004154pgm.10.1613731997101;
        Fri, 19 Feb 2021 02:53:17 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id x1sm9662193pgj.37.2021.02.19.02.53.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:53:16 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v16 7/9] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Fri, 19 Feb 2021 18:49:52 +0800
Message-Id: <20210219104954.67390-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210219104954.67390-1-songmuchun@bytedance.com>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
field in the hstate to indicate how many vmemmap pages associated with
a HugeTLB page that can be freed to buddy allocator. And initialize it
in the hugetlb_vmemmap_init(). This patch is actual enablement of the
feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 25 +++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ad249e56ac49..775aea53669a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -560,6 +560,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f0877411f790..f58331853db9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3305,6 +3305,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 7807ed6678e0..b65f0d5189bd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -251,3 +251,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 */
 	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	if (!hugetlb_free_vmemmap_enabled)
+		return;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * allocator, the other pages will map to the first tail page, so they
+	 * can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
+	 * on some architectures (e.g. aarch64). See Documentation/arm64/
+	 * hugetlbpage.rst for more details.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+
+	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a37771b0b82a..cb2bef8f9e73 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,17 +13,15 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return 0;
+	return h->nr_free_vmemmap_pages;
 }
 #else
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
@@ -35,6 +33,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
-- 
2.11.0

