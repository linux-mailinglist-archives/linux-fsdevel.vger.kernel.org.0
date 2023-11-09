Return-Path: <linux-fsdevel+bounces-2635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB127E735C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB251C20C70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4331374DF;
	Thu,  9 Nov 2023 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khQQeR3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBB3D6A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:06:23 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C69468A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YCA/tE3gVaEcJk7romlGjNLxtGeY+C0FSQYUINGlroE=; b=khQQeR3hgKdEe1mzN8Aznzj4ej
	te1gHZqEYNevgk0J4J0auclajcY+eT4Yh5iLuL55uWR3WE8UdEBPeaovfX9o2HU8fOsQIgJE6wm+j
	a8X57sX0h55YPDECkDq/Lmpf/VYuz4NjZ8RXWQgNEDmi2lSNocev6WdndBe2uaoC3eFmMNyy54VDZ
	dovcZ5G0ANnyF7oTgoULPYVTfYezei6rZdCbM0iqHHlYYGGiyLFW1gp4I7TC5gZ27I3fQrMj6Zms1
	3/JnzdK9q/IcBvP2XVkmnxOA5qj4eIC14OOSxQl5At1RlFd2Q8HcbGAZpoOxANZZPlbOcpu9Sbku/
	v8DBsMng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1CE7-009Rw5-Pd; Thu, 09 Nov 2023 21:06:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
Date: Thu,  9 Nov 2023 21:06:04 +0000
Message-Id: <20231109210608.2252323-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231109210608.2252323-1-willy@infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must not shift by a negative number so work in terms of a byte
offset to avoid the awkward shift left-or-right-depending-on-sign
option.  This means we need to use check_mul_overflow() to ensure
that a large block number does not result in a wrap.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 44e0c0b7f71f..9c3f49cf8d28 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1085,26 +1085,21 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 static bool grow_buffers(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp)
 {
-	pgoff_t index;
-	int sizebits;
-
-	sizebits = PAGE_SHIFT - __ffs(size);
-	index = block >> sizebits;
+	loff_t pos;
 
 	/*
-	 * Check for a block which wants to lie outside our maximum possible
-	 * pagecache index.  (this comparison is done using sector_t types).
+	 * Check for a block which lies outside our maximum possible
+	 * pagecache index.
 	 */
-	if (unlikely(index != block >> sizebits)) {
-		printk(KERN_ERR "%s: requested out-of-range block %llu for "
-			"device %pg\n",
+	if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESIZE) {
+		printk(KERN_ERR "%s: requested out-of-range block %llu for device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);
 		return false;
 	}
 
 	/* Create a folio with the proper size buffers */
-	return grow_dev_folio(bdev, block, index, size, gfp);
+	return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
 }
 
 static struct buffer_head *
-- 
2.42.0


