Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89BB2C87C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgK3PWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgK3PWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:22:09 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E7C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:23 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id t12so1563634pjq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYT5dZtYNzoNgBDfI70BMw/hObfhoANnOlo7wxpDnOM=;
        b=LwCkA5hrD1gS48cmMaDT4qNjkGb6QdEv5brr1re2aHgG+6vLIkxIOY0LXKteJIDKn5
         oZD7pJeys1ZiAV5Oco/N6zt5O24MHWQm1ONrkg/tWXj9Y+VFcP4eOmMmKaSvOnJ7g0k4
         74Z2xr9Sv/YIpgMg+hOKcpsvL3ZmX38JB6WrqJ53wfLVojj4Q/q8Ncs8kEdQmYaTf8st
         UszQjA7JU6se5KTtNhGZXFbuMjeGaiUBI+n9V/9+rn9Xs0tooZ3DqkiUh9AkHkjBh7XY
         bsYgwedmNvzFgI7KACSo4vfq9wbH8Iw5IMDXOGX/2Pb06fHj10wKqyGQmu2/wpe83kUF
         CcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYT5dZtYNzoNgBDfI70BMw/hObfhoANnOlo7wxpDnOM=;
        b=gJqqhblMjjk+CCDcs9YvUYyr4GVBKIS9V50WULGgx3awiqORTbWF4GIz+6B24lSS4o
         KrZAHjsQ+qzDgK7VLJHjZF+2SUWGdSFZa6opIA6JunJSGOXf8dDt2VKechk8elRylSc0
         zFHqYnyNGBvYJ12+Q1+0pRsqhhpvnP0wK7Q/7jM3EWVd5Uh+ZF9FOESUaIhvR6qhtnOR
         Dw6UQX6N2VLqatcWmeoYLXYFTAEyUGZJC5KnxtEipaJjE8CxQELwmgvrHRVWUDqRAAPY
         uB3AsmOvKhtTxEfhqJ/IaLOjnK3d1SsENGbbBhrmYsOcDOwqMKXHY1WPglArD3QafFnP
         LNTw==
X-Gm-Message-State: AOAM532rT2FM282qGlB0x418R/N68wvPMhcIXVexVnPdbrtmmrmtpc5J
        y/PHNf+QHYH4q1ytz/Vi7aGiHw==
X-Google-Smtp-Source: ABdhPJzdJo9xFB6qdz9EJXty4ReNm/tlcxVwZxpF9t/uXenCEP4+6bpzwvCYL7obLU7Z+UpQ5teEuA==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr27218790pjb.70.1606749683381;
        Mon, 30 Nov 2020 07:21:23 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.21.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:22 -0800 (PST)
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
Subject: [PATCH v7 12/15] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Mon, 30 Nov 2020 23:18:35 +0800
Message-Id: <20201130151838.11208-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should flush work when dissolving a hugetlb page to make sure that
the hugetlb page is freed to the buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 12cb46b8e901..a114d6bfd1b9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1327,6 +1327,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
 }
 static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
 
+static inline void flush_hpage_update_work(struct hstate *h)
+{
+	if (free_vmemmap_pages_per_hpage(h))
+		flush_work(&hpage_update_work);
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	/* No need to allocate vmemmap pages */
@@ -1833,6 +1839,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1846,8 +1853,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1861,6 +1869,14 @@ int dissolve_free_huge_page(struct page *page)
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * We should flush work before return to make sure that
+	 * the HugeTLB page is freed to the buddy.
+	 */
+	if (!rc && h)
+		flush_hpage_update_work(h);
+
 	return rc;
 }
 
-- 
2.11.0

