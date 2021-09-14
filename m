Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFAD40B5B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhINRMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhINRM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:12:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5FC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b64so199485qkg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=determinate-systems.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGPO8aXiMyFr9xGkKJ7nDzZ1O2MpyXvL26J5zpRPMr8=;
        b=z1zp2X5RzqK9p0okCWs5cE4c1vkO2tKU/KmTq2i36qs9/+PZvXBLLRsVJoI+AY13+d
         kP2vMxN9Sq9xwXISzm6P0PXDrPzjl7LM/nxNIoxX38MxTBkZc4xg+KvcgXqQRToMme40
         6y1rHUVj7VlPsx3FKEoGJCf9Bz/coUnrY5qQBeDTfJK0YOQyCaWW0Bfwmg1ZOp+3GDdL
         ei/zac3VgZrbtbUKhP2VrfOmaRm8X0fnKyO+jVUuUHItggpbh3b2fcK1d0W8+hfsLv9R
         mR89ikSqCc1u0sSfZOC6vxYyXl6pMcsXYOG6zAkGg+h7k9EY1PFq3TUZp5vl38PU/Y73
         mxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGPO8aXiMyFr9xGkKJ7nDzZ1O2MpyXvL26J5zpRPMr8=;
        b=1a9BUjRQc+1Od7699KaTwU9DEK9d0o6VcM/2ScTp51han3L2KNu67q6b2GOixjb7SD
         0cDxki391L0hzbTlS2Tugu32IJQ+XPIp10og2MQ6yb6zFMKwI/+uYrFawwzD97GgeF+b
         qnsEt83dz/hyCgP9Qj8tRkWA3R3sv1RjeqJH0/uaG4sngkpefTcORKcUiU/VdaW9XAMr
         59CcZhEUDQHuf8jian46gwqoqLRFqLQ7L3msKTYeT1sFGwSAP+mnAV6ZHp9m0Zcxm6kp
         Fr1F7zYq+BZjC/+tbKDdwY3LAPoWCNXRX18VJ+2GtdLfD1x/zA/YBcZzuDYirQTfX3Cd
         edLA==
X-Gm-Message-State: AOAM531UX01WS6a7SnnhXcfg+eG+JMiCdQM9DZaeLPe7o5Af0leT0tXS
        PyRqlogIsPZ2CNTXvbDgU3DxEg==
X-Google-Smtp-Source: ABdhPJyX09LuIknFVVfLI/6zpiGY3O9KR+Z63SpGXMrDbqFYPBmkeqUqm2ABF1+dPeyaY28mrII7qA==
X-Received: by 2002:a37:741:: with SMTP id 62mr6011709qkh.490.1631639469527;
        Tue, 14 Sep 2021 10:11:09 -0700 (PDT)
Received: from localhost (cpe-67-246-1-194.nycap.res.rr.com. [67.246.1.194])
        by smtp.gmail.com with ESMTPSA id c2sm7951595qkd.57.2021.09.14.10.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:11:09 -0700 (PDT)
From:   graham@determinate.systems
To:     graham@determinate.systems, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Ignat Korchagin <ignat@cloudflare.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] mnt: add support for non-rootfs initramfs
Date:   Tue, 14 Sep 2021 13:09:33 -0400
Message-Id: <20210914170933.1922584-2-graham@determinate.systems>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210914170933.1922584-1-graham@determinate.systems>
References: <20210914170933.1922584-1-graham@determinate.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ignat Korchagin <ignat@cloudflare.com>

The main need for this is to support container runtimes on stateless Linux
system (pivot_root system call from initramfs).

Normally, the task of initramfs is to mount and switch to a "real" root
filesystem. However, on stateless systems (booting over the network) it is
just convenient to have your "real" filesystem as initramfs from the start.

This, however, breaks different container runtimes, because they usually
use pivot_root system call after creating their mount namespace. But
pivot_root does not work from initramfs, because initramfs runs from
rootfs, which is the root of the mount tree and can't be unmounted.

One workaround is to do:

  mount --bind / /

