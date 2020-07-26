Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E522DCB9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGZHOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGZHOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E905C0619D2;
        Sun, 26 Jul 2020 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Df5dZMTU9+WCW1z19se/DH86K1nN9sG//9vxNDEeelY=; b=muR3E+vJwAo0uK4S6UCKhI6Uia
        FcXYYghQiDVkffPtGBVVlTXkMjN/zJchkhNCsYXB2KBlHNmtVIgFeU+hDMFfpyyT61uGgjjFavwVp
        o00LJi5d/+c5sa3RPuQlTBiYDKJcEapXAFsiRwurNaqjQCznSegFgiIaoy4MbE+tnJkDnXScyHmG/
        lxqtqqX6Q4u22JbMHPQODlhZVKYO20fRhUviurpd82TMCyGRZwabXo7jSv+KuwtHgKlWtbiBKnMO5
        rJDc3QEWrwe5j3xVxFe1awCAoQQAGESQ0ponFGIWm77+TSi8ubfLz0jAskN2BQ47/x+260nXTRcKP
        ORe363Eg==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarZ-0002Tz-Vy; Sun, 26 Jul 2020 07:14:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 13/21] init: add an init_chown helper
Date:   Sun, 26 Jul 2020 09:13:48 +0200
Message-Id: <20200726071356.287160-14-hch@lst.de>
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

Add a simple helper to chown with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/for_init.c                 | 18 ++++++++++++++++++
 fs/internal.h                 |  2 +-
 fs/open.c                     |  2 +-
 include/linux/init_syscalls.h |  1 +
 init/initramfs.c              |  6 +++---
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index 2d5428b7dc1420..0541851d86f42e 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -74,6 +74,24 @@ int __init init_chroot(const char *filename)
 	return error;
 }
 
+int __init init_chown(const char *filename, uid_t user, gid_t group, int flags)
+{
+	int lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	struct path path;
+	int error;
+
+	error = kern_path(filename, lookup_flags, &path);
+	if (error)
+		return error;
+	error = mnt_want_write(path.mnt);
+	if (!error) {
+		error = chown_common(&path, user, group);
+		mnt_drop_write(path.mnt);
+	}
+	path_put(&path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/fs/internal.h b/fs/internal.h
index 491d1e63809b37..e81b9e23c3ea3f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -134,7 +134,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		int flag);
-
+int chown_common(const struct path *path, uid_t user, gid_t group);
 extern int vfs_open(const struct path *, struct file *);
 
 /*
diff --git a/fs/open.c b/fs/open.c
index f62f4752bb436d..49960a1248f14b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -639,7 +639,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-static int chown_common(const struct path *path, uid_t user, gid_t group)
+int chown_common(const struct path *path, uid_t user, gid_t group)
 {
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index e07099a14b91db..0da59d76133e17 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -5,5 +5,6 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 int __init init_umount(const char *name, int flags);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
+int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
diff --git a/init/initramfs.c b/init/initramfs.c
index 1ceba88cfcc052..919b40fb07bada 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -346,14 +346,14 @@ static int __init do_name(void)
 		}
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
-		ksys_chown(collected, uid, gid);
+		init_chown(collected, uid, gid, 0);
 		ksys_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
-			ksys_chown(collected, uid, gid);
+			init_chown(collected, uid, gid, 0);
 			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
@@ -391,7 +391,7 @@ static int __init do_symlink(void)
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
-	ksys_lchown(collected, uid, gid);
+	init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(collected, mtime);
 	state = SkipIt;
 	next_state = Reset;
-- 
2.27.0

