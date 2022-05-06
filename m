Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2051D3D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390313AbiEFJBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiEFJB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 05:01:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DC606FC;
        Fri,  6 May 2022 01:57:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e24so6485129pjt.2;
        Fri, 06 May 2022 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhX1HHg7iybpBYiY4PNlgS/Zr12x/UKzj8k0UmQdLYg=;
        b=iUfn1KPXWBUniBwjF5mPM61y+A8l8QAHF0zATqoruK+Td/PnG4PULQL1JyXlTWzUYp
         85CeR21zEv0I7g7B8auKZyKiFNoYbeg8zxv2Vq2KM8kbiR6EbE0TVsSY/iytw/qwgjra
         jhLykjH7bZGLOb+eJHLicc/sRK0tURbo/ENQ0f1QlrnugZyD/UXUUa5/MLi9V3ppofDq
         S0dq7gFE1rxxpOrvlG6NtNZrQ3qwdoYgjGfOcQylgTtyZ60chP0N0HVxrKL9vhdIe4hw
         KIWVklX9IE2Q1W0BY2eopsy7may3GUf3Yau8WUY8oUw5TQ1Z0dBJOKhjqvpdNJAv/c3F
         y8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhX1HHg7iybpBYiY4PNlgS/Zr12x/UKzj8k0UmQdLYg=;
        b=RSmJXJYjuZK+eJeNmp/TZEQy9dBGu9dL47Ln6PVGT4ykKhwjoc7S9A02UDntczXpbV
         1sKyqqh1CcVrEWTc9rULYY+XhQD7TDNos97MeLz51Z7ksUBTQRHAdpEzs/PY8bZKrER9
         8MAgyPlNXBQJcohOWfqXoeb7xgYqquwVfzWJ2zSIt7VKDXinM0Pk0OAcDDqU+YUPTDqP
         0Zf0VL1HoaB79tb0gzCNvAGCz3hhczUThxChVr4MUlbtxnjxOWvt+VBpRvRN9b2BNNi7
         yo6fBlP8Q5eBfr5+m+oUj9CzlleURzh1UK3Sxm8ce6yAT7J5u5pnN8IFh9Ej2LOp5Ojb
         Xxyg==
X-Gm-Message-State: AOAM531EsEl9A6sNXYkFGTZr/YZTPAz07V0rqHzfzKNe8dcc8aQZ9Na/
        AGKwz6NJUUCp3UNWtG91b18=
X-Google-Smtp-Source: ABdhPJysNc0c2xr76NgKZ5enlmDuGotautP+aamf8YsN0lw3Zt+/o7e7CQW4Id3iX5fqmkckSY7VlQ==
X-Received: by 2002:a17:902:6b01:b0:158:be18:5be7 with SMTP id o1-20020a1709026b0100b00158be185be7mr2489265plk.112.1651827466230;
        Fri, 06 May 2022 01:57:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id gg7-20020a17090b0a0700b001d97f17f9b5sm6793001pjb.35.2022.05.06.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:57:45 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     elver@google.com
Cc:     viro@zeniv.linux.org.uk, zhang.yunkai@zte.com.cn,
        nathan@kernel.org, keescook@chromium.org, samitolvanen@google.com,
        rdunlap@infradead.org, axboe@kernel.dk, vgoyal@redhat.com,
        kch@nvidia.com, martin.petersen@oracle.com, leon@kernel.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        linux@rasmusvillemoes.dk, sfr@canb.auug.org.au,
        rostedt@goodmis.org, mhiramat@kernel.org, vbabka@suse.cz,
        ahalaney@redhat.com, mark-pk.tsai@mediatek.com,
        peterz@infradead.org, valentin.schneider@arm.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] initramfs: create a mount point for rootfs,so docker on rootfs can use pivot_root
Date:   Fri,  6 May 2022 08:57:36 +0000
Message-Id: <20220506085736.489467-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

When using container platforms such as Docker, it has two ways to change
the root directory to the specified path, pivot_root or chroot.

Docker uses pivot_root by default, which can be handled very cleanly.
But it only support for a disk or block device, not for rootfs. Because
the specified directory does not have a parent mount.

So if we want use docker on rootfs, we need specify DOCKER_RAMDISK=yes.
Then docker change the root directory will use chroot instead of
pivot_root.

There are at least two reasons, we still have to use pivot_root for
rootfs. Chroot can only simply change the root directory, which will
lead to resource leakage. An example is that a USB device connected
prior to the creation of a containers on the host gets disconnected
after a container is created. if the USB device was mounted on
containers, but already removed and umounted on the host, the mount
point will not go away until all containers unmount the USB device.
Containers will have mount point even if they haven't done a mount
action.

