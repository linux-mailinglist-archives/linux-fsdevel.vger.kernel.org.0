Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5B4B6B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiBOLrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiBOLrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:47:18 -0500
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8D6FA39
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:47:01 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925610tgppnmba
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:49 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: SAUrQiVpIXFTcHSlBTgbqX/VRBZj0CS9cAHri9CoK8WkcgqLeVebnOmYXXqfB
        GHUNNmzeukpjkhdwdYAznffwNBzW8894nJ0ofpOOeq7IrYynAFuPMA7wderoasz4OBpqzlS
        GsDv2us/CvAmFFhH8T0VkHVoQxr7OWunnJC3jUiaVqo2aMo4tFlumCHgREaUvBMUHmXMxaf
        ZkyPU/+VFcxGEOSz83KPIj3QjL7mrtY2PDpWU4MW/kknIkibs9ND+jHZoTP22tBlx1aj/m4
        f/Xv/mvAPUP7Ic48Ii/EFV9pLoSic7y5DTBpQ/cfFbbcab5iv4Uq6zkdSSUoBVX+8z7chxQ
        kkx8bh+iVrxBjfLn6dgZs+KLbB95C0IFCIf7M/8V+QPS9JsdearRb+KvtfX8g==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 8/8] sched: Move energy_aware sysctls to topology.c
Date:   Tue, 15 Feb 2022 19:46:04 +0800
Message-Id: <20220215114604.25772-9-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
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

move energy_aware sysctls to topology.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  6 ------
 kernel/sched/topology.c      | 25 +++++++++++++++++++++++--
 kernel/sysctl.c              | 11 -----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 053688eafd51..b6a4063e388d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -24,10 +24,4 @@ enum sched_tunable_scaling {
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-extern unsigned int sysctl_sched_energy_aware;
-int sched_energy_aware_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-#endif
-
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..409e27af2034 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -207,7 +207,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
-unsigned int sysctl_sched_energy_aware = 1;
+static unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
@@ -221,7 +221,7 @@ void rebuild_sched_domains_energy(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-int sched_energy_aware_handler(struct ctl_table *table, int write,
+static int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, state;
@@ -238,6 +238,27 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static struct ctl_table sched_energy_aware_sysctls[] = {
+	{
+		.procname       = "sched_energy_aware",
+		.data           = &sysctl_sched_energy_aware,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sched_energy_aware_handler,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init sched_energy_aware_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_energy_aware_sysctls);
+	return 0;
+}
+
+late_initcall(sched_energy_aware_sysctl_init);
 #endif
 
 static void free_pd(struct perf_domain *pd)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 21b797906cc4..ee6701ea73ea 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,17 +1674,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-	{
-		.procname	= "sched_energy_aware",
-		.data		= &sysctl_sched_energy_aware,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_energy_aware_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.20.1



