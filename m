Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA3D49F6AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347739AbiA1JvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 04:51:08 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:46186 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiA1JvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:51:08 -0500
X-QQ-mid: bizesmtp16t1643363449tqcolhvo
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jan 2022 17:50:29 +0800 (CST)
X-QQ-SSF: 0140000000200000B000B00A0000000
X-QQ-FEAT: dpyQmELDBxH9OJnSTX2OZ9jR1M94PHaAk870PQvL60zkQ6X7Dy7qLmCAK4wVQ
        GLtkEl1gmLr+BvpdbZ1+imPzzhV7w62ToKPFmYz9l/hwf8MPaIMvYfINdHtArZPDUxf4sFp
        kF/YvsbQ0zeHcc3Z7xSyJnUmGG0is1nYxjuLPj9fsyxh0F6MlNOUTS+EHAh9Fs+Hnu/XGZU
        QLeMGccBGx4Io9DsD53edTMaVnPdDfPAZ0BhZvvqmXmBP66SgCu5UlZru7V6lZSOKQl5WAv
        Ew5Os30G7cDlXe3iXdULYpUE4NAh6cNosFp2D6pHW2PaupM30Xjh+lGxUzn3/DiFSx3oqXm
        S/2yq94LEp3kmTIuW4=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move autogroup sysctls into its own file
Date:   Fri, 28 Jan 2022 17:50:25 +0800
Message-Id: <20220128095025.8745-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move autogroup sysctls to autogroup.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  4 ----
 kernel/sched/autogroup.c     | 23 +++++++++++++++++++++++
 kernel/sched/autogroup.h     |  1 +
 kernel/sysctl.c              | 11 -----------
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..3f2b70f8d32c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -45,10 +45,6 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
 
-#ifdef CONFIG_SCHED_AUTOGROUP
-extern unsigned int sysctl_sched_autogroup_enabled;
-#endif
-
 extern int sysctl_sched_rr_timeslice;
 extern int sched_rr_timeslice;
 
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 8629b37d118e..31dd2593145e 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -9,6 +9,28 @@ unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
 static atomic_t autogroup_seq_nr;
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_autogroup_sysctls[] = {
+	{
+		.procname       = "sched_autogroup_enabled",
+		.data           = &sysctl_sched_autogroup_enabled,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static void __init sched_autogroup_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_autogroup_sysctls);
+}
+#else
+#define sched_autogroup_sysctl_init() do { } while (0)
+#endif
+
 void __init autogroup_init(struct task_struct *init_task)
 {
 	autogroup_default.tg = &root_task_group;
@@ -198,6 +220,7 @@ void sched_autogroup_exit(struct signal_struct *sig)
 static int __init setup_autogroup(char *str)
 {
 	sysctl_sched_autogroup_enabled = 0;
+	sched_autogroup_sysctl_init();
 
 	return 1;
 }
diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index b96419974a1f..90fcbfdd70c3 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -27,6 +27,7 @@ extern bool task_wants_autogroup(struct task_struct *p, struct task_group *tg);
 static inline struct task_group *
 autogroup_task_group(struct task_struct *p, struct task_group *tg)
 {
+	extern unsigned int sysctl_sched_autogroup_enabled;
 	int enabled = READ_ONCE(sysctl_sched_autogroup_enabled);
 
 	if (enabled && task_wants_autogroup(p, tg))
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..1cb7ca68cd4e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1750,17 +1750,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
 #endif
-#ifdef CONFIG_SCHED_AUTOGROUP
-	{
-		.procname	= "sched_autogroup_enabled",
-		.data		= &sysctl_sched_autogroup_enabled,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.procname	= "sched_cfs_bandwidth_slice_us",
-- 
2.20.1



