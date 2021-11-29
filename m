Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D000A462698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhK2Wyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhK2Wx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC0AC0F4B27;
        Mon, 29 Nov 2021 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MBeUlxms4g1e2v6WCThbye8I3Ed9/fUTVuymP55TEVs=; b=vjq2oI9QYW9HtUPN6vfED1rBfX
        H4vHmbL83VmVTA0bHREu9f0ILOSDgP+0QhXag6dLQduCSskRcHzscAA7FXHRwr94x6gPg5aa/daKO
        fAzA6dhd13eMQMvR9cKDf65JLpL81tcCqfCNX4eJEo0C/FAbRrnXRrg2ymH6YKQGYZl8LxLaMGsgJ
        aidwT1dR7rDD7Af6fCoRXRN07Y4IPuo1i+uzUpUWpN4wre5k4ImPPMD9bZ4tbcIU05MnOHcWSW6cC
        GdD8EPmSCqHwOWeRKYtqCPhy5NZ+hOP+SBQZ4OQ6zmLIK3ItCq1T8smw4VOril8jE7MeGQp/0H/Ir
        oZk+36fQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZk-8m; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] fs: move locking sysctls where they are used
Date:   Mon, 29 Nov 2021 12:55:45 -0800
Message-Id: <20211129205548.605569-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129205548.605569-1-mcgrof@kernel.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel/sysctl.c is a kitchen sink where everyone leaves
their dirty dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to
places where they actually belong. The proc sysctl maintainers
do not want to know what sysctl knobs you wish to add for your own
piece of code, we just care about the core logic.

The locking fs sysctls are only used on fs/locks.c, so move
them there.
---
 fs/locks.c         | 34 ++++++++++++++++++++++++++++++++--
 include/linux/fs.h |  4 ----
 kernel/sysctl.c    | 20 --------------------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0fca9d680978..8c6df10cd9ed 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -62,6 +62,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/hashtable.h>
 #include <linux/percpu.h>
+#include <linux/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filelock.h>
@@ -88,8 +89,37 @@ static int target_leasetype(struct file_lock *fl)
 	return fl->fl_type;
 }
 
-int leases_enable = 1;
-int lease_break_time = 45;
+static int leases_enable = 1;
+static int lease_break_time = 45;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table locks_sysctls[] = {
+	{
+		.procname	= "leases-enable",
+		.data		= &leases_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#ifdef CONFIG_MMU
+	{
+		.procname	= "lease-break-time",
+		.data		= &lease_break_time,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+#endif /* CONFIG_MMU */
+	{}
+};
+
+static int __init init_fs_locks_sysctls(void)
+{
+	register_sysctl_init("fs", locks_sysctls);
+	return 0;
+}
+early_initcall(init_fs_locks_sysctls);
+#endif /* CONFIG_SYSCTL */
 
 /*
  * The global file_lock_list is only used for displaying /proc/locks, so we
diff --git a/include/linux/fs.h b/include/linux/fs.h
index edec0692f943..9ff634184f58 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -81,10 +81,6 @@ extern void __init files_maxfiles_init(void);
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
 extern int leases_enable, lease_break_time;
-extern int sysctl_protected_symlinks;
-extern int sysctl_protected_hardlinks;
-extern int sysctl_protected_fifos;
-extern int sysctl_protected_regular;
 
 typedef __kernel_rwf_t rwf_t;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 865173cefcef..52a86746ac9d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2896,26 +2896,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-#ifdef CONFIG_FILE_LOCKING
-	{
-		.procname	= "leases-enable",
-		.data		= &leases_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
-#ifdef CONFIG_MMU
-#ifdef CONFIG_FILE_LOCKING
-	{
-		.procname	= "lease-break-time",
-		.data		= &lease_break_time,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
-#endif
 	{
 		.procname	= "protected_symlinks",
 		.data		= &sysctl_protected_symlinks,
-- 
2.33.0

