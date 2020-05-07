Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDD1C9DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGVvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:51:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGVvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:51:51 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jWoLe-0000Ef-8K
        for linux-fsdevel@vger.kernel.org; Thu, 07 May 2020 21:46:30 +0000
Received: by mail-qv1-f70.google.com with SMTP id ev8so7296844qvb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvPfmcdMdphP7PKHpPwwL797MmH4rqHB2sXxdxkGfdE=;
        b=tSsVC3F9COZnc+pjIZiUbwxcSaItQJKBOO8kgEeaDoHORq827xmoeLEat4FgtmnZ/m
         bFhvh9xIPlumngzMYUb9x7AWLOYyeWXZ/0GGroJGaVpT3Qthd7GxgEamtV33vVvabPgT
         mYsMjQ0qMvVJUK8NeYvDLmTzCEoePTqco4HYYuTDWCCfSIvGbmL8W6sB53is5soX1qU8
         t8oa9RGeycQzo8h4wzinVf992EzC+jAS7JSWmiFvv/Jj7GBy27g9O9kGiLHOL4udW9li
         x1A6hfYZL8Xu7Vr3F4XGBJV0eUb5EtXmOsfQJ7Ehvt4P/gx7Gq8UL04jhIUVxmSitFFW
         SJGw==
X-Gm-Message-State: AGi0PuaXqPAQivb91MQltjjla7RnRr03zuZFayR79S19cCx+REMVBIsh
        Tbh4iEZtpMpj63o4vUqvniX0y52Ezn7So79XZ0kmoJ0q2rPduO7kfDMV4teaHz7fNv7IYwO8Hkg
        x29iwlm9kn1yIFRPE70x6dKTwwirI6iiU0WyZ9FuUyYY=
X-Received: by 2002:aed:2467:: with SMTP id s36mr4968182qtc.292.1588887988937;
        Thu, 07 May 2020 14:46:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIYU4MHFu72sGxvnvZgRXzKhk08WjfxU8yTpSPMTDnzbVSTQ8dP3C8CfZL/vDirDutyf/BGqw==
X-Received: by 2002:aed:2467:: with SMTP id s36mr4968163qtc.292.1588887988568;
        Thu, 07 May 2020 14:46:28 -0700 (PDT)
Received: from localhost ([187.56.73.116])
        by smtp.gmail.com with ESMTPSA id s15sm5498340qtc.31.2020.05.07.14.46.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 14:46:27 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, mcgrof@kernel.org, vbabka@suse.cz,
        gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot parameters to sysctl aliases
Date:   Thu,  7 May 2020 18:46:24 -0300
Message-Id: <20200507214624.21911-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After a recent change introduced by Vlastimil's series [0], kernel is
able now to handle sysctl parameters on kernel command line; also, the
series introduced a simple infrastructure to convert legacy boot
parameters (that duplicate sysctls) into sysctl aliases.

This patch converts the watchdog parameters softlockup_panic and
{hard,soft}lockup_all_cpu_backtrace to use the new alias infrastructure.
It fixes the documentation too, since the alias only accepts values 0
or 1, not the full range of integers. We also took the opportunity here
to improve the documentation of the previously converted hung_task_panic
(see the patch series [0]) and put the alias table in alphabetical order.

[0] lore.kernel.org/lkml/20200427180433.7029-1-vbabka@suse.cz

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---


This patch is based on linux-next/akpm branch, at d0f3f6070c3a. Thanks
in advance for reviews!
Cheers,

Guilherme


 .../admin-guide/kernel-parameters.txt         | 10 ++---
 fs/proc/proc_sysctl.c                         |  7 +++-
 kernel/watchdog.c                             | 38 +++++--------------
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a44c1bf85e7..d9197499aad1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1435,7 +1435,7 @@
 	hardlockup_all_cpu_backtrace=
 			[KNL] Should the hard-lockup detector generate
 			backtraces on all cpus.
