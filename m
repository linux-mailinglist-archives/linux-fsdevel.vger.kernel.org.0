Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B44B6B75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiBOLq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:46:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiBOLqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:46:54 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF6673D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:43 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925586t808hy5z
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:24 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: KW3QVT31YrdQMsF7E7xkyDH8AetymoeAq10KCDDtLrGa7kmDMsBH3msjstL/z
        gIZIZB/558bUVkNF53F6a9JUenkuyOR19AsuIEybkqLD6BCzIcTIMbSeZZRLAG3SZ59ePHB
        LJMmgW75X3yu5rf5v5YvMm5jYi8zd59/EV+7zFujsItt/tDPzUoQsa055Yq+/fbTXz0Ce8i
        sbg703UhYTRwCsUlMNUgHwGJuAx4du7NJbMuZvO4ZtUQ7kpbf2/TYSSU/L7EQpNKQJ1hTAf
        pr2UkH6YYU3Llm2VdIMrHAzw/NQfoRXPh8kaSrx9rk+ZYsKqmZ/n3ZncEAL/t6dlJ1fOB2l
        d6a/kWVW2yV999ltm//F5t236McjcEbgyBNlllQhTnKFSpAB3c=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 2/8] sched: Move schedstats sysctls to core.c
Date:   Tue, 15 Feb 2022 19:45:58 +0800
Message-Id: <20220215114604.25772-3-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
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

move schedstats sysctls to core.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  2 --
 kernel/sched/core.c          | 22 +++++++++++++++++++++-
 kernel/sysctl.c              | 11 -----------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5490ba24783a..ffe42509a595 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -54,8 +54,6 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0bf0dc3adf57..3c1239c61b45 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4354,7 +4354,7 @@ static int __init setup_schedstats(char *str)
 __setup("schedstats=", setup_schedstats);
 
 #ifdef CONFIG_PROC_SYSCTL
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
+static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4373,6 +4373,26 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		set_schedstats(state);
 	return err;
 }
+
+static struct ctl_table sched_schedstats_sysctls[] = {
+	{
+		.procname       = "sched_schedstats",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_schedstats,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init sched_schedstats_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_schedstats_sysctls);
+	return 0;
+}
+late_initcall(sched_schedstats_sysctl_init);
 #endif /* CONFIG_PROC_SYSCTL */
 #endif /* CONFIG_SCHEDSTATS */
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 24a99b5b7da8..88ff6b27f8ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1652,17 +1652,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 }
 
 static struct ctl_table kern_table[] = {
-#ifdef CONFIG_SCHEDSTATS
-	{
-		.procname	= "sched_schedstats",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_schedstats,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SCHEDSTATS */
 #ifdef CONFIG_TASK_DELAY_ACCT
 	{
 		.procname	= "task_delayacct",
-- 
2.20.1



