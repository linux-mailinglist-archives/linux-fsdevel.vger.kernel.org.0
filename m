Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0ACF36D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfJHHQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:16:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZgchAop4MVdMXB9wG3MhZdxYHnkKimjOpwQC0JuUMeE=; b=Va+Dh55CFcBDUaJSDTdvv0UioO
        yFO3/sy+btsxiapZgFa05ji+r0b3aHQKyzm15b+5MB2+1+Q1LpCpdUu4XMLnzpj2u9fE6Sbq1OTgU
        0YxsYEgm9FYL9q8Eqc0aJnOOXfmw7JcWLRo/0EppIUVcOxOwS7PyUtIrXoe1KafdQUbvl4DwIBa4R
        x33xoeykfn50x0fuRbpVUwGuHMRlZgPbeOOJhFhmWR92Hd7vqdDWb0nQdd2y2dCRy1/JM3rCCfc9P
        VmcJv0prWJAIcEeWlaNrQbhg0oQZYwcHxI9X418/uoMRqyAhJAVSg+O7BgTnJqJqz0+Ee8rwA08+3
        uv4xhFsA==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjjF-0006LO-SP; Tue, 08 Oct 2019 07:16:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Allison Collins <allison.henderson@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 18/20] xfs: rename the whichfork variable in xfs_buffered_write_iomap_begin
Date:   Tue,  8 Oct 2019 09:15:25 +0200
Message-Id: <20191008071527.29304-19-hch@lst.de>
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

Renaming whichfork to allocfork in xfs_buffered_write_iomap_begin makes
the usage of this variable a little more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5a7499f88673..7a3fcfe5662c 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -862,7 +862,7 @@ xfs_buffered_write_iomap_begin(
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
 	bool			eof = false, cow_eof = false, shared = false;
-	int			whichfork = XFS_DATA_FORK;
+	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 
 	/* we can't use delayed allocations when using extent size hints */
@@ -959,7 +959,7 @@ xfs_buffered_write_iomap_begin(
 		 * Fork all the shared blocks from our write offset until the
 		 * end of the extent.
 		 */
-		whichfork = XFS_COW_FORK;
+		allocfork = XFS_COW_FORK;
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 	} else {
 		/*
@@ -975,7 +975,7 @@ xfs_buffered_write_iomap_begin(
 		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
 
 		if (xfs_is_always_cow_inode(ip))
-			whichfork = XFS_COW_FORK;
+			allocfork = XFS_COW_FORK;
 	}
 
 	error = xfs_qm_dqattach_locked(ip, false);
@@ -983,7 +983,7 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 
 	if (eof) {
-		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
+		prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork, offset,
 				count, &icur);
 		if (prealloc_blocks) {
 			xfs_extlen_t	align;
@@ -1006,11 +1006,11 @@ xfs_buffered_write_iomap_begin(
 	}
 
 retry:
-	error = xfs_bmapi_reserve_delalloc(ip, whichfork, offset_fsb,
+	error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
 			end_fsb - offset_fsb, prealloc_blocks,
-			whichfork == XFS_DATA_FORK ? &imap : &cmap,
-			whichfork == XFS_DATA_FORK ? &icur : &ccur,
-			whichfork == XFS_DATA_FORK ? eof : cow_eof);
+			allocfork == XFS_DATA_FORK ? &imap : &cmap,
+			allocfork == XFS_DATA_FORK ? &icur : &ccur,
+			allocfork == XFS_DATA_FORK ? eof : cow_eof);
 	switch (error) {
 	case 0:
 		break;
@@ -1027,8 +1027,8 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 	}
 
-	if (whichfork == XFS_COW_FORK) {
-		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
+	if (allocfork == XFS_COW_FORK) {
+		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
 		goto found_cow;
 	}
 
@@ -1037,7 +1037,7 @@ xfs_buffered_write_iomap_begin(
 	 * them out if the write happens to fail.
 	 */
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
+	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
 
 found_imap:
-- 
2.20.1

