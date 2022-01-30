Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14E4A372F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 16:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbiA3POq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 10:14:46 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:46351 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355399AbiA3POo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:14:44 -0500
X-QQ-mid: bizesmtp42t1643555661tvf2j5vv
Received: from localhost.localdomain (unknown [180.105.58.61])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jan 2022 23:14:12 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: awo/irkzQ9x7uCJ7hJ2L2ByOwJx57RTcgS8GnflcG+562cie6+uqZolaa1riz
        5XSqAxZU5rcs2SjiB0xEVGQ91FJfTnyXaQO4KhzVPv/w9eVaN538WHS3+OhRNPyPcMozUax
        DEhT2g9jT3A+ep+/QY+t+8D9aCd2Nm5YJ1MG7wRhoio+3qjC16fQPQ1JYdsQ/lH70ZGntuJ
        F90/Jlt+ejtHdbKs8CZmyTVDtIm41pIiNOo4SB0qSYK12BvuGp8U5z/hDgMzxBeFTKPmFzm
        roCxLMoy/+15Txxc3G10vwxmQCg8Yq1pUN+3MlB7e8yl6YbiJUTV9tHbRdlb9LjlyGbQRVr
        BVnkto3wPVy9Xnr6dbZgBAmw0ENAw==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v3] kernel/time: move timer sysctls to its own file
Date:   Sun, 30 Jan 2022 23:13:38 +0800
Message-Id: <20220130151338.6533-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves the kernel/timer/timer.c respective sysctls to its own file.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/timer.h |  4 ----
 kernel/sysctl.c       | 11 -----------
 kernel/time/timer.c   | 28 ++++++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..793b6b7c5a3e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -198,10 +198,6 @@ extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 struct ctl_table;
-
-extern unsigned int sysctl_timer_migration;
-int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 unsigned long __round_jiffies(unsigned long j, int cpu);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..d6d133423e5d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2292,17 +2292,6 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	{
-		.procname	= "timer_migration",
-		.data		= &sysctl_timer_migration,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= timer_migration_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_BPF_SYSCALL
 	{
 		.procname	= "unprivileged_bpf_disabled",
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..f9ae2b4f6326 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/random.h>
+#include <linux/sysctl.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -223,7 +224,7 @@ static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
-unsigned int sysctl_timer_migration = 1;
+static unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
 
@@ -251,7 +252,8 @@ void timers_update_nohz(void)
 	schedule_work(&timer_update_work);
 }
 
-int timer_migration_handler(struct ctl_table *table, int write,
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+static int timer_migration_handler(struct ctl_table *table, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -264,6 +266,27 @@ int timer_migration_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
+static struct ctl_table timer_sysctl[] = {
+	{
+		.procname       = "timer_migration",
+		.data           = &sysctl_timer_migration,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = timer_migration_handler,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init timer_sysctl_init(void)
+{
+	register_sysctl_init("kernel", timer_sysctl);
+	return 0;
+}
+#else
+#define timer_sysctl_init() do { } while (0)
+#endif
 static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
@@ -2022,6 +2045,7 @@ void __init init_timers(void)
 	init_timer_cpus();
 	posix_cputimers_init_work();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
+	timer_sysctl_init();
 }
 
 /**
-- 
2.20.1



