Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7C4AE6C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 03:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbiBICk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243153AbiBIBda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:33:30 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 17:33:27 PST
Received: from qq.com (smtpbg473.qq.com [59.36.132.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B5C061576;
        Tue,  8 Feb 2022 17:33:27 -0800 (PST)
X-QQ-mid: bizesmtp39t1644370280tgd31slh
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 09 Feb 2022 09:30:44 +0800 (CST)
X-QQ-SSF: 0140000000200010C000B00B0000000
X-QQ-FEAT: 4LFlwc+MlXlaA1qxQd8ZjI3hgB/I/y2omO7QesexpMYLTYGPmEIO3CRq+JJuv
        JnT9r6B5QgTAnEqTcQ7YKbnZ4dsANyQiY395WGkZPJtG1j+MGqT87ZaIr6sOVPkDpQAN3Fm
        oYlBexIWLvrVUGYy6f2GbjkIUZHvAZLEDhmnR8WHsGqL8cb2ZW+pE4bfDhuJ4821sxibGn7
        EpcfSiKJtPeGEEr1+73mjPP33fJfJHBbuuMc8qxgdVfkeYF2Xg6n5NT0zrTMCseHqjAfcg9
        KN0n+f5Mw+MmkuALWFIRVjTRFrHiyxIEpSi4QtTbEWNO4iHrs1orMxFBXa1rxHHuW3SuPhh
        lmuHjFPLKc99hiFTkw=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move cfs_bandwidth_slice sysctls to fair.c
Date:   Wed,  9 Feb 2022 09:30:20 +0800
Message-Id: <20220209013020.1420-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/sched/fair.c          | 25 +++++++++++++++++++++++--
 kernel/sysctl.c              | 10 ----------
 3 files changed, 23 insertions(+), 16 deletions(-)

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
index 5146163bfabb..32baf28e136f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -141,8 +141,28 @@ int __weak arch_asym_cpu_priority(int cpu)
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
+#endif /* CONFIG_CFS_BANDWIDTH */
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
@@ -207,6 +227,7 @@ static void update_sysctl(void)
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



