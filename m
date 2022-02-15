Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE44B6B6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiBOLrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:47:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiBOLrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:47:19 -0500
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B017033D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:47:03 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925607tgpbbgmh
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:43 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: G+mSt178IQpLE21X4T1QR8S89E5WBMnEsA68FkG0HyZSQgLhhWCH1vXEv6YGG
        81ofPPR76/4kMtuwQY6SYDPGYxB3OtbPVjrOnFp5JmIhCd9bgAbYAT85D317SP+0XVT8HMt
        BE4UV7MmKWe7Y22AeQ1POJmFv8sEHX7XZaxKE0k0SuIGfou46aTdQAE8r8CiQRDuYncNHjn
        8bnaQadNivCBiAeYBH3/T1/czYuQDN6bdDmUbBoxdqudWeFs2opDBKYcT0wxTy+U6wVInwT
        RGzeka5Xm/+fU+Vypp2McPrVl5f2QsvCwxwsuztdf9tz9MC29j2aZp+Blil/LjUioWvs9PR
        rzcq30TwJS7Fyd9bs5NZApKRHhTxXCK6J28S0KcBtMA4hihRCg66fK2QebdOg==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 7/8] sched: Move cfs_bandwidth_slice sysctls to fair.c
Date:   Tue, 15 Feb 2022 19:46:03 +0800
Message-Id: <20220215114604.25772-8-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move cfs_bandwidth_slice sysctls to fair.c and use the
new register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  4 ---
 kernel/sched/fair.c          | 51 ++++++++++++++++++++++--------------
 kernel/sysctl.c              | 10 -------
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 9fe879602c4f..053688eafd51 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -21,10 +21,6 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
-#ifdef CONFIG_CFS_BANDWIDTH
-extern unsigned int sysctl_sched_cfs_bandwidth_slice;
-#endif
-
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ac1bfe8ca4f..321ddda16909 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -77,25 +77,6 @@ static unsigned int sched_nr_latency = 8;
  * parent will (try to) run first.
  */
 unsigned int sysctl_sched_child_runs_first __read_mostly;
-#ifdef CONFIG_SYSCTL
-static struct ctl_table sched_child_runs_first_sysctls[] = {
-	{
-		.procname       = "sched_child_runs_first",
-		.data           = &sysctl_sched_child_runs_first,
-		.maxlen         = sizeof(unsigned int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-	{}
-};
-
-static int __init sched_child_runs_first_sysctl_init(void)
-{
-	register_sysctl_init("kernel", sched_child_runs_first_sysctls);
-	return 0;
-}
-late_initcall(sched_child_runs_first_sysctl_init);
-#endif
 
 /*
  * SCHED_OTHER wake-up granularity.
@@ -160,7 +141,37 @@ int __weak arch_asym_cpu_priority(int cpu)
  *
  * (default: 5 msec, units: microseconds)
  */
-unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+#endif
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_fair_sysctls[] = {
+	{
+		.procname       = "sched_child_runs_first",
+		.data           = &sysctl_sched_child_runs_first,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#ifdef CONFIG_CFS_BANDWIDTH
+	{
+		.procname       = "sched_cfs_bandwidth_slice_us",
+		.data           = &sysctl_sched_cfs_bandwidth_slice,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ONE,
+	},
+#endif
+	{}
+};
+
+static int __init sched_fair_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_fair_sysctls);
+	return 0;
+}
+late_initcall(sched_fair_sysctl_init);
 #endif
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d811e471f7d3..21b797906cc4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,16 +1674,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
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



