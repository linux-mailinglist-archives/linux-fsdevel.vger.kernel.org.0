Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED42650A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIJUXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIJUWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:22:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AEC0617BC
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so576573pjb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfgkhWr5TvQdUsjIexLihHefc7s9wXFiV4jpjvqj+P4=;
        b=IcAkD4z1/2S2dWxK0asptEvpDVQMKoSNKpWAR+6zYzikYLiAPypGc6/bX5F0imPsE7
         MkE0O1TZK8LaTu5qFlEQkg4K5glh23k39a6UqEbwmlwKwof7KYPT/0hXh4MNToieMUdR
         JYV1fCi//9FyuuJt8WiHG8zeHG9pAxzJd/fSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfgkhWr5TvQdUsjIexLihHefc7s9wXFiV4jpjvqj+P4=;
        b=uSzEhDUkiL4e6I9fF7nmyqGx62sMSAgWko74nyz1KqEsbJcgRlkZtXwTaEJ0CTBaP9
         EI9U7ZSmoSwtcXHy2cjRHOBIkmLeTDx7CtnshvHdEPA1bmRt21xezVPlu4qeRK8WPwnf
         Eru+m3LwBpWiw7Kqx3a3G/6Lp5yH0sNES2RgyEHwBN6xb1a++IfqyZX1i2I11BesRJKT
         JdbwYTg1PoWf3DqLCmecYjikrLMrlBSlspFDMBAiGoDDR3wHSY5MX3nHBDKGe7QcJOLg
         XB2udBzhYAd4TlBLNKKhyQ1AVtEvudpyG4LrDG+xHg98JwXsASRRiEB8zjc47BrMTowM
         rH7Q==
X-Gm-Message-State: AOAM530jHtSShfPeABUfsEH3YPUwvXtCs6igHXLvyYhGSRnyAYEDHOlV
        2vnprgb47Le6QRg3ZnywAfgXZw==
X-Google-Smtp-Source: ABdhPJzB6YHe1rp5zg2xo+FQRvAQwCLx++qVkJQa5at9cU43jBjrpf+5y4Cf716aA6XzEhbVIBp+Zw==
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr1520840pju.166.1599769283338;
        Thu, 10 Sep 2020 13:21:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r123sm7002776pfc.187.2020.09.10.13.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 13:21:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     Kees Cook <keescook@chromium.org>, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force attack
Date:   Thu, 10 Sep 2020 13:21:07 -0700
Message-Id: <20200910202107.3799376-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
References: <20200910202107.3799376-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Wood <john.wood@gmx.com>

In order to mitigate a fork brute force attack it is necessary to kill
all the offending tasks. This tasks are all the ones that share the
statistical data with the current task (the task that has crashed).

Since the attack detection is done in the function fbfam_handle_attack()
that is called every time a core dump is triggered, only is needed to
kill the others tasks that share the same statistical data, not the
current one as this is in the path to be killed.

When the SIGKILL signal is sent to the offending tasks from the function
fbfam_kill_tasks(), this one will be called again during the core dump
due to the shared statistical data shows a quickly crashing rate. So, to
avoid kill again the same tasks due to a recursive call of this
function, it is necessary to disable the attack detection.

To disable this attack detection, add a condition in the function
fbfam_handle_attack() to not compute the crashing rate when the jiffies
stored in the statistical data are set to zero.

Signed-off-by: John Wood <john.wood@gmx.com>
---
 security/fbfam/fbfam.c | 76 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 3aa669e4ea51..173a6122390f 100644
--- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -4,8 +4,11 @@
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/jiffies.h>
+#include <linux/pid.h>
 #include <linux/printk.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/sched/signal.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 
@@ -24,7 +27,8 @@ unsigned long sysctl_crashing_rate_threshold = 30000;
  * struct fbfam_stats - Fork brute force attack mitigation statistics.
  * @refc: Reference counter.
  * @faults: Number of crashes since jiffies.
- * @jiffies: First fork or execve timestamp.
+ * @jiffies: First fork or execve timestamp. If zero, the attack detection is
+ *           disabled.
  *
  * The purpose of this structure is to manage all the necessary information to
  * compute the crashing rate of an application. So, it holds a first fork or
@@ -175,13 +179,69 @@ int fbfam_exit(void)
 }
 
 /**
- * fbfam_handle_attack() - Fork brute force attack detection.
+ * fbfam_kill_tasks() - Kill the offending tasks
+ *
+ * When a fork brute force attack is detected it is necessary to kill all the
+ * offending tasks. Since this function is called from fbfam_handle_attack(),
+ * and so, every time a core dump is triggered, only is needed to kill the
+ * others tasks that share the same statistical data, not the current one as
+ * this is in the path to be killed.
+ *
+ * When the SIGKILL signal is sent to the offending tasks, this function will be
+ * called again during the core dump due to the shared statistical data shows a
+ * quickly crashing rate. So, to avoid kill again the same tasks due to a
+ * recursive call of this function, it is necessary to disable the attack
+ * detection setting the jiffies to zero.
+ *
+ * To improve the for_each_process loop it is possible to end it when all the
+ * tasks that shared the same statistics are found.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zero
+ *         otherwise.
+ */
+static int fbfam_kill_tasks(void)
+{
+	struct fbfam_stats *stats = current->fbfam_stats;
+	struct task_struct *p;
+	unsigned int to_kill, killed = 0;
+
+	if (!stats)
+		return -EFAULT;
+
+	to_kill = refcount_read(&stats->refc) - 1;
+	if (!to_kill)
+		return 0;
+
+	/* Disable the attack detection */
+	stats->jiffies = 0;
+	rcu_read_lock();
+
+	for_each_process(p) {
+		if (p == current || p->fbfam_stats != stats)
+			continue;
+
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
+		pr_warn("fbfam: Offending process with PID %d killed\n",
+			p->pid);
+
+		killed += 1;
+		if (killed >= to_kill)
+			break;
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
+/**
+ * fbfam_handle_attack() - Fork brute force attack detection and mitigation.
  * @signal: Signal number that causes the core dump.
  *
  * The crashing rate of an application is computed in milliseconds per fault in
  * each crash. So, if this rate goes under a certain threshold there is a clear
  * signal that the application is crashing quickly. At this moment, a fork brute
- * force attack is happening.
+ * force attack is happening. Under this scenario it is necessary to kill all
+ * the offending tasks in order to mitigate the attack.
  *
  * Return: -EFAULT if the current task doesn't have statistical data. Zero
  *         otherwise.
@@ -195,6 +255,10 @@ int fbfam_handle_attack(int signal)
 	if (!stats)
 		return -EFAULT;
 
+	/* The attack detection is disabled */
+	if (!stats->jiffies)
+		return 0;
+
 	if (!(signal == SIGILL || signal == SIGBUS || signal == SIGKILL ||
 	      signal == SIGSEGV || signal == SIGSYS))
 		return 0;
@@ -205,9 +269,11 @@ int fbfam_handle_attack(int signal)
 	delta_time = jiffies64_to_msecs(delta_jiffies);
 	crashing_rate = delta_time / (u64)stats->faults;
 
-	if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
-		pr_warn("fbfam: Fork brute force attack detected\n");
+	if (crashing_rate >= (u64)sysctl_crashing_rate_threshold)
+		return 0;
 
+	pr_warn("fbfam: Fork brute force attack detected\n");
+	fbfam_kill_tasks();
 	return 0;
 }
 
-- 
2.25.1

