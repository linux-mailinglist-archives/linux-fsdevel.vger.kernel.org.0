Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF715677F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBHTfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Feb 2020 14:35:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:29572 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbgBHTew (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:34:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="255763687"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 11:34:51 -0800
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
Subject: [PATCH v3 07/12] fs: Add locking for a dynamic DAX state
Date:   Sat,  8 Feb 2020 11:34:40 -0800
Message-Id: <20200208193445.27421-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200208193445.27421-1-ira.weiny@intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DAX requires special address space operations but many other functions
check the IS_DAX() state.

While DAX is a property of the inode we perfer a lock at the super block
level because of the overhead of a rwsem within the inode.

Define a vfs per superblock percpu rs semaphore to lock the DAX state
while performing various VFS layer operations.  Write lock calls are
provided here but are used in subsequent patches by the file systems
themselves.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2

	Rebase on linux-next-08-02-2020

	Fix locking order
	Change all references from mode to state where appropriate
	add CONFIG_FS_DAX requirement for state change
	Use a static branch to enable locking only when a dax capable
		device has been seen.

	Move the lock to a global vfs lock

		this does a few things
			1) preps us better for ext4 support
			2) removes funky callbacks from inode ops
			3) remove complexity from XFS and probably from
			   ext4 later

		We can do this because
			1) the locking order is required to be at the
			   highest level anyway, so why complicate xfs
			2) We had to move the sem to the super_block
			   because it is too heavy for the inode.
			3) After internal discussions with Dan we
			   decided that this would be easier, just as
			   performant, and with slightly less overhead
			   than in the VFS SB.

		We also change the functions names to up/down;
		read/write as appropriate.  Previous names were over
		simplified.

	Update comments and documentation

 Documentation/filesystems/vfs.rst | 17 +++++++
 fs/attr.c                         |  1 +
 fs/dax.c                          |  3 ++
 fs/inode.c                        | 14 ++++--
 fs/iomap/buffered-io.c            |  1 +
 fs/open.c                         |  4 ++
 fs/stat.c                         |  2 +
 fs/super.c                        |  3 ++
 include/linux/fs.h                | 78 ++++++++++++++++++++++++++++++-
 mm/fadvise.c                      | 10 +++-
 mm/filemap.c                      |  4 ++
 mm/huge_memory.c                  |  1 +
 mm/khugepaged.c                   |  2 +
 mm/madvise.c                      |  3 ++
 mm/util.c                         |  9 +++-
 15 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..cd011ceb4b72 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -934,6 +934,23 @@ cache in your filesystem.  The following members are defined:
 	Called during swapoff on files where swap_activate was
 	successful.
 
+Changing DAX 'state' dynamically
+----------------------------------
+
+Some file systems which support DAX want to be able to change the DAX state
+dyanically.  To switch the state safely we lock the inode state in all "normal"
+file system operations and restrict state changes to those operations.  The
+specific rules are.
+
+        1) the direct_IO address_space_operation must be supported in all
+           potential a_ops vectors for any state suported by the inode.
+        2) FS's should enable the static branch lock_dax_state_static_key when a DAX
+           capable device is detected.
+        3) DAX state changes shall not be allowed while the file is mmap'ed
+        4) For non-mmaped operations the VFS layer must take the read lock for any
+           use of IS_DAX()
+        5) Filesystems take the write lock when changing DAX states.
+
 
 The File Object
 ===============
diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..9b15f73d1079 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -332,6 +332,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (error)
 		return error;
 
+	/* DAX read state should already be held here */
 	if (inode->i_op->setattr)
 		error = inode->i_op->setattr(dentry, attr);
 	else
diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..96136866f151 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -30,6 +30,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
 
