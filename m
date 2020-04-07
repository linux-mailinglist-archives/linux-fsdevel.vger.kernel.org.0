Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADD1A0FC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgDGPAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 11:00:07 -0400
Received: from mail1.windriver.com ([147.11.146.13]:37056 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgDGPAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:00:07 -0400
X-Greylist: delayed 14387 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 11:00:00 EDT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 037AxtZZ011133
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Apr 2020 03:59:55 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 03:59:54 -0700
From:   <zhe.he@windriver.com>
To:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>, <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 1/2] eventfd: Make wake counter work for single fd instead of all
Date:   Tue, 7 Apr 2020 18:59:51 +0800
Message-ID: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
introduces a percpu counter that tracks the percpu recursion depth and
warn if it greater than one, to avoid potential deadlock and stack
overflow.

However sometimes different eventfds may be used in parallel.
Specifically, when high network load goes through kvm and vhost, working
as below, it would trigger the following call trace.

-  100.00%
   - 66.51%
        ret_from_fork
        kthread
      - vhost_worker
         - 33.47% handle_tx_kick
              handle_tx
              handle_tx_copy
              vhost_tx_batch.isra.0
              vhost_add_used_and_signal_n
              eventfd_signal
         - 33.05% handle_rx_net
              handle_rx
              vhost_add_used_and_signal_n
              eventfd_signal
   - 33.49%
        ioctl
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        __x64_sys_ioctl
        ksys_ioctl
        do_vfs_ioctl
        kvm_vcpu_ioctl
        kvm_arch_vcpu_ioctl_run
        vmx_handle_exit
        handle_ept_misconfig
        kvm_io_bus_write
        __kvm_io_bus_write
        eventfd_signal

001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
---- snip ----
001: Call Trace:
001:  vhost_signal+0x15e/0x1b0 [vhost]
001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
001:  handle_rx+0xb9/0x900 [vhost_net]
001:  handle_rx_net+0x15/0x20 [vhost_net]
001:  vhost_worker+0xbe/0x120 [vhost]
001:  kthread+0x106/0x140
001:  ? log_used.part.0+0x20/0x20 [vhost]
001:  ? kthread_park+0x90/0x90
001:  ret_from_fork+0x35/0x40
001: ---[ end trace 0000000000000003 ]---

This patch moves the percpu counter into eventfd control structure and
does the clean-ups, so that eventfd can still be protected from deadlock
while allowing different ones to work in parallel.

As to potential stack overflow, we might want to figure out a better
solution in the future to warn when the stack is about to overflow so it
can be better utilized, rather than break the working flow when just the
second one comes.

Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Having searched the lkml, I didn't find the discussion of the aio use case
commit b5e683d5cab8 was added for, so I didn't validate this patch against
it.

 fs/eventfd.c            | 31 +++++++++----------------------
 include/linux/eventfd.h | 24 +++++++++++++++++++-----
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7..bb4385a 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -24,26 +24,8 @@
 #include <linux/seq_file.h>
 #include <linux/idr.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
-struct eventfd_ctx {
-	struct kref kref;
-	wait_queue_head_t wqh;
-	/*
-	 * Every time that a write(2) is performed on an eventfd, the
-	 * value of the __u64 being written is added to "count" and a
-	 * wakeup is performed on "wqh". A read(2) will return the "count"
-	 * value to userspace, and will reset "count" to zero. The kernel
-	 * side eventfd_signal() also, adds to the "count" counter and
-	 * issue a wakeup.
-	 */
-	__u64 count;
-	unsigned int flags;
-	int id;
-};
-
 /**
  * eventfd_signal - Adds @n to the eventfd counter.
  * @ctx: [in] Pointer to the eventfd context.
@@ -70,17 +52,17 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(*ctx->wake_count)))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	this_cpu_inc(*ctx->wake_count);
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	this_cpu_dec(*ctx->wake_count);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
@@ -406,7 +388,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
-	int fd;
+	int fd, cpu;
 
 	/* Check the EFD_* constants for consistency.  */
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
@@ -424,6 +406,11 @@ static int do_eventfd(unsigned int count, int flags)
 	ctx->count = count;
 	ctx->flags = flags;
 	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+	ctx->wake_count = alloc_percpu(typeof(*ctx->wake_count));
+	if (!ctx->wake_count)
+		return -ENOMEM;
+	for_each_possible_cpu(cpu)
+		*per_cpu_ptr(ctx->wake_count, cpu) = 0;
 
 	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a..b0d0f44 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,7 +29,23 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
-struct eventfd_ctx;
+struct eventfd_ctx {
+	struct kref kref;
+	wait_queue_head_t wqh;
+	/*
+	 * Every time that a write(2) is performed on an eventfd, the
+	 * value of the __u64 being written is added to "count" and a
+	 * wakeup is performed on "wqh". A read(2) will return the "count"
+	 * value to userspace, and will reset "count" to zero. The kernel
+	 * side eventfd_signal() also, adds to the "count" counter and
+	 * issue a wakeup.
+	 */
+	__u64 count;
+	unsigned int flags;
+	int id;
+	int __percpu *wake_count;
+};
+
 struct file;
 
 #ifdef CONFIG_EVENTFD
@@ -42,11 +58,9 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_count(struct eventfd_ctx *ctx)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return this_cpu_read(*ctx->wake_count);
 }
 
 #else /* CONFIG_EVENTFD */
-- 
2.7.4

