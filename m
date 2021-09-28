Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA841B52C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbhI1Rf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:35:58 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41359 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242104AbhI1Rfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:35:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Upy3nXM_1632850446;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0Upy3nXM_1632850446)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 01:34:12 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/fs-writeback.c: add a preemption point to move_expired_inodes
Date:   Wed, 29 Sep 2021 01:34:04 +0800
Message-Id: <20210928173404.10794-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We encountered an unrecovered_softlockup issue on !PREEMPT
kernel config with 4.9 based kernel.

PID: 185895  TASK: ffff880455dac280  CPU: 8   COMMAND: "kworker/u449:39"
 #0 [ffff883f7e803c08] machine_kexec at ffffffff81061578
 #1 [ffff883f7e803c68] __crash_kexec at ffffffff81127c19
 #2 [ffff883f7e803d30] panic at ffffffff811b2255
 #3 [ffff883f7e803db8] unrecovered_softlockup_detect at ffffffff811b2d57
 #4 [ffff883f7e803ee0] watchdog_timer_fn at ffffffff8115827e
 #5 [ffff883f7e803f18] __hrtimer_run_queues at ffffffff811085e3
 #6 [ffff883f7e803f70] hrtimer_interrupt at ffffffff81108d8a
 #7 [ffff883f7e803fc0] local_apic_timer_interrupt at ffffffff810580f8
 #8 [ffff883f7e803fd8] smp_apic_timer_interrupt at ffffffff81745405
 #9 [ffff883f7e803ff0] apic_timer_interrupt at ffffffff81743b90
 --- <IRQ stack> ---
 #10 [ffffc90086a93b88] apic_timer_interrupt at ffffffff81743b90
    [exception RIP: __list_del_entry+44]
    RIP: ffffffff813be22c  RSP: ffffc90086a93c30  RFLAGS: 00000202
    RAX: ffff88522b8f8418  RBX: ffff88522b8f8418  RCX: dead000000000200
    RDX: ffff8816fab00e68  RSI: ffffc90086a93c60  RDI: ffff8816fab01af8
    RBP: ffffc90086a93c30   R8: ffff8816fab01af8   R9: 0000000100400018
    R10: ffff885ae5ed8280  R11: 0000000000000000  R12: ffff8816fab01af8
    R13: ffffc90086a93c60  R14: ffffc90086a93d08  R15: ffff883f631d2000
    ORIG_RAX: ffffffffffffff10  CS: 0010  SS: 0000
 #11 [ffffc90086a93c38] move_expired_inodes at ffffffff8127c74c
 #12 [ffffc90086a93ca8] queue_io at ffffffff8127cde6
 #13 [ffffc90086a93cd8] wb_writeback at ffffffff8128121f
 #14 [ffffc90086a93d80] wb_workfn at ffffffff812819f4
 #15 [ffffc90086a93e18] process_one_work at ffffffff810a5dc9
 #16 [ffffc90086a93e60] worker_thread at ffffffff810a60ae
 #17 [ffffc90086a93ec0] kthread at ffffffff810ac696
 #18 [ffffc90086a93f50] ret_from_fork at ffffffff81741dd9

crash> set
    PID: 185895
COMMAND: "kworker/u449:39"
   TASK: ffff880455dac280  [THREAD_INFO: ffff880455dac280]
    CPU: 8
  STATE: TASK_RUNNING (PANIC)

It has been running continuously for 53.052, as follows:
crash> ps -m | grep 185895
[  0 00:00:53.052] [RU]  PID: 185895  TASK: ffff880455dac280  CPU: 8
COMMAND: "kworker/u449:39"

And the TIF_NEED_RESCHED flag has been set, as follows:
crash> struct thread_info -x ffff880455dac280
struct thread_info {
  flags = 0x88,
  status = 0x0
}

Let's just add cond_resched() within move_expired_inodes()'s list-moving loop in
order to avoid the watchdog splats.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 06d04a7..1546121 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1404,6 +1404,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		if (sb && sb != inode->i_sb)
 			do_sb_sort = 1;
 		sb = inode->i_sb;
+		cond_resched();
 	}
 
 	/* just one sb in list, splice to dispatch_queue and we're done */
@@ -1420,6 +1421,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 			if (inode->i_sb == sb)
 				list_move(&inode->i_io_list, dispatch_queue);
 		}
+		cond_resched();
 	}
 out:
 	return moved;
-- 
1.8.3.1

