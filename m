Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A53226933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgGTP7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgGTP7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456FC0619D2;
        Mon, 20 Jul 2020 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=21w+ZovXtzUYFHjW7zAcq/SvhfaPcQNA2bBLjzfA85I=; b=u/gfBau8lfBl8lCv/Gjz5NsubZ
        w76/+yxGcjwLvwMSvoOVhBh357tz0mSTy69IR9y8hDVWFW/VNrIddpJx7RF/2fl0YDli5vygc3D3I
        6Uv7PzkrJvlSKg1P928YG718uNYPTBiJ4rGfGxgd+ZgIypimlndFBFETTjU8VD9QLoB2aIq8cpQJe
        jfSFW4o73TyyRghGylTJKHYNUQwqkQfWAV/NdI4TOEIIYgoSzib0yCH2mOc6FsyfHl2Cn6DlS7st7
        EKqLf7SWQx4XotdhdHsIFPk9kpmozwvQPuymN7USpIXdOEGw8DXMecs6eD9FKIGiJso2ObI/JZhOG
        q7Pda19g==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCB-0007oM-UG; Mon, 20 Jul 2020 15:59:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 08/24] fs: add a kern_access helper
Date:   Mon, 20 Jul 2020 17:58:46 +0200
Message-Id: <20200720155902.181712-9-hch@lst.de>
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

Add a simple helper for a access with a kernelspace name and use it in
the early init code instead of relying on the implicit set_fs(KERNEL_DS)
there.  Remove the now unused ksys_access.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                | 37 +++++++++++++++++++++++++------------
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h |  7 -------
 init/main.c              |  3 +--
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 424db905da5f18..2a9457a16b2be2 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -394,19 +394,19 @@ static const struct cred *access_override_creds(void)
 	return old_cred;
 }
 
-long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
+static int do_faccessat(int dfd, struct filename *name, int mode, int flags)
 {
 	struct path path;
 	struct inode *inode;
-	int res;
+	int res = -EINVAL;
 	unsigned int lookup_flags = LOOKUP_FOLLOW;
 	const struct cred *old_cred = NULL;
 
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
-		return -EINVAL;
+		goto out_putname;
 
 	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
-		return -EINVAL;
+		goto out_putname;
 
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		lookup_flags &= ~LOOKUP_FOLLOW;
@@ -414,15 +414,16 @@ long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 		lookup_flags |= LOOKUP_EMPTY;
 
 	if (!(flags & AT_EACCESS)) {
+		res = -ENOMEM;
 		old_cred = access_override_creds();
 		if (!old_cred)
-			return -ENOMEM;
+			goto out_putname;
 	}
 
 retry:
-	res = user_path_at(dfd, filename, lookup_flags, &path);
+	res = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (res)
-		goto out;
+		goto out_revert_creds;
 
 	inode = d_backing_inode(path.dentry);
 
@@ -459,27 +460,39 @@ long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
+	putname(name);
+out_revert_creds:
 	if (old_cred)
 		revert_creds(old_cred);
-
 	return res;
+out_putname:
+	if (!IS_ERR(name))
+		putname(name);
+	return res;
+}
+
+int __init kern_access(const char __user *filename, int mode)
+{
+	return do_faccessat(AT_FDCWD, getname_kernel(filename), mode, 0);
 }
 
 SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 {
-	return do_faccessat(dfd, filename, mode, 0);
+	return do_faccessat(dfd, getname(filename), mode, 0);
 }
 
 SYSCALL_DEFINE4(faccessat2, int, dfd, const char __user *, filename, int, mode,
 		int, flags)
 {
-	return do_faccessat(dfd, filename, mode, flags);
+	unsigned int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	struct filename *name = getname_flags(filename, lookup_flags, NULL);
+
+	return do_faccessat(dfd, name, mode, flags);
 }
 
 SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 {
-	return do_faccessat(AT_FDCWD, filename, mode, 0);
+	return do_faccessat(AT_FDCWD, getname(filename), mode, 0);
 }
 
 static int do_chdir(struct filename *name)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0205355bffb1bc..0c7672d3f1172f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3673,5 +3673,6 @@ static inline int inode_drain_writes(struct inode *inode)
 
 int kern_chdir(const char *filename);
 int kern_chroot(const char *filename);
+int __init kern_access(const char *filename, int mode);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a3176d1a521467..b387e3700c68c5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1326,13 +1326,6 @@ static inline int ksys_chmod(const char __user *filename, umode_t mode)
 	return do_fchmodat(AT_FDCWD, filename, mode);
 }
 
-long do_faccessat(int dfd, const char __user *filename, int mode, int flags);
-
-static inline long ksys_access(const char __user *filename, int mode)
-{
-	return do_faccessat(AT_FDCWD, filename, mode, 0);
-}
-
 extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
 		       gid_t group, int flag);
 
diff --git a/init/main.c b/init/main.c
index c2c9143db96795..880f195b61abe1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1514,8 +1514,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (ksys_access((const char __user *)
-			ramdisk_execute_command, 0) != 0) {
+	if (kern_access(ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.27.0

