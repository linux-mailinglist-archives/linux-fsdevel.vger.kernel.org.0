Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17A230FB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgG1QfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgG1Qe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3BBC061794;
        Tue, 28 Jul 2020 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VnGqX557vfmWzKzvM3+qhVX0BlyWXuPdGqMx9wDnWBw=; b=YK5Lr19X4q4xjDvo07NxVborxY
        5bDWcjsBacGMDx2cxsGhswDWWHiwRkNKGT8fKfMY8EHKG4RyaTQn0Qn2sQnELMqyUPbS/ZRC/H3WG
        MmRwLS0CXF8A0kYDclrpLJFupfAUnC0obnH2+MQwnNfohvF7UPs7U0zbKq0thIMURbRsGqYy430aU
        lOypgvCzTGJrlN85Yb3IWLDFcHn40822oyoLzp7uh5/bD2zpppR0JXQr+QFDzQ6jCjJmzb7uFFDEB
        RB6Sszcdypnh61L00YqobeOfI0AJU4swn+uxLfiVxr6uqVvxaxMHkGNhd6oeOdWEVNMA4uLyCngHQ
        hv2Vvl5A==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SZ3-00072w-QZ; Tue, 28 Jul 2020 16:34:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 18/23] init: add an init_symlink helper
Date:   Tue, 28 Jul 2020 18:34:11 +0200
Message-Id: <20200728163416.556521-19-hch@lst.de>
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

Add a simple helper to symlink with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_symlink.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 16 ++++++++++++++++
 fs/internal.h                 |  2 --
 fs/namei.c                    |  2 +-
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  9 ---------
 init/initramfs.c              |  2 +-
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5db9d9f74868e1..09ef2b58d48caa 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -155,6 +155,22 @@ int __init init_link(const char *oldname, const char *newname)
 	return error;
 }
 
+int __init init_symlink(const char *oldname, const char *newname)
+{
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
+	dentry = kern_path_create(AT_FDCWD, newname, &path, 0);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	error = security_path_symlink(&path, dentry, oldname);
+	if (!error)
+		error = vfs_symlink(path.dentry->d_inode, dentry, oldname);
+	done_path_create(&path, dentry);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/internal.h b/fs/internal.h
index 58451b033d2698..40b50a222d7a22 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -67,8 +67,6 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
-long do_symlinkat(const char __user *oldname, int newdfd,
-		  const char __user *newname);
 int may_linkat(struct path *link);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 13de64c6be7640..2f6fa53eb3da28 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3955,7 +3955,7 @@ int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 }
 EXPORT_SYMBOL(vfs_symlink);
 
-long do_symlinkat(const char __user *oldname, int newdfd,
+static long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname)
 {
 	int error;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 5ca15a5b55b7d7..125f55ae3f80b8 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -9,5 +9,6 @@ int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
 int __init init_link(const char *oldname, const char *newname);
+int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4b18b91ce46573..7cdc0d749a049f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1277,15 +1277,6 @@ static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
 	return do_mkdirat(AT_FDCWD, pathname, mode);
 }
 
-extern long do_symlinkat(const char __user *oldname, int newdfd,
-			 const char __user *newname);
-
-static inline long ksys_symlink(const char __user *oldname,
-				const char __user *newname)
-{
-	return do_symlinkat(oldname, AT_FDCWD, newname);
-}
-
 extern long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		       unsigned int dev);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index a3d29318cc351d..b74d18657e7a17 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -393,7 +393,7 @@ static int __init do_symlink(void)
 {
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
-	ksys_symlink(collected + N_ALIGN(name_len), collected);
+	init_symlink(collected + N_ALIGN(name_len), collected);
 	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(collected, mtime);
 	state = SkipIt;
-- 
2.27.0

