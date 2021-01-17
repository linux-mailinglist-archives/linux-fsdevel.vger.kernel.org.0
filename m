Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106CC2F9374
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbhAQPSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbhAQPQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:16:39 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BAC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:15:58 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b3so8689544pft.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0r+JCD4Y++UkuwDhT+3Um93OT5s28ZmvypPmtNNw098=;
        b=k3Gn2lQZJK8zZF5Q1z8ZjLNvPnzK5/qZdud4LaC7Yj1dyg2sl7cpQf/+0XUKKYdWQx
         WhNSsHSTKLgmfSsqrdbqmvxZD4qSxmCCwlmLPpclfky+xXSmz7Qcd5MOvMPylsZ/pjnQ
         HRQGQpdO4BE9H8GB6BgKj/ABgy9LOjF/KXDImUfybGguvK9YNKAhTloNE+2fJT88U4yq
         Fu3LeTXn3puHbsEI7xC6kNamrthlNG2txj7TAjyzey8v6exTL492dsO1uIDx/sGgiBOk
         wW7hJ1HyfruwjSTDGE7+vGqTWth/7iMnbJwiklJkDyPeErBOx14tXMaetliubMkO2u4H
         n4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0r+JCD4Y++UkuwDhT+3Um93OT5s28ZmvypPmtNNw098=;
        b=noOFTIb4RU4IuMIwIJa6GFn2Yjend7SQo1CcCC38Ml8J24t9GfvPJYep7Q31oVdR2H
         ODDRS7AdGvcEIA5l7mMnWDtMzhJSuS1qO5/O1piGcUbTzW3pbuVbid/yVWZRMjom8v+j
         xQwIL1NYZpzDkQQwC5WpKLfMGigNBDIaP54W3rC4ktT1G6X0uryD3RbLi3S+bpR4Upu8
         heUbEFZoRb3XYNwwrUjd4cRUGT7GGD8t159E1bXvCMNkGl+J3MAq08pjkEhCGzdgqkmv
         eA/Mxa+2LSspbPL/w+KTjirO+2sVEcNeG77HlDbbBzEtb8cn4Rs5dMkNw35DZ41CmCn5
         psJg==
X-Gm-Message-State: AOAM533sIKJW7wDG3pwBxTqfMV9gnJSQbg4LAHkVpH439zzmKhb9QV/9
        EBpwbvWFMqEvY637oqQ6n38lHg==
