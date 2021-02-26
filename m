Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BEF325AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 01:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhBZA3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 19:29:07 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8517 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233313AbhBZA27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:28:59 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="104882847"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Feb 2021 08:21:36 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 359364CE6D8A;
        Fri, 26 Feb 2021 08:21:31 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 08:21:31 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 08:21:31 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Date:   Fri, 26 Feb 2021 08:20:29 +0800
Message-ID: <20210226002030.653855-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 359364CE6D8A.A44C2
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
 fs/xfs/xfs_bmap_util.c |  3 ++-
 fs/xfs/xfs_file.c      |  9 +++------
 fs/xfs/xfs_iomap.c     | 30 +++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     |  1 +
 fs/xfs/xfs_iops.c      | 11 ++++++++---
 fs/xfs/xfs_reflink.c   |  2 ++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 7371a7f7c652..65a8782b6378 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -977,7 +977,8 @@ xfs_free_file_space(
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
 	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+		  IS_DAX(VFS_I(ip)) ?
+		  &xfs_dax_write_iomap_ops : &xfs_buffered_write_iomap_ops);
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
index 7b9ff824e82d..23c6f8c97047 100644
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
@@ -850,6 +851,33 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
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
+
+	if (pos + written > i_size_read(inode)) {
+		i_size_write(inode, pos + written);
+		error = xfs_setfilesize(ip, pos, written);
+	}
+	if (xfs_is_cow_inode(ip))
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
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..a361c2f27cf3 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -42,6 +42,7 @@ xfs_aligned_fsb_count(
 
 extern const struct iomap_ops xfs_buffered_write_iomap_ops;
 extern const struct iomap_ops xfs_direct_write_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 67c8dc9de8aa..adf4467ab862 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -841,6 +841,7 @@ xfs_setattr_size(
 	int			error;
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
+	const struct iomap_ops	*ops;
 
 	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
 	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
@@ -887,10 +888,15 @@ xfs_setattr_size(
 	 * extension, or zeroing out the rest of the block on a downward
 	 * truncate.
 	 */
+	if (IS_DAX(inode))
+		ops = &xfs_direct_write_iomap_ops;
+	else
+		ops = &xfs_buffered_write_iomap_ops;
+
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_buffered_write_iomap_ops);
+				&did_zeroing, ops);
 	} else {
 		/*
 		 * iomap won't detect a dirty page over an unwritten block (or a
@@ -902,8 +908,7 @@ xfs_setattr_size(
 						     newsize);
 		if (error)
 			return error;
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = iomap_truncate_page(inode, newsize, &did_zeroing, ops);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5b3a3da36b7..dfe4e1912ff9 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1246,6 +1246,8 @@ xfs_reflink_zero_posteof(
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
 	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
+			IS_DAX(VFS_I(ip)) ?
+			&xfs_dax_write_iomap_ops :
 			&xfs_buffered_write_iomap_ops);
 }
 
-- 
2.30.1



