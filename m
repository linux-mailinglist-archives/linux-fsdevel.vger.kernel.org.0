Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D687222855A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgGUQ2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgGUQ2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC6C0619DA;
        Tue, 21 Jul 2020 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FQt39A2nvg4vjPcsla4UHR16GHiUlpocefVTzN8BskE=; b=RliynNWuP3yOwfTxeY7dQw90ke
        0L0TM3jzeFEp54mN6gVIe3zYffOQYTu0uORfDjAgDQyyPrrXR+rjBBPhr4fuXtHfoLi+nmleTBW4m
        cq51wAy3niCsa5uMdYVJgF+5hgFgGXcEunpc9kLIK9JrIGvU90d++t3zxifIsC1crOfDklQPJaAvZ
        wUqKnedgGZx63iws3N6E5WYJ70cM0rIXeFfOrn0moYP5T8rAiEnnlcvUFzsYWaZERRYdqAehVycVs
        mRIfwzRSdovJrMGTF+TyDqexqQlFEs7LJFfVcrKDKfRSpr6e116SU/nvsq85kVr3q/AMfzfC11bWL
        AF/X95Nw==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8F-0007Ut-88; Tue, 21 Jul 2020 16:28:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 15/24] init: add an init_chdir helper
Date:   Tue, 21 Jul 2020 18:28:09 +0200
Message-Id: <20200721162818.197315-16-hch@lst.de>
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

Add a simple helper to chdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_chdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                |  7 +------
 include/linux/syscalls.h |  1 -
 init/do_mounts.c         |  2 +-
 init/do_mounts.h         |  1 +
 init/do_mounts_initrd.c  |  8 ++++----
 init/fs.c                | 16 ++++++++++++++++
 6 files changed, 23 insertions(+), 12 deletions(-)

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
index 4812e21d149cab..cc08ed7b44e764 100644
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
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 58605396d358d7..c82fcb27575877 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -11,6 +11,7 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
+int __init init_chdir(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index dd4680c8ac762e..ef214a78e7ee49 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -62,7 +62,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	ksys_unshare(CLONE_FS | CLONE_FILES);
 	console_on_rootfs();
 	/* move initrd over / and chdir/chroot in initrd root */
-	ksys_chdir("/root");
+	init_chdir("/root");
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	ksys_chroot(".");
 	ksys_setsid();
@@ -83,7 +83,7 @@ static void __init handle_initrd(void)
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
 	ksys_mkdir("/old", 0700);
-	ksys_chdir("/old");
+	init_chdir("/old");
 
 	/*
 	 * In case that a resume from disk is carried out by linuxrc or one of
@@ -105,11 +105,11 @@ static void __init handle_initrd(void)
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
 
diff --git a/init/fs.c b/init/fs.c
index b69b2f949b6132..f3d8da00662572 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -3,6 +3,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <../fs/internal.h>
 #include "do_mounts.h"
 
@@ -20,6 +21,21 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	return ret;
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
-- 
2.27.0

