Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9C3B8DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhGAHAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 03:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhGAHAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:00:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA0C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 23:58:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i6so5095011pfq.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2j5sHj4fTNFiJ0fEg2DaZPxjU5FE/29m/UxTOq2+cJM=;
        b=CWBvumUIFSBprc0SSVVgKWGcMqWbl49LahF1J1JVggc05hYvBuWhIlldpUGWT7s985
         zmcvvtazHjkIgCQJMS3CfoAAV/6g77nz76Zkim3nyeYcnd9scK86qpJSyq/IJ2bdAfba
         XnNkaPBEnKL0rX1J++ZL0soChZCeL0SNzNzw8gLwelobKlheWyHNasm7Xz+jZy9ETWCz
         Tc5uMYfjWSruQCdEj7BgxsabRFecR56Tvgv+6UIjarCXf4Lu1EvqHHQf61QcIIQuF8ew
         s89e5xiJ7ynoKKnonMnmcs6KzV6bGm4bDwWmGS+ndEElLlUXwkJHgCTyU4zg6DXNFcXo
         sLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2j5sHj4fTNFiJ0fEg2DaZPxjU5FE/29m/UxTOq2+cJM=;
        b=RfgX5e13M3f1JdsVwoq82KarBu0/SNYPh89f+j21V73qBHBr+EtsXt+JkBSWdM6psh
         pavBTblMs2UyHDeuVEBPEKcolp2cx7liDdRCEVL2Y3hDCozXAWX90kvawpEqk5vieYRC
         9++247eDVccVnw4EhJrfC3+zRaGsYQ1fUMnL5p9z9t3KQu+hjK+HjaRQmwW9cwkEeKla
         6O/5IMJFpdiXXquJrPzBjt8Y6GR+MJCsJPxywP7kuLhketEwRXvB+PH3vHBPoph7VEO3
         va2x8CvnFyqTqSy+Wsf7PblpY4vgXyeIgQ3wyXnHFfWtbZGvYx8i7G08XnvMNTabANgz
         o8wQ==
X-Gm-Message-State: AOAM532jWOQTfNDj1ly+nMJzCm3McjW53JwHcZg6x1JB6B/ZaA4wlAH7
        S6uj2pR1luj3c3/9tA77G8Y=
X-Google-Smtp-Source: ABdhPJyKLbRIxKJhQBEwxQfBoIoyPUL9iSq25qDD7BID9eWLaLpzoHugBkSEfGVf554bCOPTu5UdgQ==
X-Received: by 2002:aa7:81d8:0:b029:308:1d33:a5fa with SMTP id c24-20020aa781d80000b02903081d33a5famr37531090pfn.55.1625122694574;
        Wed, 30 Jun 2021 23:58:14 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 75sm1064024pfb.159.2021.06.30.23.58.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jun 2021 23:58:14 -0700 (PDT)
From:   lijiazi <jqqlijiazi@gmail.com>
X-Google-Original-From: lijiazi <lijiazi@xiaomi.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     lijiazi <lijiazi@xiaomi.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fix use-after-free issue in fuse_read_interrupt()
Date:   Thu,  1 Jul 2021 14:58:07 +0800
Message-Id: <1625122687-30115-1-git-send-email-lijiazi@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a potential race between fuse_read_interrupt and
fuse_dev_do_write contexts as shown below:

TASK1:
fuse_dev_do_write:
                               TASK2:
                               fuse_dev_do_read:
				 spin_lock(&fiq->lock);
				 fuse_read_interrupt();
				   list_del_init(&req->intr_entry);
  fuse_request_end()//now req->intr_entry
	            //is empty so put this req
TASK3:
fuse_flash:
  fuse_simple_request();
  fuse_put_request();
  kmem_cache_free();//free req

