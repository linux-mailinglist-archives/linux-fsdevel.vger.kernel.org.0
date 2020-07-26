Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174BD22DCA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgGZHOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgGZHOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A830C0619D2;
        Sun, 26 Jul 2020 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MJxfIJc5GcfguEdhmuCVs1Q0Ywd1gqUYWhUUmceWjfw=; b=grf+yo473sM13bqM012FJatkSK
        abapynIxJJ9osJbVaZG+jaBQsZh7J2n3RVqQqmUWtuwdo7i9M+yCmd3rBIyc0q801K9TxClLpjnWc
        BGVumqUtiD+hdPL24zOzgSz4MlDN2HyI06FzIKnftoNJrcM8p00+wJFNJQuNjp4OVfpI9kxLClrCN
        zQM3eSgvaNdUkMFgNnamOO7/gbnJI/LJUeFuEek5bnz7+OEbaksvrzCE7eyaeL7MA15nWCjUQuQyx
        n3MauqJOoGuJ1cQaOcHVquypSav86Num9KWdOfNgJHmMkL4tbM1s9mQaXzbbsQtNP+VtLnG3vK0tE
        Hj7boR8w==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarp-0002WW-7l; Sun, 26 Jul 2020 07:14:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 19/21] init: add an init_mknod helper
Date:   Sun, 26 Jul 2020 09:13:54 +0200
Message-Id: <20200726071356.287160-20-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to mknod with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_mknod.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/for_init.c                 | 25 +++++++++++++++++++++++++
 fs/internal.h                 |  2 --
 fs/namei.c                    |  2 +-
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  9 ---------
 init/do_mounts.h              |  2 +-
 init/initramfs.c              |  2 +-
 init/noinitramfs.c            |  3 +--
 8 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index 6ae3305bece1eb..50813d2913b57b 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -118,6 +118,31 @@ int __init init_eaccess(const char *filename)
 	return error;
 }
 
+int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
+{
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
+	if (S_ISFIFO(mode) || S_ISSOCK(mode))
+		dev = 0;
+	else if (!(S_ISBLK(mode) || S_ISCHR(mode)))
+		return -EINVAL;
+
+	dentry = kern_path_create(AT_FDCWD, filename, &path, 0);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	if (!IS_POSIXACL(path.dentry->d_inode))
+		mode &= ~current_umask();
+	error = security_path_mknod(&path, dentry, mode, dev);
+	if (!error)
+		error = vfs_mknod(path.dentry->d_inode, dentry, mode,
+				  new_decode_dev(dev));
+	done_path_create(&path, dentry);
+	return error;
+}
+
 int __init init_link(const char *oldname, const char *newname)
 {
 	struct dentry *new_dentry;
diff --git a/fs/internal.h b/fs/internal.h
index 4741e591e923bf..07e145b2f88c4a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -62,8 +62,6 @@ extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
-long do_mknodat(int dfd, const char __user *filename, umode_t mode,
-		unsigned int dev);
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct path *link);
diff --git a/fs/namei.c b/fs/namei.c
index d6b25dd32f4d50..fde8fe086c090d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3564,7 +3564,7 @@ static int may_mknod(umode_t mode)
 	}
 }
 
-long do_mknodat(int dfd, const char __user *filename, umode_t mode,
+static long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev)
 {
 	struct dentry *dentry;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index d808985231f8f8..fa1fe7a877795f 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -8,6 +8,7 @@ int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
+int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5ef77a91382aa5..63046c5e9fc5d4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1270,15 +1270,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-extern long do_mknodat(int dfd, const char __user *filename, umode_t mode,
-		       unsigned int dev);
-
-static inline long ksys_mknod(const char __user *filename, umode_t mode,
-			      unsigned int dev)
-{
-	return do_mknodat(AT_FDCWD, filename, mode, dev);
-}
-
 extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
 		       gid_t group, int flag);
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 104d8431725aeb..7a29ac3e427bab 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -17,7 +17,7 @@ extern int root_mountflags;
 static inline __init int create_dev(char *name, dev_t dev)
 {
 	init_unlink(name);
-	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
 }
 
 #ifdef CONFIG_BLK_DEV_RAM
diff --git a/init/initramfs.c b/init/initramfs.c
index 076e66f11bda8d..9b2d93a2eb5e4b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -352,7 +352,7 @@ static int __init do_name(void)
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-			ksys_mknod(collected, mode, rdev);
+			init_mknod(collected, mode, rdev);
 			init_chown(collected, uid, gid, 0);
 			init_chmod(collected, mode);
 			do_utime(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index 94cc4df74b11f2..3d62b07f3bb9c3 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -22,8 +22,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = ksys_mknod((const char __user __force *) "/dev/console",
-			S_IFCHR | S_IRUSR | S_IWUSR,
+	err = init_mknod("/dev/console", S_IFCHR | S_IRUSR | S_IWUSR,
 			new_encode_dev(MKDEV(5, 1)));
 	if (err < 0)
 		goto out;
-- 
2.27.0

