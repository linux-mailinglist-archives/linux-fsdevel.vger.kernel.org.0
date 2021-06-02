Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B822E398D64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFBOsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFBOsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:48:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD94C061574;
        Wed,  2 Jun 2021 07:47:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e1so1203037pld.13;
        Wed, 02 Jun 2021 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbBzBMV2z4C32DY5xtLpbI1FptMG4u2XNx+XA5aT/Yc=;
        b=dl+FrSzf+rCcbmoN1HoHFna+2k5PWNF7S1o2yDZ1vpzYHPiG2iO7EwnZ8NO5IoGebA
         y0TFTipjJISdJ1LczYCH4PH7iR7h3l/7GLmk1OFDci+dD2+Mbn2BQCN2XegPZRK5bPJ1
         KgaYHryTMOehwlsCWac3Eh00qsP0hNpIGUbFAkZwSC4Gvzw8RRYWxl3BYFtg+CRUzMGm
         Xapj3MRKi4IjHDc1aSru8cNIH5LdU/aRz97SmKFP3PYIIBkxC7Yn3aNA/Emi07Pnx7Hr
         RnORinqbrxQwZecxpZ6rRKyWTFKVWIW0uw9884POPyeXPFGmvZrCw5spgW5yd9Q/F1IZ
         79zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbBzBMV2z4C32DY5xtLpbI1FptMG4u2XNx+XA5aT/Yc=;
        b=nIedxW3WJGxStwKqVmXvD/v4kH+VwlBp5ZWcooJq40mdWVVVD5ojpkrQTvNqP5zK7U
         YAfHe+Dek38Bc57OWMb2SOdUgApAhax9dorA7QuOfU+4Ig9+hjVvBlD/M0jHoSat3T0z
         cKhRexCuUYNntL4N4A3PTb1HbRNC7tCb/L3CZp+Kz/BBnsPuHNNdzOpHvAycgM1ANR05
         5goTae01onM6AFc7BbWXuPHmoU3xjvdlhfa/hAN6fqrw+71PAZL5fp8D46JOtLTzglR1
         qOEuySQg9tuLo7591kGGkgQYB0yt5w9gmY8ZPIgdxPr7ceXXqJlR1U0Y4bmsZgKnJBMe
         IV3w==
X-Gm-Message-State: AOAM530i71cay4uuhNRHYs1QNLyyLNHqZL+n3/r5Pku82NrkAfg2oIkp
        2sycvDk0rMqBedkb4aeycIA=
X-Google-Smtp-Source: ABdhPJwPqQtfR3RPR1j/EY4tcBGhHjRHUM2mRdZkkrlD7B7oguBtTErDs9wKj2QE5FOSnK1gqtkUNw==
X-Received: by 2002:a17:902:8497:b029:103:b23b:f1c3 with SMTP id c23-20020a1709028497b0290103b23bf1c3mr18261487plo.34.1622645229843;
        Wed, 02 Jun 2021 07:47:09 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id m3sm17374359pfh.174.2021.06.02.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:47:09 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, joe@perches.com, hare@suse.de,
        axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        brho@google.com, mcgrof@kernel.org, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, pmladek@suse.com,
        glider@google.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, mingo@kernel.org, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v4 2/3] init/do_mounts.c: create second mount for initramfs
Date:   Wed,  2 Jun 2021 22:46:29 +0800
Message-Id: <20210602144630.161982-3-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210602144630.161982-1-dong.menglong@zte.com.cn>
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
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
 init/do_mounts.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++--
 init/do_mounts.h | 16 ++++++++-
 init/initramfs.c |  8 +++++
 usr/Kconfig      | 10 ++++++
 4 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..5f82db43ac0f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -617,6 +617,91 @@ void __init prepare_namespace(void)
 	init_chroot(".");
 }
 
+static inline __init bool check_tmpfs_enabled(void)
+{
+	return IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
+		(!root_fs_names || strstr(root_fs_names, "tmpfs"));
+}
+
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+static __init bool is_ramfs_enabled(void)
+{
+	return true;
+}
+
+static __init bool is_tmpfs_enabled(void)
+{
+	return check_tmpfs_enabled();
+}
+
+struct fs_rootfs_root {
+	bool (*enabled)(void);
+	char *dev_name;
+	char *fs_name;
+};
+
+static struct fs_rootfs_root rootfs_roots[] __initdata = {
+	{
+		.enabled  = is_tmpfs_enabled,
+		.dev_name = "tmpfs",
+		.fs_name  = "tmpfs",
+	},
+	{
+		.enabled  = is_ramfs_enabled,
+		.dev_name = "ramfs",
+		.fs_name  = "ramfs"
+	}
+};
+
+/*
+ * Give systems running from the initramfs and making use of pivot_root a
+ * proper mount so it can be umounted during pivot_root.
+ */
+int __init prepare_mount_rootfs(void)
+{
+	struct fs_rootfs_root *root = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rootfs_roots); i++) {
+		if (rootfs_roots[i].enabled()) {
+			root = &rootfs_roots[i];
+			break;
+		}
+	}
+
+	if (unlikely(!root))
+		return -EFAULT;
+
+	return do_mount_root(root->dev_name,
+			     root->fs_name,
+			     root_mountflags & ~MS_RDONLY,
+			     root_mount_data);
+}
+
+/*
+ * Change root to the new rootfs that mounted in prepare_mount_rootfs()
+ * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
+ * Otherwise, umount the new rootfs.
+ */
+void __init finish_mount_rootfs(bool success)
+{
+	if (!success)
+		goto on_fail;
+
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (!ramdisk_exec_exist())
+		goto on_fail;
+
+	init_chroot(".");
+	return;
+
+on_fail:
+	init_chdir("/");
+	init_umount(".", 0);
+}
+#endif
+
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
 {
@@ -634,7 +719,5 @@ struct file_system_type rootfs_fs_type = {
 
 void __init init_rootfs(void)
 {
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
+	is_tmpfs = check_tmpfs_enabled();
 }
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..6a878c09a801 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,9 +10,23 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
+extern int root_mountflags;
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
-extern int root_mountflags;
+bool  ramdisk_exec_exist(void);
+
+#ifdef CONFIG_INITRAMFS_MOUNT
+
+int   prepare_mount_rootfs(void);
+void  finish_mount_rootfs(bool success);
+
+#else
+
+static inline int   prepare_mount_rootfs(void) { return 0; }
+static inline void  finish_mount_rootfs(bool success) { }
+
+#endif
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..59c8e54bebad 100644
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
@@ -682,15 +684,21 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	else
 		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	if (prepare_mount_rootfs())
+		panic("Failed to mount rootfs");
+
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
+		finish_mount_rootfs(false);
 #ifdef CONFIG_BLK_DEV_RAM
 		populate_initrd_image(err);
 #else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
+		goto done;
 	}
 
+	finish_mount_rootfs(true);
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
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

