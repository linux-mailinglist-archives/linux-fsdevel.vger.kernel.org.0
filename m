Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF2DD931
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJSOpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJSOpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KqxbiwYFnnsTcSlh+6GfaaEJRrS/Dd+Dc4VKb35fnTs=; b=F2YFkMS/bqrzI2S6fk9ZwnbTrr
        okhIdbBHepInvpl72MZheKFTzlFuNAEJpQ7uurXMOv/I4iR5jm7/9lrM7/4/M4WE6F+7q8qquSG1Q
        Ena5FE8ZIk5nnHAvm9RGXaei+eKzOZsq/NlNFtdHUontYU9j/k0rPxJ1aME6ObEI2WFb5EHCxx8JO
        z8gFw/lH7gfONLPfIiXGzAyvUVZTEnk+W7huptAm/0DwgVJt9TIqKjsIn+b05AAWSo30Bz+fkyhjD
        o4oU+4aVk9tj1pO83ZWR/cPwXQr6OyzehpY7XUaPiDPs4eqs4UxmGjcgvGQPqXF8LQMkYqHsq90h9
        KqZuFYew==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyz-0003C3-6G; Sat, 19 Oct 2019 14:45:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Allison Collins <allison.henderson@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 10/12] xfs: rename the whichfork variable in xfs_buffered_write_iomap_begin
Date:   Sat, 19 Oct 2019 16:44:46 +0200
Message-Id: <20191019144448.21483-11-hch@lst.de>
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

Renaming whichfork to allocfork in xfs_buffered_write_iomap_begin makes
the usage of this variable a little more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index a706da8ffe22..b6e17594d10a 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -869,7 +869,7 @@ xfs_buffered_write_iomap_begin(
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
 	bool			eof = false, cow_eof = false, shared = false;
-	int			whichfork = XFS_DATA_FORK;
+	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 
 	/* we can't use delayed allocations when using extent size hints */
@@ -966,7 +966,7 @@ xfs_buffered_write_iomap_begin(
 		 * Fork all the shared blocks from our write offset until the
 		 * end of the extent.
 		 */
-		whichfork = XFS_COW_FORK;
+		allocfork = XFS_COW_FORK;
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 	} else {
 		/*
@@ -982,7 +982,7 @@ xfs_buffered_write_iomap_begin(
 		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
 
 		if (xfs_is_always_cow_inode(ip))
-			whichfork = XFS_COW_FORK;
+			allocfork = XFS_COW_FORK;
 	}
 
 	error = xfs_qm_dqattach_locked(ip, false);
@@ -990,7 +990,7 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 
 	if (eof) {
-		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
+		prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork, offset,
 				count, &icur);
 		if (prealloc_blocks) {
 			xfs_extlen_t	align;
@@ -1013,11 +1013,11 @@ xfs_buffered_write_iomap_begin(
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
@@ -1034,8 +1034,8 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 	}
 
-	if (whichfork == XFS_COW_FORK) {
-		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
+	if (allocfork == XFS_COW_FORK) {
+		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
 		goto found_cow;
 	}
 
@@ -1044,7 +1044,7 @@ xfs_buffered_write_iomap_begin(
 	 * them out if the write happens to fail.
 	 */
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
+	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
 
 found_imap:
-- 
2.20.1

