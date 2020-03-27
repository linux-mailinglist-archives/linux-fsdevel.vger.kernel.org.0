Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0919196154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 23:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC0Wjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 18:39:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgC0Wjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:39:31 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jHxat-0000W0-Po
        for linux-fsdevel@vger.kernel.org; Fri, 27 Mar 2020 22:36:51 +0000
Received: by mail-qt1-f200.google.com with SMTP id b3so5203975qte.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2020 15:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O94P0uoScvdbW3wTdJiQYQPyg7B5lC7WAC85T+bbce4=;
        b=ORdyuszeXPGZ44ahLlkDT89KqWhqh8L/tLz+XOUgkD83zu62uAWwRQ5ffeKXWMWQ/j
         vBJLUTHXOLsNrX9DOm9UpB7ksiwjM9CYOVR+NwJzNZyNyXtKp7GEz/l3JukGKIe2KlTG
         iDNEs5EApxYKj4u8B+Nlzo8BYfVXwZET0bbg2a0Nfq76SQIXbxKJhf0ipsEzuAbp602r
         2Y9LSTOzS8SibL2VmRIV7hOiJQ0es+MrbAp954UUug9gk6y6BO+TBPaE/cfaZNomj3W/
         kUw2rx5muNIiU0xg3BiYKNNZfnPPZnDH4EOV4lR6gukKGPMpkkaU9Hk5LzodL1wwOhtn
         soGg==
X-Gm-Message-State: ANhLgQ2+caN4JWG9qJNsPB9qfEgtDm5hE90fCwDtYqY+8gkDvC10fSy+
        mnObd4iC6x40oot9QdL5IPbBR5pCqtRGuu8jUOWohJzX37kfSovKod1/3ejBDRxSDbOABs0UVTg
        M+zpzJeBS1JhQ2BgIRM3SleB5d4ZvQRQdxluwNM/R99k=
X-Received: by 2002:ae9:ed4a:: with SMTP id c71mr1637000qkg.418.1585348610696;
        Fri, 27 Mar 2020 15:36:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsEdbz0uv5I6GDIIDnD05XVXJ9B1aeiR0bCDmtaklFI7RlYJRhcoq0y3fccbC+JNH6yttitqQ==
X-Received: by 2002:ae9:ed4a:: with SMTP id c71mr1636966qkg.418.1585348610238;
        Fri, 27 Mar 2020 15:36:50 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id c40sm5212630qtk.18.2020.03.27.15.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:36:49 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, penguin-kernel@I-love.SAKURA.ne.jp,
        vbabka@suse.cz, rdunlap@infradead.org, willy@infradead.org,
        gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all traces when a hung task is detected
Date:   Fri, 27 Mar 2020 19:36:46 -0300
Message-Id: <20200327223646.20779-1-gpiccoli@canonical.com>
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

This patch decouples the panic event on hung task from the CPUs
backtraces dump, by creating (and documenting) a new sysctl called
"hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
individual control. The new mechanism for dumping the CPUs backtraces on
hung task detection respects "hung_task_warnings" by not dumping the
traces in case there's no warnings left.

Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---

V3: Following the suggestion from Vlastimil, removed the kernel parameter
since soon we (hopefully) will have a generic approach to set sysctls via
kernel parameters[0] - thanks Vlastimil, great idea!

Thanks,

Guilherme

[0] lore.kernel.org/lkml/20200326181606.7027-1-vbabka@suse.cz/T


 Documentation/admin-guide/sysctl/kernel.rst | 15 +++++++++++++++
 include/linux/sched/sysctl.h                |  7 +++++++
 kernel/hung_task.c                          | 20 ++++++++++++++++++--
 kernel/sysctl.c                             | 11 +++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

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
index 14a625c16cb3..9a774aee1a44 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -53,9 +53,18 @@ int __read_mostly sysctl_hung_task_warnings = 10;
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
 static bool hung_task_call_panic;
+static bool hung_task_show_all_bt;
 
 static struct task_struct *watchdog_task;
 
+#ifdef CONFIG_SMP
+/*
+ * Should we dump all CPUs backtraces in a hung task event?
+ * Defaults to 0, can be changed via sysctl.
+ */
+unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
+#endif /* CONFIG_SMP */
+
 /*
  * Should we panic (and reboot, if panic_timeout= is set) when a
  * hung task is detected:
@@ -137,6 +146,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 			" disables this message.\n");
 		sched_show_task(t);
 		hung_task_show_lock = true;
+
+		if (sysctl_hung_task_all_cpu_backtrace)
+			hung_task_show_all_bt = true;
 	}
 
 	touch_nmi_watchdog();
@@ -201,10 +213,14 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
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

