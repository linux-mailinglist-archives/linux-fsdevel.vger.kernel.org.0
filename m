Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F7D1DF5A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgEWHac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbgEWHab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A44C061A0E;
        Sat, 23 May 2020 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qIw3OPU8Sxp7JahIkvUfff5P/E6RpoFhtN8ZHq5DT7A=; b=NXC9jGCgE9e16n6ItfThongB/J
        g9rXzNTRNnU1fCZAgULKUpxUrqtO5H/v5pTXMo+QJ/EuyT7cuu6AETORRz9TF0wpCKIYZa3CPs1k2
        Vo6m1VtPuoJEnB0MMqDbkOluc8IcDmzck3mPrOuPYLLW5+hPYsOs/CuHkyxzqiGsWFO9H/RRzYgZk
        XXVgSa3Z1EP/oJjpAovvpQ2YhWSME7f447qQvp46voYOlsNGKud5tGYYoQ59yKn9mZX0QRrojp2sW
        ZS4BOtAuWUq0A3n3yebjqvZ7/Lg1lsGf0ZQUUBvLLMBVuFeVInxxAamdNyGOBPSTbmj6kj48MNaEv
        2CfRuF9g==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcOc2-0007sE-JT; Sat, 23 May 2020 07:30:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 4/9] fs: move the fiemap definitions out of fs.h
Date:   Sat, 23 May 2020 09:30:11 +0200
Message-Id: <20200523073016.2944131-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523073016.2944131-1-hch@lst.de>
References: <20200523073016.2944131-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to pull the fiemap definitions into almost every file in the
kernel build.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/bad_inode.c              |  1 +
 fs/btrfs/extent_io.h        |  1 +
 fs/cifs/inode.c             |  1 +
 fs/cifs/smb2ops.c           |  1 +
 fs/ext2/inode.c             |  1 +
 fs/ext4/ext4.h              |  1 +
 fs/f2fs/data.c              |  1 +
 fs/f2fs/inline.c            |  1 +
 fs/gfs2/inode.c             |  1 +
 fs/hpfs/file.c              |  1 +
 fs/ioctl.c                  |  1 +
 fs/iomap/fiemap.c           |  1 +
 fs/nilfs2/inode.c           |  1 +
 fs/overlayfs/inode.c        |  1 +
 fs/xfs/xfs_iops.c           |  1 +
 include/linux/fiemap.h      | 24 ++++++++++++++++++++++++
 include/linux/fs.h          | 19 +------------------
 include/uapi/linux/fiemap.h |  6 +++---
 18 files changed, 43 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/fiemap.h

diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 8035d2a445617..54f0ce4442720 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -15,6 +15,7 @@
 #include <linux/time.h>
 #include <linux/namei.h>
 #include <linux/poll.h>
