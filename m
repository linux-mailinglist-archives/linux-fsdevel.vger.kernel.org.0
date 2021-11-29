Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2545846135F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377165AbhK2LMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347961AbhK2LJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:09:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37FC08E9B3;
        Mon, 29 Nov 2021 02:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pf86FXvjYE/bTvzEEu46xn96m08VDk5UK6+R0139/q0=; b=RQ+KMORrPJ65Mv5hy09H9UjClN
        I3uP0eSBe5tMJsNfWQa2lWLTUzxyUn4AVQkYkOvXnw3cetyZsa6LMoLo0Xklf61nx4DsxRCU1aMy6
        WMRkASreGT8iCxB5u5sBUzKW5ZeHRBZ/zpq5OFvyDN6+ULm5ob2R5ZVhD/+tWkHSQldln7JhYdGeZ
        voaIDGclV5TyMj/UQlIs/RLS1mlFUAgiXNR90rJ23PPnPorbRd8Rub5bCHhK4sjrPNBETsmpAX1eT
        HB7MVegkmw1tr7Pgf8/W/Ulcl6605xecWLr7ubY/F7WIwaGMn/OGZ6MsTo+ypeNfjZANK2PwFHowl
        C+7rz5vA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnk-0073Pc-3l; Mon, 29 Nov 2021 10:22:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 15/29] xfs: add xfs_zero_range and xfs_truncate_page helpers
Date:   Mon, 29 Nov 2021 11:21:49 +0100
Message-Id: <20211129102203.2243509-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Add helpers to prepare for using different DAX operations.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
[hch: split from a larger patch + slight cleanups]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |  7 +++----
 fs/xfs/xfs_file.c      |  3 +--
 fs/xfs/xfs_iomap.c     | 25 +++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h     |  4 ++++
 fs/xfs/xfs_iops.c      |  7 +++----
 fs/xfs/xfs_reflink.c   |  3 +--
 6 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 73a36b7be3bd1..797ea0c8b14e1 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1001,7 +1001,7 @@ xfs_free_file_space(
 
 	/*
 	 * Now that we've unmap all full blocks we'll have to zero out any
-	 * partial block at the beginning and/or end.  iomap_zero_range is smart
+	 * partial block at the beginning and/or end.  xfs_zero_range is smart
 	 * enough to skip any holes, including those we just created, but we
 	 * must take care not to zero beyond EOF and enlarge i_size.
 	 */
@@ -1009,15 +1009,14 @@ xfs_free_file_space(
 		return 0;
 	if (offset + len > XFS_ISIZE(ip))
 		len = XFS_ISIZE(ip) - offset;
-	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
-			&xfs_buffered_write_iomap_ops);
+	error = xfs_zero_range(ip, offset, len, NULL);
 	if (error)
 		return error;
 
 	/*
 	 * If we zeroed right up to EOF and EOF straddles a page boundary we
 	 * must make sure that the post-EOF area is also zeroed because the
-	 * page could be mmap'd and iomap_zero_range doesn't do that for us.
+	 * page could be mmap'd and xfs_zero_range doesn't do that for us.
 	 * Writeback of the eof page will do this, albeit clumsily.
 	 */
 	if (offset + len >= XFS_ISIZE(ip) && offset_in_page(offset + len) > 0) {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 27594738b0d18..8d4c5ca261bd7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -437,8 +437,7 @@ xfs_file_write_checks(
 		}
 
 		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
-		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
-				NULL, &xfs_buffered_write_iomap_ops);
+		error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
 		if (error)
 			return error;
 	} else
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 093758440ad53..d6d71ae9f2ae4 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1311,3 +1311,28 @@ xfs_xattr_iomap_begin(
 const struct iomap_ops xfs_xattr_iomap_ops = {
 	.iomap_begin		= xfs_xattr_iomap_begin,
 };
+
+int
+xfs_zero_range(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	loff_t			len,
+	bool			*did_zero)
+{
+	struct inode		*inode = VFS_I(ip);
+
+	return iomap_zero_range(inode, pos, len, did_zero,
+				&xfs_buffered_write_iomap_ops);
+}
+
+int
+xfs_truncate_page(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	bool			*did_zero)
+{
+	struct inode		*inode = VFS_I(ip);
+
+	return iomap_truncate_page(inode, pos, did_zero,
+				   &xfs_buffered_write_iomap_ops);
+}
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 7d3703556d0e0..f1a281ab9328c 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -20,6 +20,10 @@ xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
 		struct xfs_bmbt_irec *, u16);
 
+int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
+		bool *did_zero);
+int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
+
 static inline xfs_filblks_t
 xfs_aligned_fsb_count(
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a607d6aca5c4d..ab5ef52b2a9ff 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -911,8 +911,8 @@ xfs_setattr_size(
 	 */
 	if (newsize > oldsize) {
 		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
-		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
-				&did_zeroing, &xfs_buffered_write_iomap_ops);
+		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
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
+		error = xfs_truncate_page(ip, newsize, &did_zeroing);
 	}
 
 	if (error)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cb0edb1d68ef1..facce5c076d83 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1269,8 +1269,7 @@ xfs_reflink_zero_posteof(
 		return 0;
 
 	trace_xfs_zero_eof(ip, isize, pos - isize);
-	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
-			&xfs_buffered_write_iomap_ops);
+	return xfs_zero_range(ip, isize, pos - isize, NULL);
 }
 
 /*
-- 
2.30.2

