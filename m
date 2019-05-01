Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8310A71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEAP7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:59:22 -0400
Received: from foss.arm.com ([217.140.101.70]:33168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfEAP7V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:59:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B036A78;
        Wed,  1 May 2019 08:59:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF8813F71A;
        Wed,  1 May 2019 08:59:19 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCHv2] io_uring: avoid page allocation warnings
Date:   Wed,  1 May 2019 16:59:16 +0100
Message-Id: <20190501155916.34008-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In io_sqe_buffer_register() we allocate a number of arrays based on the
iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
we can still attempt to allocate arrays exceeding MAX_ORDER.

On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
bytes, which is greater than 4MiB. This results in SLUB warning that
we're trying to allocate greater than MAX_ORDER, and failing the
allocation.

Avoid this by using kvmalloc() for allocations dependent on the
user-provided iov_len. At the same time, fix a leak of imu->bvec when
registration fails.

Full splat from before this patch:

WARNING: CPU: 1 PID: 2314 at mm/page_alloc.c:4595 __alloc_pages_nodemask+0x7ac/0x2938 mm/page_alloc.c:4595
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2314 Comm: syz-executor326 Not tainted 5.1.0-rc7-dirty #4
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
 __alloc_pages_nodemask+0x7ac/0x2938 mm/page_alloc.c:4595
 alloc_pages_current+0x164/0x278 mm/mempolicy.c:2132
 alloc_pages include/linux/gfp.h:509 [inline]
 kmalloc_order+0x20/0x50 mm/slab_common.c:1231
 kmalloc_order_trace+0x30/0x2b0 mm/slab_common.c:1243
 kmalloc_large include/linux/slab.h:480 [inline]
 __kmalloc+0x3dc/0x4f0 mm/slub.c:3791
 kmalloc_array include/linux/slab.h:670 [inline]
 io_sqe_buffer_register fs/io_uring.c:2472 [inline]
 __io_uring_register fs/io_uring.c:2962 [inline]
 __do_sys_io_uring_register fs/io_uring.c:3008 [inline]
 __se_sys_io_uring_register fs/io_uring.c:2990 [inline]
 __arm64_sys_io_uring_register+0x9e0/0x1bc8 fs/io_uring.c:2990
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

Fixes: edafccee56ff3167 ("io_uring: add support for pre-mapped user IO buffers")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/io_uring.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

Since v1:
* Use kvmalloc/kvfree
* Free imu->bvec in case of error (per Jens)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 578b5494f9e5..c6a22c2ae58f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2364,7 +2364,7 @@ static int io_sqe_buffer_unregister(struct io_ring_ctx *ctx)
 
 		if (ctx->account_mem)
 			io_unaccount_mem(ctx->user, imu->nr_bvecs);
-		kfree(imu->bvec);
+		kvfree(imu->bvec);
 		imu->nr_bvecs = 0;
 	}
 
@@ -2456,9 +2456,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		if (!pages || nr_pages > got_pages) {
 			kfree(vmas);
 			kfree(pages);
-			pages = kmalloc_array(nr_pages, sizeof(struct page *),
+			pages = kvmalloc_array(nr_pages, sizeof(struct page *),
 						GFP_KERNEL);
-			vmas = kmalloc_array(nr_pages,
+			vmas = kvmalloc_array(nr_pages,
 					sizeof(struct vm_area_struct *),
 					GFP_KERNEL);
 			if (!pages || !vmas) {
@@ -2470,7 +2470,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			got_pages = nr_pages;
 		}
 
-		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+		imu->bvec = kvmalloc_array(nr_pages, sizeof(struct bio_vec),
 						GFP_KERNEL);
 		ret = -ENOMEM;
 		if (!imu->bvec) {
@@ -2509,6 +2509,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 			if (ctx->account_mem)
 				io_unaccount_mem(ctx->user, nr_pages);
+			kvfree(imu->bvec);
 			goto err;
 		}
 
@@ -2531,12 +2532,12 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 		ctx->nr_user_bufs++;
 	}
-	kfree(pages);
-	kfree(vmas);
+	kvfree(pages);
+	kvfree(vmas);
 	return 0;
 err:
-	kfree(pages);
-	kfree(vmas);
+	kvfree(pages);
+	kvfree(vmas);
 	io_sqe_buffer_unregister(ctx);
 	return ret;
 }
-- 
2.11.0

