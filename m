Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B21B4B626D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 06:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiBOFX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 00:23:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiBOFXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:23:16 -0500
X-Greylist: delayed 101105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 21:23:06 PST
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D612858C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 21:23:06 -0800 (PST)
X-QQ-mid: bizesmtp5t1644902568tl16wf3x2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 13:22:46 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: Mzskoac49OiUs9T/oMCrmSgIQrk8Pow2Nf2ady4HgfpQFauSluksJw/vlLzGZ
        S07guoIiqSBrkU4LJodMqNSdsP6yAgo3Rw7MvrzPPgJ+rY3GZOUSGdY8N32Q+4K/V3y5JZR
        gEg/Eu+qH2jdyfMa9BQWov70XWvy7pQNKpYzJmLoP+JO9Hch5G054rHYadvXbFgAq/lj2E6
        jRIpM1ZSCvVGgotPwIMsJcOxpDRjceGElYnnj27asZV1zh7KOcV84XBd5LmGvkdIdpCAB+x
        4q6T7gwxnmnsEVShVhDNkFnBX/687a1K1Ycr/ZRC1JgnBMYTjPw9GsLmlfptQUZJk8OAk6+
        57tNy6AKDEgZPxeL8s2DGmv11nqyaCjIk91c22NkJB07Wy5wlg=
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 5/8] sched: Move rr_timeslice sysctls to rt.c
Date:   Tue, 15 Feb 2022 13:22:11 +0800
Message-Id: <20220215052214.5286-6-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215052214.5286-1-nizhen@uniontech.com>
References: <20220215052214.5286-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move rr_timeslice sysctls to rt.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  5 -----
 kernel/sched/rt.c            | 13 +++++++++++--
 kernel/sched/sched.h         |  1 +
 kernel/sysctl.c              |  7 -------
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 81187a8c625d..5515b54bfb57 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -31,11 +31,6 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
 
-extern int sysctl_sched_rr_timeslice;
-extern int sched_rr_timeslice;
-
-int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1106828c4236..95e4d5f31caa 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,7 +8,7 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -30,6 +30,8 @@ int sysctl_sched_rt_runtime = 950000;
 
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
 #ifdef CONFIG_SYSCTL
 static struct ctl_table sched_rt_sysctls[] = {
 	{
@@ -46,6 +48,13 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = sched_rt_handler,
 	},
+	{
+		.procname       = "sched_rr_timeslice_ms",
+		.data           = &sysctl_sched_rr_timeslice,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = sched_rr_handler,
+	},
 	{}
 };
 
@@ -3008,7 +3017,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 385e74095434..2d3451e06c55 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -105,6 +105,7 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
 
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
+extern int sched_rr_timeslice;
 
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f4434d22246b..cfcbd17005af 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,13 +1674,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{
-		.procname	= "sched_rr_timeslice_ms",
-		.data		= &sysctl_sched_rr_timeslice,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sched_rr_handler,
-	},
 #ifdef CONFIG_UCLAMP_TASK
 	{
 		.procname	= "sched_util_clamp_min",
-- 
2.20.1



