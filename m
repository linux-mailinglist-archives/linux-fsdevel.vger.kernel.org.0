Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68B2D8E5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437277AbgLMPs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437264AbgLMPsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:48:22 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE71C0611CC
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:33 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so7288656plb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/IANVbAC10oR1yCmyJw00iPLDRZ87joisEDYZKBsYc=;
        b=h4QHAnO90pJNatAnqiSd6FwpDzPKz7evZGo6Jv35PHkvf5uGCTCg9scbUDwgPLF/Sq
         LQ9ChkrgO/TUNnGsjydbt2eKVo649UzWcUX4J5ecTj5HW0zAXFA81HyW5TSXoDqUeHYw
         5oL3Ify2l+LN74TEgJ/wn2LU1QDb2/J6cFIlh+H7Fk6vHzeFSprETgweuy4eFr6NaL7X
         3JOcCrDyd8tDLX+VHHoHnPEkJZbnOOcD38bz8ZiElx0carfbJDtEQQNtifMVRTTzlxNc
         NaEXhGSe++0/0e6WkfZTvxCAVErvsTyraCIJB85ne6TMeV3m4UkYRaOomSce4KQcY8hz
         DnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/IANVbAC10oR1yCmyJw00iPLDRZ87joisEDYZKBsYc=;
        b=s80TkW39JHsKMUqW5ZRuKRcUgAfPE7+RF8J1LAxaTkuGwxIWi933FevJupQYg35WRo
         Bl/QS7DJuo7DQJwqZpfbGz6aUj89i9axXIvLq6Q1L0DqSWF1QjlDbg5UnI1ziaGHe+83
         TmOXTcsJ0YmgJleol/zJ4SwrtgZr3MTMOhsl1DbQZgV8/Il+mVYD2p4g6rhFuMpcwVXs
         dZ9+q4sK7iQmgqOxYfI3yDX06Q2VFKe8x7RoZTv9nNny9u1bT3m6PoJB9BhNjXYRv/KL
         uxD4BIc36CNpE0MVwn30TPqonY6Z35+iu+IhpFaqollvXyK+ibtNj9fgeLkY+CZVq1lc
         /ukA==
X-Gm-Message-State: AOAM531KPuGzegt5kRrRq5gIh/OI1diezeDB82O6jlwfYllYpzsmGQ0J
        F4Xw0sJJ/BI+OfUHq97W29H7kA==
X-Google-Smtp-Source: ABdhPJwNK76xsvc3WyZtf8T7mzZOaqed1/OA/f6WnTwj0FynXSxGhw2aZSeW3K5vwAg3d5eRa/Z7qQ==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr21928466pje.193.1607874453575;
        Sun, 13 Dec 2020 07:47:33 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:33 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 07/11] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Sun, 13 Dec 2020 23:45:30 +0800
Message-Id: <20201213154534.54826-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should flush work when dissolving a hugetlb page to make sure that
the hugetlb page is freed to the buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 29de425f879a..b0847b2ce01d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1326,6 +1326,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
 }
 static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
 
+static inline void flush_hpage_update_work(struct hstate *h)
+{
+	if (free_vmemmap_pages_per_hpage(h))
+		flush_work(&hpage_update_work);
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	/* No need to allocate vmemmap pages */
@@ -1861,6 +1867,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1874,8 +1881,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1889,6 +1897,14 @@ int dissolve_free_huge_page(struct page *page)
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * We should flush work before return to make sure that
+	 * the HugeTLB page is freed to the buddy.
+	 */
+	if (!rc && h)
+		flush_hpage_update_work(h);
+
 	return rc;
 }
 
-- 
2.11.0

