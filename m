Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61157171067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 06:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgB0Fcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 00:32:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:43439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgB0Fcp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:44 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="317670179"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:44 -0800
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
Subject: [PATCH V5 07/12] fs: Prevent DAX state change if file is mmap'ed
Date:   Wed, 26 Feb 2020 21:24:37 -0800
Message-Id: <20200227052442.22524-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200227052442.22524-1-ira.weiny@intel.com>
References: <20200227052442.22524-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Page faults need to ensure the inode DAX configuration is correct and
consistent with the vmf information at the time of the fault.  There is
no easy way to ensure the vmf information is correct if a DAX change is
in progress.  Furthermore, there is no good use case to require changing
DAX configs while the file is mmap'ed.

Track mmap's of the file and fail the DAX change if the file is mmap'ed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:

	move 'i_mapped' to struct address_space and rename mmap_count
	Add inode_has_mappings() helper for FS's
	Change reference to "mode" to "state"
---
Changes from V3:
	Fix htmldoc error from the kbuild test robot.
	Reported-by: kbuild test robot <lkp@intel.com>
	Rebase cleanups
---
 fs/inode.c         |  1 +
 fs/xfs/xfs_ioctl.c |  9 +++++++++
 include/linux/fs.h |  7 +++++++
 mm/mmap.c          | 19 +++++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6e4f1cc872f2..613a045075bd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -372,6 +372,7 @@ static void __address_space_init_once(struct address_space *mapping)
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
 	mapping->i_mmap = RB_ROOT_CACHED;
+	atomic64_set(&mapping->mmap_count, 0);
 }
 
 void address_space_init_once(struct address_space *mapping)
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 25e12ce85075..498fae2ef9f6 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1207,6 +1207,15 @@ xfs_ioctl_setattr_dax_invalidate(
 
 	/* lock, flush and invalidate mapping in preparation for flag change */
 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
+
+	/*
+	 * If there is a mapping in place we must remain in our current state.
+	 */
+	if (inode_has_mappings(inode)) {
+		error = -EBUSY;
+		goto out_unlock;
+	}
+
 	error = filemap_write_and_wait(inode->i_mapping);
 	if (error)
 		goto out_unlock;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22cc1aa980f5..cf18a3c38562 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -438,6 +438,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
+ * @mmap_count: The number of times this AS has been mmap'ed
  * @nrpages: Number of page entries, protected by the i_pages lock.
  * @nrexceptional: Shadow or DAX entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
@@ -459,6 +460,7 @@ struct address_space {
 #endif
 	struct rb_root_cached	i_mmap;
 	struct rw_semaphore	i_mmap_rwsem;
+	atomic64_t              mmap_count;
 	unsigned long		nrpages;
 	unsigned long		nrexceptional;
 	pgoff_t			writeback_index;
@@ -1937,6 +1939,11 @@ static inline void inode_aops_up_write(struct inode *inode)
 #define inode_aops_up_write(inode) do { (void)(inode); } while (0)
 #endif /* CONFIG_FS_DAX */
 
+static inline bool inode_has_mappings(struct inode *inode)
+{
+	return (atomic64_read(&inode->i_mapping->mmap_count) != 0);
+}
+
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 7cc2562b99fd..6bb16a0996b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -171,12 +171,17 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *next = vma->vm_next;
+	struct file *f = vma->vm_file;
 
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
-	if (vma->vm_file)
-		fput(vma->vm_file);
+	if (f) {
+		struct inode *inode = file_inode(f);
+		if (inode)
+			atomic64_dec(&inode->i_mapping->mmap_count);
+		fput(f);
+	}
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
 	return next;
@@ -1830,6 +1835,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
+	/*
+	 * Track if there is mapping in place such that a state change
+	 * does not occur on a file which is mapped
+	 */
+	if (file) {
+		struct inode		*inode = file_inode(file);
+
+		atomic64_inc(&inode->i_mapping->mmap_count);
+	}
+
 	return addr;
 
 unmap_and_free_vma:
-- 
2.21.0

