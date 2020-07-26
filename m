Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6988E22DCBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGZHOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZHOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E802C0619D4;
        Sun, 26 Jul 2020 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F9Hy9koauyW6Xg8otzwajT43N/kQBbpM16WsbmLZL54=; b=i0ov+Gh0GkxuU1/bB8O20p0unt
        lwwjxxjKVTrX9BWHBaMNcwFVK19Jr0r4HaMHeIR1lYTJzc6vhKmcPJFDk6e/twN0PSVzvauDUTHv9
        WzPI1K1JeYcfYDsRLJ2vn7nOYxo8bGSC7xInoHrZ0ViYQljCM/qj6EXCC/lO8UD5NHo09MxTsFdGE
        wJr+tDSh3N1MMBxxW1JF+0aXSmdkVbCdJFhzoID9Qn+jOu6ysmroneUgSIOS51sWhimmd7tYmgcDL
        wP+eaTkMF8x4z/P26+MlLbkQ8NoHbAKg4UyKbQkv8IdxXwo22AZKOAJUaz9ZPG7QRgOzHcxSLxsnw
        Xs0iLEQw==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarc-0002UV-DL; Sun, 26 Jul 2020 07:14:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 14/21] init: add an init_chmod helper
Date:   Sun, 26 Jul 2020 09:13:49 +0200
Message-Id: <20200726071356.287160-15-hch@lst.de>
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

Add a simple helper to chmod with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/for_init.c                 | 13 +++++++++++++
 fs/internal.h                 |  2 +-
 fs/open.c                     |  4 ++--
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  7 -------
 init/initramfs.c              |  4 ++--
 6 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index 0541851d86f42e..098e9b69c32ef6 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -92,6 +92,19 @@ int __init init_chown(const char *filename, uid_t user, gid_t group, int flags)
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
diff --git a/fs/internal.h b/fs/internal.h
index e81b9e23c3ea3f..6d82681c7d8372 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -131,7 +131,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
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
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 0da59d76133e17..2b1b4dc586825f 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -6,5 +6,6 @@ int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
+int __init init_chmod(const char *filename, umode_t mode);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
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
diff --git a/init/initramfs.c b/init/initramfs.c
index 919b40fb07bada..f2ec2f024f9e67 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -347,14 +347,14 @@ static int __init do_name(void)
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
 			init_chown(collected, uid, gid, 0);
-			ksys_chmod(collected, mode);
+			init_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
 	}
-- 
2.27.0

