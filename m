Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDA51EC47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiEHJDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiEHJDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 05:03:01 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAABCB9;
        Sun,  8 May 2022 01:59:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCZrFBZ_1652000346;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCZrFBZ_1652000346)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 16:59:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org
Cc:     baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 3/3] mm/damon/vaddr: Change to use huge_ptep_get_access_flags()
Date:   Sun,  8 May 2022 16:58:54 +0800
Message-Id: <bfef01549847df7645bac0eacab74b4dde693e04.1651998586.git.baolin.wang@linux.alibaba.com>
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

The ARM64 platform can support CONT-PTE/PMD size hugetlb, which can
contain seravel continuous pte or pmd entries. However current
huge_ptep_get() only return one specific pte value for the CONT-PTE
or CONT-PMD size hugetlb, which did not take into accounts the
subpages' dirty or young flags. That will make the hugetlb pages
monitoring inaccurate with missing young flags.

Thus change to use huge_ptep_get_access_flags() taking into accounts
the subpages' dirty or young flags of a CONT-PTE/PMD size hugetlb.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/damon/vaddr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d6abf76..29459ed 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -400,7 +400,8 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
+	pte_t entry = huge_ptep_get_access_flags(pte,
+					huge_page_size(hstate_vma(vma)));
 	struct page *page = pte_page(entry);
 
 	get_page(page);
@@ -557,7 +558,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get_access_flags(pte, huge_page_size(h));
 	if (!pte_present(entry))
 		goto out;
 
-- 
1.8.3.1

