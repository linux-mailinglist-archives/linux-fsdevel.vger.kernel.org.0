Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27917AF01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCETfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 14:35:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCETfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:35:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id j16so8493513wrt.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2020 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38DgGiPjwZSpDF6N7m93SvJVUYapT7VRD+CEpbcc/1g=;
        b=RWxHDXt+4syqnJPIwJ2HB8p/I2BbkFMJ9IUSLJFs2bBxyrKhYsftdIcfkxy8ycJgsG
         J6Iuqm41XaysUCVFVwmyr295oYDY/vFX1MatpGuMVYld7r5GTzn6kiKFU8EWF1hnOC5T
         zRNSuYWUqHZaGQIucodznSpMlpetewcq+pJRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38DgGiPjwZSpDF6N7m93SvJVUYapT7VRD+CEpbcc/1g=;
        b=G61R6HR2PCvv9NpMD4RGCprhEDt2jSDl6dg9eFCbyyrun+x0YeO/fsbKG69T/PMf60
         GuA8CLwlYKCJd1xjUejNhx2fQx08U2Hb9n3DxIAMoF4xMKQtXQAIkfjyJGBSiqPBoOse
         xYm2ScEThz7ih5rtJP2nsLzIjGy8ijnmfuW+Wot1a1+BC1FY/y8zqB9D19boZXIGJYVo
         WY7qTygVGrX5kLLsJ1i2JqzXDYafBO7ykTi8K2EsN6tPA6Cq5ro2q37VRkVEj7AcHfnp
         +SSz6ffmJOLqbEnOcCNkJ/csv9IXgR1O1n8rjmmgeEqDJPejMjC42pIZ/5ZAFf97ARhy
         sERw==
X-Gm-Message-State: ANhLgQ19IXKP3JITJ91dvhAkDLsvksHrCLob58SeH3obexNsrtN3pSkk
        T8AxtYX1Zvfya7q2FpCjpur0LA==
X-Google-Smtp-Source: ADFU+vu0oJrA1+m4P9vna1RTuRkGjRwiIL6Hy+SKK9W1YqIlpXJU1vl6yJ5AVNo88S4yAen8RpmeqQ==
X-Received: by 2002:a5d:4f03:: with SMTP id c3mr465574wru.336.1583436952398;
        Thu, 05 Mar 2020 11:35:52 -0800 (PST)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id f127sm10751327wma.4.2020.03.05.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 11:35:51 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH] mnt: add support for non-rootfs initramfs
Date:   Thu,  5 Mar 2020 19:35:11 +0000
Message-Id: <20200305193511.28621-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
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

One can solve this problem from userspace, but it is much more cumbersome. We
either have to create a multilayered archive for initramfs, where the outer
layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
kernel cmdline option, unpack initramfs to rootfs, run a script to create our
target tmpfs root, unpack the same initramfs there, switch root to it and again
properly cleanup the old root, thus unpacking the same archive twice and also
wasting memory, because kernel stores compressed initramfs image indefinitely.

With this change we can ask the kernel (by specifying nonroot_initramfs kernel
cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
before the initramfs handling code, so initramfs gets unpacked directly into
the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

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

