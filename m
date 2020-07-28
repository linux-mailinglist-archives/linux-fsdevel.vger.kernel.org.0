Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B6230FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgG1Qeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbgG1Qep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5FC061794;
        Tue, 28 Jul 2020 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/T5H0GjNVGfpRThj07mo+lYP7Tftb5ckql4lMF97imo=; b=cYH+YcQ8/Wy9tfCepfhgOCT1Le
        ZED6WGyxpTBMOSi+Zt/UTRB7g+dQ4evoH9AIa0zSoSOwmBGR8fe/AroJ7rA7POLVDshZZWndl4LbI
        w+LoCKoYvwo3yfMV5HGr8k1VITcCMGJqLt1WVyekuqBmm5GMubfwiclDj5kD3hCvG/zcEqvRSqGdS
        7sv/w0hJvV1UnZjAqMVIhhjeNneXh4EUCcuV8aT018bG+BYcLu3qqLl2157GX0/3tG2uhOqylq2AP
        ZjuOudsEseuS+ka1Q0ktBKhLgg0C0PUYiSm6f1OuQhz4cLLcjHcnEyclQlHrDzAxgVT4WhOEl8MJ+
        Gm0+zblQ==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYo-0006zw-Dr; Tue, 28 Jul 2020 16:34:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 12/23] init: add an init_chdir helper
Date:   Tue, 28 Jul 2020 18:34:05 +0200
Message-Id: <20200728163416.556521-13-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to chdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_chdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c       |  2 +-
 fs/init.c                     | 16 ++++++++++++++++
 fs/open.c                     |  7 +------
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  1 -
 init/do_mounts.c              |  2 +-
 init/do_mounts_initrd.c       |  8 ++++----
 7 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 32af6cb987b428..e48aaba3166b5d 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -412,7 +412,7 @@ static int __init devtmpfs_setup(void *p)
 	err = init_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
 	if (err)
 		goto out;
-	ksys_chdir("/.."); /* will traverse into overmounted root */
+	init_chdir("/.."); /* will traverse into overmounted root */
 	ksys_chroot(".");
 out:
 	*(int *)p = err;
diff --git a/fs/init.c b/fs/init.c
index eabd9ed2b51092..64d4e12eba9339 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -7,6 +7,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/init_syscalls.h>
 #include "internal.h"
 
@@ -38,6 +39,21 @@ int __init init_umount(const char *name, int flags)
 	return path_umount(&path, flags);
 }
 
+int __init init_chdir(const char *filename)
+{
+	struct path path;
+	int error;
+
+	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
+	if (error)
+		return error;
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	if (!error)
+		set_fs_pwd(current->fs, &path);
+	path_put(&path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/open.c b/fs/open.c
index b316dd6a86a8b9..723e0ac898935e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -482,7 +482,7 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return do_faccessat(AT_FDCWD, filename, mode, 0);
 }
 
-int ksys_chdir(const char __user *filename)
+SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
 	struct path path;
 	int error;
@@ -508,11 +508,6 @@ int ksys_chdir(const char __user *filename)
 	return error;
 }
 
-SYSCALL_DEFINE1(chdir, const char __user *, filename)
-{
-	return ksys_chdir(filename);
-}
-
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
 	struct fd f = fdget_raw(fd);
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index abf3af563c0b3a..1e845910ae56e9 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -3,5 +3,6 @@
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_umount(const char *name, int flags);
+int __init init_chdir(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a7b14258d245e2..31fa67fb9894b3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1238,7 +1238,6 @@ asmlinkage long sys_ni_syscall(void);
 
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
-int ksys_chdir(const char __user *filename);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 83db87b6e5d1e0..a7581c6e85f268 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -408,7 +408,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	if (ret)
 		goto out;
 
-	ksys_chdir("/root");
+	init_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
 	ROOT_DEV = s->s_dev;
 	printk(KERN_INFO
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 8b44dd017842a8..04627fd22a921f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -61,7 +61,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_unshare(CLONE_FS | CLONE_FILES);
 	console_on_rootfs();
 	/* move initrd over / and chdir/chroot in initrd root */
-	ksys_chdir("/root");
+	init_chdir("/root");
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	ksys_setsid();
@@ -82,7 +82,7 @@ static void __init handle_initrd(void)
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	ksys_mkdir("/old", 0700);
-	ksys_chdir("/old");
+	init_chdir("/old");
 
 	/*
 	 * In case that a resume from disk is carried out by linuxrc or one of
@@ -104,11 +104,11 @@ static void __init handle_initrd(void)
 	ksys_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
-		ksys_chdir("/old");
+		init_chdir("/old");
 		return;
 	}
 
-	ksys_chdir("/");
+	init_chdir("/");
 	ROOT_DEV = new_decode_dev(real_root_dev);
 	mount_root();
 
-- 
2.27.0

