Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045A762DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGZHiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjGZHht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:37:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CE449A;
        Wed, 26 Jul 2023 00:35:47 -0700 (PDT)
Received: from kwepemm600016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9lwZ58g1ztRpc;
        Wed, 26 Jul 2023 15:32:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:35:44 +0800
From:   liubo <liubo254@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <liubo254@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hughd@google.com>,
        <peterx@redhat.com>, <willy@infradead.org>
Subject: [PATCH] smaps: Fix the abnormal memory statistics obtained through /proc/pid/smaps
Date:   Wed, 26 Jul 2023 15:34:09 +0800
Message-ID: <20230726073409.631838-1-liubo254@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit 474098edac26 ("mm/gup: replace FOLL_NUMA by
gup_can_follow_protnone()"), FOLL_NUMA was removed and replaced by
the gup_can_follow_protnone interface.

However, for the case where the user-mode process uses transparent
huge pages, when analyzing the memory usage through
/proc/pid/smaps_rollup, the obtained memory usage is not consistent
with the RSS in /proc/pid/status.

Related examples are as follows:
cat /proc/15427/status
VmRSS:  20973024 kB
RssAnon:        20971616 kB
RssFile:            1408 kB
RssShmem:              0 kB

cat /proc/15427/smaps_rollup
00400000-7ffcc372d000 ---p 00000000 00:00 0 [rollup]
Rss:            14419432 kB
Pss:            14418079 kB
Pss_Dirty:      14418016 kB
Pss_Anon:       14418016 kB
Pss_File:             63 kB
Pss_Shmem:             0 kB
Anonymous:      14418016 kB
LazyFree:              0 kB
AnonHugePages:  14417920 kB

The root cause is that the traversal In the page table, the number of
pages obtained by smaps_pmd_entry does not include the pages
corresponding to PROTNONE,resulting in a different situation.

Therefore, when obtaining pages through the follow_trans_huge_pmd
interface, add the FOLL_FORCE flag to count the pages corresponding to
PROTNONE to solve the above problem.

Signed-off-by: liubo <liubo254@huawei.com>
Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
---
 fs/proc/task_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c1e6531cb02a..ed08f9b869e2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -571,8 +571,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool migration = false;
 
 	if (pmd_present(*pmd)) {
-		/* FOLL_DUMP will return -EFAULT on huge zero page */
-		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
+		/* FOLL_DUMP will return -EFAULT on huge zero page
+		 * FOLL_FORCE follow a PROT_NONE mapped page
+		 */
+		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP | FOLL_FORCE);
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
-- 
2.27.0

