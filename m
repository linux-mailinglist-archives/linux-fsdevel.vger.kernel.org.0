Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7824BCCDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiBTGEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:04:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiBTGEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:04:41 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AFF50E2D
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:04:20 -0800 (PST)
X-QQ-mid: bizesmtp73t1645337042tx5jm81h
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:03:56 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: sOJWOW+s0sNKLHe1yAEwsqM1eezK/EuD2TDgyv2R5vlMpJ9Uf6gjfmFJEsxEh
        0iv8+aBY3+ksXEqt0xYx2eecVRTxBbDFQmOWgJviZzsC4qTPGOXUYecmEjLU1HO/zTd//kN
        2bmXaMJ9AnhX2GkcgKVMcyFCHSC+I+ynqu4NCGMXeA0Q+qX9gEV9V6+XYW+XbNGbZu4oSEE
        kOtMpq9IrEKh+IFCL4MaQSxwQi1LCXZlk31mBp11L/jSBYyvAXToaWHAK2YS4BYSrIk1Y5Y
        zNUsQKuyX81ReBnb/JGC1KmL4xSN4Jq0nmBL+kdZRNIKZQVqMqrEJsPv3la/ztadYilwKnC
        /oMI+/VDgMxphyFFrhQFrX8DzXT7iZGje8fBkqh
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 11/11] fs/userfaultfd: move userfaultfd sysctls to its own file
Date:   Sun, 20 Feb 2022 14:03:54 +0800
Message-Id: <20220220060354.14961-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
follows the commit of fs, move the userfaultfd sysctls to its own file,
fs/userfdfault.c.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 fs/userfaultfd.c              | 23 ++++++++++++++++++++++-
 include/linux/userfaultfd_k.h |  2 --
 kernel/sysctl.c               | 11 -----------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e26b10132d47..796d828dd2bb 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -30,7 +30,28 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
-int sysctl_unprivileged_userfaultfd __read_mostly;
+static int sysctl_unprivileged_userfaultfd __read_mostly;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_userfaultfd_table[] = {
+	{
+		.procname       = "unprivileged_userfaultfd",
+		.data           = &sysctl_unprivileged_userfaultfd,
+		.maxlen         = sizeof(sysctl_unprivileged_userfaultfd),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{ }
+};
+
+static __init int vm_userfaultfd_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_userfaultfd_table);
+	return 0;
+}
+late_initcall(vm_userfaultfd_sysctls_init);
+#endif /* CONFIG_SYSCTL */
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 33cea484d1ad..0ece3026203f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -33,8 +33,6 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
-extern int sysctl_unprivileged_userfaultfd;
-
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 657b7bfe38f6..bc74f2bdaa52 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2407,17 +2407,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= (void *)&mmap_rnd_compat_bits_min,
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
-#endif
-#ifdef CONFIG_USERFAULTFD
-	{
-		.procname	= "unprivileged_userfaultfd",
-		.data		= &sysctl_unprivileged_userfaultfd,
-		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 #endif
 	{ }
 };
-- 
2.20.1



