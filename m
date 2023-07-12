Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E90750AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGLOZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGLOZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:25:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B541BC1;
        Wed, 12 Jul 2023 07:25:17 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1Kkc0gYvz1JCRg;
        Wed, 12 Jul 2023 22:24:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:25:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <selinux@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 5/5] perf/core: use vma_is_stack() and vma_is_heap()
Date:   Wed, 12 Jul 2023 22:38:31 +0800
Message-ID: <20230712143831.120701-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the helpers to simplify code, also kill unneeded goto cpy_name.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/events/core.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 78ae7b6f90fd..cb271f449b81 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8685,22 +8685,14 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		}
 
 		name = (char *)arch_vma_name(vma);
-		if (name)
-			goto cpy_name;
-
-		if (vma->vm_start <= vma->vm_mm->start_brk &&
-				vma->vm_end >= vma->vm_mm->brk) {
-			name = "[heap]";
-			goto cpy_name;
+		if (!name) {
+			if (vma_is_heap(vma))
+				name = "[heap]";
+			else if (vma_is_stack(vma))
+				name = "[stack]";
+			else
+				name = "//anon";
 		}
-		if (vma->vm_start <= vma->vm_mm->start_stack &&
-				vma->vm_end >= vma->vm_mm->start_stack) {
-			name = "[stack]";
-			goto cpy_name;
-		}
-
-		name = "//anon";
-		goto cpy_name;
 	}
 
 cpy_name:
-- 
2.41.0

