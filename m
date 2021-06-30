Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0C3B7B64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 03:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhF3Btu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 21:49:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9320 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhF3Btt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 21:49:49 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GF3yK6cWxz73kY;
        Wed, 30 Jun 2021 09:43:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 09:47:19 +0800
Received: from localhost (10.175.101.6) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 09:47:18 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <keescook@chromium.org>,
        <gregkh@linuxfoundation.org>
CC:     <samitolvanen@google.com>, <ojeda@kernel.org>, <johan@kernel.org>,
        <akpm@linux-foundation.org>, <masahiroy@kernel.org>,
        <elver@google.com>, <joe@perches.com>, <hare@suse.de>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next v2] rootfs: rootflags take effect when mount rootfs
Date:   Wed, 30 Jun 2021 09:47:44 +0800
Message-ID: <20210630014744.88735-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.31.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel root filesystem may use the rootflags parameters
when mount, especially for tmpfs, to setup a variety of features.

For example:
1. Add 'rootflags=huge=always' to boot args.
2. When the OS bootup:
rootfs on / type rootfs (..., huge=always)
Then we can get the hugepage performance improvement of tmpfs.

Usage:
Relevant documents (Documentation/admin-guide/kernel-parameters.txt)
description:
    rootflags=      [KNL] Set root filesystem mount option string

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 fs/namespace.c       | 5 +++--
 include/linux/init.h | 2 +-
 init/do_mounts.c     | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3f1a78ba369..318ad4fbc20b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4184,6 +4184,7 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+static char * __initdata rootfs_flags;
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
@@ -4191,7 +4192,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
@@ -4245,7 +4246,7 @@ void __init mnt_init(void)
 	if (!fs_kobj)
 		printk(KERN_WARNING "%s: kobj create error\n", __func__);
 	shmem_init();
-	init_rootfs();
+	init_rootfs(&rootfs_flags);
 	init_mount_tree();
 }
 
diff --git a/include/linux/init.h b/include/linux/init.h
index d82b4b2e1d25..d8d46d3c73fb 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -148,7 +148,7 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
-void __init init_rootfs(void);
+void __init init_rootfs(char **rootfs_flags);
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..42019b5fbf45 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -632,9 +632,11 @@ struct file_system_type rootfs_fs_type = {
 	.kill_sb	= kill_litter_super,
 };
 
-void __init init_rootfs(void)
+void __init init_rootfs(char **rootfs_flags)
 {
 	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
 		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
+
+	*rootfs_flags = root_mount_data;
 }
-- 
2.31.GIT

