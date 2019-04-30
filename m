Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26209F8F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 14:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfD3Me7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 08:34:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfD3Me7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:34:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953F080D;
        Tue, 30 Apr 2019 05:34:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4BDD63F5AF;
        Tue, 30 Apr 2019 05:34:57 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] io_uring: fix SQPOLL cpu validation
Date:   Tue, 30 Apr 2019 13:34:51 +0100
Message-Id: <20190430123451.44227-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In io_sq_offload_start(), we call cpu_possible() on an unbounded cpu
value from userspace. On v5.1-rc7 on arm64 with
CONFIG_DEBUG_PER_CPU_MAPS, this results in a splat:

  WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]

There was an attempt to fix this in commit:

  917257daa0fea7a0 ("io_uring: only test SQPOLL cpu after we've verified it")

... by adding a check after the cpu value had been limited to NR_CPU_IDS
using array_index_nospec(). However, this left an unbound check at the
start of the function, for which the warning still fires.

Let's fix this correctly by checking that the cpu value is bound by
nr_cpu_ids before passing it to cpu_possible(). Note that only
nr_cpu_ids of a cpumask are guaranteed to exist at runtime, and
nr_cpu_ids can be significantly smaller than NR_CPUs. For example, an
arm64 defconfig has NR_CPUS=256, while my test VM has 4 vCPUs.

Following the intent from the commit message for 917257daa0fea7a0, the
check is moved under the SQ_AFF branch, which is the only branch where
the cpu values is consumed. The check is performed before bounding the
value with array_index_nospec() so that we don't silently accept bogus
cpu values from userspace, where array_index_nospec() would force these
values to 0.

I suspect we can remove the array_index_nospec() call entirely, but I've
conservatively left that in place, updated to use nr_cpu_ids to match
the prior check.

Tested on arm64 with the Syzkaller reproducer:

  https://syzkaller.appspot.com/bug?extid=cd714a07c6de2bc34293
  https://syzkaller.appspot.com/x/repro.syz?x=15d8b397200000

Full splat from before this patch:

WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_check include/linux/cpumask.h:128 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_sq_offload_start fs/io_uring.c:2244 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_create fs/io_uring.c:2864 [inline]
WARNING: CPU: 1 PID: 27601 at include/linux/cpumask.h:121 io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 27601 Comm: syz-executor.0 Not tainted 5.1.0-rc7 #3
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x2f0 include/linux/compiler.h:193
 show_stack+0x20/0x30 arch/arm64/kernel/traps.c:158
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x110/0x190 lib/dump_stack.c:113
 panic+0x384/0x68c kernel/panic.c:214
 __warn+0x2bc/0x2c0 kernel/panic.c:571
 report_bug+0x228/0x2d8 lib/bug.c:186
 bug_handler+0xa0/0x1a0 arch/arm64/kernel/traps.c:956
 call_break_hook arch/arm64/kernel/debug-monitors.c:301 [inline]
 brk_handler+0x1d4/0x388 arch/arm64/kernel/debug-monitors.c:316
 do_debug_exception+0x1a0/0x468 arch/arm64/mm/fault.c:831
 el1_dbg+0x18/0x8c
 cpu_max_bits_warn include/linux/cpumask.h:121 [inline]
 cpumask_check include/linux/cpumask.h:128 [inline]
 cpumask_test_cpu include/linux/cpumask.h:344 [inline]
 io_sq_offload_start fs/io_uring.c:2244 [inline]
 io_uring_create fs/io_uring.c:2864 [inline]
 io_uring_setup+0x1108/0x15a0 fs/io_uring.c:2916
 __do_sys_io_uring_setup fs/io_uring.c:2929 [inline]
 __se_sys_io_uring_setup fs/io_uring.c:2926 [inline]
 __arm64_sys_io_uring_setup+0x50/0x70 fs/io_uring.c:2926
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:47 [inline]
 el0_svc_common.constprop.0+0x148/0x2e0 arch/arm64/kernel/syscall.c:83
 el0_svc_handler+0xdc/0x100 arch/arm64/kernel/syscall.c:129
 el0_svc+0x8/0xc arch/arm64/kernel/entry.S:948
SMP: stopping secondary CPUs
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
CPU features: 0x002,23000438
Memory Limit: none
Rebooting in 1 seconds..

Fixes: 917257daa0fea7a0 ("io_uring: only test SQPOLL cpu after we've verified it")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/io_uring.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e9fb2cb1984..48fa6e86bfd6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2240,10 +2240,6 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	mmgrab(current->mm);
 	ctx->sqo_mm = current->mm;
 
-	ret = -EINVAL;
-	if (!cpu_possible(p->sq_thread_cpu))
-		goto err;
-
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
@@ -2254,13 +2250,14 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			ctx->sq_thread_idle = HZ;
 
 		if (p->flags & IORING_SETUP_SQ_AFF) {
-			int cpu;
+			int cpu = p->sq_thread_cpu;
 
-			cpu = array_index_nospec(p->sq_thread_cpu, NR_CPUS);
 			ret = -EINVAL;
-			if (!cpu_possible(p->sq_thread_cpu))
+			if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
 				goto err;
 
+			cpu = array_index_nospec(cpu, nr_cpu_ids);
+
 			ctx->sqo_thread = kthread_create_on_cpu(io_sq_thread,
 							ctx, cpu,
 							"io_uring-sq");
-- 
2.11.0

