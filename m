Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3D4BB76F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiBRLAx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 06:00:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiBRLAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:00:44 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9B31ED621
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 03:00:27 -0800 (PST)
X-QQ-mid: bizesmtp72t1645181987tje8w7kl
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Feb 2022 18:59:40 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00M0000000
X-QQ-FEAT: TskX/GkkryDxQTL5bYbxQxyGxxhZmalWfqYD3hiq7XxS9JkXU+o+s7Sugz1Wf
        IfB3ZJAaDSAj/8vsOVduyoWjAF3d+ox27F2CoK5dPXFTQOjwE36qKhf9ElSn7+dFYhsLty3
        SkabkqvbZR0HdjfLvT6HyD7Bhm0nMoT96ar9Bf/sKqU2FqwoMAVQTpUc3/OO/eBzLPkAPTc
        qtTxcYUgvSozWRmW4ZFAmvVYylhC0cxJDqauKWIiCscgnOcsOUlbUTUkvpA6XlnNnB8LalO
        P6XfD97s6bZs4rpXPZB44fiydd0OhHnunDaVzz5DmuhNIA+q+Wr8Vt/IpXTtG1EkgNYnQx5
        QYP/bhY7J6jLIN/w0dftUmFL63DgE+18FPA/UderX5kxmqS9IU=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 4/5] kernel/delayacct: move delayacct sysctls to its own file
Date:   Fri, 18 Feb 2022 18:59:36 +0800
Message-Id: <20220218105936.12968-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
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
follows the commit of fs, move the delayacct sysctl to its own file,
kernel/delayacct.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/delayacct.h |  3 ---
 kernel/delayacct.c        | 22 +++++++++++++++++++++-
 kernel/sysctl.c           | 12 ------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 3e03d010bd2e..6b16a6930a19 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -61,9 +61,6 @@ extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
 
-extern int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
-			    size_t *lenp, loff_t *ppos);
-
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index c5e8cea9e05f..2c1e18f7c5cf 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,7 +44,7 @@ void delayacct_init(void)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
-int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
+static int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
 		     size_t *lenp, loff_t *ppos)
 {
 	int state = delayacct_on;
@@ -63,6 +63,26 @@ int sysctl_delayacct(struct ctl_table *table, int write, void *buffer,
 		set_delayacct(state);
 	return err;
 }
+
+static struct ctl_table kern_delayacct_table[] = {
+	{
+		.procname       = "task_delayacct",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_delayacct,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{ }
+};
+
+static __init int kernel_delayacct_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_delayacct_table);
+	return 0;
+}
+late_initcall(kernel_delayacct_sysctls_init);
 #endif
 
 void __delayacct_tsk_init(struct task_struct *tsk)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 781b0fbb2575..e448f43a8988 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,7 +67,6 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/latencytop.h>
 #include <linux/pid.h>
-#include <linux/delayacct.h>
 
 #include "../lib/kstrtox.h"
 
@@ -1646,17 +1645,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 }
 
 static struct ctl_table kern_table[] = {
-#ifdef CONFIG_TASK_DELAY_ACCT
-	{
-		.procname	= "task_delayacct",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_delayacct,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_TASK_DELAY_ACCT */
 #ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
-- 
2.20.1



