Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEA3ECE60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhHPGF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:05:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38875 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233564AbhHPGFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:05:24 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaMVawK3sFnzHTZxTGD1mwwqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="112944887"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Aug 2021 14:04:47 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1A0504D0D4B1;
        Mon, 16 Aug 2021 14:04:42 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 14:04:31 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 Aug 2021 14:04:30 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v7 7/8] fsdax: Introduce dax_iomap_ops for end of reflink
Date:   Mon, 16 Aug 2021 14:03:58 +0800
Message-ID: <20210816060359.1442450-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1A0504D0D4B1.A093C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After writing data, reflink requires end operations to remap those new
allocated extents.  The current ->iomap_end() ignores the error code
returned from ->actor(), so we introduce this dax_iomap_ops and change
the dax_iomap_*() interfaces to do this job.

- the dax_iomap_ops contains the original struct iomap_ops and fsdax
    specific ->actor_end(), which is for the end operations of reflink
- also introduce dax specific zero_range, truncate_page
- create new dax_iomap_ops for ext2 and ext4

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c               | 68 +++++++++++++++++++++++++++++++++++++-----
 fs/ext2/ext2.h         |  3 ++
 fs/ext2/file.c         |  6 ++--
 fs/ext2/inode.c        | 11 +++++--
 fs/ext4/ext4.h         |  3 ++
 fs/ext4/file.c         |  6 ++--
 fs/ext4/inode.c        | 13 ++++++--
 fs/iomap/buffered-io.c |  3 +-
 fs/xfs/xfs_bmap_util.c |  3 +-
 fs/xfs/xfs_file.c      |  8 ++---
 fs/xfs/xfs_iomap.c     | 36 +++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     | 33 ++++++++++++++++++++
 fs/xfs/xfs_iops.c      |  7 ++---
 fs/xfs/xfs_reflink.c   |  3 +-
 include/linux/dax.h    | 21 ++++++++++---
 include/linux/iomap.h  |  1 +
 16 files changed, 189 insertions(+), 36 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 74dd918cff1f..0e0536765a7e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1348,11 +1348,30 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	return done ? done : ret;
 }
 
+static inline int
+__dax_iomap_iter(struct iomap_iter *iter, const struct dax_iomap_ops *ops)
+{
+	int ret;
+
+	/*
+	 * Call dax_iomap_ops->actor_end() before iomap_ops->iomap_end() in
+	 * each iteration.
+	 */
+	if (iter->iomap.length && ops->actor_end) {
+		ret = ops->actor_end(iter->inode, iter->pos, iter->len,
+				     iter->processed);
+		if (ret < 0)
+			return ret;
+	}
+
+	return iomap_iter(iter, &ops->iomap_ops);
+}
+
 /**
  * dax_iomap_rw - Perform I/O to a DAX file
  * @iocb:	The control block for this I/O
  * @iter:	The addresses to do I/O from or to
- * @ops:	iomap ops passed from the file system
+ * @ops:	dax iomap ops passed from the file system
  *
  * This function performs read and write operations to directly mapped
  * persistent memory.  The callers needs to take care of read/write exclusion
@@ -1360,7 +1379,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
  */
 ssize_t
 dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops)
+		const struct dax_iomap_ops *ops)
 {
 	struct iomap_iter iomi = {
 		.inode		= iocb->ki_filp->f_mapping->host,
@@ -1380,7 +1399,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	while ((ret = iomap_iter(&iomi, ops)) > 0)
+	while ((ret = __dax_iomap_iter(&iomi, ops)) > 0)
 		iomi.processed = dax_iomap_iter(&iomi, iter);
 
 	done = iomi.pos - iocb->ki_pos;
@@ -1389,6 +1408,39 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(dax_iomap_rw);
 
+int
+dax_iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
+		bool *did_zero, const struct dax_iomap_ops *ops)
+{
+	struct iomap_iter iomi = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_ZERO,
+	};
+	int ret;
+
+	while ((ret = __dax_iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = iomap_zero_iter(&iomi, did_zero);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_iomap_zero_range);
+
+int
+dax_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct dax_iomap_ops *ops)
+{
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+
+	/* Block boundary? Nothing to do */
+	if (!off)
+		return 0;
+	return dax_iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+}
+EXPORT_SYMBOL_GPL(dax_iomap_truncate_page);
+
 static vm_fault_t dax_fault_return(int error)
 {
 	if (error == 0)
@@ -1531,7 +1583,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       int *iomap_errp, const struct iomap_ops *ops)
+		int *iomap_errp, const struct dax_iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
@@ -1576,7 +1628,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		goto unlock_entry;
 	}
 
