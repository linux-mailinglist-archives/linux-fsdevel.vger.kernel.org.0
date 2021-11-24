Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7B45D0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbhKXXSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbhKXXSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EAAC06173E;
        Wed, 24 Nov 2021 15:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uypgeyB0u27jmjLP832wchi6YoRiX1F3ojCRBUTdWCk=; b=FKmIg7JVtCRCr1NV+2lG+aDQkm
        yv/Ry67attGrXnT3mPZF/aAJVUfmxyhUjBecRQXQtRrOFMtC/YpGr7cbJdy10GKVWe4tetwDl6MOu
        yftHGzcW1tPDuJY3FKQ7J5tqoVVRg10w6B/ep7pedEL93Mp++I/hdQA3KHLaRbjkyeYwnstR1gE9r
        DB9FuUJaSb4UxmYpG0C/nkrALTrSL7Hrue2lJhDQwIPLw/dGkn66vULxsukKo2/qU4Tad3/Wl43r1
        jq49B1+5LKpikyWqCXQuwVLBDVDOqfxXDIa0JxnX/+X89dVQQjjuGkLvf3RGNI+9bA8Hx9kwUfnB/
        i954MqIw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063zB-PA; Wed, 24 Nov 2021 23:14:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] printk: move printk sysctl to printk/sysctl.c
Date:   Wed, 24 Nov 2021 15:14:32 -0800
Message-Id: <20211124231435.1445213-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124231435.1445213-1-mcgrof@kernel.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
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
piece of code, we just care about the core logic.

So move printk sysctl from kernel/sysctl.c to kernel/printk/sysctl.c.
Use register_sysctl() to register the sysctl interface.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: fixed compile issues when PRINTK is not set, commit log update]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/printk/Makefile   |  5 ++-
 kernel/printk/internal.h |  6 +++
 kernel/printk/printk.c   |  1 +
 kernel/printk/sysctl.c   | 85 ++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c          | 68 --------------------------------
 5 files changed, 96 insertions(+), 69 deletions(-)
 create mode 100644 kernel/printk/sysctl.c

diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index d118739874c0..f5b388e810b9 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -2,5 +2,8 @@
 obj-y	= printk.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
-obj-$(CONFIG_PRINTK)	+= printk_ringbuffer.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
+
+obj-$(CONFIG_PRINTK)                 += printk_support.o
+printk_support-y	             := printk_ringbuffer.o
+printk_support-$(CONFIG_SYSCTL)	     += sysctl.o
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 9f3ed2fdb721..6b1c4b399845 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,6 +4,12 @@
  */
 #include <linux/percpu.h>
 
+#if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
+void __init printk_sysctl_init(void);
+#else
+#define printk_sysctl_init() do { } while (0)
+#endif
+
 #ifdef CONFIG_PRINTK
 
 /* Flags for a single printk record. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cbc35d586afb..dbb44086ba65 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3202,6 +3202,7 @@ static int __init printk_late_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
+	printk_sysctl_init();
 	return 0;
 }
 late_initcall(printk_late_init);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
new file mode 100644
index 000000000000..653ae04aab7f
--- /dev/null
+++ b/kernel/printk/sysctl.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sysctl.c: General linux system control interface
+ */
+
+#include <linux/sysctl.h>
+#include <linux/printk.h>
+#include <linux/capability.h>
+#include <linux/ratelimit.h>
+#include "internal.h"
+
+static const int ten_thousand = 10000;
+
+static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+}
+
+static struct ctl_table printk_sysctls[] = {
+	{
+		.procname	= "printk",
+		.data		= &console_loglevel,
+		.maxlen		= 4*sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "printk_ratelimit",
+		.data		= &printk_ratelimit_state.interval,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+	},
+	{
+		.procname	= "printk_ratelimit_burst",
+		.data		= &printk_ratelimit_state.burst,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "printk_delay",
+		.data		= &printk_delay_msec,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= (void *)&ten_thousand,
+	},
+	{
+		.procname	= "printk_devkmsg",
+		.data		= devkmsg_log_str,
+		.maxlen		= DEVKMSG_STR_MAX_SIZE,
+		.mode		= 0644,
+		.proc_handler	= devkmsg_sysctl_set_loglvl,
+	},
+	{
+		.procname	= "dmesg_restrict",
+		.data		= &dmesg_restrict,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax_sysadmin,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "kptr_restrict",
+		.data		= &kptr_restrict,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax_sysadmin,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{}
+};
+
+void __init printk_sysctl_init(void)
+{
+	register_sysctl_init("kernel", printk_sysctls);
+}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7745c9b72bda..02ef27804601 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -907,17 +907,6 @@ static int proc_taint(struct ctl_table *table, int write,
 	return err;
 }
 
-#ifdef CONFIG_PRINTK
-static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-}
-#endif
-
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
  * @min: pointer to minimum allowable value
@@ -2209,63 +2198,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
-#if defined CONFIG_PRINTK
-	{
-		.procname	= "printk",
-		.data		= &console_loglevel,
-		.maxlen		= 4*sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "printk_ratelimit",
-		.data		= &printk_ratelimit_state.interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "printk_ratelimit_burst",
-		.data		= &printk_ratelimit_state.burst,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "printk_delay",
-		.data		= &printk_delay_msec,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= (void *)&ten_thousand,
-	},
-	{
-		.procname	= "printk_devkmsg",
-		.data		= devkmsg_log_str,
-		.maxlen		= DEVKMSG_STR_MAX_SIZE,
-		.mode		= 0644,
-		.proc_handler	= devkmsg_sysctl_set_loglvl,
-	},
-	{
-		.procname	= "dmesg_restrict",
-		.data		= &dmesg_restrict,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "kptr_restrict",
-		.data		= &kptr_restrict,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_sysadmin,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-#endif
 	{
 		.procname	= "ngroups_max",
 		.data		= (void *)&ngroups_max,
-- 
2.33.0

