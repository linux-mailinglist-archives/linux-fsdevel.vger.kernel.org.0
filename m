Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC1539B4F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFDIjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 04:39:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4472 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDIjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:39:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxGKj5M23zZcQQ;
        Fri,  4 Jun 2021 16:35:05 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:37:51 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 16:37:51 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <jack@suse.cz>, <tytso@mit.edu>, <osalvador@suse.de>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2] mm/memory-failure: make sure wait for page writeback in memory_failure
Date:   Fri, 4 Jun 2021 16:47:05 +0800
Message-ID: <20210604084705.3729204-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Our syzkaller trigger the "BUG_ON(!list_empty(&inode->i_wb_list))" in
clear_inode:

[  292.016156] ------------[ cut here ]------------
[  292.017144] kernel BUG at fs/inode.c:519!
[  292.017860] Internal error: Oops - BUG: 0 [#1] SMP
[  292.018741] Dumping ftrace buffer:
[  292.019577]    (ftrace buffer empty)
[  292.020430] Modules linked in:
[  292.021748] Process syz-executor.0 (pid: 249, stack limit =
0x00000000a12409d7)
[  292.023719] CPU: 1 PID: 249 Comm: syz-executor.0 Not tainted 4.19.95
[  292.025206] Hardware name: linux,dummy-virt (DT)
[  292.026176] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  292.027244] pc : clear_inode+0x280/0x2a8
[  292.028045] lr : clear_inode+0x280/0x2a8
[  292.028877] sp : ffff8003366c7950
[  292.029582] x29: ffff8003366c7950 x28: 0000000000000000
[  292.030570] x27: ffff80032b5f4708 x26: ffff80032b5f4678
[  292.031863] x25: ffff80036ae6b300 x24: ffff8003689254d0
[  292.032902] x23: ffff80036ae69d80 x22: 0000000000033cc8
[  292.033928] x21: 0000000000000000 x20: ffff80032b5f47a0
[  292.034941] x19: ffff80032b5f4678 x18: 0000000000000000
[  292.035958] x17: 0000000000000000 x16: 0000000000000000
[  292.037102] x15: 0000000000000000 x14: 0000000000000000
[  292.038103] x13: 0000000000000004 x12: 0000000000000000
[  292.039137] x11: 1ffff00066cd8f52 x10: 1ffff00066cd8ec8
[  292.040216] x9 : dfff200000000000 x8 : ffff10006ac1e86a
[  292.041432] x7 : dfff200000000000 x6 : ffff100066cd8f1e
[  292.042516] x5 : dfff200000000000 x4 : ffff80032b5f47a0
[  292.043525] x3 : ffff200008000000 x2 : ffff200009867000
[  292.044560] x1 : ffff8003366bb000 x0 : 0000000000000000
[  292.045569] Call trace:
[  292.046083]  clear_inode+0x280/0x2a8
[  292.046828]  ext4_clear_inode+0x38/0xe8
[  292.047593]  ext4_free_inode+0x130/0xc68
[  292.048383]  ext4_evict_inode+0xb20/0xcb8
[  292.049162]  evict+0x1a8/0x3c0
[  292.049761]  iput+0x344/0x460
[  292.050350]  do_unlinkat+0x260/0x410
[  292.051042]  __arm64_sys_unlinkat+0x6c/0xc0
[  292.051846]  el0_svc_common+0xdc/0x3b0
[  292.052570]  el0_svc_handler+0xf8/0x160
[  292.053303]  el0_svc+0x10/0x218
[  292.053908] Code: 9413f4a9 d503201f f90017b6 97f4d5b1 (d4210000)
[  292.055471] ---[ end trace 01b339dd07795f8d ]---
[  292.056443] Kernel panic - not syncing: Fatal exception
[  292.057488] SMP: stopping secondary CPUs
[  292.058419] Dumping ftrace buffer:
[  292.059078]    (ftrace buffer empty)
[  292.059756] Kernel Offset: disabled
[  292.060443] CPU features: 0x10,a1006000
[  292.061195] Memory Limit: none
[  292.061794] Rebooting in 86400 seconds..

Crash of this problem show that someone call __munlock_pagevec to clear
page LRU without lock_page.

 #0 [ffff80035f02f4c0] __switch_to at ffff20000808d020
 #1 [ffff80035f02f4f0] __schedule at ffff20000985102c
 #2 [ffff80035f02f5e0] schedule at ffff200009851d1c
 #3 [ffff80035f02f600] io_schedule at ffff2000098525c0
 #4 [ffff80035f02f620] __lock_page at ffff20000842d2d4
 #5 [ffff80035f02f710] __munlock_pagevec at ffff2000084c4600
 #6 [ffff80035f02f870] munlock_vma_pages_range at ffff2000084c5928
 #7 [ffff80035f02fa60] do_munmap at ffff2000084cbdf4
 #8 [ffff80035f02faf0] mmap_region at ffff2000084ce20c
 #9 [ffff80035f02fb90] do_mmap at ffff2000084cf018

So memory_failure will call identify_page_state without
wait_on_page_writeback. And after truncate_error_page clear the
mapping of this page. end_page_writeback won't call
sb_clear_inode_writeback to clear inode->i_wb_list. That will trigger
BUG_ON in clear_inode!

Fix it by check PageWriteback too to help determine should we can skip
wait_on_page_writeback.

Fixes: 0bc1f8b0682c ("hwpoison: fix the handling path of the victimized page frame that belong to non-LRU")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 mm/memory-failure.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..61368b46bd67 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1527,7 +1527,12 @@ int memory_failure(unsigned long pfn, int flags)
 		return 0;
 	}
 
-	if (!PageTransTail(p) && !PageLRU(p))
+	/*
+	 * __munlock_pagevec may clear a writeback page's LRU flag without
+	 * page_lock. We need wait writeback completion for this page or it
+	 * may trigger vfs BUG while evict inode.
+	 */
+	if (!PageTransTail(p) && !PageLRU(p) && !PageWriteback(p))
 		goto identify_page_state;
 
 	/*
-- 
2.31.1

