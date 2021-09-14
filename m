Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96640B5B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhINRMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhINRMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:12:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF7C061767
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:13 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a10so64783qka.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=determinate-systems.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGPO8aXiMyFr9xGkKJ7nDzZ1O2MpyXvL26J5zpRPMr8=;
        b=hk4NtdW9eKImQGzCH/9GmXuOzx+C9Vbqh+6NpITtiQgE0rg+KuwBU6pvS7CsyvlO1n
         rYOF0vC0gap2u2GGfxdtSI44hXnL0jEdmLj270t27YYNoiXI/pR3QOGMYXGJj38FZGsz
         Tt77CediPQ8CZbV5iIt9qNIiHhRBkNrVSm3zviQZBmAym/DhBuxaZa6/lt+VHCzOEkFx
         S/uGfYPWEZnbQjeNK11Og6N2tduaMP+V8BSQc9v84rjSoGOtFBl9/3AtvdJFz6RLPGrG
         uTBn14CgJuTgc6CVTB/rC0labhlt0jykpak/U2gQfdKftYDBVcQUiJT7unBkMprJwrns
         QIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGPO8aXiMyFr9xGkKJ7nDzZ1O2MpyXvL26J5zpRPMr8=;
        b=QjfkwAbf7VTjX0q4kKvoM3QGHhgMzun5QxEnqrdx0YWDToT5NkCA/nFQ0u1u0tOzDe
         fc1txyJY0a+9NouIjP2G8ucs2FdAp1dQ7zl7xlOlDjouSMSuKxN3vD2hL0XprHo50mKz
         X+lvt06Foom2jDIAQQn14zRyvy/nbN4XF6eSflLYbYyGuz7l7JKAz474hwvuQ5vqS5v6
         dpSxRHRqipnMF3N2xkP7xyTpCGILoJ3PiNx/j4O8UW5p3V20EpzQckY6yABqgk22Ko9U
         OBADMhxQXcLo8ezncEZxfp7cq/fWOrX916zeHcu78P/3JlSLYVwAkDM3IBlNp5pSTUQh
         R5Qw==
X-Gm-Message-State: AOAM53342+OMg3ZGfGKa+kpRHp09O5oTsFveqTtmjno7ar9j+dRq543h
        UYPtq/4bEEGwb3ymSiln5c986g==
X-Google-Smtp-Source: ABdhPJzIYBO0rohQg/SmOuz6BclTFzizLOyXSqI20jEc28Hr64Lesz2vrjXf8V05mhhxHDrcsZEyiw==
X-Received: by 2002:ae9:e012:: with SMTP id m18mr6032913qkk.396.1631639472174;
        Tue, 14 Sep 2021 10:11:12 -0700 (PDT)
Received: from localhost (cpe-67-246-1-194.nycap.res.rr.com. [67.246.1.194])
        by smtp.gmail.com with ESMTPSA id r23sm6410998qtp.60.2021.09.14.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:11:11 -0700 (PDT)
From:   graham@determinate.systems
To:     graham@determinate.systems, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Ignat Korchagin <ignat@cloudflare.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] mnt: add support for non-rootfs initramfs
Date:   Tue, 14 Sep 2021 13:09:34 -0400
Message-Id: <20210914170933.1922584-3-graham@determinate.systems>
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

