Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D394F777C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiDGHb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiDGHb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:31:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA04ECF2;
        Thu,  7 Apr 2022 00:29:55 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYtJl1dzNzgYWg;
        Thu,  7 Apr 2022 15:28:07 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 15:29:52 +0800
Received: from linux_suse_sp4_work.huawei.com (10.67.133.232) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 15:29:51 +0800
From:   Liao Hua <liaohua4@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <nixiaoming@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>
Subject: [PATCH sysctl-next v3] latencytop: move sysctl to its own file
Date:   Thu, 7 Apr 2022 15:29:48 +0800
Message-ID: <20220407072948.55820-1-liaohua4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.232]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: liaohua <liaohua4@huawei.com>

This moves latencytop sysctl to kernel/latencytop.c

Signed-off-by: liaohua <liaohua4@huawei.com>

------
v3:
  Base the patch on the latest sysctl-next and resubmit.

v2: https://lore.kernel.org/lkml/20220223094710.103378-1-liaohua4@huawei.com/
  Move latencytop sysctl to its own file base based on sysctl-next.

v1: https://lore.kernel.org/lkml/20220219072433.86983-1-liaohua4@huawei.com/
  Move latencytop sysctl to its own file base based on linux master.
---
 include/linux/latencytop.h |  3 ---
 kernel/latencytop.c        | 41 +++++++++++++++++++++++++++++------------
 kernel/sysctl.c            | 10 ----------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/latencytop.h b/include/linux/latencytop.h
index abe3d95f795b..84f1053cf2a8 100644
--- a/include/linux/latencytop.h
+++ b/include/linux/latencytop.h
@@ -38,9 +38,6 @@ account_scheduler_latency(struct task_struct *task, int usecs, int inter)
 
 void clear_tsk_latency_tracing(struct task_struct *p);
 
-int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
 #else
 
 static inline void
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 166d7bf49666..76166df011a4 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -55,6 +55,7 @@
 #include <linux/sched/stat.h>
 #include <linux/list.h>
 #include <linux/stacktrace.h>
+#include <linux/sysctl.h>
 
 static DEFINE_RAW_SPINLOCK(latency_lock);
 
@@ -63,6 +64,31 @@ static struct latency_record latency_record[MAXLR];
 
 int latencytop_enabled;
 
+#ifdef CONFIG_SYSCTL
+static int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int err;
+
+	err = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (latencytop_enabled)
+		force_schedstat_enabled();
+
+	return err;
+}
+
+static struct ctl_table latencytop_sysctl[] = {
+	{
+		.procname   = "latencytop",
+		.data       = &latencytop_enabled,
+		.maxlen     = sizeof(int),
+		.mode       = 0644,
+		.proc_handler   = sysctl_latencytop,
+	},
+	{}
+};
+#endif
+
 void clear_tsk_latency_tracing(struct task_struct *p)
 {
 	unsigned long flags;
@@ -266,18 +292,9 @@ static const struct proc_ops lstats_proc_ops = {
 static int __init init_lstats_procfs(void)
 {
 	proc_create("latency_stats", 0644, NULL, &lstats_proc_ops);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("kernel", latencytop_sysctl);
+#endif
 	return 0;
 }
-
-int sysctl_latencytop(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
-{
-	int err;
-
-	err = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (latencytop_enabled)
-		force_schedstat_enabled();
-
-	return err;
-}
 device_initcall(init_lstats_procfs);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 21172d3dad6e..2db637ca91c9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -65,7 +65,6 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
-#include <linux/latencytop.h>
 #include <linux/pid.h>
 
 #include "../lib/kstrtox.h"
@@ -1685,15 +1684,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_LATENCYTOP
-	{
-		.procname	= "latencytop",
-		.data		= &latencytop_enabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_latencytop,
-	},
-#endif
 	{
 		.procname	= "print-fatal-signals",
 		.data		= &print_fatal_signals,
-- 
2.12.3

