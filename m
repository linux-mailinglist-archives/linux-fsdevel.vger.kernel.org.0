Return-Path: <linux-fsdevel+bounces-2300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460397E4959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EA728142E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A536B08;
	Tue,  7 Nov 2023 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QNYYV5S6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636F36B03
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:06 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E7F184
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=di9cP0sWSVGFPXpf5mG5HSbfipSWo6tzMdD/guucQIE=; b=QNYYV5S69yIS/x6nNFyk6Ly6xu
	I5i7KYGYIFVnNvTKXVs80gHR+MoGim7F+8O33ufaxAEJsi0+gukY62ykhX22MPSHKEYYHgStmEKuJ
	xXP2MaZEqabXg/atiBJ1OvwUVR8jfd4+aMW/msCfaUpinnlq42giVHxYV3wA+z6xwtQClquSR21SO
	18pwxTP3UjFKFJkoqeEW4gIhWzOU5yIRb8n98xorYPOykUvfeJiFmcpDYgTqAmZO4TiIbxasonT5O
	F+17b9U/umem4VywdB02QseSuMP5QlKzTKq12ncPphxSPOXvgxApeGzhvWM+CrEPUl3ddxnArMKMK
	ZCeheHGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxT-00E9l1-RX; Tue, 07 Nov 2023 19:41:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] buffer: Calculate block number inside folio_init_buffers()
Date: Tue,  7 Nov 2023 19:41:49 +0000
Message-Id: <20231107194152.3374087-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231107194152.3374087-1-willy@infradead.org>
References: <20231107194152.3374087-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation of block from index doesn't work for devices with a block
size larger than PAGE_SIZE as we end up shifting by a negative number.
Instead, calculate the number of the first block from the folio's
position in the block device.  We no longer need to pass sizebits to
grow_dev_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8dad6c691e14..cd114110b27f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -995,11 +995,12 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
  * Initialise the state of a blockdev folio's buffers.
  */ 
 static sector_t folio_init_buffers(struct folio *folio,
-		struct block_device *bdev, sector_t block, int size)
+		struct block_device *bdev, int size)
 {
 	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
 	bool uptodate = folio_test_uptodate(folio);
+	sector_t block = folio_pos(folio) / size;
 	sector_t end_block = blkdev_max_block(bdev, size);
 
 	do {
@@ -1032,7 +1033,7 @@ static sector_t folio_init_buffers(struct folio *folio,
  * we succeeded, or the caller should retry.
  */
 static bool grow_dev_folio(struct block_device *bdev, sector_t block,
-		pgoff_t index, unsigned size, int sizebits, gfp_t gfp)
+		pgoff_t index, unsigned size, gfp_t gfp)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct folio *folio;
@@ -1047,8 +1048,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = folio_init_buffers(folio, bdev,
-					(sector_t)index << sizebits, size);
+			end_block = folio_init_buffers(folio, bdev, size);
 			goto unlock;
 		}
 
@@ -1069,8 +1069,7 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
 	link_dev_buffers(folio, bh);
-	end_block = folio_init_buffers(folio, bdev,
-			(sector_t)index << sizebits, size);
+	end_block = folio_init_buffers(folio, bdev, size);
 	spin_unlock(&inode->i_mapping->private_lock);
 unlock:
 	folio_unlock(folio);
@@ -1105,7 +1104,7 @@ static bool grow_buffers(struct block_device *bdev, sector_t block,
 	}
 
 	/* Create a folio with the proper size buffers */
-	return grow_dev_folio(bdev, block, index, size, sizebits, gfp);
+	return grow_dev_folio(bdev, block, index, size, gfp);
 }
 
 static struct buffer_head *
-- 
2.42.0


