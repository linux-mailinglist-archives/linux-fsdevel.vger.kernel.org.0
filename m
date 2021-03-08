Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A392330B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCHKbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 05:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCHKbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:31:22 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F1FC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 02:31:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q20so6826082pfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/7q5jKbe1h7Dqnn8YQgFTLIuxg0NiRfhwLI2F7iM04=;
        b=2D1Ds2tzTzq9fkHg3X+MAmOL7avtFF8QmPD5PdZb96jlfAYlr8/IujR7UrYRSsdIci
         l9LjwVRPJ9VvTkLg5ftFw3UJhxUC8A/O9ZSVn/G22/4JNMa6JdO4UX78eBjnmj2UVyF3
         lJotzLN7vo//HeYFb3FnhQ3tVIn6lLTmLaHrW7mVc2PLoiVNJQ1wZNMHV2bcD7ao3ByY
         +rx12aJAD5s1yLZLWgj5zFMOMuX2ylhCRXBY6Km8qa/pJBR0kwyjD+Ss2ns3Br9ESB+j
         nkQJFmncnwd2btkDnhDASU41F6Uv7JbBnsjnSwqAHfstvWtpd1s6ZV/TV48D0nLNaLbj
         9PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/7q5jKbe1h7Dqnn8YQgFTLIuxg0NiRfhwLI2F7iM04=;
        b=spsG3Bk3CM+ZgW3BAHzw4sG1t+JE7Lz10egp/igEfXtwOx1SAfsicD+q8QiMODHVCX
         9XF/sLiZCxmIImopEOuIrsVtUPOmpELDrkQwh1PUKo1LJAoDTIQYpCmg/gkpLiG6RP9s
         mAvA8WseeQmboQPesA0IKyI+8W3LhP55WPTzFR3A/MF7PzSuCGp6vofEzYkWKJLHI3LB
         eJQnk/tTHhcijfYE2B0xgGL4Ty3KiDeMLcf/ONFjEv05uD2Johyvjfy18CdOViF7sfwZ
         lVA7ADX1N1e+KchnsPaIa9boO5PXyb/bwO4TG0DGBSXYJrzdWkqe+hUvCHL2vCpkxQ2o
         E9IQ==
X-Gm-Message-State: AOAM530nHMVJgILWsRx/KCItiisFr0OaX5yzUcv3F54sFIo5nQCBh0Ma
        WDxm5e2yuvdsmTDpl1pPKTQJ3g==
X-Google-Smtp-Source: ABdhPJxZeyIEv6Ck0syTAoATaWCVajWwmZMOl8Mfs7LYXnyPhBCO6WxfzZJZdQmq03z8S9g976TLOg==
X-Received: by 2002:aa7:9f52:0:b029:1ee:db83:dac6 with SMTP id h18-20020aa79f520000b02901eedb83dac6mr19909392pfr.45.1615199482118;
        Mon, 08 Mar 2021 02:31:22 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ge16sm10744705pjb.43.2021.03.08.02.31.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:31:21 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v18 5/9] mm: hugetlb: set the PageHWPoison to the raw error page
Date:   Mon,  8 Mar 2021 18:28:03 +0800
Message-Id: <20210308102807.59745-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210308102807.59745-1-songmuchun@bytedance.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
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
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 mm/hugetlb.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 377e0c1b283f..c0c1b7635ca9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1304,6 +1304,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
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
@@ -1357,6 +1425,8 @@ static int update_and_free_page(struct hstate *h, struct page *page)
 		return -ENOMEM;
 	}
 
+	hwpoison_subpage_deliver(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1801,14 +1871,7 @@ int dissolve_free_huge_page(struct page *page)
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
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
@@ -1818,6 +1881,7 @@ int dissolve_free_huge_page(struct page *page)
 			h->surplus_huge_pages--;
 			h->surplus_huge_pages_node[nid]--;
 			h->max_huge_pages++;
+			hwpoison_subpage_clear(h, head);
 		}
 	}
 out:
-- 
2.11.0

