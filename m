Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E60190096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCWVq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 17:46:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41303 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgCWVq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:46:27 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jGUtr-0004qh-Pw
        for linux-fsdevel@vger.kernel.org; Mon, 23 Mar 2020 21:46:23 +0000
Received: by mail-qk1-f200.google.com with SMTP id 64so6288166qkk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 14:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IyEq9cC0p84R074N8knqi4eTkTH1auwI+4lEtYST0ds=;
        b=ceXn4ob8imdt+W2rb1+W0IOwhKU5iBy9VVOHthw3dje7F/sOc3JmB3Rm3wZRel6ccG
         VvD/ZoZbNWJYL5VDMDsD8kfVHKq4I1iHjgMRFk7pedum9qJCIZ9TlwjTOV+vxRZvwaUE
         mcXtz2HSwCtHoktt239xj3unUH7dmnHKVrYwnYHfTjPWhMLlGfAdvjgdnm0BQzvQkN0g
         9VVL/KT7XMv0Z6FxAB8OaDMCmKpM2VcwUhrQ2bWwJoNR5uOUjzFXkx4wqGEltMUWrM0C
         9zVbFrCVtPox1ErR19OvB7WL4ATLa23mkDJ8ROPPPPAPXshEqYsu0Z1exIKDUalszFd6
         cRsg==
X-Gm-Message-State: ANhLgQ32T/GKSsPl+lywcrDJMsQJaGJ3cT5EE4R4+H9PXXUTTgT1EJeu
        T74BPdlorOSp30uyC7ccA4v42IQTZtrH+Byl+1WO6glN482RPcXjAPl9PzXks7bfcabxE51+njo
        CFzC6m6+ZSB3rEuK9EEqDh/BnIbQKiOQ1DKIDzV0k5cQ=
X-Received: by 2002:a37:6244:: with SMTP id w65mr23140460qkb.350.1584999982756;
        Mon, 23 Mar 2020 14:46:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuI4/eAcWMUFjJrQ5h020CG4ZX670DnngXSCdDt0sTCtBJ+f49LvAshp3E1er5aV0Dy6bfepA==
X-Received: by 2002:a37:6244:: with SMTP id w65mr23140424qkb.350.1584999982307;
        Mon, 23 Mar 2020 14:46:22 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id 5sm3398651qka.16.2020.03.23.14.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 14:46:21 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        penguin-kernel@I-love.SAKURA.ne.jp, akpm@linux-foundation.org,
        cocci@systeme.lip6.fr, linux-api@vger.kernel.org,
        gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH V2] kernel/hung_task.c: Introduce sysctl to print all traces when a hung task is detected
Date:   Mon, 23 Mar 2020 18:46:18 -0300
Message-Id: <20200323214618.28429-1-gpiccoli@canonical.com>
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


V2: Followed suggestions from Kees and Tetsuo (and other grammar
improvements). Also, followed Tetsuo suggestion to itereate kernel
testing community - but I don't really know a ML for that, so I've
CCed Coccinelle community and kernel-api ML.

Also, Tetsuo suggested that this option could be default to 1 - I'm
open to it, but given it is only available if hung_task panic is set
as of now and the goal of this patch is give users more flexibility,
I vote to keep default as 0. I can respin a V3 in case more people
want to see it enabled by default. Thanks in advance for the review!
Cheers,

Guilherme


 .../admin-guide/kernel-parameters.txt         |  6 ++++
 Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
 include/linux/sched/sysctl.h                  |  7 +++++
 kernel/hung_task.c                            | 30 +++++++++++++++++--
 kernel/sysctl.c                               | 11 +++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..7a14caac6c94 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1453,6 +1453,12 @@
 			x86-64 are 2M (when the CPU supports "pse") and 1G
 			(when the CPU supports the "pdpe1gb" cpuinfo flag).
 
+	hung_task_all_cpu_backtrace=
+			[KNL] Should kernel generate backtraces on all cpus
+			when a hung task is detected. Defaults to 0 and can
+			be controlled by hung_task_all_cpu_backtrace sysctl.
+			Format: <integer>
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: <integer>
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..8b4ff69d2348 100644
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
@@ -338,6 +339,20 @@ Path for the hotplug policy agent.
 Default value is "/sbin/hotplug".
 
 
+hung_task_all_cpu_backtrace:
+================
+
+If this option is set, the kernel will send an NMI to all CPUs to dump
+their backtraces when a hung task is detected. This file shows up if
+CONFIG_DETECT_HUNG_TASK and CONFIG_SMP are enabled.
+
+0: Won't show all CPUs backtraces when a hung task is detected.
+This is the default behavior.
+
+1: Will non-maskably interrupt all CPUs and dump their backtraces when
+a hung task is detected.
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
index 14a625c16cb3..0d76f9d25820 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -53,9 +53,28 @@ int __read_mostly sysctl_hung_task_warnings = 10;
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
 static bool hung_task_call_panic;
+static bool hung_task_show_all_bt;
 
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
+			hung_task_show_all_bt = true;
 	}
 
 	touch_nmi_watchdog();
@@ -201,10 +223,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	rcu_read_unlock();
 	if (hung_task_show_lock)
 		debug_show_all_locks();
-	if (hung_task_call_panic) {
+
+	if (hung_task_show_all_bt) {
+		hung_task_show_all_bt = false;
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

