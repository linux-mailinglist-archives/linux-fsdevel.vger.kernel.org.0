Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E668651EC44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiEHJDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiEHJDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 05:03:00 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E5BCB7;
        Sun,  8 May 2022 01:59:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCZrFB4_1652000345;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCZrFB4_1652000345)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 16:59:06 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org
Cc:     baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 2/3] fs/proc/task_mmu: Change to use huge_ptep_get_access_flags()
Date:   Sun,  8 May 2022 16:58:53 +0800
Message-Id: <62de656111dcdb8d189698316f1c2721753d7c7a.1651998586.git.baolin.wang@linux.alibaba.com>
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
subpages' dirty or young flags. So the gather_hugetlb_stats()
will miss some dirty hugetlb statistics.

Thus change to use huge_ptep_get_access_flags() taking into accounts
the subpages' dirty or young flags of a CONT-PTE/PMD size hugetlb,
to make the hugetlb statistics more accurate.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f9c9abb..3f224a7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1880,7 +1880,8 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get_access_flags(pte,
+				huge_page_size(hstate_vma(walk->vma)));
 	struct numa_maps *md;
 	struct page *page;
 
-- 
1.8.3.1

