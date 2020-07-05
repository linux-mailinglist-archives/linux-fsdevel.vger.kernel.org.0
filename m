Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FCF214C77
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGEMt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 08:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGEMt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:49:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3DC061794;
        Sun,  5 Jul 2020 05:49:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so6276056pjg.3;
        Sun, 05 Jul 2020 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Aj40E3vlw0EzHeK0WU01GA5Zuc/XtjNbFyYn4gYvCAo=;
        b=RYM2H25OcxnyT1kzSYmB8h461hXG2zCMIq1XhMv0IG0y/ITnvsyj6WJJ5Pv4joZkBh
         rbQFmOwRGoLPsNDiCeUzYZgzuDrDOz6+PYXbkcfXGqR1bs/vgwOseqH7nfd/Az7M5CHy
         gyC4aZe6PYhA4REP64q1bTPidLwhUMNq1/qmra4dTgguXORHdjqe0Ka4VGLYQ3EeJZUl
         7LPiYqX9LJBqfxShPR5NO4u4MmPE/4qT9yktFPPOtqwImagnNL/3ZVoNvUY11WUo/MpX
         j5qEQBYmLJ7lAkVo7GXEhGLa4HdwIgR3Fi6nNdAefolJULmtpTy4WFNqjdMjJIVKeCKZ
         Oh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aj40E3vlw0EzHeK0WU01GA5Zuc/XtjNbFyYn4gYvCAo=;
        b=aMjHbWd/1vRioeTcn2f5RDty0ilxeDt2U4fxsO8IZhtsagOeWY5f8EPy9xuJRMpgrL
         iee6gxBBCsuTOayXpy5a2OiKLrpXTAfuFlQsIp3kG9hc09kKtQy5L6LB2gqBmicszVYY
         LJHeeUqo37cz0Rnh6AbCFy6cti+PNO/IUzg/mp4Pqqr7VO5gHMoz3EocCXh6tDFGsjrq
         UFBW2Fm5KUbqjnBgi/GO2WzqnMiIqbp/w07+ZaNofhBzKzwdgDPz6MNQPshaAsjrEi9J
         WCv7xXccpZ6+Wd+km/8VgVYYmyrMTvpcX5F9BipwkVWNKgsNxjDMBnvvpTfH10cF4C7j
         Nq1w==
X-Gm-Message-State: AOAM533Npzmqsfg85PN6eZvO7TH/lLvRYQs3QVGZMGDMZD8ShFFIBkj0
        1zIIQ0qUiuOeNHaYjoK+bG8=
X-Google-Smtp-Source: ABdhPJyZY3GzukKAOFoczFcdoYjLdT0sF/ULpERELza3uD5+xtOfsJy0SCICVsMTPGPer1DTz5W5uA==
X-Received: by 2002:a17:902:c401:: with SMTP id k1mr16445742plk.202.1593953397440;
        Sun, 05 Jul 2020 05:49:57 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f207sm16954553pfa.107.2020.07.05.05.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2020 05:49:56 -0700 (PDT)
From:   yang che <chey84736@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yang che <chey84736@gmail.com>
Subject: [PATCH v2] hung_task:add detecting task in D state milliseconds timeout
Date:   Sun,  5 Jul 2020 20:48:52 +0800
Message-Id: <1593953332-29404-1-git-send-email-chey84736@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

current hung_task_check_interval_secs and hung_task_timeout_secs
only supports seconds. In some cases,the TASK_UNINTERRUPTIBLE state
takes less than 1 second,may need to hung task trigger panic
get ramdump or print all cpu task.

modify hung_task_check_interval_secs to hung_task_check_interval_millisecs,
check interval use milliseconds. Add hung_task_timeout_millisecs file to
set milliseconds.
task timeout = hung_task_timeout_secs * 1000 + hung_task_timeout_millisecs.
(timeout * HZ / 1000) calculate how many are generated jiffies
in timeout milliseconds.

