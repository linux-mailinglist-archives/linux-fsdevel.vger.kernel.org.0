Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21E340C3E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhIOKr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 06:47:28 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56889 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237592AbhIOKrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:47:22 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AtJiYrKkMm/e4LFL/E5twbl/o5gz6J0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzAAmmEWWGmFPauIMWGgfdp/Oomw905QsJ7dzN8xGwZq+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuWJQUVUj/nSH+KtUbO?=
 =?us-ascii?q?cYUideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHj7JXClxKcG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJqkS+1ol+wiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVetl6UoK8f52nI0Bc?=
 =?us-ascii?q?31LnrLcqTdtGULe1VlUawonnauWj0ajkAO9ubxSWU9Fq3m/TC2y/2MKoWFbul5?=
 =?us-ascii?q?rtkm1Ge2GEXIAMZWEH9ovSjjEO6HdVFJCQ8/isosLh390GxSNT5dwO3rWTCvRM?=
 =?us-ascii?q?GXddUVeog52mlzqvS/hbcFmYfZiBOZcZgt8IsQzEukFiTkLvBGz11t5WHRHSc6?=
 =?us-ascii?q?PGQrDWvKW4SN2BEeCxscOevy7EPu6lq1lSWEIklS/Xz07XI9fjL62jihEADa38?=
 =?us-ascii?q?70abnD5mGwG0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0ZAPJ68suSk9lV1wwK9uk+C9I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY0TiX2ra2TdZggvyMc6wxxZJhDo7+90cC7KBu2yXcc2/hzAV7IZmXbUQ?=
 =?us-ascii?q?WTQr1f0Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="114519072"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2021 18:45:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0A9AC4D0DC76;
        Wed, 15 Sep 2021 18:45:54 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 18:45:48 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 15 Sep 2021 18:45:47 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Date:   Wed, 15 Sep 2021 18:45:00 +0800
Message-ID: <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0A9AC4D0DC76.A4DD2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
After that, new allocated extents needs to be remapped to the file.
So, add a CoW identification in ->iomap_begin(), and implement
->iomap_end() to do the remapping work.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_bmap_util.c |  3 +--
 fs/xfs/xfs_file.c      |  6 +++---
 fs/xfs/xfs_iomap.c     | 38 +++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     | 30 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.c      |  7 +++----
 fs/xfs/xfs_reflink.c   |  3 +--
 6 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 73a36b7be3bd..0681250e0a5d 100644
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
index 7aa943edfc02..2ef1930374d2 100644
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
@@ -1329,8 +1329,8 @@ __xfs_filemap_fault(
 		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
-				 &xfs_read_iomap_ops);
+					&xfs_dax_write_iomap_ops :
+					&xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 093758440ad5..6fa3b377cb81 100644
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
@@ -854,6 +855,41 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
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
+	struct xfs_inode	*ip = XFS_I(inode);
+	/*
+	 * Usually we use @written to indicate whether the operation was
+	 * successful.  But it is always positive or zero.  The CoW needs the
+	 * actual error code from actor().  So, get it from
+	 * iomap_iter->processed.
+	 */
+	const struct iomap_iter *iter =
+				container_of(iomap, typeof(*iter), iomap);
+
+	if (!xfs_is_cow_inode(ip))
+		return 0;
+
+	if (iter->processed <= 0) {
+		xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		return 0;
+	}
+
+	return xfs_reflink_end_cow(ip, pos, iter->processed);
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
index 7d3703556d0e..92679a0c3578 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -45,5 +45,35 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
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
+	return iomap_zero_range(inode, pos, len, did_zero,
+			IS_DAX(inode) ?
+				&xfs_dax_write_iomap_ops :
+				&xfs_buffered_write_iomap_ops);
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
+	return iomap_truncate_page(inode, pos, did_zero,
+			IS_DAX(inode)?
+				&xfs_dax_write_iomap_ops :
+				&xfs_buffered_write_iomap_ops);
+}
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a607d6aca5c4..332e6208dffd 100644
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
index 7ecea0311e88..9d876e268734 100644
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
-- 
2.33.0



