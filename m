Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A150CEC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiDXDCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 23:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiDXDCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:02:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954413FD8B;
        Sat, 23 Apr 2022 19:59:11 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmCXM72zlzhYKj;
        Sun, 24 Apr 2022 10:58:59 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 10:59:10 +0800
Received: from Linux-SUSE12SP5.huawei.com (10.67.189.3) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 10:59:09 +0800
From:   yingelin <yingelin@huawei.com>
To:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <mcgrof@kernel.org>, <yzaikin@google.com>, <yingelin@huawei.com>
CC:     <kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chenjianguo3@huawei.com>,
        <nixiaoming@huawei.com>, <qiuguorui1@huawei.com>,
        <young.liuyang@huawei.com>, <zengweilin@huawei.com>
Subject: [PATCH sysctl-testing v2] kernel/kexec_core: move kexec_core sysctls into its own file
Date:   Sun, 24 Apr 2022 10:57:40 +0800
Message-ID: <20220424025740.50371-1-yingelin@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.3]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This move the kernel/kexec_core.c respective sysctls to its own file.

kernel/sysctl.c has grown to an insane mess, We move sysctls to places
where features actually belong to improve the readability and reduce
merge conflicts. At the same time, the proc-sysctl maintainers can easily
care about the core logic other than the sysctl knobs added for some feature.

We already moved all filesystem sysctls out. This patch is part of the effort
to move kexec related sysctls out.

Signed-off-by: yingelin <yingelin@huawei.com>

---
v2:
  1. Add the explanation to commit log to help patch review and subsystem
  maintainers better understand the context/logic behind the migration
  2. Add CONFIG_SYSCTL to to isolate the sysctl
  3. Change subject-prefix of sysctl-next to sysctl-testing

v1: https://lore.kernel.org/lkml/20220223030318.213093-1-yingelin@huawei.com/
  1. Lack more informations in the commit log to help patch review better
  2. Lack isolation of the sysctl
  3. Use subject-prefix of sysctl-next
---
 kernel/kexec_core.c | 22 ++++++++++++++++++++++
 kernel/sysctl.c     | 13 -------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..a0456baf52cc 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -936,6 +936,28 @@ int kimage_load_segment(struct kimage *image,
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 int kexec_load_disabled;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table kexec_core_sysctls[] = {
+	{
+		.procname	= "kexec_load_disabled",
+		.data		= &kexec_load_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init kexec_core_sysctl_init(void)
+{
+	register_sysctl_init("kernel", kexec_core_sysctls);
+	return 0;
+}
+late_initcall(kexec_core_sysctl_init);
+#endif
 
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b60345cbadf0..0f3cb61a2e39 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -61,7 +61,6 @@
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
-#include <linux/kexec.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
@@ -1712,18 +1711,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= tracepoint_printk_sysctl,
 	},
 #endif
-#ifdef CONFIG_KEXEC_CORE
-	{
-		.procname	= "kexec_load_disabled",
-		.data		= &kexec_load_disabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_MODULES
 	{
 		.procname	= "modprobe",
-- 
2.26.2

