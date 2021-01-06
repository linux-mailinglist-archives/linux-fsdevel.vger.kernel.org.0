Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF52EBF7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 15:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAFOWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 09:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbhAFOWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:22:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50024C061358
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 06:21:43 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v19so2295094pgj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=leMCwiJUMOALRI5sultiZwFK5v4LdPgwOBvUXqzpH+M=;
        b=fKAiFaUcBNxGGPgUTJj2FRif/SfXZMu2KuZLQ1tkC9hf115yidMi1n/53fvmREUala
         rEV5qBf4q9uqF/44G7mT0920lUzF3ZX4LRTOoQmTDDwdWXM9wOK78Fvwk13NnoGOJSGM
         B4aqOPGXxG3JUpEMKeS/52q4ZTqeOb0HgNfRWL6O5KrobfJgIE2hvENlgWg1E/8GaZzm
         k65GUHnL678L4cm495jhyXqszI4j9dKuDx7m7KM37WKRoHzxOfQMD/JFvcwdG8yuQqXM
         Born6DGk9Vr2WyPoEVF36LaYbYSjXapAwpH7gFnb0HW2SAGh4WlkWF8f+lhC2tP1q83c
         /MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leMCwiJUMOALRI5sultiZwFK5v4LdPgwOBvUXqzpH+M=;
        b=OKN3c5HWs6yJuXHFL6ppXBkubWOOmpsbUZlMcThpfJErllu7RGi1wiWjH+bkdLWoh0
         8pTavyxHBWKxYSeeTuuB+IoZgh5qZ6OpPV0Eq/+l69P8dYYlVqnXUPRlOzPmsbPZ6r1K
         vLWZnifkzG1Yhehfks4vVI0DO+6V4TlQzA+F6vZUgtO7sDZjEKaUVXZwGNlnWPZBDkTn
         m2z5MrZhTJVBA54ygxSF6a+WWKNURdX8bb4Qdqsm4Fkv9BBKL5HQAZ9tgJsNEg55PvtH
         11S8eZxtE8ERvsF9zaSMqOZxYOAkjVTIJP9NNC7ncG98tHeP7acfBiHAEOhs89f9KQ4c
         zSYA==
X-Gm-Message-State: AOAM531U7yGQFQBdHxLs4YJwm3UDbUnhLUP/gacPXuiGqGeLVD0feKfd
        MxIluifdbJ+ugqMrNrBMDhPy4w==
X-Google-Smtp-Source: ABdhPJylqpTH8n8thsMjFkTxsLxbMjGuXzOSLFrlQ6MOpttJhlgIj8J5mZrax0MPQhVSXhI3hM/lyQ==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr4756956pgm.135.1609942902922;
        Wed, 06 Jan 2021 06:21:42 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.21.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:21:42 -0800 (PST)
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
Subject: [PATCH v12 09/13] mm/hugetlb: Introduce PageHugeInflight
Date:   Wed,  6 Jan 2021 22:19:27 +0800
Message-Id: <20210106141931.73931-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we free a HugeTLB page whose vmemmap pages can be optimized,
it is freed to the buddy allocator through a kworker. And the ref
count of page is zero, so if we dissolve it before it is freed to
the buddy allocator. It can be freed again. In order to avoid
this, we introduce PageHugeInflight to indicate that the HugeTLB
page is already freed from hugepage pool but not freed to buddy
allocator yet. When we hit the inflight page, we just need to flush
the work.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3222bad8b112..14549204ddcb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1343,6 +1343,36 @@ static inline void flush_hpage_update_work(struct hstate *h)
 		flush_work(&hpage_update_work);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+static inline bool PageHugeInflight(struct page *head)
+{
+	return page_private(head + 5) == -1UL;
+}
+
+static inline void SetPageHugeInflight(struct page *head)
+{
+	set_page_private(head + 5, -1UL);
+}
+
+static inline void ClearPageHugeInflight(struct page *head)
+{
+	set_page_private(head + 5, 0);
+}
+#else
+static inline bool PageHugeInflight(struct page *head)
+{
+	return false;
+}
+
+static inline void SetPageHugeInflight(struct page *head)
+{
+}
+
+static inline void ClearPageHugeInflight(struct page *head)
+{
+}
+#endif
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	/* No need to allocate vmemmap pages */
@@ -1351,6 +1381,8 @@ static inline void __update_and_free_page(struct hstate *h, struct page *page)
 		return;
 	}
 
+	SetPageHugeInflight(page);
+
 	/*
 	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap
 	 * pages.
@@ -1637,6 +1669,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
 	free_huge_page_vmemmap(h, page);
 
+	ClearPageHugeInflight(page);
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
@@ -1913,13 +1946,16 @@ int dissolve_free_huge_page(struct page *page)
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
+		rc = 0;
 		hwpoison_subpage_set(h, head, page);
+		if (PageHugeInflight(head))
+			goto out;
+
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
 		update_and_free_page(h, head);
-		rc = 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
-- 
2.11.0

