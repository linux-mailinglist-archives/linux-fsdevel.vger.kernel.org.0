Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129B72125C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgGBOLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbgGBOLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:11:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3CC08C5C1;
        Thu,  2 Jul 2020 07:11:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so8528022pfg.5;
        Thu, 02 Jul 2020 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1pH1ebKF/UI6gdhZ9svi5sBPO6+C9yjRjx8NrHnZlkc=;
        b=t+PI9pmEghzftnVhVQf23D+ENLvl3pp+Sx3wdAPL9mXvRsyBDagRdehgvtX+3tGytq
         H1Da9FjTMYQ4WEITvpQm0S5I8wm/LXqT0lfs7VCGEfRQIdGwd3f5vMYCdhxyhvX2gdE2
         NmATPpaMxnCMf3AyisW1WNSpNL9hAs2S4rWoL5iHB+F3h83E8FqgJBA/T/RB0NxdDZue
         msNVk1/EWrqFojsPEhqHdwjMq653SaMDUE8jm1xsT2U2IQhz9Q9Bd7TlN9f+QA7378dK
         4LMkQ8kQ5fYz1bPWEqGXYl3ZMu1H4Tx2dnpzA9YsyAtRzNXkpkpnpAO+2Vh/LGz529ZL
         Av4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1pH1ebKF/UI6gdhZ9svi5sBPO6+C9yjRjx8NrHnZlkc=;
        b=tmuUXkMAvT1NqIJn2o16CvunmlNNYmZT9qnRL6OpH3kFDIEMqur3ynleB58JFOZuxW
         +0Dsh2pr79bCga07AQMDdQ90DKVbFQNaXYNoMVYQl4pVRZe9a1heFFGuQU2uTNZ4e6pq
         zTuzOy3sgDNDnUhqXlvkNN9d9XiSorUXwPmbBX9P+MvJArAyighz+DhSmKGDy/g9KgEa
         1PXmGHvCk2fwfClxX6a5VBjHHiIw9MqHfB+K4ghn2DVREXXyKp9Ca7DKb1dchDNI+RZR
         M9KEHYjS+OdMxC/9bRfFeN7gKpu3bz7onRmyP2tJbg1EgATA6B4Ij4XVVjfLo6nAXkAR
         eREw==
X-Gm-Message-State: AOAM532Uf/w+Pk3YBDxZv8VQfFmkq5oW2BAyMXc1GJPxg/zrYXl+pYH4
        a3RIjckIl2oCSORQU0lOaZ4=
X-Google-Smtp-Source: ABdhPJxrUS55YlQXENV7rqxqQBQpvC5pacs+YAAP8eL0N6rfzUztmjXwWbStGaeUverXDecXPuWeNw==
X-Received: by 2002:a63:e23:: with SMTP id d35mr23779107pgl.435.1593699072962;
        Thu, 02 Jul 2020 07:11:12 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g5sm6173330pfh.168.2020.07.02.07.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:11:12 -0700 (PDT)
From:   yang che <chey84736@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yang che <chey84736@gmail.com>
Subject: [RFC] hung_task:add detecting task in D state milliseconds timeout
Date:   Thu,  2 Jul 2020 22:08:13 +0800
Message-Id: <1593698893-6371-1-git-send-email-chey84736@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

current hung_task_check_interval_secs and hung_task_timeout_secs
only supports seconds.in some cases,the TASK_UNINTERRUPTIBLE state
takes less than 1 second.The task of the graphical interface,
the unterruptible state lasts for hundreds of milliseconds
will cause the interface to freeze

echo 1 > /proc/sys/kernel/hung_task_milliseconds
value of hung_task_check_interval_secs and hung_task_timeout_secs whill
to milliseconds

Signed-off-by: yang che <chey84736@gmail.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/hung_task.c           | 33 +++++++++++++++++++++++++++------
 kernel/sysctl.c              |  9 +++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49..e5e5de2 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -16,6 +16,7 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
 
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
+extern unsigned int  sysctl_hung_task_millisecond;
 extern unsigned long sysctl_hung_task_timeout_secs;
 extern unsigned long sysctl_hung_task_check_interval_secs;
 extern int sysctl_hung_task_warnings;
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index ce76f49..7f34912 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -44,6 +44,14 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
 
 /*
+ * sysctl_hung_task_milliseconds is enable milliseconds
+ *
+ * if is 1 , hung_task_timeout_secs and hung_task_check_interval_secs will
+ * means set to millisecondsuse. as hung_task_timeout_secs is 5, will 5 milliseconds
+ */
+unsigned int __read_mostly sysctl_hung_task_millisecond;
+
+/*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
  */
 unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
@@ -108,8 +116,13 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		t->last_switch_time = jiffies;
 		return;
 	}
-	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
-		return;
+	if (sysctl_hung_task_millisecond) {
+		if (time_is_after_jiffies(t->last_switch_time + (timeout * HZ) / 1000))
+			return;
+	} else {
+		if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+			return;
+	}
 
 	trace_sched_process_hang(t);
 
@@ -126,8 +139,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		if (sysctl_hung_task_millisecond)
+			pr_err("INFO: task %s:%d blocked for more than %ld milliiseconds.\n",
+				t->comm, t->pid, (jiffies - t->last_switch_time) / HZ * 1000);
+		else
+			pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
+				t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
@@ -217,8 +234,12 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 				 unsigned long timeout)
 {
 	/* timeout of 0 will disable the watchdog */
-	return timeout ? last_checked - jiffies + timeout * HZ :
-		MAX_SCHEDULE_TIMEOUT;
+	if (sysctl_hung_task_millisecond)
+		return timeout ? last_checked - jiffies + (timeout * HZ) / 1000 :
+			MAX_SCHEDULE_TIMEOUT;
+	else
+		return timeout ? last_checked - jiffies + timeout * HZ :
+			MAX_SCHEDULE_TIMEOUT;
 }
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..0bdcd66 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2476,6 +2476,15 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
+		.procname       = "hung_task_milliseconds",
+		.data           = &sysctl_hung_task_millisecond,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{
 		.procname	= "hung_task_timeout_secs",
 		.data		= &sysctl_hung_task_timeout_secs,
 		.maxlen		= sizeof(unsigned long),
-- 
2.7.4

