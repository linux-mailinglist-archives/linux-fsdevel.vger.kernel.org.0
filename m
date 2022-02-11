Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D14B1EFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 08:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiBKHFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 02:05:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347566AbiBKHFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:05:45 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007CF54
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 23:05:44 -0800 (PST)
X-QQ-mid: bizesmtp14t1644563119twugeka5
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Feb 2022 15:05:14 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: d3XYZ9avhmDA9voKcRBKIN1dAONDHXsm7ZRkq5+e0fmr2DUYVGN+tcdffkD4u
        VHaOpioBVgejWHM6/zbPqXJBny67E8lSbY4obEf+hRrfJF2pw4aiL1rnJYU0Aiy7yx24wYC
        4Epvs1axt8Na5Oz05qFsTUaKqtrcFJy56v1dQlMQIqAZ3waIqvyBaoTIctDZ6zDTYg+kwOe
        JvSSDDG4aIEC8eIMs6aSt0506UuTn3DZpSeTTmQX9pTDCisFOvGI+IJIHp4F8+UawPqHOnH
        b192m9pJFcGIWxP9iEZsjwQSmD8EtTIIcdQiCnOl0sJHPtiG1pLNzGNUpMAk9FPr3yz1UK9
        0lGrndYrjUUHDhov4A9oe2fzq92URrswwLsE8Ti
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3] sched: move cfs_bandwidth_slice sysctls to fair.c
Date:   Fri, 11 Feb 2022 15:05:12 +0800
Message-Id: <20220211070512.9144-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move cfs_bandwidth_slice sysctls to fair.c and use the
new register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  4 ----
 kernel/sched/fair.c          | 27 +++++++++++++++++++++++++--
 kernel/sysctl.c              | 10 ----------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..d416d8f45186 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,10 +41,6 @@ extern unsigned int sysctl_sched_uclamp_util_max;
 extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 #endif
 
-#ifdef CONFIG_CFS_BANDWIDTH
-extern unsigned int sysctl_sched_cfs_bandwidth_slice;
-#endif
-
 #ifdef CONFIG_SCHED_AUTOGROUP
 extern unsigned int sysctl_sched_autogroup_enabled;
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..50ee00163800 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -141,8 +141,30 @@ int __weak arch_asym_cpu_priority(int cpu)
  *
  * (default: 5 msec, units: microseconds)
  */
-unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
-#endif
+static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_cfs_bandwidth_sysctls[] = {
+	{
+		.procname       = "sched_cfs_bandwidth_slice_us",
+		.data           = &sysctl_sched_cfs_bandwidth_slice,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static void __init sched_cfs_bandwidth_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_cfs_bandwidth_sysctls);
+}
+#else /* !CONFIG_SYSCTL */
+#define sched_cfs_bandwidth_sysctl_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+#else /* !CONFIG_CFS_BANDWIDTH */
+#define sched_cfs_bandwidth_sysctl_init() do { } while (0)
+#endif /* CONFIG_CFS_BANDWIDTH */
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
@@ -207,6 +229,7 @@ static void update_sysctl(void)
 void __init sched_init_granularity(void)
 {
 	update_sysctl();
+	sched_cfs_bandwidth_sysctl_init();
 }
 
 #define WMULT_CONST	(~0U)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..981a1902d7a4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1761,16 +1761,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_CFS_BANDWIDTH
-	{
-		.procname	= "sched_cfs_bandwidth_slice_us",
-		.data		= &sysctl_sched_cfs_bandwidth_slice,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-#endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
 		.procname	= "sched_energy_aware",
-- 
2.20.1



