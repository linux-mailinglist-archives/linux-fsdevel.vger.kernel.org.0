Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C72265FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 17:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgGTP7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgGTP7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0038C0619D2;
        Mon, 20 Jul 2020 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wapfVARVdu2rPD3BwjJEB1KyGijoqrlGPwEotE0t0IY=; b=rS5LCpJj7ZaZb8gf7tdqf0ITny
        HIUK9sLiT6OVcFKzRaclbtvxUcg5v0Ve7yva7ffZOU0vt618YY0/E3bERcBB5Wp0cOh6mUvoGJEC6
        UON0B6Cph6M/kd4i/jgP5wD8hKh2xKruQOFpXCh0/d88+xguXsMnnV8Vcnsubu8ZQhj4L5dK7SRCp
        djGwMhvpqxq/Sx1DkrJ/Wh+ZbQPkLdZKQZPgsi7GUvyUmKFU/y2IFYz5iNVXMUpopdu5Gjxp+rjpk
        R3A6d6qH2w1S9A3pimN/eEwxfsPzbGV38Aj86OtBF8/v48CFmJ20dpoqko65UGpqdeNg8UjetLEIK
        vcd8umiQ==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYCA-0007nt-0H; Mon, 20 Jul 2020 15:59:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 07/24] fs: add a kern_chroot helper
Date:   Mon, 20 Jul 2020 17:58:45 +0200
Message-Id: <20200720155902.181712-8-hch@lst.de>
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

Add a simple helper for a chroot with a kernelspace name and use it in
the early init code instead of relying on the implicit set_fs(KERNEL_DS)
there.  Remove the now unused ksys_chroot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/devtmpfs.c  |  2 +-
 fs/open.c                | 15 ++++++++++-----
 include/linux/fs.h       |  1 +
 include/linux/syscalls.h |  1 -
 init/do_mounts.c         |  2 +-
 init/do_mounts_initrd.c  |  4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 2cedeb62706f18..a5126e7be34c8a 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -389,7 +389,7 @@ static int devtmpfs_setup(void *p)
 	if (err)
 		goto out;
 	kern_chdir("/.."); /* will traverse into overmounted root */
-	ksys_chroot(".");
+	kern_chroot(".");
 out:
 	*(int *)p = err;
 	complete(&setup_done);
diff --git a/fs/open.c b/fs/open.c
index 3d62f4d2604739..424db905da5f18 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -540,15 +540,15 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	return error;
 }
 
-int ksys_chroot(const char __user *filename)
+static int do_chroot(struct filename *name)
 {
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 retry:
-	error = user_path_at(AT_FDCWD, filename, lookup_flags, &path);
+	error = filename_lookup(AT_FDCWD, name, lookup_flags, &path, NULL);
 	if (error)
-		goto out;
+		return error;
 
 	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
@@ -569,13 +569,18 @@ int ksys_chroot(const char __user *filename)
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-out:
+	putname(name);
 	return error;
 }
 
+int kern_chroot(const char *filename)
+{
+	return do_chroot(getname_kernel(filename));
+}
+
 SYSCALL_DEFINE1(chroot, const char __user *, filename)
 {
-	return ksys_chroot(filename);
+	return do_chroot(getname(filename));
 }
 
 static int chmod_common(const struct path *path, umode_t mode)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dccb37407e9bad..0205355bffb1bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3672,5 +3672,6 @@ static inline int inode_drain_writes(struct inode *inode)
 }
 
 int kern_chdir(const char *filename);
+int kern_chroot(const char *filename);
 
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index f2a181776b0409..a3176d1a521467 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1236,7 +1236,6 @@ asmlinkage long sys_ni_syscall(void);
  * the ksys_xyzyyz() functions prototyped below.
  */
 
-int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 8c3fca8e2d3c6e..31b8dedb189b57 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -629,7 +629,7 @@ void __init prepare_namespace(void)
 out:
 	devtmpfs_mount();
 	do_kern_mount(".", "/", NULL, MS_MOVE, NULL);
-	ksys_chroot(".");
+	kern_chroot(".");
 }
 
 static bool is_tmpfs;
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 522554d703b785..1cbc9988d2e0ad 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -63,7 +63,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	/* move initrd over / and chdir/chroot in initrd root */
 	kern_chdir("/root");
 	do_kern_mount(".", "/", NULL, MS_MOVE, NULL);
-	ksys_chroot(".");
+	kern_chroot(".");
 	ksys_setsid();
 	return 0;
 }
@@ -101,7 +101,7 @@ static void __init handle_initrd(void)
 	/* move initrd to rootfs' /old */
 	do_kern_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
-	ksys_chroot("..");
+	kern_chroot("..");
 
 	if (new_decode_dev(real_root_dev) == Root_RAM0) {
 		kern_chdir("/old");
-- 
2.27.0

