Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974504B061A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 07:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiBJGI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 01:08:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBJGI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:08:58 -0500
X-Greylist: delayed 17278 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 22:08:59 PST
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F8010CA
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 22:08:58 -0800 (PST)
X-QQ-mid: bizesmtp31t1644473325t4um6gr6
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Feb 2022 14:08:37 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: F3yR32iATbgqbQ7dxOEjZ8MGKfPiaMbvMu0Lq+6FSWO29t6tRcEdrRK9bqB6x
        6aj+EpSZ8mgnCUh5uBOeMlsuP0R9Cuu97YEieN8zDS8/x8QgmK5qPKZqWr7iR9cG6FcziWv
        6QzARQiZcGm/PMiKERzdDxkcYj7ATOzHWcaTl7cWKZjrXuk/3RymxEBeMDhtp5Wrudj8/Zj
        4iDluVCjd1pTAXXiWD8Y8EDW5/RnYeVopR43TAJLIreAqjq48kulVMilXMU1x6MX9sTApXG
        i5CB/SmqFf+gDgrN02X3HfkLzDA/9NK7y/rIQzc9PVDAyBOXi96jgOjsmy1KsGlL6Q+5QtH
        nY4FDRfAQSfHG3Z49OGOF003OETqbMnzfjdwCbzeyQ4LDK+GBg=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move rr_timeslice sysctls to rt.c
Date:   Thu, 10 Feb 2022 14:08:31 +0800
Message-Id: <20220210060831.26689-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move rr_timeslice sysctls to rt.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  3 ---
 kernel/sched/rt.c            | 28 ++++++++++++++++++++++++++--
 kernel/sysctl.c              |  7 -------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d416d8f45186..f6466040883c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -45,11 +45,8 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 extern unsigned int sysctl_sched_autogroup_enabled;
 #endif
 
-extern int sysctl_sched_rr_timeslice;
 extern int sched_rr_timeslice;
 
-int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..e8316e0307b0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,10 +8,33 @@
 #include "pelt.h"
 
 int sched_rr_timeslice = RR_TIMESLICE;
-int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
+static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_rr_sysctls[] = {
+	{
+		.procname       = "sched_rr_timeslice_ms",
+		.data           = &sysctl_sched_rr_timeslice,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = sched_rr_handler,
+	},
+	{}
+};
+
+static void __init sched_rr_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_rr_sysctls);
+}
+#else
+#define sched_rr_sysctl_init() do { } while (0)
+#endif
+
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
 struct rt_bandwidth def_rt_bandwidth;
@@ -2471,6 +2494,7 @@ void __init init_sched_rt_class(void)
 		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
 					GFP_KERNEL, cpu_to_node(i));
 	}
+	sched_rr_sysctl_init();
 }
 #endif /* CONFIG_SMP */
 
@@ -2967,7 +2991,7 @@ int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
-int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int ret;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 981a1902d7a4..d0c45bf6801d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1720,13 +1720,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
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



