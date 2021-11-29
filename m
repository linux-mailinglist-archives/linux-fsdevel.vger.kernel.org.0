Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA394627C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhK2XJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbhK2XJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:09:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6039C09B195;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h6IrSH0GHepcGUE39G/28OhFGK4xmoJIeiHG2f6yFoA=; b=csu+Z9MfPBMUauTR3wEM6gjQdZ
        XfsMyywT7EiNYpSgAAMNmpbPyyoh43d02teetdoDGEnml3b03UC+f6R7l8++yVpOhtZoAcQ6qB0gP
        tPSJ7rzPuUly+XW13NnTeF3nOydkWQp2cLwfiSOiYcj44Iu06Q2bRekEpZ1Us2c+0hYIeeW+9kRhM
        +6j+AxuBudfHGrifkMQjRCISyCISvHpwBcjj/FYFLsd9y2VEfQuHh4Ch1QPX7+rqfOWQ2plMYGfqa
        l/L40eZFz/N0obp/NNSE2naK6HoQKVONBATEYpV8fQp0pES3bmaRJIYRAy1BJFxQ3Z2dMGvzZyRL8
        QqpCLiqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002gZz-Ms; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] fs: move namespace sysctls and declare fs base directory
Date:   Mon, 29 Nov 2021 13:19:39 -0800
Message-Id: <20211129211943.640266-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211129211943.640266-1-mcgrof@kernel.org>
References: <20211129211943.640266-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This moves the namespace sysctls to its own file as part of the
kernel/sysctl.c spring cleaning

Since we have now removed all sysctls for "fs", we now have to
declare it on the filesystem code, we do that using the new helper,
which reduces boiler plate code.

We rename init_fs_shared_sysctls() to init_fs_sysctls() to reflect
that now fs/sysctls.c is taking on the burden of being the first
to register the base directory as well.

Lastly, since init code will load in the order in which we link it
we have to move the sysctl code to be linked in early, so that its
early init routine runs prior to other fs code. This way, other
filesystem code can register their own sysctls using the helpers
after this:

  * register_sysctl_init()
  * register_sysctl()

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/Makefile           |  3 ++-
 fs/namespace.c        | 24 +++++++++++++++++++++++-
 fs/sysctls.c          |  9 +++++----
 include/linux/mount.h |  3 ---
 kernel/sysctl.c       | 14 --------------
 5 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index ea8770d124da..dab324aea08f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -6,6 +6,8 @@
 # Rewritten to use lists instead of if-statements.
 # 
 
+obj-$(CONFIG_SYSCTL)		+= sysctls.o
+
 obj-y :=	open.o read_write.o file_table.o super.o \
 		char_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
 		ioctl.o readdir.o select.o dcache.o inode.o \
@@ -28,7 +30,6 @@ obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-y				+= anon_inodes.o
 obj-$(CONFIG_SIGNALFD)		+= signalfd.o
-obj-$(CONFIG_SYSCTL)		+= sysctls.o
 obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
 obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
diff --git a/fs/namespace.c b/fs/namespace.c
index 3ab45b47b286..647af66f313d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -36,7 +36,7 @@
 #include "internal.h"
 
 /* Maximum number of mounts in a mount namespace */
-unsigned int sysctl_mount_max __read_mostly = 100000;
+static unsigned int sysctl_mount_max __read_mostly = 100000;
 
 static unsigned int m_hash_mask __read_mostly;
 static unsigned int m_hash_shift __read_mostly;
@@ -4612,3 +4612,25 @@ const struct proc_ns_operations mntns_operations = {
 	.install	= mntns_install,
 	.owner		= mntns_owner,
 };
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table fs_namespace_sysctls[] = {
+	{
+		.procname	= "mount-max",
+		.data		= &sysctl_mount_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init init_fs_namespace_sysctls(void)
+{
+	register_sysctl_init("fs", fs_namespace_sysctls);
+	return 0;
+}
+fs_initcall(init_fs_namespace_sysctls);
+
+#endif /* CONFIG_SYSCTL */
diff --git a/fs/sysctls.c b/fs/sysctls.c
index 54216cd1ecd7..c701273c9432 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -29,10 +29,11 @@ static struct ctl_table fs_shared_sysctls[] = {
 	{ }
 };
 
-static int __init init_fs_shared_sysctls(void)
+DECLARE_SYSCTL_BASE(fs, fs_shared_sysctls);
+
+static int __init init_fs_sysctls(void)
 {
-	register_sysctl_init("fs", fs_shared_sysctls);
-	return 0;
+	return register_sysctl_base(fs);
 }
 
-early_initcall(init_fs_shared_sysctls);
+early_initcall(init_fs_sysctls);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5d92a7e1a742..7f18a7555dff 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -113,9 +113,6 @@ extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
 extern void mark_mounts_for_expiry(struct list_head *mounts);
 
 extern dev_t name_to_dev_t(const char *name);
-
-extern unsigned int sysctl_mount_max;
-
 extern bool path_is_mountpoint(const struct path *path);
 
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bbbafe545723..8d4cab1fbe9f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2810,18 +2810,6 @@ static struct ctl_table vm_table[] = {
 	{ }
 };
 
-static struct ctl_table fs_table[] = {
-	{
-		.procname	= "mount-max",
-		.data		= &sysctl_mount_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{ }
-};
-
 static struct ctl_table debug_table[] = {
 #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
 	{
@@ -2852,7 +2840,6 @@ static struct ctl_table dev_table[] = {
 
 DECLARE_SYSCTL_BASE(kernel, kern_table);
 DECLARE_SYSCTL_BASE(vm, vm_table);
-DECLARE_SYSCTL_BASE(fs, fs_table);
 DECLARE_SYSCTL_BASE(debug, debug_table);
 DECLARE_SYSCTL_BASE(dev, dev_table);
 
@@ -2860,7 +2847,6 @@ int __init sysctl_init(void)
 {
 	register_sysctl_base(kernel);
 	register_sysctl_base(vm);
-	register_sysctl_base(fs);
 	register_sysctl_base(debug);
 	register_sysctl_base(dev);
 
-- 
2.33.0

