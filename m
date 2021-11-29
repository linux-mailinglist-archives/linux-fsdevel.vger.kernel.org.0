Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56C4625E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhK2WoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhK2Wnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434FC0F4B2A;
        Mon, 29 Nov 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tm9qm3VeHN10PG+90IU5R5ZYzfv43W620K/ViCKSnyc=; b=ZgDnot7Iohh/VxHI7PwerufIqO
        UieetiYUn7kxqyS6zdUAgMC1x1yKNuD0ZQiWUq/X3yPz8bmsGu8p6O3PZn/c1WP6EstF0m+89CxX8
        NlK/4skNAyygCwf0TG+mRSPORxp08usvdF/ohAUCL01BEQmO6Vp6UZDFfsvWpzQQ5peCtqCH/LyM2
        3Qwt6n2tyr92g28pllKQUIRIaF0roOAdSX6sjagslz9aojIy3UbN+OvC53bA3js+bd4gxk4oT+Ugy
        K3ibDz1Ph7LOz/Tlxjn/CV5WxjktTS3PfQYO8F6PJdIzKd/MkEMzSgxF+p3KGhMWmWczEV12rm4bZ
        cXACFQWw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XaR-FN; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] fs: move pipe sysctls to is own file
Date:   Mon, 29 Nov 2021 12:55:48 -0800
Message-Id: <20211129205548.605569-10-mcgrof@kernel.org>
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

So move the pipe sysctls to its own file.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/pipe.c                 | 64 +++++++++++++++++++++++++++++++++++++--
 include/linux/pipe_fs_i.h |  4 ---
 include/linux/sysctl.h    |  6 ++++
 kernel/sysctl.c           | 61 ++++---------------------------------
 4 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6d4342bad9f1..cc28623a67b6 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -25,6 +25,7 @@
 #include <linux/fcntl.h>
 #include <linux/memcontrol.h>
 #include <linux/watch_queue.h>
+#include <linux/sysctl.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -50,13 +51,13 @@
  * The max size that a non-root user is allowed to grow the pipe. Can
  * be set by root in /proc/sys/fs/pipe-max-size
  */
-unsigned int pipe_max_size = 1048576;
+static unsigned int pipe_max_size = 1048576;
 
 /* Maximum allocatable pages per user. Hard limit is unset by default, soft
  * matches default values.
  */
-unsigned long pipe_user_pages_hard;
-unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
+static unsigned long pipe_user_pages_hard;
+static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
 
 /*
  * We use head and tail indices that aren't masked off, except at the point of
@@ -1428,6 +1429,60 @@ static struct file_system_type pipe_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
+#ifdef CONFIG_SYSCTL
+static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
+					unsigned int *valp,
+					int write, void *data)
+{
+	if (write) {
+		unsigned int val;
+
+		val = round_pipe_size(*lvalp);
+		if (val == 0)
+			return -EINVAL;
+
+		*valp = val;
+	} else {
+		unsigned int val = *valp;
+		*lvalp = (unsigned long) val;
+	}
+
+	return 0;
+}
+
+static int proc_dopipe_max_size(struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return do_proc_douintvec(table, write, buffer, lenp, ppos,
+				 do_proc_dopipe_max_size_conv, NULL);
+}
+
+static struct ctl_table fs_pipe_sysctls[] = {
+	{
+		.procname	= "pipe-max-size",
+		.data		= &pipe_max_size,
+		.maxlen		= sizeof(pipe_max_size),
+		.mode		= 0644,
+		.proc_handler	= proc_dopipe_max_size,
+	},
+	{
+		.procname	= "pipe-user-pages-hard",
+		.data		= &pipe_user_pages_hard,
+		.maxlen		= sizeof(pipe_user_pages_hard),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "pipe-user-pages-soft",
+		.data		= &pipe_user_pages_soft,
+		.maxlen		= sizeof(pipe_user_pages_soft),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{ }
+};
+#endif
+
 static int __init init_pipe_fs(void)
 {
 	int err = register_filesystem(&pipe_fs_type);
@@ -1439,6 +1494,9 @@ static int __init init_pipe_fs(void)
 			unregister_filesystem(&pipe_fs_type);
 		}
 	}
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("fs", fs_pipe_sysctls);
+#endif
 	return err;
 }
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index fc5642431b92..c00c618ef290 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -238,10 +238,6 @@ void pipe_lock(struct pipe_inode_info *);
 void pipe_unlock(struct pipe_inode_info *);
 void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
 
-extern unsigned int pipe_max_size;
-extern unsigned long pipe_user_pages_hard;
-extern unsigned long pipe_user_pages_soft;
-
 /* Wait for a pipe to be readable/writable while dropping the pipe lock */
 void pipe_wait_readable(struct pipe_inode_info *);
 void pipe_wait_writable(struct pipe_inode_info *);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index bb921eb8a02d..4294e9668bd5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -221,6 +221,12 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
+int do_proc_douintvec(struct ctl_table *table, int write,
+		      void *buffer, size_t *lenp, loff_t *ppos,
+		      int (*conv)(unsigned long *lvalp,
+				  unsigned int *valp,
+				  int write, void *data),
+		      void *data);
 
 extern int pwrsw_enabled;
 extern int unaligned_enabled;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0146fc549978..a4cde441635d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -56,7 +56,6 @@
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
-#include <linux/pipe_fs_i.h>
 #include <linux/oom.h>
 #include <linux/kmod.h>
 #include <linux/capability.h>
@@ -760,12 +759,12 @@ static int __do_proc_douintvec(void *tbl_data, struct ctl_table *table,
 	return do_proc_douintvec_r(i, buffer, lenp, ppos, conv, data);
 }
 
-static int do_proc_douintvec(struct ctl_table *table, int write,
-			     void *buffer, size_t *lenp, loff_t *ppos,
-			     int (*conv)(unsigned long *lvalp,
-					 unsigned int *valp,
-					 int write, void *data),
-			     void *data)
+int do_proc_douintvec(struct ctl_table *table, int write,
+		      void *buffer, size_t *lenp, loff_t *ppos,
+		      int (*conv)(unsigned long *lvalp,
+				  unsigned int *valp,
+				  int write, void *data),
+		      void *data)
 {
 	return __do_proc_douintvec(table->data, table, write,
 				   buffer, lenp, ppos, conv, data);
@@ -1089,33 +1088,6 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
-					unsigned int *valp,
-					int write, void *data)
-{
-	if (write) {
-		unsigned int val;
-
-		val = round_pipe_size(*lvalp);
-		if (val == 0)
-			return -EINVAL;
-
-		*valp = val;
-	} else {
-		unsigned int val = *valp;
-		*lvalp = (unsigned long) val;
-	}
-
-	return 0;
-}
-
-static int proc_dopipe_max_size(struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-				 do_proc_dopipe_max_size_conv, NULL);
-}
-
 #ifdef CONFIG_MAGIC_SYSRQ
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
@@ -2839,27 +2811,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "pipe-max-size",
-		.data		= &pipe_max_size,
-		.maxlen		= sizeof(pipe_max_size),
-		.mode		= 0644,
-		.proc_handler	= proc_dopipe_max_size,
-	},
-	{
-		.procname	= "pipe-user-pages-hard",
-		.data		= &pipe_user_pages_hard,
-		.maxlen		= sizeof(pipe_user_pages_hard),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
-	{
-		.procname	= "pipe-user-pages-soft",
-		.data		= &pipe_user_pages_soft,
-		.maxlen		= sizeof(pipe_user_pages_soft),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-	},
 	{
 		.procname	= "mount-max",
 		.data		= &sysctl_mount_max,
-- 
2.33.0

