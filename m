Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CC851EC3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiEHJC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiEHJC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 05:02:57 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEDBCB7;
        Sun,  8 May 2022 01:59:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCZqsya_1652000343;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCZqsya_1652000343)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 May 2022 16:59:04 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org
Cc:     baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags() interface
Date:   Sun,  8 May 2022 16:58:51 +0800
Message-Id: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

As Mike pointed out [1], the huge_ptep_get() will only return one specific
pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
size hugetlb page for those functions that want to check the dirty or
young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
will also get inaccurate access statistics.

To fix this issue, one approach is that we can define an ARM64 specific huge_ptep_get()
implementation, which will take into account any subpages' dirty or young bits.
However we should add a new parameter for ARM64 specific huge_ptep_get() to check
how many continuous PTEs or PMDs in this CONT-PTE/PMD size hugetlb, that means we
should convert all the places using huge_ptep_get(), meanwhile most places using
huge_ptep_get() did not care about the dirty or young flags at all.

So instead of changing the prototype of huge_ptep_get(), this patch set introduces
a new huge_ptep_get_access_flags() interface and define an ARM64 specific implementation,
that will take into account any subpages' dirty or young bits for CONT-PTE/PMD size
hugetlb page. And we can only change to use huge_ptep_get_access_flags() for those
functions that care about the dirty or young flags of a hugetlb page.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Baolin Wang (3):
  arm64/hugetlb: Introduce new huge_ptep_get_access_flags() interface
  fs/proc/task_mmu: Change to use huge_ptep_get_access_flags()
  mm/damon/vaddr: Change to use huge_ptep_get_access_flags()

 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
 fs/proc/task_mmu.c               |  3 ++-
 include/asm-generic/hugetlb.h    |  7 +++++++
 mm/damon/vaddr.c                 |  5 +++--
 5 files changed, 38 insertions(+), 3 deletions(-)

-- 
1.8.3.1

