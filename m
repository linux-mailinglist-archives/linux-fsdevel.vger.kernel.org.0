Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6F137733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAJTao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:30:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:38365 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgAJTaI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="371693760"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:06 -0800
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
Subject: [RFC PATCH V2 07/12] fs: Add locking for a dynamic inode 'mode'
Date:   Fri, 10 Jan 2020 11:29:37 -0800
Message-Id: <20200110192942.25021-8-ira.weiny@intel.com>
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

DAX requires special address space operations but many other functions
check the IS_DAX() mode.

DAX is a property of the inode thus we define an inode mode lock as an
inode operation which file systems can optionally define.

This patch defines the core function callbacks as well as puts the
locking calls in place.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/filesystems/vfs.rst | 30 ++++++++++++++++
 fs/ioctl.c                        | 23 +++++++++----
 fs/open.c                         |  4 +++
 include/linux/fs.h                | 57 +++++++++++++++++++++++++++++--
 mm/fadvise.c                      | 10 ++++--
 mm/khugepaged.c                   |  2 ++
 mm/mmap.c                         |  7 ++++
 7 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..b945aa95f15a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -59,6 +59,28 @@ like open(2) the file, or stat(2) it to peek at the inode data.  The
 stat(2) operation is fairly simple: once the VFS has the dentry, it
 peeks at the inode data and passes some of it back to userspace.
 
+Changing inode 'modes' dynamically
+----------------------------------
+
+Some file systems may have different modes for their inodes which require
+dyanic changing.  A specific example of this is DAX enabled files in XFS and
+ext4.  To switch the mode safely we lock the inode mode in all "normal" file
+system operations and restrict mode changes to those operations.  The specific
+rules are.
+
+To do this a file system must follow the following rules.
+
+        1) the direct_IO address_space_operation must be supported in all
+           potential a_ops vectors for any mode suported by the inode.
+	2) Filesystems must define the lock_mode() and unlock_mode() operations
+           in struct inode_operations.  These functions are used by the core
+           vfs layers to ensure that the mode is stable before allowing the
+           core operations to proceed.
+        3) Mode changes shall not be allowed while the file is mmap'ed
+        4) While changing modes filesystems should take exclusive locks which
+           prevent the core vfs layer from proceeding.
+
+
 
 The File Object
 ---------------
@@ -437,6 +459,8 @@ As of kernel 2.6.22, the following members are defined:
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+		void (*lock_mode)(struct inode *);
+		void (*unlock_mode)(struct inode *);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -584,6 +608,12 @@ otherwise noted.
 	atomically creating, opening and unlinking a file in given
 	directory.
 
+``lock_mode``
+	called to prevent operations which depend on the inode's mode from
+        proceeding should a mode change be in progress
+
+``unlock_mode``
+	called when critical mode dependent operation is complete
 
 The Address Space Object
 ========================
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 7c9a5df5a597..ed6ab5303a24 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -55,18 +55,29 @@ EXPORT_SYMBOL(vfs_ioctl);
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
 	struct address_space *mapping = filp->f_mapping;
+	struct inode *inode = filp->f_inode;
 	int res, block;
 
+	lock_inode_mode(inode);
+
 	/* do we support this mess? */
-	if (!mapping->a_ops->bmap)
-		return -EINVAL;
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
+	if (!mapping->a_ops->bmap) {
+		res = -EINVAL;
+		goto out;
+	}
+	if (!capable(CAP_SYS_RAWIO)) {
+		res = -EPERM;
+		goto out;
+	}
 	res = get_user(block, p);
 	if (res)
-		return res;
+		goto out;
 	res = mapping->a_ops->bmap(mapping, block);
