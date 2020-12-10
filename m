Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D82D526B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbgLJD7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 22:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbgLJD7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:59:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378FC0611CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:58:37 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so2112184plo.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJ9Kpw9euvaWeMiz77W9dHgAhVUDo0j7sOjcwheIHew=;
        b=ghgjyxrsJ7T3/jqCtD+ypiLM9BEH2CLt5gtZONrJJTsdwKdYqavXofY8lXr9g8uc/t
         qUGReab7rPAaXR7HMv2iBiOxHdhbPlaIW5NIKQtub81/vpTu+Q4gPxTqai/7eH/fTMAY
         KVYDT3L0tGkj3Syi40CkpQoBAA+mVTuFSoenjCx6NiZeb2Lln2ajAkF6smCI0wTuGCgH
         iAaMLnc+T+In0bYzzZKbG4IzF3BC63yD8soDcWKY/VWCSRbwQ+lIJJnQ0pu6DxvcSv8f
         5PcwsBg79Tc0gRGGgTMOTRnzu96UK/sRIAvV2WvrX9gkti1p24TUHyY4t3AGud40NeYU
         SmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJ9Kpw9euvaWeMiz77W9dHgAhVUDo0j7sOjcwheIHew=;
        b=EsrDLU8R5zM6HbpszPHWGV9i74m+HVD4QJV0kHKbkyMCFkgAi0AoPK96egKOVsr9Ef
         /ibCq49yT+b6sKCYhfh0QyH0Ka2ZI/TbaPITP/8oT0a06a5GHIHI9LOKWS+Qrjjo6El1
         M030NCFXcJ+ll9mvIQYSQ8/dlJMGd37a7vqhY3ISImDL9ef4rkIpZ60wpMzT1owzpcpJ
         eeKTuKDuU7FK4cMVyuYe0PctR3WQ89kdpx5Z6JvGfHloKzYTMiooM7Rebmi8X+om6DxJ
         Ohff5v/yDCcRqgnm6YYjNGnRtlhAfFJWK66ZfdWRukSifDmptJ/nI0UhYcg2tTnL5dpT
         5hoQ==
X-Gm-Message-State: AOAM533Lp3GIhu5vEqMJMpGFPtrjxSj+cXD+o57XSTqXR/FPTelHBNxf
        fE5qKeGYRzYhM1DTcOKSd8zVgg==
X-Google-Smtp-Source: ABdhPJzw5hLUvQdTuLt9Uua9WZQksiCrIptpkpMT26lr/lIhMe4UXVimr/dNHo2MdPSc2Jv07kMXcQ==
X-Received: by 2002:a17:902:b08a:b029:d9:eca:7d38 with SMTP id p10-20020a170902b08ab02900d90eca7d38mr4807254plr.72.1607572717228;
        Wed, 09 Dec 2020 19:58:37 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.58.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:58:36 -0800 (PST)
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
Subject: [PATCH v8 07/12] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Thu, 10 Dec 2020 11:55:21 +0800
Message-Id: <20201210035526.38938-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 542e6cb81321..06157df08d8e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1347,6 +1347,47 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
 		schedule_work(&hpage_update_work);
 }
 
+static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
+{
+	struct page *page = head;
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
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
+static inline void set_subpage_hwpoison(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (!PageHWPoison(head))
+		return;
+
+	if (free_vmemmap_pages_per_hpage(h)) {
+		set_page_private(head + 4, page - head);
+		return;
+	}
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
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1363,6 +1404,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	subpage_hwpoison_deliver(h, page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1840,14 +1882,8 @@ int dissolve_free_huge_page(struct page *page)
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
+		set_subpage_hwpoison(h, head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-- 
2.11.0

