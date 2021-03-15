Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46D433AEB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhCOJ1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhCOJ0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:26:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5213FC061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:26:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so14017839pjq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2/ODMtgLnweb1N5hCFVuD0E57uJQlZA+87DYa7fEos=;
        b=fWqFlVpLDZVvabLTqY6XWqIm5EPe9ESjAJ65lwHImJuxbe6oi0UTTL5++R8iGfCNsn
         rLoc43/C1rfgUtH3bGELhMC3P/tjwKuoyKOTZYklNssCqsCh7a4ShaabLwxV0mb2zC5P
         iwxyaO+Nw/P4QkOrK75T/YF5xiwQS5OOZZxVcy1kmnGWesurCAKSBVceRc2ilGKgftmI
         pznCl127tMcy1ByP+QBUYNnKsfwH9HPQL5EcmqlGacHmQ9V6ahNdxhbXGsnmrB/ZWnZY
         4tF7cV2wvQJwNzfGAzk9grb7AI3HY/LZ5O8xcf15QlN7nQMbTtRUAja/pzRN348G6fbc
         BPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2/ODMtgLnweb1N5hCFVuD0E57uJQlZA+87DYa7fEos=;
        b=r0xONe0hIm1xkscymQiAcrPQ21CzwP3rmW+H2flTIS03ZbduifZ3hck0YSbUPqhxnk
         QECsYCSzT8eJaBOkF8om33L6ENrSBQ0FU543GDoKYQF+XL2iL8UoU3ftQps2Wgi4IlLX
         Zdz/X5wNSSXC6Q33Btx/THJxMBHdmALzgqzWUQf7zlBHxf1dcGI5d3xvHZCyZB47D+tl
         /OPUdtgWYSr3e0gzKNL8iVJvLXupvFcXhhV9e1jO721pa4HiHCvboWiwv1DDbA/613aN
         QdQB1Mla2TQbQI/xvl+xe9apF14TF7JNGJdiPmbPwCmY9GYEZX1P7wYGO5nK/Da+wPGa
         f05w==
X-Gm-Message-State: AOAM532rv7sRsvOuGBMCZg30ge/sjgopmOImzwNM/Rm4TD9n2KbnPhWa
        Mio/jutQxcCLV38K2sobnCrvJg==
X-Google-Smtp-Source: ABdhPJzN98itLq+BobCymLYOZG6KeM6JPt1UFnCPke4TlN6xln50a6pC7P2034I9S10auzTeMIb7Sw==
X-Received: by 2002:a17:903:4093:b029:e5:b933:fab7 with SMTP id z19-20020a1709034093b02900e5b933fab7mr10455889plc.11.1615800400893;
        Mon, 15 Mar 2021 02:26:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id gm10sm10607883pjb.4.2021.03.15.02.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:26:40 -0700 (PDT)
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
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v19 3/8] mm: hugetlb: gather discrete indexes of tail page
Date:   Mon, 15 Mar 2021 17:20:10 +0800
Message-Id: <20210315092015.35396-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210315092015.35396-1-songmuchun@bytedance.com>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
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

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/hugetlb.h        | 21 +++++++++++++++++++--
 include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ce6533584eb7..09421f5f35e2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,23 @@ typedef struct { unsigned long pd; } hugepd_t;
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
+	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
+#endif
+	__NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -604,13 +621,13 @@ extern unsigned int default_hstate_idx;
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
index 2ad6e92f124a..54ec689e3c9c 100644
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
+#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__MAX_CGROUP_SUBPAGE_INDEX + 1)
 
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
 
-- 
2.11.0