-			Format: <integer>
+			Format: 0 | 1
 
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
@@ -1503,7 +1503,7 @@
 
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
-			Format: <integer>
+			Format: 0 | 1
 
 			A value of 1 instructs the kernel to panic when a
 			hung task is detected. The default value is controlled
@@ -4643,9 +4643,9 @@
 
 	softlockup_panic=
 			[KNL] Should the soft-lockup detector generate panics.
-			Format: <integer>
+			Format: 0 | 1
 
-			A nonzero value instructs the soft-lockup detector
+			A value of 1 instructs the soft-lockup detector
 			to panic the machine when a soft-lockup occurs. It is
 			also controlled by the kernel.softlockup_panic sysctl
 			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
@@ -4654,7 +4654,7 @@
 	softlockup_all_cpu_backtrace=
 			[KNL] Should the soft-lockup detector generate
 			backtraces on all cpus.
-			Format: <integer>
+			Format: 0 | 1
 
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
 			See Documentation/admin-guide/laptops/sonypi.rst
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 15030784566c..5b405f32971d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1720,8 +1720,11 @@ struct sysctl_alias {
  * parameter.
  */
 static const struct sysctl_alias sysctl_aliases[] = {
-	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
-	{"hung_task_panic",		"kernel.hung_task_panic" },
+	{"hardlockup_all_cpu_backtrace",	"kernel.hardlockup_all_cpu_backtrace" },
+	{"hung_task_panic",			"kernel.hung_task_panic" },
+	{"numa_zonelist_order",			"vm.numa_zonelist_order" },
+	{"softlockup_all_cpu_backtrace",	"kernel.softlockup_all_cpu_backtrace" },
+	{"softlockup_panic",			"kernel.softlockup_panic" },
 	{ }
 };
 
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index fa5aacbfd000..1b939532fcc1 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -50,6 +50,11 @@ struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
+
+# ifdef CONFIG_SMP
+int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
+# endif /* CONFIG_SMP */
+
 /*
  * Should we panic when a soft-lockup or hard-lockup occurs:
  */
@@ -82,17 +87,6 @@ static int __init hardlockup_panic_setup(char *str)
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
-# ifdef CONFIG_SMP
-int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
-
-static int __init hardlockup_all_cpu_backtrace_setup(char *str)
-{
-	sysctl_hardlockup_all_cpu_backtrace = !!simple_strtol(str, NULL, 0);
-	return 1;
-}
-__setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
-# endif /* CONFIG_SMP */
-
 atomic_t hardlockup_detected = ATOMIC_INIT(0);
 
 static inline void flush_hardlockup_messages(void)
@@ -183,6 +177,10 @@ static void lockup_detector_update_enable(void)
 
 #define SOFTLOCKUP_RESET	ULONG_MAX
 
+#ifdef CONFIG_SMP
+int __read_mostly sysctl_softlockup_all_cpu_backtrace;
+#endif
+
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
 			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
@@ -198,13 +196,6 @@ static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
-static int __init softlockup_panic_setup(char *str)
-{
-	softlockup_panic = simple_strtoul(str, NULL, 0);
-	return 1;
-}
-__setup("softlockup_panic=", softlockup_panic_setup);
-
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;
@@ -226,17 +217,6 @@ static int __init watchdog_thresh_setup(char *str)
 }
 __setup("watchdog_thresh=", watchdog_thresh_setup);
 
-#ifdef CONFIG_SMP
-int __read_mostly sysctl_softlockup_all_cpu_backtrace;
-
-static int __init softlockup_all_cpu_backtrace_setup(char *str)
-{
-	sysctl_softlockup_all_cpu_backtrace = !!simple_strtol(str, NULL, 0);
-	return 1;
-}
-__setup("softlockup_all_cpu_backtrace=", softlockup_all_cpu_backtrace_setup);
-#endif
-
 static void __lockup_detector_cleanup(void);
 
 /*
-- 
2.25.2

