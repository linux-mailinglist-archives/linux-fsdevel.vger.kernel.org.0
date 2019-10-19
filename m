Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACFDD929
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfJSOpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZcMMvQMV0bIkYFY0Efy0R9tKnM0Vzztay5ez5SO5Gwk=; b=M4xqalSGXorUPVsoBfsOgCjTb3
        vLuTzE+Lr/WT3i5EMHOxehqlmXy65TOyA+un3CucramCRncgxshyRCFMQf3Dtuz3KLo4+VdIWALbm
        3uENuUbReb6nNmPVEpzxm4+v3odvFU3v6rGl8WLubvvt6VjuYt/WdUcVXPrDmPTCFTnJ9oi2Mc6T5
        9dWr23Y4LiwBl9ANr1TF4s91qN+YQ0c2xqDtytm2EwczwcMTX9L0X2ZEnj2uD6ww692gV4VdZklQ+
        9vfQkNGTG6BR1jih4hMxzJBCZ/eTW+8i0dWFBIaUO9yUIxogT6SgTkBnbG84ZDrrOk2AjHG7hRicf
        XxOjCEkQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyi-00038i-JW; Sat, 19 Oct 2019 14:45:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Allison Collins <allison.henderson@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 06/12] xfs: factor out a helper to calculate the end_fsb
Date:   Sat, 19 Oct 2019 16:44:42 +0200
Message-Id: <20191019144448.21483-7-hch@lst.de>
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

We have lots of places that want to calculate the final fsb for
a offset + count in bytes and check that the result fits into
s_maxbytes.  Factor out a helper for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 08c0f0a369d7..528b35898231 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -102,6 +102,17 @@ xfs_hole_to_iomap(
 	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
 }
 
+static inline xfs_fileoff_t
+xfs_iomap_end_fsb(
+	struct xfs_mount	*mp,
+	loff_t			offset,
+	loff_t			count)
+{
+	ASSERT(offset <= mp->m_super->s_maxbytes);
+	return min(XFS_B_TO_FSB(mp, offset + count),
+		   XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
+}
+
 xfs_extlen_t
 xfs_eof_alignment(
 	struct xfs_inode	*ip,
@@ -172,8 +183,8 @@ xfs_iomap_write_direct(
 	int		nmaps)
 {
 	xfs_mount_t	*mp = ip->i_mount;
-	xfs_fileoff_t	offset_fsb;
-	xfs_fileoff_t	last_fsb;
+	xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t	last_fsb = xfs_iomap_end_fsb(mp, offset, count);
 	xfs_filblks_t	count_fsb, resaligned;
 	xfs_extlen_t	extsz;
 	int		nimaps;
@@ -192,8 +203,6 @@ xfs_iomap_write_direct(
 
 	ASSERT(xfs_isilocked(ip, lockmode));
 
-	offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	last_fsb = XFS_B_TO_FSB(mp, ((xfs_ufsize_t)(offset + count)));
 	if ((offset + count) > XFS_ISIZE(ip)) {
 		/*
 		 * Assert that the in-core extent list is present since this can
@@ -533,9 +542,7 @@ xfs_file_iomap_begin_delay(
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	xfs_fileoff_t		maxbytes_fsb =
-		XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
-	xfs_fileoff_t		end_fsb;
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
 	struct xfs_bmbt_irec	imap, cmap;
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
@@ -565,8 +572,6 @@ xfs_file_iomap_begin_delay(
 			goto out_unlock;
 	}
 
-	end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
-
 	/*
 	 * Search the data fork fork first to look up our source mapping.  We
 	 * always need the data fork map, as we have to return it to the
@@ -648,7 +653,7 @@ xfs_file_iomap_begin_delay(
 		 * the lower level functions are updated.
 		 */
 		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
-		end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
+		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
 
 		if (xfs_is_always_cow_inode(ip))
 			whichfork = XFS_COW_FORK;
@@ -674,7 +679,8 @@ xfs_file_iomap_begin_delay(
 			if (align)
 				p_end_fsb = roundup_64(p_end_fsb, align);
 
-			p_end_fsb = min(p_end_fsb, maxbytes_fsb);
+			p_end_fsb = min(p_end_fsb,
+				XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
 			ASSERT(p_end_fsb > offset_fsb);
 			prealloc_blocks = p_end_fsb - end_fsb;
 		}
@@ -937,7 +943,8 @@ xfs_file_iomap_begin(
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_bmbt_irec	imap, cmap;
-	xfs_fileoff_t		offset_fsb, end_fsb;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
@@ -963,12 +970,6 @@ xfs_file_iomap_begin(
 	if (error)
 		return error;
 
-	ASSERT(offset <= mp->m_super->s_maxbytes);
-	if (offset > mp->m_super->s_maxbytes - length)
-		length = mp->m_super->s_maxbytes - offset;
-	offset_fsb = XFS_B_TO_FSBT(mp, offset);
-	end_fsb = XFS_B_TO_FSB(mp, offset + length);
-
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, 0);
 	if (error)
@@ -1196,8 +1197,7 @@ xfs_seek_iomap_begin(
 		/*
 		 * Fake a hole until the end of the file.
 		 */
-		data_fsb = min(XFS_B_TO_FSB(mp, offset + length),
-			       XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
+		data_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	}
 
 	/*
-- 
2.20.1

