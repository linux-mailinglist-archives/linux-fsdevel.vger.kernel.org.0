Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A42B199A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKMLGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgKMLFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5FC094240
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:46 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so7365149pfu.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzolJXKJFt3Cv9lk0AvV6UgqgHDueM2wckEIHiP70o4=;
        b=vYF40kLSPTori9kiUCaA8h+WJRxn/OJj5FR3U6TfhNVIRJ7HIWbWL5bz2jmSwgCAh7
         QLXUgeaue7x6mna7QPdQSqYCZgX3VfQZE5fOrBaMuupSjUfiVrpq42S5Ww5vJb3jz+0K
         KZraHE4s3VI/MVTe/GbH/NRYf3RnEK6aJPK5zGbtRQ5cIlyFZegnpzJjP3YQ3cQEpZHW
         QFw9ZSI+hH37JpxeFP8Zu9aueUjInncq/8gD8aA/GFxdKXDV91nT9FT9q9R0s167Qb/s
         01bp9m/k992a3+NE/2zqSJ5xkx6SDwejark0dKPO0/KTtafxi3MGqRPOfSOZA8Uusl04
         Em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzolJXKJFt3Cv9lk0AvV6UgqgHDueM2wckEIHiP70o4=;
        b=Z2iGxUOT8fKsb4xqRY30aBd74UxT9svOZqd6dj8LGcg/TCwiLqYZ2cM+5r45jJ9xv3
         GsNKesC67UvhLfFoIkhkc3wfkY9IdFuk9orK064tOaNqvKA+ZxzZvHJLY9uRSV3NBBzZ
         sq04J4CPjO++9kg9edOUHfGGmF9JvyUttVhoHZwt9pi4eKfm8pdyilyc2o/4YLChhW8j
         Z5kJbyAgVeg1I1hMlePZx3LpNrVRv5DLrSZfTFjFkcLC37N4M0JsYj0OkiEXaNTS9G3A
         MIfocIwDw8RiIFCuAsgIES/I4MN7LDENGv2jxyXIJ2cKYRteQyd3Stm6Tz5J14KCpCoh
         1Qiw==
X-Gm-Message-State: AOAM530QfCqJ+hHa1XNfA6Jvzab0Sjej91G0BhvwMBc5My3/PDw+T9Ej
        Zz3uNK8GhEAZEiDu4YIFt2GcZw==
X-Google-Smtp-Source: ABdhPJwSxrC8AebEKZmKNBIl86jC4CYLWk9JpK9nMJhulmTMM7fshqtrmP4/n4vXa34e85lcpIUKTQ==
X-Received: by 2002:a17:90a:a58e:: with SMTP id b14mr2244140pjq.203.1605265425784;
        Fri, 13 Nov 2020 03:03:45 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:45 -0800 (PST)
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
Subject: [PATCH v4 15/21] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Fri, 13 Nov 2020 18:59:46 +0800
Message-Id: <20201113105952.11638-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail page, if we set PageHWPosion on a
tail page. It indicates that we may set PageHWPoison on a series
of pages. So we can use the head[4].mapping to record the real
error page index and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 11 +++--------
 mm/hugetlb_vmemmap.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 055604d07046..b853aacd5c16 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1383,6 +1383,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	subpage_hwpoison_deliver(page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1944,14 +1945,8 @@ int dissolve_free_huge_page(struct page *page)
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
index 79f330bb0714..b09fd658ce20 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,6 +21,29 @@ void __init gather_vmemmap_pgtable_init(struct huge_bootmem_page *m,
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
@@ -57,6 +80,22 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
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

