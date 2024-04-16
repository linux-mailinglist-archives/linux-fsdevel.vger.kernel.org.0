Return-Path: <linux-fsdevel+bounces-17012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D28A6171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 05:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6E0B218CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 03:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AF210FF;
	Tue, 16 Apr 2024 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvvSnld2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6D41799B;
	Tue, 16 Apr 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237480; cv=none; b=olFr5AshL0Ef/LOjIPv1/foSfQwbCBUbaarKaNecP0xyBhmgykzgnDTqocY66MY5satH22xDXZ/FRhdZZt+7nLZl3M6Y/XPhQzZCW/FviLsAA6GOazEnoH15D0WVtxB/NqH+6RWXkTiwUO8vZwkhVcPA+WzvkCT9vxZ6SrEzYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237480; c=relaxed/simple;
	bh=lAPa08IhPQtMbTxyecDDdGadkBQWe/L12G3eEq8lCKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJN8d7LLr6cTzBonu6/tcdOVwaPxsedWy9tka7pQ45xTebxJtg1FarBn5EhnuNQkeSFcnRQ6WsEYCFze8nGi+cf86LQSE0LXrdAjmL0IOspBb9a5pnOjpXQBUyT4orFfSyutEHJG86iPjyZUSFUHlujuGPv37/hYJoeGlHwi4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZvvSnld2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=FGpNu8aZPJ0EzAtAE/YF4YBptN/FSxJxoVRcCRnwFCE=; b=ZvvSnld2uxIIEqpK6cpCdU8Iup
	z79SIS3mE7t0WrcTNa7v2owUoVlchXnMhxsCOYkAVjHmqwQAHVN8NJOJusEzLtVQojbE3AkMPLKIk
	nOEqP1JOof33SWzMHFyYbIDOgCLdYnllDZrA78jvNi5ARZqDm4xV+arkzVH+WlDC0KTNIvp6RfBH8
	c/8zBVVpIWmweFmZKDMZ0I3fOt+XG0kIiKvQb1t+uvJCQoNSidNlnkzTJCfIjCG2jS+hYYB0JOvzM
	emDdkms2DLNFo9+cTsxI88nt8fANyHwt0X72O4ryyP7uio4t6He1CKWbEqjzKHUXVqCbfFs4HuPW/
	nwirn9yA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwZKW-0000000H6b0-0gC8;
	Tue, 16 Apr 2024 03:17:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 4/8] buffer: Fix __bread and __bread_gfp kernel-doc
Date: Tue, 16 Apr 2024 04:17:48 +0100
Message-ID: <20240416031754.4076917-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416031754.4076917-1-willy@infradead.org>
References: <20240416031754.4076917-1-willy@infradead.org>
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

__bread_gfp() isn't used directly by filesystems, but the other wrappers
for it don't have documentation, so document it accordingly.

Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 35 ++++++++++++++++++++++-------------
 include/linux/buffer_head.h | 22 +++++++++++++---------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 0466ed7ed95a..32ab3eddc44f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1453,20 +1453,29 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
 EXPORT_SYMBOL(__breadahead);
 
 /**
- *  __bread_gfp() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
- *  @gfp: page allocation flag
- *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache can be allocated from non-movable area
- *  not to prevent page migration if you set gfp to zero.
- *  It returns NULL if the block was unreadable.
+ * __bread_gfp() - Read a block.
+ * @bdev: The block device to read from.
+ * @block: Block number in units of block size.
+ * @size: The block size of this device in bytes.
+ * @gfp: Not page allocation flags; see below.
+ *
+ * You are not expected to call this function.  You should use one of
+ * sb_bread(), sb_bread_unmovable() or __bread().
+ *
+ * Read a specified block, and return the buffer head that refers to it.
+ * If @gfp is 0, the memory will be allocated using the block device's
+ * default GFP flags.  If @gfp is __GFP_MOVABLE, the memory may be
+ * allocated from a movable area.  Do not pass in a complete set of
+ * GFP flags.
+ *
+ * The returned buffer head has its refcount increased.  The caller should
+ * call brelse() when it has finished with the buffer.
+ *
+ * Context: May sleep waiting for I/O.
+ * Return: NULL if the block was unreadable.
  */
-struct buffer_head *
-__bread_gfp(struct block_device *bdev, sector_t block,
-		   unsigned size, gfp_t gfp)
+struct buffer_head *__bread_gfp(struct block_device *bdev, sector_t block,
+		unsigned size, gfp_t gfp)
 {
 	struct buffer_head *bh;
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..56a1e9c1e71e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -437,17 +437,21 @@ static inline void bh_readahead_batch(int nr, struct buffer_head *bhs[],
 }
 
 /**
- *  __bread() - reads a specified block and returns the bh
- *  @bdev: the block_device to read from
- *  @block: number of block
- *  @size: size (in bytes) to read
+ * __bread() - Read a block.
+ * @bdev: The block device to read from.
+ * @block: Block number in units of block size.
+ * @size: The block size of this device in bytes.
  *
- *  Reads a specified block, and returns buffer head that contains it.
- *  The page cache is allocated from movable area so that it can be migrated.
- *  It returns NULL if the block was unreadable.
+ * Read a specified block, and return the buffer head that refers
+ * to it.  The memory is allocated from the movable area so that it can
+ * be migrated.  The returned buffer head has its refcount increased.
+ * The caller should call brelse() when it has finished with the buffer.
+ *
+ * Context: May sleep waiting for I/O.
+ * Return: NULL if the block was unreadable.
  */
-static inline struct buffer_head *
-__bread(struct block_device *bdev, sector_t block, unsigned size)
+static inline struct buffer_head *__bread(struct block_device *bdev,
+		sector_t block, unsigned size)
 {
 	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
 }
-- 
2.43.0


