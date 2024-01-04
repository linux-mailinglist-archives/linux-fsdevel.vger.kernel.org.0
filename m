Return-Path: <linux-fsdevel+bounces-7399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E054782466E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D821F25664
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1B2D05C;
	Thu,  4 Jan 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWV8vsRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A272D033;
	Thu,  4 Jan 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pxHBfcGZFBAcpsHKOLVI+HuTnhEV5ZNIlJJNDoYE0m8=; b=OWV8vsRGLnY1KSmhLbM7xO+eCA
	0OLBvsxwFx11AhsOk2njoTnl9f2DpRBUVWqrJ+ixKokE2NJMXQ5jcgfit4pbLVQvPgdUMZiF/lsMV
	5+YPtH15b6nbSp0xtIY+0srE2HPA+7qyFZ7eipqL1KTAu7N83W1IcJQDwCg+GYDGdvbtyCJ4G/lRA
	p9Nlk1oYuGRJGEnYPZ63w2m/AOivueSMz3jkJ2ictllQyyrjvuzEBxrAwoNllrWgF/Dl5CvpGqD5N
	OjSPAh/aN8iE8Fxqm13/K/02fULq6ywnD7OtzPizPvn2OI5MHwC1rNXh84pWFVPo1K4wfTrTzP0Ur
	mZjomj4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLQiE-00FY2X-QZ; Thu, 04 Jan 2024 16:36:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] buffer: Fix __bread() kernel-doc
Date: Thu,  4 Jan 2024 16:36:51 +0000
Message-Id: <20240104163652.3705753-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240104163652.3705753-1-willy@infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extra indentation confused the kernel-doc parser, so remove it.
Fix some other wording while I'm here, and advise the user they need to
call brelse() on this buffer.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..7558cd1d3eb3 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -437,14 +437,17 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
 }
 
 /**
- *  __bread() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
+ * __bread() - Read a block.
+ * @bdev: The block device to read from.
+ * @block: Block number in units of block size.
+ * @size: Block size in bytes.
  *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache is allocated from movable area so that it can be migrated.
- *  It returns NULL if the block was unreadable.
+ * Read a specified block, and return the buffer head that refers to it.
+ * The memory is allocated from the movable area so that it can be
+ * migrated.  The buffer head has its refcount elevated and the caller
+ * should call brelse() when it has finished with the buffer.
+ *
+ * Return: NULL if the block was unreadable.
  */
 static inline struct buffer_head *
 __bread(struct block_device *bdev, sector_t block, unsigned size)
-- 
2.43.0


