Return-Path: <linux-fsdevel+bounces-7621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37190828842
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFDA284AE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B03B799;
	Tue,  9 Jan 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjSgiwUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0B3B296;
	Tue,  9 Jan 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=O7lis2itUlx9IU8kc9yc0wwrtDMZQuoZYKYmXgRl3Lw=; b=UjSgiwUMpvBrJVcDFbKwXeW/6A
	ozkYUjDTagYCXTCZls66gJHF5HQOysaAECLs0wvEeLz24S0H4G/37KPMqVF/qxNuLD0qSAGiEmtje
	UKqWNxG1EzUZcdip9yDkUz9k1kIOTffGElk8ggUYbJk/U+z/XNe2XJwNFa/mZ6qC/8FabQmMnFdMu
	9WCpfVY60l6MySLYqRFvf75Erli+/NKwmSeYfk0fhin5l3FRQS95BxnINGfb2oOJPiILhpR8KyCYq
	0vTPxLtYNVk5nLv0D3wYEQ3Q4NBbuZZkNmLONNmmXSZSF61a1toFzWC68wD55AaZ8M5L/7C+R8Msc
	/wyLFLiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB1-009xrW-38; Tue, 09 Jan 2024 14:33:59 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 4/8] buffer: Fix __bread and __bread_gfp kernel-doc
Date: Tue,  9 Jan 2024 14:33:53 +0000
Message-Id: <20240109143357.2375046-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240109143357.2375046-1-willy@infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
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
index 25861241657f..160bbc1f929c 100644
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