Signed-off-by: yang che <chey84736@gmail.com>
---

v1->v2:
 add hung_task_check_interval_millisecs,hung_task_timeout_millisecs.
 fix writing to the millisecond file silently overrides the setting in
 the seconds file.

 [1]https://lore.kernel.org/lkml/CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com

 include/linux/sched/sysctl.h |  3 ++-
 kernel/hung_task.c           | 25 ++++++++++++++++++-------
 kernel/sysctl.c              | 12 ++++++++++--
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49..179c331 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -16,8 +16,9 @@ extern unsigned int sysctl_hung_task_all_cpu_backtrace;
 
 extern int	     sysctl_hung_task_check_count;
 extern unsigned int  sysctl_hung_task_panic;
+extern unsigned long  sysctl_hung_task_timeout_millisecs;
 extern unsigned long sysctl_hung_task_timeout_secs;
-extern unsigned long sysctl_hung_task_check_interval_secs;
+extern unsigned long sysctl_hung_task_check_interval_millisecs;
 extern int sysctl_hung_task_warnings;
 int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index ce76f49..809c999 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -37,6 +37,7 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
  * the RCU grace period. So it needs to be upper-bound.
  */
 #define HUNG_TASK_LOCK_BREAK (HZ / 10)
+#define SECONDS 1000
 
 /*
  * Zero means infinite timeout - no checking done:
@@ -44,9 +45,14 @@ int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
 unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_TASK_TIMEOUT;
 
 /*
+ * Zero means only use sysctl_hung_task_timeout_secs
+ */
+unsigned long  __read_mostly sysctl_hung_task_timeout_millisecs;
+
+/*
  * Zero (default value) means use sysctl_hung_task_timeout_secs:
  */
-unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
+unsigned long __read_mostly sysctl_hung_task_check_interval_millisecs;
 
 int __read_mostly sysctl_hung_task_warnings = 10;
 
@@ -108,7 +114,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		t->last_switch_time = jiffies;
 		return;
 	}
-	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
+
+	if (time_is_after_jiffies(t->last_switch_time + (timeout * HZ) / SECONDS))
 		return;
 
 	trace_sched_process_hang(t);
@@ -126,13 +133,16 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+
+		pr_err("INFO: task %s:%d blocked for more than %ld seconds %ld milliseconds.\n",
+			t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
+			(jiffies - t->last_switch_time) % HZ * (SECONDS / HZ));
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
 			init_utsname()->version);
 		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
+			"\"echo 0 > /proc/sys/kernel/hung_task_timeout_millisecs\""
 			" disables this message.\n");
 		sched_show_task(t);
 		hung_task_show_lock = true;
@@ -217,7 +227,7 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 				 unsigned long timeout)
 {
 	/* timeout of 0 will disable the watchdog */
-	return timeout ? last_checked - jiffies + timeout * HZ :
+	return timeout ? last_checked - jiffies + (timeout * HZ) / SECONDS :
 		MAX_SCHEDULE_TIMEOUT;
 }
 
@@ -281,8 +291,9 @@ static int watchdog(void *dummy)
 	set_user_nice(current, 0);
 
 	for ( ; ; ) {
-		unsigned long timeout = sysctl_hung_task_timeout_secs;
-		unsigned long interval = sysctl_hung_task_check_interval_secs;
+		unsigned long timeout = sysctl_hung_task_timeout_secs * SECONDS +
+					sysctl_hung_task_timeout_millisecs;
+		unsigned long interval = sysctl_hung_task_check_interval_millisecs;
 		long t;
 
 		if (interval == 0)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7a..8f7ac33 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2476,6 +2476,14 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 	{
+		.procname       = "hung_task_timeout_millisecs",
+		.data           = &sysctl_hung_task_timeout_millisecs,
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
+		.procname	= "hung_task_check_interval_millisecs",
+		.data		= &sysctl_hung_task_check_interval_millisecs,
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_dohung_task_timeout_secs,
-- 
2.7.4

