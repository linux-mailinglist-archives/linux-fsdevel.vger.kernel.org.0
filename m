Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AA5019D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfFXFxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 01:53:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfFXFxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YQfVkRaLDzTLP/kwXTkMMaUpzKVVxzAAzyVqy0c6VlU=; b=jJP+wpYNnjZCpeoborv7TIhwpD
        kyjqXXYu+N6FaACVqVnh1jdlGJWU6AhEtQekffOnNKYffVDdOXOTFKQLjkwztnSnTzzFa+rVmB32i
        leiumMk1td3ee6SD20jN/XQWv2JdoHVogKJxtj1R+sjzsfDWcaXAq28ZiQ+0XEklyaT/9ORZiHUXp
        1QmMuViXCpC+Uk0cs5w34SYp5v1DTdo4mLaXdz7swBoYnTfMKo2rwZCvOb1IXO18EZyX8T/ufriUl
        wYh0d5cdp2GNKd16nzjfPTZghXoQQhX/P/1W5zncZs42+SBqwlgQ1xvS/FhX7ntqyAtd7OSot3Eze
        SHDYQyFw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHuk-00045d-2x; Mon, 24 Jun 2019 05:53:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] xfs: remove XFS_TRANS_NOFS
Date:   Mon, 24 Jun 2019 07:52:47 +0200
Message-Id: <20190624055253.31183-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624055253.31183-1-hch@lst.de>
References: <20190624055253.31183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of a magic flag for xfs_trans_alloc, just ensure all callers
that can't relclaim through the file system use memalloc_nofs_save to
set the per-task nofs flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_shared.h |  1 -
 fs/xfs/xfs_aops.c          | 12 +++++++++---
 fs/xfs/xfs_file.c          | 12 +++++++++---
 fs/xfs/xfs_iomap.c         |  2 +-
 fs/xfs/xfs_reflink.c       |  4 ++--
 fs/xfs/xfs_trans.c         |  4 +---
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 4e909791aeac..1f2b5a0c71b4 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -65,7 +65,6 @@ void	xfs_log_get_max_trans_res(struct xfs_mount *mp,
 #define XFS_TRANS_DQ_DIRTY	0x10	/* at least one dquot in trx dirty */
 #define XFS_TRANS_RESERVE	0x20    /* OK to use reserved data blocks */
 #define XFS_TRANS_NO_WRITECOUNT 0x40	/* do not elevate SB writecount */
-#define XFS_TRANS_NOFS		0x80	/* pass KM_NOFS to kmem_alloc */
 /*
  * LOWMODE is used by the allocator to activate the lowspace algorithm - when
  * free space is running low the extent allocator may choose to allocate an
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 93a760f13017..633baaaff7ae 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -138,8 +138,7 @@ xfs_setfilesize_trans_alloc(
 	struct xfs_trans	*tp;
 	int			error;
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0,
-				XFS_TRANS_NOFS, &tp);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
@@ -236,6 +235,7 @@ STATIC void
 xfs_end_ioend(
 	struct xfs_ioend	*ioend)
 {
+	unsigned int		nofs_flag = memalloc_nofs_save();
 	struct list_head	ioend_list;
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
 	xfs_off_t		offset = ioend->io_offset;
@@ -282,6 +282,8 @@ xfs_end_ioend(
 		list_del_init(&ioend->io_list);
 		xfs_destroy_ioend(ioend, error);
 	}
+
+	memalloc_nofs_restore(nofs_flag);
 }
 
 /*
@@ -663,8 +665,12 @@ xfs_submit_ioend(
 	    (ioend->io_fork == XFS_COW_FORK ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
-	    !ioend->io_append_trans)
+	    !ioend->io_append_trans) {
+		unsigned nofs_flag = memalloc_nofs_save();
+
 		status = xfs_setfilesize_trans_alloc(ioend);
+		memalloc_nofs_restore(nofs_flag);
+	}
 
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = xfs_end_bio;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 916a35cae5e9..f2d806ef8f06 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -379,6 +379,7 @@ xfs_dio_write_end_io(
 	struct inode		*inode = file_inode(iocb->ki_filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	loff_t			offset = iocb->ki_pos;
+	unsigned int		nofs_flag;
 	int			error = 0;
 
 	trace_xfs_end_io_direct_write(ip, offset, size);
@@ -395,10 +396,11 @@ xfs_dio_write_end_io(
 	 */
 	XFS_STATS_ADD(ip->i_mount, xs_write_bytes, size);
 
+	nofs_flag = memalloc_nofs_save();
 	if (flags & IOMAP_DIO_COW) {
 		error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
-			return error;
+			goto out;
 	}
 
 	/*
@@ -407,8 +409,10 @@ xfs_dio_write_end_io(
 	 * earlier allows a racing dio read to find unwritten extents before
 	 * they are converted.
 	 */
-	if (flags & IOMAP_DIO_UNWRITTEN)
-		return xfs_iomap_write_unwritten(ip, offset, size, true);
+	if (flags & IOMAP_DIO_UNWRITTEN) {
+		error = xfs_iomap_write_unwritten(ip, offset, size, true);
+		goto out;
+	}
 
 	/*
 	 * We need to update the in-core inode size here so that we don't end up
@@ -430,6 +434,8 @@ xfs_dio_write_end_io(
 		spin_unlock(&ip->i_flags_lock);
 	}
 
+out:
+	memalloc_nofs_restore(nofs_flag);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6b29452bfba0..461ea023b910 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -782,7 +782,7 @@ xfs_iomap_write_unwritten(
 		 * complete here and might deadlock on the iolock.
 		 */
 		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-				XFS_TRANS_RESERVE | XFS_TRANS_NOFS, &tp);
+				XFS_TRANS_RESERVE, &tp);
 		if (error)
 			return error;
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 680ae7662a78..0b23c2b29609 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -572,7 +572,7 @@ xfs_reflink_cancel_cow_range(
 
 	/* Start a rolling transaction to remove the mappings */
 	error = xfs_trans_alloc(ip->i_mount, &M_RES(ip->i_mount)->tr_write,
-			0, 0, XFS_TRANS_NOFS, &tp);
+			0, 0, 0, &tp);
 	if (error)
 		goto out;
 
@@ -631,7 +631,7 @@ xfs_reflink_end_cow_extent(
 
 	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE | XFS_TRANS_NOFS, &tp);
+			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 0746b329a937..21228d7455af 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -264,9 +264,7 @@ xfs_trans_alloc(
 	 * GFP_NOFS allocation context so that we avoid lockdep false positives
 	 * by doing GFP_KERNEL allocations inside sb_start_intwrite().
 	 */
-	tp = kmem_zone_zalloc(xfs_trans_zone,
-		(flags & XFS_TRANS_NOFS) ? KM_NOFS : KM_SLEEP);
-
+	tp = kmem_zone_zalloc(xfs_trans_zone, KM_SLEEP);
 	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_start_intwrite(mp->m_super);
 
-- 
2.20.1

