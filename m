Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583B4BB766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 11:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiBRK7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 05:59:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiBRK7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:59:50 -0500
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3571CEB00
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 02:59:34 -0800 (PST)
X-QQ-mid: bizesmtp71t1645181962tz70e2vo
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Feb 2022 18:59:14 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00M0000000
X-QQ-FEAT: 0Eq+cbWb7RxKR0yuzkJjHbcehYXoBUOTOljkRKZHdRjnLsDcsdAzo5euxiRnl
        tzKP8w0VVpgIEWQtV0J5tEar9WZ7P7nn4gMf2UOJwBVQZYrOM8jo/E+SbqCZZwvWB3cmcGk
        w18QmJGvqyF8Ag86KjKeYnHf4SzOVfx95YntYQnZfwwHbjH3NcPbVVTYZSupAxz11XgXwcA
        yxY2KBFn5+drQNlYIlMKIX8d7JG+sNTJcTHlawvgWjN+kP6Dx+BfK+7RDO9pQjU+2qHhDJv
        kkP3/2iykNeWYT/6EH0eMrg4z/Afkj0kh3Swt0FD2qRh+EpvsPL6nLxudtFR+4Vn5DGtu0z
        ftjxIzGo9e502bfYoPquztA6ouXT2pn+ebxHSHe
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 2/5] kernel/panic: move panic sysctls to its own file
Date:   Fri, 18 Feb 2022 18:59:12 +0800
Message-Id: <20220218105912.12696-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the oops_all_cpu_backtrace sysctl to
its own file, kernel/panic.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/panic.h |  6 ------
 kernel/panic.c        | 26 +++++++++++++++++++++++++-
 kernel/sysctl.c       | 11 -----------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index f5844908a089..e71161da69c4 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -15,12 +15,6 @@ extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
 
-#ifdef CONFIG_SMP
-extern unsigned int sysctl_oops_all_cpu_backtrace;
-#else
-#define sysctl_oops_all_cpu_backtrace 0
-#endif /* CONFIG_SMP */
-
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/kernel/panic.c b/kernel/panic.c
index 55b50e052ec3..8aa5c01b41b6 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -43,7 +43,9 @@
  * Should we dump all CPUs backtraces in an oops event?
  * Defaults to 0, can be changed via sysctl.
  */
-unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
+static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
+#else
+#define sysctl_oops_all_cpu_backtrace 0
 #endif /* CONFIG_SMP */
 
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
@@ -72,6 +74,28 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
+static struct ctl_table kern_panic_table[] = {
+	{
+		.procname       = "oops_all_cpu_backtrace",
+		.data           = &sysctl_oops_all_cpu_backtrace,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{ }
+};
+
+static __init int kernel_panic_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_panic_table);
+	return 0;
+}
+late_initcall(kernel_panic_sysctls_init);
+#endif
+
 static long no_blink(int state)
 {
 	return 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 682b3b3f2924..fa79967d4b87 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1928,17 +1928,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_SMP
-	{
-		.procname	= "oops_all_cpu_backtrace",
-		.data		= &sysctl_oops_all_cpu_backtrace,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SMP */
 	{
 		.procname	= "pid_max",
 		.data		= &pid_max,
-- 
2.20.1



