Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7E3A77E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOHYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:24:09 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23828 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229781AbhFOHYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:24:09 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Af8MZ26nhWe7nYkRHS9oYRUlmwz7pDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="109611955"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jun 2021 15:22:03 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D0B0C4C369F7;
        Tue, 15 Jun 2021 15:22:01 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Jun 2021 15:21:50 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Jun 2021 15:21:50 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <darrick.wong@oracle.com>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v6.1 6/7] fs/xfs: Handle CoW for fsdax write() path
Date:   Tue, 15 Jun 2021 15:21:47 +0800
Message-ID: <20210615072147.73852-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <OSBPR01MB2920A2BCD568364C1363AFA6F4369@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2920A2BCD568364C1363AFA6F4369@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D0B0C4C369F7.A1B47
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Since other patches looks good, I post this RFC patch singly to hot-fix the
problem in xfs_dax_write_iomap_ops->iomap_end() of v6 that the error code was
ingored. I will split this in two patches(changes in iomap and xfs
respectively) in next formal version if it looks ok.

====

Introduce a new interface called "iomap_post_actor()" in iomap_ops.  And call it
between ->actor() and ->iomap_end().  It is mean to handle the error code
returned from ->actor().  In this patchset, it is used to remap or cancel the
CoW extents according to the error code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c               | 27 ++++++++++++++++++---------
 fs/iomap/apply.c       |  4 ++++
 fs/xfs/xfs_bmap_util.c |  3 +--
 fs/xfs/xfs_file.c      |  5 +++--
 fs/xfs/xfs_iomap.c     | 33 ++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h     | 24 ++++++++++++++++++++++++
 fs/xfs/xfs_iops.c      |  7 +++----
 fs/xfs/xfs_reflink.c   |  3 +--
 include/linux/iomap.h  |  8 ++++++++
 9 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 93f16210847b..0740c2610b6f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1537,7 +1537,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	struct iomap iomap = { .type = IOMAP_HOLE };
 	struct iomap srcmap = { .type = IOMAP_HOLE };
 	unsigned flags = IOMAP_FAULT;
-	int error;
+	int error, copied = PAGE_SIZE;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	vm_fault_t ret = 0, major = 0;
 	void *entry;
@@ -1598,7 +1598,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, false, flags,
 			      &iomap, &srcmap);
 	if (ret == VM_FAULT_SIGBUS)
-		goto finish_iomap;
+		goto finish_iomap_actor;
 
 	/* read/write MAPPED, CoW UNWRITTEN */
 	if (iomap.flags & IOMAP_F_NEW) {
@@ -1607,10 +1607,16 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		major = VM_FAULT_MAJOR;
 	}
 
+ finish_iomap_actor:
+	if (ops->iomap_post_actor) {
+		if (ret & VM_FAULT_ERROR)
+			copied = 0;
+		ops->iomap_post_actor(inode, pos, PMD_SIZE, copied, flags,
+				      &iomap, &srcmap);
+	}
+
 finish_iomap:
 	if (ops->iomap_end) {
-		int copied = PAGE_SIZE;
-
 		if (ret & VM_FAULT_ERROR)
 			copied = 0;
 		/*
@@ -1677,7 +1683,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	pgoff_t max_pgoff;
 	void *entry;
 	loff_t pos;
-	int error;
+	int error, copied = PMD_SIZE;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1736,12 +1742,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, true, flags,
 			      &iomap, &srcmap);
 
+	if (ret == VM_FAULT_FALLBACK)
+		copied = 0;
+	if (ops->iomap_post_actor) {
+		ops->iomap_post_actor(inode, pos, PMD_SIZE, copied, flags,
+				      &iomap, &srcmap);
+	}
+
 finish_iomap:
 	if (ops->iomap_end) {
-		int copied = PMD_SIZE;
-
-		if (ret == VM_FAULT_FALLBACK)
-			copied = 0;
 		/*
 		 * The fault is done by now and there's no way back (other
 		 * thread may be already happily using PMD we have installed).
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 0493da5286ad..26a54ded184f 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -84,6 +84,10 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	written = actor(inode, pos, length, data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
+	if (ops->iomap_post_actor) {
+		written = ops->iomap_post_actor(inode, pos, length, written,
+						flags, &iomap, &srcmap);
+	}
 out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a5e9d7d34023..2a36dc93ff27 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -965,8 +965,7 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+	error = xfs_iomap_zero_range(ip, offset, len, NULL);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 396ef36dcd0a..89406ec6741b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -684,11 +684,12 @@ xfs_file_dax_write(
 	pos = iocb->ki_pos;
 
 	trace_xfs_file_dax_write(iocb, from);
-	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
 	}
+
 out:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
@@ -1309,7 +1310,7 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_direct_write_iomap_ops :
+				 &xfs_dax_write_iomap_ops :
 				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d154f42e2dc6..2f322e2f8544 100644
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
@@ -854,6 +855,36 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 	.iomap_begin		= xfs_direct_write_iomap_begin,
 };
 
+static int
+xfs_dax_write_iomap_post_actor(
+	struct inode		*inode,
+	loff_t			pos,
+	loff_t			length,
+	ssize_t			written,
+	unsigned int		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	int			error = 0;
+	struct xfs_inode	*ip = XFS_I(inode);
+	bool			cow = xfs_is_cow_inode(ip);
+
+	if (written <= 0) {
+		if (cow)
+			xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		return written;
+	}
+
+	if (cow)
+		error = xfs_reflink_end_cow(ip, pos, written);
+	return error ?: written;
+}
+
+const struct iomap_ops xfs_dax_write_iomap_ops = {
+	.iomap_begin		= xfs_direct_write_iomap_begin,
+	.iomap_post_actor	= xfs_dax_write_iomap_post_actor,
+};
+
 static int
 xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e..fbacf638ab21 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -42,8 +42,32 @@ xfs_aligned_fsb_count(
 
 extern const struct iomap_ops xfs_buffered_write_iomap_ops;
 extern const struct iomap_ops xfs_direct_write_iomap_ops;
+extern const struct iomap_ops xfs_dax_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 
+static inline int
+xfs_iomap_zero_range(
+	struct xfs_inode	*ip,
+	loff_t			offset,
+	loff_t			len,
+	bool			*did_zero)
+{
+	return iomap_zero_range(VFS_I(ip), offset, len, did_zero,
+			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
+					  : &xfs_buffered_write_iomap_ops);
+}
+
+static inline int
+xfs_iomap_truncate_page(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	return iomap_truncate_page(VFS_I(ip), pos, did_zero,
+			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
+					  : &xfs_buffered_write_iomap_ops);
+}
+
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index dfe24b7f26e5..6d936c3e1a6e 100644
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
index d25434f93235..9a780948dbd0 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1266,8 +1266,7 @@ xfs_reflink_zero_posteof(
 		return 0;
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
-	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_buffered_write_iomap_ops);
+	return xfs_iomap_zero_range(ip, isize, pos - isize, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 95562f863ad0..58f2e1c78018 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -135,6 +135,14 @@ struct iomap_ops {
 			unsigned flags, struct iomap *iomap,
 			struct iomap *srcmap);
 
+	/*
+	 * Handle the error code from actor(). Do the finishing jobs for extra
+	 * operations, such as CoW, according to whether written is negative.
+	 */
+	int (*iomap_post_actor)(struct inode *inode, loff_t pos, loff_t length,
+			ssize_t written, unsigned flags, struct iomap *iomap,
+			struct iomap *srcmap);
+
 	/*
 	 * Commit and/or unreserve space previous allocated using iomap_begin.
 	 * Written indicates the length of the successful write operation which
-- 
2.31.1



