Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D121578C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgGFMq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgGFMq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:46:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA655C061794;
        Mon,  6 Jul 2020 05:46:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so18332368pgn.7;
        Mon, 06 Jul 2020 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3UDisdmmxAxoVFDA02zf8tgRXf0NT2qryD8Bj88ZzkU=;
        b=mcUs7Cn+2N0+DolBZjF1mQ9W0RaoemEg9z1dhg5PxlaSZlTmJZWLcVCnOes/jCOx68
         fR4fCKYoNvCLtGSEaO/+QH3H/M+d8kWtMEFqBbOkaOXcDkndHINCafiDYwlxvoPQ5+d+
         61TrqLxp4KCW6J3iUugVps9y3hWQnwNKbMt1tnbYODGCz8OmiC/bOWVjFgu1ekejQUs3
         hMgevpZc+1+1Ky7fUip00QrEa2L2iR7/fnbSgHz+jyDU16teOw6nZJiGCVLx0aD305wK
         1flD7hUWwNmR/SjwS8dy4r/7By5woZtOd8xVIFQ+vlSQVzMmoGYNu/SlIsM5Jvho6NjV
         b+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UDisdmmxAxoVFDA02zf8tgRXf0NT2qryD8Bj88ZzkU=;
        b=ddF6xQkwHs85Nuul54eFfCvSFyZnsB1kuyvInKsL8Wqxka9haeFGGXzAOPSpPXcrJV
         pcOU9Wpvc93lUHN+TGGiJU54WUl4wp5Ix+Gglr3yr7zMLDc2G9lnTfmzGrnCvQR19PPn
         2Wv3WxZcZJGb23qxaba5nV08uPEe6Hb6RI59DShZxWooddXCcxBgZdZmVhLrD+iUi0un
         nG2iYznLfxDWfUFN4m6JO5yU0smEkoNsh4rAW8t4/37mtckRWCZcHc+26IpOv7DQZqTd
         kVgjqZt3SWUn1pRClwi+scK/CWRFaZN1epey3iHe49ETpuHdn7gPnhpKVfvPhwBrtKpI
         TVcg==
X-Gm-Message-State: AOAM530hiTSZDWcB9p1K6cMm6lBN/kAKC4XxU6cj2d45d1IGJLqLHb8N
        0leDTBERD3t8XgrlsALihPk=
X-Google-Smtp-Source: ABdhPJyqV8PExAxba6IkqO2rGw2HCb1TGZFPA7XcQiMO1uMhvLBaIB+Z4fYbbcUGtTwfX4bYXhfu0A==
X-Received: by 2002:a63:8c5d:: with SMTP id q29mr39122594pgn.249.1594039616345;
        Mon, 06 Jul 2020 05:46:56 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id az13sm17248951pjb.34.2020.07.06.05.46.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 05:46:55 -0700 (PDT)
From:   yang che <chey84736@gmail.com>
To:     willy@infradead.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yang che <chey84736@gmail.com>
Subject: [PATCH v3] hung_task:add detecting task in D state milliseconds timeout
Date:   Mon,  6 Jul 2020 20:45:33 +0800
Message-Id: <1594039533-26240-1-git-send-email-chey84736@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

current hung_task_check_interval_secs and hung_task_timeout_secs
only supports seconds. In some cases,the TASK_UNINTERRUPTIBLE state
takes less than 1 second,may need to hung task trigger panic
get ramdump or print all cpu task.

modify hung_task_check_interval_secs to hung_task_check_interval_msecs,
check interval use milliseconds. Add hung_task_timeout_msecs file to
set milliseconds.
task timeout = hung_task_timeout_secs * 1000 + hung_task_timeout_msecs.

Signed-off-by: yang che <chey84736@gmail.com>
---

v2->v3:
 Fix some format issues.
 add use msecs_to_jiffies,jiffies_to_msec.
 because use timeout = secs * 1000  + msecs,so sysctl_hung_task_timeout_msec
 = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT * MSEC_PER_SEC; will cause timeout is
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT double.

