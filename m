Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F46622699F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgGTQ1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbgGTP7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFCC061794;
        Mon, 20 Jul 2020 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nAsH9T7X6ZSD60FzUE1BgNEp8/8aowZX5wNUHqsAE74=; b=pwBZBTeu9/U/FLHwWp5Pw3z4+H
        pjonpatQSpbmN1/1ip4ARtplkErkRto1D/zkxaxUXlzwtGOxqa5eBYCuoUhExQ87qadoRoDF/fqx2
        H+yEVdJ0ths3Q30EM7TfLk6/K6h5dmO32XS1aRBtC2ZPDUxov+JjTTXiqJHk0WYEmzcwqG+Nh7kNs
        mwzHoT/XMoQqP6Wy5y1mb7zxBFIK0kmLKiR2+j2hkroNCuxYpuvTYYK097xFwPgpiNiQnCetG77qC
        czmUVTQxgIEcsbreDEJGRF9h1JwwRc5mpdnTqxyrQqCQNBr97wMJzhAadSlai96O6IWy1491AX4H3
        KW6eVRxA==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCQ-0007qS-Ah; Mon, 20 Jul 2020 15:59:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 15/24] fs: add a kern_link helper
Date:   Mon, 20 Jul 2020 17:58:53 +0200
Message-Id: <20200720155902.181712-16-hch@lst.de>
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

Add a simple helper perform a link with a kernel space file name and use
it in the early init code instead of relying on the implicit
set_fs(KERNEL_DS) there.  To do so push the getname from do_linkat into the
callers.  Remove the now unused ksys_link.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h            |  2 --
 fs/namei.c               | 39 +++++++++++++++++++++++++++++----------
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h |  9 ---------
 init/initramfs.c         |  2 +-
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 1e7a72bd183e63..f0869d5dc4dbfa 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -66,8 +66,6 @@ long do_rmdir(int dfd, const char __user *pathname);
 long do_unlinkat(int dfd, struct filename *name);
 long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname);
-int do_linkat(int olddfd, const char __user *oldname, int newdfd,
-	      const char __user *newname, int flags);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index de97edac21849d..9d80a5bce1051a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4122,8 +4122,8 @@ EXPORT_SYMBOL(vfs_link);
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-int do_linkat(int olddfd, const char __user *oldname, int newdfd,
-	      const char __user *newname, int flags)
+static int do_linkat(int olddfd, struct filename *oldname, int newdfd,
+	      struct filename *newname, int flags)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
@@ -4131,27 +4131,29 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	int how = 0;
 	int error;
 
+	error = -EINVAL;
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
-		return -EINVAL;
+		goto out_put_both_names;
 	/*
 	 * To use null names we require CAP_DAC_READ_SEARCH
 	 * This ensures that not everyone will be able to create
 	 * handlink using the passed filedescriptor.
 	 */
 	if (flags & AT_EMPTY_PATH) {
+		error = -ENOENT;
 		if (!capable(CAP_DAC_READ_SEARCH))
-			return -ENOENT;
+			goto out_put_both_names;
 		how = LOOKUP_EMPTY;
 	}
 
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
 retry:
-	error = user_path_at(olddfd, oldname, how, &old_path);
+	error = filename_lookup(olddfd, oldname, how, &old_path, NULL);
 	if (error)
-		return error;
+		goto out_put_newname;
 
-	new_dentry = user_path_create(newdfd, newname, &new_path,
+	new_dentry = filename_create(newdfd, newname, &new_path,
 					(how & LOOKUP_REVAL));
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
@@ -4181,21 +4183,38 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 		how |= LOOKUP_REVAL;
 		goto retry;
 	}
+	putname(newname);
 out:
 	path_put(&old_path);
-
+	putname(oldname);
+	return error;
+out_put_both_names:
+	if (!IS_ERR(oldname))
+		putname(oldname);
+out_put_newname:
+	if (!IS_ERR(newname))
+		putname(newname);
 	return error;
 }
 
+int __init kern_link(const char *oldname, const char *newname)
+{
+	return do_linkat(AT_FDCWD, getname_kernel(oldname), AT_FDCWD,
+			 getname_kernel(newname), 0);
+}
+
 SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname, int, flags)
 {
-	return do_linkat(olddfd, oldname, newdfd, newname, flags);
+	int how = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+
+	return do_linkat(olddfd, getname_flags(oldname, how, NULL), newdfd,
+			 getname(newname), flags);
 }
 
 SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
 {
-	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+	return do_linkat(AT_FDCWD, getname(oldname), AT_FDCWD, getname(newname), 0);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 846a21a9b3e14c..fc3b09d473945f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3679,5 +3679,6 @@ int __init kern_chmod(const char *filename, umode_t mode);
 int __init kern_utimes(const char *filename, struct timespec64 *tv, int flags);
 int kern_mkdir(const char *pathname, umode_t mode);
 int kern_mknod(const char *filename, umode_t mode, unsigned int dev);
+int __init kern_link(const char *oldname, const char *newname);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 3dfcae351a077d..467cc4413874ed 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1293,15 +1293,6 @@ static inline long ksys_symlink(const char __user *oldname,
 	return do_symlinkat(oldname, AT_FDCWD, newname);
 }
 
-extern int do_linkat(int olddfd, const char __user *oldname, int newdfd,
-		     const char __user *newname, int flags);
-
-static inline long ksys_link(const char __user *oldname,
-			     const char __user *newname)
-{
-	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
-}
-
 extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 
 static inline long ksys_ftruncate(unsigned int fd, loff_t length)
diff --git a/init/initramfs.c b/init/initramfs.c
index f32226d0388100..e484381c6c131b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -310,7 +310,7 @@ static int __init maybe_link(void)
 		char *old = find_link(major, minor, ino, mode, collected);
 		if (old) {
 			clean_path(collected, 0);
-			return (ksys_link(old, collected) < 0) ? -1 : 1;
+			return (kern_link(old, collected) < 0) ? -1 : 1;
 		}
 	}
 	return 0;
-- 
2.27.0

