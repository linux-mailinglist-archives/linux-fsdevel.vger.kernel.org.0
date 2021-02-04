Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B93A30EB4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 04:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhBDD6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 22:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhBDDzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:55:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E5C0617AA
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 19:55:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fa16so495863pjb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 19:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61XssS9hC3yvdXbWzdJhtTR8Yjia1vJaQF8aPfeYJmw=;
        b=hEsjQq399BYLQaa4G3mACRWtXR09Qe1HRCTJcok9uAmiEzX414JVvCHs4NvNaGS96O
         HYnGMvn5VX804tR3PJ9YNjyaZ+bZexbWkByhPRPmed35G2BIXgaXQq99yrweVBtjvSGr
         r+nQUBh5KGyMpyDgBZSLQmNihvxZ9hISeoCpoubaIHyqLNFP1qm99WG9M+6/+VCojM/W
         G9mltVuVoTpE5M1CIwZmFWvpvMgblU8pIqYKDgqJ4L05GXbH3k2DMQ6ZVBcreMNLvUhp
         3IUL3IMl+wmA1GJgpIAdDRtfs4SFf8ss3k46nNAT4thHWwYVTxWwFNxv+fHvTGs2rHZM
         j+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61XssS9hC3yvdXbWzdJhtTR8Yjia1vJaQF8aPfeYJmw=;
        b=XY1ZqWfl3st0b2RqMVkL+lLWiz/whOzvIg+o3SHFW6jKT5QkBvWqv0xJyQRwBQuwBi
         hK0f68CkiyYcyL7ddTMDdc0liNKi++dxC3cUmhQ4qwnaMhQVVDaUZ+WfD46dzD672+LM
         3NYgexhuITk+XlKJmyXriVfuwhYIFj3qxNoVBVyXSJg3p0kHIn9hwatLhT55GdixQydh
         LPFGWRprsYF+Pd671WIc8ExGdPmjn2VdovMux6GvAf6UsF8QEmEhB2IRuDlU5lQzRI6l
         mqK89V+QQnjpx4fyPdIcuLBWS+MN2I9DXBymkKQ2xqRE4pRagq+IQ8R3kPWpzxYVGUBG
         M+Xw==
X-Gm-Message-State: AOAM5329XpMQLDsPQ/ojv8D+qizJTVdgL3XZ7d3G2XGymFMdueEpU6cA
        bk0gmpNqlxJv0AWQVa2g4sKyfQ==
X-Google-Smtp-Source: ABdhPJymEyO5jCkZDSiQkPoZ425GLmAnOcns72vBeQg76oX3E/2kTSUpaVxq6nyo8yaTnx2fBBny0w==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr6228475pjq.0.1612410905026;
        Wed, 03 Feb 2021 19:55:05 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 9sm3747466pfy.110.2021.02.03.19.54.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:55:04 -0800 (PST)
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
Subject: [PATCH v14 6/8] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Thu,  4 Feb 2021 11:50:41 +0800
Message-Id: <20210204035043.36609-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210204035043.36609-1-songmuchun@bytedance.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
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
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 30 ++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.h    |  5 +++++
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
index 5518283aa667..04dde2b71f3e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3220,6 +3220,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 224a3cb69bf9..36ebd677e606 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -208,13 +208,10 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
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
 
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
@@ -269,3 +266,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
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
index 6f89a9eed02c..02a21604ef1d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -14,6 +14,7 @@
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
 			    gfp_t gfp_mask);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 #else
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
 					  gfp_t gfp_mask)
@@ -24,5 +25,9 @@ static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

