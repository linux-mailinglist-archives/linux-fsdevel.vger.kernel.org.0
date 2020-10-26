Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E8299042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782748AbgJZO4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:56:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46618 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782742AbgJZO4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:56:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id x10so2591796plm.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8s2C/dmr+hzCVncDgNolmMfa9FiU5L4x2d/qdrYiLM=;
        b=bvJ+weNAK62o0rqsgtIP0MF494iJCbOlFGfBQz4Tf9Be9dkFY02ErXnV2CkxwQaJov
         vqsGZ3GKTAsZrrZUC214OE93EHHrjfk5fqKqscbWBq8qOkomhTUcpOSIgSYpMpIijEaB
         ncDnCibpBpXWFQmxJirNhgJnLIs7QN6RcdYnunEWvzcZK4cgqUv3WM8JFgr3ShbPJq8x
         ABMaw8/KOGL5AgUEtVsuKaWbekW4Y49KPndxbHNz/cnMsvoCCrX2xsCB6PfP95KQn47H
         omQfSHbSMR7ihAMsvGPAb/mmD/Bdnjz95N+9qJYe2rbEafIlC8fOu8KgEDZ71ERVVQpC
         JloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8s2C/dmr+hzCVncDgNolmMfa9FiU5L4x2d/qdrYiLM=;
        b=OY2hLjVeY604oWtraTeKMjsxvyCRIelmMY9DrpW24WSFwIEskFujHKz2Ghy0CqN1KQ
         NpHHIFIXmJ2fRWgSPccW5R6axrt828WA19tw0RhcCxme6zl5QAqH6L8bruqhXewZb0HI
         Cy6I1pLJzAz0t4UtDDk2a9gPm7uSfR9boFJjrW6/rFDIy75WRkPWp6s9EWTlBavQiT4e
         jvzvwsTGo7JQoR88Q57c8Cg8kMfuvUCGEArV2eF1ykaTIRPniaDqKOgplPgXTX/rCdF+
         UAYLf4zw7cXwiTA7iA1P1Jgnb3LLbOzgfsLBkZNU38o2vtPjvkmBQu4yO3h1BD50+qOp
         GNFw==
X-Gm-Message-State: AOAM5324+JUf8Wz+WG6TM6IS9bscSW4NfXOod8JSNjx6lMCL1IKp8Hjx
        tB3ATtKo4ZHWA24EIP2BvrCsbA==
X-Google-Smtp-Source: ABdhPJzligmAWidXFyuZPsN3hhtvBApJ3V4vmQY4KHzYlIoIpDOWARzwAlJv6luUtUdt32oM2nOhag==
X-Received: by 2002:a17:90a:fa48:: with SMTP id dt8mr16879212pjb.108.1603724163086;
        Mon, 26 Oct 2020 07:56:03 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:56:02 -0700 (PDT)
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
Subject: [PATCH v2 18/19] mm/hugetlb: Gather discrete indexes of tail page
Date:   Mon, 26 Oct 2020 22:51:13 +0800
Message-Id: <20201026145114.59424-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c                   | 18 +++++++++---------
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3a45199cc5c1..6d377b6099f0 100644
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
index a526bcdb137b..029b00ed52ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1925,17 +1925,17 @@ static inline void flush_free_huge_page_work(void)
 
 static inline bool subpage_hwpoison(struct page *head, struct page *page)
 {
-	return page_private(head + 4) == page - head;
+	return page_private(head + SUBPAGE_INDEX_HWPOISON) == page - head;
 }
 
 static inline void set_subpage_hwpoison(struct page *head, struct page *page)
 {
-	set_page_private(head + 4, page - head);
+	set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
 }
 
 static inline void clear_subpage_hwpoison(struct page *head)
 {
-	set_page_private(head + 4, 0);
+	set_page_private(head + SUBPAGE_INDEX_HWPOISON, 0);
 }
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
@@ -2075,20 +2075,20 @@ struct hstate *size_to_hstate(unsigned long size)
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
@@ -2100,17 +2100,17 @@ static inline bool PageHugeTemporary(struct page *page)
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
-- 
2.20.1

