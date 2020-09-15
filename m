Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958E26B855
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIPAlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIONDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C4C061355
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so1744745pjg.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4BTtwaMtESewFNIOUy9zxHCLZirXUfq3fAtH3OWyA0=;
        b=cXXnrjbpWvONeQdtoAVhTZ1yEdWmSsnQjcHBSITYlGXfagXm3/IJgmyXBhneJ6FD7e
         RBdUN/kDepP9jC/FvRXoRJtKV3yp8pN7OHM1DHiC4YycfS5R5tW7UQm46HQw2bzjYntD
         ydYttZbIUk7Y7cp0efMhEeVtwpXC92brqjYiP6AsfeIp0gaHFUffOPUnYz1GAumIXGSt
         BqXqqefdlV3KyEVSMUu6lo2Y6hLkS6u9lNFi0Mok1IDjXxCUQse9upWTGu7yG/jDHyId
         juUbZp+JFrctB+XeE//2fQvtkKjeKle6+2zAKMxjOU6dksJTwyX1FTXYl3FgMtS6eHA+
         T3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4BTtwaMtESewFNIOUy9zxHCLZirXUfq3fAtH3OWyA0=;
        b=W5Yup1OmD4ByPsfBlaIFOeJpixwacdwWnrpJPNg4n3ghbCo0pvlQx9jaXOHcGHiiV8
         SdRokKsv83Inrdx6Dh+8XvIcSf+z24Jr3elWW5Fqkv/oqQnSSok910Y//8TUnSqM+iAU
         Drga6E80njymfn4SVquTC8wPH8DEbOqGUlYzBHvghfIVvK7iKNkL/rvPOT/WoJ0NdB9e
         3yR/0KUkzzKz0+1VN57iRGN4blMX5cdrkUAj5fO9jGW+s3pMxcJaYP2zAq5t0CWnJvvg
         E1CgXM2jEVPNWFvtAeNVgvyrLJ5rs6/BfqHP0GCMonGZJjLdKz40j88ZfEFOmdbXf7py
         cdoQ==
X-Gm-Message-State: AOAM530WmGe32wNmIpO6eOVMDpDFoKkp5sLsomqzHeZwGPo/YPhMI9QD
        YgYbhjf3AACLFlrDwtYLfX+vkQ==
X-Google-Smtp-Source: ABdhPJzutEEVq5G6/7+ccPxCWjUDCELLq9lbv2LK9MvrA+j214YRs9JOfhtSh5/VK8gk1Qc8NYMz+A==
X-Received: by 2002:a17:90b:3c3:: with SMTP id go3mr4345809pjb.64.1600174986059;
        Tue, 15 Sep 2020 06:03:06 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:03:05 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 18/24] mm/hugetlb: Clear PageHWPoison on the non-error memory page
Date:   Tue, 15 Sep 2020 20:59:41 +0800
Message-Id: <20200915125947.26204-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail page, if we set PageHWPosion on a
tail page. It indicates that we may set PageHWPoison on a series
of pages. So we need to clear PageHWPoison on the non-error pages.
We use the head[3].mapping to record the real error page index and
clear non-error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 34706cec21ec..8666cedf9a7b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1847,6 +1847,21 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 {
 	free_gigantic_page(page, huge_page_order(h));
 }
+
+static inline bool subpage_hwpoison(struct page *head, struct page *page)
+{
+	return page_private(head + 4) == page - head;
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+	set_page_private(head + 4, page - head);
+}
+
+static inline void clear_subpage_hwpoison(struct page *head)
+{
+	set_page_private(head + 4, 0);
+}
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
@@ -1894,6 +1909,19 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 	free_gigantic_page(page, huge_page_order(h));
 	spin_lock(&hugetlb_lock);
 }
+
+static inline bool subpage_hwpoison(struct page *head, struct page *page)
+{
+	return true;
+}
+
+static inline void set_subpage_hwpoison(struct page *head, struct page *page)
+{
+}
+
+static inline void clear_subpage_hwpoison(struct page *head)
+{
+}
 #endif
 
 static void update_and_free_page(struct hstate *h, struct page *page)
@@ -1918,6 +1946,9 @@ static void __free_hugepage(struct hstate *h, struct page *page)
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
 				1 << PG_writeback);
+
+		if (PageHWPoison(page + i) && !subpage_hwpoison(page, page + i))
+			ClearPageHWPoison(page + i);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
@@ -2107,6 +2138,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	free_huge_page_vmemmap(h, page);
 	/* Must be called before the initialization of @page->lru */
 	vmemmap_pgtable_free(h, page);
+	clear_subpage_hwpoison(page);
 
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
@@ -2477,6 +2509,7 @@ int dissolve_free_huge_page(struct page *page)
 			SetPageHWPoison(page);
 			ClearPageHWPoison(head);
 		}
+		set_subpage_hwpoison(head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
-- 
2.20.1

