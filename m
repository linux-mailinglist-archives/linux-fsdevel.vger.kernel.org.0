Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABB4BCCCC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiBTGBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbiBTGBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:01:31 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C464E398
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:01:10 -0800 (PST)
X-QQ-mid: bizesmtp71t1645336814toup6w7g
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:00:06 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: DjV0wquoRWbFbMhTh/aiK/+4vF3oTrbzwjW7Ob/10jesuFazuUecCwYqC5XvK
        Tew27FVHThUVjkWVIjlh9CMfNPNVjApeRa9kJ4qhIgB6phrxrsryM2LmykVnoTt+cLmFaGB
        WAjl7CIdfGOHuToR2s7P5x9/JNp5JZEaEOsndqIvOb3VrNyvRFNNU/O4IFPEFf8jeMISz2c
        2snBphFkZ4VcxKm7Y8oYt+eWesd9c02oWGMFGv5KckZVuOWfmfGiruJrYHis6fi18zRoPyO
        03yhjr6bHBRBM/W1EmFVFL7ZS4zP3eG0AVywskqfz8vKcEnQ1pDL3f0I7F8ka0i2hjPr7je
        1aH1sh6
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 01/11] kernel/parisc: move soft-power sysctl to its own file
Date:   Sun, 20 Feb 2022 14:00:00 +0800
Message-Id: <20220220060000.13079-1-tangmeng@uniontech.com>
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
follows the commit of fs, move the soft-power sysctl to its own file,
kernel/parisc/power.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/parisc/power.c | 22 ++++++++++++++++++++++
 include/linux/sysctl.h |  1 -
 kernel/sysctl.c        |  9 ---------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee6..24e0ffbe460a 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -193,6 +193,26 @@ static struct notifier_block parisc_panic_block = {
 	.priority	= INT_MAX,
 };
 
+static int pwrsw_enabled;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_parisc_power_table[] = {
+	{
+		.procname       = "soft-power",
+		.data           = &pwrsw_enabled,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static void __init kernel_parisc_power_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_parisc_power_table);
+}
+#else
+#define kernel_parisc_power_sysctls_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
 
 static int __init power_init(void)
 {
@@ -233,6 +253,8 @@ static int __init power_init(void)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&parisc_panic_block);
 
+	kernel_parisc_power_sysctls_init();
+
 	return 0;
 }
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6353d6db69b2..e00bf436d63b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -242,7 +242,6 @@ int do_proc_douintvec(struct ctl_table *table, int write,
 				  int write, void *data),
 		      void *data);
 
-extern int pwrsw_enabled;
 extern int unaligned_enabled;
 extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 22037f03cd2b..d11390634321 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1737,15 +1737,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_PARISC
-	{
-		.procname	= "soft-power",
-		.data		= &pwrsw_enabled,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW
 	{
 		.procname	= "unaligned-trap",
-- 
2.20.1



