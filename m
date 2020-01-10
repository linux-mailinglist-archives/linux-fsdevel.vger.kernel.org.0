Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD9137730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgAJTan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:30:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:10951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbgAJTaJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:08 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="224289175"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:08 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH V2 08/12] fs/xfs: Add lock/unlock mode to xfs
Date:   Fri, 10 Jan 2020 11:29:38 -0800
Message-Id: <20200110192942.25021-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110192942.25021-1-ira.weiny@intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

XFS requires regular files to be locked while changing to/from DAX mode.

Define a new DAX lock type and implement the [un]lock_mode() inode
operation callbacks.

We define a new XFS_DAX_* lock type to carry the lock through the
transaction because we don't want to use IOLOCK as that would cause
performance issues with locking of the inode itself.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/xfs/xfs_icache.c |  2 ++
 fs/xfs/xfs_inode.c  | 37 +++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_inode.h  | 12 ++++++++++--
 fs/xfs/xfs_iops.c   | 24 +++++++++++++++++++++++-
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8dc2e5414276..0288672e8902 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -74,6 +74,8 @@ xfs_inode_alloc(
 	INIT_LIST_HEAD(&ip->i_ioend_list);
 	spin_lock_init(&ip->i_ioend_lock);
 
+	percpu_init_rwsem(&ip->i_dax_sem);
+
 	return ip;
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 401da197f012..e8fd95b75e5b 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
  *
  * Basic locking order:
  *
- * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
+ * i_rwsem -> i_dax_sem -> i_mmap_lock -> page_lock -> i_ilock
  *
  * mmap_sem locking order:
  *
  * i_rwsem -> page lock -> mmap_sem
- * mmap_sem -> i_mmap_lock -> page_lock
+ * mmap_sem -> i_dax_sem -> i_mmap_lock -> page_lock
  *
  * The difference in mmap_sem locking order mean that we cannot hold the
  * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
@@ -181,6 +181,13 @@ xfs_ilock(
 	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
 	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
+	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) !=
+	       (XFS_DAX_SHARED | XFS_DAX_EXCL));
+
+	if (lock_flags & XFS_DAX_EXCL)
+		percpu_down_write(&ip->i_dax_sem);
+	else if (lock_flags & XFS_DAX_SHARED)
+		percpu_down_read(&ip->i_dax_sem);
 
 	if (lock_flags & XFS_IOLOCK_EXCL) {
 		down_write_nested(&VFS_I(ip)->i_rwsem,
@@ -224,6 +231,8 @@ xfs_ilock_nowait(
 	 * You can't set both SHARED and EXCL for the same lock,
 	 * and only XFS_IOLOCK_SHARED, XFS_IOLOCK_EXCL, XFS_ILOCK_SHARED,
 	 * and XFS_ILOCK_EXCL are valid values to set in lock_flags.
+	 *
+	 * XFS_DAX_* is not allowed
 	 */
 	ASSERT((lock_flags & (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL)) !=
 	       (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL));
@@ -232,6 +241,7 @@ xfs_ilock_nowait(
 	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
 	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
+	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
 
 	if (lock_flags & XFS_IOLOCK_EXCL) {
 		if (!down_write_trylock(&VFS_I(ip)->i_rwsem))
@@ -302,6 +312,8 @@ xfs_iunlock(
 	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
 	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
 	ASSERT(lock_flags != 0);
+	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) !=
+	       (XFS_DAX_SHARED | XFS_DAX_EXCL));
 
 	if (lock_flags & XFS_IOLOCK_EXCL)
 		up_write(&VFS_I(ip)->i_rwsem);
@@ -318,6 +330,11 @@ xfs_iunlock(
 	else if (lock_flags & XFS_ILOCK_SHARED)
 		mrunlock_shared(&ip->i_lock);
 
+	if (lock_flags & XFS_DAX_EXCL)
+		percpu_up_write(&ip->i_dax_sem);
+	else if (lock_flags & XFS_DAX_SHARED)
+		percpu_up_read(&ip->i_dax_sem);
+
 	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
 }
 
@@ -333,6 +350,8 @@ xfs_ilock_demote(
 	ASSERT(lock_flags & (XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL));
 	ASSERT((lock_flags &
 		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
+	/* XFS_DAX_* is not allowed */
+	ASSERT((lock_flags & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
 		mrdemote(&ip->i_lock);
@@ -369,6 +388,13 @@ xfs_isilocked(
 		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
 	}
 
+	if (lock_flags & (XFS_DAX_EXCL|XFS_DAX_SHARED)) {
+		if (!(lock_flags & XFS_DAX_SHARED))
+			return !debug_locks ||
+				percpu_rwsem_is_held(&ip->i_dax_sem, 0);
+		return rwsem_is_locked(&ip->i_dax_sem);
+	}
+
 	ASSERT(0);
 	return 0;
 }
@@ -465,6 +491,9 @@ xfs_lock_inodes(
 	ASSERT(!(lock_mode & XFS_ILOCK_EXCL) ||
 		inodes <= XFS_ILOCK_MAX_SUBCLASS + 1);
 
+	/* XFS_DAX_* is not allowed */
+	ASSERT((lock_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
+
 	if (lock_mode & XFS_IOLOCK_EXCL) {
 		ASSERT(!(lock_mode & (XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL)));
 	} else if (lock_mode & XFS_MMAPLOCK_EXCL)
@@ -566,6 +595,10 @@ xfs_lock_two_inodes(
 	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
 	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
 
+	/* XFS_DAX_* is not allowed */
+	ASSERT((ip0_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
+	ASSERT((ip1_mode & (XFS_DAX_SHARED | XFS_DAX_EXCL)) == 0);
+
 	ASSERT(ip0->i_ino != ip1->i_ino);
 
 	if (ip0->i_ino > ip1->i_ino) {
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 492e53992fa9..693ca66bd89b 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -67,6 +67,9 @@ typedef struct xfs_inode {
 	spinlock_t		i_ioend_lock;
 	struct work_struct	i_ioend_work;
 	struct list_head	i_ioend_list;
+
+	/* protect changing the mode to/from DAX */
+	struct percpu_rw_semaphore i_dax_sem;
 } xfs_inode_t;
 
 /* Convert from vfs inode to xfs inode */
@@ -278,10 +281,13 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
 #define	XFS_ILOCK_SHARED	(1<<3)
 #define	XFS_MMAPLOCK_EXCL	(1<<4)
 #define	XFS_MMAPLOCK_SHARED	(1<<5)
+#define	XFS_DAX_EXCL		(1<<6)
+#define	XFS_DAX_SHARED		(1<<7)
 
 #define XFS_LOCK_MASK		(XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED \
 				| XFS_ILOCK_EXCL | XFS_ILOCK_SHARED \
-				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED)
+				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED \
+				| XFS_DAX_EXCL | XFS_DAX_SHARED)
 
 #define XFS_LOCK_FLAGS \
 	{ XFS_IOLOCK_EXCL,	"IOLOCK_EXCL" }, \
@@ -289,7 +295,9 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
 	{ XFS_ILOCK_EXCL,	"ILOCK_EXCL" }, \
 	{ XFS_ILOCK_SHARED,	"ILOCK_SHARED" }, \
 	{ XFS_MMAPLOCK_EXCL,	"MMAPLOCK_EXCL" }, \
-	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }
+	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }, \
+	{ XFS_DAX_EXCL,   	"DAX_EXCL" }, \
+	{ XFS_DAX_SHARED,	"DAX_SHARED" }
 
 
 /*
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d6843cdb51d0..a2f2604c3187 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1158,6 +1158,16 @@ xfs_vn_tmpfile(
 	return xfs_generic_create(dir, dentry, mode, 0, true);
 }
 
+static void xfs_lock_mode(struct inode *inode)
+{
+	xfs_ilock(XFS_I(inode), XFS_DAX_SHARED);
+}
+
+static void xfs_unlock_mode(struct inode *inode)
+{
+	xfs_iunlock(XFS_I(inode), XFS_DAX_SHARED);
+}
+
 static const struct inode_operations xfs_inode_operations = {
 	.get_acl		= xfs_get_acl,
 	.set_acl		= xfs_set_acl,
@@ -1168,6 +1178,18 @@ static const struct inode_operations xfs_inode_operations = {
 	.update_time		= xfs_vn_update_time,
 };
 
+static const struct inode_operations xfs_reg_inode_operations = {
+	.get_acl		= xfs_get_acl,
+	.set_acl		= xfs_set_acl,
+	.getattr		= xfs_vn_getattr,
+	.setattr		= xfs_vn_setattr,
+	.listxattr		= xfs_vn_listxattr,
+	.fiemap			= xfs_vn_fiemap,
+	.update_time		= xfs_vn_update_time,
+	.lock_mode              = xfs_lock_mode,
+	.unlock_mode            = xfs_unlock_mode,
+};
+
 static const struct inode_operations xfs_dir_inode_operations = {
 	.create			= xfs_vn_create,
 	.lookup			= xfs_vn_lookup,
@@ -1372,7 +1394,7 @@ xfs_setup_iops(
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_op = &xfs_inode_operations;
+		inode->i_op = &xfs_reg_inode_operations;
 		inode->i_fop = &xfs_file_operations;
 		if (IS_DAX(inode))
 			inode->i_mapping->a_ops = &xfs_dax_aops;
-- 
2.21.0

