Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C582A26508B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIJUWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgIJUVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:21:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8FC0617A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f2so2882944pgd.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7r1rfre30aGq4hYAj5mMZd9aKhfhtSFtGbHwMdeYlE0=;
        b=WSKxrRh1zgAfDwGMo9L1sYHyOSqjXp+wb+YwpqiJT/Zb3NKDCzaVVT0HbYRYHs8jtw
         syDcuriSzwueAxNmNoSgZJ3aO/+dNCwSIlBAmgYX5A9wHlOOfBJPa/yeELcCY0MiEm+v
         nylpABXf8ROfraF5ukN6PNGINg1dckKo/9qxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7r1rfre30aGq4hYAj5mMZd9aKhfhtSFtGbHwMdeYlE0=;
        b=mF8ZTCMc8qTMDCfeVvaV5VI6KqZTMdBTTZePjlYII9iTgxC5/fMc86DzxF5+cVxAXt
         gp6Xtc2lLg6F5K5hE2MqUsBOqfcXE6feg+10+Hcs4eaEyWuuL2JGzesmj719kTDDxFic
         xn3BtcK7n1M4hx3gisHSlcbTh6U8HbIIbIpnEqd6jVgISGze9a9RV7Ez2oV+sVY0AOwk
         VUH75VVSgzrYeNn/ZFQ3vvgJSqyrEoS2rTqKyGTGSI3zF52xuAoVzdEER0ribb0jw5nd
         F6KMtE/nflMSQxADELGKLf0aTzHoCb4z8kPl142KEDB5jk04kfsbjpZqQkSThtBgMOqc
         j6Ig==
X-Gm-Message-State: AOAM5316S0svpkgfr6gQcOYS9ZI2tJOEyysZ7Ocj45nrXmBTHbqiKmlp
        9Psu4PKCe1OIbKAAMFClKpaYVA==
X-Google-Smtp-Source: ABdhPJzItNXJVhR75anYSdIs4NQSDmbgQALJfcnBGhftyYgbxgDuvZlpz5suFQW/PoYrnFwTWnHvYQ==
X-Received: by 2002:a62:7809:: with SMTP id t9mr6934123pfc.105.1599769280337;
        Thu, 10 Sep 2020 13:21:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j9sm6655836pfe.170.2020.09.10.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 13:21:16 -0700 (PDT)
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
Subject: [RFC PATCH 4/6] security/fbfam: Add a new sysctl to control the crashing rate threshold
Date:   Thu, 10 Sep 2020 13:21:05 -0700
Message-Id: <20200910202107.3799376-5-keescook@chromium.org>
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

This is a previous step to add the detection feature.

A fork brute force attack will be detected when an application crashes
quickly. Since, a rate can be defined as a time per fault, add a new
sysctl to control the crashing rate threshold.

This way, each system can tune the detection's sensibility adjusting the
milliseconds per fault. So, if the application's crashing rate falls
under this threshold an attack will be detected. So, the higher this
value, the faster an attack will be detected.

Signed-off-by: John Wood <john.wood@gmx.com>
---
 include/fbfam/fbfam.h   |  4 ++++
 kernel/sysctl.c         |  9 +++++++++
 security/fbfam/Makefile |  1 +
 security/fbfam/fbfam.c  | 11 +++++++++++
 security/fbfam/sysctl.c | 20 ++++++++++++++++++++
 5 files changed, 45 insertions(+)
 create mode 100644 security/fbfam/sysctl.c

diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
index b5b7d1127a52..2cfe51d2b0d5 100644
--- a/include/fbfam/fbfam.h
+++ b/include/fbfam/fbfam.h
@@ -3,8 +3,12 @@
 #define _FBFAM_H_
 
 #include <linux/sched.h>
+#include <linux/sysctl.h>
 
 #ifdef CONFIG_FBFAM
+#ifdef CONFIG_SYSCTL
+extern struct ctl_table fbfam_sysctls[];
+#endif
 int fbfam_fork(struct task_struct *child);
 int fbfam_execve(void);
 int fbfam_exit(void);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 09e70ee2332e..c3b4d737bef3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -77,6 +77,8 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
+#include <fbfam/fbfam.h>
+
 #ifdef CONFIG_X86
 #include <asm/nmi.h>
 #include <asm/stacktrace.h>
@@ -2660,6 +2662,13 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+#endif
+#ifdef CONFIG_FBFAM
+	{
+		.procname	= "fbfam",
+		.mode		= 0555,
+		.child		= fbfam_sysctls,
+	},
 #endif
 	{ }
 };
diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
index f4b9f0b19c44..b8d5751ecea4 100644
--- a/security/fbfam/Makefile
+++ b/security/fbfam/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FBFAM) += fbfam.o
+obj-$(CONFIG_SYSCTL) += sysctl.o
diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 0387f95f6408..9be4639b72eb 100644
--- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -7,6 +7,17 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 
+/**
+ * sysctl_crashing_rate_threshold - Crashing rate threshold.
+ *
+ * The rate's units are in milliseconds per fault.
+ *
+ * A fork brute force attack will be detected if the application's crashing rate
+ * falls under this threshold. So, the higher this value, the faster an attack
+ * will be detected.
+ */
+unsigned long sysctl_crashing_rate_threshold = 30000;
+
 /**
  * struct fbfam_stats - Fork brute force attack mitigation statistics.
  * @refc: Reference counter.
diff --git a/security/fbfam/sysctl.c b/security/fbfam/sysctl.c
new file mode 100644
index 000000000000..430323ad8e9f
--- /dev/null
+++ b/security/fbfam/sysctl.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sysctl.h>
+
+extern unsigned long sysctl_crashing_rate_threshold;
+static unsigned long ulong_one = 1;
+static unsigned long ulong_max = ULONG_MAX;
+
+struct ctl_table fbfam_sysctls[] = {
+	{
+		.procname	= "crashing_rate_threshold",
+		.data		= &sysctl_crashing_rate_threshold,
+		.maxlen		= sizeof(sysctl_crashing_rate_threshold),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &ulong_one,
+		.extra2		= &ulong_max,
+	},
+	{ }
+};
+
-- 
2.25.1

