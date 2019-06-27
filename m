Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D929580E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfF0Ksz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:48:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfF0Ksy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GIOqKjqkuWzDtK5JkzGGhZ7BWI6iCD4xnLtVdIWkFUk=; b=RO6ZanssSJ7O7PUs49ufa3hBiu
        P5Dzdfq+Mqf19PNHDhqXPo3qRlcNIZ4a/0HQ+nVVFGNY5tvh3qJCR+ElyQJ5Ud/Jy7xYiSecwHFvX
        AMgBFbVRFnOByp3FZsfPcUAD7K5pRgY8t8p9GRq6Mit0co4oAQJhlnYRoOQCwpJd2KZafIkJ1Qtyf
        YKtqTtx30N8jYoCsKBHyPbYr0o4kdT8HsgMPRtqvFu0nqRvwnVeOApXJFtprtvpijrVcUHB2WTN+W
        OyIIIP6ywvVaWJYwQ6TlqidiZWwuH1fe+mS1hVRdLperGROgyIa4+BAV7GdPynC7gGe/aIicVKCqv
        QWOaamAA==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxT-00054K-OU; Thu, 27 Jun 2019 10:48:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
Date:   Thu, 27 Jun 2019 12:48:27 +0200
Message-Id: <20190627104836.25446-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we don't overwrite the flags field in the iomap in
xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
but is harmful once we want to be able to reuse an iomap in the
writeback code.  Replace the shared paramter with a set of initial
flags an thus ensures the flags field is always reinitialized.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 28 +++++++++++++++++-----------
 fs/xfs/xfs_iomap.h |  2 +-
 fs/xfs/xfs_pnfs.c  |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 63d323916bba..6b29452bfba0 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -57,7 +57,7 @@ xfs_bmbt_to_iomap(
 	struct xfs_inode	*ip,
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
-	bool			shared)
+	u16			flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 
@@ -82,12 +82,11 @@ xfs_bmbt_to_iomap(
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
 	iomap->bdev = xfs_find_bdev_for_inode(VFS_I(ip));
 	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
+	iomap->flags = flags;
 
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
-	if (shared)
-		iomap->flags |= IOMAP_F_SHARED;
 	return 0;
 }
 
@@ -543,6 +542,7 @@ xfs_file_iomap_begin_delay(
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
 	bool			eof = false, cow_eof = false, shared = false;
+	u16			iomap_flags = 0;
 	int			whichfork = XFS_DATA_FORK;
 	int			error = 0;
 
@@ -710,7 +710,7 @@ xfs_file_iomap_begin_delay(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
-	iomap->flags |= IOMAP_F_NEW;
+	iomap_flags |= IOMAP_F_NEW;
 	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
 			whichfork == XFS_DATA_FORK ? &imap : &cmap);
 done:
@@ -718,14 +718,17 @@ xfs_file_iomap_begin_delay(
 		if (imap.br_startoff > offset_fsb) {
 			xfs_trim_extent(&cmap, offset_fsb,
 					imap.br_startoff - offset_fsb);
-			error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
+			error = xfs_bmbt_to_iomap(ip, iomap, &cmap,
+					IOMAP_F_SHARED);
 			goto out_unlock;
 		}
 		/* ensure we only report blocks we have a reservation for */
 		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
 		shared = true;
 	}
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
+	if (shared)
+		iomap_flags |= IOMAP_F_SHARED;
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
@@ -933,6 +936,7 @@ xfs_file_iomap_begin(
 	xfs_fileoff_t		offset_fsb, end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
+	u16			iomap_flags = 0;
 	unsigned		lockmode;
 
 	if (XFS_FORCED_SHUTDOWN(mp))
@@ -1048,11 +1052,13 @@ xfs_file_iomap_begin(
 	if (error)
 		return error;
 
-	iomap->flags |= IOMAP_F_NEW;
+	iomap_flags |= IOMAP_F_NEW;
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 
 out_finish:
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
+	if (shared)
+		iomap_flags |= IOMAP_F_SHARED;
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
 
 out_found:
 	ASSERT(nimaps);
@@ -1196,7 +1202,7 @@ xfs_seek_iomap_begin(
 		if (data_fsb < cow_fsb + cmap.br_blockcount)
 			end_fsb = min(end_fsb, data_fsb);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
-		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
+		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1218,7 +1224,7 @@ xfs_seek_iomap_begin(
 	imap.br_state = XFS_EXT_NORM;
 done:
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1264,7 +1270,7 @@ xfs_xattr_iomap_begin(
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, false);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 5c2f6aa6d78f..71d0ae460c44 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -16,7 +16,7 @@ int xfs_iomap_write_direct(struct xfs_inode *, xfs_off_t, size_t,
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 
 int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
-		struct xfs_bmbt_irec *, bool shared);
+		struct xfs_bmbt_irec *, u16);
 xfs_extlen_t xfs_eof_alignment(struct xfs_inode *ip, xfs_extlen_t extsize);
 
 static inline xfs_filblks_t
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 2d95355a8a0a..97cdb57e58bc 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -186,7 +186,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:
-- 
2.20.1

