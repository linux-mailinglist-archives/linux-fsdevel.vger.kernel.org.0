Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0C4A3E03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 07:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357811AbiAaG6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 01:58:23 -0500
Received: from smtpbg701.qq.com ([203.205.195.86]:33395 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1357820AbiAaG6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:58:20 -0500
X-QQ-mid: bizesmtp6t1643612288td0m6dc0b
Received: from localhost.localdomain (unknown [180.105.58.61])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jan 2022 14:58:01 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: a4niRxydalGEIRaLD5i0kl2MyqHHO7oEJVHodigFOMYIBLiR/6UhuYxVQzOEQ
        vajdUbjtFqzaqpmBmLzcYP+6kFdRB/xTHKNAJ7dtKpv1OjT31Ktj1DU62RoHvQ6cCyM7XSg
        EwzQXGKOGVbHzrFHVqdkecOvnN6/bktjOKtHU8oh6sOQ8EqvW2U/VPY59NEmAhRioGPj1C8
        QSQ0V7o8sLIyj4HlbGIWZ/ifjLeETtx+yBw/1Wd0bpACYmVul3YiBGYqJPDqWSQFLaZtRYb
        cmhZMNitd0+wU7bYCQX/s51mVmtjemUlyPO9gbbZGVgCZBf++X57nOWL94zALj/ZRJZk2d1
        EbUXkkyj/8FdUqGnbk=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v4] kernel/time: move timer sysctls to its own file
Date:   Mon, 31 Jan 2022 14:57:28 +0800
Message-Id: <20220131065728.6823-1-tangmeng@uniontech.com>
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
 kernel/time/timer.c   | 26 ++++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 17 deletions(-)

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
index 85f1021ad459..2d3f4295614b 100644
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
@@ -264,6 +266,26 @@ int timer_migration_handler(struct ctl_table *table, int write,
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
+__initcall(timer_sysctl_init);
+#endif
 static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
-- 
2.20.1



