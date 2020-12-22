Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B085D2E0BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgLVObm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgLVObl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:31:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0507BC0619D7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t8so8566199pfg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oh7BiGimGKbgDDnn+uhtQoJ4SgvK0edAogQf1UAb2c=;
        b=NW1HUXse/ELoaMPuVDyXVFSEXun0IU5JAUCAUQqwl70HtUvXMJ15gRN46nFp02CL/H
         y123iBq8TgKa6MlDbL7fbshMPHrtU9trYby/dfN+k+iid4+hgB1SWFi9IAZLcOSU5+1j
         hlVkou1gyu4cv8Lj+YoFecsr3J34P9vh5YPawOjHUGBMe/dkmG3hv6gxBK7jaoNb4hHs
         C24Gk6/Oq53lnk6iyVLhBzNDwhT6H8OpxAv9KwjhbVuqkTCLpjopNJMS7P1h6gGUW5+A
         7ur1UjBRKLuzuNPQPEk+Zoh65ugww85l/kHrfi+YqdfkJhYD9gTxoaFDyvb5tHwnEQ+G
         XYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oh7BiGimGKbgDDnn+uhtQoJ4SgvK0edAogQf1UAb2c=;
        b=WbvWT5zl2PLxdo9khj6yfGlY5+qA7Xkpiu1B1H0833buaKM3Jrsi88blVR7TFShoI2
         GXwXd7n+dwq8ouftbYHsdVbXjRms6tzzKA/FfAM/LNUVspK/varb5qkXFIRMag8w3jor
         uKa3aG4CmxDC2fQVzK98ZthFiVJkXjDYMrCsNSEQ6NnX42j0jGvN5yKvEm2B5qwt5GYZ
         NIoLmJnMlGbczWCd6Q7BAMf1omG69I51gEeYo0+r752t+p8FLZvorjpN0chZCmJcWBAx
         JLgoiUq5JWUwMQ5SMKEd18JviLlYVHwO1X5GxYohjv8X56mLoXL4bSLX78/NscTWLiVe
         d7MA==
X-Gm-Message-State: AOAM533frIamDgC8Y1DV0dOjftsXif3T/Mazy1xMdQ9bN4OFeMLk9Xqs
        sCxTyVY6Wn7z0fHC/sF7NysV/Q==
X-Google-Smtp-Source: ABdhPJwC1b7+z3oU5UdGT0bIyumq1D1G/6x6HmVq4M+8WybN1mLv+noPxL93zTQbS40CfFx40mjThg==
X-Received: by 2002:a65:6542:: with SMTP id a2mr8854257pgw.148.1608647437583;
        Tue, 22 Dec 2020 06:30:37 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a31sm21182088pgb.93.2020.12.22.06.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 06:30:36 -0800 (PST)
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
Subject: [PATCH v11 06/11] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Tue, 22 Dec 2020 22:24:35 +0800
Message-Id: <20201222142440.28930-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201222142440.28930-1-songmuchun@bytedance.com>
References: <20201222142440.28930-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail vmemmap page frame and remap it
with read-only, we cannot set the PageHWPosion on a tail page.
So we can use the head[4].private to record the real error page
index and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ab6d2eabfea8..dbf4e8eeeff1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1350,6 +1350,43 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
 		schedule_work(&hpage_update_work);
 }
 
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
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1366,6 +1403,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	hwpoison_subpage_deliver(h, page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1843,14 +1881,8 @@ int dissolve_free_huge_page(struct page *page)
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
+		hwpoison_subpage_set(h, head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-- 
2.11.0