-	while ((error = iomap_iter(&iter, ops)) > 0) {
+	while ((error = __dax_iomap_iter(&iter, ops)) > 0) {
 		if (WARN_ON_ONCE(iomap_length(&iter) < PAGE_SIZE)) {
 			iter.processed = -EIO;	/* fs corruption? */
 			continue;
@@ -1641,7 +1693,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 }
 
 static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       const struct iomap_ops *ops)
+		const struct dax_iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
@@ -1700,7 +1752,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	}
 
 	iter.pos = (loff_t)xas.xa_index << PAGE_SHIFT;
-	while ((error = iomap_iter(&iter, ops)) > 0) {
+	while ((error = __dax_iomap_iter(&iter, ops)) > 0) {
 		if (iomap_length(&iter) < PMD_SIZE)
 			continue; /* actually breaks out of the loop */
 
@@ -1742,7 +1794,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+		pfn_t *pfnp, int *iomap_errp, const struct dax_iomap_ops *ops)
 {
 	switch (pe_size) {
 	case PE_SIZE_PTE:
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index e512630cb63e..b04f3e2fe11f 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -807,6 +807,9 @@ extern void ext2_set_file_ops(struct inode *inode);
 extern const struct address_space_operations ext2_aops;
 extern const struct address_space_operations ext2_nobh_aops;
 extern const struct iomap_ops ext2_iomap_ops;
+#ifdef CONFIG_FS_DAX
+extern const struct dax_iomap_ops ext2_dax_iomap_ops;
+#endif
 
 /* namei.c */
 extern const struct inode_operations ext2_dir_inode_operations;
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index f98466acc672..d5dd82111128 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -39,7 +39,7 @@ static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		return 0; /* skip atime */
 
 	inode_lock_shared(inode);
-	ret = dax_iomap_rw(iocb, to, &ext2_iomap_ops);
+	ret = dax_iomap_rw(iocb, to, &ext2_dax_iomap_ops);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -63,7 +63,7 @@ static ssize_t ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret)
 		goto out_unlock;
 
-	ret = dax_iomap_rw(iocb, from, &ext2_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &ext2_dax_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		mark_inode_dirty(inode);
@@ -102,7 +102,7 @@ static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 	}
 	down_read(&ei->dax_sem);
 
-	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
+	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_dax_iomap_ops);
 
 	up_read(&ei->dax_sem);
 	if (write)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dadb121beb22..deb1a117aa74 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -852,6 +852,13 @@ const struct iomap_ops ext2_iomap_ops = {
 	.iomap_begin		= ext2_iomap_begin,
 	.iomap_end		= ext2_iomap_end,
 };
+
+const struct dax_iomap_ops ext2_dax_iomap_ops = {
+	.iomap_ops	= {
+		.iomap_begin	= ext2_iomap_begin,
+		.iomap_end	= ext2_iomap_end,
+	},
+};
 #else
 /* Define empty ops for !CONFIG_FS_DAX case to avoid ugly ifdefs */
 const struct iomap_ops ext2_iomap_ops;
@@ -1296,9 +1303,9 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode)) {
-		error = iomap_zero_range(inode, newsize,
+		error = dax_iomap_zero_range(inode, newsize,
 					 PAGE_ALIGN(newsize) - newsize, NULL,
-					 &ext2_iomap_ops);
+					 &ext2_dax_iomap_ops);
 	} else if (test_opt(inode->i_sb, NOBH))
 		error = nobh_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..59829d63cb89 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3787,6 +3787,9 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
