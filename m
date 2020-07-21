Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA31C22856B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgGUQ3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgGUQ25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B04C0619DB;
        Tue, 21 Jul 2020 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H9VMcvfRXD662qkjJ9u8mN2CQ3f2kctb0ZnG1Haiav0=; b=dMEIlIY8sizzNSAkdSgjLXDd9Z
        SO1uMlcB5nVcE1fuivBlFRIo8zjcJFVtGOZAvwOJGspqzB07oXFDmeWrgN/a7lMY/RNUp8w5eV4Sm
        Y+umWOFNSxivdNzbAo+nMnN7FI09NU7JQLu0jVN9z+M67ebM7hSkRrKcDNPp/fL6V99U0SVN+Fqml
        UUPE4Me1tRceGsvzRMqTkr9ynz+pnBLNm9GEWBeQ9d8sXzrqzL07tXRpYzcPawZuL9OWVQuBbp6g1
        pemnyAP+ahitHzREZdnmMUbOhj+7GGIgkOqq3JZ0nygeRZ0rm1Y19dvLXFLnLe1/JBJd6RIPnYEkS
        zntNHS0Q==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8P-0007Xk-EK; Tue, 21 Jul 2020 16:28:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 21/24] init: add an init_symlink helper
Date:   Tue, 21 Jul 2020 18:28:15 +0200
Message-Id: <20200721162818.197315-22-hch@lst.de>
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

Add a simple helper to symlink with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_symlink.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 --
 fs/namei.c               |  2 +-
 include/linux/syscalls.h |  9 ---------
 init/do_mounts.h         |  1 +
 init/fs.c                | 22 ++++++++++++++++++++++
 init/initramfs.c         |  2 +-
 6 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9a1e937e484647..ad89db759513c4 100644
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
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index c80105e47a8e66..30287ac3106dba 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -17,6 +17,7 @@ int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
 int __init init_link(const char *oldname, const char *newname);
+int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/fs.c b/init/fs.c
index fb5fb7aa498485..8ffca538a8133f 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -136,6 +136,28 @@ int __init init_link(const char *oldname, const char *newname)
 	return error;
 }
 
+int __init init_symlink(const char *oldname, const char *newname)
+{
+	struct filename *from = getname_kernel(oldname);
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
+	if (IS_ERR(from))
+		return PTR_ERR(from);
+	dentry = kern_path_create(AT_FDCWD, newname, &path, 0);
+	error = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
+		goto out_putname;
+	error = security_path_symlink(&path, dentry, from->name);
+	if (!error)
+		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
+	done_path_create(&path, dentry);
+out_putname:
+	putname(from);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/init/initramfs.c b/init/initramfs.c
index bdc3c0ec5a6c31..5dd234cd2ecf12 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -397,7 +397,7 @@ static int __init do_symlink(void)
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

