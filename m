Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49D2C225B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgKXJ6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbgKXJ6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:58:48 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7CC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:48 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so4635991pga.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFw3IJ+e2PheHYuR5pwkJRvmAhprgLu2/OHbj9OxvOs=;
        b=R/NFgWFzv5XD8+fMmy9hSPore6Nhp1q1lz+iTh/Z6t/bPrllx4dpov59KYoAon2lNA
         GBpERZR/JZMY3ulmkYQpKDP8DV953PQ3RZzUQxKM4mnyWNwRhDa1wb4snI4zBh2wr5Kb
         oXkrMON3RrVLHJTImt44dHhTRUluYGutuVa+Os1DRIMMBtTcn1CMLLEZ94p2kvJTScoi
         /oK4DbQV2PgqhlLFxSIpN6IZAYBXesDQpPwdvfStSi3uUNLJyrQfB+zmcM3hkx4A7BYj
         ZK6OtqPE/foVctZ5CI9SefAoHhTozBrksQuotfIRLF6NPlQ4HBdzxuvEFbwwoy4rwUfi
         M9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFw3IJ+e2PheHYuR5pwkJRvmAhprgLu2/OHbj9OxvOs=;
        b=GjVVh9fDoZ2WZNo8kyYELoodPUBoJ/CmkNyB0Itc1l+lFaYc9DnkQYBvq4V+iWekdU
         lMYp4WvAf56gv5qydPcfRqjWB4YOIsuc2Uq6zmiyilKmF8UyO5mHojxyHpoEgzimfZST
         RYpSGKEMSsDoI6xkbG/umrGmpOVNDySNdk5UmwD/MU7/3plitMiUgjAguCMF7XVBvrP1
         m8sJktpvKtoVpUkLKC5efClT4aW6JDCXN3kEAHedqr5Qdh3MwVssUbcP05YTa8io/pII
         a2mAalxFoCLaerWZHqj2890CqfG+GI9ba4PveNmkqJ5Hg8SW7s6h2ApOyoRnZ76oaXre
         VYVQ==
X-Gm-Message-State: AOAM530XDcw+MpEqpWe5LTyt+hovv8Kl3G/DgvOtkfam3A22NP5UDpuu
        m3+gTxM7mA13nTvzj4vV4nV2QxFjiMlGA/uaIGg=
X-Google-Smtp-Source: ABdhPJzdxw87RN1KSfcNqb2JmA6MNZy/cqHyN2dAAW7ioN9KAQtWf+p2mboNDrApUqfrr5RM9+njBA==
X-Received: by 2002:a62:78d3:0:b029:198:ad8:7d05 with SMTP id t202-20020a6278d30000b02901980ad87d05mr3424298pfc.18.1606211928001;
        Tue, 24 Nov 2020 01:58:48 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.58.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:58:47 -0800 (PST)
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
Subject: [PATCH v6 12/16] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Tue, 24 Nov 2020 17:52:55 +0800
Message-Id: <20201124095259.58755-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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
index 3fafa39fcac6..ade20954eb81 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1383,6 +1383,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	subpage_hwpoison_deliver(page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1930,14 +1931,8 @@ int dissolve_free_huge_page(struct page *page)
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

