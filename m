Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB97226940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgGTP7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbgGTP7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E2C061794;
        Mon, 20 Jul 2020 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9GhGuOFkyummJYwXht5KypyMsPpMUy3wBY5HUGAYE/4=; b=BAyJCuJl6xxfaR2bnyWAKfNOCa
        bns2edHE8oUfB2I2/oXY7gh0JIm+ty2cps51xzTEJ/w7H1w3hUhLc1yGRZsrR/u9pQ47MYdtXmjDX
        1Wzxe+zgGo1kooKo0IYK6G8m0ql48vmS8iSkTcj/cWhFYXVSybHMJ05peVOtl6gVW95PlA3PWL4Df
        jPEzy7xPqzcV/662Cy+SnzUta/fbOqVOqIxZpUdEC7HFbhIJm5RXBxoLzK3zE62ed3qzUiBp4GQoj
        xykHVdmyahzsr3yZd2CIAkvJWmBadQiDHas1i4qNYwiYQOgMuq872RL/wv8vFnlhtVNEXd5CKR9fS
        XQK8PW0Q==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCU-0007r7-DT; Mon, 20 Jul 2020 15:59:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 17/24] fs: add a kern_unlink helper
Date:   Mon, 20 Jul 2020 17:58:55 +0200
Message-Id: <20200720155902.181712-18-hch@lst.de>
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

Add a simple helper to unlink with a kernel space file name and switch
the early init and coredump code over to it.  Remove the now unused
ksys_unlink.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/coredump.c            | 2 +-
 fs/internal.h            | 1 -
 fs/namei.c               | 7 ++++++-
 include/linux/fs.h       | 1 +
 include/linux/syscalls.h | 7 -------
 init/do_mounts.h         | 2 +-
 init/do_mounts_initrd.c  | 4 ++--
 init/do_mounts_rd.c      | 2 +-
 init/initramfs.c         | 2 +-
 9 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7237f07ff6bed2..fc82170e78c71d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -719,7 +719,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			 * If it doesn't exist, that's fine. If there's some
 			 * other problem, we'll catch it at the filp_open().
 			 */
-			do_unlinkat(AT_FDCWD, getname_kernel(cn.corename));
+			kern_unlink(cn.corename);
 		}
 
 		/*
diff --git a/fs/internal.h b/fs/internal.h
index 46f727c0bd84e2..62e17871f16316 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -63,7 +63,6 @@ extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 long do_rmdir(int dfd, const char __user *pathname);
-long do_unlinkat(int dfd, struct filename *name);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 01e43676008644..3cbaca386d3189 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3883,7 +3883,7 @@ EXPORT_SYMBOL(vfs_unlink);
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
-long do_unlinkat(int dfd, struct filename *name)
+static int do_unlinkat(int dfd, struct filename *name)
 {
 	int error;
 	struct dentry *dentry;
@@ -3954,6 +3954,11 @@ long do_unlinkat(int dfd, struct filename *name)
 	goto exit2;
 }
 
+int kern_unlink(const char *pathname)
+{
+	return do_unlinkat(AT_FDCWD, getname_kernel(pathname));
+}
+
 SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
 {
 	if ((flag & ~AT_REMOVEDIR) != 0)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7a7b3bf1b8aa53..306e58ff54f69f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3681,5 +3681,6 @@ int kern_mkdir(const char *pathname, umode_t mode);
 int kern_mknod(const char *filename, umode_t mode, unsigned int dev);
 int __init kern_link(const char *oldname, const char *newname);
 int __init kern_symlink(const char *oldname, const char *newname);
+int kern_unlink(const char *pathname);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 474d5d165048c8..483431765ac823 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1270,13 +1270,6 @@ int compat_ksys_ipc(u32 call, int first, int second,
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
  */
-extern long do_unlinkat(int dfd, struct filename *name);
-
-static inline long ksys_unlink(const char __user *pathname)
-{
-	return do_unlinkat(AT_FDCWD, getname(pathname));
-}
-
 extern long do_rmdir(int dfd, const char __user *pathname);
 
 static inline long ksys_rmdir(const char __user *pathname)
diff --git a/init/do_mounts.h b/init/do_mounts.h
index b9ec1d522f0ce1..0b3c72ee6670b2 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -15,7 +15,7 @@ extern int root_mountflags;
 
 static inline int create_dev(char *name, dev_t dev)
 {
-	ksys_unlink(name);
+	kern_unlink(name);
 	return kern_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index b9a749ebe85c2d..1b74a0a5c38f8b 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -137,11 +137,11 @@ bool __init initrd_load(void)
 		 * mounted in the normal path.
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
-			ksys_unlink("/initrd.image");
+			kern_unlink("/initrd.image");
 			handle_initrd();
 			return true;
 		}
 	}
-	ksys_unlink("/initrd.image");
+	kern_unlink("/initrd.image");
 	return false;
 }
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 7b64390c075043..1737f1d2ee9fd7 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -271,7 +271,7 @@ int __init rd_load_image(char *from)
 	fput(out_file);
 out:
 	kfree(buf);
-	ksys_unlink("/dev/ram");
+	kern_unlink("/dev/ram");
 	return res;
 }
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 4efd78427996da..86d3750a47499d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -300,7 +300,7 @@ static void __init clean_path(char *path, umode_t fmode)
 		if (S_ISDIR(st.mode))
 			ksys_rmdir(path);
 		else
-			ksys_unlink(path);
+			kern_unlink(path);
 	}
 }
 
-- 
2.27.0

