Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9F3FAB68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhH2M1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 08:27:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56559 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235251AbhH2M0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:26:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AGUOow6zr/8aI6j5AsWZfKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.84,361,1620662400"; 
   d="scan'208";a="113656472"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Aug 2021 20:25:56 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F21474D0D4A1;
        Sun, 29 Aug 2021 20:25:49 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:47 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 29 Aug 2021 20:25:43 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v8 6/7] xfs: support CoW in fsdax mode
Date:   Sun, 29 Aug 2021 20:25:16 +0800
Message-ID: <20210829122517.1648171-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F21474D0D4A1.A3EE9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
After that, new allocated extents needs to be remapped to the file.  Add
an implementation of ->iomap_end() for dax write ops to do the remapping
work.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c               | 39 ++++++++++++++++++++++++++++++++++++---
 fs/iomap/buffered-io.c |  3 ++-
 fs/xfs/xfs_bmap_util.c |  3 +--
 fs/xfs/xfs_file.c      |  4 ++--
 fs/xfs/xfs_iomap.c     | 32 +++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     | 32 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.c      |  7 +++----
 fs/xfs/xfs_reflink.c   |  3 +--
 include/linux/dax.h    |  4 ++++
 include/linux/iomap.h  |  1 +
 10 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a1232d6b7e37..88541b734f97 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1401,6 +1401,39 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(dax_iomap_rw);
 
+int
+dax_iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
+		bool *did_zero, const struct iomap_ops *ops)
+{
+	struct iomap_iter iomi = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_ZERO,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = iomap_zero_iter(&iomi, did_zero);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_iomap_zero_range);
+
+int
+dax_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops)
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
@@ -1521,7 +1554,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       int *iomap_errp, const struct iomap_ops *ops)
+		int *iomap_errp, const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
@@ -1631,7 +1664,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 }
 
 static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
-			       const struct iomap_ops *ops)
+		const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
@@ -1732,7 +1765,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+		pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
 {
 	switch (pe_size) {
 	case PE_SIZE_PTE:
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
index cc3cfb12df53..d57f94c523c7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -704,7 +704,7 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -1329,7 +1329,7 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
+				 &xfs_dax_write_iomap_ops :
 				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d8cd2583dedb..c037a47004f9 100644
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
@@ -854,6 +855,35 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_dax_write_iomap_end(
+	struct inode 		*inode,
+	loff_t 			pos,
+	loff_t 			length,
+	ssize_t 		written,
+	unsigned 		flags,
+	struct iomap 		*iomap)
+{
+	int			error = 0;
+	struct xfs_inode	*ip = XFS_I(inode);
+	bool			cow = xfs_is_cow_inode(ip);
+	const struct iomap_iter *iter =
+				container_of(iomap, typeof(*iter), iomap);
+
+	if (cow) {
+		if (iter->processed <= 0)
+			xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		else
+			error = xfs_reflink_end_cow(ip, pos, iter->processed);
+	}
+	return error ?: iter->processed;
+}
+
+const struct iomap_ops xfs_dax_write_iomap_ops = {
+	.iomap_begin 	= xfs_direct_write_iomap_begin,
+	.iomap_end	= xfs_dax_write_iomap_end,
+};
+
 static int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..1ca9f9102523 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -45,5 +45,37 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
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
index 8ecd125434ef..96b1f0bb4ab8 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -237,6 +237,10 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int dax_iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
+		bool *did_zero, const struct iomap_ops *ops);
+int dax_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops);
 s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
 		const struct iomap *srcmap);
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24f8489583ca..b32cbdb74c49 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -235,6 +235,7 @@ int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 #endif
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.32.0



