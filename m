Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B62BA293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKTGsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgKTGsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:48:17 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C3C061A04
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:16 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 10so6946575pfp.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Do8GcGO4xmr+cusNrmUBw5tiCH8/VB9at1POMWv3fh0=;
        b=oHuG7CqvR273FTn61sbH+LZ9ciiaqHc/fvv8a2VuhUVaTlyz45DJpff3068NZzNE9n
         f2Y9K+e3P7w2Y/egDOo4mCzZyAA4wuLl3nZmhdYb7rbZSijfzmdPN0ODv3ZN+R2nnS/w
         aEw6mRLycjPA2344UXwW95+0Da3049dnNjhMOHWOpkrLQ9dWMX8JYK7PkhPFDaGIaPKS
         5y5/qZKW4xEnOcpveJgGLWLEcoyURo/p0FFD4RIkZlwA+yGL4i5aTsTMlFXY1PEde1VD
         bzJXbBlBWtnqpB91w3r9ijKBKplKusdCXHIFQTEo/rpijlyDBpbjr+6fnKmzbFKHYlk6
         er3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Do8GcGO4xmr+cusNrmUBw5tiCH8/VB9at1POMWv3fh0=;
        b=IUsUtEjWl1HsVV2fxVj5iPk4S1c/l3KIlNPb4Yd1jCkJZz/Z9bdciyr7RA/kLRlEDO
         F8IRGC1KE6CVfCQqhd3gyGM/07BBk1sfyl+09IukYoseaVRBEe0mTRuEhSVgriAqwdRZ
         NeUJTpdzcNAls2gaKzu74CDqScAuoS5qUuBOyVRJzYqotBwKBR4CN84a2tY8T+V06DgQ
         wan84PjvYtGdcYD+5rhxpNoPYto8DaF45zd+nMh50DPmrqL6u9tV9C4uR0Lv/oAzbFRq
         CBJTgwTNjl4ztAf2LyDK2GLN0C77pu/s7KhraPHJcyUWWpKK3803CRoJolRsqBsqvc96
         01PA==
X-Gm-Message-State: AOAM532LcHhw+kgWUOgoL0WOYFoDT7edX7/OKSmLCUuTvdN2vW5pzLAT
        B+WaSkS5cI9tuDncsdGtxSFOig==
X-Google-Smtp-Source: ABdhPJydpnegg1dAIfXPFOT/olIsplN9RWAEQRFf2e6HdaBkydyhP4+NMb0O7oxmIGQlT2jDgLzaZA==
X-Received: by 2002:a17:90a:ca97:: with SMTP id y23mr8185536pjt.186.1605854895707;
        Thu, 19 Nov 2020 22:48:15 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:48:15 -0800 (PST)
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
Subject: [PATCH v5 13/21] mm/hugetlb: Use PG_slab to indicate split pmd
Date:   Fri, 20 Nov 2020 14:43:17 +0800
Message-Id: <20201120064325.34492-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 06e2b8a7b7c8..e2ddc73ce25f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -293,6 +293,25 @@ static void remap_huge_page_pmd_vmemmap(struct hstate *h, pmd_t *pmd,
 	flush_tlb_kernel_range(start, end);
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
 static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
 					  unsigned long start,
 					  unsigned long end,
@@ -357,11 +376,12 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
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
@@ -443,8 +463,10 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	BUG_ON(!pmd);
 
 	ptl = vmemmap_pmd_lock(pmd);
-	if (vmemmap_pmd_huge(pmd))
+	if (vmemmap_pmd_huge(pmd)) {
 		split_vmemmap_huge_page(head, pmd);
+		set_pmd_split(pmd);
+	}
 
 	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
 				    __free_huge_page_pte_vmemmap);
-- 
2.11.0

