Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A54BCCC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiBTGBI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:01:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiBTGBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:01:07 -0500
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DF4E391
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:00:45 -0800 (PST)
X-QQ-mid: bizesmtp67t1645336826t02la2ki
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:00:20 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: Mzskoac49OhGvxpJRUZvZbOVIB6zL6XZ5GzlSuFgGhGks3zBTi6Ww2WccQD+E
        KpQ8suHUKwp2NxsEx6UrQf8MXOkZCxaFdFGoRnMFiiYpSz3vvgSIWLJlLRP8nAYcZYbkXRo
        0hs36nv9bzYTodyVIgr7Pb8zxqojhpYv5zn1Nxc18p6dxIEM9ChF2BWfG+XSP3MQXe9szW3
        zWoy+4cXt52aEbP9ktUOejwE4UYcZdXSQ9mC9fRsl8fTlQr9LpeBeZnFcFjRHKVaZ8y7PhL
        L47eFc2IdjfZQoK6I3r5w6SM8BJJuv/CJjfetuIzUNVHdByvMb95OY911UJOtOBUBjOcWxB
        rLSHGJyC2bPftg/Rk02SnxfAHKzQh19Z52lstfT
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     rostedt@goodmis.org, mingo@redhat.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 02/11] kernel/trace: move stack_tracer_enabled sysctl to its own file
Date:   Sun, 20 Feb 2022 14:00:17 +0800
Message-Id: <20220220060017.13285-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
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
follows the commit of fs, move the stack_tracer_enabled sysctl to its
own file, kernel/trace/trace_stack.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/ftrace.h     |  6 ------
 kernel/sysctl.c            |  9 ---------
 kernel/trace/trace_stack.c | 26 ++++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9999e29187de..cc6f7532e038 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -392,12 +392,6 @@ static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifdef CONFIG_STACK_TRACER
-
-extern int stack_tracer_enabled;
-
-int stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
-		       size_t *lenp, loff_t *ppos);
-
 /* DO NOT MODIFY THIS VARIABLE DIRECTLY! */
 DECLARE_PER_CPU(int, disable_stack_tracer);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d11390634321..b41138d64e5e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1755,15 +1755,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= ftrace_enable_sysctl,
 	},
 #endif
-#ifdef CONFIG_STACK_TRACER
-	{
-		.procname	= "stack_tracer_enabled",
-		.data		= &stack_tracer_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= stack_trace_sysctl,
-	},
-#endif
 #ifdef CONFIG_TRACING
 	{
 		.procname	= "ftrace_dump_on_oops",
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..b871499cf7e6 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -32,7 +32,7 @@ static arch_spinlock_t stack_trace_max_lock =
 DEFINE_PER_CPU(int, disable_stack_tracer);
 static DEFINE_MUTEX(stack_sysctl_mutex);
 
-int stack_tracer_enabled;
+static int stack_tracer_enabled;
 
 static void print_max_stack(void)
 {
@@ -513,7 +513,8 @@ static const struct file_operations stack_trace_filter_fops = {
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-int
+#ifdef CONFIG_SYSCTL
+static int
 stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
 		   size_t *lenp, loff_t *ppos)
 {
@@ -537,6 +538,25 @@ stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
 	return ret;
 }
 
+static struct ctl_table kern_trace_stack_table[] = {
+	{
+		.procname       = "stack_tracer_enabled",
+		.data           = &stack_tracer_enabled,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = stack_trace_sysctl,
+	},
+	{ }
+};
+
+static void __init kernel_trace_stack_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_trace_stack_table);
+}
+#else
+#define kernel_trace_stack_sysctls_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
 static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
 
 static __init int enable_stacktrace(char *str)
@@ -576,6 +596,8 @@ static __init int stack_trace_init(void)
 	if (stack_tracer_enabled)
 		register_ftrace_function(&trace_ops);
 
+	kernel_trace_stack_sysctls_init();
+
 	return 0;
 }
 
-- 
2.20.1



