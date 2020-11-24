Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6D2C2261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbgKXJ7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731363AbgKXJ7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:59:08 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91296C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so16977117pgg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvROAgOOAQ4kY4iKE3ESPFWS7AbcyyeQezHTq1QFTAg=;
        b=fuMUt74xPel262JKZcWj7UdAWTy2xxyYGTNPRBO2ViJpSb3cOepUJiAuAL5eAr2ooz
         j2AHvTaxLpMpe17XuGaalenP6FFJcPzfpy9YqA23Bq2eUtD1M3G8z51lfjCSJya72zRY
         Cqsck+YkGPmh1FnH25pcEzUHMUjFjiVc3fm2OCsWimzfMVj9RcOe98i0MZLz6Kmym7e4
         /K5gvmzeNjSQjb5v/FXLbtcDiHPYmOJUPWJlz1ldS8ljQO9iC0uEm2rIxpMCB8mcFTC1
         7kQOBSiW05idLnK6y4kUUNxTqg1SlWoQCaGLWLXOnm4r0vJ38ZT0iZv8dgHT3KKv09NC
         vzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvROAgOOAQ4kY4iKE3ESPFWS7AbcyyeQezHTq1QFTAg=;
        b=oSU9Y4jPsr6Wy8vD8y1ositw/21kaffUUGNS5abuH4t2qyCaX/fwrnTPnZYA4itsuh
         iZPS7iPXB8H8P1BWybqcxGQ7MRHjmsQiI24c87QS29KSh1C30QpoofD9jSpRg+SuUt6g
         NA7XJbmaYDEP5y71Hcvn2mFGvX9Lte4PA+tNIO7nteK+Mas5Ww09eDsGHbVGQjOWkUrD
         RSfFHaHU5a7BiqaP5U4URtvK/M5xbkg8k4I3Sf/QbyADS4RJKa4NXPE/zNAlMV7poaJ0
         WCky4zJembV2PgtHYHXewJBRO281zUs/cn/3Q7ByyrcAVDvRTaSX3S3Qi3tOuZzQKnVy
         bFPA==
X-Gm-Message-State: AOAM532TY61Mmqh9lDZj0RnrHKlTKiBWck2CPLJgOIISKpnrVVN3sFNd
        kKeJ3sgZY5mIrzhSD7SQxHyUZA==
X-Google-Smtp-Source: ABdhPJxlanZ/RJAQaev8flwUs/w/EGF8DKrJNUyiGS3fentCZnvyeLaxGW2GOzpgkK7Q4Y0SmdGDQg==
X-Received: by 2002:a17:90a:c214:: with SMTP id e20mr4154217pjt.212.1606211948164;
        Tue, 24 Nov 2020 01:59:08 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:59:07 -0800 (PST)
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
Subject: [PATCH v6 14/16] mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
Date:   Tue, 24 Nov 2020 17:52:57 +0800
Message-Id: <20201124095259.58755-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c                            | 19 ++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5debfe238027..d28c3acde965 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1551,6 +1551,15 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page.
+			Format: { on | off (default) }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..6a8b57f6d3b7 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	unused vmemmap pages associated each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 509ca451e232..b2222f8d1245 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -131,6 +131,22 @@ typedef void (*vmemmap_pte_remap_func_t)(struct page *reuse, pte_t *ptep,
 					 unsigned long start, unsigned long end,
 					 void *priv);
 
+static bool hugetlb_free_vmemmap_enabled __initdata;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (!strcmp(buf, "on"))
+		hugetlb_free_vmemmap_enabled = true;
+	else if (strcmp(buf, "off"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
+
 static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
@@ -322,7 +338,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
-	if (!is_power_of_2(sizeof(struct page))) {
+	if (!is_power_of_2(sizeof(struct page)) ||
+	    !hugetlb_free_vmemmap_enabled) {
 		pr_info("disable freeing vmemmap pages for %s\n", h->name);
 		return;
 	}
-- 
2.11.0