+#ifdef CONFIG_FS_DAX
+extern const struct dax_iomap_ops ext4_dax_iomap_ops;
+#endif
 extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 816dedcbd541..a7a3497429ca 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -102,7 +102,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		/* Fallback to buffered IO in case we cannot support DAX */
 		return generic_file_read_iter(iocb, to);
 	}
-	ret = dax_iomap_rw(iocb, to, &ext4_iomap_ops);
+	ret = dax_iomap_rw(iocb, to, &ext4_dax_iomap_ops);
 	inode_unlock_shared(inode);
 
 	file_accessed(iocb->ki_filp);
@@ -650,7 +650,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &ext4_dax_iomap_ops);
 
 	if (extend)
 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
@@ -721,7 +721,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	} else {
 		down_read(&EXT4_I(inode)->i_mmap_sem);
 	}
-	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
+	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_dax_iomap_ops);
 	if (write) {
 		ext4_journal_stop(handle);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..c0ac5e1384e6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3523,6 +3523,15 @@ const struct iomap_ops ext4_iomap_ops = {
 	.iomap_end		= ext4_iomap_end,
 };
 
+#ifdef CONFIG_FS_DAX
+const struct dax_iomap_ops ext4_dax_iomap_ops = {
+	.iomap_ops		= {
+		.iomap_begin = ext4_iomap_begin,
+		.iomap_end   = ext4_iomap_end,
+	},
+};
+#endif
+
 const struct iomap_ops ext4_iomap_overwrite_ops = {
 	.iomap_begin		= ext4_iomap_overwrite_begin,
 	.iomap_end		= ext4_iomap_end,
@@ -3840,8 +3849,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		length = max;
 
 	if (IS_DAX(inode)) {
-		return iomap_zero_range(inode, from, length, NULL,
-					&ext4_iomap_ops);
+		return dax_iomap_zero_range(inode, from, length, NULL,
+					    &ext4_dax_iomap_ops);
 	}
 	return __ext4_block_zero_page_range(handle, mapping, from, length);
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6e8d40877d01..6341a1328def 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -887,7 +887,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 	return iomap_write_end(iter, pos, bytes, bytes, page);
 }
 
-static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -918,6 +918,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 
 	return written;
 }
