Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4D5ADEEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfIIS2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:28:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jT8xK3X6S08HtNcFh2mz5fZ1USkp3JqeMKW/9J5WoEA=; b=hcPS4QukCLuPdI6kVhN9dY2CG
        sqN/B5G2muo0mrxAahHtR905A7Aqm/La756meHPOYOp8pB9L9JsCIZAGZwrOmRujyOLrQcy2VWPtQ
        mBVaoi68k8yMtoN4rF/oKEAoMiPqCy2mXpGPbQvp9Q77g0hts6EEX9FZGFpoko/LG4g84+TfFYJ4A
        RSd5C13lA2vpwubypdnnyop/oYA0IWR9ekkQrqzt/1F+r6nwE0N7tvzA2E8FAbGPAA0dSG5t4JVSv
        7UDjRTgS/zilS2ae8fDccX/v61f5AqbShy4tQoiHTPDzkL2bF7gU2aVkS6u6j7CICzziIHkRcLGKs
        tN8gWMKyQ==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOR-00025X-EP; Mon, 09 Sep 2019 18:28:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/19] xfs: split out a new set of read-only iomap ops
Date:   Mon,  9 Sep 2019 20:27:17 +0200
Message-Id: <20190909182722.16783-15-hch@lst.de>
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

Start untangling xfs_file_iomap_begin by splitting out the read-only
case into its own set of iomap_ops with a very simply iomap_begin
helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c  |  9 ++++---
 fs/xfs/xfs_file.c  |  8 +++---
 fs/xfs/xfs_iomap.c | 61 ++++++++++++++++++++++++++++++++++------------
 fs/xfs/xfs_iomap.h |  1 +
 fs/xfs/xfs_iops.c  |  2 +-
 5 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4e4a4d7df5ac..fe47a4d52247 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1158,7 +1158,7 @@ xfs_vm_bmap(
 	 */
 	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
 		return 0;
-	return iomap_bmap(mapping, block, &xfs_iomap_ops);
+	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
 STATIC int
@@ -1167,7 +1167,7 @@ xfs_vm_readpage(
 	struct page		*page)
 {
 	trace_xfs_vm_readpage(page->mapping->host, 1);
-	return iomap_readpage(page, &xfs_iomap_ops);
+	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
 
 STATIC int
@@ -1178,7 +1178,7 @@ xfs_vm_readpages(
 	unsigned		nr_pages)
 {
 	trace_xfs_vm_readpages(mapping->host, nr_pages);
-	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
+	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
 }
 
 static int
@@ -1188,7 +1188,8 @@ xfs_iomap_swapfile_activate(
 	sector_t			*span)
 {
 	sis->bdev = xfs_find_bdev_for_inode(file_inode(swap_file));
-	return iomap_swapfile_activate(sis, swap_file, span, &xfs_iomap_ops);
+	return iomap_swapfile_activate(sis, swap_file, span,
+			&xfs_read_iomap_ops);
 }
 
 const struct address_space_operations xfs_address_space_operations = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 21bd3d575aaa..d8e2e36b84f7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -187,7 +187,7 @@ xfs_file_dio_aio_read(
 	file_accessed(iocb->ki_filp);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -214,7 +214,7 @@ xfs_file_dax_read(
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
 
-	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
+	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	file_accessed(iocb->ki_filp);
@@ -1131,7 +1131,9 @@ __xfs_filemap_fault(
 	if (IS_DAX(inode)) {
 		pfn_t pfn;
 
-		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &xfs_iomap_ops);
+		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
+				(write_fault && !vmf->cow_page) ?
+				 &xfs_iomap_ops : &xfs_read_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 	} else {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0ba67a8d8169..d0ed0cba9041 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -950,11 +950,13 @@ xfs_file_iomap_begin(
 	u16			iomap_flags = 0;
 	unsigned		lockmode;
 
+	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
+
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
-			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
+	if (!(flags & IOMAP_DIRECT) && !IS_DAX(inode) &&
+	    !xfs_get_extsz_hint(ip)) {
 		/* Reserve delalloc blocks for regular writeback. */
 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
 				iomap, srcmap);
@@ -975,17 +977,6 @@ xfs_file_iomap_begin(
 	if (error)
 		goto out_unlock;
 
-	if (flags & IOMAP_REPORT) {
-		/* Trim the mapping to the nearest shared extent boundary. */
-		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
-		if (error)
-			goto out_unlock;
-	}
-
-	/* Non-modifying mapping requested, so we are done */
-	if (!(flags & (IOMAP_WRITE | IOMAP_ZERO)))
-		goto out_found;
-
 	/*
 	 * Break shared extents if necessary. Checks for non-blocking IO have
 	 * been done up front, so we don't need to do them here.
@@ -1046,8 +1037,6 @@ xfs_file_iomap_begin(
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 
 out_finish:
-	if (shared)
-		iomap_flags |= IOMAP_F_SHARED;
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
 
 out_found:
@@ -1150,6 +1139,48 @@ const struct iomap_ops xfs_iomap_ops = {
 	.iomap_end		= xfs_file_iomap_end,
 };
 
+static int
+xfs_read_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_bmbt_irec	imap;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	int			nimaps = 1, error = 0;
+	bool			shared = false;
+	unsigned		lockmode;
+
+	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
+
+	if (XFS_FORCED_SHUTDOWN(mp))
+		return -EIO;
+
+	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	if (error)
+		return error;
+	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
+			       &nimaps, 0);
+	if (!error && (flags & IOMAP_REPORT))
+		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
+	xfs_iunlock(ip, lockmode);
+
+	if (error)
+		return error;
+	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared ? IOMAP_F_SHARED : 0);
+}
+
+const struct iomap_ops xfs_read_iomap_ops = {
+	.iomap_begin		= xfs_read_iomap_begin,
+};
+
 static int
 xfs_seek_iomap_begin(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 71d0ae460c44..61b1fc3e5143 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -40,6 +40,7 @@ xfs_aligned_fsb_count(
 }
 
 extern const struct iomap_ops xfs_iomap_ops;
+extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ff3c1fae5357..f0c7df82e18b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1113,7 +1113,7 @@ xfs_vn_fiemap(
 				&xfs_xattr_iomap_ops);
 	} else {
 		error = iomap_fiemap(inode, fieinfo, start, length,
-				&xfs_iomap_ops);
+				&xfs_read_iomap_ops);
 	}
 	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
 
-- 
2.20.1

