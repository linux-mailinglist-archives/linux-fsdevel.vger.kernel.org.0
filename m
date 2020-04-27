Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4891B9ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgD0ItB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:49:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3144 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbgD0Isq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547664"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B54804BCC892;
        Mon, 27 Apr 2020 16:37:56 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:39 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:38 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 7/8] fs/xfs: handle CoW for fsdax write() path
Date:   Mon, 27 Apr 2020 16:47:49 +0800
Message-ID: <20200427084750.136031-8-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B54804BCC892.AE0AE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, WRITE and ZERO on a shared extent need CoW mechanism
performed.  After CoW, new extents needs to be remapped to the file.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

fs/dax.c: fix nrexceptional count error.
---
 fs/xfs/xfs_bmap_util.c |  6 +++++-
 fs/xfs/xfs_file.c      | 10 +++++++---
 fs/xfs/xfs_iomap.c     |  3 ++-
 fs/xfs/xfs_iops.c      | 11 ++++++++---
 fs/xfs/xfs_reflink.c   |  2 ++
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 4f800f7fe888..8980120415ba 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -969,10 +969,14 @@ xfs_free_file_space(
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
 	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+		  IS_DAX(VFS_I(ip)) ?
+		  &xfs_direct_write_iomap_ops : &xfs_buffered_write_iomap_ops);
 	if (error)
 		return error;
 
+	if (xfs_is_reflink_inode(ip))
+		xfs_reflink_end_cow(ip, offset, len);
+
 	/*
 	 * If we zeroed right up to EOF and EOF straddles a page boundary we
 	 * must make sure that the post-EOF area is also zeroed because the
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4b8bdecc3863..2f8a83b2605d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -588,9 +588,13 @@ xfs_file_dax_write(
 
 	trace_xfs_file_dax_write(ip, count, pos);
 	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
-	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
-		i_size_write(inode, iocb->ki_pos);
-		error = xfs_setfilesize(ip, pos, ret);
+	if (ret > 0) {
+		if (iocb->ki_pos > i_size_read(inode)) {
+			i_size_write(inode, iocb->ki_pos);
+			error = xfs_setfilesize(ip, pos, ret);
+		}
+		if (xfs_is_cow_inode(ip))
+			xfs_reflink_end_cow(ip, pos, ret);
 	}
 out:
 	xfs_iunlock(ip, iolock);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index bb590a267a7f..ca92f76498c9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -754,13 +754,14 @@ xfs_direct_write_iomap_begin(
 		goto out_unlock;
 
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
+		bool need_convert = flags & IOMAP_DIRECT || IS_DAX(inode);
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
 			goto out_unlock;
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, flags & IOMAP_DIRECT);
+				&lockmode, need_convert);
 		if (error)
 			goto out_unlock;
 		if (shared)
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f7a99b3bbcf7..92b58ae06c0e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -864,6 +864,7 @@ xfs_setattr_size(
 	int			error;
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
+	const struct iomap_ops	*ops;
 
 	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
 	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
@@ -910,13 +911,17 @@ xfs_setattr_size(
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
-		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_buffered_write_iomap_ops);
+		error = iomap_truncate_page(inode, newsize, &did_zeroing, ops);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 792217cd1e64..f87ab78dd421 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1269,6 +1269,8 @@ xfs_reflink_zero_posteof(
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
 	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
+			IS_DAX(VFS_I(ip)) ?
+			&xfs_direct_write_iomap_ops :
 			&xfs_buffered_write_iomap_ops);
 }
 
-- 
2.26.2