+EXPORT_SYMBOL_GPL(iomap_zero_iter);
 
 int
 iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 213a97a921bb..f1b7a2637a1d 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1009,8 +1009,7 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+	error = xfs_iomap_zero_range(ip, offset, len, NULL);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index cc3cfb12df53..226e3fbaf405 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -281,7 +281,7 @@ xfs_file_dax_read(
 	ret = xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
-	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
+	ret = dax_iomap_rw(iocb, to, &xfs_dax_read_iomap_ops);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	file_accessed(iocb->ki_filp);
@@ -704,7 +704,7 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -1329,8 +1329,8 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
-				 &xfs_read_iomap_ops);
+				 &xfs_dax_write_iomap_ops :
+				 &xfs_dax_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 	} else {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d8cd2583dedb..4b0f405304ce 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -761,7 +761,8 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode,
+				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 		if (shared)
@@ -854,6 +855,33 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_dax_write_iomap_actor_end(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			length,
+	ssize_t			written)
+{
+	int			error = 0;
+	struct xfs_inode	*ip = XFS_I(inode);
+	bool			cow = xfs_is_cow_inode(ip);
+
+	if (cow) {
+		if (written <= 0)
+			xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		else
+			error = xfs_reflink_end_cow(ip, pos, written);
+	}
+	return error ?: written;
+}
+
+const struct dax_iomap_ops xfs_dax_write_iomap_ops = {
+	.iomap_ops		= {
+		.iomap_begin = xfs_direct_write_iomap_begin,
+	},
+	.actor_end		= xfs_dax_write_iomap_actor_end,
+};
+
 static int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
@@ -1184,6 +1212,12 @@ const struct iomap_ops xfs_read_iomap_ops = {
 	.iomap_begin		= xfs_read_iomap_begin,
 };
 
+const struct dax_iomap_ops xfs_dax_read_iomap_ops = {
+	.iomap_ops		= {
+		.iomap_begin = xfs_read_iomap_begin,
+	},
+};
+
 static int
 xfs_seek_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..5eacb5d8ca88 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -45,5 +45,38 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
+extern const struct dax_iomap_ops xfs_dax_write_iomap_ops;
+extern const struct dax_iomap_ops xfs_dax_read_iomap_ops;
+
+static inline int
+xfs_iomap_zero_range(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	loff_t			len,
+	bool			*did_zero)
+{
+	struct inode		*inode = VFS_I(ip);
+
+	return IS_DAX(inode)
+			? dax_iomap_zero_range(inode, pos, len, did_zero,
+					       &xfs_dax_write_iomap_ops)
+			: iomap_zero_range(inode, pos, len, did_zero,
+					       &xfs_buffered_write_iomap_ops);
+}
+
+static inline int
+xfs_iomap_truncate_page(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	struct inode		*inode = VFS_I(ip);
+
+	return IS_DAX(inode)
+			? dax_iomap_truncate_page(inode, pos, did_zero,
+					       &xfs_dax_write_iomap_ops)
+			: iomap_truncate_page(inode, pos, did_zero,
+					       &xfs_buffered_write_iomap_ops);
+}
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 93c082db04b7..0380f6942bc0 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -911,8 +911,8 @@ xfs_setattr_size(
 	 */
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
-		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_buffered_write_iomap_ops);
+		error = xfs_iomap_zero_range(ip, oldsize, newsize - oldsize,
+				&did_zeroing);
 	} else {
 		/*
 		 * iomap won't detect a dirty page over an unwritten block (or a
@@ -924,8 +924,7 @@ xfs_setattr_size(
 						     newsize);
 		if (error)
 			return error;
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = xfs_iomap_truncate_page(ip, newsize, &did_zeroing);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 28effe537d07..13e461cf2055 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1269,8 +1269,7 @@ xfs_reflink_zero_posteof(
 		return 0;
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
-	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_buffered_write_iomap_ops);
+	return xfs_iomap_zero_range(ip, isize, pos - isize, NULL);
 }
 
 /*
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 8ecd125434ef..aff5617578ba 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -3,6 +3,7 @@
 #define _LINUX_DAX_H
 
 #include <linux/fs.h>
+#include <linux/iomap.h>
 #include <linux/mm.h>
 #include <linux/radix-tree.h>
 
@@ -11,8 +12,6 @@
 
 typedef unsigned long dax_entry_t;
 
-struct iomap_ops;
-struct iomap;
 struct dax_device;
 struct dax_operations {
 	/*
@@ -38,6 +37,16 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct dax_iomap_ops {
+	/* the original iomap ops */
+	struct iomap_ops iomap_ops;
+	/*
+	 * actor_end: accept error code returned from ->actor(), deal with it
+	 * before ->iomap_end()
+	 */
+	int (*actor_end)(struct inode *, loff_t, loff_t, ssize_t);
+};
+
 extern struct attribute_group dax_attribute_group;
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -229,14 +238,18 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops);
+		const struct dax_iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
+		pfn_t *pfnp, int *errp, const struct dax_iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int dax_iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
+		bool *did_zero, const struct dax_iomap_ops *ops);
+int dax_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct dax_iomap_ops *ops);
 s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
 		const struct iomap *srcmap);
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index ebef060c65cd..8cdb94e749d9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -237,6 +237,7 @@ int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 #endif
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.32.0



