Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2F228579
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgGUQ3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgGUQ27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9FC061794;
        Tue, 21 Jul 2020 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y/wMk4rC/y8zl/f6mFKXnyS0BzkChghodY9s4Ma8xLo=; b=BAvfo7lC2hep7fO5OGNHCI/3U+
        hw2InX5rnNjb4P6gcofsgJbgvZMfaGTmEUL+TAUFx11NIMTlFBOzqr7fuB3IxpPG+QHzCWOjmnYbG
        VVv3HEI6CfUGsYmgH1HMRz04Ppngc2+1NY05i3dlxaczboVfzRPXxMToAJhnJkOrgIbyxmixLLiV5
        uxSSuQAi0Huvzy6h/vDgBbVd170v024HWioqWBjCRRgU8ujuI3r5FAEFZGCT519k4pxDmG9owWRrK
        W3lPFC4TTviz3wGNANcBEfqhwE7u1uC+bhI/7y8D2b70e0V29bHktro2Ys32QKnbJ+Hehsukigsuu
        ndk3soyQ==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8Q-0007YE-Vl; Tue, 21 Jul 2020 16:28:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 22/24] init: add an init_mkdir helper
Date:   Tue, 21 Jul 2020 18:28:16 +0200
Message-Id: <20200721162818.197315-23-hch@lst.de>
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

Add a simple helper to mkdir with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_mkdir.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  1 -
 fs/namei.c               |  2 +-
 include/linux/syscalls.h |  7 -------
 init/do_mounts.h         |  1 +
 init/do_mounts_initrd.c  |  2 +-
 init/fs.c                | 18 ++++++++++++++++++
 init/initramfs.c         |  2 +-
 init/noinitramfs.c       |  5 +++--
 8 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ad89db759513c4..54cf897bd0c18f 100644
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
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 30287ac3106dba..62ae09b96be025 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -19,6 +19,7 @@ int __init init_eaccess(const char *filename);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
+int __init init_mkdir(const char *pathname, umode_t mode);
 int __init init_rmdir(const char *pathname);
 
 void  mount_block_root(char *name, int flags);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 697d45e4aa8c87..1be66f7d70d709 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -82,7 +82,7 @@ static void __init handle_initrd(void)
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
 	mount_block_root("/dev/root.old", root_mountflags & ~MS_RDONLY);
-	ksys_mkdir("/old", 0700);
+	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
 	/*
diff --git a/init/fs.c b/init/fs.c
index 8ffca538a8133f..0793a6872d0e33 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -163,6 +163,24 @@ int __init init_unlink(const char *pathname)
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
diff --git a/init/initramfs.c b/init/initramfs.c
index 5dd234cd2ecf12..b1a0a1d5c3c135 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -352,7 +352,7 @@ static int __init do_name(void)
 			state = CopyFile;
 		}
 	} else if (S_ISDIR(mode)) {
-		ksys_mkdir(collected, mode);
+		init_mkdir(collected, mode);
 		init_chown(collected, uid, gid, 0);
 		init_chmod(collected, mode);
 		dir_add(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index fa9cdfa7101d3c..b8bdba1c949cf9 100644
--- a/init/noinitramfs.c
+++ b/init/noinitramfs.c
@@ -9,6 +9,7 @@
 #include <linux/stat.h>
 #include <linux/kdev_t.h>
 #include <linux/syscalls.h>
+#include "do_mounts.h"
 
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

