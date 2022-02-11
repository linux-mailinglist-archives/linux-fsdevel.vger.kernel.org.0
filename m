Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B74B1EF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 08:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347546AbiBKHEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 02:04:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiBKHEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:04:12 -0500
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 23:04:11 PST
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5186F4B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 23:04:11 -0800 (PST)
X-QQ-mid: bizesmtp54t1644563004t30oz7ix
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Feb 2022 15:03:20 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: ZKIyA7viXp3R0aWkRtuN4d+xvpiOtMB90G7oXLuG9o5syXqwm9hjF/wrsOo1Z
        cp5fDKr/8+XqA1QWIdmlQOxK738pklJLj7dvC5G2ChUBJ+JZZpQV8asjbAoatwiYAzk037u
        AFTbc1p/A7QqNqVA/JJMJ262fWbBAzSpraU1MCICk12Uz0YUkODklTBWiwMZWpA5LyeCJpa
        Rl8z5UtktziCt7y3seaoA3DRwWwFsBaqvYuppb8DqjON6Iu74h6wIX0e8rsd2X/Qmv4mkTu
        rj9pfnmuLH4uurKoYiMtSCFGQgFfzOTTwUhwPvW8BndPbF1+rQDGKlD/8033EPsKAdZ7OkD
        Chot7GXLwmKzXJ3ouH93jw2acQoI/qC6aV9aSi/
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move schedstats sysctls to core.c
Date:   Fri, 11 Feb 2022 15:03:18 +0800
Message-Id: <20220211070318.5331-1-nizhen@uniontech.com>
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

move schedstats sysctls to core.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  2 --
 kernel/sched/core.c          | 22 +++++++++++++++++++++-
 kernel/sysctl.c              | 11 -----------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..e3555a1bc013 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -60,8 +60,6 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..024e09875472 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4352,7 +4352,7 @@ static int __init setup_schedstats(char *str)
 __setup("schedstats=", setup_schedstats);
 
 #ifdef CONFIG_PROC_SYSCTL
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
+static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4371,6 +4371,26 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
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
index 5ae443b2882e..4b2716387e35 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1659,17 +1659,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
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



