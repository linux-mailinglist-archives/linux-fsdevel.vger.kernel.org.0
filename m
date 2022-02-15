Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484904B63BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 07:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiBOGqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 01:46:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiBOGqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:46:12 -0500
X-Greylist: delayed 1431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 22:46:02 PST
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65AC3C33
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 22:46:01 -0800 (PST)
X-QQ-mid: bizesmtp44t1644907530twnjvw9f
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 14:45:24 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: SAUrQiVpIXGIL5g7/NqIvJwpdoFW7wYZScAUFA/QFcoU1fbTkyDLEpCNrmc1X
        oO3SrOYY48t7wRrlQzy/yoTv43z3vqOujfSfspKvJMPCSGPfevYoFhjOal9meYjt/3n0KJJ
        QkPakhaFrzFpwtZcVe5Z6YaeV+yeDleye6dmMFOWyWAhbhkkiM1hrAtXUsjleNkGiqUNr6K
        VV2vw9Nr69o/6Wldox/s+9nuXbjMYXPKEK72v+cxKGGtesXh6rJtksh7boX7BehAiE6VxTI
        /hXI33OLbx84faXI3yCrLaWf78JEiezzOHZZROYlxkZKBPi7KzxM79DyGqIlqDBJmQgscUt
        9Cqxk8cSakiNaw9wJudMm2hYXgQApd+woQaUfoM
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v6] kernel/time: move timer sysctls to its own file
Date:   Tue, 15 Feb 2022 14:45:22 +0800
Message-Id: <20220215064522.5905-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/timer.h |  8 -------
 kernel/sysctl.c       | 11 ---------
 kernel/time/timer.c   | 54 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..648f00105f58 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -196,14 +196,6 @@ extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-struct ctl_table;
-
-extern unsigned int sysctl_timer_migration;
-int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos);
-#endif
-
 unsigned long __round_jiffies(unsigned long j, int cpu);
 unsigned long __round_jiffies_relative(unsigned long j, int cpu);
 unsigned long round_jiffies(unsigned long j);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..740c34f20235 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2656,17 +2656,6 @@ static struct ctl_table kern_table[] = {
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
index 85f1021ad459..c4f0045139cb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,9 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/random.h>
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+#endif
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -223,7 +226,8 @@ static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
 
 #ifdef CONFIG_SMP
-unsigned int sysctl_timer_migration = 1;
+struct ctl_table;
+static unsigned int sysctl_timer_migration = 1;
 
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
 
@@ -234,6 +238,41 @@ static void timers_update_migration(void)
 	else
 		static_branch_disable(&timers_migration_enabled);
 }
+
+#ifdef CONFIG_SYSCTL
+static int timer_migration_handler(struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	mutex_lock(&timer_keys_mutex);
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write)
+		timers_update_migration();
+	mutex_unlock(&timer_keys_mutex);
+	return ret;
+}
+
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
+	register_sysctl("kernel", timer_sysctl);
+	return 0;
+}
+device_initcall(timer_sysctl_init);
+#endif /* CONFIG_SYSCTL */
 #else
 static inline void timers_update_migration(void) { }
 #endif /* !CONFIG_SMP */
@@ -251,19 +290,6 @@ void timers_update_nohz(void)
 	schedule_work(&timer_update_work);
 }
 
-int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int ret;
-
-	mutex_lock(&timer_keys_mutex);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (!ret && write)
-		timers_update_migration();
-	mutex_unlock(&timer_keys_mutex);
-	return ret;
-}
-
 static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
-- 
2.20.1



