Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947D230FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgG1Qew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgG1Qeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1753DC061794;
        Tue, 28 Jul 2020 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U6/jNKrxAUIjzQ18kwUZySI+bueeC5+chL9pO9InTCg=; b=jNuHn6EW67qenzbx2RviE1Lh+R
        w369i05ZeMR5zgBppkJJuPGHwLtd1wmqu/UUkvm3HvpuPKXqb5oVyuO/lO19VSxI5s2FH3LlpZFz4
        JdK6wffIbRHJILl2fWrVKGoiS9Pf0WRJ8auweugKcgXPel1kj39QlPWSh6xY0H5gfrZHqZh0CityY
        tgqkd/cPG+5tuugTkOqjm4m2I5hUTZfYi8cqNT/EEuQHqzHlsn4u7zbCNZUxD4ZH7A0kIOt0Afpmn
        ddO/m8q9I31AjNGFsyJ/8q28gPT16W9jpUvCwsyK8DC9W4SI2XfbFtejyAtRt3CN00iBeB7zrmUUb
        iz+nI5cw==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYu-00071A-1t; Tue, 28 Jul 2020 16:34:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 14/23] init: add an init_chown helper
Date:   Tue, 28 Jul 2020 18:34:07 +0200
Message-Id: <20200728163416.556521-15-hch@lst.de>
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

Add a simple helper to chown with a kernel space file name and switch
the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 18 ++++++++++++++++++
 fs/internal.h                 |  2 +-
 fs/open.c                     |  2 +-
 include/linux/init_syscalls.h |  1 +
 init/initramfs.c              |  6 +++---
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 2c78f24814dde4..edd0244655956e 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -78,6 +78,24 @@ int __init init_chroot(const char *filename)
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
index fb7210731d9e5d..24a8dcc6734064 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -349,14 +349,14 @@ static int __init do_name(void)
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
@@ -394,7 +394,7 @@ static int __init do_symlink(void)
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

