Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416026B84A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIPAlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIOND1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007AFC061220
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so1970873pgd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOJhqJtv+UWYoFjqXwWvBe8sB0f2lCBZ6nqED2fuMHQ=;
        b=EOQN2yWHyRuPAk9Gq+vMMRCScrOmbSFwQ3n+S9wZYYojswi6k8MztS4cheCz/qacPa
         JQH4e+xWH0J27Q2IH3NK20OWrmxC6SH8QTl8gW2KyP1R6iauFKSbXnW6RCyse/SaZqzu
         H5/jC1r63VISpnzqCqjZbh1KoHJ8PUp5VnvAh87TKRUVm6FgYuM/2IBTVSCqs/moqLOl
         vDTfbMz93M8Af8EBdTZK3i8xzTOrHp7cqmo+zrubXB95j0mPnK2Jy/6skjemTyoOrdlc
         VOcBpmuITOubgjyoOWCxAvFXusRUf0Wsf7a9t97nrU1k/gEkmQpssTuulsmZPnh6+CTw
         /bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOJhqJtv+UWYoFjqXwWvBe8sB0f2lCBZ6nqED2fuMHQ=;
        b=JngX/+5JN8HG8hQqq33P8P7EyGef3bNWNQTwB424UP6Zd6b7SMxiqAIb54YlIfaTUf
         NaPM9kX5V2d436BQojoY78HS9EJBpBFhdYbni8u1ZOQ0c3T17bzpagz+Cqy8rOfv9U28
         R1F5x6sfjfbJ/0BwaQs4Bdxacgljnc3OC4FhmPvwQiUYskc3oVozvJQjKfPTxH7gYObO
         UnlO+JY04wM0b/FIny0HnlPfAD53muKqoUW0Iwh/Cd4ygz3HRUqqHsSOOwd05GCoddRQ
         wQWG9hSi+X7g1d4i/wrKrJM4Tu0uYF6w16OJRZO0JRvpS+i2ykBNyOJbgqBxQZ0QM6Rm
         sfZw==
X-Gm-Message-State: AOAM533cr61AJNSbo7mqYldk/yXFvseUYW03jUlIQ+rgFZsOj87Qw0qw
        SwtnZ5TXRHf1TBPIWhQOExOchg==
X-Google-Smtp-Source: ABdhPJy+syIBhM8kx1V8ywime9iP9xvufd4f0gsLV6gbG6xM7YybTp78AmXxxeqXUOso9/bnBhpTyQ==
X-Received: by 2002:a62:3044:0:b029:142:2501:398b with SMTP id w65-20020a6230440000b02901422501398bmr1767708pfw.80.1600175006499;
        Tue, 15 Sep 2020 06:03:26 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.03.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:03:25 -0700 (PDT)
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
Subject: [RFC PATCH 20/24] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Tue, 15 Sep 2020 20:59:43 +0800
Message-Id: <20200915125947.26204-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 5debfe238027..69d18ef6f66b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1551,6 +1551,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this disables freeing unused vmemmap pages associated
+			each HugeTLB page.
+			Format: { on (default) | off }
+
+			on:  enable the feature
+			off: dosable the feature
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
index 56c0bf2370ed..28c154679838 100644
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
@@ -1867,6 +1876,20 @@ static inline void clear_subpage_hwpoison(struct page *head)
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

