Return-Path: <linux-fsdevel+bounces-2299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE37E4958
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7A2813AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A67136B00;
	Tue,  7 Nov 2023 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VkTFI7X6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE1315A6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:04 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C763184
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=HAzpO5vddckPLZx1GWapozUSPOMMErgj8L/dgMSKhKw=; b=VkTFI7X63TSu1cZJo7Df9ZDuTr
	7tI5aMqYBN5e7UjerMZUWu/NaUabLqwTv/W7foixuIV1el3zdNnikBM926bDYuinrPNEOIAKdPJJY
	e9kynsCFDMERMvEoZhosBPTsofG6NGgSa9aer3B/zjE7e52H8PybCrWbZsCjJ3auKHrX3U7NsOShE
	3L5+ZFKLH2XkMcvdt1YwJRbHjXDDbqTpk0lNcwCFK2ZnIDn/49nE8hjMzqT/hd/7IoBmCkbkcIxy2
	1XBstEKxXBRZ0B1Y59vcjz7HW8D964BR+xTPQnkZBAjXvnBZ8HFelYOYRC+FXaluefnMUus9Frcqu
	+Jv58Y1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxT-00E9kz-Ot; Tue, 07 Nov 2023 19:41:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] buffer: Return bool from grow_dev_folio()
Date: Tue,  7 Nov 2023 19:41:48 +0000
Message-Id: <20231107194152.3374087-2-willy@infradead.org>
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

Rename grow_dev_page() to grow_dev_folio() and make it return a bool.
Document what that bool means; it's more subtle than it first appears.
Also rename the 'failed' label to 'unlock' beacuse it's not exactly
'failed'.  It just hasn't succeeded.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 967f34b70aa8..8dad6c691e14 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1024,40 +1024,43 @@ static sector_t folio_init_buffers(struct folio *folio,
 }
 
 /*
- * Create the page-cache page that contains the requested block.
+ * Create the page-cache folio that contains the requested block.
  *
  * This is used purely for blockdev mappings.
+ *
+ * Returns false if we have a 'permanent' failure.  Returns true if
+ * we succeeded, or the caller should retry.
  */
-static int
-grow_dev_page(struct block_device *bdev, sector_t block,
-	      pgoff_t index, int size, int sizebits, gfp_t gfp)
+static bool grow_dev_folio(struct block_device *bdev, sector_t block,
+		pgoff_t index, unsigned size, int sizebits, gfp_t gfp)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct folio *folio;
 	struct buffer_head *bh;
-	sector_t end_block;
-	int ret = 0;
+	sector_t end_block = 0;
 
 	folio = __filemap_get_folio(inode->i_mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return false;
 
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
 			end_block = folio_init_buffers(folio, bdev,
 					(sector_t)index << sizebits, size);
-			goto done;
+			goto unlock;
 		}
+
+		/* Caller should retry if this call fails */
+		end_block = ~0ULL;
 		if (!try_to_free_buffers(folio))
-			goto failed;
+			goto unlock;
 	}
 
-	ret = -ENOMEM;
 	bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
 	if (!bh)
-		goto failed;
+		goto unlock;
 
 	/*
 	 * Link the folio to the buffers and initialise them.  Take the
@@ -1069,20 +1072,19 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	end_block = folio_init_buffers(folio, bdev,
 			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->private_lock);
-done:
-	ret = (block < end_block) ? 1 : -ENXIO;
-failed:
+unlock:
 	folio_unlock(folio);
 	folio_put(folio);
-	return ret;
+	return block < end_block;
 }
 
 /*
- * Create buffers for the specified block device block's page.  If
- * that page was dirty, the buffers are set dirty also.
+ * Create buffers for the specified block device block's folio.  If
+ * that folio was dirty, the buffers are set dirty also.  Returns false
+ * if we've hit a permanent error.
  */
-static int
-grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
+static bool grow_buffers(struct block_device *bdev, sector_t block,
+		unsigned size, gfp_t gfp)
 {
 	pgoff_t index;
 	int sizebits;
@@ -1099,11 +1101,11 @@ grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 			"device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);
-		return -EIO;
+		return false;
 	}
 
-	/* Create a page with the proper size buffers.. */
-	return grow_dev_page(bdev, block, index, size, sizebits, gfp);
+	/* Create a folio with the proper size buffers */
+	return grow_dev_folio(bdev, block, index, size, sizebits, gfp);
 }
 
 static struct buffer_head *
@@ -1124,14 +1126,12 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 
 	for (;;) {
 		struct buffer_head *bh;
-		int ret;
 
 		bh = __find_get_block(bdev, block, size);
 		if (bh)
 			return bh;
 
-		ret = grow_buffers(bdev, block, size, gfp);
-		if (ret < 0)
+		if (!grow_buffers(bdev, block, size, gfp))
 			return NULL;
 	}
 }
-- 
2.42.0


