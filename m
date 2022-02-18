Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7064BB768
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiBRK74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 05:59:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiBRK7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:59:52 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C91B7634
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 02:59:34 -0800 (PST)
X-QQ-mid: bizesmtp75t1645181950tezeyhil
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Feb 2022 18:59:03 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00M0000000
X-QQ-FEAT: JRmPfD6HWhykTEiQFDHsYliCQGMuGr/p1wXKShUhdXWhhe3xUHuf/+kdHbKS4
        fp0hpVZZdSjOEGOhbT63p3zTTegZ+OP93BGy/PPgZ0yWELIEkvkrUYUIidhz0RVFG7uwlN7
        RJMS0UndbhACo5/9cPDiXztSPScuGImCE/duiZV7sWy0XdpFToH1P57mMeynGT2CcJdSroc
        Bhx86Dgn4SjqSgtLJlPvtl2pmEUkhZkvHWOHmD7PIozVcX7keee3pGlGxznlXsmdcDoEjO8
        PhvHP2xlQL18e82Yy9ma6/RAIvr9lILW3f+93uyvvIc14q0B14X6RGdLjlh2zY9pfUTXfAr
        9GzHYC/s2zZzMhh2lk8cB8k4NhMdOr04mlQGhHR
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 1/5] kernel/lockdep: move lockdep sysctls to its own file
Date:   Fri, 18 Feb 2022 18:58:57 +0800
Message-Id: <20220218105857.12559-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
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
follows the commit of fs, move the prove_locking and lock_stat sysctls
to its own file, kernel/lockdep.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/lockdep.h  |  4 ----
 kernel/locking/lockdep.c | 35 +++++++++++++++++++++++++++++++++--
 kernel/sysctl.c          | 21 ---------------------
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105..37951c17908e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -16,10 +16,6 @@
 
 struct task_struct;
 
-/* for sysctl */
-extern int prove_locking;
-extern int lock_stat;
-
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f83aeb9..d36c55c3101c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -64,19 +64,50 @@
 #include <trace/events/lock.h>
 
 #ifdef CONFIG_PROVE_LOCKING
-int prove_locking = 1;
+static int prove_locking = 1;
 module_param(prove_locking, int, 0644);
 #else
 #define prove_locking 0
 #endif
 
 #ifdef CONFIG_LOCK_STAT
-int lock_stat = 1;
+static int lock_stat = 1;
 module_param(lock_stat, int, 0644);
 #else
 #define lock_stat 0
 #endif
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_lockdep_table[] = {
+#ifdef CONFIG_PROVE_LOCKING
+	{
+		.procname       = "prove_locking",
+		.data           = &prove_locking,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#endif /* CONFIG_PROVE_LOCKING */
+#ifdef CONFIG_LOCK_STAT
+	{
+		.procname       = "lock_stat",
+		.data           = &lock_stat,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+#endif /* CONFIG_LOCK_STAT */
+	{ }
+};
+
+static __init int kernel_lockdep_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_lockdep_table);
+	return 0;
+}
+late_initcall(kernel_lockdep_sysctls_init);
+#endif /* CONFIG_SYSCTL */
+
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
 EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3cd3478b815d..682b3b3f2924 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -88,9 +88,6 @@
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
-#if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_LOCK_STAT)
-#include <linux/lockdep.h>
-#endif
 
 #if defined(CONFIG_SYSCTL)
 
@@ -1684,24 +1681,6 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#endif
-#ifdef CONFIG_PROVE_LOCKING
-	{
-		.procname	= "prove_locking",
-		.data		= &prove_locking,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
-#ifdef CONFIG_LOCK_STAT
-	{
-		.procname	= "lock_stat",
-		.data		= &lock_stat,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #endif
 	{
 		.procname	= "panic",
-- 
2.20.1



