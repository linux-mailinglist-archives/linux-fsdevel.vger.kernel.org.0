Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB234127B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhCSByD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:54:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41531 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233118AbhCSBxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:46 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4TDbYqroIo4wHGMDj4d8rnkaV5rLeYIsi2QD?=
 =?us-ascii?q?101hICF9WMqeisyogbAnxQb54QxhPE0ItPKhHO27QX3a/YNo+oV5B9qfdSTvpW?=
 =?us-ascii?q?fAFu9fxKTvzzDqEyf9ss5xvJ0LT4FQE9v1ZGIase/fwC2VV+kt28OG9qfAv5a6?=
 =?us-ascii?q?815IQRtxY69tqydVYzzrcXFefwVNCZonGJf03KMuyAaIQ2gdbciwGxA+Lor+ju?=
 =?us-ascii?q?DM/aiHXTc2QzYj6CSryQij8aPGFXGjtSs2YndixqgD/AH+/zDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; 
   d="scan'208";a="105876738"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:53:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7840A4CEB2AC;
        Fri, 19 Mar 2021 09:53:43 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:33 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:53:32 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v3 09/10] fs/xfs: Handle CoW for fsdax write() path
Date:   Fri, 19 Mar 2021 09:52:36 +0800
Message-ID: <20210319015237.993880-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7840A4CEB2AC.A38B4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, WRITE and ZERO on a shared extent need CoW performed. After
CoW, new allocated extents needs to be remapped to the file.  So, add an
iomap_end for dax write ops to do the remapping work.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_bmap_util.c |  3 +--
 fs/xfs/xfs_file.c      |  9 +++----
 fs/xfs/xfs_iomap.c     | 58 +++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     |  4 +++
 fs/xfs/xfs_iops.c      |  7 +++--
 fs/xfs/xfs_reflink.c   |  3 +--
 6 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 7371a7f7c652..809013de9915 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -976,8 +976,7 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+	error = xfs_iomap_zero_range(VFS_I(ip), offset, len, NULL);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f73837..1987d15eab61 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -623,11 +623,8 @@ xfs_file_dax_write(
 	count = iov_iter_count(from);
 
 	trace_xfs_file_dax_write(ip, count, pos);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
-	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
-		i_size_write(inode, iocb->ki_pos);
-		error = xfs_setfilesize(ip, pos, ret);
-	}
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
+
 out:
 	xfs_iunlock(ip, iolock);
 	if (error)
@@ -1250,7 +1247,7 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
+				 &xfs_dax_write_iomap_ops :
 				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7b9ff824e82d..0afae5dbbce1 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -771,7 +771,8 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode,
+				flags & IOMAP_DIRECT || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 		if (shared)
@@ -850,6 +851,38 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_dax_write_iomap_end(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			length,
+	ssize_t			written,
+	unsigned int		flags,
+	struct iomap		*iomap)
+{
+	int			error = 0;
+	xfs_inode_t		*ip = XFS_I(inode);
+	bool			cow = xfs_is_cow_inode(ip);
+
+	if (pos + written > i_size_read(inode)) {
+		i_size_write(inode, pos + written);
+		error = xfs_setfilesize(ip, pos, written);
+		if (error && cow) {
+			xfs_reflink_cancel_cow_range(ip, pos, written, true);
+			return error;
+		}
+	}
+	if (cow)
+		error = xfs_reflink_end_cow(ip, pos, written);
+
+	return error;
+}
+
+const struct iomap_ops xfs_dax_write_iomap_ops = {
+	.iomap_begin		= xfs_direct_write_iomap_begin,
+	.iomap_end		= xfs_dax_write_iomap_end,
+};
+
 static int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
@@ -1308,3 +1341,26 @@ xfs_xattr_iomap_begin(
 const struct iomap_ops xfs_xattr_iomap_ops = {
 	.iomap_begin		= xfs_xattr_iomap_begin,
 };
+
+int
+xfs_iomap_zero_range(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			len,
+	bool			*did_zero)
+{
+	return iomap_zero_range(inode, offset, len, did_zero,
+			IS_DAX(inode) ? &xfs_dax_write_iomap_ops :
+					&xfs_buffered_write_iomap_ops);
+}
+
+int
+xfs_iomap_truncate_page(
+	struct inode		*inode,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	return iomap_truncate_page(inode, pos, did_zero,
+			IS_DAX(inode) ? &xfs_dax_write_iomap_ops :
+					&xfs_buffered_write_iomap_ops);
+}
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..8adb2bf78a5a 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -14,6 +14,9 @@ struct xfs_bmbt_irec;
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, struct xfs_bmbt_irec *imap);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
+int xfs_iomap_zero_range(struct inode *inode, loff_t offset, loff_t len,
+		bool *did_zero);
+int xfs_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
@@ -42,6 +45,7 @@ xfs_aligned_fsb_count(
 
 extern const struct iomap_ops xfs_buffered_write_iomap_ops;
 extern const struct iomap_ops xfs_direct_write_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 67c8dc9de8aa..2281161e05c8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -889,8 +889,8 @@ xfs_setattr_size(
 	 */
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
-		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_buffered_write_iomap_ops);
+		error = xfs_iomap_zero_range(inode, oldsize, newsize - oldsize,
+				&did_zeroing);
 	} else {
 		/*
 		 * iomap won't detect a dirty page over an unwritten block (or a
@@ -902,8 +902,7 @@ xfs_setattr_size(
 						     newsize);
 		if (error)
 			return error;
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = xfs_iomap_truncate_page(inode, newsize, &did_zeroing);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5b3a3da36b7..73c556c2ff76 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1245,8 +1245,7 @@ xfs_reflink_zero_posteof(
 		return 0;
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
-	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_buffered_write_iomap_ops);
+	return xfs_iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL);
 }
 
 /*
-- 
2.30.1



