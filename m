Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779E326B860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIPAm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIONCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C511C0611C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so1959032pgd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVV3WTmK6XA7LtxrkcMYqgHDOYcKykPcvtWqvODpAvM=;
        b=gHURAa2qwURYUv/ja5UoRzgyS1wkJkFAoxB36PqJjiqmVMoqDqHbzyNT1qlRaW9R9w
         FFwUBjf79ioO3vM8rMphZORI5NfLer+NOcsdXapnm3limLJGlHbEIUIJEfLqoWkMoNsv
         Xj3zBK/49fR4GZYSNgUft4ZoNumz1JNrGmeyCzNSWArndSMd5B2QPwYll2w3SdctsHuw
         Q2a+6wpYZYqAqe+r8BFxUtd60lFitcBA2aCxd9pFA0Mnz3rRX7EDutZSxJAcUaenBr8L
         B0Mm+xGXz3o/8hk8vLZqqA6TGfPoDAn5cHutkKLV5C2gjF/HoxkxihfB8ltGatni1xkf
         aOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVV3WTmK6XA7LtxrkcMYqgHDOYcKykPcvtWqvODpAvM=;
        b=NeXjV9NfZBAEPviHB0TDhadM8V41Zq3RrPNQoZg25d8/MpkxEb4Atb8TC9IRb70o9x
         pnz+Ui6jWdrCgord1MEf21pa0V1lCiRT4rmRUcHc9mspNnfJE/CDP74tn3N4myfmrUWw
         8p63uut3BMzZpEhuOQUxuA57XR6BeeTWDebYDGpchVTaOtPNk7g9cGp8+E4+cqS3blSk
         onvtaLFfGDz+Tbtm3N5HMAnG/VUePoutvSMhoeIwEPQPJQ+igJaX8mVXyZC+SRxvZilQ
         V5mVzezT8H4QCL2JrnoI48Z2oyOQJXLczNPdxglEmvy7oZOGAE9wDU0keagZz1lyA01j
         gGfA==
X-Gm-Message-State: AOAM531uggxpoDwrwv3x8kwAMeWm301R4ycoiKQ8NHWhc3BFgsRKSTOa
        Mfygjk6zvgMjM2N/1trPOxdP/Q==
X-Google-Smtp-Source: ABdhPJzvhvBb63cFKpGYA1g3UNc9aZPmEibZEVeHZ1Quj26JsNItVJjEgrqQJPDwM+Q4GgdbshBhhg==
X-Received: by 2002:a63:4d5b:: with SMTP id n27mr14337711pgl.360.1600174954601;
        Tue, 15 Sep 2020 06:02:34 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:34 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 15/24] mm/hugetlb: Use PG_slab to indicate split pmd
Date:   Tue, 15 Sep 2020 20:59:38 +0800
Message-Id: <20200915125947.26204-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 5cc796dc3a0a..c42c27a12df2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1629,6 +1629,25 @@ static void split_vmemmap_huge_page(struct page *head, pmd_t *pmd)
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
@@ -1645,6 +1664,7 @@ static void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	if (vmemmap_pmd_huge(pmd)) {
 		VM_BUG_ON(!nr_pgtable(h));
 		split_vmemmap_huge_page(head, pmd);
+		set_pmd_split(pmd);
 	}
 
 	remap_huge_page_pmd_vmemmap(h, pmd, (unsigned long)head, &free_pages,
@@ -1718,11 +1738,12 @@ static void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	spin_lock(ptl);
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
2.20.1

