Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDD33AEC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCOJ1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCOJ1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:27:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E79C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:27:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so14021119pjh.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTYzbhsiA8bs2WRejVmaHhThRa6HhDAe7Bk8Um9iG/k=;
        b=oUOYR62B4HrwFWKoQPv3NKrcouBpXkF2Xbfj1dqe0HZ7QL39QjE0uIHdWF18QHJn6M
         /eYEetuE0Q4AwrcG/SUMjZqc1q4xp/SW+1Te097bI0/vYpWXKfQctJt3F93XOZNs1/7Q
         Dh474vez/g4qryni+h02n8fo1Xu3H7IcRJcRMggGoIxkFvmceVU7ITiXguK5/PcHjVbW
         HIL1mA9u79UR89qC62jAI59tw9oR4VR7CmXSBXFEZifAMlKPLxaYlkXs65ODx4c3D2IE
         RJvCR6w8kNgcFEnhzMaT0xMpPSu+JUWcpaOPkOA93HY/r4SczST+21IEsJFKLiFup0sY
         mOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTYzbhsiA8bs2WRejVmaHhThRa6HhDAe7Bk8Um9iG/k=;
        b=CBKe3hH0ZR6lAmgeYzNE+IhTQQACtPqZYTT3bfly8zty29duyiK11KCAzk7nGelr+c
         CjRupVX2RlBmQ5hnMPHt3qxOvGqRDgOv4eD7TFAS7oUK/HaJv8Dct7+Neh/t80RiqSsm
         mEjYIL3D82KQbs/aOdLgFpthyQLrFd+E44Oi1LHHh6HxBmR8RHKP09z+iJpjfTHqsTwp
         FPBlFMczrJ6T+O7sB7NannOV2vrgfOPi1craXv6kmcgyxn/CBVz6zFDU8jA+/mAKGgWs
         WiHoPThAfkD05TT0dqvVALfpjd9BcqOgP1F+M0+NCo56aXmcN/k9UFACkRxfrTTmWeSW
         AK6w==
X-Gm-Message-State: AOAM5305obEaaMbfrry5uaocpj61e6fRXh3Sk2x5zNmLi2xOnwndxysP
        J0pzMSU0RgiMCTdq95Ps57b4gDPlm/PSzXFZPCE=
X-Google-Smtp-Source: ABdhPJyEig3ApBxf8QVu35XAmR9adFxfmMYahwRL8W1n+VUerLTXU/+AJUV2Wh/oSpQqdws0zcb3fw==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr11805014pjx.194.1615800435132;
        Mon, 15 Mar 2021 02:27:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id gm10sm10607883pjb.4.2021.03.15.02.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:27:14 -0700 (PDT)
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
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v19 6/8] mm: hugetlb: set the PageHWPoison to the raw error page
Date:   Mon, 15 Mar 2021 17:20:13 +0800
Message-Id: <20210315092015.35396-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210315092015.35396-1-songmuchun@bytedance.com>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail vmemmap page frame and remap it
with read-only, we cannot set the PageHWPosion on some tail pages.
So we can use the head[4].private (There are at least 128 struct
page structures associated with the optimized HugeTLB page, so
using head[4].private is safe) to record the real error page index
and set the raw error page PageHWPoison later.

We cannot have more poisoned tail pages. So a single slot is
sufficient. Why?

memory_failure()
    if (PageHuge(page))
        memory_failure_hugetlb()
            head = compound_head(page)
            if (TestSetPageHWPoison(head))
                return

Because we do not clear the HWPoison of the head page, we cannot
poison another tail page.

Note: some pages might miss their poisoning (even without this patch).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 include/linux/hugetlb.h |  3 ++
 mm/hugetlb.c            | 81 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09421f5f35e2..7f7a0e3405ae 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -42,6 +42,9 @@ enum {
 	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
 	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
 #endif
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	SUBPAGE_INDEX_HWPOISON,		/* reuse page->private */
+#endif
 	__NR_USED_SUBPAGE,
 };
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e42b19337a8f..53f239818293 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1304,6 +1304,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+	struct page *page;
+
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
+
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (!PageHWPoison(head))
+		return;
+
+	if (free_vmemmap_pages_per_hpage(h)) {
+		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
+	} else if (page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	set_page_private(head + SUBPAGE_INDEX_HWPOISON, 0);
+}
+#else
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (PageHWPoison(head) && page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+}
+#endif
+
 static int update_and_free_page_surplus(struct hstate *h, struct page *page,
 					bool acct_surplus)
 	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
@@ -1807,22 +1875,17 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
+		hwpoison_subpage_set(h, head, page);
 		list_del(&head->lru);
 		ClearHPageFreed(page);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
 		rc = update_and_free_page_surplus(h, head, false);
-		if (rc)
+		if (rc) {
 			h->max_huge_pages++;
+			hwpoison_subpage_clear(h, head);
+		}
 	}
 out:
 	spin_unlock(&hugetlb_lock);
-- 
2.11.0

