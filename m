Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C8CF35D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfJHHP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHP5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KgEtRwGRCAa8sdWlvdRDcISk1IAe+y2eWGce8aZDXoI=; b=s3mXcp3T9m3vycjxOmB0fZWeD
        UNSC/RKgksg0Z7YOjDYCYJObXnuktNOPogfwHgWWV5R7aR0D7sFMJN6vePk7gCS20jCGYFzjdO7KG
        1ZUNmpAXuTTeUjvI0olRcSeCD/x0nP83fMRWdfaenSk1G4ZxL/IvK9SIj+4h8i/7+BcgMzWsiPUFu
        yK+ow8q8XinXvbwVWUa3HWVjx49tIWr8yJ44p8VeVQDt8rvvpCskhLhxp4Mjdv1VqTqfNYaizh9Eq
        duUvtC9RAar7u71Jy7LeMy2mm22qSU1MPNJIlS15dVXkjYNqlFNVLL9pT60PsHmNjh0rjEmAySceJ
        iAiNL8/2A==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjiv-0006Fl-8T; Tue, 08 Oct 2019 07:15:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/20] xfs: remove xfs_reflink_dirty_extents
Date:   Tue,  8 Oct 2019 09:15:17 +0200
Message-Id: <20191008071527.29304-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that xfs_file_unshare is not completely dumb we can just call it
directly without iterating the extent and reflink btrees ourselves.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_reflink.c | 103 +++----------------------------------------
 1 file changed, 5 insertions(+), 98 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index a9634110c783..7fc728a8852b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1381,85 +1381,6 @@ xfs_reflink_remap_prep(
 	return ret;
 }
 
-/*
- * The user wants to preemptively CoW all shared blocks in this file,
- * which enables us to turn off the reflink flag.  Iterate all
- * extents which are not prealloc/delalloc to see which ranges are
- * mentioned in the refcount tree, then read those blocks into the
- * pagecache, dirty them, fsync them back out, and then we can update
- * the inode flag.  What happens if we run out of memory? :)
- */
-STATIC int
-xfs_reflink_dirty_extents(
-	struct xfs_inode	*ip,
-	xfs_fileoff_t		fbno,
-	xfs_filblks_t		end,
-	xfs_off_t		isize)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	xfs_agnumber_t		agno;
-	xfs_agblock_t		agbno;
-	xfs_extlen_t		aglen;
-	xfs_agblock_t		rbno;
-	xfs_extlen_t		rlen;
-	xfs_off_t		fpos;
-	xfs_off_t		flen;
-	struct xfs_bmbt_irec	map[2];
-	int			nmaps;
-	int			error = 0;
-
-	while (end - fbno > 0) {
-		nmaps = 1;
-		/*
-		 * Look for extents in the file.  Skip holes, delalloc, or
-		 * unwritten extents; they can't be reflinked.
-		 */
-		error = xfs_bmapi_read(ip, fbno, end - fbno, map, &nmaps, 0);
-		if (error)
-			goto out;
-		if (nmaps == 0)
-			break;
-		if (!xfs_bmap_is_real_extent(&map[0]))
-			goto next;
-
-		map[1] = map[0];
-		while (map[1].br_blockcount) {
-			agno = XFS_FSB_TO_AGNO(mp, map[1].br_startblock);
-			agbno = XFS_FSB_TO_AGBNO(mp, map[1].br_startblock);
-			aglen = map[1].br_blockcount;
-
-			error = xfs_reflink_find_shared(mp, NULL, agno, agbno,
-					aglen, &rbno, &rlen, true);
-			if (error)
-				goto out;
-			if (rbno == NULLAGBLOCK)
-				break;
-
-			/* Dirty the pages */
-			xfs_iunlock(ip, XFS_ILOCK_EXCL);
-			fpos = XFS_FSB_TO_B(mp, map[1].br_startoff +
-					(rbno - agbno));
-			flen = XFS_FSB_TO_B(mp, rlen);
-			if (fpos + flen > isize)
-				flen = isize - fpos;
-			error = iomap_file_unshare(VFS_I(ip), fpos, flen,
-					&xfs_iomap_ops);
-			xfs_ilock(ip, XFS_ILOCK_EXCL);
-			if (error)
-				goto out;
-
-			map[1].br_blockcount -= (rbno - agbno + rlen);
-			map[1].br_startoff += (rbno - agbno + rlen);
-			map[1].br_startblock += (rbno - agbno + rlen);
-		}
-
-next:
-		fbno = map[0].br_startoff + map[0].br_blockcount;
-	}
-out:
-	return error;
-}
-
 /* Does this inode need the reflink flag? */
 int
 xfs_reflink_inode_has_shared_extents(
@@ -1596,10 +1517,7 @@ xfs_reflink_unshare(
 	xfs_off_t		offset,
 	xfs_off_t		len)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	xfs_fileoff_t		fbno;
-	xfs_filblks_t		end;
-	xfs_off_t		isize;
+	struct inode		*inode = VFS_I(ip);
 	int			error;
 
 	if (!xfs_is_reflink_inode(ip))
@@ -1607,20 +1525,12 @@ xfs_reflink_unshare(
 
 	trace_xfs_reflink_unshare(ip, offset, len);
 
-	inode_dio_wait(VFS_I(ip));
+	inode_dio_wait(inode);
 
-	/* Try to CoW the selected ranges */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	fbno = XFS_B_TO_FSBT(mp, offset);
-	isize = i_size_read(VFS_I(ip));
-	end = XFS_B_TO_FSB(mp, offset + len);
-	error = xfs_reflink_dirty_extents(ip, fbno, end, isize);
+	error = iomap_file_unshare(inode, offset, len, &xfs_iomap_ops);
 	if (error)
-		goto out_unlock;
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-
-	/* Wait for the IO to finish */
-	error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
+		goto out;
+	error = filemap_write_and_wait(inode->i_mapping);
 	if (error)
 		goto out;
 
@@ -1628,11 +1538,8 @@ xfs_reflink_unshare(
 	error = xfs_reflink_try_clear_inode_flag(ip);
 	if (error)
 		goto out;
-
 	return 0;
 
-out_unlock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 out:
 	trace_xfs_reflink_unshare_error(ip, error, _RET_IP_);
 	return error;
-- 
2.20.1

