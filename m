Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E01228587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgGUQ3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbgGUQ2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA443C0619DA;
        Tue, 21 Jul 2020 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3tnQJ2SyV577nhDNWivl/uepM3k+S5Rq8YsTJaQnWS4=; b=hGpeFup3HRIsYBOYxNG3aCmdCv
        5ozOu8laUO//TedEvwk6kSIhwop86R+2XOqmiQYXCx3Abv7wMjaQSccna8QDOqQg22zhzhu9eDlpe
        rY1XcucBmQt5BQfZ1qdZqy9IVM6AH/MCePbKAP/XLUY2/GRnpy7ihGxZGTgLW405RnqRN0izeB690
        5ItUPjFJY9FxeaQOpJkQvEbjQrEO5t8NmDCAO5sVU5q7wfWCXXl4d2X0oE9O/IU9ZeTeR19tZqWS9
        LMEfia9P1iaqz0OtBzI7qQvwp5EKJCxDgBm6MqQxuCOSqU7WFq8iuydnwSR4qy0pXNwRB5L08k0GF
        WTWYoDDQ==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8I-0007W3-R6; Tue, 21 Jul 2020 16:28:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 17/24] init: add an init_chown helper
Date:   Tue, 21 Jul 2020 18:28:11 +0200
Message-Id: <20200721162818.197315-18-hch@lst.de>
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

Add a simple helper to chown with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h    |  2 +-
 fs/open.c        |  2 +-
 init/do_mounts.h |  1 +
 init/fs.c        | 18 ++++++++++++++++++
 init/initramfs.c |  6 +++---
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e903d5aae139a2..4a66730fabefa7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -129,7 +129,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
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
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 810b37ce1db882..db42564080a2f9 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -13,6 +13,7 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
 int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
+int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/fs.c b/init/fs.c
index af55e6d40357dc..30000b7097b9f0 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -59,6 +59,24 @@ int __init init_chroot(const char *filename)
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
diff --git a/init/initramfs.c b/init/initramfs.c
index 41491149fb1f29..076413dbe8bcf3 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -353,14 +353,14 @@ static int __init do_name(void)
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
+			init_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
@@ -398,7 +398,7 @@ static int __init do_symlink(void)
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

