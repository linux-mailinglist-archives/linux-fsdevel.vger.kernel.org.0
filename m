Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F831D6F84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 06:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgEREA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 00:00:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgEREAM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 00:00:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6266B7D7BBF977549C7A;
        Mon, 18 May 2020 12:00:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 12:00:00 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <patrick.bellasi@arm.com>,
        <mingo@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <alex.huangjianhui@huawei.com>
Subject: [PATCH v3 4/4] watchdog: move watchdog sysctl interface to watchdog.c
Date:   Mon, 18 May 2020 11:59:57 +0800
Message-ID: <1589774397-42485-5-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
References: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move watchdog syscl interface to watchdog.c.
Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/sysctl.c   |  96 ---------------------------------------------------
 kernel/watchdog.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 96 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 90e3ea8..cd85a1c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -97,9 +97,6 @@
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/stackleak.h>
 #endif
-#ifdef CONFIG_LOCKUP_DETECTOR
-#include <linux/nmi.h>
-#endif
 
 #if defined(CONFIG_SYSCTL)
 
@@ -120,9 +117,6 @@
 #endif
 
 /* Constants used for minimum and  maximum */
-#ifdef CONFIG_LOCKUP_DETECTOR
-static int sixty = 60;
-#endif
 
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -883,96 +877,6 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,
 	},
-#if defined(CONFIG_LOCKUP_DETECTOR)
-	{
-		.procname       = "watchdog",
-		.data		= &watchdog_user_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler   = proc_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "watchdog_thresh",
-		.data		= &watchdog_thresh,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_watchdog_thresh,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &sixty,
-	},
-	{
-		.procname       = "nmi_watchdog",
-		.data		= &nmi_watchdog_user_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
-		.proc_handler   = proc_nmi_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "watchdog_cpumask",
-		.data		= &watchdog_cpumask_bits,
-		.maxlen		= NR_CPUS,
-		.mode		= 0644,
-		.proc_handler	= proc_watchdog_cpumask,
-	},
-#ifdef CONFIG_SOFTLOCKUP_DETECTOR
-	{
-		.procname       = "soft_watchdog",
-		.data		= &soft_watchdog_user_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler   = proc_soft_watchdog,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "softlockup_panic",
-		.data		= &softlockup_panic,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#ifdef CONFIG_SMP
-	{
-		.procname	= "softlockup_all_cpu_backtrace",
-		.data		= &sysctl_softlockup_all_cpu_backtrace,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SMP */
-#endif
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-	{
-		.procname	= "hardlockup_panic",
-		.data		= &hardlockup_panic,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#ifdef CONFIG_SMP
-	{
-		.procname	= "hardlockup_all_cpu_backtrace",
-		.data		= &sysctl_hardlockup_all_cpu_backtrace,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SMP */
-#endif
-#endif
-
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 	{
 		.procname       = "unknown_nmi_panic",
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b6b1f54..8c833b6 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -756,6 +756,106 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 	mutex_unlock(&watchdog_mutex);
 	return err;
 }
+
+static const int sixty = 60;
+
+static struct ctl_table watchdog_sysctls[] = {
+	{
+		.procname       = "watchdog",
+		.data		= &watchdog_user_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler   = proc_watchdog,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "watchdog_thresh",
+		.data		= &watchdog_thresh,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_watchdog_thresh,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&sixty,
+	},
+	{
+		.procname       = "nmi_watchdog",
+		.data		= &nmi_watchdog_user_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= NMI_WATCHDOG_SYSCTL_PERM,
+		.proc_handler   = proc_nmi_watchdog,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "watchdog_cpumask",
+		.data		= &watchdog_cpumask_bits,
+		.maxlen		= NR_CPUS,
+		.mode		= 0644,
+		.proc_handler	= proc_watchdog_cpumask,
+	},
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	{
+		.procname       = "soft_watchdog",
+		.data		= &soft_watchdog_user_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler   = proc_soft_watchdog,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "softlockup_panic",
+		.data		= &softlockup_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#ifdef CONFIG_SMP
+	{
+		.procname	= "softlockup_all_cpu_backtrace",
+		.data		= &sysctl_softlockup_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
+#endif
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+	{
+		.procname	= "hardlockup_panic",
+		.data		= &hardlockup_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#ifdef CONFIG_SMP
+	{
+		.procname	= "hardlockup_all_cpu_backtrace",
+		.data		= &sysctl_hardlockup_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
+#endif
+	{}
+};
+
+static void __init watchdog_sysctl_init(void)
+{
+	register_sysctl_init("kernel", watchdog_sysctls, "watchdog_sysctls");
+}
+#else
+#define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
 void __init lockup_detector_init(void)
@@ -769,4 +869,5 @@ void __init lockup_detector_init(void)
 	if (!watchdog_nmi_probe())
 		nmi_watchdog_available = true;
 	lockup_detector_setup();
+	watchdog_sysctl_init();
 }
-- 
1.8.5.6

