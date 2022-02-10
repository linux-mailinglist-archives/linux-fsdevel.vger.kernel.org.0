Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411784B057F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 06:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiBJFmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 00:42:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiBJFl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:41:28 -0500
X-Greylist: delayed 101155 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 21:40:59 PST
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538A1112A
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 21:40:58 -0800 (PST)
X-QQ-mid: bizesmtp41t1644471635t16p9qhh
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Feb 2022 13:40:30 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: K4bWFj5sOHWITqYFbnmkegtCiLZlSV158Z2sf+FqGG4d9/2rMWJWCBqSgZNGb
        W2pRynhnaAT8jq3Baob57P57ZXO5LeyNuASVOPaXHITKO8U2bBcLv3Ybda0j4pIQwHNFSLG
        GBgmVoIZtkx6F/WPtQ1J3bnlwExtplgw19H+yc/uMpKQQBaSUkRSEE17rEgROPBxw7I+5Ar
        XIc3eqxfL7ZJxg5Qtiu4PuDhT2YVPdfiKZcCA0xn60b/G/TEMNDGdcVJDXPmLvW9j9PEui8
        73GblYD0YRvuVDpOnPWQftiPGPKkHPfsWxZCn/3pVA+EHJlNeBDRYWkux9+LT7tY4+FYaen
        QXuibLb0/pl0RkpgTPKLpzguetAGDy4VE3bw7eV
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v2] sched: move cfs_bandwidth_slice sysctls to fair.c
Date:   Thu, 10 Feb 2022 13:40:28 +0800
Message-Id: <20220210054028.3062-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move cfs_bandwidth_slice sysctls to fair.c and use the
new register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  4 ----
 kernel/sched/fair.c          | 25 +++++++++++++++++++++++--
 kernel/sysctl.c              | 10 ----------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..d416d8f45186 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,10 +41,6 @@ extern unsigned int sysctl_sched_uclamp_util_max;
 extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 #endif
 
-#ifdef CONFIG_CFS_BANDWIDTH
-extern unsigned int sysctl_sched_cfs_bandwidth_slice;
-#endif
-
 #ifdef CONFIG_SCHED_AUTOGROUP
 extern unsigned int sysctl_sched_autogroup_enabled;
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..354ebf938567 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -141,8 +141,26 @@ int __weak arch_asym_cpu_priority(int cpu)
  *
  * (default: 5 msec, units: microseconds)
  */
-unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
-#endif
+static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_cfs_bandwidth_sysctls[] = {
+	{
+		.procname       = "sched_cfs_bandwidth_slice_us",
+		.data           = &sysctl_sched_cfs_bandwidth_slice,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static void __init sched_cfs_bandwidth_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_cfs_bandwidth_sysctls);
+}
+#endif /* CONFIG_SYSCTL */
+#endif /* CONFIG_CFS_BANDWIDTH */
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
 {
@@ -207,6 +225,9 @@ static void update_sysctl(void)
 void __init sched_init_granularity(void)
 {
 	update_sysctl();
+#if defined(CONFIG_CFS_BANDWIDTH) && defined(CONFIG_SYSCTL)
+	sched_cfs_bandwidth_sysctl_init();
+#endif
 }
 
 #define WMULT_CONST	(~0U)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..981a1902d7a4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1761,16 +1761,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-#ifdef CONFIG_CFS_BANDWIDTH
-	{
-		.procname	= "sched_cfs_bandwidth_slice_us",
-		.data		= &sysctl_sched_cfs_bandwidth_slice,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-#endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
 		.procname	= "sched_energy_aware",
-- 
2.20.1



