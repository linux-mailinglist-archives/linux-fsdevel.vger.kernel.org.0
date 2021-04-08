Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51B13582D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhDHMFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:05:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24879 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230467AbhDHMFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:05:36 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AWSmrB64l1Mx8I0MRhwPXwCjXdLJzesId70hD?=
 =?us-ascii?q?6mlaTxtJfsuE0/2/hfhz726RtB89elEF3eqBNq6JXG/G+fdOjLU5EL++UGDd1l?=
 =?us-ascii?q?eAA41v4IDryT+lOwCWzIRg/Ih6dawWMrzNJHxbqeq/3wWiCdYnx7C8gcWVrMPT?=
 =?us-ascii?q?1W1kQw0vS4wI1XYbNi+hHkd7RBZLCPMCffLy2uN8uzGidX4LB/7LZEUtYu6rnb?=
 =?us-ascii?q?32vaOjSRsHKjpi0wOWkA6vgYSQLzGomjsYTBNDqI1PzVT4?=
X-IronPort-AV: E=Sophos;i="5.82,206,1613404800"; 
   d="scan'208";a="106797311"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Apr 2021 20:05:23 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2EBEE4CF2676;
        Thu,  8 Apr 2021 20:05:18 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 8 Apr 2021 20:05:08 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 8 Apr 2021 20:05:07 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>
Subject: [PATCH v4 6/7] fs/xfs: Handle CoW for fsdax write() path
Date:   Thu, 8 Apr 2021 20:04:31 +0800
Message-ID: <20210408120432.1063608-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2EBEE4CF2676.A45D4
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
index e7d68318e6a5..9fcea33dd2c9 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -954,8 +954,7 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+	error = xfs_iomap_zero_range(VFS_I(ip), offset, len, NULL);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a007ca0711d9..5795d5d6f869 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -684,11 +684,8 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
-	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
-		i_size_write(inode, iocb->ki_pos);
-		error = xfs_setfilesize(ip, pos, ret);
-	}
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
+
 out:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
@@ -1309,7 +1306,7 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
+				 &xfs_dax_write_iomap_ops :
 				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index e17ab7f42928..f818f989687b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -760,7 +760,8 @@ xfs_direct_write_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode,
+				flags & IOMAP_DIRECT || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
 		if (shared)
@@ -853,6 +854,38 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
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
@@ -1314,3 +1347,26 @@ xfs_xattr_iomap_begin(
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
index 66ebccb5a6ff..db8eeaa8a773 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -879,8 +879,8 @@ xfs_setattr_size(
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
@@ -892,8 +892,7 @@ xfs_setattr_size(
 						     newsize);
 		if (error)
 			return error;
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = xfs_iomap_truncate_page(inode, newsize, &did_zeroing);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 9ef9f98725a2..a4cd6e8a7aa0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1266,8 +1266,7 @@ xfs_reflink_zero_posteof(
 		return 0;
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
-	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_buffered_write_iomap_ops);
+	return xfs_iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL);
 }
 
 /*
-- 
2.31.0



