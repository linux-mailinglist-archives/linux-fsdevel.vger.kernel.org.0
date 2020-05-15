Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCD1D44AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgEOEeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:34:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgEOEeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:34:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3650B3FC3A5A4A9C49D3;
        Fri, 15 May 2020 12:33:58 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 12:33:48 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 4/4] sysctl: Add register_sysctl_init() interface
Date:   Fri, 15 May 2020 12:33:44 +0800
Message-ID: <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to eliminate the duplicate code for registering the sysctl
interface during the initialization of each feature, add the
register_sysctl_init() interface

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 include/linux/sysctl.h    |  2 ++
 kernel/hung_task_sysctl.c | 15 +--------------
 kernel/sysctl.c           | 19 +++++++++++++++++++
 kernel/watchdog.c         | 18 +-----------------
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6d741d6..3cdbe89 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -207,6 +207,8 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init(void);
+extern void register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name);
 
 extern struct ctl_table sysctl_mount_point[];
 
diff --git a/kernel/hung_task_sysctl.c b/kernel/hung_task_sysctl.c
index 62a51f5..14d2ed6 100644
--- a/kernel/hung_task_sysctl.c
+++ b/kernel/hung_task_sysctl.c
@@ -59,21 +59,8 @@
 	{}
 };
 
-/*
- * The hung task sysctl has a default value.
- * Even if register_sysctl() fails, it does not affect the main function of
- * the hung task. At the same time, during the system initialization phase,
- * malloc small memory will almost never fail.
- * So the return value is ignored here
- */
 void __init hung_task_sysctl_init(void)
 {
-	struct ctl_table_header *srt = register_sysctl("kernel", hung_task_sysctls);
-
-	if (unlikely(!srt)) {
-		pr_err("%s fail\n", __func__);
-		return;
-	}
-	kmemleak_not_leak(srt);
+	register_sysctl_init("kernel", hung_task_sysctls, "hung_task_sysctls");
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e394990..0a09742 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1823,6 +1823,25 @@ int __init sysctl_init(void)
 	return 0;
 }
 
+/*
+ * The sysctl interface is used to modify the interface value,
+ * but the feature interface has default values. Even if register_sysctl fails,
+ * the feature body function can also run. At the same time, malloc small
+ * fragment of memory during the system initialization phase, almost does
+ * not fail. Therefore, the function return is designed as void
+ */
+void __init register_sysctl_init(const char *path, struct ctl_table *table,
+				 const char *table_name)
+{
+	struct ctl_table_header *hdr = register_sysctl(path, table);
+
+	if (unlikely(!hdr)) {
+		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		return;
+	}
+	kmemleak_not_leak(hdr);
+}
+
 #endif /* CONFIG_SYSCTL */
 
 /*
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 05e1d58..c1bebb1 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,9 +23,6 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
-#ifdef CONFIG_SYSCTL
-#include <linux/kmemleak.h>
-#endif
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
@@ -853,22 +850,9 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 	{}
 };
 
-/*
- * The watchdog sysctl has a default value.
- * Even if register_sysctl() fails, it does not affect the main function of
- * the watchdog. At the same time, during the system initialization phase,
- * malloc small memory will almost never fail.
- * So the return value is ignored here
- */
 static void __init watchdog_sysctl_init(void)
 {
-	struct ctl_table_header *p = register_sysctl("kernel", watchdog_sysctls);
-
-	if (unlikely(!p)) {
-		pr_err("%s fail\n", __func__);
-		return;
-	}
-	kmemleak_not_leak(p);
+	register_sysctl_init("kernel", watchdog_sysctls, "watchdog_sysctls");
 }
 #else
 #define watchdog_sysctl_init() do { } while (0)
-- 
1.8.5.6

