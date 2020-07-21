Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8A228552
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgGUQ2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgGUQ2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C712C061794;
        Tue, 21 Jul 2020 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p+1vAloQdss4MLN/qmNhhv4t2otUx0WTO85WGrKJM3w=; b=L3d4Lo4+pGFoml2TQ7oRoP0whw
        zQ4KP/RMuM0UNOWgHwHeQrY3/Bxfrsww9dFMR5KlVCow6oaYNuppbVrgn47OQNVcSxdgy/NWruxr6
        MZ66QIr7qEbYGlV08d9f8SGxnVbrsvfL1UcymyND8z7JbYriiJSik87a1Tv1eaLgg6XzDWTfG/ixJ
        +dy1DonJyzQueSgcGcWmFmEm+WL7YMy7mUlRohRhaT5PrGX1ZuljrgoH11iXW9/NKKLseYR8si99V
        4u+CRxW8Y2nozzmvbFpAy2napMjW/PeJC5hAfYa++kF7z1TIAJ7wqPgch4HnokefBW76ZDJF0dESn
        /wy4MHxA==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv86-0007TH-1Z; Tue, 21 Jul 2020 16:28:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 10/24] init: open code ksys_umount in handle_initrd
Date:   Tue, 21 Jul 2020 18:28:04 +0200
Message-Id: <20200721162818.197315-11-hch@lst.de>
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

Replace ksys_umount with an open coded version that takes the proper
kernel pointer instead of relying on the implicit set_fs(KERNEL_DS)
during early init.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namespace.c           | 4 ++--
 include/linux/mount.h    | 1 +
 include/linux/syscalls.h | 1 -
 init/do_mounts_initrd.c  | 6 +++++-
 4 files changed, 8 insertions(+), 4 deletions(-)

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
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf9896f86a48f4..e868b1ac7af90c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -115,5 +115,6 @@ extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 int path_mount(const char *dev_name, struct path *path, const char *type_page,
 		unsigned long flags, void *data_page);
+int path_umount(struct path *path, int flags);
 
 #endif /* _LINUX_MOUNT_H */
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
index e08669187d63be..3fabbc82513506 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -9,6 +9,7 @@
 #include <linux/freezer.h>
 #include <linux/kmod.h>
 #include <uapi/linux/mount.h>
+#include <linux/namei.h>
 
 #include "do_mounts.h"
 
@@ -117,12 +118,15 @@ static void __init handle_initrd(void)
 	if (!error)
 		printk("okay\n");
 	else {
+		struct path path;
+
 		if (error == -ENOENT)
 			printk("/initrd does not exist. Ignored.\n");
 		else
 			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
-		ksys_umount("/old", MNT_DETACH);
+		if (!kern_path("/old", LOOKUP_MOUNTPOINT, &path))
+			path_umount(&path, MNT_DETACH);
 	}
 }
 
-- 
2.27.0

