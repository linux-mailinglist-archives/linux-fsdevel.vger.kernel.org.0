Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92600DD92F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfJSOpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O/Ult98tKoprP/NtwRUiDlPLD7WMfFE9Ty7Q7LiLBDg=; b=VO0BU/d+6CrwIJodIC0p5YMANq
        nWHtuHlmPGiH9qrUVuqUUg1tM+te5u41Cknr59+EHXQ4Wxv7xfVofQWXVxibO+Gw2BBWrWIVh0Rai
        LNrdr3AjNOwGcvBToeDL4Nh+2f50K7RhNhCQMdVGnMVk+xDoi9hmLW99CU+TiadqnfbdvnMs+Z2P9
        nfUBapGt2kyN5mVg5+4rvKoCTNHjm7095Z18DBn0RhtmAyBDbJDNpbcTCXdBB8nVN9kgENBoP7sXC
        DpHpxO9/O85pnWMPgIgcMy3mBneRKfIDmogxjKR29I3n8QfYYN0VJ1QLxuHk0pXbBQxfWglF+Tljx
        z+GmalUA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpys-0003Az-Cw; Sat, 19 Oct 2019 14:45:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 09/12] xfs: split the iomap ops for buffered vs direct writes
Date:   Sat, 19 Oct 2019 16:44:45 +0200
Message-Id: <20191019144448.21483-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019144448.21483-1-hch@lst.de>
References: <20191019144448.21483-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of lots of magic conditionals in the main write_begin
handler this make the intent very clear.  Thing will become even
better once we support delayed allocations for extent size hints
and realtime allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  3 ++-
 fs/xfs/xfs_file.c      | 16 ++++++-----
 fs/xfs/xfs_iomap.c     | 61 +++++++++++++++---------------------------
 fs/xfs/xfs_iomap.h     |  3 ++-
 fs/xfs/xfs_iops.c      |  4 +--
 fs/xfs/xfs_reflink.c   |  5 ++--
 6 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 4f443703065e..5d8632b7f549 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1113,7 +1113,8 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL, &xfs_iomap_ops);
+	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
+			&xfs_buffered_write_iomap_ops);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e3299ffdf090..24659667d5cb 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -352,7 +352,7 @@ xfs_file_aio_write_checks(
 	
 		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
 		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
-				NULL, &xfs_iomap_ops);
+				NULL, &xfs_buffered_write_iomap_ops);
 		if (error)
 			return error;
 	} else
@@ -552,7 +552,8 @@ xfs_file_dio_aio_write(
 	 * If unaligned, this is the only IO in-flight. Wait on it before we
 	 * release the iolock to prevent subsequent overlapping IO.
 	 */
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			   &xfs_dio_write_ops,
 			   is_sync_kiocb(iocb) || unaligned_io);
 out:
 	xfs_iunlock(ip, iolock);
