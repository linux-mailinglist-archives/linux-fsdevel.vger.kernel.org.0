Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8022DCBF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGZHPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGZHOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF698C0619D2;
        Sun, 26 Jul 2020 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FLygEUX/lUPRtrxlATG8BWXr35TDNLqXYg82nNdiEGg=; b=uvtcnVif2od8np/uzR68B2QiJG
        G4mwDa3scaQoGnxeVvgsuJxKbDVpiWw/bJVoFcpiiJpFmzrsuW80TpYAXGjnBhIvKCJ5E5prKYWk3
        Mc+tA6dzImxamcC51IpB3uUH7+m9ij9TyQDMFZt17bpDNGavA1K/YJtWvRInxIwoaL4h9pzbMPRwl
        HUipeboomqA1IKpDidDiSD7FlgSBqN/jOtpuhTn2wRCi8Wpl3me0Qw32kbLckHKbG/9KpM7HNEG1w
        pwGH0wAAQcvbsurqB8NXrYVbOB5q1Udu6378zBewC90OJtwLYDV3Z0L3l+pfCo4BXPrhmo6z15dC0
        7n+esxJw==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarf-0002Un-2b; Sun, 26 Jul 2020 07:14:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 15/21] init: add an init_eaccess helper
Date:   Sun, 26 Jul 2020 09:13:50 +0200
Message-Id: <20200726071356.287160-16-hch@lst.de>
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

Add a simple helper to check if a file exists based on kernel space file
name and switch the early init code over to it.  Note that this
theoretically changes behavior as it always is based on the effective
permissions.  But during early init that doesn't make a difference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/for_init.c                 | 13 +++++++++++++
 fs/open.c                     |  2 +-
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  7 -------
 init/main.c                   |  4 ++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/for_init.c b/fs/for_init.c
index 098e9b69c32ef6..abc152f41e648b 100644
--- a/fs/for_init.c
+++ b/fs/for_init.c
@@ -105,6 +105,19 @@ int __init init_chmod(const char *filename, umode_t mode)
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
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 2b1b4dc586825f..7031c0934bee9f 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -7,5 +7,6 @@ int __init init_chdir(const char *filename);
 int __init init_chroot(const char *filename);
 int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
 int __init init_chmod(const char *filename, umode_t mode);
+int __init init_eaccess(const char *filename);
 int __init init_unlink(const char *pathname);
 int __init init_rmdir(const char *pathname);
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
 
diff --git a/init/main.c b/init/main.c
index c2c9143db96795..6e2a4a078b78c4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -96,6 +96,7 @@
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
+#include <linux/init_syscalls.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1514,8 +1515,7 @@ static noinline void __init kernel_init_freeable(void)
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

