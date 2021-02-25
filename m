Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6732506D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBYN1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhBYNZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D06C061222
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:52 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t25so3783210pga.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMtr9FkjUja9fNTQt0RC29vFN9iD9O5NxbdKTLOUbHg=;
        b=WQ6NC+BZ2eXNnTn47JK0Qk5kLQqh47dMzoSBcJZqeZCDdQDNPBIiOTt0SB94juo103
         T7EkflDcGMAoQSTwPusNn0Ge3Pk6VUyQFuz407gbmIf00e9Wk7X7AUs8Rcfz4wvQxItL
         x9+F0wPQTbilTR7NqUXMem9G4ntPbyjGzMQAREObWngkkACYiOPL/D0X1H+xEYOM9EnZ
         EhWMNyQ556etNLBAk1KDJaPPBQmjjT1wpyzlCOmCacmo3sGOjYEcIr2bvZ4rnpbg21RX
         P43xfTTcaEZmdE8D16tqqxvj7J0gKY+XLut9H9+5gvzCatMg5Kxdnl/C79Cpzi8jibkH
         bzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMtr9FkjUja9fNTQt0RC29vFN9iD9O5NxbdKTLOUbHg=;
        b=GpLiDqtdL1/mn9eZ0s2vufJIjHQEmtoIfzw2FTEp7U/HsCQ9BO2ytQ/TiYXIh1felu
         WCEwouZohwxDyJNqiPgwGIrcZAbsag1ZibYuHDALPAm5rHDuQsf7FXuNvmv9RuSECgcR
         hSZxA1uiA7tDsRVwVyTYgTGtu2Zus0Frf2dEdwS/jG2N1hcaAiGOO77VomVNBSNyf9/k
         nNvVq9s9XaLnUfIhvuKCrw5B7ZrlKAUgvJcqQ64Di72mZmpScXkykwPLNVr1ta1HofD2
         tZnF+6KVKEMAn3x44xbBvu6f/XEUMHx8iOz2rkUQ09UDfaWhB1RPNAMy2+rhraDCwJXI
         Vvpw==
X-Gm-Message-State: AOAM533C1XF/1w3S1L8dOaV1daIVuLJ2fFRBQuQKAXzd3HHd8045r7h3
        o4WZ482eQGET6EQ7s7dz2jxuKw==
X-Google-Smtp-Source: ABdhPJz2UOugiz4Kv0LuAfkbkqxCNr5UJuhJ0CvwRpQRIblrWmKWiQorW9EeyEns7fRbuDCI690LHA==
X-Received: by 2002:a63:9811:: with SMTP id q17mr3005582pgd.238.1614259492014;
        Thu, 25 Feb 2021 05:24:52 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id x190sm6424676pfx.166.2021.02.25.05.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:24:51 -0800 (PST)
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
Subject: [PATCH v17 7/9] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Thu, 25 Feb 2021 21:21:28 +0800
Message-Id: <20210225132130.26451-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
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
index 78934e9aeab6..a4d80f7263fc 100644
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
index bccb6907833f..4d192ba183f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3312,6 +3312,7 @@ void __init hugetlb_add_hstate(unsigned int order)
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

