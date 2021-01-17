Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54652F9366
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 16:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbhAQPQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 10:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbhAQPPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:15:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA8C0613ED
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so2935283plg.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAzAJAw7JBXGA5wVumCYbe7IIg4huGuKzHI34tpedh0=;
        b=KTUr9bgvGRfZY7zXyuwqqHtpRf08YVqRbt+LDLJU7qpqnjsV8fzOF/1SuTd2UmsSpW
         mGlYwlOtzOcINqgu4C5bZ1e93d+XOozvOTgYxbuejQG+mvigc4Z7OXdbWEjfXbhW45pr
         grL/MeFRczzi5E2HbJ3K9zLMQ5nKra2Ed6nKyQX1Zr3nWiHUBSaF8W3GnWun90ZMqdmG
         TMSIxi2AQWQ9Ni3I2zfoUC0zvJqa99AyQvzd+bUHhdEANd1Ky8yDKSwzXKSRRkeGTYSs
         N5J5MtL78j0A4Pa+APQ/OvmwiQmzGXnIcPi9FQ5wVzLLcuRUU5DHBiBSOlUT9EyWNCX1
         Nuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAzAJAw7JBXGA5wVumCYbe7IIg4huGuKzHI34tpedh0=;
        b=SDITcnRRqk7ftAIUoNMQq57T3TCWC02b9WmMHLPQPH6n+7YpgbUOaMEMPZR2rT1EPR
         lj9s0h2CwTcLmdNDJEEnI5+Ut1V4IVl9jNpWXrVAOi7sh7ON0CrkFDZxqfgpljAizr4a
         mijeqgNPTiLSgFyTzTdgdAYgX/mzkn+CuVP3EHt1qYDEmPfNq3XtUpTicumxTLmEvQGh
         hg6da+kxGFZA4wIcuRDp4jDeuyQKHhDKJBT1V4HLj4MrSF4Hami5NTEWR1VaBuaOVoPX
         LnLoBUn/vqDVOtGdIQ1BduWOtNnB53lP59F7E61769Jki90PMVkRwvZ/dwM4FDmUAK6/
         BKvA==
X-Gm-Message-State: AOAM532QaFfl5MiGlSiKtevNgDYriyJ2PcxKj/Fp6bEzIVMSxHbUyKBu
        mL/DLlNHZj+zRGP3ReQvb0cvOA==
X-Google-Smtp-Source: ABdhPJyZnm1OiBW8g2a5JU4rQ20aHbQusIDFhvpTdfXrG3sJdzrVFR5b4ifkqeOM6cYqFgDldVrTeA==
X-Received: by 2002:a17:90a:e006:: with SMTP id u6mr20691095pjy.201.1610896481318;
        Sun, 17 Jan 2021 07:14:41 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.14.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:14:40 -0800 (PST)
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
Subject: [PATCH v13 06/12] mm: hugetlb: set the PageHWPoison to the raw error page
Date:   Sun, 17 Jan 2021 23:10:47 +0800
Message-Id: <20210117151053.24600-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d11c32fcdb38..6caaa7e5dd2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1358,6 +1358,63 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
 		schedule_work(&hpage_update_work);
 }
 
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
+#endif
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1373,6 +1430,8 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 {
 	int i;
 
+	hwpoison_subpage_deliver(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
@@ -1845,14 +1904,8 @@ int dissolve_free_huge_page(struct page *page)
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

