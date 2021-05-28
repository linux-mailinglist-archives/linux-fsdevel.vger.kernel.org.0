Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0639444F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbhE1OlF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1Ok6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:40:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9C5C061574;
        Fri, 28 May 2021 07:39:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n8so1723598plf.7;
        Fri, 28 May 2021 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJ7U/OKohkc8JHO0oQ9gAirJ7L2O/GLriRaj6yb1ZLY=;
        b=lHCMFuBFz18UEDshV+PrmPr5Ne8Ts0nzlHtRNzKftyE4UsRsNj1Bmf8SSuw/kZItvA
         W7K9oIVmOV7Ugkg0AUCa+uzxyNyCzvFT8deBXC3sqmG4F/GnwQ2WADSq4NQzMPUZCjxO
         GS8ArXufBrLevIJuFrnEMk0p9yxoqw4N6ioDsykIlHaKHizbvHGi5qd40eF7GwMm/C0z
         WHaqkw3UPdeFeG72NWz1bSx0/kdxckxpW9fv7m6IK70iqnbpGZHiFqsuImoRlkt/83gR
         T9loQkp0ZiJmh5ze6cIlVrlBaWzIPeT+XQn/gms+/92I2KM8j3Uireck0BYvEXR3qIgF
         y4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJ7U/OKohkc8JHO0oQ9gAirJ7L2O/GLriRaj6yb1ZLY=;
        b=Ko2W5mO7cZj1H0t43BdEW/PYjMCTS2iaFgANPsMztiCt2drOXSLsHr9piH+pame8te
         6kN1FpLCUmzau4FnthGFK0hz7NaRik0EbiWsEwE1izQzHJZVvE+ECg8mbbt9R0n12IAE
         iCtwUZAT26kLrZyuUoA2YqvPgGZhDxizrRO7InQCel7oc6nWckb9WHceQGT9S4Ok1LL6
         ahzRYymLJEEav3bSjSpetBRkkjemCPqNkuGPPK7CjX8yqfPyVQkuhcQyWwLEkSEBPKLQ
         zpOZTA3Cz4q30e5miasp4NlgIdeZyUEWcMjXJzRwX21YXiVRaJjHTR3QXyXc+o70A07j
         qRZA==
X-Gm-Message-State: AOAM533C3a8eUX8WQGUrhYlu/redN8uaKf/0caJspE0OuR3POXVr5iXV
        YLbA+MNT8ipnlmoPtJEMnlU=
X-Google-Smtp-Source: ABdhPJzvbSnll4D+Nf9gZUTQ3O6VR6cJj+nuwgGDOdVW5ZSyrurzeiiSVCcCwFLNLB/b71VrS5GO8A==
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr4783427pju.51.1622212763524;
        Fri, 28 May 2021 07:39:23 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id f18sm4394378pjh.55.2021.05.28.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:39:22 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mhiramat@kernel.org, mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, jack@suse.cz, hare@suse.de,
        tj@kernel.org, gregkh@linuxfoundation.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: [PATCH v3 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
Date:   Fri, 28 May 2021 22:38:01 +0800
Message-Id: <20210528143802.78635-3-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528143802.78635-1-dong.menglong@zte.com.cn>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
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

In order to support pivot_root on initramfs we introduce a second
"user_root" mount which is created before we do the cpio unpacking.
The filesystem of the "user_root" mount is the same the rootfs.

While mounting the 'user_root', 'rootflags' is passed to it, and it means
that we can set options for the mount of rootfs in boot cmd now.
For example, the size of tmpfs can be set with 'rootflags=size=1024M'.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 init/do_mounts.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h |  18 ++++++++-
 init/initramfs.c |  10 +++++
 usr/Kconfig      |  10 +++++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..2fd168cca480 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -617,6 +617,107 @@ void __init prepare_namespace(void)
 	init_chroot(".");
 }
 
