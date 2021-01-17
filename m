Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB72F9382
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbhAQPVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbhAQPOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:14:40 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8150C061793
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so3553416pfg.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dJD9jIzWDoyhaAcVJQeaUo28aYYhfu54r+mE2CBxNg=;
        b=WZDoQulZaOHqUK7FYNLKOHufGI3gm9j2qkD0tsBiPKndmaWLewA1SGkCa+UjuLc7rW
         TLPzKj1a2Zrn7sD4jCbTlW0NiAmZwQB8S3KLRRGiWWAQQtawa31SstAs/YN7mI+l+tM2
         +2ECS/Xej6ZG1fLc3Z7n7BEAyn7X6JN/z6MRe8R5BuKDrew2SI3j/dOPRU5zImglfkS+
         USUuSkIIhiabsDk74CkWVM3UP6XZOWlfrPnzpbQPj41BoDwSnKGid1Zz8cvqm7mYSJlk
         o5Ywnn/8mdJ5vo8e3fkQNIuFBjwLVmQy1aqOIQlplkLi0qZh5uoYmpRP+hT0hl5TQvZQ
         nIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dJD9jIzWDoyhaAcVJQeaUo28aYYhfu54r+mE2CBxNg=;
        b=tj8dzw7yMI3U6H4JzhcxpW/4a8SNROMuMFxa8BKkaVZVu5zx4AbIdg9Z+Ef0FH2TY/
         Qgp4kyULcRV2TrhKfgwLlVWwPNIW21L+51UpkyKVL1x/A/eCbiTH+xMbKdYilKnGocbZ
         FLlX/Zzco7NfNzucVFaAhOGwFk40rfJ2o2BwxrO6denzBH9lceyYJ3/owp3mSufYL6bK
         teWPZQ4EuszEEouHFLSmvvSvRik34IGd3Z+7nwfQtmK8aMbeWW88+h76RzPTRCAjRCrC
         T/Vp0KPpGQUkMO/p78w8yNm2NSDgVeI80FzP2Au3EsYEObBarBeT2G4iHl5AhDZz6dd9
         pB8Q==
X-Gm-Message-State: AOAM533kUUwRMduC48d6NTIENoc3FaGCiKQ9ZqXQCwZiV4Ah3ku9J4dM
        Qn4HHK/LFz3MnTsN1U55m+Tn6A==
X-Google-Smtp-Source: ABdhPJz+9H+G2DnPbSxxBH5sFXFhg3WUBNTmJ3IP8AMyUEP0AtODY7e2nHgbQHOSy42bOXlh6WCa1g==
X-Received: by 2002:a63:78ca:: with SMTP id t193mr22215079pgc.391.1610896450449;
        Sun, 17 Jan 2021 07:14:10 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.13.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:14:09 -0800 (PST)
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
Subject: [PATCH v13 04/12] mm: hugetlb: defer freeing of HugeTLB pages
Date:   Sun, 17 Jan 2021 23:10:45 +0800
Message-Id: <20210117151053.24600-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the subsequent patch, we should allocate the vmemmap pages when
freeing HugeTLB pages. But update_and_free_page() is always called
with holding hugetlb_lock, so we cannot use GFP_KERNEL to allocate
vmemmap pages. However, we can defer the actual freeing in a kworker
to prevent from using GFP_ATOMIC to allocate the vmemmap pages.

The update_hpage_vmemmap_workfn() is where the call to allocate
vmemmmap pages will be inserted.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 mm/hugetlb_vmemmap.c | 12 ---------
 mm/hugetlb_vmemmap.h | 17 ++++++++++++
 3 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 140135fc8113..c165186ec2cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,15 +1292,85 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
-static void update_and_free_page(struct hstate *h, struct page *page)
+static void __free_hugepage(struct hstate *h, struct page *page);
+
+/*
+ * As update_and_free_page() is always called with holding hugetlb_lock, so we
+ * cannot use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
+ * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
+ * the vmemmap pages.
+ *
+ * The update_hpage_vmemmap_workfn() is where the call to allocate vmemmmap
+ * pages will be inserted.
+ *
+ * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of pages
+ * to be freed and frees them one-by-one. As the page->mapping pointer is going
+ * to be cleared in update_hpage_vmemmap_workfn() anyway, it is reused as the
+ * llist_node structure of a lockless linked list of huge pages to be freed.
+ */
+static LLIST_HEAD(hpage_update_freelist);
+
+static void update_hpage_vmemmap_workfn(struct work_struct *work)
 {
-	int i;
+	struct llist_node *node;
+
+	node = llist_del_all(&hpage_update_freelist);
+
+	while (node) {
+		struct page *page;
+		struct hstate *h;
+
+		page = container_of((struct address_space **)node,
+				     struct page, mapping);
+		node = node->next;
+		page->mapping = NULL;
+		h = page_hstate(page);
+
+		spin_lock(&hugetlb_lock);
+		__free_hugepage(h, page);
+		spin_unlock(&hugetlb_lock);
 
+		cond_resched();
+	}
+}
+static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
+
+static inline void __update_and_free_page(struct hstate *h, struct page *page)
+{
+	/* No need to allocate vmemmap pages */
+	if (!free_vmemmap_pages_per_hpage(h)) {
+		__free_hugepage(h, page);
+		return;
+	}
+
+	/*
+	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap
+	 * pages.
+	 *
+	 * Only call schedule_work() if hpage_update_freelist is previously
+	 * empty. Otherwise, schedule_work() had been called but the workfn
+	 * hasn't retrieved the list yet.
+	 */
+	if (llist_add((struct llist_node *)&page->mapping,
+		      &hpage_update_freelist))
+		schedule_work(&hpage_update_work);
+}
+
+static void update_and_free_page(struct hstate *h, struct page *page)
+{
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[page_to_nid(page)]--;
+
+	__update_and_free_page(h, page);
+}
+
+static void __free_hugepage(struct hstate *h, struct page *page)
+{
+	int i;
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ffa2a4ae2a8..19f1898aaede 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -178,18 +178,6 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-/*
- * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
- */
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
-{
-	return 0;
-}
-
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 {
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 6923f03534d5..01f8637adbe0 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -12,9 +12,26 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+
+/*
+ * How many vmemmap pages associated with a HugeTLB page that can be freed
+ * to the buddy allocator.
+ *
+ * Todo: Returns zero for now, which means the feature is disabled. We will
+ * enable it once all the infrastructure is there.
+ */
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #else
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

