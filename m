Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB754462780
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhK2XGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhK2XGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:06:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AC6C0F4B26;
        Mon, 29 Nov 2021 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DFkAuiLlJgGJvY2k3xmqh87XecWf0cvSJbFfKizd6jA=; b=vRwnV+a8kv4xfG4VKOunlJ/t0p
        s6zM31bSgGMu4GS5v44MeNmotn8WwaRLTnxeaJpglNunytSz6Jy8BvmSTYBnMmUdKzd5KmdVUSeo2
        +nMgmMKnkhEaYFB7edaRbi2j5QQDRmZnXXZvf/wiL6E4PWogO3hyNlh01qR3ST2bD5y7zTLS3T/E/
        6FCvO7h6ugIAJj4dds6nzwJWKHQSGfVRQgzCkjNF/XVhEtWQICssly9ZxcsQpQr7xktl6O2Zll9Rb
        zSsKp523SWLBZi2lRXYiFNbDxHjMZiwHolPuTMe/0uI5JgRDwb92vRl1N2fG6XawbRhy6YX3LsSuk
        BPsV+WGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZi-6l; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] fs: move shared sysctls to fs/sysctls.c
Date:   Mon, 29 Nov 2021 12:55:44 -0800
Message-Id: <20211129205548.605569-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move sysctls which are shared between filesystems into a common
file outside of kernel/sysctl.c.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/Makefile     |  1 +
 fs/sysctls.c    | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c | 18 ------------------
 3 files changed, 39 insertions(+), 18 deletions(-)
 create mode 100644 fs/sysctls.c

diff --git a/fs/Makefile b/fs/Makefile
index 84c5e4cdfee5..ea8770d124da 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -28,6 +28,7 @@ obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-y				+= anon_inodes.o
 obj-$(CONFIG_SIGNALFD)		+= signalfd.o
+obj-$(CONFIG_SYSCTL)		+= sysctls.o
 obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
diff --git a/fs/sysctls.c b/fs/sysctls.c
new file mode 100644
index 000000000000..54216cd1ecd7
--- /dev/null
+++ b/fs/sysctls.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * /proc/sys/fs shared sysctls
+ *
+ * These sysctls are shared between different filesystems.
+ */
+#include <linux/init.h>
+#include <linux/sysctl.h>
+
+static struct ctl_table fs_shared_sysctls[] = {
+	{
+		.procname	= "overflowuid",
+		.data		= &fs_overflowuid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_MAXOLDUID,
+	},
+	{
+		.procname	= "overflowgid",
+		.data		= &fs_overflowgid,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_MAXOLDUID,
+	},
+	{ }
+};
+
+static int __init init_fs_shared_sysctls(void)
+{
+	register_sysctl_init("fs", fs_shared_sysctls);
+	return 0;
+}
+
+early_initcall(init_fs_shared_sysctls);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 05d9dd85e17f..865173cefcef 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2896,24 +2896,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "overflowuid",
-		.data		= &fs_overflowuid,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
-	},
-	{
-		.procname	= "overflowgid",
-		.data		= &fs_overflowgid,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
-	},
 #ifdef CONFIG_FILE_LOCKING
 	{
 		.procname	= "leases-enable",
-- 
2.33.0

