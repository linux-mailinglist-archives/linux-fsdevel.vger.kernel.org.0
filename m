Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE80230FD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbgG1Qfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731673AbgG1Qez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB503C061794;
        Tue, 28 Jul 2020 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wa1l4/v8lDQwBc5r7QfX99DV59Slfd55uHBjGt4s3eI=; b=WqaHpSJAnklYimjfoeY28OzSTo
        HyewgYRQVtVM2WX/nKX3aFayc5zQqNbAltdxfgDh6XBCQnAqsoHbaTTqs88vmur8zkCQZMTGAOdv3
        RaAvhE+oW/56VP0CHzEhHzybOwU1S2tzSwfu7VRo96CsJL9L4fWWdzosCr9zeQjS9yrFQSHLb5/Q7
        2wzSkjyNX3a8czDNc9PEMns8EcSSSWBUSMUPwGyZvk6K9WRMQTqtvQtRF09hb/bAuClVJw770+Y9t
        Z9setN+LZd+sBKaHEFH0p/H45dtyH0c1iBFS4g+D6cwR8OuEvYz/4yQXbDkmwMaXOgJClOK45jd3A
        AIMU21EA==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SZ0-000728-2e; Tue, 28 Jul 2020 16:34:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 16/23] init: add an init_eaccess helper
Date:   Tue, 28 Jul 2020 18:34:09 +0200
Message-Id: <20200728163416.556521-17-hch@lst.de>
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

Add a simple helper to check if a file exists based on kernel space file
name and switch the early init code over to it.  Note that this
theoretically changes behavior as it always is based on the effective
permissions.  But during early init that doesn't make a difference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 13 +++++++++++++
 fs/open.c                     |  2 +-
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  7 -------
 init/main.c                   |  4 ++--
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index a66032d128b618..6d9af40d2897b1 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -109,6 +109,19 @@ int __init init_chmod(const char *filename, umode_t mode)
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
index 47698427b15f62..1c710d3e1d461a 100644
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

