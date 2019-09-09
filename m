Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06503ADEF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfIIS2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:28:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z4c8WFGrFR6v6EF2ZDpdsSGfW95mgeu2RAuWMmGHQog=; b=pJQohg/HTJoLf3rq9XL4VLObm
        IzcUAHzvUpfYkgmHKHKEhrxAYInA6dC/OIoA8Yagxg3LSD69Xfi4HWCN95ugsg6m/24vKpKd+sSDh
        ylynRWanGlqF3KPbjca4o4U602QY7GNoOM8TFvck6EJjxTiYNA6DnK/vjFBwhiz7L24a2GagqIFse
        q40V/zY+vbC7FqZ0F9PQCt9Q6/+EF+cS2qhN5EQXFxX/mPy9XPGAl2Sc3MteJ1H+CqIgt93VxBQc6
        MRdRvwA3+nVFU7rrljX3UJlgCwWStAe4MUXwvDYfwZX9pxxGCse4F9DZMbeHhY0o13XlRMdjdlUq1
        6h3gbAwcg==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOY-00027p-O0; Mon, 09 Sep 2019 18:28:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/19] xfs: rename the whichfork variable in xfs_buffered_write_iomap_begin
Date:   Mon,  9 Sep 2019 20:27:20 +0200
Message-Id: <20190909182722.16783-18-hch@lst.de>
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

Renaming whichfork to allocfork in xfs_buffered_write_iomap_begin makes
the usage of this variable a little more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6dd143374d75..0e575ca1e3fc 100644
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

