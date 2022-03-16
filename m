Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506EF4DA8B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353410AbiCPDBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCPDBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:01:08 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707365D669;
        Tue, 15 Mar 2022 19:59:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7KZLHo_1647399589;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0V7KZLHo_1647399589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 10:59:50 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     adobriyan@gmail.com, shy828301@gmail.com, sashal@kernel.org,
        akpm@linux-foundation.org, linmiaohe@huawei.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] mm: proc: remove redundant page validation of pte_page
Date:   Wed, 16 Mar 2022 10:59:47 +0800
Message-Id: <20220316025947.328276-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pte_page() always returns a valid page, so remove the redundant
page validation, as we did in many other places.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 fs/proc/task_mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f46060eb9..a843d13e2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1873,8 +1873,6 @@ static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		return 0;
 
 	page = pte_page(huge_pte);
-	if (!page)
-		return 0;
 
 	md = walk->private;
 	gather_stats(page, md, pte_dirty(huge_pte), 1);
-- 
2.17.1

