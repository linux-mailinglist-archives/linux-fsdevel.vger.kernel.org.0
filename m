Return-Path: <linux-fsdevel+bounces-5124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD81A808323
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42622B21B31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142F328AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4DPPOb15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCB1D5B;
	Wed,  6 Dec 2023 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y+NglUGlgZ9YBrdTJdpOBFfcM6D33ZO9uf8JCBTQOZ8=; b=4DPPOb15nmRr71vLaSqWwT2ORq
	PLSsaSvO0xL6TiE88y9Tl6/Di/HKDezf1XcsIvWzb2hTXPlt1xZz3OaS2k4xUj2uvFuqKFt4sIanm
	CqXsu+ZPZFqsVkl2TqqJJXvQvbvqK2PBLW8cudvuAkVVy5MsU07YcPkBzGwcfNNmG0xOJxmHcaiPH
	lPzFWRU67gDArF2yHf9eVcRZaDQ57GLqVAQvXJS8pCnliMOdZYTA3JpZePYVmhN9FjmECoYHMuwrv
	oqhAnq4i7AELm48Hk6Np/nO2SWj22Ug/t48k6iL4tJP9Yk8jCKAGhfktgx2ry98oxCjVgFjmsLZFM
	eRtSFs1g==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nc-00C59G-23;
	Thu, 07 Dec 2023 07:27:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 14/14] iomap: pass the length of the dirty region to ->map_blocks
Date: Thu,  7 Dec 2023 08:27:10 +0100
Message-Id: <20231207072710.176093-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Let the file system know how much dirty data exists at the passed
in offset.  This allows file systems to allocate the right amount
of space that actually is written back if they can't eagerly
convert (e.g. because they don't support unwritten extents).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c           | 2 +-
 fs/gfs2/bmap.c         | 2 +-
 fs/iomap/buffered-io.c | 2 +-
 fs/xfs/xfs_aops.c      | 3 ++-
 fs/zonefs/file.c       | 3 ++-
 include/linux/iomap.h  | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0abaac705dafb0..7e921f999182dc 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -467,7 +467,7 @@ static void blkdev_readahead(struct readahead_control *rac)
 }
 
 static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
-		struct inode *inode, loff_t offset)
+		struct inode *inode, loff_t offset, unsigned int len)
 {
 	loff_t isize = i_size_read(inode);
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index d9ccfd27e4f11f..789af5c8fade9d 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2465,7 +2465,7 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 }
 
 static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
-		loff_t offset)
+		loff_t offset, unsigned int len)
 {
 	int ret;
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d8f56968962b97..e0c9cede82ee4b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1783,7 +1783,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 	do {
 		unsigned map_len;
 
-		error = wpc->ops->map_blocks(wpc, inode, pos);
+		error = wpc->ops->map_blocks(wpc, inode, pos, dirty_len);
 		if (error)
 			break;
 		trace_iomap_writepage_map(inode, &wpc->iomap);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b45ee6cbbdaab2..bf26a91ecdbbc6 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -276,7 +276,8 @@ static int
 xfs_map_blocks(
 	struct iomap_writepage_ctx *wpc,
 	struct inode		*inode,
-	loff_t			offset)
+	loff_t			offset,
+	unsigned int		len)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index b2c9b35df8f76d..1526e0ec6bfeaf 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -125,7 +125,8 @@ static void zonefs_readahead(struct readahead_control *rac)
  * which implies that the page range can only be within the fixed inode size.
  */
 static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
-				   struct inode *inode, loff_t offset)
+				   struct inode *inode, loff_t offset,
+				   unsigned int len)
 {
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 49d93f53878565..6fc1c858013d1e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -318,7 +318,7 @@ struct iomap_writeback_ops {
 	 * by the file system if it is still valid.
 	 */
 	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
-				loff_t offset);
+			  loff_t offset, unsigned len);
 
 	/*
 	 * Optional, allows the file systems to perform actions just before
-- 
2.39.2


