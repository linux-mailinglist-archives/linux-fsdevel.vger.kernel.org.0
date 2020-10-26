Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FC729903A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782711AbgJZOzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:45 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37916 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782706AbgJZOzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id gi3so3223567pjb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyW32MZ8OSoinxuXp8kqgHUjIwxNZICw8FuoRY/UD9c=;
        b=ieYl9GrTxm18tKLd3e2GEkSyzB4fgJBpLTwzGnog8ojgx+bj/xGHpgf7e43ffusvjh
         QuDW0AT5ukd+yNgI4Q13wVET7huAibAY/PXl7lJpT9r9FC++G1sh+tWQLFrD31kk1Ia4
         TkpI6GvCoMdCpKLLMb5l1crJrCbhHcX8kjWD3Em5jxJXVRUO1PvW8MQiNqADdRPPzZx1
         UbofYIoYpINsiRUNxM+g9Q8qAkDf68EGkIVssPlhhil9lQXjEMARYEHRrmAOBgv90Skz
         M2WmiXIS+1b2I+AOVkUWzrKloLm8yykJjjRjr9chMd1nQRHV9z48E3R7U9Zaqk3oMKYp
         rhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyW32MZ8OSoinxuXp8kqgHUjIwxNZICw8FuoRY/UD9c=;
        b=mbQocdn/dY22AbCjHBNtBuf7sbz9OpOCrkEk0S5d/cttKh0tSO/kHS+NeMyBPwgzfY
         ZsYJ0OaQb6GvKHZ4nYdVhP/0KsiU/Q3CpPAP7DEgvlkQEkeOil04W1Ygcrna0XTENKKp
         Jh1SyYCC8g1E9ZGc/0sBC7ILVly4L5cKR4UGsTfwEZ7o9tEF5pnNgLFHxFq1ts1f8fYl
         hxQK0nkzNGf2gn1+cWCdv9Q8G2vn7VDxHWQXIB7Wr9D4nSt42tSEiJgz7eV6gyM4CaLf
         tL/PcVrCosLvwBProUaE2O4JVI9WItKJeRukSuqwGXX9GClANP2ZBixQAE1a6a+k2p8r
         gFDw==
X-Gm-Message-State: AOAM530BmYL0XsvjG3U05iuVtcKR1+eWDCXTtSNTwRTZ/B4JYSrLR/pW
        /YGfNSWysc+bRYNy8C6agEeXPg==
X-Google-Smtp-Source: ABdhPJxXsam/XlOPzz/Gp1YN2pMJT1VPNjBUP5H+XZsosKWY9Qb7CNr3fa9M+5hmN9nFhz9dzpvY+A==
X-Received: by 2002:a17:902:c383:b029:d3:d17a:1de with SMTP id g3-20020a170902c383b02900d3d17a01demr8417074plg.84.1603724144004;
        Mon, 26 Oct 2020 07:55:44 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 16/19] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Mon, 26 Oct 2020 22:51:11 +0800
Message-Id: <20201026145114.59424-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst  |  3 +++
 mm/hugetlb.c                                  | 23 +++++++++++++++++++
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
index 509de0732d9f..82467d573fee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1310,6 +1310,8 @@ static void __free_hugepage(struct hstate *h, struct page *page);
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
 })
 
+static bool hugetlb_free_vmemmap_disabled __initdata;
+
 static inline unsigned int nr_free_vmemmap(struct hstate *h)
 {
 	return h->nr_free_vmemmap_pages;
@@ -1457,6 +1459,13 @@ static void __init hugetlb_vmemmap_init(struct hstate *h)
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
@@ -1826,6 +1835,20 @@ static inline void clear_subpage_hwpoison(struct page *head)
 {
 	set_page_private(head + 4, 0);
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
2.20.1

