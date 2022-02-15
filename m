Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637F14B6154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 04:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiBODFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 22:05:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBODFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:05:38 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 19:05:27 PST
Received: from qq.com (smtpbg409.qq.com [113.96.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B59BDE62;
        Mon, 14 Feb 2022 19:05:27 -0800 (PST)
X-QQ-mid: bizesmtp9t1644894208tiionbskv
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 11:03:00 +0800 (CST)
X-QQ-SSF: 0140000000000080F000B00A0000000
X-QQ-FEAT: jaWQEnoziVEUFUcA33dfgmTiwLw8MbNPBILov2MQ4JKYsJ6wIWQzKRMbg8xV6
        eJRtvw8z5vIpSwcFqa0JUw141zSmlzCFz5eX/Cxo6LP9/lCBhB0G1rOkYicOv2enldJj92W
        f0Utccb31SsGTS5fhIkPPBT8u/6JHM/63xQURrKzdBe0HKd+s1Ohe5dezrJGyGjSIVQjxAb
        w/IN7YF7mt3eLTa1WJSKxOOWHDl3ZpyHsHJECnvGMS9NFmVYlvuHx+s9hoNpvwXmaa2ppi5
        I22i0C+VjPBxRTVP2Vn3SlBMfHpKZuO6wYzpaJ14mIrMXaW1YKn2bfy8qsWUTbflQtVZ68q
        XbYqjZLRTO55uRCYwI=
X-QQ-GoodBg: 2
From:   sujiaxun <sujiaxun@uniontech.com>
To:     mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        sujiaxun <sujiaxun@uniontech.com>
Subject: [PATCH] mm: move oom_kill sysctls to their own file
Date:   Tue, 15 Feb 2022 11:02:57 +0800
Message-Id: <20220215030257.11150-1-sujiaxun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we just
care about the core logic.

So move the oom_kill sysctls to its own file.

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 include/linux/oom.h |  4 ----
 kernel/sysctl.c     | 23 -----------------------
 mm/oom_kill.c       | 37 ++++++++++++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..02d1e7bbd8cd 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -123,8 +123,4 @@ extern void oom_killer_enable(void);

 extern struct task_struct *find_lock_task_mm(struct task_struct *p);

-/* sysctls */
-extern int sysctl_oom_dump_tasks;
-extern int sysctl_oom_kill_allocating_task;
-extern int sysctl_panic_on_oom;
 #endif /* _INCLUDE_LINUX_OOM_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 788b9a34d5ab..40d822fbb6d5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2352,29 +2352,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{
-		.procname	= "panic_on_oom",
-		.data		= &sysctl_panic_on_oom,
-		.maxlen		= sizeof(sysctl_panic_on_oom),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
-	},
-	{
-		.procname	= "oom_kill_allocating_task",
-		.data		= &sysctl_oom_kill_allocating_task,
-		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "oom_dump_tasks",
-		.data		= &sysctl_oom_dump_tasks,
-		.maxlen		= sizeof(sysctl_oom_dump_tasks),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 	{
 		.procname	= "overcommit_ratio",
 		.data		= &sysctl_overcommit_ratio,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 6b875acabd1e..c720c0710911 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -52,9 +52,35 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/oom.h>

-int sysctl_panic_on_oom;
-int sysctl_oom_kill_allocating_task;
-int sysctl_oom_dump_tasks = 1;
+static int sysctl_panic_on_oom;
+static int sysctl_oom_kill_allocating_task;
+static int sysctl_oom_dump_tasks = 1;
+
+static struct ctl_table vm_oom_kill_table[] = {
+	{
+		.procname	= "panic_on_oom",
+		.data		= &sysctl_panic_on_oom,
+		.maxlen		= sizeof(sysctl_panic_on_oom),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
+	{
+		.procname	= "oom_kill_allocating_task",
+		.data		= &sysctl_oom_kill_allocating_task,
+		.maxlen		= sizeof(sysctl_oom_kill_allocating_task),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "oom_dump_tasks",
+		.data		= &sysctl_oom_dump_tasks,
+		.maxlen		= sizeof(sysctl_oom_dump_tasks),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	}
+};

 /*
  * Serializes oom killer invocations (out_of_memory()) from all contexts to
@@ -680,6 +706,11 @@ static void wake_oom_reaper(struct task_struct *tsk)
 static int __init oom_init(void)
 {
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
+
+	#ifdef CONFIG_SYSCTL
+		register_sysctl_init("vm", vm_oom_kill_table);
+	#endif
+
 	return 0;
 }
 subsys_initcall(oom_init)
--
2.20.1



