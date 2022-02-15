Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72A4B626C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 06:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiBOFXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 00:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiBOFXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:23:20 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF7E72AF
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 21:23:10 -0800 (PST)
X-QQ-mid: bizesmtp5t1644902577ty7gqvw8a
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 13:22:55 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: XcJ1Se6WjemirswIwPMLJ8vy0PeFDGQGd9qjTlz3zVp2Zfp60c4vhXks92mE8
        OUsf4zcLNTEB2kd/rLoEBgTQLcp6Q0EPRZRkpS5ywSFqNTUSL2Hoiril3TNXaO40zDDBQhg
        EgJoDcD7QOY3iCFkpwpHFzZVh7sw+QYslm++1YADPGSHgsn2/9Cym6X3fZj+//7wvi6wpkM
        ncEw134zXzKS8P74Kj9F2zdpkkWPlnOe0SrKJqrPS+Msba1n5wbhC1t45hMmSi6P/5eb9MP
        UR/dLZVwxCLUWHcE/Ndb5jvsnhyyOQ7NyWPc8qnqoGAhRHCJoYXM5fBUuCmJCAJyxcpDmqY
        bILaqd23XQi2S/OE30K1zrJoG99aVhIDBj1+7ScYCxzQrYZ8Dg=
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 8/8] sched: Move energy_aware sysctls to topology.c
Date:   Tue, 15 Feb 2022 13:22:14 +0800
Message-Id: <20220215052214.5286-9-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215052214.5286-1-nizhen@uniontech.com>
References: <20220215052214.5286-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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



