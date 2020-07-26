Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D022DCA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGZHOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgGZHOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11F4C0619D4;
        Sun, 26 Jul 2020 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TyccVA9O302V0OzLInx8V8iW+zTGdsLOVXOTBRT3hL0=; b=KdCFC9UBIOeHHGXJoCzMGMnbeG
        WImpbutFefQcgK7CwTsZ7jsFQdELMEyoRfTFFT3ZiPqkEnsuPcNewpTVzyEd96IGmCNYXt+/Am2KN
        Wduj2AOEHyfqFvGtt6pgeldg6olmrhqSl7Du0FJdJKUB6nOJ9KxB/eQHAhTDbU0Ntss+DltznjxmH
        ge4ujbf6XaX34mwM+L+MauPP/coyfEq3uCqNO2m34SImrl8fIKXuF4dC8K62MmADPsxz2N8ZYqAoc
        7tU9YNIiP6/8TZ8Znz8czN4WmXzI0rjPnyF5P69UMKvpQBIdhTqm+8l8K4je5uy0GWLSZlRhJPeAx
        U/WyiV8g==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarh-0002VE-R0; Sun, 26 Jul 2020 07:14:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 16/21] init: add an init_link helper
Date:   Sun, 26 Jul 2020 09:13:51 +0200
Message-Id: <20200726071356.287160-17-hch@lst.de>
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

Add a simple helper to link with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_link.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/for_init.c                 | 33 +++++++++++++++++++++++++++++++++
 fs/internal.h                 |  3 +--
 fs/namei.c                    |  4 ++--
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  9 ---------
 init/initramfs.c              |  2 +-
 6 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index abc152f41e648b..339ac1a52ca150 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -118,6 +118,39 @@ int __init init_eaccess(const char *filename)
 	return error;
 }
 
+int __init init_link(const char *oldname, const char *newname)
+{
+	struct dentry *new_dentry;
+	struct path old_path, new_path;
+	int error;
+
+	error = kern_path(oldname, 0, &old_path);
+	if (error)
+		return error;
+
+	new_dentry = kern_path_create(AT_FDCWD, newname, &new_path, 0);
+	error = PTR_ERR(new_dentry);
+	if (IS_ERR(new_dentry))
+		goto out;
+
+	error = -EXDEV;
+	if (old_path.mnt != new_path.mnt)
+		goto out_dput;
+	error = may_linkat(&old_path);
+	if (unlikely(error))
+		goto out_dput;
+	error = security_path_link(old_path.dentry, &new_path, new_dentry);
+	if (error)
+		goto out_dput;
+	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry,
+			 NULL);
+out_dput:
+	done_path_create(&new_path, new_dentry);
+out:
+	path_put(&old_path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/internal.h b/fs/internal.h
index 6d82681c7d8372..58451b033d2698 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -69,8 +69,7 @@ long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname);
-int do_linkat(int olddfd, const char __user *oldname, int newdfd,
-	      const char __user *newname, int flags);
+int may_linkat(struct path *link);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index d75a6039ae3966..13de64c6be7640 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1024,7 +1024,7 @@ static bool safe_hardlink_source(struct inode *inode)
  *
  * Returns 0 if successful, -ve on error.
  */
-static int may_linkat(struct path *link)
+int may_linkat(struct path *link)
 {
 	struct inode *inode = link->dentry->d_inode;
 
@@ -4086,7 +4086,7 @@ EXPORT_SYMBOL(vfs_link);
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-int do_linkat(int olddfd, const char __user *oldname, int newdfd,
+static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	      const char __user *newname, int flags)
 {
 	struct dentry *new_dentry;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 7031c0934bee9f..5ca15a5b55b7d7 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -8,5 +8,6 @@ int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
+int __init init_link(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a2779638e41445..4b18b91ce46573 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1295,15 +1295,6 @@ static inline long ksys_mknod(const char __user *filename, umode_t mode,
 	return do_mknodat(AT_FDCWD, filename, mode, dev);
 }
 
-extern int do_linkat(int olddfd, const char __user *oldname, int newdfd,
-		     const char __user *newname, int flags);
-
-static inline long ksys_link(const char __user *oldname,
-			     const char __user *newname)
-{
-	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
-}
-
 extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
 		       gid_t group, int flag);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index f2ec2f024f9e67..48c137142fed7f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -311,7 +311,7 @@ static int __init maybe_link(void)
 		char *old = find_link(major, minor, ino, mode, collected);
 		if (old) {
 			clean_path(collected, 0);
-			return (ksys_link(old, collected) < 0) ? -1 : 1;
+			return (init_link(old, collected) < 0) ? -1 : 1;
 		}
 	}
 	return 0;
-- 
2.27.0

