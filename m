Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD792AAB95
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKHOPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKHOPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:15:07 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DBC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:15:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so6449pfu.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+pj5tPMvMXnx32hBMvm1ajVAzlJ7YDVCn4dJUaWnUA=;
        b=KGbXZwTkiLz84tXlUP4bi2kCpQ0nHeH1CMyl6yYdCOCV/rHFVJQKBAuB09h0oyUUmt
         zNt4VXowCLFHHUtk9MxSGfUrD1KUwFMmM/vxRNbhEL7s1ey0OVO+Wg6omi8rRoRM0QiH
         H6gHk30M8hMt7gN6hBHRrX0lCfebp5xZ0GLSSlUtJV/ejG4H2j33GDeHnF6Ms91sWliJ
         p3AJ4Kdy3Lv8yPPWOdD4f+e5L56y77WRSW6h4vHV5XzXwFTswuOhtra2vOQKrkRH/drY
         5Ow2Ao3w5j+USJRqS7226vNfONQEfKs3lTaZaqEIiKVmURoIM5+OH/kbWgZ3mEfGjJNr
         ce2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+pj5tPMvMXnx32hBMvm1ajVAzlJ7YDVCn4dJUaWnUA=;
        b=fp4ayWTAttNW4q+iG7px0pbv7CkToWSR0Zl6rzd2dQUhITxP2ofN3AlFmaXsdkZT1V
         HjJd/dSbNSEeWPC0bYQIFqXU6ARY35vWLdf0WG0VvfGRIL63UH5gvdf5VM0rZqs9SR9x
         tyOXEFv7I4fMZwz8Vf7UZHDWCweWDJLmcxHa4RckC9wT46M+jj7CxSBY1kna98FC4ljK
         oGE/ItC724/cIZqiIhYk4ikmGgxpGtSIgC41Uh0B4XAPKRADxwC9KKTE/rsuM27cxvnv
         r9Ccwa/+KBuqtcN7tMpNyBzRgVnXCv2aJgUKuMAyPVC2jOWkiQLZ9j8TPXbeRbxPVYeP
         UPTQ==
X-Gm-Message-State: AOAM533/H4va66zG1sQS/+t1r2pkWCeHU0K7Si4G9XB23EegGzKVYZS/
        PY59Cit4SZmCrQZjfGx0grLhew==
X-Google-Smtp-Source: ABdhPJyEzVCy/CWEDirtuTPvNaVt+XUiPFs02MDJaUgg0dgIGbW9XqiytCuIQ617QOS/N4yH13vxTw==
X-Received: by 2002:a63:2145:: with SMTP id s5mr8808739pgm.288.1604844906177;
        Sun, 08 Nov 2020 06:15:06 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:15:05 -0800 (PST)
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
Subject: [PATCH v3 20/21] mm/hugetlb: Gather discrete indexes of tail page
Date:   Sun,  8 Nov 2020 22:11:12 +0800
Message-Id: <20201108141113.65450-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
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
 mm/hugetlb.c                   | 16 ++++++++--------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 32abfb420731..cb604b9dd649 100644
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
index 52e56c3a9b72..1dd1a9cec008 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1918,7 +1918,7 @@ static inline void subpage_hwpoison_deliver(struct page *head)
 	struct page *page = head;
 
 	if (PageHWPoison(head))
-		page = head + page_private(head + 4);
+		page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
 
 	/*
 	 * Move PageHWPoison flag from head page to the raw error page,
@@ -1933,7 +1933,7 @@ static inline void subpage_hwpoison_deliver(struct page *head)
 static inline void set_subpage_hwpoison(struct page *head, struct page *page)
 {
 	if (PageHWPoison(head))
-		set_page_private(head + 4, page - head);
+		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
 }
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
@@ -2074,20 +2074,20 @@ struct hstate *size_to_hstate(unsigned long size)
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
@@ -2099,17 +2099,17 @@ static inline bool PageHugeTemporary(struct page *page)
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
2.11.0

