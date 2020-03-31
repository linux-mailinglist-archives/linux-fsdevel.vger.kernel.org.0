Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF41996B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgCaMkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 08:40:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39229 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgCaMkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:40:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so25733578wrt.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrYU4pdXtjoqLSCi1+BzGz0FwfrcT1JORFV6pfBLh/Q=;
        b=ury2i0drH9nc44Mz1FbJHJodHBl7BjEBB+TfLm2H0shisGyjSIgoLGejyEwJte99RI
         mE+AoFJg7DBjBoDsecrIrnzm0bYqbbaCoSEAPt2QLYdt4fJ5HJvuQDf05IhmRoiyi550
         l8S/9wzk5DVeVbqFqnpF7gbL3ebyjMuPG6MHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrYU4pdXtjoqLSCi1+BzGz0FwfrcT1JORFV6pfBLh/Q=;
        b=QUxXTos03/uM2ZeuFkSNFX2DAUoWjIw5z6Q+xIVSKeVtqJoctQYF42TLnByaZC2TBJ
         jzKP8XVXrNyll02QZwoeNFQZAuKdrLgeGi4WxC3GQM47Qmm2Jb59cW3VGC4hRMLXYMKx
         ehhK6XGRWjbCYg2//kgHGN9bHOmqZOoMTSxvahvsuZnNA3lHVK3GadDVst4B+LVj7Id7
         RICZPt7Dz6/kdD4ALMaNS5IWcX7AsiKTAQOMXr7Toz/CUB9ogzxStOe5pOQyNyCt+mkz
         U4l6IJBTt6uGrlvhFMhhP/Zn5Z+S7Moeso+M7RHrWWrIBnhymK/tEd7LxsZkpdLe6oJW
         mkRg==
X-Gm-Message-State: ANhLgQ1Iv0HvN/k4rBH60AbctWb6/gpCcetbhxoGMA2djxORTnVkixZ9
        o6R24ttCBWS2g7bDI6/ETPcmPw==
X-Google-Smtp-Source: ADFU+vu8AJDlsBQPYOHqtbggoLh4K9dPV196dmXMNIJ1cefjnuTxTqIgu8wxKorMC2XSWfQm7c5ITQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr19484696wrm.279.1585658434518;
        Tue, 31 Mar 2020 05:40:34 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id w66sm3819159wma.38.2020.03.31.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:40:33 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 1/1] mnt: add support for non-rootfs initramfs
Date:   Tue, 31 Mar 2020 13:40:17 +0100
Message-Id: <20200331124017.2252-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331124017.2252-1-ignat@cloudflare.com>
References: <20200331124017.2252-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The main need for this is to support container runtimes on stateless Linux
system (pivot_root system call from initramfs).

Normally, the task of initramfs is to mount and switch to a "real" root
filesystem. However, on stateless systems (booting over the network) it is just
convenient to have your "real" filesystem as initramfs from the start.

This, however, breaks different container runtimes, because they usually use
pivot_root system call after creating their mount namespace. But pivot_root does
not work from initramfs, because initramfs runs form rootfs, which is the root
of the mount tree and can't be unmounted.

One workaround is to do:

  mount --bind / /

However, that defeats one of the purposes of using pivot_root in the cloned
containers: get rid of host root filesystem, should the code somehow escapes the
chroot.

There is a way to solve this problem from userspace, but it is much more
cumbersome:
  * either have to create a multilayered archive for initramfs, where the outer
    layer creates a tmpfs filesystem and unpacks the inner layer, switches root
    and does not forget to properly cleanup the old rootfs
  * or we need to use keepinitrd kernel cmdline option, unpack initramfs to
    rootfs, run a script to create our target tmpfs root, unpack the same
    initramfs there, switch root to it and again properly cleanup the old root,
    thus unpacking the same archive twice and also wasting memory, because
    the kernel stores compressed initramfs image indefinitely.

With this change we can ask the kernel (by specifying nonroot_initramfs kernel
cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
before the initramfs handling code, so initramfs gets unpacked directly into
the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

This also bring the behaviour in line with the older style initrd, where the
initrd is located on some leaf filesystem in the mount tree and rootfs remaining
empty.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++-
 fs/namespace.c                                | 47 +++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..720fd3ee9f8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3192,11 +3192,18 @@
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
index 85b5f7bea82e..a1ec862e8146 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
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
+	err = ksys_mkdir("/root", 0700);
+	if (err < 0)
+		goto out;
+
+	err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chdir("/root");
+	if (err)
+		goto out;
+
+	err = do_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chroot(".");
+	if (!err)
+		return;
+out:
+	printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
+}
+#endif /* IS_ENABLED(CONFIG_TMPFS) */
+
 void __init mnt_init(void)
 {
 	int err;
@@ -3734,6 +3777,10 @@ void __init mnt_init(void)
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
2.20.1

