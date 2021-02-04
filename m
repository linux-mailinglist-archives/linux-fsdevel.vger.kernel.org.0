Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181DC30EB45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 04:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBDD4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 22:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhBDDz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:55:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BAC06178C
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 19:55:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q131so1240596pfq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 19:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l17vIavXl4eAyQHBiVfkTE5Mu/d7cEQgNvp7av0Rs5s=;
        b=QfTg/kcxn8zc9OT3hm68BejvweeEcZUQdUCoRloqh4jLhAG+8YkNlAr7xNxtUeAvlc
         jie7NoQPid/uppmQg7301VAzpJYB7mYVv9ETFuQqdV8A/RXZtJI2BeSFtRoIqj/RRcma
         OowC50mrXcu4Z8xV8SjbsbYD6IgMjohs4YC0NF++Zn8aWG7zrpa1BTWANbWVn6/ErGRd
         CgbMmPDY0zsiWKnooSWbTxv2wDDeHHJu0giiZEiDuiI4HqK1aWEMsYZieshFTf3UVBlA
         uB16NLcu2BFDeirLKfA/aEwDgcls3sxJqBMonnSTGG3+MSF2yhZExjmDinL60+XffBSv
         Hx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l17vIavXl4eAyQHBiVfkTE5Mu/d7cEQgNvp7av0Rs5s=;
        b=Gw3mxnzqFAd3ZbxHJgboq9cVWxl6I98kW8yBdFVV5K/zJZEx//E4v0+JiHbfhQjkhh
         pkfbLujcI1/m1mGm1b8oBAlFmJMeC3P14d2GWBiHj+PPQz4HKWjlZL4BDa32E283yzBR
         khTDx75Kg/z08eN1iR1FbPFNU7AXmNKE5pq+s4Gpmb5RKq/IEH03jj5HLCkaoUr2rhhU
         QMoWpF7wjKVRmRkpJaOMtk/AzmFR1PzgkhwVesthNT6ZsrgLPcr5MumAa8409jXf4QQS
         cuobr4Cac/Fse4MZOgRxV3+GiN1LoGga2l+7F0Ga6povIKoIaTjZGev8vFBh+N8O3EUp
         jcEg==
X-Gm-Message-State: AOAM533uTFd8ET0rX2C0oScCrpzkF8T+h1h/G/eqAtLG5fQk6hHGcIaI
        0fizju75ObxbRuC4uGGu7yEq6g==
X-Google-Smtp-Source: ABdhPJxgZwmMzwselQz/frR/NaL/uhGXH8xTPhseIv/LWJ9v8ZypG60i4NV1vUg6Jk5wo7EQxOvSzQ==
X-Received: by 2002:a63:fc54:: with SMTP id r20mr6797608pgk.167.1612410919149;
        Wed, 03 Feb 2021 19:55:19 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 9sm3747466pfy.110.2021.02.03.19.55.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:55:18 -0800 (PST)
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
Subject: [PATCH v14 7/8] mm: hugetlb: gather discrete indexes of tail page
Date:   Thu,  4 Feb 2021 11:50:42 +0800
Message-Id: <20210204035043.36609-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210204035043.36609-1-songmuchun@bytedance.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For HugeTLB page, there are more metadata to save in the struct page.
But the head struct page cannot meet our needs, so we have to abuse
other tail struct page to store the metadata. In order to avoid
conflicts caused by subsequent use of more tail struct pages, we can
gather these discrete indexes of tail struct page. In this case, it
will be easier to add a new tail page index later.

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h        | 20 ++++++++++++++++++--
 include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
 mm/hugetlb_vmemmap.c           |  8 ++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 775aea53669a..822ab2f5542a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,22 @@ typedef struct { unsigned long pd; } hugepd_t;
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
+/*
+ * For HugeTLB page, there are more metadata to save in the struct page. But
+ * the head struct page cannot meet our needs, so we have to abuse other tail
+ * struct page to store the metadata. In order to avoid conflicts caused by
+ * subsequent use of more tail struct pages, we gather these discrete indexes
+ * of tail struct page here.
+ */
+enum {
+	SUBPAGE_INDEX_SUBPOOL = 1,	/* reuse page->private */
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
+	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
+#endif
+	NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -607,13 +623,13 @@ extern unsigned int default_hstate_idx;
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
-	return (struct hugepage_subpool *)(hpage+1)->private;
+	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage+1, (unsigned long)subpool);
+	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..c0cae6a704f2 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -21,15 +21,16 @@ struct hugetlb_cgroup;
 struct resv_map;
 struct file_region;
 
+#ifdef CONFIG_CGROUP_HUGETLB
 /*
  * Minimum page order trackable by hugetlb cgroup.
  * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[2]) is the fault usage cgroup.
- * The third tail page (hpage[3]) is the reservation usage cgroup.
+ * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
+ * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
+ * is the reservation usage cgroup.
  */
-#define HUGETLB_CGROUP_MIN_ORDER	2
+#define HUGETLB_CGROUP_MIN_ORDER	order_base_2(NR_USED_SUBPAGE)
 
-#ifdef CONFIG_CGROUP_HUGETLB
 enum hugetlb_memory_event {
 	HUGETLB_MAX,
 	HUGETLB_NR_MEMORY_EVENTS,
@@ -66,9 +67,9 @@ __hugetlb_cgroup_from_page(struct page *page, bool rsvd)
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
 	if (rsvd)
-		return (struct hugetlb_cgroup *)page[3].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
 	else
-		return (struct hugetlb_cgroup *)page[2].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
 }
 
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
@@ -90,9 +91,11 @@ static inline int __set_hugetlb_cgroup(struct page *page,
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
 	if (rsvd)
-		page[3].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+				 (unsigned long)h_cg);
 	else
-		page[2].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+				 (unsigned long)h_cg);
 	return 0;
 }
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 36ebd677e606..8efad9978821 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -272,6 +272,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
-- 
2.11.0

