Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4F226949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgGTP7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgGTP7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94334C0619D2;
        Mon, 20 Jul 2020 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=10VRYCf+X0T5z2Mm4tKRRm7BN7GX5B7QP0oqeGQ3VHk=; b=N32TaqnPGTYyL3tptrjXUcK4Bw
        u/x5h3vZxh5F/yaK3rJqefBmJZFOuuge05j+epNumOLaZ5Y4C8jvnzqD7JU5Mr2mJwWrfHJzkaSuf
        Kw75ktWVqKaEm39YW60rAlh3DFTh6jNnxzCmU29TPejKqZ3wWXuZ/Irr7BMEJ2mc+n4A4wMHyfndn
        8BmIARbKLdvpSSHv+yyo8VyXga2KAjo7VcAsQMLuoMni3ZpTseyGg4VZVKXy9Cz5qYZUNRbG/u9Va
        zehOBMnUsGipesKDsl8DW/vdCHizUr483W3eHI6wOQN1mhGXt+go0gUW0HuDyqpXXFttPUKRwBgPE
        KawhYODg==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCf-0007sO-3P; Mon, 20 Jul 2020 15:59:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 24/24] fs: add a kern_stat helper
Date:   Mon, 20 Jul 2020 17:59:02 +0200
Message-Id: <20200720155902.181712-25-hch@lst.de>
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

Add a simple helper to stat/lstat with a kernel space file name and
switch the early init code over to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-autodetect.c |  2 +-
 fs/stat.c                  | 32 ++++++++++++++++++++++----------
 include/linux/fs.h         |  1 +
 init/initramfs.c           |  3 ++-
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 14b6e86814c061..5bd52ec05ed821 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -151,7 +151,7 @@ static void __init md_setup_drive(struct md_setup_args *args)
 		if (strncmp(devname, "/dev/", 5) == 0)
 			devname += 5;
 		snprintf(comp_name, 63, "/dev/%s", devname);
-		if (vfs_stat(comp_name, &stat) == 0 && S_ISBLK(stat.mode))
+		if (kern_stat(comp_name, &stat, 0) == 0 && S_ISBLK(stat.mode))
 			dev = new_decode_dev(stat.rdev);
 		if (!dev) {
 			pr_warn("md: Unknown device name: %s\n", devname);
diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e7967..3c976b92db00ca 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -151,7 +151,7 @@ int vfs_fstat(int fd, struct kstat *stat)
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
- * @filename: The name of the file of interest
+ * @name: The name of the file of interest
  * @flags: Flags to control the query
  * @stat: The result structure to fill in.
  * @request_mask: STATX_xxx flags indicating what the caller wants
@@ -163,16 +163,16 @@ int vfs_fstat(int fd, struct kstat *stat)
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-static int vfs_statx(int dfd, const char __user *filename, int flags,
+static int vfs_statx(int dfd, struct filename *name, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
 	unsigned lookup_flags = 0;
-	int error;
+	int error = -EINVAL;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
 		      AT_STATX_SYNC_TYPE))
-		return -EINVAL;
+		goto out_putname;
 
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
@@ -182,9 +182,9 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		lookup_flags |= LOOKUP_EMPTY;
 
 retry:
-	error = user_path_at(dfd, filename, lookup_flags, &path);
+	error = filename_lookup(dfd, name, lookup_flags, &path, NULL);
 	if (error)
-		goto out;
+		return error;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
@@ -197,15 +197,25 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
+out_putname:
+	if (!IS_ERR(name))
+		putname(name);
 	return error;
 }
 
+int __init kern_stat(const char *filename, struct kstat *stat, int flags)
+{
+	return vfs_statx(AT_FDCWD, getname_kernel(filename),
+			 flags | AT_NO_AUTOMOUNT, stat, STATX_BASIC_STATS);
+}
+
 int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+
+	return vfs_statx(dfd, getname_flags(filename, lookup_flags, NULL),
+			 flags | AT_NO_AUTOMOUNT, stat, STATX_BASIC_STATS);
 }
 
 #ifdef __ARCH_WANT_OLD_STAT
@@ -569,6 +579,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 int do_statx(int dfd, const char __user *filename, unsigned flags,
 	     unsigned int mask, struct statx __user *buffer)
 {
+	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
 	struct kstat stat;
 	int error;
 
@@ -577,7 +588,8 @@ int do_statx(int dfd, const char __user *filename, unsigned flags,
 	if ((flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
 		return -EINVAL;
 
-	error = vfs_statx(dfd, filename, flags, &stat, mask);
+	error = vfs_statx(dfd, getname_flags(filename, lookup_flags, NULL),
+			  flags, &stat, mask);
 	if (error)
 		return error;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0e0cd6a988bb38..d1f8edb39cf969 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3671,5 +3671,6 @@ int __init kern_link(const char *oldname, const char *newname);
 int __init kern_symlink(const char *oldname, const char *newname);
 int kern_unlink(const char *pathname);
 int __init kern_rmdir(const char *pathname);
+int __init kern_stat(const char *filename, struct kstat *stat, int flags);
 
 #endif /* _LINUX_FS_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index d72594298133a7..6c605f23900fa1 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -296,7 +296,8 @@ static void __init clean_path(char *path, umode_t fmode)
 {
 	struct kstat st;
 
-	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
+	if (kern_stat(path, &st, AT_SYMLINK_NOFOLLOW) &&
+	    (st.mode ^ fmode) & S_IFMT) {
 		if (S_ISDIR(st.mode))
 			kern_rmdir(path);
 		else
-- 
2.27.0

