Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523824B6B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiBOLqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:46:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiBOLqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:46:51 -0500
X-Greylist: delayed 22995 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:46:41 PST
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6C654B2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:40 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925582traacy2x
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:19 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: NFbnPP6/4uIjq7baGubDdF8lAVSJ0kqlgzt/KiV61aU24LUBUVE0bomkY+7nl
        z5Wy7xiJTTDN/3RzpX1dEwM9csZ6mctawBbO/zg/jQ+vT+rU4mHPVVLVx90ytVTJc87CEzu
        BZQ8xxCRbpKoeGQBlKtSPtkjzuI9rhjXCXqOqoldUo0yuirtL1grrw9bZhAuZWLaFZ7vm0V
        /gjlG3mOppSGp+ztndl14OpFT1fEaG1hhjC2GovpPVZCjyLBEVnKiUGeV/8eGW1nTFyamRE
        4rkANqxarjXpIb7llYlBZkoH/OiBNb3AypK3GIGnhUN6NJHh7zGL54MQRGaqcduCPvkjkzJ
        qPfLTFp+uitbp+ZaMK7gnagj8HIj99XWcT0uqOnqnvktS/SrQyo5+/nc3WOrQ==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 1/8] sched: Move child_runs_first sysctls to fair.c
Date:   Tue, 15 Feb 2022 19:45:57 +0800
Message-Id: <20220215114604.25772-2-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move child_runs_first sysctls to fair.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  2 --
 kernel/sched/fair.c          | 19 +++++++++++++++++++
 kernel/sched/sched.h         |  2 ++
 kernel/sysctl.c              |  7 -------
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3f2b70f8d32c..5490ba24783a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -14,8 +14,6 @@ extern unsigned long sysctl_hung_task_timeout_secs;
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
-extern unsigned int sysctl_sched_child_runs_first;
-
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8fc35fd779f8..4ac1bfe8ca4f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -77,6 +77,25 @@ static unsigned int sched_nr_latency = 8;
  * parent will (try to) run first.
  */
 unsigned int sysctl_sched_child_runs_first __read_mostly;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_child_runs_first_sysctls[] = {
+	{
+		.procname       = "sched_child_runs_first",
+		.data           = &sysctl_sched_child_runs_first,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{}
+};
+
+static int __init sched_child_runs_first_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_child_runs_first_sysctls);
+	return 0;
+}
+late_initcall(sched_child_runs_first_sysctl_init);
+#endif
 
 /*
  * SCHED_OTHER wake-up granularity.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b33ba9c3c42..27465635c774 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -96,6 +96,8 @@ extern __read_mostly int scheduler_running;
 extern unsigned long calc_load_update;
 extern atomic_long_t calc_load_tasks;
 
+extern unsigned int sysctl_sched_child_runs_first;
+
 extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1cb7ca68cd4e..24a99b5b7da8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1652,13 +1652,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 }
 
 static struct ctl_table kern_table[] = {
-	{
-		.procname	= "sched_child_runs_first",
-		.data		= &sysctl_sched_child_runs_first,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.20.1



