Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFE230FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgG1QfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbgG1Qe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C47C0619D2;
        Tue, 28 Jul 2020 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eImBx+GdSKM3RfLtfB/i5lqS7yPeMnv3+z0pgZdWGl4=; b=MYnxIgNB4dHy/WF6kkYepN0YsA
        iAw0NEaq2uxYCTUS7EOCqFp6drRLtHhxBOst3xs8Ap3OTGCoLf5YJbBKUhDJpMjVa5rUTyUEcJpQW
        BARl4rG9ZUeszaGH6WnLfMjO4xsmnIr49CBCwqoD7Lnl98zIUWFmdWEpwDVwV46hEhpbPjzGY36wP
        mdS/yaiwU0mEDES83f+qOVp/etU3wEE5ZU6d57WxsX9vNcshjQnf+F2zKAXhgbnE1eql/SpU2+/YQ
        jDxQ1r8eHziZ9CX5UDF++/5ZSKZZclE69UFw90YBVTWwQvO3pmxOBBrqXRfvAr0vLWoLZZJJOqri8
        Ztk+UhFw==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SZ5-000737-JM; Tue, 28 Jul 2020 16:34:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 19/23] init: add an init_mkdir helper
Date:   Tue, 28 Jul 2020 18:34:12 +0200
Message-Id: <20200728163416.556521-20-hch@lst.de>
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

Add a simple helper to mkdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_mkdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 18 ++++++++++++++++++
 fs/internal.h                 |  1 -
 fs/namei.c                    |  2 +-
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  7 -------
 init/do_mounts_initrd.c       |  2 +-
 init/initramfs.c              |  2 +-
 init/noinitramfs.c            |  5 +++--
 8 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 09ef2b58d48caa..127033d0842601 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -176,6 +176,24 @@ int __init init_unlink(const char *pathname)
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
 }
 
+int __init init_mkdir(const char *pathname, umode_t mode)
+{
+	struct dentry *dentry;
+	struct path path;
+	int error;
+
+	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+	if (!IS_POSIXACL(path.dentry->d_inode))
+		mode &= ~current_umask();
+	error = security_path_mkdir(&path, dentry, mode);
+	if (!error)
+		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
+	done_path_create(&path, dentry);
+	return error;
+}
+
 int __init init_rmdir(const char *pathname)
 {
 	return do_rmdir(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/internal.h b/fs/internal.h
index 40b50a222d7a22..4741e591e923bf 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -64,7 +64,6 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		unsigned int dev);
-long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct path *link);
diff --git a/fs/namei.c b/fs/namei.c
index 2f6fa53eb3da28..d6b25dd32f4d50 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3645,7 +3645,7 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
+static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 125f55ae3f80b8..d808985231f8f8 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -11,4 +11,5 @@ int __init init_eaccess(const char *filename);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
+int __init init_mkdir(const char *pathname, umode_t mode);
 int __init init_rmdir(const char *pathname);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7cdc0d749a049f..5ef77a91382aa5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1270,13 +1270,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-extern long do_mkdirat(int dfd, const char __user *pathname, umode_t mode);
-
-static inline long ksys_mkdir(const char __user *pathname, umode_t mode)
-{
-	return do_mkdirat(AT_FDCWD, pathname, mode);
-}
-
 extern long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 		       unsigned int dev);
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index a6b447b191dbc8..3f5ac81913dde4 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -81,7 +81,7 @@ static void __init handle_initrd(void)
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
-	ksys_mkdir("/old", 0700);
+	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
 	/*
diff --git a/init/initramfs.c b/init/initramfs.c
index b74d18657e7a17..23513e4419e052 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -348,7 +348,7 @@ static int __init do_name(void)
 			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
-		ksys_mkdir(collected, mode);
+		init_mkdir(collected, mode);
 		init_chown(collected, uid, gid, 0);
 		init_chmod(collected, mode);
 		dir_add(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index fa9cdfa7101d3c..94cc4df74b11f2 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -9,6 +9,7 @@
 #include <linux/stat.h>
 #include <linux/kdev_t.h>
 #include <linux/syscalls.h>
+#include <linux/init_syscalls.h>
 
 /*
  * Create a simple rootfs that is similar to the default initramfs
@@ -17,7 +18,7 @@ static int __init default_rootfs(void)
 {
 	int err;
 
-	err = ksys_mkdir((const char __user __force *) "/dev", 0755);
+	err = init_mkdir("/dev", 0755);
 	if (err < 0)
 		goto out;
 
@@ -27,7 +28,7 @@ static int __init default_rootfs(void)
 	if (err < 0)
 		goto out;
 
-	err = ksys_mkdir((const char __user __force *) "/root", 0700);
+	err = init_mkdir("/root", 0700);
 	if (err < 0)
 		goto out;
 
-- 
2.27.0