+DEFINE_STATIC_KEY_FALSE(lock_dax_state_static_key);
+EXPORT_SYMBOL(lock_dax_state_static_key);
+
 static inline unsigned int pe_order(enum page_entry_size pe_size)
 {
 	if (pe_size == PE_SIZE_PTE)
diff --git a/fs/inode.c b/fs/inode.c
index 7d57068b6b7a..7d0227f9e3e8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1616,11 +1616,19 @@ EXPORT_SYMBOL(iput);
  */
 int bmap(struct inode *inode, sector_t *block)
 {
-	if (!inode->i_mapping->a_ops->bmap)
-		return -EINVAL;
+	int ret = 0;
+
+	inode_dax_state_down_read(inode);
+	if (!inode->i_mapping->a_ops->bmap) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
-	return 0;
+
+err:
+	inode_dax_state_up_read(inode);
+	return ret;
 }
 EXPORT_SYMBOL(bmap);
 #endif
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7c84c4c027c4..e313a34d5fa6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -999,6 +999,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
+		/* DAX state read should already be held here */
 		if (IS_DAX(inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..148980e30611 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -59,10 +59,12 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	if (ret)
 		newattrs.ia_valid |= ret | ATTR_FORCE;
 
+	inode_dax_state_down_read(dentry->d_inode);
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+	inode_dax_state_up_read(dentry->d_inode);
 	return ret;
 }
 
@@ -306,7 +308,9 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	file_start_write(file);
+	inode_dax_state_down_read(inode);
 	ret = file->f_op->fallocate(file, mode, offset, len);
+	inode_dax_state_up_read(inode);
 
 	/*
 	 * Create inotify and fanotify events.
diff --git a/fs/stat.c b/fs/stat.c
index 894699c74dde..bf8841314c08 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -79,8 +79,10 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
+	inode_dax_state_down_read(inode);
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
+	inode_dax_state_up_read(inode);
 
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..3e26e3a1d860 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -51,6 +51,9 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
 	"sb_internal",
 };
 
+DEFINE_PERCPU_RWSEM(sb_dax_rwsem);
+EXPORT_SYMBOL(sb_dax_rwsem);
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63d1e533a07d..1a22cd94c4ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/percpu-rwsem.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -359,6 +360,11 @@ typedef struct {
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
+/**
+ * NOTE: DO NOT define new functions in address_space_operations without first
+ * considering how dynamic DAX states are to be supported.  See the
+ * inode_dax_state_*_read() functions
+ */
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
@@ -1817,6 +1823,11 @@ struct block_device_operations;
 
 struct iov_iter;
 
+/**
+ * NOTE: DO NOT define new functions in file_operations without first
+ * considering how dynamic DAX states are to be supported.  See the
+ * inode_dax_state_*_read() functions
+ */
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1889,16 +1900,79 @@ struct inode_operations {
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
+#if defined(CONFIG_FS_DAX)
+/*
+ * Filesystems wishing to support dynamic DAX states must do the following.
+ *
+ * 1) the direct_IO address_space_operation must be supported in all
+ *    potential a_ops vectors for any state suported by the inode.
+ * 2) FS's should enable the static branch lock_dax_state_static_key when a DAX
+ *    capable device is detected.
+ * 3) DAX state changes shall not be allowed while the file is mmap'ed
+ * 4) For non-mmaped operations the VFS layer must take the read lock for any
+ *    use of IS_DAX()
+ * 5) Filesystems take the write lock when changing DAX states.
+ */
+DECLARE_STATIC_KEY_FALSE(lock_dax_state_static_key);
+extern struct percpu_rw_semaphore sb_dax_rwsem;
+static inline void inode_dax_state_down_read(struct inode *inode)
+{
+	if (!static_branch_unlikely(&lock_dax_state_static_key))
+		return;
+	percpu_down_read(&sb_dax_rwsem);
+}
+static inline void inode_dax_state_up_read(struct inode *inode)
+{
+	if (!static_branch_unlikely(&lock_dax_state_static_key))
+		return;
+	percpu_up_read(&sb_dax_rwsem);
+}
+static inline void inode_dax_state_down_write(struct inode *inode)
+{
+	if (!static_branch_unlikely(&lock_dax_state_static_key))
+		return;
+	percpu_down_write(&sb_dax_rwsem);
+}
+static inline void inode_dax_state_up_write(struct inode *inode)
+{
+	if (!static_branch_unlikely(&lock_dax_state_static_key))
+		return;
+	percpu_up_write(&sb_dax_rwsem);
+}
+static inline void enable_dax_state_static_branch(void)
+{
+	static_branch_enable(&lock_dax_state_static_key);
+}
+#else /* !CONFIG_FS_DAX */
+#define inode_dax_state_down_read(inode) do { (void)(inode); } while (0)
+#define inode_dax_state_up_read(inode) do { (void)(inode); } while (0)
+#define inode_dax_state_down_write(inode) do { (void)(inode); } while (0)
+#define inode_dax_state_up_write(inode) do { (void)(inode); } while (0)
+#define enable_dax_state_static_branch()
+#endif /* CONFIG_FS_DAX */
+
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
-	return file->f_op->read_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	inode_dax_state_down_read(inode);
+	ret = file->f_op->read_iter(kio, iter);
+	inode_dax_state_up_read(inode);
+	return ret;
 }
 
 static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
 				      struct iov_iter *iter)
 {
-	return file->f_op->write_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	inode_dax_state_down_read(inode);
+	ret = file->f_op->write_iter(kio, iter);
+	inode_dax_state_up_read(inode);
+	return ret;
 }
 
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 4f17c83db575..ac85eb778c74 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -47,7 +47,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	bdi = inode_to_bdi(mapping->host);
 
+	inode_dax_state_down_read(inode);
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
+		inode_dax_state_up_read(inode);
+		return ret;
 	}
