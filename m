Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBEB2269BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbgGTQ3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbgGTP7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2111C061794;
        Mon, 20 Jul 2020 08:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6G9nY4eSC9xSGsf15DzhzTkdCjVU0H1/v7EwBq5HHsM=; b=psAR+SvePzTC3oMmD8sNc8v4sT
        RzluB0XH8DVjeqRoFEmJDFPO7DEskn9gYBX0j5shToxPH4zv/+cU9JX6I/6fpnRUtlO3Wt7JGOWOP
        WoeZ1xRQSuTBHIP/xU97IIPAnANsi50x+iW6CoOZKEopsLEPYlgJ1AeYBvVIll0lN5CgwDFs+oI26
        sAcp2xMdEJfa01HUayr6Dr83KhEqWRk2AGsdOg1V8rrhgqikvyigT/pQiyDnlzFojdR5Q9zeNUr0G
        vYmJUN8n9Cx9J5KyQKSvPHDoIjZ+Y+iQeGc1M9ed++birhcJF47R7ozBtEiZUvbMTU9IEtShZr5xv
        tyyQd1gg==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCD-0007oU-73; Mon, 20 Jul 2020 15:59:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 09/24] fs: add a kern_chown helper
Date:   Mon, 20 Jul 2020 17:58:47 +0200
Message-Id: <20200720155902.181712-10-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple helper to chown with a kernel space name and use it in the
early init code instead of relying on the implicit set_fs(KERNEL_DS)
there.  Remove ksys_chown after switching all users to call do_fchownat
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 --
 fs/open.c                | 31 +++++++++++++++++++++----------
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h | 15 +--------------
 init/initramfs.c         |  6 +++---
 kernel/uid16.c           |  6 ++++--
 6 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9b863a7bd70892..ad62729e7ae587 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -127,8 +127,6 @@ extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
-int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
-		int flag);
 
 extern int vfs_open(const struct path *, struct file *);
 
diff --git a/fs/open.c b/fs/open.c
index 2a9457a16b2be2..7d7456070503f2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -714,23 +714,23 @@ static int chown_common(const struct path *path, uid_t user, gid_t group)
 	return error;
 }
 
-int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
+int do_fchownat(int dfd, struct filename *name, uid_t user, gid_t group,
 		int flag)
 {
 	struct path path;
-	int error = -EINVAL;
-	int lookup_flags;
+	int lookup_flags, error;
 
+	error = -EINVAL;
 	if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
-		goto out;
+		goto out_putname;
 
 	lookup_flags = (flag & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
 	if (flag & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 retry:
-	error = user_path_at(dfd, filename, lookup_flags, &path);
+	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
-		goto out;
+		return error;
 	error = mnt_want_write(path.mnt);
 	if (error)
 		goto out_release;
@@ -742,24 +742,35 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
+out_putname:
+	if (!IS_ERR(name))
+		putname(name);
 	return error;
 }
 
+int __init kern_chown(const char *filename, uid_t user, gid_t group, int flag)
+{
+	return do_fchownat(AT_FDCWD, getname_kernel(filename), user, group,
+			flag);
+}
+
 SYSCALL_DEFINE5(fchownat, int, dfd, const char __user *, filename, uid_t, user,
 		gid_t, group, int, flag)
 {
-	return do_fchownat(dfd, filename, user, group, flag);
+	int lookup_flags = (flag & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
+
+	return do_fchownat(dfd, name, user, group, flag);
 }
 
 SYSCALL_DEFINE3(chown, const char __user *, filename, uid_t, user, gid_t, group)
 {
-	return do_fchownat(AT_FDCWD, filename, user, group, 0);
+	return do_fchownat(AT_FDCWD, getname(filename), user, group, 0);
 }
 
 SYSCALL_DEFINE3(lchown, const char __user *, filename, uid_t, user, gid_t, group)
 {
-	return do_fchownat(AT_FDCWD, filename, user, group,
+	return do_fchownat(AT_FDCWD, getname(filename), user, group,
 			   AT_SYMLINK_NOFOLLOW);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0c7672d3f1172f..75d6ef7e1de52b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3674,5 +3674,6 @@ static inline int inode_drain_writes(struct inode *inode)
 int kern_chdir(const char *filename);
 int kern_chroot(const char *filename);
 int __init kern_access(const char *filename, int mode);
+int __init kern_chown(const char *filename, uid_t user, gid_t group, int flag);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b387e3700c68c5..42dd2715e07688 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1326,22 +1326,9 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
+extern int do_fchownat(int dfd, struct filename *name, uid_t user,
 		       gid_t group, int flag);
 
-static inline long ksys_chown(const char __user *filename, uid_t user,
-			      gid_t group)
-{
-	return do_fchownat(AT_FDCWD, filename, user, group, 0);
-}
-
-static inline long ksys_lchown(const char __user *filename, uid_t user,
-			       gid_t group)
-{
-	return do_fchownat(AT_FDCWD, filename, user, group,
-			     AT_SYMLINK_NOFOLLOW);
-}
-
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
diff --git a/init/initramfs.c b/init/initramfs.c
index 3823d15e5d2619..45e4ddb63caba1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -345,14 +345,14 @@ static int __init do_name(void)
 		}
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
-		ksys_chown(collected, uid, gid);
+		kern_chown(collected, uid, gid, 0);
 		ksys_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
-			ksys_chown(collected, uid, gid);
+			kern_chown(collected, uid, gid, 0);
 			ksys_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
@@ -390,7 +390,7 @@ static int __init do_symlink(void)
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
-	ksys_lchown(collected, uid, gid);
+	kern_chown(collected, uid, gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(collected, mtime);
 	state = SkipIt;
 	next_state = Reset;
diff --git a/kernel/uid16.c b/kernel/uid16.c
index af6925d8599b9b..a332947e92d12e 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -22,12 +22,14 @@
 
 SYSCALL_DEFINE3(chown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
 {
-	return ksys_chown(filename, low2highuid(user), low2highgid(group));
+	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
+			low2highgid(group), 0);
 }
 
 SYSCALL_DEFINE3(lchown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
 {
-	return ksys_lchown(filename, low2highuid(user), low2highgid(group));
+	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
+			low2highgid(group), AT_SYMLINK_NOFOLLOW);
 }
 
 SYSCALL_DEFINE3(fchown16, unsigned int, fd, old_uid_t, user, old_gid_t, group)
-- 
2.27.0

