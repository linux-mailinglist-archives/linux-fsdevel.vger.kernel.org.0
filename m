Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB636A56C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhDYHPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhDYHPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:15:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF48C061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:14:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so36897138pfc.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7E9xxvtIaGoCVHKrBienU8O4EF8xbijYGjRWUP+xNQ=;
        b=tfD1/0Rrs9QLHAe+XDoBLSsiOGvAfo7UPeNO3TvB0I9YNsovxZnHvyJCBVMLAGaeJ6
         VeBJhqrtHPwKyGjLTmcTGkIAig7dSRfq0DnzUQaHWukyvgXcB7zGIaY4xuqiAfBfRrkG
         19A8bLMrK1bAd/smR40Pb3f2ryKuvWRdC5X1jtZuckqy/eniKorMV6bjAhmKa2lXfIMr
         x7Bz38c0+raE89+dZVcSLPbApJ980ASHMWEm+ulIIOMijksJ1sgfm/+7rUM+2iKBW1+L
         VXzESxCQQE0MCLXC9gUoa6LF7Qm5vBE+/0Hu9p2w+5U6PqxJYCR3k0spfhInpn4A6MqV
         FPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7E9xxvtIaGoCVHKrBienU8O4EF8xbijYGjRWUP+xNQ=;
        b=O/40pxa6tDYOK6nt5izWN1PR2ejmFaizj/q3KYM4EfdHWDcr3jbK/AsdyUGtAbig5M
         zw4Q38pWlUb3R0bGlo6x31Uny9nS3vKmn2XA7gZUDnVV1p++DUeeD1MqhK87x7+aQ8DB
         /Y/+OgGDaoL+8anH35RD/VJbdxCCgHQSsTOrkPlvvSk37gteN9DFYn0Gdski3Bxw6sWH
         WskMFGm8YE+8ufCyAZY+dgDXIaqf/PhuuepGUsxCvVRTR+QgWaeI3mvKO7vgydi8g8Q7
         yvxtwXT6lPy3EF1HoQd1tDRs728hWH/LA0J8lb8R57edJUXYzoaC345VQSuvI9THEbt7
         05TA==
X-Gm-Message-State: AOAM532RQeK94ONUqapuNTjZmOMRgGzlTEQ/+8Fyw92BJ5cLg42f79Bu
        V57b6ePxtA6gOwUGMU+fKTtd3w==
X-Google-Smtp-Source: ABdhPJxV+24WPh7aprLog7xJUYz8OvYabaL/FKS2fFZ/ta2X1S8bPUnjuEqxMaMkb8pt77ZwdTK3Hw==
X-Received: by 2002:a63:d507:: with SMTP id c7mr11382542pgg.306.1619334870996;
        Sun, 25 Apr 2021 00:14:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h8sm8767125pjt.17.2021.04.25.00.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 00:14:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v21 9/9] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Sun, 25 Apr 2021 15:07:52 +0800
Message-Id: <20210425070752.17783-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210425070752.17783-1-songmuchun@bytedance.com>
References: <20210425070752.17783-1-songmuchun@bytedance.com>
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

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 33 +++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65865d523ef7..c7e66251997d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -602,6 +602,9 @@ struct hstate {
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
index 1e3e3a8e05e2..9c617c19fc18 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3521,6 +3521,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3070e1465b1b..f9f9bb212319 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -262,3 +262,36 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	SetHPageVmemmapOptimized(head);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
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

