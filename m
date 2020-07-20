Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A5226605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgGTP71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbgGTP70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28927C0619D2;
        Mon, 20 Jul 2020 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bGI5glpVTMc72nMQUnC3avSi0QQq30weE86MJk3nK0g=; b=SYJpGqrUt58eCrS0IaEaYMDVS0
        lklis6uXRVwpxvFybdtw2JUC4befQJwU7e4wYEC0A6g7ENd3H3VUJID9ax922VXQ2phps6cG6h358
        G9Nx0HLBrODAHg9VrEzILLzAUjKRIscL1JRezulezFAtg/GzYj0J7uJe2IvkcyhE6vqeQo73vnai6
        WR2DvOMZsmnx+p/bPTZQTekEt5ulmCay7JFBvoxgvjOn36K/X4FFDXXGm/zpXOypkhLuQHs3lyXfC
        P7B/jt759cfIW2WGP8X27F8BAvs0nKpEdiz3mfJekWNbSJVENE/tn/a6igvudUtnjQ6p2rpVDIJAb
        v/CxunmA==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCI-0007pA-Pv; Mon, 20 Jul 2020 15:59:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 11/24] fs: add a kern_chmod helper
Date:   Mon, 20 Jul 2020 17:58:49 +0200
Message-Id: <20200720155902.181712-12-hch@lst.de>
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
there.  Remove the now unused ksys_chmod.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  1 -
 fs/open.c                | 28 +++++++++++++++++-----------
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h |  7 -------
 init/initramfs.c         |  4 ++--
 5 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index ad62729e7ae587..1e2b425f56ee9e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -126,7 +126,6 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
 
 extern int vfs_open(const struct path *, struct file *);
 
diff --git a/fs/open.c b/fs/open.c
index 8157db254c8f8a..bb8ffc24c4b034 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -643,33 +643,39 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+static int do_fchmodat(int dfd, struct filename *name, umode_t mode)
 {
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 retry:
-	error = user_path_at(dfd, filename, lookup_flags, &path);
-	if (!error) {
-		error = chmod_common(&path, mode);
-		path_put(&path);
-		if (retry_estale(error, lookup_flags)) {
-			lookup_flags |= LOOKUP_REVAL;
-			goto retry;
-		}
+	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
+	if (error)
+		return error;
+	error = chmod_common(&path, mode);
+	path_put(&path);
+	if (retry_estale(error, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
 	}
+	putname(name);
 	return error;
 }
 
+int __init kern_chmod(const char *filename, umode_t mode)
+{
+	return do_fchmodat(AT_FDCWD, getname_kernel(filename), mode);
+}
+
 SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
 		umode_t, mode)
 {
-	return do_fchmodat(dfd, filename, mode);
+	return do_fchmodat(dfd, getname(filename), mode);
 }
 
 SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 {
-	return do_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat(AT_FDCWD, getname(filename), mode);
 }
 
 static int chown_common(const struct path *path, uid_t user, gid_t group)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 75d6ef7e1de52b..ca034126cb0e4d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3675,5 +3675,6 @@ int kern_chdir(const char *filename);
 int kern_chroot(const char *filename);
 int __init kern_access(const char *filename, int mode);
 int __init kern_chown(const char *filename, uid_t user, gid_t group, int flag);
+int __init kern_chmod(const char *filename, umode_t mode);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 82346a68a73877..a2ece4cc8692f5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1318,13 +1318,6 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
-extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
-
-static inline int ksys_chmod(const char __user *filename, umode_t mode)
-{
-	return do_fchmodat(AT_FDCWD, filename, mode);
-}
-
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
diff --git a/init/initramfs.c b/init/initramfs.c
index 45e4ddb63caba1..2c2d4480d495e8 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -346,14 +346,14 @@ static int __init do_name(void)
 	} else if (S_ISDIR(mode)) {
 		ksys_mkdir(collected, mode);
 		kern_chown(collected, uid, gid, 0);
-		ksys_chmod(collected, mode);
+		kern_chmod(collected, mode);
 		dir_add(collected, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
 			ksys_mknod(collected, mode, rdev);
 			kern_chown(collected, uid, gid, 0);
-			ksys_chmod(collected, mode);
+			kern_chmod(collected, mode);
 			do_utime(collected, mtime);
 		}
 	}
-- 
2.27.0

