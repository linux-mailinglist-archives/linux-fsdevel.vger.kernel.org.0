Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24034A4013
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 11:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358190AbiAaKYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 05:24:19 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51026 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358146AbiAaKYG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:24:06 -0500
X-Greylist: delayed 68961 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Jan 2022 05:24:05 EST
X-QQ-mid: bizesmtp11t1643624627tmhf9c2q
Received: from localhost.localdomain (unknown [180.105.58.61])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jan 2022 18:22:47 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: YSwSv5UBo8jqRMsFPvrPuKGE1HHFTE5HH6gTbBe1i0Gh8eAUIPWPPhTYKcMqY
        sFlA1wslD7Xu5go8t4ZC0LBMYLw2PBtAxWoYpFf8waY1logbhaZrinkuOu0LvOMUYwDA383
        FuE4V9ikrDLJ7/w9J9hO2ZZpcGDNxMV2v0U7FPZNdvfRUlxN4T/Jm9duQ84hjNnonQYL45x
        LGYnzc9ai/bhc4Vtv7sjseXdXbTrN6XRquSnbwa8yxb32VM73BfeEUZ2Tf6X9VW16KCsSeV
        fDbX2SGJQGbqKGBVuapHW5Xd6B6Lc0UEIUNhwGyx2vTcryA29UhQS0fQ5uSOnL+IaI1NcE3
        4NKUO1gcdhjSQGIdf1/dTk1cSLuIyBAfAlJOaWH
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v5] kernel/time: move timer sysctls to its own file
Date:   Mon, 31 Jan 2022 18:22:14 +0800
Message-Id: <20220131102214.2284-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

So move the timer_migration sysctls to its own file.

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