+#ifdef CONFIG_INITRAMFS_USER_ROOT
+#ifdef CONFIG_TMPFS
+static __init bool is_tmpfs_enabled(void)
+{
+	return (!root_fs_names || strstr(root_fs_names, "tmpfs")) &&
+	       !saved_root_name[0];
+}
+#endif
+
+static __init bool is_ramfs_enabled(void)
+{
+	return true;
+}
+
+struct fs_user_root {
+	bool (*enabled)(void);
+	char *dev_name;
+	char *fs_name;
+};
+
+static struct fs_user_root user_roots[] __initdata = {
+#ifdef CONFIG_TMPFS
+	{
+		.enabled  = is_tmpfs_enabled,
+		.dev_name = "tmpfs",
+		.fs_name  = "tmpfs",
+	},
+#endif
+	{
+		.enabled  = is_ramfs_enabled,
+		.dev_name = "ramfs",
+		.fs_name  = "ramfs"
+	}
+};
+static struct fs_user_root * __initdata user_root;
+
+/*
+ * The syscall 'pivot_root' is used to change root and it is able to
+ * clean the old mounts, which make it preferred by container platforms
+ * such as Docker. However, initramfs is not supported by pivot_root,
+ * and 'chroot()' has to be used, which is unable to clean the mounts
+ * that propagate from HOST. These useless mounts make the release of
+ * removable device or network namespace a big problem.
+ *
+ * To make initramfs supported by pivot_root, the mount of the root
+ * filesystem should have a parent, which will make it unmountable. In
+ * this function, the second mount, which is called 'user root', is
+ * created and mounted on '/root', and it will be made the root filesystem
+ * in end_mount_user_root() by init_chroot().
+ *
+ * The 'user root' has a parent mount, which makes it unmountable and
+ * pivot_root work.
+ *
+ * What's more, root_mountflags and root_mount_data are used here, which
+ * makes the 'rootflags' in boot cmd work for 'user root'.
+ */
+int __init mount_user_root(void)
+{
+	return do_mount_root(user_root->dev_name,
+			     user_root->fs_name,
+			     root_mountflags & ~MS_RDONLY,
+			     root_mount_data);
+}
+
+/*
+ * This function is used to chroot to new initramfs root that
+ * we unpacked on success. It will chdir to '/' and umount
+ * the secound mount on failure.
+ */
+void __init end_mount_user_root(bool succeed)
+{
+	init_chdir("/");
+	if (!succeed) {
+		init_umount("/root", 0);
+		return;
+	}
+
+	init_mount("/root", "/", NULL, MS_MOVE, NULL);
+	if (!ramdisk_exec_exist()) {
+		init_umount("/..", 0);
+		return;
+	}
+
+	init_chroot("/..");
+}
+
+void __init init_user_rootfs(void)
+{
+	struct fs_user_root *root;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(user_roots); i++) {
+		root = &user_roots[i];
+		if (root->enabled()) {
+			user_root = root;
+			break;
+		}
+	}
+}
+#endif
+
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
 {
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..3802c7a3ba91 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,9 +10,25 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
+extern int root_mountflags;
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
-extern int root_mountflags;
+bool  ramdisk_exec_exist(void);
+
+#ifdef CONFIG_INITRAMFS_USER_ROOT
+
+int   mount_user_root(void);
+void  end_mount_user_root(bool succeed);
+void  init_user_rootfs(void);
+
+#else
+
+static inline int   mount_user_root(void) { return 0; }
+static inline void  end_mount_user_root(bool succeed) { }
+static inline void  init_user_rootfs(void) { }
+
+#endif
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..ffa78932ae65 100644
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
@@ -682,15 +684,23 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	else
 		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	init_user_rootfs();
+
+	if (mount_user_root())
+		panic("Failed to create user root");
+
 	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
 	if (err) {
+		end_mount_user_root(false);
 #ifdef CONFIG_BLK_DEV_RAM
 		populate_initrd_image(err);
 #else
 		printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 #endif
+		goto done;
 	}
 
+	end_mount_user_root(true);
 done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
diff --git a/usr/Kconfig b/usr/Kconfig
index 8bbcf699fe3b..f9c96de539c3 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -52,6 +52,16 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+config INITRAMFS_USER_ROOT
+	bool "Create 'user root' to make pivot_root supported"
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


