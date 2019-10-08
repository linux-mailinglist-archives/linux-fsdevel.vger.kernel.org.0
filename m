Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C25CF350
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfJHHPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjSjoa1MVwZWt9XbFvlb0U7SX/qQHQdSxdrkyllxl/o=; b=equfbYXVEhGZmVpaoTDhmZL58y
        IpXF2QousXsucnvZSj0GVXUkeGHeN1AJKm8EOnX03KHsNliu6RjKXh1l+IDO3tDCLn4NU3xDPYaGR
        OapVz/eo4x9NKEdraQQ9glLccNwpYOV45gM7lRp7s7EjlwbQgmb4aP3+/4bE/9whJkI7wF/KDmFBD
        RIoMSgTDYJoOEn+vq1ajtt3+t14JMpei4JKGvJue2Zo+Mc5t+H2hzhv706Vy/ReFTOPhYj5qmE00M
        qqRdpvWhjaHCAYujdG9mRRzKK00z7r6ancvWtsqY8fEwEP9s888kilpinP4XJgFW4eJdSTzJBvcMc
        rd/uurPQ==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjif-0005je-NB; Tue, 08 Oct 2019 07:15:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 04/20] iomap: ignore non-shared or non-data blocks in xfs_file_dirty
Date:   Tue,  8 Oct 2019 09:15:11 +0200
Message-Id: <20191008071527.29304-5-hch@lst.de>
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

xfs_file_dirty is used to unshare reflink blocks.  Rename the function
to xfs_file_unshare to better document that purpose, and skip iomaps
that are not shared and don't need zeroing.  This will allow to simplify
the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 15 +++++++++++----
 fs/xfs/xfs_reflink.c   |  2 +-
 include/linux/iomap.h  |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bf6a0e0b92a5..59751835f172 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -887,12 +887,19 @@ __iomap_read_page(struct inode *inode, loff_t offset)
 }
 
 static loff_t
-iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
 {
 	long status = 0;
 	ssize_t written = 0;
 
+	/* don't bother with blocks that are not shared to start with */
+	if (!(iomap->flags & IOMAP_F_SHARED))
+		return length;
+	/* don't bother with holes or unwritten extents */
+	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
+		return length;
+
 	do {
 		struct page *page, *rpage;
 		unsigned long offset;	/* Offset into pagecache page */
@@ -932,14 +939,14 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 }
 
 int
-iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
+iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops)
 {
 	loff_t ret;
 
 	while (len) {
 		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
-				iomap_dirty_actor);
+				iomap_unshare_actor);
 		if (ret <= 0)
 			return ret;
 		pos += ret;
@@ -948,7 +955,7 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iomap_file_dirty);
+EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
 static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 		unsigned bytes, struct iomap *iomap)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 0f08153b4994..a9634110c783 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1442,7 +1442,7 @@ xfs_reflink_dirty_extents(
 			flen = XFS_FSB_TO_B(mp, rlen);
 			if (fpos + flen > isize)
 				flen = isize - fpos;
-			error = iomap_file_dirty(VFS_I(ip), fpos, flen,
+			error = iomap_file_unshare(VFS_I(ip), fpos, flen,
 					&xfs_iomap_ops);
 			xfs_ilock(ip, XFS_ILOCK_EXCL);
 			if (error)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 17cf63717681..220f6b17a1a7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -166,7 +166,7 @@ int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 #else
 #define iomap_migrate_page NULL
 #endif
-int iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
+int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
-- 
2.20.1