X-Google-Smtp-Source: ABdhPJzeWgpcmNzxzNxHDXk9WwDEnqjTordZah07UE2deqp7jFbfH+5aDWblVQ4OEouKj3q3At/s9Q==
X-Received: by 2002:aa7:9384:0:b029:1ae:4dbf:f34d with SMTP id t4-20020aa793840000b02901ae4dbff34dmr22081917pfe.11.1610896558373;
        Sun, 17 Jan 2021 07:15:58 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.15.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:15:57 -0800 (PST)
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
Subject: [PATCH v13 11/12] mm: hugetlb: gather discrete indexes of tail page
Date:   Sun, 17 Jan 2021 23:10:52 +0800
Message-Id: <20210117151053.24600-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For HugeTLB page, there are more metadata to save in the struct page.
But the head struct page cannot meet our needs, so we have to abuse
other tail struct page to store the metadata. In order to avoid
conflicts caused by subsequent use of more tail struct pages, we can
gather these discrete indexes of tail struct page. In this case, it
will be easier to add a new tail page index later.

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h        | 14 ++++++++++++++
 include/linux/hugetlb_cgroup.h | 15 +++++++++------
 mm/hugetlb.c                   | 25 ++++++++++++-------------
 mm/hugetlb_vmemmap.c           |  8 ++++++++
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 66d82ae7b712..05fd2db09b78 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,20 @@ typedef struct { unsigned long pd; } hugepd_t;
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
+enum {
+	SUBPAGE_INDEX_ACTIVE = 1,	/* reuse page flags of PG_private */
+	SUBPAGE_INDEX_TEMPORARY,	/* reuse page->mapping */
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_CGROUP = SUBPAGE_INDEX_TEMPORARY,/* reuse page->private */
+	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
+#endif
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	SUBPAGE_INDEX_HWPOISON,		/* reuse page->private */
+	SUBPAGE_INDEX_INFLIGHT,		/* reuse page->private */
+#endif
+	NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..3d3c1c49efe4 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -24,8 +24,9 @@ struct file_region;
 /*
  * Minimum page order trackable by hugetlb cgroup.
  * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[2]) is the fault usage cgroup.
- * The third tail page (hpage[3]) is the reservation usage cgroup.
+ * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
+ * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
+ * is the reservation usage cgroup.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2
 
@@ -66,9 +67,9 @@ __hugetlb_cgroup_from_page(struct page *page, bool rsvd)
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
 	if (rsvd)
-		return (struct hugetlb_cgroup *)page[3].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
 	else
-		return (struct hugetlb_cgroup *)page[2].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
 }
 
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
@@ -90,9 +91,11 @@ static inline int __set_hugetlb_cgroup(struct page *page,
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
 	if (rsvd)
-		page[3].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+				 (unsigned long)h_cg);
 	else
-		page[2].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+				 (unsigned long)h_cg);
 	return 0;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0e14fad63823..fdabc1d0ef98 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1346,17 +1346,17 @@ static inline void flush_hpage_update_work(struct hstate *h)
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 static inline bool PageHugeInflight(struct page *head)
 {
-	return page_private(head + 5) == -1UL;
+	return page_private(head + SUBPAGE_INDEX_INFLIGHT) == -1UL;
 }
 
 static inline void SetPageHugeInflight(struct page *head)
 {
-	set_page_private(head + 5, -1UL);
+	set_page_private(head + SUBPAGE_INDEX_INFLIGHT, -1UL);
 }
 
 static inline void ClearPageHugeInflight(struct page *head)
 {
-	set_page_private(head + 5, 0);
+	set_page_private(head + SUBPAGE_INDEX_INFLIGHT, 0);
 }
 #else
 static inline bool PageHugeInflight(struct page *head)
@@ -1404,7 +1404,7 @@ static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
 	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
 		return;
 
-	page = head + page_private(head + 4);
+	page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
 
 	/*
 	 * Move PageHWPoison flag from head page to the raw error page,
@@ -1423,7 +1423,7 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
 		return;
 
 	if (free_vmemmap_pages_per_hpage(h)) {
-		set_page_private(head + 4, page - head);
+		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
 	} else if (page != head) {
 		/*
 		 * Move PageHWPoison flag from head page to the raw error page,
@@ -1433,7 +1433,6 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
 		ClearPageHWPoison(head);
 	}
 }
-
 #else
 static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
 {
@@ -1514,20 +1513,20 @@ struct hstate *size_to_hstate(unsigned long size)
 bool page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
+	return PageHead(page) && PagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /* never called for tail page */
 static void set_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	SetPagePrivate(&page[1]);
+	SetPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 static void clear_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	ClearPagePrivate(&page[1]);
+	ClearPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /*
@@ -1539,17 +1538,17 @@ static inline bool PageHugeTemporary(struct page *page)
 	if (!PageHuge(page))
 		return false;
 
-	return (unsigned long)page[2].mapping == -1U;
+	return (unsigned long)page[SUBPAGE_INDEX_TEMPORARY].mapping == -1U;
 }
 
 static inline void SetPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = (void *)-1U;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = (void *)-1U;
 }
 
 static inline void ClearPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = NULL;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = NULL;
 }
 
 static void __free_huge_page(struct page *page)
@@ -3374,7 +3373,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 		return;
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
-	BUG_ON(order == 0);
+	BUG_ON((1U << order) < NR_USED_SUBPAGE);
 	h = &hstates[hugetlb_max_hstate++];
 	h->order = order;
 	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 7dcb4aa1e512..6b8f7bb2273e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -242,6 +242,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
-- 
2.11.0

