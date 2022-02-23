Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0744C09E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 04:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiBWDEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 22:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiBWDE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:04:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DB94B403;
        Tue, 22 Feb 2022 19:04:02 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K3LNf3clCz1FDVN;
        Wed, 23 Feb 2022 10:59:30 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 11:04:00 +0800
Received: from Linux-SUSE12SP5.huawei.com (10.67.189.3) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 11:04:00 +0800
From:   yingelin <yingelin@huawei.com>
To:     <ebiederm@xmission.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>
CC:     <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zengweilin@huawei.com>,
        <chenjianguo3@huawei.com>, <nixiaoming@huawei.com>,
        <qiuguorui1@huawei.com>, <yingelin@huawei.com>,
        <young.liuyang@huawei.com>
Subject: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls into its own file
Date:   Wed, 23 Feb 2022 11:03:18 +0800
Message-ID: <20220223030318.213093-1-yingelin@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.3]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This move the kernel/kexec_core.c respective sysctls to its own file.

Signed-off-by: yingelin <yingelin@huawei.com>
---
 kernel/kexec_core.c | 20 ++++++++++++++++++++
 kernel/sysctl.c     | 13 -------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..e57339d49439 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -936,6 +936,26 @@ int kimage_load_segment(struct kimage *image,
 struct kimage *kexec_image;
 struct kimage *kexec_crash_image;
 int kexec_load_disabled;
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
 
 /*
  * No panic_cpu check version of crash_kexec().  This function is called
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ae5e59396b5d..00e97c6d6576 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -61,7 +61,6 @@
 #include <linux/capability.h>
 #include <linux/binfmts.h>
 #include <linux/sched/sysctl.h>
-#include <linux/kexec.h>
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
@@ -1839,18 +1838,6 @@ static struct ctl_table kern_table[] = {
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

