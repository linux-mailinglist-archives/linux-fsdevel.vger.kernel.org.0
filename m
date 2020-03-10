Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1305180296
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 16:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCJP5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 11:57:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46196 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgCJP5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:57:06 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jBhFf-0001iP-C8
        for linux-fsdevel@vger.kernel.org; Tue, 10 Mar 2020 15:57:03 +0000
Received: by mail-wm1-f72.google.com with SMTP id z12so569984wml.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 08:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bU2bAsKCmhGtQG8kyL29QcjXAg6Y2S3H5JueO4Uiyo=;
        b=Bmrrz6aqiEQ3FYX7RXJIbs2KoeD3Mj3rZ4sLmvYk9nEAZ/aAcm9Y4SCT6lLd5CB4lq
         wkzGsb6aYtGKhcWCTXq5i4Z7IpLKI1nRVVywoHLvIX5pCQx/rzbKSVwZDB3HTaPJp4De
         XUsF+29UT6DKNGOjnXoQiFFY3vVXjdN7NuX2j+mFhDdXXIkc+wfvS2M0IhhI8B3vlWG+
         Vrru7sqkOYZUv67Lwx+WWOxdqkyH+MTYIFGFQiJYA7CBs194esIV/rmFEd95k1tp7m7T
         LGL9IkboUXg+Nn7UV5uEzn4Lh05fxqZH3QQ8OjwmxybO/1xLXB7S6dbW4/wbLuIMAU3H
         icnA==
X-Gm-Message-State: ANhLgQ2ah4TXEdObrK18Hhr0F7uvrEFl/8ebRtjYMMGI2l+eN5gKUvNm
        p9O+sQTC9L3TSdaYk/KsY/H9ugPYRQuqXcUgVt4uYT02r/UhM9VZY1sAjf8BoxDEfCJiIp7RLW1
        cORTdTQ8x2zHRcWw5kNZBcKTzH8Ay47JvNed2VutuFE8=
X-Received: by 2002:a5d:4382:: with SMTP id i2mr27043805wrq.424.1583855822760;
        Tue, 10 Mar 2020 08:57:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtwXC/I1eK0vh+vQ0Rr6XLMpACaGQdcAhI6O2uc9M49Po4n8L+6y3hqKiqs5jQnam6z0Du/0g==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr27043774wrq.424.1583855822450;
        Tue, 10 Mar 2020 08:57:02 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id r19sm4461075wmh.26.2020.03.10.08.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:57:01 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        gpiccoli@canonical.com, kernel@gpiccoli.net,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] kernel/hung_task.c: Introduce sysctl to print all traces when a hung task is detected
Date:   Tue, 10 Mar 2020 12:56:50 -0300
Message-Id: <20200310155650.17968-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks before panic")
introduced a change in that we started to show all CPUs backtraces when a
hung task is detected _and_ the sysctl/kernel parameter "hung_task_panic"
is set. The idea is good, because usually when observing deadlocks (that
may lead to hung tasks), the culprit is another task holding a lock and
not necessarily the task detected as hung.

The problem with this approach is that dumping backtraces is a slightly
expensive task, specially printing that on console (and specially in many
CPU machines, as servers commonly found nowadays). So, users that plan to
collect a kdump to investigate the hung tasks and narrow down the deadlock
definitely don't need the CPUs backtrace on dmesg/console, which will delay
the panic and pollute the log (crash tool would easily grab all CPUs traces
with 'bt -a' command).
Also, there's the reciprocal scenario: some users may be interested in
seeing the CPUs backtraces but not have the system panic when a hung task
is detected. The current approach hence is almost as embedding a policy in
the kernel, by forcing the CPUs backtraces' dump (only) on hung_task_panic.

