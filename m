Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1B2C87CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgK3PWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgK3PWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:22:24 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ADC0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s63so10256156pgc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqa2olKFahS/Yc5IjkVn5d088b/MkB6a+zSEcNedz7c=;
        b=BBDgLNkHyFBhkMTLjEdHMalxCoZVLu//4GKbKiMQUimsui/VrWAZrUQMmZv80of/iL
         xvaXGTcXO/Oy5kGotXq8HEMVAw/sT4KuoHNWQviA9F06Ok7xyHHIjTXxgvYntH4alcr6
         aIEV5Z2pOfKWpcz5MS4Azwtf9bAREanurLZwT1PVr2rRwYz3K4Dzx9zfRpcHhYjw6S/i
         L3IGm2JenVEKAHRLzzqwqB7X5r6kRudAZ45QnIqyjneR6jyEVk47geevBN2fk8xek9Ny
         l5AQ3fDpvBdk2y8AVqamNHNSsSJypVIEY9nmLlknsD2TWNiP/2sGP8oXvUhBT7FIzZ8v
         H/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqa2olKFahS/Yc5IjkVn5d088b/MkB6a+zSEcNedz7c=;
        b=pyWSzy9aVcvvNoSQz3t11JpozJpYjLWQIr7Iu09eQ9P3+5sCryytxzmRAPetE6NkWM
         o6HdCyNXUi9LSS1zMaWM5+dpHU/PrJkUEph6i05AxN58j2goK5qgT5/2YklqMO6fb7b7
         NqkQTVgg2l5zzadhKHAScYmK8eD+4WT3WCLzCbtqt1uzuy0xiF3sf0ksjwcPr1dNsUTN
         7GNDmdAC9n9PbdUuAwJ8S+x89dgU+ee0qvrseStyI8mRCYt5nPMyS9MovLm1+c/0FDvu
         7qOQ2oa9LbnUcPDvuaBkwHdShFpuyi/xedGo1BpYALua1l65ojhPwV01AbscP3T1FHqX
         WY6Q==
X-Gm-Message-State: AOAM531DukzuXhO+qSOaIjME5centQUHKgYlSPvrUI2bR0pjrq+Zw6AF
        qq/Li6Rh7XEKysff/8RBBVxxrQ==
X-Google-Smtp-Source: ABdhPJwWR4lDjaUWruV1GQxvMYXA7xo1XqSWw6tA2GZzpIjE2YzA3N6O10u7hszg1BAmz/WtoF+cnA==
X-Received: by 2002:a62:7b47:0:b029:197:cd7f:e044 with SMTP id w68-20020a627b470000b0290197cd7fe044mr18948148pfc.68.1606749703789;
        Mon, 30 Nov 2020 07:21:43 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.21.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:43 -0800 (PST)
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
Subject: [PATCH v7 14/15] mm/hugetlb: Gather discrete indexes of tail page
Date:   Mon, 30 Nov 2020 23:18:37 +0800
Message-Id: <20201130151838.11208-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For hugetlb page, there are more metadata to save in the struct
page. But the head struct page cannot meet our needs, so we have
to abuse other tail struct page to store the metadata. In order
to avoid conflicts caused by subsequent use of more tail struct
pages, we can gather these discrete indexes of tail struct page
In this case, it will be easier to add a new tail page index later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h        | 13 +++++++++++++
 include/linux/hugetlb_cgroup.h | 15 +++++++++------
 mm/hugetlb.c                   | 12 ++++++------
 mm/hugetlb_vmemmap.h           |  4 ++--
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 66d82ae7b712..7295f6b3d55e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,19 @@ typedef struct { unsigned long pd; } hugepd_t;
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
+enum {
+	SUBPAGE_INDEX_ACTIVE = 1,	/* reuse page flags of PG_private */
+	SUBPAGE_INDEX_TEMPORARY,	/* reuse page->mapping */
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_CGROUP = SUBPAGE_INDEX_TEMPORARY,/* reuse page->private */
+	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
+#endif
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	SUBPAGE_INDEX_HWPOISON,		/* reuse page->private */
+#endif
+	NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..3d3c1c49efe4 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -24,8 +24,9 @@ struct file_region;
 /*
  * Minimum page order trackable by hugetlb cgroup.
  * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[2]) is the fault usage cgroup.
- * The third tail page (hpage[3]) is the reservation usage cgroup.
+ * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
+ * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
+ * is the reservation usage cgroup.
  */
 #define HUGETLB_CGROUP_MIN_ORDER	2
 
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
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a114d6bfd1b9..b2f8cfc6c524 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1428,20 +1428,20 @@ struct hstate *size_to_hstate(unsigned long size)
 bool page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return PageHead(page) && PagePrivate(&page[1]);
+	return PageHead(page) && PagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /* never called for tail page */
 static void set_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	SetPagePrivate(&page[1]);
+	SetPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 static void clear_page_huge_active(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
-	ClearPagePrivate(&page[1]);
+	ClearPagePrivate(&page[SUBPAGE_INDEX_ACTIVE]);
 }
 
 /*
@@ -1453,17 +1453,17 @@ static inline bool PageHugeTemporary(struct page *page)
 	if (!PageHuge(page))
 		return false;
 
-	return (unsigned long)page[2].mapping == -1U;
+	return (unsigned long)page[SUBPAGE_INDEX_TEMPORARY].mapping == -1U;
 }
 
 static inline void SetPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = (void *)-1U;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = (void *)-1U;
 }
 
 static inline void ClearPageHugeTemporary(struct page *page)
 {
-	page[2].mapping = NULL;
+	page[SUBPAGE_INDEX_TEMPORARY].mapping = NULL;
 }
 
 static void __free_huge_page(struct page *page)
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 4bb35d87ae10..54c2ca0e0dbe 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,7 +20,7 @@ static inline void subpage_hwpoison_deliver(struct page *head)
 	struct page *page = head;
 
 	if (PageHWPoison(head))
-		page = head + page_private(head + 4);
+		page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
 
 	/*
 	 * Move PageHWPoison flag from head page to the raw error page,
@@ -35,7 +35,7 @@ static inline void subpage_hwpoison_deliver(struct page *head)
 static inline void set_subpage_hwpoison(struct page *head, struct page *page)
 {
 	if (PageHWPoison(head))
-		set_page_private(head + 4, page - head);
+		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
 }
 
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
-- 
2.11.0

