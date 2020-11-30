Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA42C87C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgK3PWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgK3PV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:21:59 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF4C0617A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:13 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so10248265pgi.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AROpevGsmraJS2E24AC4gycXj2TEwOrJX0mQgAFYrzY=;
        b=pwSZzac3IBcilPGXWUeBgyY+Fg7/95ymV3hblc/nKN3k8/VWi05Mm0dVLFWqOP6JEF
         frGeFrlddmHPh3u/8lHiQxLFlw2ZJY9GgTwc+Wm1eIsHZK4BjW5TPW6CyDCzJB0/Gl3x
         0H5/WdIuCGDS9AKNSEZP0O6Qk7kElZ4ABSRnuQdDvRo1kBkF8frslTucIdUGhMZzeM0q
         ip49yBijOT7TDl6o4rRvxt5F/MvC8oKg3UTT2dZ+wxT0RemzBFGtpGNp9dz7hZp4x9/j
         eXT1PQVQYY4E7pGGwGLLTl/kWkg4qEdf6gcFvSPU1WslDsyTtBlDsAV4lFha5LfanNzo
         Ws3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AROpevGsmraJS2E24AC4gycXj2TEwOrJX0mQgAFYrzY=;
        b=lEJwaJc4BLUFcfzQKvPBjrfgATi/U0ABE/SmYK7NuIwndY+OjjOcJb25DMXtFPbJ+0
         UT9uRieAe1R0TU4tAfvIq0O4/1lhv0xLsh8kAK9ELmr33kEX8YP6BVLj4rrzUXxNUqMx
         8Ln4Tn3jwKOOvuFIt9jTS8BLkMpceQmWqprbU0v8tQ0lplGQ8M8P4I1++2hhnVORYe1U
         +ccWvhLRIVrDcPXnZj3UnrNdt39BblYdmT8eos4TrOAczd9VPzksZ7hn7VYACO4tr74R
         kQlbFtNwOY6R6mXNEg31U9GCh/LyJOxjhIFvP3UQ1AKZRRGXLVF6c2PihJlL4osZZUHC
         lJYA==
X-Gm-Message-State: AOAM53221qpf78jrs0NUampeuy8ABmDL554EteFdBSxmgtzSL72WBoyI
        2s9lqQDCJ5uIGknQQa8s5gz1zw==
X-Google-Smtp-Source: ABdhPJxH9kfbhIihzHvuiewQLiLNOB0k6p0Ye+4DjteIb8gr6m+sMIOCgzhj3sZMaB4KXtbfJ5506Q==
X-Received: by 2002:aa7:9606:0:b029:198:14c4:4f44 with SMTP id q6-20020aa796060000b029019814c44f44mr18740912pfg.80.1606749673191;
        Mon, 30 Nov 2020 07:21:13 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:12 -0800 (PST)
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
Subject: [PATCH v7 11/15] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Mon, 30 Nov 2020 23:18:34 +0800
Message-Id: <20201130151838.11208-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail vmemmap page frame and remap it
with read-only, we cannot set the PageHWPosion on a tail page.
So we can use the head[4].mapping to record the real error page
index and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 11 +++--------
 mm/hugetlb_vmemmap.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ebe35532d432..12cb46b8e901 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1382,6 +1382,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	subpage_hwpoison_deliver(page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1849,14 +1850,8 @@ int dissolve_free_huge_page(struct page *page)
 		int nid = page_to_nid(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
+
+		set_subpage_hwpoison(head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 7887095488f4..4bb35d87ae10 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -15,6 +15,29 @@ void __init hugetlb_vmemmap_init(struct hstate *h);
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
+static inline void subpage_hwpoison_deliver(struct page *head)
+{
+	struct page *page = head;
+
+	if (PageHWPoison(head))
+		page = head + page_private(head + 4);
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
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	if (PageHWPoison(head))
+		set_page_private(head + 4, page - head);
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -32,6 +55,22 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void subpage_hwpoison_deliver(struct page *head)
+{
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (PageHWPoison(head) && page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
-- 
2.11.0

