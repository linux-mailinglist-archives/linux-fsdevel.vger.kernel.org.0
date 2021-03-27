Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEC34B4A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 07:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhC0Gge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 02:36:34 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:16710 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhC0GgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 02:36:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTRdtN0_1616826972;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UTRdtN0_1616826972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 27 Mar 2021 14:36:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     miklos@szeredi.hu
Cc:     tao.peng@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back dirty pages
Date:   Sat, 27 Mar 2021 14:36:05 +0800
Message-Id: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can meet below deadlock scenario when writing back dirty pages, and
writing files at the same time. The deadlock scenario can be reproduced
by:

- A writeback worker thread A is trying to write a bunch of dirty pages by
fuse_writepages(), and the fuse_writepages() will lock one page (named page 1),
add it into rb_tree with setting writeback flag, and unlock this page 1,
then try to lock next page (named page 2).

- But at the same time a file writing can be triggered by another process B,
to write several pages by fuse_perform_write(), the fuse_perform_write()
will lock all required pages firstly, then wait for all writeback pages
are completed by fuse_wait_on_page_writeback().

- Now the process B can already lock page 1 and page 2, and wait for page 1
waritehack is completed (page 1 is under writeback set by process A). But
process A can not complete the writeback of page 1, since it is still
waiting for locking page 2, which was locked by process B already.

A deadlock is occurred.

To fix this issue, we should make sure each page writeback is completed
after lock the page in fuse_fill_write_pages() separately, and then write
them together when all pages are stable.

[1450578.772896] INFO: task kworker/u259:6:119885 blocked for more than 120 seconds.
[1450578.796179] kworker/u259:6  D    0 119885      2 0x00000028
[1450578.796185] Workqueue: writeback wb_workfn (flush-0:78)
[1450578.796188] Call trace:
[1450578.798804]  __switch_to+0xd8/0x148
[1450578.802458]  __schedule+0x280/0x6a0
[1450578.806112]  schedule+0x34/0xe8
[1450578.809413]  io_schedule+0x20/0x40
[1450578.812977]  __lock_page+0x164/0x278
[1450578.816718]  write_cache_pages+0x2b0/0x4a8
[1450578.820986]  fuse_writepages+0x84/0x100 [fuse]
[1450578.825592]  do_writepages+0x58/0x108
[1450578.829412]  __writeback_single_inode+0x48/0x448
[1450578.834217]  writeback_sb_inodes+0x220/0x520
[1450578.838647]  __writeback_inodes_wb+0x50/0xe8
[1450578.843080]  wb_writeback+0x294/0x3b8
[1450578.846906]  wb_do_writeback+0x2ec/0x388
[1450578.850992]  wb_workfn+0x80/0x1e0
[1450578.854472]  process_one_work+0x1bc/0x3f0
[1450578.858645]  worker_thread+0x164/0x468
[1450578.862559]  kthread+0x108/0x138
[1450578.865960] INFO: task doio:207752 blocked for more than 120 seconds.
[1450578.888321] doio            D    0 207752 207740 0x00000000
[1450578.888329] Call trace:
[1450578.890945]  __switch_to+0xd8/0x148
[1450578.894599]  __schedule+0x280/0x6a0
[1450578.898255]  schedule+0x34/0xe8
[1450578.901568]  fuse_wait_on_page_writeback+0x8c/0xc8 [fuse]
[1450578.907128]  fuse_perform_write+0x240/0x4e0 [fuse]
[1450578.912082]  fuse_file_write_iter+0x1dc/0x290 [fuse]
[1450578.917207]  do_iter_readv_writev+0x110/0x188
[1450578.921724]  do_iter_write+0x90/0x1c8
[1450578.925598]  vfs_writev+0x84/0xf8
[1450578.929071]  do_writev+0x70/0x110
[1450578.932552]  __arm64_sys_writev+0x24/0x30
[1450578.936727]  el0_svc_common.constprop.0+0x80/0x1f8
[1450578.941694]  el0_svc_handler+0x30/0x80
[1450578.945606]  el0_svc+0x10/0x14

Suggested-by: Peng Tao <tao.peng@linux.alibaba.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Use fuse_wait_on_page_writeback() instead to wait for page stable.
---
 fs/fuse/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb..9a30093 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1101,9 +1101,6 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	unsigned int offset, i;
 	int err;
 
-	for (i = 0; i < ap->num_pages; i++)
-		fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
-
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
 	if (fm->fc->handle_killpriv_v2 && !capable(CAP_FSETID))
@@ -1140,6 +1137,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_args_pages *ap,
 				     unsigned int max_pages)
 {
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
+	struct inode *inode = mapping->host;
 	unsigned offset = pos & (PAGE_SIZE - 1);
 	size_t count = 0;
 	int err;
@@ -1166,6 +1164,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_args_pages *ap,
 		if (!page)
 			break;
 
+		fuse_wait_on_page_writeback(inode, page->index);
+
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-- 
1.8.3.1

