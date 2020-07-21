Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C122857F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgGUQ3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgGUQ2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DCC061794;
        Tue, 21 Jul 2020 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gQeUtO8B95VDrknI0pRSG4zAnm6PRQY7ifzO2jwGB6M=; b=YEPhb6YHoeiYCsQ+wUd6MEXFbe
        Nx59O4xajSdw7fg07j4h+UG0mSCz14M638IinLS42knjTTW8SXYCN/StBvDORlN9M7RrE1JIJ6c7x
        iFRo7J6WB+Qbp+YawE/Au+r/meEm+eU+VQyDxH9NEJdgFJDkS264sqUbA+Yc2aOTlLIfnDxpOWoT0
        vYssmNNOGPq+Wru5rvQuVEU4S5JphYBvtei/2SshJekzxKPHofY9bRQk4bo0u+kbO7ncgUkgtMNX1
        DV8E2bvx3oFLMkT6MyTu3K5+JGD2msWzLVdGNu0b8YwbZROyvx8gGkXctDydcGdfo5g7RNP2IYXyM
        yiATifKg==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8K-0007WN-KX; Tue, 21 Jul 2020 16:28:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 18/24] init: add an init_chmod helper
Date:   Tue, 21 Jul 2020 18:28:12 +0200
Message-Id: <20200721162818.197315-19-hch@lst.de>
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

Add a simple helper to chmod with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 +-
 fs/open.c                |  4 ++--
 include/linux/syscalls.h |  7 -------
 init/do_mounts.h         |  1 +
 init/fs.c                | 13 +++++++++++++
 init/initramfs.c         |  4 ++--
 6 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 4a66730fabefa7..585968c0286cf7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -126,7 +126,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
 int chown_common(const struct path *path, uid_t user, gid_t group);
diff --git a/fs/open.c b/fs/open.c
index 49960a1248f14b..7ba89eae46c560 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -563,7 +563,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	return error;
 }
 
-static int chmod_common(const struct path *path, umode_t mode)
+int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
@@ -610,7 +610,7 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 {
 	struct path path;
 	int error;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e89d62e944dc0e..8b71fa321ca20c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1304,13 +1304,6 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
-extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
-
-static inline int ksys_chmod(const char __user *filename, umode_t mode)
-{
-	return do_fchmodat(AT_FDCWD, filename, mode);
-}
-
 long do_faccessat(int dfd, const char __user *filename, int mode, int flags);
 
 static inline long ksys_access(const char __user *filename, int mode)
diff --git a/init/do_mounts.h b/init/do_mounts.h
index db42564080a2f9..b323d9755d7e5e 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -14,6 +14,7 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
+int __init init_chmod(const char *filename, umode_t mode);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/fs.c b/init/fs.c
index 30000b7097b9f0..c636f25c9a6d69 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -77,6 +77,19 @@ int __init init_chown(const char *filename, uid_t user, gid_t group, int flags)
 	return error;
 }
 
+int __init init_chmod(const char *filename, umode_t mode)
+{
+	struct path path;
+	int error;
+
+	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	if (error)
+		return error;
+	error = chmod_common(&path, mode);
+	path_put(&path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/init/initramfs.c b/init/initramfs.c
index 076413dbe8bcf3..771da27e87afa1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -354,14 +354,14 @@ static int __init do_name(void)
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
 		init_chown(collected, uid, gid, 0);
-		ksys_chmod(collected, mode);
+		init_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
 			init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
-			ksys_chmod(collected, mode);
+			init_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
 	}
-- 
2.27.0