+#include <linux/fiemap.h>
 
 static int bad_file_open(struct inode *inode, struct file *filp)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2ed65bd0760ea..817698bc06693 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -5,6 +5,7 @@
 
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/fiemap.h>
 #include "ulist.h"
 
 /*
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 5d2965a237305..115d28e7c2197 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
 #include <linux/wait_bit.h>
+#include <linux/fiemap.h>
 
 #include <asm/div64.h>
 #include "cifsfs.h"
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f829f4165d38c..09047f1ddfb66 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/sort.h>
 #include <crypto/aead.h>
+#include <linux/fiemap.h>
 #include "cifsfs.h"
 #include "cifsglob.h"
 #include "smb2pdu.h"
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c885cf7d724b4..0f12a0e8a8d97 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -36,6 +36,7 @@
 #include <linux/iomap.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
+#include <linux/fiemap.h>
 #include "ext2.h"
 #include "acl.h"
 #include "xattr.h"
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad2dbf6e49245..06f97a3a943f6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -36,6 +36,7 @@
 #include <crypto/hash.h>
 #include <linux/falloc.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/fiemap.h>
 #ifdef __KERNEL__
 #include <linux/compat.h>
 #endif
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cdf2f626bea7a..25abbbb65ba09 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
+#include <linux/fiemap.h>
 
 #include "f2fs.h"
 #include "node.h"
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4167e54081518..9686ffea177e7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -8,6 +8,7 @@
 
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
+#include <linux/fiemap.h>
 
 #include "f2fs.h"
 #include "node.h"
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 5acd3ce30759b..a1337bf31e49f 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -17,6 +17,7 @@
 #include <linux/crc32.h>
 #include <linux/iomap.h>
 #include <linux/security.h>
+#include <linux/fiemap.h>
 #include <linux/uaccess.h>
 
 #include "gfs2.h"
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index b36abf9cb345a..62959a8e43ad8 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -9,6 +9,7 @@
 
 #include "hpfs_fn.h"
 #include <linux/mpage.h>
+#include <linux/fiemap.h>
 
 #define BLOCKS(size) (((size) + 511) >> 9)
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 8fe5131b1deea..3f300cc07dee4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -18,6 +18,7 @@
 #include <linux/buffer_head.h>
 #include <linux/falloc.h>
 #include <linux/sched/signal.h>
+#include <linux/fiemap.h>
 
 #include "internal.h"
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index d55e8f491a5e5..0a807bbb2b4af 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
+#include <linux/fiemap.h>
 
 struct fiemap_ctx {
 	struct fiemap_extent_info *fi;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 671085512e0fd..6e1aca38931f3 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/uio.h>
+#include <linux/fiemap.h>
 #include "nilfs.h"
 #include "btnode.h"
 #include "segment.h"
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 981f11ec51bc6..625e58da4e82a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -10,6 +10,7 @@
 #include <linux/xattr.h>
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
+#include <linux/fiemap.h>
 #include "overlayfs.h"
 
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f7a99b3bbcf7a..44c353998ac5c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -25,6 +25,7 @@
 #include <linux/posix_acl.h>
 #include <linux/security.h>
 #include <linux/iversion.h>
+#include <linux/fiemap.h>
 
 /*
  * Directories have different lock order w.r.t. mmap_sem compared to regular
diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
new file mode 100644
index 0000000000000..240d4f7d9116a
--- /dev/null
+++ b/include/linux/fiemap.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FIEMAP_H
+#define _LINUX_FIEMAP_H 1
+
+#include <uapi/linux/fiemap.h>
+#include <linux/fs.h>
+
+struct fiemap_extent_info {
+	unsigned int fi_flags;		/* Flags as passed from user */
+	unsigned int fi_extents_mapped;	/* Number of mapped extents */
+	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
+	struct fiemap_extent __user *fi_extents_start; /* Start of
+							fiemap_extent array */
+};
+
+int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
+			    u64 phys, u64 len, u32 flags);
+int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
+
+int generic_block_fiemap(struct inode *inode,
+		struct fiemap_extent_info *fieinfo, u64 start, u64 len,
+		get_block_t *get_block);
+
+#endif /* _LINUX_FIEMAP_H 1 */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 69b7619eb83d0..6bb0de9995012 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -24,7 +24,6 @@
 #include <linux/capability.h>
 #include <linux/semaphore.h>
 #include <linux/fcntl.h>
-#include <linux/fiemap.h>
 #include <linux/rculist_bl.h>
 #include <linux/atomic.h>
 #include <linux/shrinker.h>
@@ -48,6 +47,7 @@ struct backing_dev_info;
 struct bdi_writeback;
 struct bio;
 struct export_operations;
+struct fiemap_extent_info;
 struct hd_geometry;
 struct iovec;
 struct kiocb;
@@ -1745,19 +1745,6 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 extern void inode_init_owner(struct inode *inode, const struct inode *dir,
 			umode_t mode);
 extern bool may_open_dev(const struct path *path);
-/*
- * VFS FS_IOC_FIEMAP helper definitions.
- */
-struct fiemap_extent_info {
-	unsigned int fi_flags;		/* Flags as passed from user */
-	unsigned int fi_extents_mapped;	/* Number of mapped extents */
-	unsigned int fi_extents_max;	/* Size of fiemap_extent array */
-	struct fiemap_extent __user *fi_extents_start; /* Start of
-							fiemap_extent array */
-};
-int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
-			    u64 phys, u64 len, u32 flags);
-int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
@@ -3299,10 +3286,6 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
 extern int vfs_readlink(struct dentry *, char __user *, int);
 
-extern int generic_block_fiemap(struct inode *inode,
-				struct fiemap_extent_info *fieinfo, u64 start,
-				u64 len, get_block_t *get_block);
-
 extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
index 8c0bc24d5d955..07c1cdcb715e8 100644
--- a/include/uapi/linux/fiemap.h
+++ b/include/uapi/linux/fiemap.h
@@ -9,8 +9,8 @@
  *          Andreas Dilger <adilger@sun.com>
  */
 
-#ifndef _LINUX_FIEMAP_H
-#define _LINUX_FIEMAP_H
+#ifndef _UAPI_LINUX_FIEMAP_H
+#define _UAPI_LINUX_FIEMAP_H
 
 #include <linux/types.h>
 
@@ -67,4 +67,4 @@ struct fiemap {
 #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with other
 						    * files. */
 
-#endif /* _LINUX_FIEMAP_H */
+#endif /* _UAPI_LINUX_FIEMAP_H */
-- 
2.26.2

