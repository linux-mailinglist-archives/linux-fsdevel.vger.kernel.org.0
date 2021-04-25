Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CA36A559
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhDYHOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhDYHOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:14:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80BC061760
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:13:21 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y32so38041175pga.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCnSzaZHCKqH61wVuHk0o1TT9bY3u6rBTZhvsMh9WN0=;
        b=iuQotF7krxl+PvfWxvrxojZC+Ta2JWPbGuN2zQiuPoAyq/hTMN+QHfdyvnmzFdNrtY
         PZoazCj4l9Qk3whw/6Lo9YfVMl8m5vCJq5PSfaeaWDFWN/JIu3LzyNtFtDZEDEM9l7zt
         BHb8F8zJ4VZnvv0x2w8QBXd74v7xGF8eCU+MnGs1BmRzSLbLWQkAQfJgOGYbR78a5nHT
         6NWPZfdHnQPBDYLqa49bu1p3uIrYtt5tcBydJxCBdpYvpBL3ROPVFwDo9QEXmILBsslJ
         FrphOMXa3NlDc7zj+lKCgZJhf7l7ho81fJX8cYJwlnkYk2t9+UnctntoezhwWokv+Xhj
         yD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCnSzaZHCKqH61wVuHk0o1TT9bY3u6rBTZhvsMh9WN0=;
        b=i8WvcbdNQLFo/eLF4bDvM+Qc1jR3QueNiTTei69aicf1bJtGmeNsOWryFN4qKd7YjF
         jVmVcB2AMF2nAE8KEyCrmow51F9Ul9jLXP6YgmFDfOUD786clgDO50b7GxAq1FvGOs/j
         bMaJhKkvD1k2vDLlR7HU0ZzgGbUwRlpDt+NFGdg2UEiNiX/3pRCZKl5y0oiz6eH5aNlb
         /65lxs+PdQKtHj0GBhx7S6HwpUZ43PTPowrVBDL5ne9YvnMJV5ntkG99q3tphiVAMmIR
         x9x1exlz/u3kfN/ocSCRW7BGW48jiJMpLrGVVNt7kOUB1rbvbX56BwYbTR60In5Y4IxE
         PUtw==
X-Gm-Message-State: AOAM530hmjI2+dXmsAVc7spNvAwF4alHNtwpNlf7XePAh8jiGrObv+aT
        zBPx0UOM//y4NopAaOkAhSOd+Q==
X-Google-Smtp-Source: ABdhPJwq/7b7UqgASe/biYAAZkDOaSMih+KJKhTHZoTaSTPoiT5ytk6k4oe47NPsXl9TWBo1ZygRmg==
X-Received: by 2002:aa7:8142:0:b029:256:d3d4:16a0 with SMTP id d2-20020aa781420000b0290256d3d416a0mr11569996pfn.56.1619334801067;
        Sun, 25 Apr 2021 00:13:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h8sm8767125pjt.17.2021.04.25.00.13.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 00:13:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v21 3/9] mm: hugetlb: gather discrete indexes of tail page
Date:   Sun, 25 Apr 2021 15:07:46 +0800
Message-Id: <20210425070752.17783-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210425070752.17783-1-songmuchun@bytedance.com>
References: <20210425070752.17783-1-songmuchun@bytedance.com>
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h        | 21 +++++++++++++++++++--
 include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef58..d523a345dc86 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -29,6 +29,23 @@ typedef struct { unsigned long pd; } hugepd_t;
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
@@ -627,13 +644,13 @@ extern unsigned int default_hstate_idx;
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
index 0bff345c4bc6..0b8d1fdda3a1 100644
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

