Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA32AAB7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgKHON4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgKHONz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:55 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D8C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:54 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so4590802pgg.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFvWVRuWHt463dQDdqukGR7bqLaRSs18WBT8QT/EalE=;
        b=Ep+CuZUX/uBfg+ywqlNDPDWSezOzVFRCpwC4tRkIO5YtwQn+xjHA9ywAq9dgs2V1cT
         jVd/BxEsvDq9s1xrtgaq60SbNKEhiZcSX2L2HsARVmWDr6r245JppS+LyNIjaUXHFZkt
         /c2+xuW2xqGJCmK6CUkwZ5gEI57L7XM+D8+7c3GBNsP6rKWjLpiz7p757SnSXKbxBQu6
         0571GGcCt7T+9UlS5tlBl3PEI2liBVMWR4ZlYm1LzJ8q2DwYuMyZT5gjFQp0spvSijy0
         G3nHtcUyF+HOwPf6AD2tiDiMxG+sMdqtIiB+8YjqqPEkJx7OMKBWwt1NWQD7GvMwMQSx
         mZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFvWVRuWHt463dQDdqukGR7bqLaRSs18WBT8QT/EalE=;
        b=sBUGBWaIoyoQts2Rq+Nk7lc4mJUMqjvpSO/yti78SUCNeBF/czjvVw3E9SvG3l5DbK
         UyYwClh1JK64WJ2qmtmiZ18ijGphzvHqRDlmCPI99f6ooCd2n5X9PeFPGrlp4CTDl4XE
         fC3wYG58yxekazmLQOlVwY6EvYQPhPVYio21ZqOlz0YTwXO+yiZCQeW4DVUrA3vSYUkA
         j0Sryv1dR+X2kReoLko5BUshhgzKv/g8d3Xw9vNyryc8MlrTEkuKlR3UgJEwuPoG6PDW
         U5AuSbHX/lqdJ7jpvyOFXeV3iz7o461WAuBHUQGCVuWyeLzvtardUExbid60t5wbOLSM
         JttQ==
X-Gm-Message-State: AOAM5316InmDMr+05YM83ZNfXqRCRiC5RTANzt1uR+HVQGBBIJ24eypT
        ZM3qCVQk4+QrgjbL9lxCNrsEeg==
X-Google-Smtp-Source: ABdhPJz7zuNAIV4IAVZhc7gKx9qk6parvKFljufOCjpJdrnjCZATqW0v3rLLOKJQc2CnPwKMO8GR7w==
X-Received: by 2002:a63:3202:: with SMTP id y2mr9079909pgy.97.1604844834110;
        Sun, 08 Nov 2020 06:13:54 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.13.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:53 -0800 (PST)
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
Subject: [PATCH v3 13/21] mm/hugetlb: Use PG_slab to indicate split pmd
Date:   Sun,  8 Nov 2020 22:11:05 +0800
Message-Id: <20201108141113.65450-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we allocate hugetlb page from buddy, we may need split huge pmd
to pte. When we free the hugetlb page, we can merge pte to pmd. So
we need to distinguish whether the previous pmd has been split. The
page table is not allocated from slab. So we can reuse the PG_slab
to indicate that the pmd has been split.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5d3806476212..9b1ac52d9fdd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1565,6 +1565,25 @@ static void split_vmemmap_huge_page(struct hstate *h, struct page *head,
 	flush_tlb_kernel_range(start, addr);
 }
 
+static inline bool pmd_split(pmd_t *pmd)
+{
+	return PageSlab(pmd_page(*pmd));
+}
+
+static inline void set_pmd_split(pmd_t *pmd)
+{
+	/*
+	 * We should not use slab for page table allocation. So we can set
+	 * PG_slab to indicate that the pmd has been split.
+	 */
+	__SetPageSlab(pmd_page(*pmd));
+}
+
+static inline void clear_pmd_split(pmd_t *pmd)
+{
+	__ClearPageSlab(pmd_page(*pmd));
+}
+
 static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 	pmd_t *pmd;
@@ -1579,6 +1598,7 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	if (vmemmap_pmd_huge(pmd)) {
 		VM_BUG_ON(!pgtable_pages_to_prealloc_per_hpage(h));
 		split_vmemmap_huge_page(h, head, pmd);
+		set_pmd_split(pmd);
 	}
 
 	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
@@ -1651,11 +1671,12 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	ptl = vmemmap_pmd_lock(pmd);
 	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &remap_pages,
 				    __remap_huge_page_pte_vmemmap);
-	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd))) {
+	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
 		/*
 		 * Todo:
 		 * Merge pte to huge pmd if it has ever been split.
 		 */
+		clear_pmd_split(pmd);
 	}
 	spin_unlock(ptl);
 }
-- 
2.11.0

