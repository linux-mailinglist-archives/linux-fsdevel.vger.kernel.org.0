Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1D2EBF72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbhAFOVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 09:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbhAFOVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:21:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D070CC06134C
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 06:21:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t22so1798225pfl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dASYKFPFHjiUnTmEMcq8ifWiWDwHax4a4AuznfbkXhg=;
        b=QBIgusp0rz3cJH2Unc5f6ix8w/SB+q02KuZ1i9GykIZTfE7W8Qe1xN31TRSjWf1ZHd
         h7T3xHhSXev4xrmI4UUAC0QbxevIt/ZKxVBn/xAUhEQDlTu1TB+LNlV0IOzkNq0DzDUA
         AaRUziGgewnoNXIGGOc6a4zd5K2TGgOgRBTXD4hDxiUffzD/VWVnWIRlPhfI0iRcYbqd
         tH4m6Rxi88VZ6ehu9H1LqDEvz+x/fbbVnGyRRpolwJC75LGo5s6g9GSZ8E8rssNYenpK
         Q2g0mEHeixVP6De1Ulh30jeb27UbPr9/reb3Pn7vdzXrG+ZncM4pMRQTzvbZy9iunjcX
         p/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dASYKFPFHjiUnTmEMcq8ifWiWDwHax4a4AuznfbkXhg=;
        b=MzwI0+DsPgqFQssIxVWYb3UtH6mZBf2UMECUMlPgXttKt8lTJq/5l0RCrezk3XoNnO
         9RH9cQegr4asnvcIcsuxG5tJzOUk57ZTHLnXYsryp1XsUgWftHgz7CH7UKylhZI73svW
         UIQFQISFjSC/P4bpP+0zmi7r1gcfeihXm+XX0wYNQYaHhnc/dKVzZOaWwaUzhF4w87JA
         D8/qNNII9QJxy0GAlPiDmxMPWW6p00LO+IIiRYEmy6QezGPCRq5E0n8dw2ukKz+eZPQ6
         Qr8jQanyIRSDPq//RdQq8XwnmVuOKFw85fgAJEL3uXjXEdZudqyu9JRZB3YfGDq7f//j
         YYPQ==
X-Gm-Message-State: AOAM530f3E1qYmMJ8XH4OIB5wWC3dqzbh1ayF7FuDQt/lMXhzB+yk2Ox
        83TWrowVXnX8oPBie2r0NKm5dw==
X-Google-Smtp-Source: ABdhPJxVxNlrnkK2rQNjNpyM/qKsRrXp4UXrFzdyM5LkfYlnjfIYRQkeqeWhgbjGPfF053bTyUW5qw==
X-Received: by 2002:a62:874a:0:b029:19e:6e03:cfc3 with SMTP id i71-20020a62874a0000b029019e6e03cfc3mr3984496pfe.67.1609942890650;
        Wed, 06 Jan 2021 06:21:30 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.21.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:21:29 -0800 (PST)
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
Subject: [PATCH v12 08/13] mm/hugetlb: Flush work when dissolving a HugeTLB page
Date:   Wed,  6 Jan 2021 22:19:26 +0800
Message-Id: <20210106141931.73931-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should flush work when dissolving a HugeTLB page to make sure that
the HugeTLB page is freed to the buddy allocator. Because the caller
of dissolve_free_huge_pages() relies on this guarantee.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6caaa7e5dd2a..3222bad8b112 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1337,6 +1337,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
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
@@ -1887,6 +1893,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1900,8 +1907,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1915,6 +1923,14 @@ int dissolve_free_huge_page(struct page *page)
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

