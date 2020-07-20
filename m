Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A12226944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgGTP7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbgGTP7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A0C061794;
        Mon, 20 Jul 2020 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UOX0si6AhtwoJKottNiHX9JjlUJtCyr1PHl0KmhrlQ8=; b=ZnhLZN8h5/oQjepX3efiYYpOy2
        URR9cKKOC/Yd4BhaqoUpwkwkGP/V7LRXInoYenKQSc0yMl5h07lxvQ1cEBDit32wyfGBIW7Nryk/U
        momcCqsa15ARKZnmpkdAA5fjkm/x3htx1/SO6sxRSFYNVw0VfQr1Rt4+oZ7fchHzBgWRoQYLv938W
        0chWbyjsEXS5I2/ruPCYdkIBqOS7D/D32YZO8UB+zSw05ArglFq3n2NkDert20IJG52Ak/vF9y8Z5
        K8TQiaOjnGcNfsL6sw5Ta12NSZ4ucGFazig+/dil4Qr9PrupSXFcU2hUkIZGcTY9p27NO8QBitrgv
        36j3WQGQ==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCV-0007rC-Qj; Mon, 20 Jul 2020 15:59:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 18/24] fs: add a kern_rmdir helper
Date:   Mon, 20 Jul 2020 17:58:56 +0200
Message-Id: <20200720155902.181712-19-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to rmdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_rmdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  1 -
 fs/namei.c               | 17 ++++++++++-------
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h |  7 -------
 init/initramfs.c         |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 62e17871f16316..11b5b99c8dc689 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -62,7 +62,6 @@ extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
-long do_rmdir(int dfd, const char __user *pathname);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 3cbaca386d3189..3de1476885a18a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3754,18 +3754,16 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(vfs_rmdir);
 
-long do_rmdir(int dfd, const char __user *pathname)
+static int do_rmdir(int dfd, struct filename *name)
 {
 	int error = 0;
-	struct filename *name;
 	struct dentry *dentry;
 	struct path path;
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
 retry:
-	name = filename_parentat(dfd, getname(pathname), lookup_flags,
-				&path, &last, &type);
+	name = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
@@ -3805,17 +3803,22 @@ long do_rmdir(int dfd, const char __user *pathname)
 	mnt_drop_write(path.mnt);
 exit1:
 	path_put(&path);
-	putname(name);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+	putname(name);
 	return error;
 }
 
+int __init kern_rmdir(const char *pathname)
+{
+	return do_rmdir(AT_FDCWD, getname_kernel(pathname));
+}
+
 SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 {
-	return do_rmdir(AT_FDCWD, pathname);
+	return do_rmdir(AT_FDCWD, getname(pathname));
 }
 
 /**
@@ -3965,7 +3968,7 @@ SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 		return -EINVAL;
 
 	if (flag & AT_REMOVEDIR)
-		return do_rmdir(dfd, pathname);
+		return do_rmdir(dfd, getname(pathname));
 
 	return do_unlinkat(dfd, getname(pathname));
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 306e58ff54f69f..6100b9f92cee8b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3682,5 +3682,6 @@ int kern_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init kern_link(const char *oldname, const char *newname);
 int __init kern_symlink(const char *oldname, const char *newname);
 int kern_unlink(const char *pathname);
+int __init kern_rmdir(const char *pathname);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 483431765ac823..56c1fb4fadd666 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1270,13 +1270,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-extern long do_rmdir(int dfd, const char __user *pathname);
-
-static inline long ksys_rmdir(const char __user *pathname)
-{
-	return do_rmdir(AT_FDCWD, pathname);
-}
-
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
diff --git a/init/initramfs.c b/init/initramfs.c
index 86d3750a47499d..d72594298133a7 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -298,7 +298,7 @@ static void __init clean_path(char *path, umode_t fmode)
 
 	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
-			ksys_rmdir(path);
+			kern_rmdir(path);
 		else
 			kern_unlink(path);
 	}
-- 
2.27.0

