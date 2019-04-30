Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2402F9D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfD3NYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 09:24:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47040 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfD3NYP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE63780D;
        Tue, 30 Apr 2019 06:24:14 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D3BA3F5AF;
        Tue, 30 Apr 2019 06:24:13 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] io_uring: avoid page allocation warnings
Date:   Tue, 30 Apr 2019 14:24:05 +0100
Message-Id: <20190430132405.8268-1-mark.rutland@arm.com>
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

Avoid this by passing __GFP_NOWARN when allocating arrays for the
user-provided iov_len. We'll gracefully handle the failed allocation,
returning -ENOMEM to userspace.

We should probably consider lowering the limit below SZ_1G, or reworking
the array allocations.

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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 48fa6e86bfd6..25fc8cb56fc5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2453,10 +2453,10 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			kfree(vmas);
 			kfree(pages);
 			pages = kmalloc_array(nr_pages, sizeof(struct page *),
-						GFP_KERNEL);
+						GFP_KERNEL | __GFP_NOWARN);
 			vmas = kmalloc_array(nr_pages,
 					sizeof(struct vm_area_struct *),
-					GFP_KERNEL);
+					GFP_KERNEL | __GFP_NOWARN);
 			if (!pages || !vmas) {
 				ret = -ENOMEM;
 				if (ctx->account_mem)
@@ -2467,7 +2467,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		}
 
 		imu->bvec = kmalloc_array(nr_pages, sizeof(struct bio_vec),
-						GFP_KERNEL);
+						GFP_KERNEL | __GFP_NOWARN);
 		ret = -ENOMEM;
 		if (!imu->bvec) {
 			if (ctx->account_mem)
-- 
2.11.0

