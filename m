Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAC39C590
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFEDs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 23:48:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39821 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFEDsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:48:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so5632242pls.6;
        Fri, 04 Jun 2021 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SO+yaAY8Fk45u9d7CKIQc/HZvjGFxnb666ka7wNnXAs=;
        b=C8Ip1DjssxWq1dZe/uqZBbxzaxEVMS7RMFfdCwuuXTPtSr/d0d0a2nKHDHiEG2nK3F
         3zZNXeKjTEGl4zev9xmoKdIXtCMZsxJMmhXs0RINn0dLiJLmUn8fgVoiu0P+3Yo0Ly3q
         H4zmHRLBG6N5C6nUFHa+EVnjMQCpfFo6Ke8Y8FuS7grAaENWu88u6zvn8aGzlMxl6RUs
         tPxRzEvK8iUTka/btIvxcBmI6VfduPjOpGRFE8kLL8V6cxP1ADUiJklwbakagRGifxIa
         Qi4Ng88fTiLD0xf/MDo5I1wiT7vJti98AG17Be21Nlh9adkZc3dlUeLd3BoC310tZmCz
         74qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SO+yaAY8Fk45u9d7CKIQc/HZvjGFxnb666ka7wNnXAs=;
        b=G+LuwIpks01w1BfYrAl7+4sGzd/BxMeVMfnVkZpfYwftGOy93pnhdnjjhrQzcDQemr
         0Fj6s2FC03YdhoWZGFD8a9+raAmv3FBW2k4oj//26ywjnJhpJJRLZx8Z0SKNNdvVjuLn
         lIrgLt9/Y6Rr/zpTkDFhwtqp4EJjBxCVSvj0Y9mCxfoE7Lnzh0ZeUfOSwQQuTTx4+dwx
         9HhiWxG55fjDZ1vW90ggbavnhIr27vQ1NQyI6BWuJtUpFfh4wC1Ivdqp7BL4j6jgby67
         S2z1Tit/cyuMkDzU6W7dwdhF3ZbMukzyPykyjFj0kKGz1Xzu7rerUFMX1rwRf+h+De7p
         5KNw==
X-Gm-Message-State: AOAM533MnVFP+QwpPhFKISWLFZjKN1LNlFvypKUviRq80JHSDRH3++/Q
        k3QAtmbzrA/cNZXVnbQgbdY=
X-Google-Smtp-Source: ABdhPJzPAKUItdRzDe5QyifhuhFM/ppGFwnoWr6+dTn/kPApkyeQRrmxJaL+25RHl+4+rXE+xMkmaw==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr8321724pjb.88.1622864724605;
        Fri, 04 Jun 2021 20:45:24 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id i10sm2879186pfk.74.2021.06.04.20.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 20:45:24 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, joe@perches.com,
        dong.menglong@zte.com.cn, jack@suse.cz, hare@suse.de,
        axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, neilb@suse.de, akpm@linux-foundation.org,
        linux@rasmusvillemoes.dk, brho@google.com, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        mhiramat@kernel.org, rostedt@goodmis.org, vbabka@suse.cz,
        glider@google.com, pmladek@suse.com, johannes.berg@intel.com,
        ebiederm@xmission.com, jojing64@gmail.com, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, mingo@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v6 2/2] init/do_mounts.c: create second mount for initramfs
Date:   Sat,  5 Jun 2021 11:44:47 +0800
Message-Id: <20210605034447.92917-3-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210605034447.92917-1-dong.menglong@zte.com.cn>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

If using container platforms such as Docker, upon initialization it
wants to use pivot_root() so that currently mounted devices do not
propagate to containers. An example of value in this is that
a USB device connected prior to the creation of a containers on the
host gets disconnected after a container is created; if the
USB device was mounted on containers, but already removed and
umounted on the host, the mount point will not go away until all
containers unmount the USB device.

Another reason for container platforms such as Docker to use pivot_root
is that upon initialization the net-namspace is mounted under
/var/run/docker/netns/ on the host by dockerd. Without pivot_root
Docker must either wait to create the network namespace prior to
the creation of containers or simply deal with leaking this to each
container.

