Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF44BB770
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBRLAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 06:00:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiBRLAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:00:31 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32BC1ED631
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 03:00:13 -0800 (PST)
X-QQ-mid: bizesmtp89t1645181973tkblj3mn
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Feb 2022 18:59:26 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00M0000000
X-QQ-FEAT: xoS364mEyr0CAqAcI82K48d2BBOqblN61/BW+RmdSzYjTe4TvLWIT7OcdmMuO
        0YxSJBr3XScxDsuRA9Yd7Dp9Zu5GULGLgnohfTrw8kLMQskT57GsGQwiQ+eih0eIgNoISQ0
        q9RaLJlAGGhS9WQu4+K5T5rDPH73xGwwkW7nyj9mASerrUkCnVPoplQ43uJprwyGsubfqwS
        B7yYdvtL7FLvj6RqKSe02B40Nu/E7rq1Ammw38uRuOb3/cqwNU6glLc5RGCpcP7YCqkttTq
        emv4kzCqVTJtkLpe4UlKbezUjcdrO2hnjxvvoTngsz3eoAeW4duCJNqO8O7ExRQn5s5bDIX
        u9bRR4E8bBIjuX+BCGN69Y+ayMPwxKh1FTG4ljBpSq149oRCeuZfpLjvEflDg==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 3/5] kernel/acct: move acct sysctls to its own file
Date:   Fri, 18 Feb 2022 18:59:23 +0800
Message-Id: <20220218105923.12829-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
follows the commit of fs, move the acct sysctl to its own file,
kernel/acct.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/acct.h |  1 -
 kernel/acct.c        | 22 +++++++++++++++++++++-
 kernel/sysctl.c      | 12 ------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/acct.h b/include/linux/acct.h
index bc70e81895c0..2718c4854815 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -21,7 +21,6 @@
 
 #ifdef CONFIG_BSD_PROCESS_ACCT
 struct pid_namespace;
-extern int acct_parm[]; /* for sysctl */
 extern void acct_collect(long exitcode, int group_dead);
 extern void acct_process(void);
 extern void acct_exit_ns(struct pid_namespace *);
diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..13706356ec54 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -70,11 +70,31 @@
  * Turned into sysctl-controllable parameters. AV, 12/11/98
  */
 
-int acct_parm[3] = {4, 2, 30};
+static int acct_parm[3] = {4, 2, 30};
 #define RESUME		(acct_parm[0])	/* >foo% free space - resume */
 #define SUSPEND		(acct_parm[1])	/* <foo% free space - suspend */
 #define ACCT_TIMEOUT	(acct_parm[2])	/* foo second timeout between checks */
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_acct_table[] = {
+	{
+		.procname       = "acct",
+		.data           = &acct_parm,
+		.maxlen         = 3*sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static __init int kernel_acct_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_acct_table);
+	return 0;
+}
+late_initcall(kernel_acct_sysctls_init);
+#endif /* CONFIG_SYSCTL */
+
 /*
  * External references and all of the globals.
  */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fa79967d4b87..781b0fbb2575 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -82,9 +82,6 @@
 #ifdef CONFIG_SPARC
 #include <asm/setup.h>
 #endif
-#ifdef CONFIG_BSD_PROCESS_ACCT
-#include <linux/acct.h>
-#endif
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
@@ -1862,15 +1859,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dostring,
 	},
 #endif
-#ifdef CONFIG_BSD_PROCESS_ACCT
-	{
-		.procname	= "acct",
-		.data		= &acct_parm,
-		.maxlen		= 3*sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_MAGIC_SYSRQ
 	{
 		.procname	= "sysrq",
-- 
2.20.1