@@ -592,7 +593,7 @@ xfs_file_dax_write(
 	count = iov_iter_count(from);
 
 	trace_xfs_file_dax_write(ip, count, pos);
-	ret = dax_iomap_rw(iocb, from, &xfs_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -639,7 +640,8 @@ xfs_file_buffered_aio_write(
 	current->backing_dev_info = inode_to_bdi(inode);
 
 	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
-	ret = iomap_file_buffered_write(iocb, from, &xfs_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from,
+			&xfs_buffered_write_iomap_ops);
 	if (likely(ret >= 0))
 		iocb->ki_pos += ret;
 
@@ -1156,12 +1158,14 @@ __xfs_filemap_fault(
 
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
 				(write_fault && !vmf->cow_page) ?
-				 &xfs_iomap_ops : &xfs_read_iomap_ops);
+				 &xfs_direct_write_iomap_ops :
+				 &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 	} else {
 		if (write_fault)
-			ret = iomap_page_mkwrite(vmf, &xfs_iomap_ops);
+			ret = iomap_page_mkwrite(vmf,
+					&xfs_buffered_write_iomap_ops);
 		else
 			ret = filemap_fault(vmf);
 	}
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index bbe0ca4ff10d..a706da8ffe22 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -719,16 +719,7 @@ xfs_ilock_for_iomap(
 }
 
 static int
-xfs_file_iomap_begin_delay(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			count,
-	unsigned		flags,
-	struct iomap		*iomap,
-	struct iomap		*srcmap);
-
-static int
-xfs_file_iomap_begin(
+xfs_direct_write_iomap_begin(
 	struct inode		*inode,
 	loff_t			offset,
 	loff_t			length,
@@ -751,13 +742,6 @@ xfs_file_iomap_begin(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	if (!(flags & IOMAP_DIRECT) && !IS_DAX(inode) &&
-	    !xfs_get_extsz_hint(ip)) {
-		/* Reserve delalloc blocks for regular writeback. */
-		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
-				iomap, srcmap);
-	}
-
 	/*
 	 * Lock the inode in the manner required for the specified operation and
 	 * check for as many conditions that would result in blocking as
@@ -864,8 +848,12 @@ xfs_file_iomap_begin(
 	return error;
 }
 
+const struct iomap_ops xfs_direct_write_iomap_ops = {
+	.iomap_begin		= xfs_direct_write_iomap_begin,
+};
+
 static int
-xfs_file_iomap_begin_delay(
+xfs_buffered_write_iomap_begin(
 	struct inode		*inode,
 	loff_t			offset,
 	loff_t			count,
@@ -884,8 +872,12 @@ xfs_file_iomap_begin_delay(
 	int			whichfork = XFS_DATA_FORK;
 	int			error = 0;
 
+	/* we can't use delayed allocations when using extent size hints */
+	if (xfs_get_extsz_hint(ip))
+		return xfs_direct_write_iomap_begin(inode, offset, count,
+				flags, iomap, srcmap);
+
 	ASSERT(!XFS_IS_REALTIME_INODE(ip));
-	ASSERT(!xfs_get_extsz_hint(ip));
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 
@@ -1077,18 +1069,23 @@ xfs_file_iomap_begin_delay(
 }
 
 static int
-xfs_file_iomap_end_delalloc(
-	struct xfs_inode	*ip,
+xfs_buffered_write_iomap_end(
+	struct inode		*inode,
 	loff_t			offset,
 	loff_t			length,
 	ssize_t			written,
+	unsigned		flags,
 	struct iomap		*iomap)
 {
+	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		start_fsb;
 	xfs_fileoff_t		end_fsb;
 	int			error = 0;
 
+	if (iomap->type != IOMAP_DELALLOC)
+		return 0;
+
 	/*
 	 * Behave as if the write failed if drop writes is enabled. Set the NEW
 	 * flag to force delalloc cleanup.
@@ -1133,25 +1130,9 @@ xfs_file_iomap_end_delalloc(
 	return 0;
 }
 
-static int
-xfs_file_iomap_end(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
-	ssize_t			written,
-	unsigned		flags,
-	struct iomap		*iomap)
-{
-	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
-	    iomap->type == IOMAP_DELALLOC)
-		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
-				length, written, iomap);
-	return 0;
-}
-
-const struct iomap_ops xfs_iomap_ops = {
-	.iomap_begin		= xfs_file_iomap_begin,
-	.iomap_end		= xfs_file_iomap_end,
+const struct iomap_ops xfs_buffered_write_iomap_ops = {
+	.iomap_begin		= xfs_buffered_write_iomap_begin,
+	.iomap_end		= xfs_buffered_write_iomap_end,
 };
 
 static int
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 61b1fc3e5143..7aed28275089 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -39,7 +39,8 @@ xfs_aligned_fsb_count(
 	return count_fsb;
 }
 
-extern const struct iomap_ops xfs_iomap_ops;
+extern const struct iomap_ops xfs_buffered_write_iomap_ops;
+extern const struct iomap_ops xfs_direct_write_iomap_ops;
 extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 9c448a54a951..329a34af8e79 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -883,10 +883,10 @@ xfs_setattr_size(
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
 		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_iomap_ops);
+				&did_zeroing, &xfs_buffered_write_iomap_ops);
 	} else {
 		error = iomap_truncate_page(inode, newsize, &did_zeroing,
-				&xfs_iomap_ops);
+				&xfs_buffered_write_iomap_ops);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 19a6e4644123..1e18b4024b82 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1270,7 +1270,7 @@ xfs_reflink_zero_posteof(
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
 	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_iomap_ops);
+			&xfs_buffered_write_iomap_ops);
 }
 
 /*
@@ -1527,7 +1527,8 @@ xfs_reflink_unshare(
 
 	inode_dio_wait(inode);
 
-	error = iomap_file_unshare(inode, offset, len, &xfs_iomap_ops);
+	error = iomap_file_unshare(inode, offset, len,
+			&xfs_buffered_write_iomap_ops);
 	if (error)
 		goto out;
 	error = filemap_write_and_wait(inode->i_mapping);
-- 
2.20.1

