Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A854C110D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiBWLMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiBWLMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:12:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458FA60A89;
        Wed, 23 Feb 2022 03:11:56 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K3YHP6pc4zdZWM;
        Wed, 23 Feb 2022 19:10:41 +0800 (CST)
Received: from Linux-SUSE12SP5.huawei.com (10.67.132.207) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 19:11:53 +0800
From:   Wei Xiao <xiaowei66@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>,
        <nixiaoming@huawei.com>, <xiaowei66@huawei.com>
Subject: [PATCH v2 sysctl-next] ftrace: move sysctl_ftrace_enabled to ftrace.c
Date:   Wed, 23 Feb 2022 19:11:53 +0800
Message-ID: <20220223111153.234411-1-xiaowei66@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.132.207]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves ftrace_enabled to trace/ftrace.c.

We move sysctls to places where features actually belong to improve
the readability of the code and reduce the risk of code merge conflicts.
At the same time, the proc-sysctl maintainers do not want to know what
sysctl knobs you wish to add for your owner piece of code, we just care
about the core logic.

Signed-off-by: Wei Xiao <xiaowei66@huawei.com>

---
v2:
Add subject-prefix of sysctl-next and add the explanation to the commit log 
to help patch review and subsystem maintainers better understand the context/logic 
behind the migration.

v1: https://lore.kernel.org/lkml/20220223012311.134314-1-xiaowei66@huawei.com/
1. Lack subject-prefix of sysctl-next to avoid conflicts better.
2. Lack more informations in the commit log to help patch review better.
---
 include/linux/ftrace.h |  3 ---
 kernel/sysctl.c        |  9 ---------
 kernel/trace/ftrace.c  | 22 +++++++++++++++++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9999e29187de..659b2840563a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -94,9 +94,6 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
-extern int
-ftrace_enable_sysctl(struct ctl_table *table, int write,
-		     void *buffer, size_t *lenp, loff_t *ppos);
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..55279ec66b28 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1906,15 +1906,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_FUNCTION_TRACER
-	{
-		.procname	= "ftrace_enabled",
-		.data		= &ftrace_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= ftrace_enable_sysctl,
-	},
-#endif
 #ifdef CONFIG_STACK_TRACER
 	{
 		.procname	= "stack_tracer_enabled",
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..4a5b4d6996a4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7846,7 +7846,8 @@ static bool is_permanent_ops_registered(void)
 	return false;
 }
 
-int
+#ifdef CONFIG_SYSCTL
+static int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -7889,3 +7890,22 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 	mutex_unlock(&ftrace_lock);
 	return ret;
 }
+
+static struct ctl_table ftrace_sysctls[] = {
+	{
+		.procname       = "ftrace_enabled",
+		.data           = &ftrace_enabled,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = ftrace_enable_sysctl,
+	},
+	{}
+};
+
+static int __init ftrace_sysctl_init(void)
+{
+	register_sysctl_init("kernel", ftrace_sysctls);
+	return 0;
+}
+late_initcall(ftrace_sysctl_init);
+#endif
-- 
2.19.1

