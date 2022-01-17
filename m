Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9134909AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiAQNoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiAQNo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:44:29 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDD0C061574;
        Mon, 17 Jan 2022 05:44:29 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y10so19216745qtw.1;
        Mon, 17 Jan 2022 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qsy9iO5QNpvhH9vyZT3hQoa7mdrCF0c+4JFfeVVUuQM=;
        b=IZyW5y1GdwVl4px0QbEDSD5Och9801oxJf/NX9GACC+pgxTDmHVKIslQUql6bJ5S6x
         /HSbFuxd3e+t6P5ZIBj2PQ89oXpA7aj/r6swB7g3IUlOgWPgem7G6Cq3q97sEsWymI42
         4aP4JUNgPO1UepFxMEXuang0gitNPKSqOMAugWbCAyR5BTqxEs7dXy4e4WSAdg0CW2+Z
         becCt/znlJBnsH7Nx3IL0CoEe4M3YW9s3Qolk76ke5kGj8bue2KLiFCVI0nMuRh0q1nq
         HX5VnDg3Vejeeu9oyEIfT95UkOtVCHTO/V8gKE5N3IwyWZ2d6WKZj98b0/yHZRjDaqap
         +Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qsy9iO5QNpvhH9vyZT3hQoa7mdrCF0c+4JFfeVVUuQM=;
        b=jbHvsflZcpCqhE/qYThi0rQXKdO9NNYe944jecfVkVt+WtcTQsXKDyfFRoRaOKi3mr
         9+siUdhZAWoibPrLNMu3pKwzJBU5AkWLcqHLggH7Y7gx+qRjOMTX6wyQ0suagbiUraqD
         m8h2sAAVhdUmKoL6omjVAAWCkoIkeTIAH6hiSgfMDH5M+n8XTV3hX3tXvQKv5uhjyJ9T
         Lg7MKpq6nyI5oDbKHMEtHWnaA24YYfm3zPIUn9MEq3V2bGG9XEeIjyMgwHv7xvvyZWZG
         J7dh3jD9TSA4TGrIcDXkMKyrt2hh9kF0timykSG6l/7OAF5vOE5db0Sqmc6YxvpxiKmx
         QQzQ==
X-Gm-Message-State: AOAM531Q81xa2Bmn7OHb7qYp25CvQ3CtMXxDEYSRlSpcIRAhIfiJcOKO
        cX+nzhRJBmSEf0rRXMIfoEA=
X-Google-Smtp-Source: ABdhPJxQsWdKsWj/NjJjvb51fnkcnvopF7I1gnuJ1RN6LMTotZtbNsNDsA6oh8XfU7+xCe/MqRhwGA==
X-Received: by 2002:a05:622a:512:: with SMTP id l18mr17146823qtx.120.1642427068243;
        Mon, 17 Jan 2022 05:44:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s1sm9124073qtw.25.2022.01.17.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 05:44:27 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mhiramat@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, elver@google.com, masahiroy@kernel.org,
        zhang.yunkai@zte.com.cn, axboe@kernel.dk, vgoyal@redhat.com,
        jack@suse.cz, leon@kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, linux@rasmusvillemoes.dk,
        palmerdabbelt@google.com, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, rostedt@goodmis.org,
        ahalaney@redhat.com, valentin.schneider@arm.com,
        peterz@infradead.org, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dong.menglong@zte.com.cn
Subject: [PATCH v7 2/2] init/do_mounts.c: create second mount for initramfs
Date:   Mon, 17 Jan 2022 13:43:52 +0000
Message-Id: <20220117134352.866706-3-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
References: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

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

This patch is from:
[init/initramfs.c: make initramfs support pivot_root]
https://lore.kernel.org/all/20210605034447.92917-3-dong.menglong@zte.com.cn/
I fix some console bugs.

Reported-by: dong.menglong@zte.com.cn
Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 init/do_mounts.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h | 17 ++++++++++++++++-
 init/initramfs.c | 12 +++++++++++-
 usr/Kconfig      | 10 ++++++++++
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 762b534978d9..8a72c1fe17c8 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -650,6 +650,50 @@ void __init prepare_namespace(void)
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
+	init_mkdir("/root", 0700);
+	return do_mount_root(rootfs, rootfs,
+				root_mountflags & ~MS_RDONLY,
+				root_mount_data);
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
@@ -657,6 +701,7 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 
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
index 2f3d96dc3db6..881fb8ea4352 100644
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
@@ -671,7 +673,12 @@ static void __init populate_initrd_image(char *err)
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
 
@@ -685,11 +692,14 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 
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
index 8bbcf699fe3b..af2aeeef8635 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_MOUNT
+       bool "Create second mount to make pivot_root() supported"
+       default y
+       help
+         Before unpacking cpio, create a second mount and make it become
+         the root filesystem. Therefore, initramfs will be supported by
+         pivot_root().
+
+         If container platforms is used with initramfs, say Y.
+
 config RD_GZIP
 	bool "Support initial ramdisk/ramfs compressed using gzip"
 	default y
-- 
2.25.1

