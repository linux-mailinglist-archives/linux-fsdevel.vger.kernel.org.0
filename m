Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160A22BA29F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKTGs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKTGs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:54 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so6411059pga.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eD78AzWQVV1uAAuXAFqLOGFAQosJqi4Yg9b3koUXsus=;
        b=lcwWZUVWnsQa5LT0KgaEjI0iwQ9Zy5KTdkDwdkaYkIYrx0sageBcgcvZ02a8P7IinQ
         cH5lrqUx09ERWxttsalm94SKQsQY0j6YCySKE/qz+9qixGVDly1/Cm5JbHmwcIDBD7WL
         qtkr0vBPhTrsvRVOh3aJI+DhhOqf+WOwZwne/kV3PDRrWDacby9e6XbuOJjfECG0xIhY
         rMH/tVXPlloLTOHZI44HQN35LHMa+2J6nR1JL8jBr+E/4YTbzBFNHhM59vHTB+3J+PB2
         l6ZJRCDsJJ0nRZmFn+SzJpi7oN3oQhm7q0KA10Asz0SBMEKJBD6xgv+9zezxopyUkfdG
         mYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eD78AzWQVV1uAAuXAFqLOGFAQosJqi4Yg9b3koUXsus=;
        b=CvS9+MHiHniUMaZJQ4FT0qPMtDKZy6jvLEweQXNk8A2SoaZJV+poyY6psmXTNrgJpy
         XeZEdh49kIFn2dvoKexfK1ftYi09q9yYUCpqgFXkfEwDLAPAkpH9kFj4Nq0SbR/YahJS
         dbYl5/L4dfRnxm3RuvFSaWGI2g7Q9cf4dWLAERxLlRbvLPq4st+xo9VdnyqWjaPv0xxL
         HjMAzWaeqRABN+gG476i0qtb8d9WknzxHUp2OIjq0eMXGRLK4CBnl+opKfF7U1qvtEJE
         EGjikdnWnUBwXReRSNn/Z+TM99z/kxomzjzFBDbewUIX7gD8yQzL87ocxVB2kgGHj2Q7
         umpw==
X-Gm-Message-State: AOAM533GNQXeCVIf+UZbXFpz2X5Tx0Hf9lg8TLEm+MwW5C9ZOex2wnuv
        P/AUU3ecoTZKN/gAf9kTn5XHfA==
X-Google-Smtp-Source: ABdhPJzVi5Mi23xJ7xuPD8J+lf/CK5R/RCg+2yoXfUf7ZH72VA+vSBnxOfiz+7uMBS0fZyuYnbVoyA==
X-Received: by 2002:a63:5826:: with SMTP id m38mr15569054pgb.240.1605854934100;
        Thu, 19 Nov 2020 22:48:54 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:53 -0800 (PST)
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
Subject: [PATCH v5 17/21] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Fri, 20 Nov 2020 14:43:21 +0800
Message-Id: <20201120064325.34492-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c                            | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)

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
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3629165d8158..c958699d1393 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -144,6 +144,22 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 }
 #endif
 
+static bool hugetlb_free_vmemmap_disabled __initdata;
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
+
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
@@ -541,6 +557,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	if (hugetlb_free_vmemmap_disabled) {
+		pr_info("disable free vmemmap pages for %s\n", h->name);
+		return;
+	}
+
 	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page are not to be freed to buddy
-- 
2.11.0

