Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34DEADED7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfIIS1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nsHXJCbKKhtEHp3V5FIKlgukR9a0XDTWcYxud/JBjJI=; b=Qlq14sYPq3JRo+GoOu4UwyA2l
        qneNjUJQ1Oj/78vMkzOixA+TYcA15XHRpn6Yctksq9Ad3LYj5TGRWwP14w+bm3pxe5moAurnCeNnB
        46CMa5WC5gmRd25OqBRE1gsZrSXwEy268LMH7MvCG1dLqzbxpbMcU6KMANOt+2+1RuJMoAY24G5CX
        PRQotvLM1shdGUGPI1SKvwPuT5mqy0nhCYlBzNZAAbt+e9GScAkaAz//E64T8kKb0Pra27luDg9AK
        IxS/ChC2PvgZPcEAjJmcbLWfe8L/0WyKAfTG8CaXiMEgTEfIzEQg1Z4YwPyypID0CEReQ20LSfHrj
        bc50/Pzww==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OO1-0001vt-Mo; Mon, 09 Sep 2019 18:27:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/19] iomap: ignore non-shared or non-data blocks in xfs_file_dirty
Date:   Mon,  9 Sep 2019 20:27:07 +0200
Message-Id: <20190909182722.16783-5-hch@lst.de>
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

xfs_file_dirty is used to unshare reflink blocks.  Rename the function
to xfs_file_unshare to better document that purpose, and skip iomaps
that are not shared are don't need zeroing.  This will allow to simplify
the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 15 +++++++++++----
 fs/xfs/xfs_reflink.c   |  2 +-
 include/linux/iomap.h  |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 33e03992d8a7..0b05551d9b5a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -872,12 +872,19 @@ __iomap_read_page(struct inode *inode, loff_t offset)
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
@@ -917,14 +924,14 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
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
@@ -933,7 +940,7 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iomap_file_dirty);
+EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
 static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 		unsigned bytes, struct iomap *iomap)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index c4ec7afd1170..cadc0456804d 100644
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
index 8adcc8dd4498..3a0f0975a57e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -183,7 +183,7 @@ int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
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

