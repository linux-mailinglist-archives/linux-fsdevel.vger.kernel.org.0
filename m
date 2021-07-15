Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADC3C9FE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhGONnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55806 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhGONnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8437422A7D;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsI+catW5RS76O1qdmcY4XnE8ZCUk7oq5voDHQ5HYLE=;
        b=IiPsrU68bsCNYIZFsI0IPy92N02/349Fg2nPIGYqwLU8+utzhwtQpr/wxz0PiFN17gRtec
        j8y8pqDsndj6Bw6TtTKQfM2P8vkY6hUBy9CGW4OEEKGl34hepIZtJ14G3TqvZ0iL/5BAlM
        vAYUeP4u3Szgm5WLbgu9GXzjVff01Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsI+catW5RS76O1qdmcY4XnE8ZCUk7oq5voDHQ5HYLE=;
        b=5w8o+0+hfvSJMcqG+YnxIJBl4hwF8gy2m/jJqCN5z+30xzjge7rBQqh4NLZGvObozauAw0
        L5d/YmCnOIwSPxDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6FD7CA3BA4;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1EE1B1E0CA7; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/14] xfs: Convert to use invalidate_lock
Date:   Thu, 15 Jul 2021 15:40:18 +0200
Message-Id: <20210715134032.24868-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7925; h=from:subject; bh=mWejkTIDaMc9IxG2WeDXqMcapYxJ9TVU66wpmUCJK/w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrC59+SdGq1uy3gFs6NYDzc+OoN+hNXqB+X3E14 ZExEH3GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6wgAKCRCcnaoHP2RA2bVfB/ 9km7hkkB9Q9JhDwD8wU+FUAkBa81LsU7jBZj2pl3UyvHrRc5lqRfLSG/H58JnBmX5Ly03I+ktg2y5d 0c1OgOtH+LzTitmdP8yuYeMCTsqtvdZmaOZ71uXZ6lMrmAMwjObQ+fGbJVER2/fTNv1wFzLBBkWLch Hnt2KL75K79N2NtRJQLwQchkaXeHy/TqMpLU1g4CdmlzlElDkCRg1o7siwHavQxDN5nUR6pqNdKffH 3Ry6izKs87djqcZZzXACKjPAaumd0eKHcWJSGZCi65Pjqai9Iy2AVs8+SFC3thJ4BVfDjrGy/YOHWG EYp72C2zTHclo8Otc0sHxrCUMUlgxp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use invalidate_lock instead of XFS internal i_mmap_lock. The intended
purpose of invalidate_lock is exactly the same. Note that the locking in
__xfs_filemap_fault() slightly changes as filemap_fault() already takes
invalidate_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
CC: <linux-xfs@vger.kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_file.c  | 13 +++++++-----
 fs/xfs/xfs_inode.c | 50 ++++++++++++++++++++++++----------------------
 fs/xfs/xfs_inode.h |  1 -
 fs/xfs/xfs_super.c |  2 --
 4 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cc3cfb12df53..3dfbdcdb0d1c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1302,7 +1302,7 @@ xfs_file_llseek(
  *
  * mmap_lock (MM)
  *   sb_start_pagefault(vfs, freeze)
- *     i_mmaplock (XFS - truncate serialisation)
+ *     invalidate_lock (vfs/XFS_MMAPLOCK - truncate serialisation)
  *       page_lock (MM)
  *         i_lock (XFS - extent map serialisation)
  */
@@ -1323,24 +1323,27 @@ __xfs_filemap_fault(
 		file_update_time(vmf->vma->vm_file);
 	}
 
-	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 	if (IS_DAX(inode)) {
 		pfn_t pfn;
 
+		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
 				 &xfs_direct_write_iomap_ops :
 				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 	} else {
-		if (write_fault)
+		if (write_fault) {
+			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 			ret = iomap_page_mkwrite(vmf,
 					&xfs_buffered_write_iomap_ops);
-		else
+			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
+		} else {
 			ret = filemap_fault(vmf);
+		}
 	}
-	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 
 	if (write_fault)
 		sb_end_pagefault(inode->i_sb);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 359e2cd44ad7..d6a8ac76b45d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -132,7 +132,7 @@ xfs_ilock_attr_map_shared(
 
 /*
  * In addition to i_rwsem in the VFS inode, the xfs inode contains 2
- * multi-reader locks: i_mmap_lock and the i_lock.  This routine allows
+ * multi-reader locks: invalidate_lock and the i_lock.  This routine allows
  * various combinations of the locks to be obtained.
  *
  * The 3 locks should always be ordered so that the IO lock is obtained first,
@@ -140,23 +140,23 @@ xfs_ilock_attr_map_shared(
  *
  * Basic locking order:
  *
- * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
+ * i_rwsem -> invalidate_lock -> page_lock -> i_ilock
  *
  * mmap_lock locking order:
  *
  * i_rwsem -> page lock -> mmap_lock
- * mmap_lock -> i_mmap_lock -> page_lock
+ * mmap_lock -> invalidate_lock -> page_lock
  *
  * The difference in mmap_lock locking order mean that we cannot hold the
- * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
- * fault in pages during copy in/out (for buffered IO) or require the mmap_lock
- * in get_user_pages() to map the user pages into the kernel address space for
- * direct IO. Similarly the i_rwsem cannot be taken inside a page fault because
- * page faults already hold the mmap_lock.
+ * invalidate_lock over syscall based read(2)/write(2) based IO. These IO paths
+ * can fault in pages during copy in/out (for buffered IO) or require the
+ * mmap_lock in get_user_pages() to map the user pages into the kernel address
+ * space for direct IO. Similarly the i_rwsem cannot be taken inside a page
+ * fault because page faults already hold the mmap_lock.
  *
  * Hence to serialise fully against both syscall and mmap based IO, we need to
- * take both the i_rwsem and the i_mmap_lock. These locks should *only* be both
- * taken in places where we need to invalidate the page cache in a race
+ * take both the i_rwsem and the invalidate_lock. These locks should *only* be
+ * both taken in places where we need to invalidate the page cache in a race
  * free manner (e.g. truncate, hole punch and other extent manipulation
  * functions).
  */
@@ -188,10 +188,13 @@ xfs_ilock(
 				 XFS_IOLOCK_DEP(lock_flags));
 	}
 
-	if (lock_flags & XFS_MMAPLOCK_EXCL)
-		mrupdate_nested(&ip->i_mmaplock, XFS_MMAPLOCK_DEP(lock_flags));
-	else if (lock_flags & XFS_MMAPLOCK_SHARED)
-		mraccess_nested(&ip->i_mmaplock, XFS_MMAPLOCK_DEP(lock_flags));
+	if (lock_flags & XFS_MMAPLOCK_EXCL) {
+		down_write_nested(&VFS_I(ip)->i_mapping->invalidate_lock,
+				  XFS_MMAPLOCK_DEP(lock_flags));
+	} else if (lock_flags & XFS_MMAPLOCK_SHARED) {
+		down_read_nested(&VFS_I(ip)->i_mapping->invalidate_lock,
+				 XFS_MMAPLOCK_DEP(lock_flags));
+	}
 
 	if (lock_flags & XFS_ILOCK_EXCL)
 		mrupdate_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
@@ -240,10 +243,10 @@ xfs_ilock_nowait(
 	}
 
 	if (lock_flags & XFS_MMAPLOCK_EXCL) {
-		if (!mrtryupdate(&ip->i_mmaplock))
+		if (!down_write_trylock(&VFS_I(ip)->i_mapping->invalidate_lock))
 			goto out_undo_iolock;
 	} else if (lock_flags & XFS_MMAPLOCK_SHARED) {
-		if (!mrtryaccess(&ip->i_mmaplock))
+		if (!down_read_trylock(&VFS_I(ip)->i_mapping->invalidate_lock))
 			goto out_undo_iolock;
 	}
 
@@ -258,9 +261,9 @@ xfs_ilock_nowait(
 
 out_undo_mmaplock:
 	if (lock_flags & XFS_MMAPLOCK_EXCL)
-		mrunlock_excl(&ip->i_mmaplock);
+		up_write(&VFS_I(ip)->i_mapping->invalidate_lock);
 	else if (lock_flags & XFS_MMAPLOCK_SHARED)
-		mrunlock_shared(&ip->i_mmaplock);
+		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
 out_undo_iolock:
 	if (lock_flags & XFS_IOLOCK_EXCL)
 		up_write(&VFS_I(ip)->i_rwsem);
@@ -307,9 +310,9 @@ xfs_iunlock(
 		up_read(&VFS_I(ip)->i_rwsem);
 
 	if (lock_flags & XFS_MMAPLOCK_EXCL)
-		mrunlock_excl(&ip->i_mmaplock);
+		up_write(&VFS_I(ip)->i_mapping->invalidate_lock);
 	else if (lock_flags & XFS_MMAPLOCK_SHARED)
-		mrunlock_shared(&ip->i_mmaplock);
+		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
 		mrunlock_excl(&ip->i_lock);
@@ -335,7 +338,7 @@ xfs_ilock_demote(
 	if (lock_flags & XFS_ILOCK_EXCL)
 		mrdemote(&ip->i_lock);
 	if (lock_flags & XFS_MMAPLOCK_EXCL)
-		mrdemote(&ip->i_mmaplock);
+		downgrade_write(&VFS_I(ip)->i_mapping->invalidate_lock);
 	if (lock_flags & XFS_IOLOCK_EXCL)
 		downgrade_write(&VFS_I(ip)->i_rwsem);
 
@@ -375,9 +378,8 @@ xfs_isilocked(
 	}
 
 	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
-		if (!(lock_flags & XFS_MMAPLOCK_SHARED))
-			return !!ip->i_mmaplock.mr_writer;
-		return rwsem_is_locked(&ip->i_mmaplock.mr_lock);
+		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
+				(lock_flags & XFS_IOLOCK_SHARED));
 	}
 
 	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 4b5202ae8ebb..e0ae905554e2 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -40,7 +40,6 @@ typedef struct xfs_inode {
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
 	mrlock_t		i_lock;		/* inode lock */
-	mrlock_t		i_mmaplock;	/* inode mmap IO lock */
 	atomic_t		i_pincount;	/* inode pin count */
 
 	/*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2c9e26a44546..102cbd606633 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -709,8 +709,6 @@ xfs_fs_inode_init_once(
 	atomic_set(&ip->i_pincount, 0);
 	spin_lock_init(&ip->i_flags_lock);
 
-	mrlock_init(&ip->i_mmaplock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
-		     "xfsino", ip->i_ino);
 	mrlock_init(&ip->i_lock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
 		     "xfsino", ip->i_ino);
 }
-- 
2.26.2

