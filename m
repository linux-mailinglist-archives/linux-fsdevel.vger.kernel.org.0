Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D524625DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhK2WoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhK2Wnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A51C0F4B29;
        Mon, 29 Nov 2021 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tRAXjxgaGRnjxBVQRgKpO7UHxvbJzoHTMmgHdwzbDIs=; b=ksOOZZQgRmDaQ1wbe0It4wKHMl
        Wq1Y24MheGtc3X502qtCdTTQZP5XbmxWgENxuCooWHA0icZcFyPRqu1RUn/pcwuNDCq3lU3LgkKQv
        zIZHUbvFs0kRzYBu2P6wl++6E0Vkz8eU9piA9UJPtH091peDlGwZyzYRzWBNvwljxEYaW5obA7hVQ
        mOrwsj7aPvQN/65JSPdSIeY+TsU12DF0n5anFhDr0CvoHqS+HEF/dzGOzVo7QqHeswcqo3j2ZwoNO
        HdkBezE2SCSKRELpx9p4M04KEMW+GXTm018niX3R1HIIK6dWcjFSV7TP59B0PyQq2ILpZQYNZnUQn
        9eeZ0kHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngl-002XZV-0S; Mon, 29 Nov 2021 20:55:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] fs: move inode sysctls to its own file
Date:   Mon, 29 Nov 2021 12:55:40 -0800
Message-Id: <20211129205548.605569-2-mcgrof@kernel.org>
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

So move the inode sysctls to its own file. Since we are no longer
using this outside of fs/ remove the extern declaration of
its respective proc helper.

We use early_initcall() as it is the earliest we can use.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/inode.c         | 31 ++++++++++++++++++++++++++++---
 include/linux/fs.h |  3 ---
 kernel/sysctl.c    | 14 --------------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 980e7b7a5460..bef6ba9b8eb4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -70,7 +70,7 @@ EXPORT_SYMBOL(empty_aops);
 /*
  * Statistics gathering..
  */
-struct inodes_stat_t inodes_stat;
+static struct inodes_stat_t inodes_stat;
 
 static DEFINE_PER_CPU(unsigned long, nr_inodes);
 static DEFINE_PER_CPU(unsigned long, nr_unused);
@@ -106,13 +106,38 @@ long get_nr_dirty_inodes(void)
  * Handle nr_inode sysctl
  */
 #ifdef CONFIG_SYSCTL
-int proc_nr_inodes(struct ctl_table *table, int write,
-		   void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_nr_inodes(struct ctl_table *table, int write, void *buffer,
+			  size_t *lenp, loff_t *ppos)
 {
 	inodes_stat.nr_inodes = get_nr_inodes();
 	inodes_stat.nr_unused = get_nr_inodes_unused();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
+
+static struct ctl_table inodes_sysctls[] = {
+	{
+		.procname	= "inode-nr",
+		.data		= &inodes_stat,
+		.maxlen		= 2*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_inodes,
+	},
+	{
+		.procname	= "inode-state",
+		.data		= &inodes_stat,
+		.maxlen		= 7*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_inodes,
+	},
+	{ }
+};
+
+static int __init init_fs_inode_sysctls(void)
+{
+	register_sysctl_init("fs", inodes_sysctls);
+	return 0;
+}
+early_initcall(init_fs_inode_sysctls);
 #endif
 
 static int no_open(struct inode *inode, struct file *file)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6d13424891dd..667c291b53c5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -81,7 +81,6 @@ extern void __init files_maxfiles_init(void);
 extern struct files_stat_struct files_stat;
 extern unsigned long get_max_files(void);
 extern unsigned int sysctl_nr_open;
-extern struct inodes_stat_t inodes_stat;
 extern int leases_enable, lease_break_time;
 extern int sysctl_protected_symlinks;
 extern int sysctl_protected_hardlinks;
@@ -3596,8 +3595,6 @@ int proc_nr_files(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos);
 int proc_nr_dentry(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos);
-int proc_nr_inodes(struct ctl_table *table, int write,
-		   void *buffer, size_t *lenp, loff_t *ppos);
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8f9c275e0242..3eb71bf91b71 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2900,20 +2900,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "inode-nr",
-		.data		= &inodes_stat,
-		.maxlen		= 2*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_inodes,
-	},
-	{
-		.procname	= "inode-state",
-		.data		= &inodes_stat,
-		.maxlen		= 7*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_inodes,
-	},
 	{
 		.procname	= "file-nr",
 		.data		= &files_stat,
-- 
2.33.0

