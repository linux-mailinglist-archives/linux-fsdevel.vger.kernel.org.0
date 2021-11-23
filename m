Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E045AD3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhKWU1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhKWU11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9777C061746;
        Tue, 23 Nov 2021 12:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fvJ1zNviSpEWvNzghsQMTjAajeym6K/XNsF9qk9FX3s=; b=r+bJv+AybA6J9+KN5G2Fdx7c/o
        DN5G/GVrPl+gVzXjyDe10QrKuuQwSzm0Qz5EwvWwJL4P4FtcPgGEMNbtsQVdSC+5C22Tmch5uoQvF
        du039YaFmBsbPYqvWchB4z8Iv3X7cgLAtLFTeF6SEjoXCa6KJTjYxv6SgWZ0qdfaVM7mBmrz1nRHl
        zdVxZqwx7mB0Pvya4l5qSitdXjBFJ66OS8Ity0BDyekAatyBSD+VOuFW5Y7c1J5CdASfBuexNIfCn
        0eQQpA0zqmWJwKrhlaFi6Zyob+8StEXBO2LziGFXmli5LKR12rs8JhMzQvTu39uKCJdxYLP8YH5Oo
        fcDdJVJg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qr8-DW; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 9/9] dnotify: move dnotify sysctl to dnotify.c
Date:   Tue, 23 Nov 2021 12:23:47 -0800
Message-Id: <20211123202347.818157-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211123202347.818157-1-mcgrof@kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

So move dnotify sysctls to dnotify.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
[mcgrof: adjust the commit log to justify the move]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/notify/dnotify/dnotify.c | 21 ++++++++++++++++++++-
 include/linux/dnotify.h     |  1 -
 kernel/sysctl.c             | 10 ----------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e85e13c50d6d..2b04e2296fb6 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -19,7 +19,25 @@
 #include <linux/fdtable.h>
 #include <linux/fsnotify_backend.h>
 
-int dir_notify_enable __read_mostly = 1;
+static int dir_notify_enable __read_mostly = 1;
+#ifdef CONFIG_SYSCTL
+static struct ctl_table dnotify_sysctls[] = {
+	{
+		.procname	= "dir-notify-enable",
+		.data		= &dir_notify_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{}
+};
+static void __init dnotify_sysctl_init(void)
+{
+	register_sysctl_init("fs", dnotify_sysctls);
+}
+#else
+#define dnotify_sysctl_init() do { } while (0)
+#endif
 
 static struct kmem_cache *dnotify_struct_cache __read_mostly;
 static struct kmem_cache *dnotify_mark_cache __read_mostly;
@@ -386,6 +404,7 @@ static int __init dnotify_init(void)
 	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
+	dnotify_sysctl_init();
 	return 0;
 }
 
diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
index 0aad774beaec..4f3b25d47436 100644
--- a/include/linux/dnotify.h
+++ b/include/linux/dnotify.h
@@ -29,7 +29,6 @@ struct dnotify_struct {
 			    FS_CREATE | FS_DN_RENAME |\
 			    FS_MOVED_FROM | FS_MOVED_TO)
 
-extern int dir_notify_enable;
 extern void dnotify_flush(struct file *, fl_owner_t);
 extern int fcntl_dirnotify(int, struct file *, unsigned long);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 20326d67b814..7a90a12b9ea4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -48,7 +48,6 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
-#include <linux/dnotify.h>
 #include <linux/syscalls.h>
 #include <linux/vmstat.h>
 #include <linux/nfs_fs.h>
@@ -3090,15 +3089,6 @@ static struct ctl_table fs_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_DNOTIFY
-	{
-		.procname	= "dir-notify-enable",
-		.data		= &dir_notify_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 #ifdef CONFIG_MMU
 #ifdef CONFIG_FILE_LOCKING
 	{
-- 
2.33.0

