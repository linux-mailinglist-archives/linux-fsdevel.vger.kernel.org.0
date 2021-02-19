Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463AE31F7B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBSKzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 05:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBSKxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:53:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C17C061356
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:52:54 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p21so3751834pgl.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbL3Iq/tlQKaMY7+ENkq1giGyxHjMyxq30iguX+T2Xg=;
        b=b8+RCL0XLP/mP/uuf0ArdrG6YUP6u0r+K23hdKtgbqZc86K+O3Pc1oAqgfR71Rxq5J
         ZL12a/lWwfL8quq3c7jBYlA2HrYyhLeYh3RHrIoQ7jPVYRNBsQHGo1wVKXEq8HIOxxDm
         ClzL1VxCWxVmEj2noq/OdiHMzW/cD+q6i0DBBWRa7DiMosPfUt5c1WbmYTkJvd8xhgCJ
         yqQw7+IPoHnLFqfg5ZyNRo2DjXtcN/S+eG3NO+Di1clk6Luj5OTK8JM+VQ/9mQ2LSVDN
         W20iL+miSRqojFd0211tau7RINh/q8ZTzCbJrl/QMe/NLNsKjEATn+IF061FOWdjejUY
         MLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbL3Iq/tlQKaMY7+ENkq1giGyxHjMyxq30iguX+T2Xg=;
        b=UEGm/8VyowLZ/zG5r4ya0dAxvo5k7uKGPnDZNL+In23xD2ph6xK/7eqmBDa1zDF6aO
         xNKREdFz/4rdFJ5bKHa9OCKerDAdLaMnHIHmMD5LivuFRsfcZ2DZdmozt/VFyfDBLY2+
         v1Jvy/zjb90Q5PE3Gp07jheS9KqtvFK0Q5HUhaD7QBgoPAsP5Q6ap7MGZC0dRbP02Ayy
         hN9tMY3UWp22RSd0eJU7p7p3ep7nmVtSwqdGJYpWPcdvKlDZ6WfNizHXKEcbWDaNJZnA
         TDqKBl1qyC210/gTdOn3Wd1naSkNou67qs6d+Ic3V9e1fGCTsInd0zhNUpZZHdO+EN7i
         xlqA==
X-Gm-Message-State: AOAM533C0vsB3qJE5rCPaXGwDYHWItEy3eDSTKUua0ZVbCUNomcM4hFd
        JA9ONpSxZ5ggseRVnoIWVWOtNQ==
X-Google-Smtp-Source: ABdhPJxniWBzV0gBHXJrKBk5wa91AXlRmw0Gkx8HF/+cf1IdDPvx6EuhKmDKQSmuJ4tPyNqQGJ2Qfw==
X-Received: by 2002:aa7:9393:0:b029:1ec:bf17:9270 with SMTP id t19-20020aa793930000b02901ecbf179270mr8890456pfe.70.1613731973970;
        Fri, 19 Feb 2021 02:52:53 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id x1sm9662193pgj.37.2021.02.19.02.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:52:53 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v16 5/9] mm: hugetlb: set the PageHWPoison to the raw error page
Date:   Fri, 19 Feb 2021 18:49:50 +0800
Message-Id: <20210219104954.67390-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210219104954.67390-1-songmuchun@bytedance.com>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail vmemmap page frame and remap it
with read-only, we cannot set the PageHWPosion on some tail pages.
So we can use the head[4].private (There are at least 128 struct
page structures associated with the optimized HugeTLB page, so
using head[4].private is safe) to record the real error page index
and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.c | 12 --------
 mm/hugetlb_vmemmap.h | 17 +++++++++++
 3 files changed, 91 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bcf856974c48..f0877411f790 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1305,6 +1305,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+	struct page *page;
+
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	page = head + page_private(head + 4);
+
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (!PageHWPoison(head))
+		return;
+
+	if (free_vmemmap_pages_per_hpage(h)) {
+		set_page_private(head + 4, page - head);
+	} else if (page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	set_page_private(head + 4, 0);
+}
+#else
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (PageHWPoison(head) && page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+}
+#endif
+
 static int update_and_free_page(struct hstate *h, struct page *page)
 	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
 {
@@ -1351,6 +1419,8 @@ static int update_and_free_page(struct hstate *h, struct page *page)
 		return -ENOMEM;
 	}
 
+	hwpoison_subpage_deliver(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
@@ -1795,22 +1865,17 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
+		hwpoison_subpage_set(h, head, page);
 		ClearHPageFreed(page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
 		rc = update_and_free_page(h, head);
-		if (rc)
+		if (rc) {
 			h->max_huge_pages++;
+			hwpoison_subpage_clear(h, head);
+		}
 	}
 out:
 	spin_unlock(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 29a3380f3b20..f7ab3d99250a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -181,18 +181,6 @@
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
index e5547d53b9f5..a37771b0b82a 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,18 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
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
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
@@ -22,5 +34,10 @@ static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
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

