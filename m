Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5CADEF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfIIS2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:28:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MESDqbigWLTBKHYIAWuUbGVEmz0Ugva6SL8AA8H9eA4=; b=TeEGaU2yYckQ3sZy1rpC9kMTz
        cmGG0+jEBddetimtJKYHBMG2CP9SERNBI6FN+r0rJsg2s60wtX0xRPUSErNZ5w3jNro/eDkm3AjDH
        U+2Ei2euBV90+xsPCJnNeEtczLCJPjqMCNdqMozmYFjZK9T5R50euNs9qNDPKkrGLX2q9YvPq1PTv
        iYPotXsESv6P3LHZBItNMwJzK9f1OO5elZUMUcmUCHdzoH3EMsghkvaBuo7yx970oClknan8n3miV
        iwEerXgygWSdN/JXh44DTXt7afiR8vzGs8RLC2fzRj3L8WfUXweo/kzRP/0KXu4HpGQ9DpdEF/Rzv
        fBqZSMqTQ==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOW-00026j-9f; Mon, 09 Sep 2019 18:28:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/19] xfs: split the iomap ops for buffered vs direct writes
Date:   Mon,  9 Sep 2019 20:27:19 +0200
Message-Id: <20190909182722.16783-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
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
---
 fs/xfs/xfs_bmap_util.c |  3 ++-
 fs/xfs/xfs_file.c      | 16 ++++++-----
 fs/xfs/xfs_iomap.c     | 61 +++++++++++++++---------------------------
 fs/xfs/xfs_iomap.h     |  3 ++-
 fs/xfs/xfs_iops.c      |  4 +--
 fs/xfs/xfs_reflink.c   |  5 ++--
 6 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 98c6a7a71427..a4a4813e9cc6 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1111,7 +1111,8 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL, &xfs_iomap_ops);
+	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
+			&xfs_buffered_write_iomap_ops);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d8e2e36b84f7..b2ea030485e9 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -350,7 +350,7 @@ xfs_file_aio_write_checks(
 	
 		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
 		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
-				NULL, &xfs_iomap_ops);
+				NULL, &xfs_buffered_write_iomap_ops);
 		if (error)
 			return error;
 	} else
@@ -546,7 +546,8 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
+	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
+			   &xfs_dio_write_ops);
 
 	/*
 	 * If unaligned, this is the only IO in-flight. If it has not yet
@@ -593,7 +594,7 @@ xfs_file_dax_write(
 	count = iov_iter_count(from);
 
 	trace_xfs_file_dax_write(ip, count, pos);
-	ret = dax_iomap_rw(iocb, from, &xfs_iomap_ops);
+	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
 	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
 		i_size_write(inode, iocb->ki_pos);
 		error = xfs_setfilesize(ip, pos, ret);
@@ -640,7 +641,8 @@ xfs_file_buffered_aio_write(
 	current->backing_dev_info = inode_to_bdi(inode);
 
 	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
-	ret = iomap_file_buffered_write(iocb, from, &xfs_iomap_ops);
+	ret = iomap_file_buffered_write(iocb, from,
+			&xfs_buffered_write_iomap_ops);
 	if (likely(ret >= 0))
 		iocb->ki_pos += ret;
 
@@ -1133,12 +1135,14 @@ __xfs_filemap_fault(
 
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
index 7ae55503ee27..6dd143374d75 100644
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
@@ -857,8 +841,12 @@ xfs_file_iomap_begin(
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
@@ -877,8 +865,12 @@ xfs_file_iomap_begin_delay(
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
 
@@ -1070,18 +1062,23 @@ xfs_file_iomap_begin_delay(
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
@@ -1126,25 +1123,9 @@ xfs_file_iomap_end_delalloc(
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
index f0c7df82e18b..5c1154e761ca 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -882,10 +882,10 @@ xfs_setattr_size(
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
index 673018a618f0..c68700c3a64a 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1270,7 +1270,7 @@ xfs_reflink_zero_posteof(
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
 	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_iomap_ops);
+			&xfs_buffered_write_iomap_ops);
 }
 
 /*
@@ -1532,7 +1532,8 @@ xfs_reflink_unshare(
 
 	inode_dio_wait(inode);
 
-	error = iomap_file_unshare(inode, offset, len, &xfs_iomap_ops);
+	error = iomap_file_unshare(inode, offset, len,
+			&xfs_buffered_write_iomap_ops);
 	if (error)
 		goto out;
 	error = filemap_write_and_wait(inode->i_mapping);
-- 
2.20.1

