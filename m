Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936654BCCD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiBTGBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:01:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiBTGBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:01:47 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA524E391
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:01:25 -0800 (PST)
X-QQ-mid: bizesmtp82t1645336866t5uc6nr6
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:00:59 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: X+oTZzR2YPgLP2/i7yIbDL5tLF5aCxs9hfHc/ADu78N1w7TWGQCEuREZ3QnOd
        lvWEQkz9Bvyp1My9hZTgnhuRnXRx+DJjk019R6yAXzIQ/jJhHBT2xqqRgZ5PlPIH1MUBuq3
        5Zq1dwnXK4HlJEIFkVskAK8MyvL5d8S0q6sFrxaNSg536XImV5mOT1G7LlgTlaxV7Oj2uyB
        aT5T7HGmEXVyT3aLa8v/wbITINlJTO+S00KC2phEyV3EDIQAr7OCRy3Qs8L812G1PdxSwJr
        EV0Mf1fRrU4jVBb2qFG9DrAE7U168SZHN1Z/kJGbY3I+9mtwWo66tpnBWpk9IVPUCBio03f
        peI8bQZ4T3rVWjd42GDStccyEy5XKxksLjKw39v
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 05/11] kernel/acpi: move acpi_video_flags sysctl to its own file
Date:   Sun, 20 Feb 2022 14:00:53 +0800
Message-Id: <20220220060053.13647-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
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

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the acpi_video_flags sysctl to its
own file, arch/x86/kernel/acpi/sleep.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 arch/x86/kernel/acpi/sleep.c | 21 ++++++++++++++++++++-
 include/linux/acpi.h         |  1 -
 kernel/sysctl.c              |  9 ---------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 1e97f944b47d..256f3c065605 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -20,7 +20,26 @@
 #include "../../realmode/rm/wakeup.h"
 #include "sleep.h"
 
-unsigned long acpi_realmode_flags;
+static unsigned long acpi_realmode_flags;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kern_acpi_table[] = {
+	{
+		.procname       = "acpi_video_flags",
+		.data           = &acpi_realmode_flags,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = proc_doulongvec_minmax,
+	},
+	{ }
+};
+
+static __init int kernel_acpi_sysctls_init(void)
+{
+	register_sysctl_init("kernel", kern_acpi_table);
+	return 0;
+}
+late_initcall(kernel_acpi_sysctls_init);
+#endif /* CONFIG_SYSCTL */
 
 #if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
 static char temp_stack[4096];
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..4f1d9cf579f5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -349,7 +349,6 @@ static inline bool acpi_sci_irq_valid(void)
 }
 
 extern int sbf_port;
-extern unsigned long acpi_realmode_flags;
 
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e6d99bbf9a9d..62499e3207aa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1973,15 +1973,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
-	{
-		.procname	= "acpi_video_flags",
-		.data		= &acpi_realmode_flags,
-		.maxlen		= sizeof (unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-#endif
 #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
 	{
 		.procname	= "ignore-unaligned-usertrap",
-- 
2.20.1