+	inode_dax_state_up_read(inode);
 
 	/*
 	 * Careful about overflows. Len == 0 means "as much as possible".  Use
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..3a7863ba51b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2293,6 +2293,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * and return.  Otherwise fallthrough to buffered io for
 		 * the rest of the read.  Buffered reads will not work for
 		 * DAX files, so don't bother trying.
+		 *
+		 * IS_DAX is protected under ->read_iter lock
 		 */
 		if (retval < 0 || !count || iocb->ki_pos >= size ||
 		    IS_DAX(inode))
@@ -3377,6 +3379,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * holes, for example.  For DAX files, a buffered write will
 		 * not succeed (even if it did, DAX does not handle dirty
 		 * page-cache pages correctly).
+		 *
+		 * IS_DAX is protected under ->write_iter lock
 		 */
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..3d05bd10d83e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -572,6 +572,7 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
+	/* Should not need locking here because mmap is not allowed */
 	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
 		goto out;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..3bec46277886 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1592,9 +1592,11 @@ static void collapse_file(struct mm_struct *mm,
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
 				xas_unlock_irq(&xas);
+				inode_dax_state_down_read(file->f_inode);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  PAGE_SIZE);
+				inode_dax_state_up_read(file->f_inode);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..419b7c26216b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -275,10 +275,13 @@ static long madvise_willneed(struct vm_area_struct *vma,
 		return -EBADF;
 #endif
 
+	inode_dax_state_down_read(file_inode(file));
 	if (IS_DAX(file_inode(file))) {
+		inode_dax_state_up_read(file_inode(file));
 		/* no bad return value, but ignore advice */
 		return 0;
 	}
+	inode_dax_state_up_read(file_inode(file));
 
 	/*
 	 * Filesystem's fadvise may need to take various locks.  We need to
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..8dfb9958f2a6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -501,11 +501,18 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 
 	ret = security_mmap_file(file, prot, flag);
 	if (!ret) {
-		if (down_write_killable(&mm->mmap_sem))
+		if (file)
+			inode_dax_state_down_read(file_inode(file));
+		if (down_write_killable(&mm->mmap_sem)) {
+			if (file)
+				inode_dax_state_up_read(file_inode(file));
 			return -EINTR;
+		}
 		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
 				    &populate, &uf);
 		up_write(&mm->mmap_sem);
+		if (file)
+			inode_dax_state_up_read(file_inode(file));
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
 			mm_populate(ret, populate);
-- 
2.21.0

