Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE9230FDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgG1QgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbgG1Qei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD86C061794;
        Tue, 28 Jul 2020 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DRMHqN692VZul25DPeXb71n72Fd2PLEekGX4ziRpt5Q=; b=FaaKEZht5hHMYYzpy26ebrj6Q9
        KnnZQ4UmqIrsRJAPIg1Uany1t1HfLE3oZ3FOfisEdSrp14GOkVJvm8HSXweYVGQb1WWmskVqZKsOg
        mz27CSWTZ9CG7DkXz6S6J95P742c+yRxOOJfxmxbGhe4EaIWRz6JR4SAjOgO+Tj59mgFGPLTE/2V5
        IZfgK/IPg5zXK0ftronyI/+FZeKZT8cX3yohYqYbL8YUsS+6ptaPdKlCkswCeJXPjESgqHBiEuxCs
        DBYwZ/WiIoAHgeTzPAVvdxAqcH1/N/Hp3f8HoO5vvltdEywgjo+Zu8ndDnN72q9UNN8NBG2HGzw+X
        uk74aTmA==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYi-0006yV-Mx; Tue, 28 Jul 2020 16:34:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 09/23] init: add an init_umount helper
Date:   Tue, 28 Jul 2020 18:34:02 +0200
Message-Id: <20200728163416.556521-10-hch@lst.de>
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

Like ksys_umount, but takes a kernel pointer for the destination path.
Switch over the umount in the init code, which just happen to work due to
the implicit set_fs(KERNEL_DS) during early init right now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c                     | 14 ++++++++++++++
 fs/internal.h                 |  1 +
 fs/namespace.c                |  4 ++--
 include/linux/init_syscalls.h |  1 +
 include/linux/syscalls.h      |  1 -
 init/do_mounts_initrd.c       |  2 +-
 6 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index c6eb724e1c7b22..9c8e31fdb048c8 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -23,3 +23,17 @@ int __init init_mount(const char *dev_name, const char *dir_name,
 	path_put(&path);
 	return ret;
 }
+
+int __init init_umount(const char *name, int flags)
+{
+	int lookup_flags = LOOKUP_MOUNTPOINT;
+	struct path path;
+	int ret;
+
+	if (!(flags & UMOUNT_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+	ret = kern_path(name, lookup_flags, &path);
+	if (ret)
+		return ret;
+	return path_umount(&path, flags);
+}
diff --git a/fs/internal.h b/fs/internal.h
index 72ea0b6f7435a4..491d1e63809b37 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -92,6 +92,7 @@ extern void dissolve_on_fput(struct vfsmount *);
 
 int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
+int path_umount(struct path *path, int flags);
 
 /*
  * fs_struct.c
diff --git a/fs/namespace.c b/fs/namespace.c
index 2c4d7592097485..a7301790abb211 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1706,7 +1706,7 @@ static inline bool may_mandlock(void)
 }
 #endif
 
-static int path_umount(struct path *path, int flags)
+int path_umount(struct path *path, int flags)
 {
 	struct mount *mnt;
 	int retval;
@@ -1736,7 +1736,7 @@ static int path_umount(struct path *path, int flags)
 	return retval;
 }
 
-int ksys_umount(char __user *name, int flags)
+static int ksys_umount(char __user *name, int flags)
 {
 	int lookup_flags = LOOKUP_MOUNTPOINT;
 	struct path path;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index af9ea88a60e0bd..a5a2e7f1991691 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -2,3 +2,4 @@
 
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page);
+int __init init_umount(const char *name, int flags);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e43816198e6001..1a4f5d8ee7044b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1236,7 +1236,6 @@ asmlinkage long sys_ni_syscall(void);
  * the ksys_xyzyyz() functions prototyped below.
  */
 
-int ksys_umount(char __user *name, int flags);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 1f9336209ad9cc..6b020a06990251 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -122,7 +122,7 @@ static void __init handle_initrd(void)
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
-		ksys_umount("/old", MNT_DETACH);
+		init_umount("/old", MNT_DETACH);
 	}
 }
 
-- 
2.27.0