However, that defeats one of the purposes of using pivot_root in the
cloned containers: get rid of host root filesystem, should the code somehow
escapes the chroot.

There is a way to solve this problem from userspace, but it is much more
cumbersome:
  * either have to create a multilayered archive for initramfs, where the
    outer layer creates a tmpfs filesystem and unpacks the inner layer,
    switches root and does not forget to properly cleanup the old rootfs
  * or we need to use keepinitrd kernel cmdline option, unpack initramfs
    to rootfs, run a script to create our target tmpfs root, unpack the
    same initramfs there, switch root to it and again properly cleanup
    the old root, thus unpacking the same archive twice and also wasting
    memory, because the kernel stores compressed initramfs image
    indefinitely.

With this change we can ask the kernel (by specifying nonroot_initramfs
kernel cmdline option) to create a "leaf" tmpfs mount for us and switch
root to it before the initramfs handling code, so initramfs gets unpacked
directly into the "leaf" tmpfs with rootfs being empty and no need to
clean up anything.

This also bring the behaviour in line with the older style initrd, where
the initrd is located on some leaf filesystem in the mount tree and rootfs
remaining empty.

Co-developed-by: Graham Christensen <graham@determinate.systems>
Signed-off-by: Graham Christensen <graham@determinate.systems>
Tested-by: Graham Christensen <graham@determinate.systems>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++-
 fs/namespace.c                                | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..bfbc904ad751 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3517,11 +3517,18 @@
 	nomfgpt		[X86-32] Disable Multi-Function General Purpose
 			Timer usage (for AMD Geode machines).
 
+	nomodule        Disable module load
+
 	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
-	nomodule	Disable module load
+	nonroot_initramfs
+			[KNL] Create an additional tmpfs filesystem under rootfs
+			and unpack initramfs there instead of the rootfs itself.
+			This is useful for stateless systems, which run directly
+			from initramfs, create mount namespaces and use
+			"pivot_root" system call.
 
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
diff --git a/fs/namespace.c b/fs/namespace.c
index 659a8f39c61a..c639ea9feb66 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/idr.h>
 #include <linux/init.h>		/* init_rootfs */
+#include <linux/init_syscalls.h> /* init_chdir, init_chroot, init_mkdir */
 #include <linux/fs_struct.h>	/* get_fs_root et.al. */
 #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
 #include <linux/file.h>
@@ -4302,6 +4303,49 @@ static void __init init_mount_tree(void)
 	set_fs_root(current->fs, &root);
 }
 
+#if IS_ENABLED(CONFIG_TMPFS)
+static int __initdata nonroot_initramfs;
+
+static int __init nonroot_initramfs_param(char *str)
+{
+	if (*str)
+		return 0;
+	nonroot_initramfs = 1;
+	return 1;
+}
+__setup("nonroot_initramfs", nonroot_initramfs_param);
+
+static void __init init_nonroot_initramfs(void)
+{
+	int err;
+
+	if (!nonroot_initramfs)
+		return;
+
+	err = init_mkdir("/root", 0700);
+	if (err < 0)
+		goto out;
+
+	err = init_mount("tmpfs", "/root", "tmpfs", 0, NULL);
+	if (err)
+		goto out;
+
+	err = init_chdir("/root");
+	if (err)
+		goto out;
+
+	err = init_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (err)
+		goto out;
+
+	err = init_chroot(".");
+	if (!err)
+		return;
+out:
+	pr_warn("Failed to create a non-root filesystem for initramfs\n");
+}
+#endif /* IS_ENABLED(CONFIG_TMPFS) */
+
 void __init mnt_init(void)
 {
 	int err;
@@ -4335,6 +4379,10 @@ void __init mnt_init(void)
 	shmem_init();
 	init_rootfs();
 	init_mount_tree();
+
+#if IS_ENABLED(CONFIG_TMPFS)
+	init_nonroot_initramfs();
+#endif
 }
 
 void put_mnt_ns(struct mnt_namespace *ns)
-- 
2.32.0