-	return put_user(res, p);
+	res = put_user(res, p);
+
+out:
+	unlock_inode_mode(inode);
+	return res;
 }
 
 /**
diff --git a/fs/open.c b/fs/open.c
index b0be77ea8f1b..c62428bbc525 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -59,10 +59,12 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	if (ret)
 		newattrs.ia_valid |= ret | ATTR_FORCE;
 
+	lock_inode_mode(dentry->d_inode);
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+	unlock_inode_mode(dentry->d_inode);
 	return ret;
 }
 
@@ -306,7 +308,9 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	file_start_write(file);
+	lock_inode_mode(inode);
 	ret = file->f_op->fallocate(file, mode, offset, len);
+	unlock_inode_mode(inode);
 
 	/*
 	 * Create inotify and fanotify events.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e11989502eac..631f11d6246e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -359,6 +359,11 @@ typedef struct {
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
+/**
+ * NOTE: DO NOT define new functions in address_space_operations without first
+ * considering how dynamic inode modes can be supported.  See the comment in
+ * struct inode_operations for the lock_mode() and unlock_mode() callbacks.
+ */
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
@@ -1817,6 +1822,11 @@ struct block_device_operations;
 
 struct iov_iter;
 
+/**
+ * NOTE: DO NOT define new functions in file_operations without first
+ * considering how dynamic inode modes can be supported.  See the comment in
+ * struct inode_operations for the lock_mode() and unlock_mode() callbacks.
+ */
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1859,6 +1869,20 @@ struct file_operations {
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 } __randomize_layout;
 
+/*
+ * Filesystems wishing to support dynamic inode modes must do the following.
+ *
+ * 1) the direct_IO address_space_operation must be supported in all
+ *    potential a_ops vectors for any mode suported by the inode.
+ * 2) Filesystems must define the lock_mode() and unlock_mode() operations
+ *    in struct inode_operations.  These functions are used by the core
+ *    vfs layers to ensure that the mode is stable before allowing the
+ *    core operations to proceed.
+ * 3) Mode changes shall not be allowed while the file is mmap'ed
+ * 4) While changing modes filesystems should take exclusive locks which
+ *    prevent the core vfs layer from proceeding.
+ *
+ */
 struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
@@ -1887,18 +1911,47 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	void (*lock_mode)(struct inode*);
+	void (*unlock_mode)(struct inode*);
 } ____cacheline_aligned;
 
+static inline void lock_inode_mode(struct inode *inode)
+{
+	WARN_ON_ONCE(inode->i_op->lock_mode &&
+		     !inode->i_op->unlock_mode);
+	if (inode->i_op->lock_mode)
+		inode->i_op->lock_mode(inode);
+}
+static inline void unlock_inode_mode(struct inode *inode)
+{
+	WARN_ON_ONCE(inode->i_op->unlock_mode &&
+		     !inode->i_op->lock_mode);
+	if (inode->i_op->unlock_mode)
+		inode->i_op->unlock_mode(inode);
+}
+
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
-	return file->f_op->read_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	lock_inode_mode(inode);
+	ret = file->f_op->read_iter(kio, iter);
+	unlock_inode_mode(inode);
+	return ret;
 }
 
 static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
 				      struct iov_iter *iter)
 {
-	return file->f_op->write_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	lock_inode_mode(inode);
+	ret = file->f_op->write_iter(kio, iter);
+	unlock_inode_mode(inode);
+	return ret;
 }
 
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 4f17c83db575..a4095a5deac8 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -47,7 +47,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	bdi = inode_to_bdi(mapping->host);
 
+	lock_inode_mode(inode);
 	if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
+		int ret = 0;
+
 		switch (advice) {
 		case POSIX_FADV_NORMAL:
 		case POSIX_FADV_RANDOM:
@@ -58,10 +61,13 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			/* no bad return value, but ignore advice */
 			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
-		return 0;
+
+		unlock_inode_mode(inode);
+		return ret;
 	}
+	unlock_inode_mode(inode);
 
 	/*
 	 * Careful about overflows. Len == 0 means "as much as possible".  Use
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..ff49da065db0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1592,9 +1592,11 @@ static void collapse_file(struct mm_struct *mm,
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
 				xas_unlock_irq(&xas);
+				lock_inode_mode(file->f_inode);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  PAGE_SIZE);
+				unlock_inode_mode(file->f_inode);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
diff --git a/mm/mmap.c b/mm/mmap.c
index 70f67c4515aa..dfaf1130e706 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1542,11 +1542,18 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (file)
+		lock_inode_mode(file_inode(file));
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
 		*populate = len;
+
+	if (file)
+		unlock_inode_mode(file_inode(file));
+
 	return addr;
 }
 
-- 
2.21.0