pivot_root is supported if the rootfs is a initrd or block device, but
it's not supported if the rootfs uses an initramfs (tmpfs). This means
container platforms today must resort to using block devices if
they want to pivot_root from the rootfs. A workaround to use chroot()
is not a clean viable option given every container will have a
duplicate of every mount point on the host.

In order to support using container platforms such as Docker on
all the supported rootfs types we must extend Linux to support
pivot_root on initramfs as well. This patch does the work to do
just that.

pivot_root will unmount the mount of the rootfs from its parent mount
and mount the new root to it. However, when it comes to initramfs, it
donesn't work, because the root filesystem has not parent mount, which
makes initramfs not supported by pivot_root.

In order to make pivot_root supported on initramfs, we create a second
mount with type of rootfs before unpacking cpio, and change root to
this mount after unpacking.

While mounting the second rootfs, 'rootflags' is passed, and it means
that we can set options for the mount of rootfs in boot cmd now.
For example, the size of tmpfs can be set with 'rootflags=size=1024M'.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 init/do_mounts.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h | 17 ++++++++++++++++-
 init/initramfs.c |  8 ++++++++
 usr/Kconfig      | 10 ++++++++++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..715bdaa89b81 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -618,6 +618,49 @@ void __init prepare_namespace(void)
 }
 
 static bool is_tmpfs;
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+/*
+ * Give systems running from the initramfs and making use of pivot_root a
+ * proper mount so it can be umounted during pivot_root.
+ */
+int __init prepare_mount_rootfs(void)
+{
+	char *rootfs = "ramfs";
+
+	if (is_tmpfs)
+		rootfs = "tmpfs";
+
+	return do_mount_root(rootfs, rootfs,
+			     root_mountflags & ~MS_RDONLY,
+			     root_mount_data);
+}
+
+/*
+ * Revert to previous mount by chdir to '/' and unmounting the second
+ * mount.
+ */
+void __init revert_mount_rootfs(void)
+{
+	init_chdir("/");
+	init_umount(".", MNT_DETACH);
+}
+
+/*
+ * Change root to the new rootfs that mounted in prepare_mount_rootfs()
+ * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
+ */
+void __init finish_mount_rootfs(void)
+{
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (likely(ramdisk_exec_exist()))
+		init_chroot(".");
+	else
+		revert_mount_rootfs();
+}
+
+#define rootfs_init_fs_context ramfs_init_fs_context
+#else
 static int rootfs_init_fs_context(struct fs_context *fc)
 {
 	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
@@ -625,6 +668,7 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 
 	return ramfs_init_fs_context(fc);
 }
+#endif
 
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..ae4ab306caa9 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,9 +10,24 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
+extern int root_mountflags;
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
-extern int root_mountflags;
+
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+int  prepare_mount_rootfs(void);
+void finish_mount_rootfs(void);
+void revert_mount_rootfs(void);
+
+#else
+
+static inline int  prepare_mount_rootfs(void) { return 0; }
+static inline void finish_mount_rootfs(void) { }
+static inline void revert_mount_rootfs(void) { }
+
+#endif
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..1833de3cf04e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -16,6 +16,8 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 
+#include "do_mounts.h"
+
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
 {
@@ -682,13 +684,19 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	else
 		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	if (prepare_mount_rootfs())
+		panic("Failed to mount rootfs");
+
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
+		revert_mount_rootfs();
 #ifdef CONFIG_BLK_DEV_RAM
 		populate_initrd_image(err);
 #else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
+	} else {
+		finish_mount_rootfs();
 	}
 
 done:
diff --git a/usr/Kconfig b/usr/Kconfig
index 8bbcf699fe3b..4f6ac12eafe9 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_MOUNT
+	bool "Create second mount to make pivot_root() supported"
+	default y
+	help
+	  Before unpacking cpio, create a second mount and make it become
+	  the root filesystem. Therefore, initramfs will be supported by
+	  pivot_root().
+
+	  If container platforms is used with initramfs, say Y.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	default y
-- 
2.32.0.rc0