This patch decouples the panic event on hung task from the CPUs backtraces
dump, by creating (and documenting) a new sysctl/kernel parameter called
"hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
individual control. The new mechanism for dumping the CPUs backtraces on
hung task detection respects "hung_task_warnings" by not dumping the
traces in case there's no warnings left.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
 include/linux/sched/sysctl.h                  |  7 +++++
 kernel/hung_task.c                            | 30 +++++++++++++++++--
 kernel/sysctl.c                               | 11 +++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index adf77ead02c3..4c6595b5f6c8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1453,6 +1453,12 @@
 			x86-64 are 2M (when the CPU supports "pse") and 1G
 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
 
+	hung_task_all_cpu_backtrace=
+			[KNL] Should kernel generates backtraces on all cpus
+			when a hung task is detected. Defaults to 0 and can
+			be controlled by hung_task_all_cpu_backtrace sysctl.
+			Format: <integer>
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: <integer>
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 95b2f3256323..218c717c1354 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -40,6 +40,7 @@ show up in /proc/sys/kernel:
 - hotplug
 - hardlockup_all_cpu_backtrace
 - hardlockup_panic
+- hung_task_all_cpu_backtrace
 - hung_task_panic
 - hung_task_check_count
 - hung_task_timeout_secs
@@ -339,6 +340,20 @@ Path for the hotplug policy agent.
 Default value is "/sbin/hotplug".
 
 
+hung_task_all_cpu_backtrace:
+================
+
+Determines if kernel should NMI all CPUs to dump their backtraces when
+a hung task is detected. This file shows up if CONFIG_DETECT_HUNG_TASK
+and CONFIG_SMP are enabled.
+
+0: Won't show all CPUs backtraces when a hung task is detected.
+This is the default behavior.
+
+1: Will NMI all CPUs and dump their backtraces when a hung task
+is detected.
+
+
 hung_task_panic:
 ================
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..8cd29440ec8a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -7,6 +7,13 @@
 struct ctl_table;
 
 #ifdef CONFIG_DETECT_HUNG_TASK
+
+#ifdef CONFIG_SMP
+extern unsigned int sysctl_hung_task_all_cpu_backtrace;
+#else
+#define sysctl_hung_task_all_cpu_backtrace 0
+#endif /* CONFIG_SMP */
+
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..54152b26117e 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -53,9 +53,28 @@ int __read_mostly sysctl_hung_task_warnings = 10;
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
 static bool hung_task_call_panic;
+static bool hung_task_show_bt;
 
 static struct task_struct *watchdog_task;
 
+#ifdef CONFIG_SMP
+/*
+ * Should we dump all CPUs backtraces in a hung task event?
+ * Defaults to 0, can be changed either via cmdline or sysctl.
+ */
+unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
+
+static int __init hung_task_backtrace_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &sysctl_hung_task_all_cpu_backtrace);
+
+	if (rc)
+		return rc;
+	return 1;
+}
+__setup("hung_task_all_cpu_backtrace=", hung_task_backtrace_setup);
+#endif /* CONFIG_SMP */
+
 /*
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
@@ -137,6 +156,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			" disables this message.\n");
 		sched_show_task(t);
 		hung_task_show_lock = true;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			hung_task_show_bt = true;
 	}
 
 	touch_nmi_watchdog();
@@ -201,10 +223,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	rcu_read_unlock();
 	if (hung_task_show_lock)
 		debug_show_all_locks();
-	if (hung_task_call_panic) {
+
+	if (hung_task_show_bt) {
+		hung_task_show_bt = false;
 		trigger_all_cpu_backtrace();
+	}
+
+	if (hung_task_call_panic)
 		panic("hung_task: blocked tasks");
-	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..238f268de486 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1098,6 +1098,17 @@ static struct ctl_table kern_table[] = {
 	},
 #endif
 #ifdef CONFIG_DETECT_HUNG_TASK
+#ifdef CONFIG_SMP
+	{
+		.procname	= "hung_task_all_cpu_backtrace",
+		.data		= &sysctl_hung_task_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
 	{
 		.procname	= "hung_task_panic",
 		.data		= &sysctl_hung_task_panic,
-- 
2.25.1

