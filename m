Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB7766367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 06:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjG1Esz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjG1Esc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:48:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588E26B8;
        Thu, 27 Jul 2023 21:48:31 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBw6T19T8zNm4t;
        Fri, 28 Jul 2023 12:45:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 12:48:27 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <selinux@vger.kernel.org>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        David Hildenbrand <david@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <paul@paul-moore.com>,
        <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <peterz@infradead.org>, <acme@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 4/4] perf/core: use vma_is_initial_stack() and vma_is_initial_heap()
Date:   Fri, 28 Jul 2023 13:00:43 +0800
Message-ID: <20230728050043.59880-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the helpers to simplify code, also kill unneeded goto cpy_name.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/events/core.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f84e2640ea2f..b36d0823ff33 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8631,7 +8631,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	unsigned int size;
 	char tmp[16];
 	char *buf = NULL;
-	char *name;
+	char *name = NULL;
 
 	if (vma->vm_flags & VM_READ)
 		prot |= PROT_READ;
@@ -8678,29 +8678,18 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 		goto got_name;
 	} else {
-		if (vma->vm_ops && vma->vm_ops->name) {
+		if (vma->vm_ops && vma->vm_ops->name)
 			name = (char *) vma->vm_ops->name(vma);
-			if (name)
-				goto cpy_name;
+		if (!name)
+			name = (char *)arch_vma_name(vma);
+		if (!name) {
+			if (vma_is_initial_heap(vma))
+				name = "[heap]";
+			else if (vma_is_initial_stack(vma))
+				name = "[stack]";
+			else
+				name = "//anon";
 		}
-
-		name = (char *)arch_vma_name(vma);
-		if (name)
-			goto cpy_name;
-
-		if (vma->vm_start <= vma->vm_mm->start_brk &&
-				vma->vm_end >= vma->vm_mm->brk) {
-			name = "[heap]";
-			goto cpy_name;
-		}
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