v1->v2:
 add hung_task_check_interval_millisecs,hung_task_timeout_millisecs.
 fix writing to the millisecond file silently overrides the setting in
 the seconds file.

 [1]https://lore.kernel.org/lkml/CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com
 [2]https://lore.kernel.org/lkml/20200705171633.GU25523@casper.infradead.org/

 include/linux/sched/sysctl.h |  3 ++-
 kernel/hung_task.c           | 31 ++++++++++++++++++++++---------
 kernel/sysctl.c              | 12 ++++++++++--
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49..41b426e 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -16,8 +16,9 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
 
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
+extern unsigned long sysctl_hung_task_timeout_msecs;
 extern unsigned long sysctl_hung_task_timeout_secs;
-extern unsigned long sysctl_hung_task_check_interval_secs;
+extern unsigned long sysctl_hung_task_check_interval_msecs;
 extern int sysctl_hung_task_warnings;
 int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index ce76f49..bac6f33 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -37,16 +37,23 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * the RCU grace period. So it needs to be upper-bound.
  */
 #define HUNG_TASK_LOCK_BREAK (HZ / 10)
+#define MSEC_PER_SEC 1000L
 
 /*
- * Zero means infinite timeout - no checking done:
+ * Zero and sysctl_hung_task_timeout_msecs zero means infinite timeout - no checking done:
  */
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
 
 /*
- * Zero (default value) means use sysctl_hung_task_timeout_secs:
+ * Zero (default value) means only use sysctl_hung_task_timeout_secs
  */
-unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
+unsigned long  __read_mostly sysctl_hung_task_timeout_msecs;
+
+/*
+ * Zero (default value) means use
+ * sysctl_hung_task_timeout_secs * MSEC_PER_SEC + sysctl_hung_task_timeout_msecs
+ */
+unsigned long __read_mostly sysctl_hung_task_check_interval_msecs;
 
 int __read_mostly sysctl_hung_task_warnings = 10;
 
@@ -108,7 +115,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		t->last_switch_time = jiffies;
 		return;
 	}
-	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+
+	if (time_is_after_jiffies(t->last_switch_time + msecs_to_jiffies(timeout)))
 		return;
 
 	trace_sched_process_hang(t);
@@ -126,13 +134,17 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+
+		pr_err("INFO: task %s:%d blocked for more than %ld.%03ld seconds.\n",
+			t->comm, t->pid,
+			jiffies_to_msecs(jiffies - t->last_switch_time) / MSEC_PER_SEC,
+			jiffies_to_msecs(jiffies - t->last_switch_time) % MSEC_PER_SEC);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
 			init_utsname()->version);
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
+			"\"echo 0 > /proc/sys/kernel/hung_task_timeout_msecs\""
 			" disables this message.\n");
 		sched_show_task(t);
 		hung_task_show_lock = true;
@@ -217,7 +229,7 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 				 unsigned long timeout)
 {
 	/* timeout of 0 will disable the watchdog */
-	return timeout ? last_checked - jiffies + timeout * HZ :
+	return timeout ? last_checked - jiffies + msecs_to_jiffies(timeout) :
 		MAX_SCHEDULE_TIMEOUT;
 }
 
@@ -281,8 +293,9 @@ static int watchdog(void *dummy)
 	set_user_nice(current, 0);
 
 	for ( ; ; ) {
-		unsigned long timeout = sysctl_hung_task_timeout_secs;
-		unsigned long interval = sysctl_hung_task_check_interval_secs;
+		unsigned long timeout = sysctl_hung_task_timeout_secs * MSEC_PER_SEC +
+					sysctl_hung_task_timeout_msecs;
+		unsigned long interval = sysctl_hung_task_check_interval_msecs;
 		long t;
 
 		if (interval == 0)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..5c52759 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2476,6 +2476,14 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
+		.procname       = "hung_task_timeout_msecs",
+		.data           = &sysctl_hung_task_timeout_msecs,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = proc_dohung_task_timeout_secs,
+		.extra2         = &hung_task_timeout_max,
+	},
+	{
 		.procname	= "hung_task_timeout_secs",
 		.data		= &sysctl_hung_task_timeout_secs,
 		.maxlen		= sizeof(unsigned long),
@@ -2484,8 +2492,8 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &hung_task_timeout_max,
 	},
 	{
-		.procname	= "hung_task_check_interval_secs",
-		.data		= &sysctl_hung_task_check_interval_secs,
+		.procname	= "hung_task_check_interval_msecs",
+		.data		= &sysctl_hung_task_check_interval_msecs,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_timeout_secs,
-- 
2.7.4

