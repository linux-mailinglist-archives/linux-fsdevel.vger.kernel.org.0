Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3146259A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhK2WlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhK2Wk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:40:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3BEC0F4B2C;
        Mon, 29 Nov 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UD/ENffFxiWPOpCn2A7XHe3ViO8svGYO5DlTJTehoUs=; b=fDJ0QnjRvmFTIr4vpu1SdfipNr
        FtB8p/rK1QaxhmaXos+Ik95dG/8h/TEU6EmHHJNx3AU1XpV1mNn6Snwg7/4C5miWHARzJ5dCDYXfu
        4PUn8nP/+B3/WhpJ7EsEPkcyM8rQhrJRu3sTBeIX9KNbkO6UlxTIftczUu+mWa76QPKVJVAXoxaOb
        satqtX/mKK6IFL0+4S4XhKSivOP5/Pv3lliYHux0R9rGOzbHEaTXnqJtZAM9E5B+RL5Vpkb/kwGC/
        9gUmlCjXb2Crmn2HLVAK9Pivg3DlM7tFHdGw1m0F2C7rZn3f1LNivekaTMSeQM0EEBFChqTuPTvbh
        hTWIyp0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZX-29; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] fs: move fs stat sysctls to file_table.c
Date:   Mon, 29 Nov 2021 12:55:41 -0800
Message-Id: <20211129205548.605569-3-mcgrof@kernel.org>
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

We can create the sysctl dynamically on early init for fs stat
to help with this clutter. This dusts off the fs stat syctls knobs
and puts them into where they are declared.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/file_table.c    | 47 ++++++++++++++++++++++++++++++++++++++--------
 include/linux/fs.h |  3 ---
 kernel/sysctl.c    | 25 ------------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..57edef16dce4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -33,7 +33,7 @@
 #include "internal.h"
 
 /* sysctl tunables... */
-struct files_stat_struct files_stat = {
+static struct files_stat_struct files_stat = {
 	.max_files = NR_FILE
 };
 
@@ -75,22 +75,53 @@ unsigned long get_max_files(void)
 }
 EXPORT_SYMBOL_GPL(get_max_files);
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
+
 /*
  * Handle nr_files sysctl
  */
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
-int proc_nr_files(struct ctl_table *table, int write,
-                     void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_nr_files(struct ctl_table *table, int write, void *buffer,
+			 size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
-#else
-int proc_nr_files(struct ctl_table *table, int write,
-                     void *buffer, size_t *lenp, loff_t *ppos)
+
+static struct ctl_table fs_stat_sysctls[] = {
+	{
+		.procname	= "file-nr",
+		.data		= &files_stat,
+		.maxlen		= sizeof(files_stat),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_files,
+	},
+	{
+		.procname	= "file-max",
+		.data		= &files_stat.max_files,
+		.maxlen		= sizeof(files_stat.max_files),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= SYSCTL_LONG_ZERO,
+		.extra2		= SYSCTL_LONG_MAX,
+	},
+	{
+		.procname	= "nr_open",
+		.data		= &sysctl_nr_open,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &sysctl_nr_open_min,
+		.extra2		= &sysctl_nr_open_max,
+	},
+	{ }
+};
+
+static int __init init_fs_stat_sysctls(void)
 {
-	return -ENOSYS;
+	register_sysctl_init("fs", fs_stat_sysctls);
+	return 0;
 }
+fs_initcall(init_fs_stat_sysctls);
 #endif
 
 static struct file *__alloc_file(int flags, const struct cred *cred)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 667c291b53c5..adb74ecaf686 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -78,7 +78,6 @@ extern void __init inode_init_early(void);
 extern void __init files_init(void);
 extern void __init files_maxfiles_init(void);
 
-extern struct files_stat_struct files_stat;
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
 extern int leases_enable, lease_break_time;
@@ -3591,8 +3590,6 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos);
 
 struct ctl_table;
-int proc_nr_files(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos);
 int proc_nr_dentry(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos);
 int __init list_bdev_fs_names(char *buf, size_t size);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3eb71bf91b71..a94d24595fa3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2900,31 +2900,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "file-nr",
-		.data		= &files_stat,
-		.maxlen		= sizeof(files_stat),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_files,
-	},
-	{
-		.procname	= "file-max",
-		.data		= &files_stat.max_files,
-		.maxlen		= sizeof(files_stat.max_files),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_LONG_ZERO,
-		.extra2		= SYSCTL_LONG_MAX,
-	},
-	{
-		.procname	= "nr_open",
-		.data		= &sysctl_nr_open,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &sysctl_nr_open_min,
-		.extra2		= &sysctl_nr_open_max,
-	},
 	{
 		.procname	= "dentry-state",
 		.data		= &dentry_stat,
-- 
2.33.0

