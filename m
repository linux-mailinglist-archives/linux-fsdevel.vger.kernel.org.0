Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E827851EC46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiEHJDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEHJDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 05:03:01 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840EBCB8;
        Sun,  8 May 2022 01:59:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCZrFAl_1652000344;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCZrFAl_1652000344)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 16:59:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org
Cc:     baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 1/3] arm64/hugetlb: Introduce new huge_ptep_get_access_flags() interface
Date:   Sun,  8 May 2022 16:58:52 +0800
Message-Id: <a73f07314e79299b85fa4d7612d6ac22548f58c1.1651998586.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we use huge_ptep_get() to get the pte value of a hugetlb page,
however it will only return one specific pte value for the CONT-PTE
or CONT-PMD size hugetlb on ARM64 system, which can contain seravel
continuous pte or pmd entries with same page table attributes. And it
will not take into account the subpages' dirty or young bits of a
CONT-PTE/PMD size hugetlb page.

So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
which already takes account the dirty or young bits for any subpages
in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
young flags statistics for hugetlb pages with current huge_ptep_get(),
such as the gather_hugetlb_stats() function.

Thus introduce a new huge_ptep_get_access_flags() interface and define
an ARM64 specific implementation, that will take into account any subpages'
dirty or young bits for CONT-PTE/PMD size hugetlb page, for those functions
that want to check the dirty and young flags of a hugetlb page.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 include/asm-generic/hugetlb.h    |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 616b2ca..a473544 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -44,6 +44,8 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
+#define __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
+extern pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz);
 extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, unsigned long sz);
 #define set_huge_swap_pte_at set_huge_swap_pte_at
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index ca8e65c..ce39699 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -158,6 +158,30 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
+pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz)
+{
+	int ncontig, i;
+	size_t pgsize;
+	pte_t orig_pte = ptep_get(ptep);
+
+	if (!pte_cont(orig_pte))
+		return orig_pte;
+
+	ncontig = num_contig_ptes(sz, &pgsize);
+
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index a57d667..bb77fb0 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
+static inline pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz)
+{
+	return ptep_get(ptep);
+}
+#endif
+
 #ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
 static inline bool gigantic_page_runtime_supported(void)
 {
-- 
1.8.3.1

