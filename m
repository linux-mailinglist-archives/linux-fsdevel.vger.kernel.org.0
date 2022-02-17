Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB84B97A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 05:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiBQEYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 23:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiBQEYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:24:10 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97113296B
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 20:23:56 -0800 (PST)
X-QQ-mid: bizesmtp91t1645071811tig2sadn
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 17 Feb 2022 12:23:23 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: lC5HeAtE+ybbExCBMKHCcf5/KOTEY3bGUZZ0Clp34iLJDKjDP29NqoGYqnSVI
        aAJ2Y+OiGoZ2a7hQEn3RWrP+UtQARJhx5Zp8kA/3+VhPNHAQ3yhlbu9tgMIoGeWC1HX/ABI
        rCv/7du8Kr9h8PCZXGUlVg+IQ5Ca2mWvyxwDE08cFn66Yj7fn36nSBheQAbWp5qj2YYjODM
        +bvpSgK4C5KQCUQJubke0uV9lPkaP60OzM/WAc/qAbwUVDDbOoO0KTNSH0EzISPJk9wONm+
        PJl93l6WOYnVsw8uJ4MwzwwqEBPd58UUyCznm2TfUTU2Qa9JkTBbIV8Y/9lZpGsdyUWpf8/
        9LLG39SA/RoFRmZ84qLqtLHyy0hWg==
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] kernel/reboot: move reboot sysctls to its own file
Date:   Thu, 17 Feb 2022 12:23:21 +0800
Message-Id: <20220217042321.10291-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
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
follows the commit of fs, move the poweroff_cmd and ctrl-alt-del
sysctls to its own file, kernel/reboot.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/reboot.h |  4 ----
 kernel/reboot.c        | 34 ++++++++++++++++++++++++++++++++--
 kernel/sysctl.c        | 14 --------------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index af907a3d68d1..a2429648d831 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -71,12 +71,8 @@ extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
 
-extern int C_A_D; /* for sysctl */
 void ctrl_alt_del(void);
 
-#define POWEROFF_CMD_PATH_LEN	256
-extern char poweroff_cmd[POWEROFF_CMD_PATH_LEN];
-
 extern void orderly_poweroff(bool force);
 extern void orderly_reboot(void);
 void hw_protection_shutdown(const char *reason, int ms_until_forced);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 6bcc5d6a6572..ed4e6dfb7d44 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -23,7 +23,7 @@
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
  */
 
-int C_A_D = 1;
+static int C_A_D = 1;
 struct pid *cad_pid;
 EXPORT_SYMBOL(cad_pid);
 
@@ -417,9 +417,37 @@ void ctrl_alt_del(void)
 		kill_cad_pid(SIGINT, 1);
 }
 
-char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
+#define POWEROFF_CMD_PATH_LEN  256
+static char poweroff_cmd[POWEROFF_CMD_PATH_LEN] = "/sbin/poweroff";
 static const char reboot_cmd[] = "/sbin/reboot";
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_reboot_table[] = {
+	{
+		.procname       = "poweroff_cmd",
+		.data           = &poweroff_cmd,
+		.maxlen         = POWEROFF_CMD_PATH_LEN,
+		.mode           = 0644,
+		.proc_handler   = proc_dostring,
+	},
+	{
+		.procname       = "ctrl-alt-del",
+		.data           = &C_A_D,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{ }
+};
+
+static void __init kernel_reboot_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_reboot_table);
+}
+#else
+#define kernel_reboot_sysctls_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
 static int run_cmd(const char *cmd)
 {
 	char **argv;
@@ -886,6 +914,8 @@ static int __init reboot_ksysfs_init(void)
 		return ret;
 	}
 
+	kernel_reboot_sysctls_init();
+
 	return 0;
 }
 late_initcall(reboot_ksysfs_init);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 40d822fbb6d5..38ef895355a7 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1895,13 +1895,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "ctrl-alt-del",
-		.data		= &C_A_D,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 #ifdef CONFIG_FUNCTION_TRACER
 	{
 		.procname	= "ftrace_enabled",
@@ -2208,13 +2201,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "poweroff_cmd",
-		.data		= &poweroff_cmd,
-		.maxlen		= POWEROFF_CMD_PATH_LEN,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
 #ifdef CONFIG_KEYS
 	{
 		.procname	= "keys",
-- 
2.20.1



