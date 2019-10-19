Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B0DD92B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJSOpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jHYFjeLRaM3gEOKk0fNtinn4mmlj0CtPRhLPxOzPDGk=; b=sbJf+d95wiUwWlcdwVpbuOnIGH
        3155bllUq8HyC6DDEhGT09YoFdO8C2Eomr6DhdSwpCCNeFySO95Qi0SB992hUPIjdzSa4uJdLBHIy
        CGWxiRcN1cX3DOea/tiqRwjzaT67ib9bAUy3CFOyCTwY/B6WIA2EA7DIUdw9YrOCeLNVb9mlhaZAm
        8ynFyADwKATxE8NsEFOKGqwWTaOWproyIz6GgzBNGB+Pvh0XFBjdlbqUsdkHW3cxPgixE1nb6jvm+
        hQNLwIUzYJE0Efmi2AsDum390zXT2W2BRWX48HS6apN222Lg6+GcTg6VxJv+ObJGeD/vlXPadohuA
        nruKS7gw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyl-00039W-IB; Sat, 19 Oct 2019 14:45:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 07/12] xfs: split out a new set of read-only iomap ops
Date:   Sat, 19 Oct 2019 16:44:43 +0200
Message-Id: <20191019144448.21483-8-hch@lst.de>
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

Start untangling xfs_file_iomap_begin by splitting out the read-only
case into its own set of iomap_ops with a very simply iomap_begin
helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c  |  9 ++++---
 fs/xfs/xfs_file.c  |  9 ++++---
 fs/xfs/xfs_iomap.c | 63 ++++++++++++++++++++++++++++++++++------------
 fs/xfs/xfs_iomap.h |  1 +
 fs/xfs/xfs_iops.c  |  2 +-
 5 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5936507c6f50..5d3503f6412a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -634,7 +634,7 @@ xfs_vm_bmap(
 	 */
 	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
 		return 0;
-	return iomap_bmap(mapping, block, &xfs_iomap_ops);
+	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
 STATIC int
@@ -642,7 +642,7 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	return iomap_readpage(page, &xfs_iomap_ops);
+	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
 
 STATIC int
@@ -652,7 +652,7 @@ xfs_vm_readpages(
 	struct list_head	*pages,
 	unsigned		nr_pages)
 {
-	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
+	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
 }
 
 static int
@@ -662,7 +662,8 @@ xfs_iomap_swapfile_activate(
 	sector_t			*span)
 {
 	sis->bdev = xfs_find_bdev_for_inode(file_inode(swap_file));
-	return iomap_swapfile_activate(sis, swap_file, span, &xfs_iomap_ops);
+	return iomap_swapfile_activate(sis, swap_file, span,
+			&xfs_read_iomap_ops);
 }
 
 const struct address_space_operations xfs_address_space_operations = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c0620135a279..e3299ffdf090 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -188,7 +188,8 @@ xfs_file_dio_aio_read(
 	file_accessed(iocb->ki_filp);
 
 	xfs_ilock(ip, XFS_IOLOCK_SHARED);
-	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL, is_sync_kiocb(iocb));
+	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
+			is_sync_kiocb(iocb));
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	return ret;
@@ -215,7 +216,7 @@ xfs_file_dax_read(
 		xfs_ilock(ip, XFS_IOLOCK_SHARED);
 	}
 
-	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
+	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
 	file_accessed(iocb->ki_filp);
@@ -1153,7 +1154,9 @@ __xfs_filemap_fault(
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
index 528b35898231..3bd1f7d62f4c 100644
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
@@ -1051,10 +1042,8 @@ xfs_file_iomap_begin(
 	 * so consider them to be dirty for the purposes of O_DSYNC even if
 	 * there is no other metadata changes pending or have been made here.
 	 */
-	if ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode))
+	if (offset + length > i_size_read(inode))
 		iomap_flags |= IOMAP_F_DIRTY;
-	if (shared)
-		iomap_flags |= IOMAP_F_SHARED;
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
 
 out_found:
@@ -1157,6 +1146,48 @@ const struct iomap_ops xfs_iomap_ops = {
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
index fe285d123d69..9c448a54a951 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1114,7 +1114,7 @@ xfs_vn_fiemap(
 				&xfs_xattr_iomap_ops);
 	} else {
 		error = iomap_fiemap(inode, fieinfo, start, length,
-				&xfs_iomap_ops);
+				&xfs_read_iomap_ops);
 	}
 	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
 
-- 
2.20.1

