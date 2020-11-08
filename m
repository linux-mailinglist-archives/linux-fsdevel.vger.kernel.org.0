Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076DA2AAB8E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKHOOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgKHOOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:14:48 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38FC0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:14:46 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so5499516pfq.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RheNFP0EuiAgdfcYmY6eB4EIrW1DiMLHzYTKBgLQRZE=;
        b=U33zj+M1CsQ/M+93U8mn/n5QfHFI9wydIavi0QQK4pMsmWfo6FB3v/k6Nu9Nqg5Tlr
         cHMqxF0gyER3bE0IbFtNULVIa1c6+rVTv0yLMguptq6i8hTKIKpnjEa6w+8yaJk6TUnX
         b9N52Vg2z4X1svWBHCqJulMqNaTE8WzlokU//3s0FUVWc0UP6qk+VaY94uvHfonD/Hco
         Gs8g+T8DZwl7m7wEbMteKO/NRzrvFEtZDIIWOF0WvSVWHv4D5fBHmSyvfJHy4TNw0EBT
         PAOXBnimXxMdxP6ZMFCQd4H8SqHsNcPZ1kuqy1xxCfq44pyecpW9QP5rlDWjom02zQKV
         kx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RheNFP0EuiAgdfcYmY6eB4EIrW1DiMLHzYTKBgLQRZE=;
        b=XHjClVWjtW/6s+v0nBmbBy7ylxoBD8DTxvzAcLmV5KsoZkABmEYpN2eQL6y0WlyHll
         G7ANCckF7Uf7cGwqzbAM0b5K/ceh1808zuRp2jAvDZmKn6E0A+IFkD8RApyZ3YzsNwjs
         NEangTrGpOyuuRKQ3KURgCgyU1szbbYKLLgnv/+oraPh/quOMLr/e0S3fJuaIt139LLv
         +vMwfuLnpubEuX1X3zYkMCD5UMPR6WRWpcNmnzbFfzXmdNACcnMIb9lQCRZTGj+vwCBh
         7FAopW3dGV+ZkTRjP6xJ9/kqBTIlTa2BVsDgZBnXGUaipIY6HnquOSQaxH+ZE3HLWfkA
         t52w==
X-Gm-Message-State: AOAM530YXw6nwyYCr6uh/DOLwRMh38HY3WySCdZ48/vcyGWu9XEqFYUe
        sxoA79nNZkIq/KhoRxh4NeMrqA==
X-Google-Smtp-Source: ABdhPJw2QDTjCMQdldj7gBBZ+4MC0gXtMGu5jJeI4aZlSbwWIzM41YxfsEvorb1eXCUPW7hgYYTvcw==
X-Received: by 2002:a63:d24a:: with SMTP id t10mr9661795pgi.344.1604844886440;
        Sun, 08 Nov 2020 06:14:46 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:14:45 -0800 (PST)
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
Subject: [PATCH v3 18/21] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Sun,  8 Nov 2020 22:11:10 +0800
Message-Id: <20201108141113.65450-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 mm/hugetlb.c                                    | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5debfe238027..ccf07293cb63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1551,6 +1551,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page.
+			Format: { on (default) | off }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..7d6129ee97dd 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
+	unused vmemmap pages associated each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4cd2f4a6366a..7c97a1d30fd9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1319,6 +1319,8 @@ static void __free_hugepage(struct hstate *h, struct page *page);
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
 })
 
+static bool hugetlb_free_vmemmap_disabled __initdata;
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -1480,6 +1482,13 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	if (hugetlb_free_vmemmap_disabled) {
+		h->nr_free_vmemmap_pages = 0;
+		pr_info("HugeTLB: disable free vmemmap pages for %s\n",
+			h->name);
+		return;
+	}
+
 	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page not free to buddy system,
@@ -1822,6 +1831,20 @@ static inline void set_subpage_hwpoison(struct page *head, struct page *page)
 	if (PageHWPoison(head))
 		set_page_private(head + 4, page - head);
 }
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (!strcmp(buf, "off"))
+		hugetlb_free_vmemmap_disabled = true;
+	else if (strcmp(buf, "on"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
-- 
2.11.0

