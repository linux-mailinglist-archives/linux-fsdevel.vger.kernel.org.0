Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2350228558
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgGUQ2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbgGUQ2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481ADC061794;
        Tue, 21 Jul 2020 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rLxcfdL2zVDL0b0Nzk8JqYM0sd8pftMXzm0dy6UrVug=; b=ST3g9v0BuSSi2OKz/gs7aY7Dxb
        43xy05rogt18zI8To1tLR665ayv7kEMPeLc6YUUZcvU/el8DRoF2UMDwNopsOFdRRiiOzWkgsU9Be
        /+dYT2rtimbVJKy+pGdXoF7bNRxnWQcqapd7hhkSQ6rv4ZFQ62qkAukYQKKCVs59OwA+iX+ErbRv7
        Vo6W09Ad+GiKMMwk4YLwFC6YRibdviRURmSqQkG9B9ltfDjMSlt6MaT664xxzlm83Y/U/coqrmiCe
        /dR+tWeXV7XpBkgSIIo/aMsAPbhuppEq0ekULlCh29JhK8sfIpDWfAiNXjcF/yBqGA9+MRZHuwvFz
        Eez4HGXQ==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8H-0007VI-2Y; Tue, 21 Jul 2020 16:28:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 16/24] init: add an init_chroot helper
Date:   Tue, 21 Jul 2020 18:28:10 +0200
Message-Id: <20200721162818.197315-17-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
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
 fs/open.c                |  7 +------
 include/linux/syscalls.h |  2 --
 init/do_mounts.c         |  2 +-
 init/do_mounts.h         |  1 +
 init/do_mounts_initrd.c  |  4 ++--
 init/fs.c                | 23 +++++++++++++++++++++++
 6 files changed, 28 insertions(+), 11 deletions(-)

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
index cc08ed7b44e764..c8ccdc80ffcdd5 100644
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
diff --git a/init/do_mounts.h b/init/do_mounts.h
index c82fcb27575877..810b37ce1db882 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,6 +12,7 @@
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_chdir(const char *filename);
+int __init init_chroot(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index ef214a78e7ee49..697d45e4aa8c87 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -64,7 +64,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	/* move initrd over / and chdir/chroot in initrd root */
 	init_chdir("/root");
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	ksys_chroot(".");
+	init_chroot(".");
 	ksys_setsid();
 	return 0;
 }
@@ -102,7 +102,7 @@ static void __init handle_initrd(void)
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
-	ksys_chroot("..");
+	init_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
 		init_chdir("/old");
diff --git a/init/fs.c b/init/fs.c
index f3d8da00662572..af55e6d40357dc 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -36,6 +36,29 @@ int __init init_chdir(const char *filename)
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
-- 
2.27.0

