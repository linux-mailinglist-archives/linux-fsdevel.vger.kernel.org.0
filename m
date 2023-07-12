Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C1750ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjGLOZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGLOZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:25:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7419A3;
        Wed, 12 Jul 2023 07:25:15 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1KgS2xkDzMqYD;
        Wed, 12 Jul 2023 22:21:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:25:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <selinux@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/5] mm: use vma_is_stack() and vma_is_heap()
Date:   Wed, 12 Jul 2023 22:38:28 +0800
Message-ID: <20230712143831.120701-3-wangkefeng.wang@huawei.com>
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

Use the helpers to simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/task_mmu.c   | 24 ++++--------------------
 fs/proc/task_nommu.c | 15 +--------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cfab855fe7e9..05e9893552ce 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -236,21 +236,6 @@ static int do_maps_open(struct inode *inode, struct file *file,
 				sizeof(struct proc_maps_private));
 }
 
-/*
- * Indicate if the VMA is a stack for the given task; for
- * /proc/PID/maps that is the stack of the main task.
- */
-static int is_stack(struct vm_area_struct *vma)
-{
-	/*
-	 * We make no effort to guess what a given thread considers to be
-	 * its "stack".  It's not even well-defined for programs written
-	 * languages like Go.
-	 */
-	return vma->vm_start <= vma->vm_mm->start_stack &&
-		vma->vm_end >= vma->vm_mm->start_stack;
-}
-
 static void show_vma_header_prefix(struct seq_file *m,
 				   unsigned long start, unsigned long end,
 				   vm_flags_t flags, unsigned long long pgoff,
@@ -327,13 +312,12 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 			goto done;
 		}
 
-		if (vma->vm_start <= mm->brk &&
-		    vma->vm_end >= mm->start_brk) {
+		if (vma_is_heap(vma)) {
 			name = "[heap]";
 			goto done;
 		}
 
-		if (is_stack(vma)) {
+		if (vma_is_stack(vma)) {
 			name = "[stack]";
 			goto done;
 		}
@@ -1974,9 +1958,9 @@ static int show_numa_map(struct seq_file *m, void *v)
 	if (file) {
 		seq_puts(m, " file=");
 		seq_file_path(m, file, "\n\t= ");
-	} else if (vma->vm_start <= mm->brk && vma->vm_end >= mm->start_brk) {
+	} else if (vma_is_heap(vma)) {
 		seq_puts(m, " heap");
-	} else if (is_stack(vma)) {
+	} else if (vma_is_stack(vma)) {
 		seq_puts(m, " stack");
 	}
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 2c8b62265981..f42c84172b9e 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -121,19 +121,6 @@ unsigned long task_statm(struct mm_struct *mm,
 	return size;
 }
 
-static int is_stack(struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	/*
-	 * We make no effort to guess what a given thread considers to be
-	 * its "stack".  It's not even well-defined for programs written
-	 * languages like Go.
-	 */
-	return vma->vm_start <= mm->start_stack &&
-		vma->vm_end >= mm->start_stack;
-}
-
 /*
  * display a single VMA to a sequenced file
  */
@@ -171,7 +158,7 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 	if (file) {
 		seq_pad(m, ' ');
 		seq_file_path(m, file, "");
-	} else if (mm && is_stack(vma)) {
+	} else if (mm && vma_is_stack(vma)) {
 		seq_pad(m, ' ');
 		seq_puts(m, "[stack]");
 	}
-- 
2.41.0

