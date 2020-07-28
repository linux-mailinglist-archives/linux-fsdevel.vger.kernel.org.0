Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17028230FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbgG1Qer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgG1Qeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEBC061794;
        Tue, 28 Jul 2020 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RSxXaY46qjfEfo21QTpQuE55JqNPBx/9VQ1LMRWiW5M=; b=lEJ+hCVHys8yl21i8p4u0uuAAq
        lurWG95UoMC61IC0nXnS/E4PRS31Tuo6oOFJSYBX5ZXBc/WYjR6nsfiU9V/PSHnH3ZWwc0UKks1PY
        g9ayjXHHa7PettEcd2lwMNdLd9JNtdfkEMwTSDxpHT/SqATBdwfQbkM2mCaRS6qGkrLEPyluagz5G
        pN9JQcCdkqAnM0SP092CdWEIo60tUzB26rMTx7zjMxG4ZM/MZtfOz5vMGaf1yKwzfsVGBgci/o8B/
        0Pg+sLk5QoRx64H/PPLGnhx2E84kmkEq28f+MROahXPnJq4btasqSw4PjSMDaPRSRssoOKQXWVA1C
        S/1fBXJw==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYr-00070X-N1; Tue, 28 Jul 2020 16:34:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 13/23] init: add an init_chroot helper
Date:   Tue, 28 Jul 2020 18:34:06 +0200
Message-Id: <20200728163416.556521-14-hch@lst.de>
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

Add a simple helper to chroot with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_chroot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c       |  2 +-
 fs/init.c                     | 24 ++++++++++++++++++++++++
 fs/open.c                     |  7 +------
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  2 --
 init/do_mounts.c              |  2 +-
 init/do_mounts_initrd.c       |  4 ++--
 7 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index e48aaba3166b5d..eac184e6d65774 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -413,7 +413,7 @@ static int __init devtmpfs_setup(void *p)
 	if (err)
 		goto out;
 	init_chdir("/.."); /* will traverse into overmounted root */
-	ksys_chroot(".");
+	init_chroot(".");
 out:
 	*(int *)p = err;
 	complete(&setup_done);
diff --git a/fs/init.c b/fs/init.c
index 64d4e12eba9339..2c78f24814dde4 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
 #include <linux/init_syscalls.h>
+#include <linux/security.h>
 #include "internal.h"
 
 int __init init_mount(const char *dev_name, const char *dir_name,
@@ -54,6 +55,29 @@ int __init init_chdir(const char *filename)
 	return error;
 }
 
+int __init init_chroot(const char *filename)
+{
+	struct path path;
+	int error;
+
+	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
+	if (error)
+		return error;
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	if (error)
+		goto dput_and_out;
+	error = -EPERM;
+	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
+		goto dput_and_out;
+	error = security_path_chroot(&path);
+	if (error)
+		goto dput_and_out;
+	set_fs_root(current->fs, &path);
+dput_and_out:
+	path_put(&path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/open.c b/fs/open.c
index 723e0ac898935e..f62f4752bb436d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -530,7 +530,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	return error;
 }
 
-int ksys_chroot(const char __user *filename)
+SYSCALL_DEFINE1(chroot, const char __user *, filename)
 {
 	struct path path;
 	int error;
@@ -563,11 +563,6 @@ int ksys_chroot(const char __user *filename)
 	return error;
 }
 
-SYSCALL_DEFINE1(chroot, const char __user *, filename)
-{
-	return ksys_chroot(filename);
-}
-
 static int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 1e845910ae56e9..e07099a14b91db 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -4,5 +4,6 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
+int __init init_chroot(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 31fa67fb9894b3..e89d62e944dc0e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1235,8 +1235,6 @@ asmlinkage long sys_ni_syscall(void);
  * Instead, use one of the functions which work equivalently, such as
  * the ksys_xyzyyz() functions prototyped below.
  */
-
-int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a7581c6e85f268..b5f9604d0c98a2 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -629,7 +629,7 @@ void __init prepare_namespace(void)
 out:
 	devtmpfs_mount();
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	ksys_chroot(".");
+	init_chroot(".");
 }
 
 static bool is_tmpfs;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 04627fd22a921f..a6b447b191dbc8 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -63,7 +63,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	/* move initrd over / and chdir/chroot in initrd root */
 	init_chdir("/root");
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	ksys_chroot(".");
+	init_chroot(".");
 	ksys_setsid();
 	return 0;
 }
@@ -101,7 +101,7 @@ static void __init handle_initrd(void)
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
-	ksys_chroot("..");
+	init_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
 		init_chdir("/old");
-- 
2.27.0

