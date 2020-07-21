Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C522856D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgGUQ3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgGUQ2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00581C061794;
        Tue, 21 Jul 2020 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TSrX/2/LmPlcW4m7BclnQVx8pIIkFF094bAK/ioj+Is=; b=GxGySKuu2GFS8iwrrcqLGLnY/V
        spSEUqBr/dJPTXOHYGplyDszIPvIrslaOpQFBMb6PVxCYXGDCWKvBmzJkTHNP/uWEqYJKsnp5jmUS
        JSSfVHv4koTabKsBQ9Qct0ZrNugVxj4SgG915ErhdEqEomem+WwymohH46ju7pP4qZ/37GsW5BE74
        D8MZZ64eMRVPW0FSdcWydq8XsSw7arZuny9MkRUk+qucBtI2a4oa0Wry91fz0ps0HqmZ0+ZP26K7j
        T0b89wwMyMaOSn4ydP/NaT7jFCsV889vEeFNkRk7kXmyHUr3DO8lgUPCd1eylfBfd/jm/Xb1x9O+c
        iHPbXB5A==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv8M-0007Wq-8l; Tue, 21 Jul 2020 16:28:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 19/24] init: add an init_eaccess helper
Date:   Tue, 21 Jul 2020 18:28:13 +0200
Message-Id: <20200721162818.197315-20-hch@lst.de>
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

Add a simple helper to check if a file exists based on kernel space file
name and switch the early init code over to it.  Note that this
theoretically changes behavior as it always is based on the effective
permissions.  But during early init that doesn't make a difference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/open.c                |  2 +-
 include/linux/syscalls.h |  7 -------
 init/do_mounts.h         |  1 +
 init/fs.c                | 13 +++++++++++++
 init/main.c              |  3 +--
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 7ba89eae46c560..aafecd1f7ba1a5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -394,7 +394,7 @@ static const struct cred *access_override_creds(void)
 	return old_cred;
 }
 
-long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
+static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 {
 	struct path path;
 	struct inode *inode;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8b71fa321ca20c..a2779638e41445 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1304,13 +1304,6 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
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
 
diff --git a/init/do_mounts.h b/init/do_mounts.h
index b323d9755d7e5e..b886aaa0d09716 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -15,6 +15,7 @@ int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
+int __init init_eaccess(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
 
diff --git a/init/fs.c b/init/fs.c
index c636f25c9a6d69..9929cdd19affbe 100644
--- a/init/fs.c
+++ b/init/fs.c
@@ -90,6 +90,19 @@ int __init init_chmod(const char *filename, umode_t mode)
 	return error;
 }
 
+int __init init_eaccess(const char *filename)
+{
+	struct path path;
+	int error;
+
+	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	if (error)
+		return error;
+	error = inode_permission(d_inode(path.dentry), MAY_ACCESS);
+	path_put(&path);
+	return error;
+}
+
 int __init init_unlink(const char *pathname)
 {
 	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
diff --git a/init/main.c b/init/main.c
index b952e4cd685af4..227e206b9ffee2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1516,8 +1516,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (ksys_access((const char __user *)
-			ramdisk_execute_command, 0) != 0) {
+	if (init_eaccess(ramdisk_execute_command) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.27.0