After TASK3 free req, TASK2 access this req in fuse_read_interrupt
and gets below crash:
==================================================================
[   63.712079] BUG: KASAN: use-after-free in
fuse_read_interrupt+0x18c/0x948
[   63.712084] Read of size 8 at addr ffffff8049797d50 by task
Thread-5/5508
[   63.712093] CPU: 4 PID: 5508 Comm: Thread-5 Tainted: G S         O
5.4.86-qgki-debug-ge1de60c2024c #1
[   63.712096] Call trace:
[   63.712100]  dump_backtrace+0x0/0x2cc
[   63.712102]  show_stack+0x18/0x24
[   63.712106]  dump_stack+0x134/0x1c4
[   63.712109]  print_address_description+0x88/0x578
[   63.712111]  __kasan_report+0x1c4/0x1e0
[   63.712113]  kasan_report+0x14/0x20
[   63.712115]  __asan_report_load8_noabort+0x1c/0x28
[   63.712117]  fuse_read_interrupt+0x18c/0x948
[   63.712119]  fuse_dev_do_read+0x678/0x11a0
[   63.712121]  fuse_dev_read+0x108/0x17c
[   63.712124]  __vfs_read+0x408/0x544
[   63.712126]  vfs_read+0x114/0x2a8
[   63.712127]  ksys_read+0xd8/0x18c
[   63.712129]  __arm64_sys_read+0x78/0x8c
[   63.712132]  el0_svc_common+0x134/0x2cc
[   63.712134]  el0_svc_handler+0xd0/0xe0
[   63.712136]  el0_svc+0x8/0xc
[   63.712137]
[   63.712141] Allocated by task 5535:
[   63.712146]  __kasan_kmalloc+0x100/0x1c0
[   63.712148]  kasan_slab_alloc+0x18/0x24
[   63.712150]  kmem_cache_alloc+0x320/0x3c4
[   63.712152]  fuse_get_req+0x1f0/0x6a4
[   63.712154]  fuse_simple_request+0x5c/0xb90
[   63.712156]  fuse_flush_times+0x340/0x474
[   63.712158]  fuse_write_inode+0x90/0xc4
[   63.712160]  write_inode+0x1ec/0x478
[   63.712162]  __writeback_single_inode+0x420/0x838
[   63.712165]  writeback_single_inode+0x128/0x708
[   63.712167]  write_inode_now+0x2b0/0x370
[   63.712169]  fuse_release+0x9c/0x100
[   63.712171]  __fput+0x18c/0x4a8
[   63.712173]  ____fput+0x10/0x1c
[   63.712176]  task_work_run+0x118/0x1ec
[   63.712178]  do_exit+0x500/0x1810
[   63.712179]  do_group_exit+0x1c8/0x200
[   63.712182]  get_signal+0xc44/0x1194
[   63.712183]  do_signal+0x134/0x464
[   63.712185]  do_notify_resume+0x110/0x1c4
[   63.712187]  work_pending+0x8/0x14
[   63.712188]
[   63.712191] Freed by task 5535:
[   63.712194]  __kasan_slab_free+0x168/0x238
[   63.712196]  kasan_slab_free+0x14/0x24
[   63.712198]  slab_free_freelist_hook+0xe0/0x164
[   63.712201]  kmem_cache_free+0xfc/0x358
[   63.712202]  fuse_put_request+0x148/0x1a4
[   63.712204]  fuse_simple_request+0x810/0xb90
[   63.712206]  fuse_flush_times+0x340/0x474
[   63.712208]  fuse_write_inode+0x90/0xc4
[   63.712210]  write_inode+0x1ec/0x478
[   63.712212]  __writeback_single_inode+0x420/0x838
[   63.712214]  writeback_single_inode+0x128/0x708
[   63.712217]  write_inode_now+0x2b0/0x370
[   63.712219]  fuse_release+0x9c/0x100
[   63.712221]  __fput+0x18c/0x4a8
[   63.712222]  ____fput+0x10/0x1c
[   63.712224]  task_work_run+0x118/0x1ec
[   63.712226]  do_exit+0x500/0x1810
[   63.712228]  do_group_exit+0x1c8/0x200
[   63.712229]  get_signal+0xc44/0x1194
[   63.712231]  do_signal+0x134/0x464
[   63.712233]  do_notify_resume+0x110/0x1c4
[   63.712235]  work_pending+0x8/0x14

Put list_del_init after the code access req, if intr_entry not
empty, fuse_request_end will wait for fiq->lock, req will not
free before TASK2 unlock fiq->lock.

Signed-off-by: lijiazi <lijiazi@xiaomi.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 817a0b1..bef21b2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1045,13 +1045,13 @@ __releases(fiq->lock)
 	unsigned reqsize = sizeof(ih) + sizeof(arg);
 	int err;
 
-	list_del_init(&req->intr_entry);
 	memset(&ih, 0, sizeof(ih));
 	memset(&arg, 0, sizeof(arg));
 	ih.len = reqsize;
 	ih.opcode = FUSE_INTERRUPT;
 	ih.unique = (req->in.h.unique | FUSE_INT_REQ_BIT);
 	arg.unique = req->in.h.unique;
+	list_del_init(&req->intr_entry);
 
 	spin_unlock(&fiq->lock);
 	if (nbytes < reqsize)
-- 
2.7.4

