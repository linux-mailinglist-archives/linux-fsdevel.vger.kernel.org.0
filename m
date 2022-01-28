Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8849F3E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 07:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbiA1GzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 01:55:21 -0500
Received: from smtpbg516.qq.com ([203.205.250.54]:50878 "EHLO smtpbg516.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346461AbiA1GzV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:55:21 -0500
X-QQ-mid: bizesmtp41t1643352913th5emuoc
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jan 2022 14:55:06 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: FXvDfBZI5O6u18t8KgF9w8gE4/WINuNZiWc0PrPj2/BDg8uDHDj6kQWpGYPbt
        rXArt00Bvuje+9mNzjVhMd7uDg7YvsCYbcc0zoA01bC/yvEhm8p/tH+jE9rMizS3w7p/laT
        NfIUVzye5I8uanNNfCFgwuOjPzci/oRJiusrNuaNfciiIxsFh81MCMMaxufdnJhyCt6m92O
        Pdd1z271ZPLk/UOl6cC+ZwtBGoeendGmiwP/VvlRlOXHYqp36MQ7nmJoSxhyPyrCxnAKU1g
        Z4AtAV8Rm58h4/N2BB+IRuAUuZP3cu6+UdsaDcjTHJlLV1PBqQiD94oG+sjLOC7ZG8rJcRx
        gi1LNa21gzWlS1iR1K9tbERLuYi7Q==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] kernel/time: move timer sysctls to its own file
Date:   Fri, 28 Jan 2022 14:55:05 +0800
Message-Id: <20220128065505.16685-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves the kernel/timer/timer.c respective sysctls to its own file.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/timer.h |  4 ----
 kernel/sysctl.c       | 11 -----------
 kernel/time/timer.c   | 27 +++++++++++++++++++++++++--
 3 files changed, 25 insertions(+), 17 deletions(-)

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
index 85f1021ad459..e7ee3c2484c6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -223,7 +223,7 @@ static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
-unsigned int sysctl_timer_migration = 1;
+static unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
 
@@ -251,7 +251,21 @@ void timers_update_nohz(void)
 	schedule_work(&timer_update_work);
 }
 
-int timer_migration_handler(struct ctl_table *table, int write,
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
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
+static int timer_migration_handler(struct ctl_table *table, int write,
 			    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
@@ -264,6 +278,14 @@ int timer_migration_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
+static int __init timer_sysctl_init(void)
+{
+	register_sysctl_init("kerneli/timer", timer_sysctl);
+	return 0;
+}
+#else
+#define timer_sysctl_init() do { } while (0)
+#endif
 static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
@@ -2022,6 +2044,7 @@ void __init init_timers(void)
 	init_timer_cpus();
 	posix_cputimers_init_work();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
+	timer_sysctl_init();
 }
 
 /**
-- 
2.20.1




