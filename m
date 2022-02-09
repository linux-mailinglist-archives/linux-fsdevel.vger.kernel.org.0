Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23064AE76A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 04:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiBIDDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350283AbiBICtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:49:35 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFDC0613CC;
        Tue,  8 Feb 2022 18:36:44 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644374202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JhaRiHxNGMaWK3YKZvBkBs+xYo59cXloX0HvpTiAB2I=;
        b=XnW+pZHOYqYOKhHfiGql7fIwcVeqACsYAl7tZjX02IBYJaQTLBb3yY4b0bGn0+3IZaBMrK
        8d8+hwoWd6deui7/X70eiWnnBYoPyBo1VgIGOw8Q+hqRDdofu5PW3PhVhEBiOQ1aDuTC6D
        kv0L/n/u7SACrZCBjUDxxZ67nbvjPdE=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Colin Cross <ccross@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: task_mmu.c: Fix the error-unused variable 'migration'
Date:   Wed,  9 Feb 2022 10:35:59 +0800
Message-Id: <20220209023602.21929-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid the error-unused variable 'migration' when
CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_ARCH_ENABLE_THP_MIGRATION
are not enabled.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index bc2f46033231..b055ff29204d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1441,7 +1441,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	spinlock_t *ptl;
 	pte_t *pte, *orig_pte;
 	int err = 0;
-	bool migration = false;
+	bool migration __maybe_unused = false;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptl = pmd_trans_huge_lock(pmdp, vma);
-- 
2.25.1