Another reason for Docker to use pivot_root is that upon initialization
the net-namspace is mounted under /var/run/docker/netns/ on the host by
dockerd. Without pivot_root Docker must either wait to create the
network namespace prior to the creation of containers or simply deal
with leaking this to each container.

This patch creates a parent mount point for rootfs to support
pivot_root. The main steps are:
mkdir /root
cd /root
mount tmpfs to /root
decompress initramfs and initrd to tmpfs
mount . /
ksys_chroot .

In addition, because there is an additional layer of mounting, it is
necessary to slightly modify the way init_eaccess searches for files
during the kernel initialization.

While mounting tmpfs to /root, 'rootflags' is passed, and it means that
we can set options for the mount of rootfs in boot cmd now. For example,
the size of tmpfs can be set with 'rootflags=size=1024M'.

Tested-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 fs/init.c            | 10 ++++++++--
 include/linux/init.h |  1 +
 init/do_mounts.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h     | 14 ++++++++++++++
 init/initramfs.c     | 16 ++++++++++++++--
 init/main.c          |  6 +++++-
 usr/Kconfig          | 10 ++++++++++
 7 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..4974f19bf645 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -112,14 +112,20 @@ int __init init_chmod(const char *filename, umode_t mode)
 
 int __init init_eaccess(const char *filename)
 {
-	struct path path;
+	struct path path, root;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path("/", LOOKUP_DOWN, &root);
 	if (error)
 		return error;
+	error = vfs_path_lookup(root.dentry, root.mnt, filename,
+			LOOKUP_FOLLOW, &path);
+	if (error)
+		goto on_err;
 	error = path_permission(&path, MAY_ACCESS);
 	path_put(&path);
+on_err:
+	path_put(&root);
 	return error;
 }
 
diff --git a/include/linux/init.h b/include/linux/init.h
index baf0b29a7010..6eddd3730ce8 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -149,6 +149,7 @@ extern unsigned int reset_devices;
 void setup_arch(char **);
 void prepare_namespace(void);
 void __init init_rootfs(void);
+bool ramdisk_exec_exist(void);
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7058e14ad5f7..c28a5792ddc3 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -649,6 +649,50 @@ void __init prepare_namespace(void)
 }
 
 static bool is_tmpfs;
+#ifdef CONFIG_ROOTFS_MOUNT
+
+/*
+ * Give systems running from the rootfs and making use of pivot_root a
+ * proper mount so it can be umounted during pivot_root.
+ */
+int __init prepare_mount_rootfs(void)
+{
+	char *rootfs = "ramfs";
+
+	if (is_tmpfs)
+		rootfs = "tmpfs";
+
+	init_mkdir("/root", 0700);
+	return do_mount_root(rootfs, rootfs,
+			root_mountflags & ~MS_RDONLY,
+			root_mount_data);
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
@@ -656,6 +700,7 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 
 	return ramfs_init_fs_context(fc);
 }
+#endif
 
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..6bc954b84015 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -14,6 +14,20 @@ void  mount_block_root(char *name, int flags);
 void  mount_root(void);
 extern int root_mountflags;
 
+#ifdef CONFIG_ROOTFS_MOUNT
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
+
 static inline __init int create_dev(char *name, dev_t dev)
 {
 	init_unlink(name);
diff --git a/init/initramfs.c b/init/initramfs.c
index 2f3d96dc3db6..7b68c5aeff7d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -17,6 +17,8 @@
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
 
+#include "do_mounts.h"
+
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
 		loff_t *pos)
 {
@@ -671,12 +673,19 @@ static void __init populate_initrd_image(char *err)
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
-	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
+	char *err;
+
+	if (prepare_mount_rootfs())
+		panic("Failed to mount rootfs\n");
+
+	err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
-	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
+	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
+		finish_mount_rootfs();
 		goto done;
+	}
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
@@ -685,11 +694,14 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 
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
diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..2e4875834f97 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1580,6 +1580,10 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(void)
+{
+	return init_eaccess(ramdisk_execute_command) == 0;
+}
 static noinline void __init kernel_init_freeable(void)
 {
 	/* Now the scheduler is fully set up and can do blocking allocations */
@@ -1621,7 +1625,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist()) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
diff --git a/usr/Kconfig b/usr/Kconfig
index 8bbcf699fe3b..03dbb22e95f9 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config ROOTFS_MOUNT
+	bool "Create mount point for rootfs to make pivot_root() supported"
+	default n
+	help
+	  Before unpacking cpio, create a mount point and make it become
+	  the root filesystem. Therefore, rootfs will be supported by
+	  pivot_root().
+
+	  If container platforms is used with rootfs, say Y.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	default y
-- 
2.25.1

