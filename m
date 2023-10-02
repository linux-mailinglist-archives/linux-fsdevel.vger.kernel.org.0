Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA07B4D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjJBIZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 04:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:25:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9308C6;
        Mon,  2 Oct 2023 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696235140; x=1727771140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LjUA0WnZOwfBZbOsPWOE8rX33xk0uzpE44wPBaNDwPc=;
  b=n2cUg4hc3KB3pgqa/MSXJL/Bc6rC5qwHF7mRWyK/6w+HgEc+pwd0dIU9
   /VZFQjBuGgf2OSrWjLzyY4duz4s2+dM6GMbLeoNR9skiXOvfSRRXOtQLR
   DLQhX4gTEz/S67Ltp60HJKeP5DTMfQDqBoYuMl+c5S04wAfULGlwzhCcT
   /WLK8KGOjRxkJXJtSxOFXn5aufagqVJRe+EhtVbphxZIbR5rgeXcxOryb
   DjiJfgQZniC7+GGuBo4hhO4NaqDbbxaVYh1GvKkl7qW93NiugQjnydWdW
   LIjM+FGvIICMPIgJUKZ8CMHVRDdyHgG85ASElkoIFJi+QlrsZ/O4Kz+oL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="468881032"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="468881032"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="874286167"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="874286167"
Received: from joe-255.igk.intel.com (HELO localhost) ([10.91.220.57])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:25:37 -0700
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH] XArray: Make xa_lock_init macro 
Date:   Mon,  2 Oct 2023 10:25:35 +0200
Message-Id: <20231002082535.1516405-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make xa_init_flags() macro to avoid false positive lockdep splats.

When spin_lock_init() is used inside initialization function (like
in xa_init_flags()) which can be called many times, lockdep assign
the same key to different locks.

For example this splat is seen with intel_vpu driver which uses
two xarrays and has two separate xa_init_flags() calls:

[ 1139.148679] WARNING: inconsistent lock state
[ 1139.152941] 6.6.0-hardening.1+ #2 Tainted: G           OE
[ 1139.158758] --------------------------------
[ 1139.163024] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[ 1139.169018] kworker/10:1/109 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 1139.174576] ffff888137237150 (&xa->xa_lock#18){?.+.}-{2:2}, at: ivpu_mmu_user_context_mark_invalid+0x1c/0x80 [intel_vpu]
[ 1139.185438] {HARDIRQ-ON-W} state was registered at:
[ 1139.190305]   lock_acquire+0x1a3/0x4a0
[ 1139.194055]   _raw_spin_lock+0x2c/0x40
[ 1139.197800]   ivpu_submit_ioctl+0xf0b/0x3520 [intel_vpu]
[ 1139.203114]   drm_ioctl_kernel+0x201/0x3f0 [drm]
[ 1139.207791]   drm_ioctl+0x47d/0xa20 [drm]
[ 1139.211846]   __x64_sys_ioctl+0x12e/0x1a0
[ 1139.215849]   do_syscall_64+0x59/0x90
[ 1139.219509]   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1139.224636] irq event stamp: 45500
[ 1139.228037] hardirqs last  enabled at (45499): [<ffffffff92ef0314>] _raw_spin_unlock_irq+0x24/0x50
[ 1139.236961] hardirqs last disabled at (45500): [<ffffffff92eadf8f>] common_interrupt+0xf/0x90
[ 1139.245457] softirqs last  enabled at (44956): [<ffffffff92ef3430>] __do_softirq+0x4c0/0x712
[ 1139.253862] softirqs last disabled at (44461): [<ffffffff907df310>] irq_exit_rcu+0xa0/0xd0
[ 1139.262098]
               other info that might help us debug this:
[ 1139.268604]  Possible unsafe locking scenario:

[ 1139.274505]        CPU0
[ 1139.276955]        ----
[ 1139.279403]   lock(&xa->xa_lock#18);
[ 1139.282978]   <Interrupt>
[ 1139.285601]     lock(&xa->xa_lock#18);
[ 1139.289345]
                *** DEADLOCK ***

Lockdep falsely identified xa_lock from two different xarrays as the same
lock and report deadlock. More detailed description of the problem
is provided in commit c21f11d182c2 ("drm: fix drmm_mutex_init()")

Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---
 include/linux/xarray.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..409d9d739ee9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -375,12 +375,12 @@ void xa_destroy(struct xarray *);
  *
  * Context: Any context.
  */
-static inline void xa_init_flags(struct xarray *xa, gfp_t flags)
-{
-	spin_lock_init(&xa->xa_lock);
-	xa->xa_flags = flags;
-	xa->xa_head = NULL;
-}
+#define xa_init_flags(_xa, _flags)	\
+do {					\
+	spin_lock_init(&(_xa)->xa_lock);\
+	(_xa)->xa_flags = (_flags);	\
+	(_xa)->xa_head = NULL;		\
+} while (0)
 
 /**
  * xa_init() - Initialise an empty XArray.
@@ -390,10 +390,7 @@ static inline void xa_init_flags(struct xarray *xa, gfp_t flags)
  *
  * Context: Any context.
  */
-static inline void xa_init(struct xarray *xa)
-{
-	xa_init_flags(xa, 0);
-}
+#define xa_init(xa) xa_init_flags(xa, 0)
 
 /**
  * xa_empty() - Determine if an array has any present entries.
-- 
2.25.1

