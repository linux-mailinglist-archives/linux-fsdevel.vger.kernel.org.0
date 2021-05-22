Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6369C38D5A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhEVLdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhEVLdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 07:33:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDBC061574;
        Sat, 22 May 2021 04:32:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v12so12291229plo.10;
        Sat, 22 May 2021 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb+7hC9sQx9m7PSUx2yiOZQuWEVGSNF+NglwnwABS1o=;
        b=Mf/WEp7u2q4v+65iISSZF+Lht/7KB1U7v9g9+xiqpTB1EUfzPsf/8jaMMAE88m+hUx
         8cpNy3aQeS6rSv8RhrnPdyTnbYKb8VP0qkNcJxMk2KmUBRcUdLZQX/1L5n+USAj8nmLu
         uA2LzKaRJD8rfCEG4BdW61haXkeXNpRad66/WrHEWAUfoafghTTMdkDrhfiedFSqR6fi
         sVead/hCp+swuXew3PiRl7zhayrk7Qo1qd3A3HJaYTU6ldvQv3OaIhJjYSIgvE9Qre5J
         kAWePvMveaSRfKX06JiR/VcmvIsLtKONpBczWeuPc9OZGhGpHyHiMHYSpafYs9DcTa0Z
         gOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb+7hC9sQx9m7PSUx2yiOZQuWEVGSNF+NglwnwABS1o=;
        b=nf0s+JFH4uggDcDqY6LllpMWxAcceIctoNHZ6xMPTVCkyvT7P1OEM/PWOcWdRMr9W3
         f4Vgb+AonB5bWATYDZFTlI2t6kCZMMmioVxTEB1BYWPzMwsU6iaDBnTiPxsnBD23oDnE
         x/t0zlUzpbJg1MZbbgGz1wPP9XQWSylmZvXXc56yNi7+RWIjLi2lLzkXQYKYQVVoEL5b
         jUn34zfO6i635OZGWfKbN6j03hwgNXpjFuDkF/YSfkF3KD2eR0sY9UI7yvQZPubJJxEk
         ynVVI0vXPwR+17sjoDMrRyCHhlB0d4QjFu9PuADSmaR0HTr7aAaMVbMjotkt9HDXgUZj
         0bfw==
X-Gm-Message-State: AOAM531ffqipRZKVirbFjKLKpkc/Ox+r2Xof8Q6sG5S5puzelzdxIR3o
        N06kB8/cEmMcbMA307U/htc=
X-Google-Smtp-Source: ABdhPJwA6c0bbQ0RhXEuFjWzLr78r+E4chWPE9yItZ4+ybKD8FhYH2keLWeDXB0Qa2oEXoCOZNpjSA==
X-Received: by 2002:a17:90a:4d4f:: with SMTP id l15mr13021917pjh.78.1621683146771;
        Sat, 22 May 2021 04:32:26 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id x22sm10494983pjp.42.2021.05.22.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:32:26 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
Date:   Sat, 22 May 2021 19:31:54 +0800
Message-Id: <20210522113155.244796-3-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522113155.244796-1-dong.menglong@zte.com.cn>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

During the kernel initialization, the root of the mount tree is
created with file system type of ramfs or tmpfs.

While using initramfs as the root file system, cpio file is unpacked
into the rootfs. Thus, this rootfs is exactly what users see in user
space, and some problems arose: this rootfs has no parent mount,
which make it can't be umounted or pivot_root.

'pivot_root' is used to change the rootfs and clean the old mounts,
and it is essential for some users, such as docker. Docker use
'pivot_root' to change the root fs of a process if the current root
fs is a block device of initrd. However, when it comes to initramfs,
things is different: docker has to use 'chroot()' to change the root
fs, as 'pivot_root()' is not supported in initramfs.

The usage of 'chroot()' to create root fs for a container introduced
a lot problems.

First, 'chroot()' can't clean the old mountpoints which inherited
from the host. It means that the mountpoints in host will have a
duplicate in every container. Users may remove a USB after it
is umounted successfully in the host. However, the USB may still
be mounted in containers, although it can't be seen by the 'mount'
commond. This means the USB is not released yet, and data may not
write back. Therefore, data lose arise.

Second, net-namespace leak is another problem. The net-namespace
of containers will be mounted in /var/run/docker/netns/ in host
by dockerd. It means that the net-namespace of a container will
be mounted in containers which are created after it. Things
become worse now, as the net-namespace can't be remove after
the destroy of that container, as it is still mounted in other
containers. If users want to recreate that container, he will
fail if a certain mac address is to be binded with the container,
as it is not release yet.

In this patch, a second mount, which is called 'user root', is
created before 'cpio' unpacking. The file system of 'user root'
is exactly the same as rootfs, and both ramfs and tmpfs are
supported. Then, the 'cpio' is unpacked into the 'user root'.
Now, the rootfs has a parent mount, and pivot_root() will be
supported for initramfs.

What's more, after this patch, 'rootflags' in boot cmd is supported
by initramfs. Therefore, users can set the size of tmpfs with
'rootflags=size=1024M'.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 init/do_mounts.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.h |  7 ++++-
 init/initramfs.c | 10 +++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..943cb58846fb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -617,6 +617,78 @@ void __init prepare_namespace(void)
 	init_chroot(".");
 }
 
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
+	{.fs_name = "tmpfs", .enabled = is_tmpfs_enabled },
+#endif
+	{.fs_name = "ramfs", .enabled = is_ramfs_enabled }
+};
+static struct fs_user_root * __initdata user_root;
+
+/* Mount the user_root on '/'. */
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
+	if (!succeed)
+		goto on_failed;
+
+	if (!ramdisk_exec_exist(false))
+		goto on_failed;
+
+	init_mount(".", "/", NULL, MS_MOVE, NULL);
+	init_chroot(".");
+	return;
+
+on_failed:
+	init_chdir("/");
+	init_umount("/..", 0);
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
+
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
 {
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 7a29ac3e427b..92c004bdd320 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,9 +10,14 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
+extern int root_mountflags;
+
 void  mount_block_root(char *name, int flags);
 void  mount_root(void);
-extern int root_mountflags;
+int   mount_user_root(void);
+void  end_mount_user_root(bool succeed);
+void  init_user_rootfs(void);
+bool  ramdisk_exec_exist(bool abs);
 
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
-- 
2.31.1

