Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866232269B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgGTQ2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgGTP7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AEC061794;
        Mon, 20 Jul 2020 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=y1dPItBmZKcvSo985WsMlTxvtNzxD63bJREW0GA5b/M=; b=e433WSzzwsp/Kfz0ckwD1yJy3J
        +jQNrQ8OKYZXYltBtzntPs+h+aDDTsYbuMbGDCnWE43JVIgVMANJxmcVnPVp86u1u2LHU9QpBUK04
        7otT0hLWG+qjO80neJwzJbioRxOswOlX7hLsaRK7jM4QD6d8EviAlRPrJKElP+N2jWlotZWft9MBk
        VQA4wqQ5UJNlR3p1Tmn1TuGe6XlFBpUDfOdj5THGv4DEjapg19WyA+Y2CeWWvVm0x00vwkds4yavp
        nE4ps1PRc9WdgDKp96bSEZCgxUAgGCBgW2CwmYI65RRF/y6PH5rVYRd75f2OJ8GYnLmiO207rdsB3
        EdUrZZHg==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCG-0007ok-4t; Mon, 20 Jul 2020 15:59:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 10/24] fs: move the uid16 (f)chown syscalls to fs/open.c
Date:   Mon, 20 Jul 2020 17:58:48 +0200
Message-Id: <20200720155902.181712-11-hch@lst.de>
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

This allows to keep the internal (f)chown helper private in open.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 25 ++++++++++++++++++++++---
 include/linux/syscalls.h |  4 ----
 kernel/uid16.c           | 17 -----------------
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 7d7456070503f2..8157db254c8f8a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -714,7 +714,7 @@ static int chown_common(const struct path *path, uid_t user, gid_t group)
 	return error;
 }
 
-int do_fchownat(int dfd, struct filename *name, uid_t user, gid_t group,
+static int do_fchownat(int dfd, struct filename *name, uid_t user, gid_t group,
 		int flag)
 {
 	struct path path;
@@ -787,7 +787,7 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group)
 	return error;
 }
 
-int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
+static int do_fchown(unsigned int fd, uid_t user, gid_t group)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
@@ -801,9 +801,28 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 
 SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 {
-	return ksys_fchown(fd, user, group);
+	return do_fchown(fd, user, group);
 }
 
+#ifdef CONFIG_UID16
+SYSCALL_DEFINE3(chown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
+{
+	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
+			low2highgid(group), 0);
+}
+
+SYSCALL_DEFINE3(lchown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
+{
+	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
+			low2highgid(group), AT_SYMLINK_NOFOLLOW);
+}
+
+SYSCALL_DEFINE3(fchown16, unsigned int, fd, old_uid_t, user, old_gid_t, group)
+{
+	return do_fchown(fd, low2highuid(user), low2highgid(group));
+}
+#endif /* CONFIG_UID16 */
+
 static int do_dentry_open(struct file *f,
 			  struct inode *inode,
 			  int (*open)(struct inode *, struct file *))
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 42dd2715e07688..82346a68a73877 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1237,7 +1237,6 @@ asmlinkage long sys_ni_syscall(void);
  */
 
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
-int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
@@ -1326,9 +1325,6 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-extern int do_fchownat(int dfd, struct filename *name, uid_t user,
-		       gid_t group, int flag);
-
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
diff --git a/kernel/uid16.c b/kernel/uid16.c
index a332947e92d12e..ec2a5634e99af6 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -20,23 +20,6 @@
 
 #include "uid16.h"
 
-SYSCALL_DEFINE3(chown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
-{
-	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
-			low2highgid(group), 0);
-}
-
-SYSCALL_DEFINE3(lchown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
-{
-	return do_fchownat(AT_FDCWD, getname(filename), low2highuid(user),
-			low2highgid(group), AT_SYMLINK_NOFOLLOW);
-}
-
-SYSCALL_DEFINE3(fchown16, unsigned int, fd, old_uid_t, user, old_gid_t, group)
-{
-	return ksys_fchown(fd, low2highuid(user), low2highgid(group));
-}
-
 SYSCALL_DEFINE2(setregid16, old_gid_t, rgid, old_gid_t, egid)
 {
 	return __sys_setregid(low2highgid(rgid), low2highgid(egid));
-- 
2.27.0

