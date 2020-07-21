Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F622857B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgGUQ3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgGUQ3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:29:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37AEC0619DA;
        Tue, 21 Jul 2020 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wRdGdHiPIMSQTkea6F2RZyQBW2sP0D118Ho9bXBJyHY=; b=ShS237RHYk7nDNFwyPheqoOnU4
        bjTqRGbrb/5etMz3f+AtfqpPG5ao9Yuv2xRw95/aMVnK88ZEsxYbiWeIYyh8quc2fyoE+ziTLAScE
        fFPkJxrwC+FG9S1tIOBywUunbS29Kin+02hw48Ok/r5uSAs5yW7ex5Nr0JlIcFE5mUlwiftgfevBg
        LrGEKWEBPrWRyPQDMGAf53GZqLTa+zZptCl14B97Qm6Ry8ftvin30BBqwaCUqiLvWeu7q1genNixj
        ISSkueIL1565C1lDeqCrU+bxtCUVmMtshU955MoXXYjVNQmcTyqTPBJf2SYD4osSVWXp7izZWNCBL
        9MWavngg==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8S-0007Ye-OJ; Tue, 21 Jul 2020 16:28:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 23/24] init: add an init_mknod helper
Date:   Tue, 21 Jul 2020 18:28:17 +0200
Message-Id: <20200721162818.197315-24-hch@lst.de>
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

Add a simple helper to mknod with a kernel space file name and switch
the early init code over to it.  Remove the now unused ksys_mknod.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 --
 fs/namei.c               |  2 +-
 include/linux/syscalls.h |  9 ---------
 init/do_mounts.h         |  3 ++-
 init/fs.c                | 25 +++++++++++++++++++++++++
 init/initramfs.c         |  2 +-
 init/noinitramfs.c       |  3 +--
 7 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 54cf897bd0c18f..490cf426ec9f67 100644
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
index 62ae09b96be025..a793bafc6c6f2b 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -16,6 +16,7 @@ int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
 int __init init_eaccess(const char *filename);
+int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init init_link(const char *oldname, const char *newname);
 int __init init_symlink(const char *oldname, const char *newname);
 int __init init_unlink(const char *pathname);
@@ -30,7 +31,7 @@ extern int root_mountflags;
 static inline __init int create_dev(char *name, dev_t dev)
 {
 	init_unlink(name);
-	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+	return init_mknod(name, S_IFBLK | 0600, new_encode_dev(dev));
 }
 
 #ifdef CONFIG_BLK_DEV_RAM
diff --git a/init/fs.c b/init/fs.c
index 0793a6872d0e33..7f0e50a877fc98 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -103,6 +103,31 @@ int __init init_eaccess(const char *filename)
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
+	dentry = user_path_create(AT_FDCWD, filename, &path, 0);
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
diff --git a/init/initramfs.c b/init/initramfs.c
index b1a0a1d5c3c135..bd685fdb5840f3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -359,7 +359,7 @@ static int __init do_name(void)
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-			ksys_mknod(collected, mode, rdev);
+			init_mknod(collected, mode, rdev);
 			init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 			init_chmod(collected, mode);
 			do_utime(collected, mtime);
diff --git a/init/noinitramfs.c b/init/noinitramfs.c
index b8bdba1c949cf9..490f2bd2b49979 100644
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

