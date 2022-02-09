Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D94AE6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 03:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiBICk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 21:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbiBIBhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:37:10 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 17:37:07 PST
Received: from qq.com (smtpbg407.qq.com [113.96.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7757C061576
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Feb 2022 17:37:07 -0800 (PST)
X-QQ-mid: bizesmtp15t1644370492t7reyjc6
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 09 Feb 2022 09:34:46 +0800 (CST)
X-QQ-SSF: 0140000000200010C000B00B0000000
X-QQ-FEAT: B0D4DPF8NcT3//ST4v23tCQDQKKmBlflQxqxGxV6GBo9FaC2qaTUURrPUlaSm
        kA2Gp1pQiHxPlUxAtFVkDAFJDvxfcxr6289vFk+NpjSaQjXo3Hf6x9u/NOf4SU4U8Ft7NEc
        zY/2wXdIRm6hbGTPD7VgH820PfYUGUonuDb7bUHc5D2eVa6IwjdtneVbrUohuVT8CenMRsQ
        tyHWO+AoQvWFNX11s2GaCCxsfYoqTUz5ydmxhXlCozPBMYZYHBKF0dGn6X1b/86ZwQK7VAw
        Wgy1P7tfCgHThCCPUPK6i34IupUoe7ROVdgIdk3dX/ba66TYdGrxf75o8FtZXAB2WkFJkZQ
        U/VdPHngRXXRfPVrHe8qBWm3AlAXvw2HkpQLZj+
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move energy_aware sysctls to topology.c
Date:   Wed,  9 Feb 2022 09:34:44 +0800
Message-Id: <20220209013444.9522-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 kernel/sched/topology.c      | 26 ++++++++++++++++++++++++--
 kernel/sysctl.c              | 11 -----------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d416d8f45186..2af92e71b027 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -59,10 +59,4 @@ int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
-#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
-extern unsigned int sysctl_sched_energy_aware;
-int sched_energy_aware_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-#endif
-
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..af7ce40f1486 100644
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
@@ -240,6 +240,28 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 }
 #endif
 
+#ifdef CONFIG_SYSCTL
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
+late_initcall(sched_energy_aware_sysctl_init);
+#endif /* CONFIG_SYSCTL */
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 981a1902d7a4..81bb5901635b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1761,17 +1761,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
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



