Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27FE6A6A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCAKGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 05:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCAKGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:06:37 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE83B66A;
        Wed,  1 Mar 2023 02:06:36 -0800 (PST)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PRVF74H5fz16P0H;
        Wed,  1 Mar 2023 18:03:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 18:06:33 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <mcgrof@kernel.org>, <akpm@linux-foundation.org>,
        <peterx@redhat.com>, <jthoughton@google.com>,
        <Liam.Howlett@Oracle.com>, <viro@zeniv.linux.org.uk>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH] userfaultfd: move unprivileged_userfaultfd sysctl to its own file
Date:   Wed, 1 Mar 2023 10:06:27 +0000
Message-ID: <20230301100627.3505739-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

The sysctl_unprivileged_userfaultfd is part of userfaultfd, move it to
its own file.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/userfaultfd.c              | 20 +++++++++++++++++++-
 include/linux/userfaultfd_k.h |  2 --
 kernel/sysctl.c               | 11 -----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..d01f803a6b11 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -32,7 +32,22 @@
 #include <linux/swapops.h>
 #include <linux/miscdevice.h>
 
-int sysctl_unprivileged_userfaultfd __read_mostly;
+static int sysctl_unprivileged_userfaultfd __read_mostly;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_userfaultfd_table[] = {
+	{
+		.procname	= "unprivileged_userfaultfd",
+		.data		= &sysctl_unprivileged_userfaultfd,
+		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+#endif
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -2178,6 +2193,9 @@ static int __init userfaultfd_init(void)
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 						init_once_userfaultfd_ctx);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_userfaultfd_table);
+#endif
 	return 0;
 }
 __initcall(userfaultfd_init);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3767f18114ef..fff49fec0258 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -36,8 +36,6 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
-extern int sysctl_unprivileged_userfaultfd;
-
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1c240d2c99bc..c14552a662ae 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2438,17 +2438,6 @@ static struct ctl_table vm_table[] = {
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
2.25.1

