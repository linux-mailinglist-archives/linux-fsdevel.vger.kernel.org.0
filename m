Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808D45AD38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKWU1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKWU11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E64C061574;
        Tue, 23 Nov 2021 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FL2SyQ6Pu0YrOGRjcKkDoZFEz/tZa2RgMNl+tDCLzQQ=; b=zSbdOGBTtyKIhbO5UCB6rCKn7Y
        cfE52zIY9+8jRvAS81sDj3xz+DyBblIb+ZWjDBTMrhCOQ7pfgIKRJVX/OJ/cfFxh1KjDlOZrWinIK
        j8zE1Jg6Bizi/Iqm82z6IeOoIZEiW12V81I4HQfBq3B7vsrYUKLOBO8Uy/hjgZoZUhr5K/PT4ZCtT
        sak132s4gbAUs8nw0AtRzOUsvZ/18dNpfwLZXfO3qptAALi3WP7d1M6WtrnWdA/pSUhqqB0e/+LYw
        ocThF0/BIwf0S9p59hHiXEy0S31Hu/IAGlNxHszCeY1lt5rScgM3rseRbaHjUwzl78AFQ2z0HYHpK
        Z4LQXc+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qqy-7o; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 4/9] watchdog: move watchdog sysctl interface to watchdog.c
Date:   Tue, 23 Nov 2021 12:23:42 -0800
Message-Id: <20211123202347.818157-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic of proc sysctl.

So, move the watchdog syscl interface to watchdog.c.
Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the
same time.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[mcgrof: justify the move on the commit log]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c   |  96 -------------------------------------------
 kernel/watchdog.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 96 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9fc6a5222cee..8d5bcf1f08f3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -102,16 +102,10 @@
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/stackleak.h>
 #endif
-#ifdef CONFIG_LOCKUP_DETECTOR
-#include <linux/nmi.h>
-#endif
 
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and  maximum */
-#ifdef CONFIG_LOCKUP_DETECTOR
-static int sixty = 60;
-#endif
 
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
@@ -2308,96 +2302,6 @@ static struct ctl_table kern_table[] = {
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
index ad912511a0c0..99afb88d2e85 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -740,6 +740,106 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
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
+	register_sysctl_init("kernel", watchdog_sysctls);
+}
+#else
+#define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
 void __init lockup_detector_init(void)
@@ -753,4 +853,5 @@ void __init lockup_detector_init(void)
 	if (!watchdog_nmi_probe())
 		nmi_watchdog_available = true;
 	lockup_detector_setup();
+	watchdog_sysctl_init();
 }
-- 
2.33.0

