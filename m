Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C803C4BCCCB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiBTGB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:01:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiBTGBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:01:22 -0500
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9594E392
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:00:58 -0800 (PST)
X-QQ-mid: bizesmtp89t1645336851t7aadi5n
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:00:44 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: F3yR32iATbi/mkLSpOZvYvncsiPLQQBpqaeLowKGG86n/yfoUl7HczKwqnGvv
        AFWPx+giiUSNc8US0Rbd28oDJVUomiKnOUWitwatSMKDHPGqDMumpZqZfzJDxrovodrq43f
        49BMtuG34fiwk4h+xaM2l2UXpZNlYx+xxYY15iIqSNg7oS8tx85P3VefeKbCmUBg1Yhz35Y
        jlu5+RAb9yexYmgw85jyi8wQp6kUektl441hPSDvSAjdbRv7cL7lZ+Gbgh07RdNx28OApP5
        7PLG2Xv9DaK0TQCsJb9FpjEHKvtXYC8q/uvPTU9L4xioHQG5gnPA/F9/bf5zGToG7HTKvhd
        6c1+GVUZ1rsBHfwHA5h3YsFnUHZJAOaCODOnT/t
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 04/11] kernel/fork: move threads-max sysctl to its own file
Date:   Sun, 20 Feb 2022 14:00:41 +0800
Message-Id: <20220220060041.13531-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
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
follows the commit of fs, move the threads-max sysctl to its
own file, kernel/fork.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/sysctl.h |  3 ---
 kernel/fork.c          | 22 +++++++++++++++++++++-
 kernel/sysctl.c        |  7 -------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e00bf436d63b..1d3467b5e2f3 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -295,7 +295,4 @@ static inline void do_sysctl_args(void)
 }
 #endif /* CONFIG_SYSCTL */
 
-int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
 #endif /* _LINUX_SYSCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..0ac42feb3f71 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3143,7 +3143,8 @@ int unshare_files(void)
 	return 0;
 }
 
-int sysctl_max_threads(struct ctl_table *table, int write,
+#ifdef CONFIG_SYSCTL
+static int sysctl_max_threads(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -3165,3 +3166,22 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 
 	return 0;
 }
+
+static struct ctl_table kern_fork_table[] = {
+	{
+		.procname       = "threads-max",
+		.data           = NULL,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_max_threads,
+	},
+	{ }
+};
+
+static __init int kernel_fork_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_fork_table);
+	return 0;
+}
+late_initcall(kernel_fork_sysctls_init);
+#endif /* CONFIG_SYSCTL */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 126d47e8224d..e6d99bbf9a9d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1829,13 +1829,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_do_cad_pid,
 	},
 #endif
-	{
-		.procname	= "threads-max",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_max_threads,
-	},
 	{
 		.procname	= "usermodehelper",
 		.mode		= 0555,
-- 
2.20.1



