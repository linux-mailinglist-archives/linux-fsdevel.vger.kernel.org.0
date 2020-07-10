Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECE21AF3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJGPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 02:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJGPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:15:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD5C08C5CE;
        Thu,  9 Jul 2020 23:15:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u18so2073364pfk.10;
        Thu, 09 Jul 2020 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3UDisdmmxAxoVFDA02zf8tgRXf0NT2qryD8Bj88ZzkU=;
        b=CCNnBzGlzx2kwlJE26zUeWzUawQ+jCzFseRnJJDqF/W9ziK8E58GyapnxXQnmKOmnG
         lpeljdj6FVx0JZKwIm2KDmLULADPCUJXz4DdB0K88wMCWV0CqQ6TiQ18FzmOtKPF9pPh
         Ofkj9xNfQ56eJF4Hk8/TWYwmPbn1EFRlLDYpXRjRBatdth70hPEBrhjgu5wgJ87XDIKF
         mNzLsb88HZaL5aMDK0V80Ar6QJhG7Y5M8w3AHFZGE2ccazhL6rMFx6viXQEDCQhZ8C29
         S2P9fN9upJ1Ok7MR/7Wll0Ix/7SXeAKOg8QxQy47ujRyW3vOEsGDfBDD+VRCgSHvZjcZ
         Mp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UDisdmmxAxoVFDA02zf8tgRXf0NT2qryD8Bj88ZzkU=;
        b=WO/yZXmvHyp/UzBgJdRnAJFSP8ydorh/lELGts+wEB9VnKhoTWo8nEL5a69rI/o+ej
         7rh5NAlxynyGJl6o+I8JDcfyu1HJ/dQwsi5FsSfPY4KkJBKAGa2mOfg3P+VYv1G2EScU
         8AnW0lMPusmEGvwAGk4/Cyr91yJduOcZTmoOeg2eEEUsu+cHmfZb1hDmd2jAqXmDh6hF
         COpg/u1YlZvHNX9PBt4tRXtK0EJGBk3pInzJA8sWbjPnJJWR1IjxVtJWKmQv6A7iW6Tz
         Vyp++A4l1YFBT8bWuUu8EID4gaYu6jjW87mi4xN2ymfd7oMXKeapSIs5Sai8EUWMV7Ua
         XuCQ==
X-Gm-Message-State: AOAM532o019p8TZGCxALVHOeYKCsXFVUB8yT4Dhzah+t5MmTisaXz7kN
        //VwYwQQpjLc8bKJjHs/WYs=
X-Google-Smtp-Source: ABdhPJwVmqZUAAKfhO3/uTq/APmG/M/vVevTvaXd5iCq2GNOukYygaFFeyJ1gQdq7JJEVW4TbnRU2w==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr17832268pgp.67.1594361747517;
        Thu, 09 Jul 2020 23:15:47 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j13sm4372525pjz.8.2020.07.09.23.15.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 23:15:47 -0700 (PDT)
From:   yang che <chey84736@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yang che <chey84736@gmail.com>
Subject: [PATCH v3] hung_task:add detecting task in D state milliseconds timeout
Date:   Fri, 10 Jul 2020 14:15:15 +0800
Message-Id: <1594361715-25325-1-git-send-email-chey84736@gmail.com>
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

