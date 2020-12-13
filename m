Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9A2D8E57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437244AbgLMPsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437199AbgLMPr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:47:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C4C0611CA
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:23 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n1so8053882pge.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Hn/VAt0Cz4OvxZ3ZLZ7kdSFuid7Egkgjo1KIVr5tXk=;
        b=MGyj+v/fpgjFg796Ql1cWg7MCfhrF/gzP0PnhpQ3xcGoeVoGgctAJ9l/XQfptmEpGD
         iO8X8MxsERuR+Vqfs27ZZJ0SBOJyRxxccqWe0y7do5j8ujw1ZQEJhAfnvFk8tr+ddTHV
         YAHIbwcOwd0TOsa44UYqevn+bg767PoXrK5OZ6ZbwTxGKUURcxng/vS5CSM5euoBdC7N
         2I8rkCrcVI7kYF5JtHO3B0JU1e4X5iXm57m3pwEQXMjxUT4m7/LENZinOPIN1WNotLeS
         vjtEH6PEAQqRqCLBuU6wkMB9Xn66DFWDPce/4k74rDgyaxKl4ELcar4mpuF8jRRoYNhq
         jhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Hn/VAt0Cz4OvxZ3ZLZ7kdSFuid7Egkgjo1KIVr5tXk=;
        b=jdyiCYS6DyAADFCnWcUKpaUYCdWO/r+hR2+SLQ4TC9OCgMU6+YQ2yY0YctENXDWECz
         S830VDPWJqXvBbVox6q96cy4OdYmkiHU7glNLD7P85Nw7VIF2uUrg/ChFKz85WvaHA5V
         am94ckdIxBYy22lyhd4jDauSQht3h/NiPi/HNoG0M3cJDKCwn19fdiUFiNecCsCEAfWP
         Uu4K3okrqNPXlcJYy9qynmU1YLMLo8MFBfLGyJI77AaKJ+HCSp2XeFFMebx6HBkz2PN8
         XzsWURAeJap3mxTjbqatBGYPoIlBPp9/pyCDDsrgHHTUnHZceHPlv6MTTScvsP0eBVy1
         ktmg==
X-Gm-Message-State: AOAM533CpvsdmI1ltOJU+FxcyfbQE4FkAcQGAqdiPe49fFsspsUzN1qD
        USws9OooM8klBN0DN7ARQDUYbA==
X-Google-Smtp-Source: ABdhPJzm8g+/dhJF7aOm/BWobYUOtXsvZXX19jmBO3Px6nr+cLrLxt9DJkTUH0p/rLUE4u9kv7VXEQ==
X-Received: by 2002:a63:215c:: with SMTP id s28mr20432259pgm.117.1607874442722;
        Sun, 13 Dec 2020 07:47:22 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:22 -0800 (PST)
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
Subject: [PATCH v9 06/11] mm/hugetlb: Set the PageHWPoison to the raw error page
Date:   Sun, 13 Dec 2020 23:45:29 +0800
Message-Id: <20201213154534.54826-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
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
---
 mm/hugetlb.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 542e6cb81321..29de425f879a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1347,6 +1347,43 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
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
@@ -1363,6 +1400,7 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 	int i;
 
 	alloc_huge_page_vmemmap(h, page);
+	hwpoison_subpage_deliver(h, page);
 
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1840,14 +1878,8 @@ int dissolve_free_huge_page(struct page *page)
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

