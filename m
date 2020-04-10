Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DD41A45DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 13:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDJLra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 07:47:30 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62512 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJLra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:47:30 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 03ABlNfQ000030
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 10 Apr 2020 04:47:23 -0700 (PDT)
Received: from pek-lpg-core3.wrs.com (128.224.153.232) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Apr 2020 04:47:22 -0700
From:   <zhe.he@windriver.com>
To:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Date:   Fri, 10 Apr 2020 19:47:20 +0800
Message-ID: <20200410114720.24838-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
introduces a percpu counter that tracks the percpu recursion depth and
warn if it greater than zero, to avoid potential deadlock and stack
overflow.

However sometimes different eventfds may be used in parallel. Specifically,
when heavy network load goes through kvm and vhost, working as below, it
would trigger the following call trace.

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

This patch enlarges the limit to 1 which is the maximum recursion depth we
have found so far.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/eventfd.c            | 3 ++-
 include/linux/eventfd.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..8b9bd6fb08cd 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -70,7 +70,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
 	 * it returns true, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
+	    EFD_WAKE_COUNT_MAX))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index dc4fd8a6644d..e7684d768e3f 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -29,6 +29,9 @@
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
 
+/* This is the maximum recursion depth we find so far */
+#define EFD_WAKE_COUNT_MAX 1
+
 struct eventfd_ctx;
 struct file;
 
-- 
2.17.1

