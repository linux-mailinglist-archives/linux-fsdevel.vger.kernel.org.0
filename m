Return-Path: <linux-fsdevel+bounces-59693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15715B3C5ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF2F1883510
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 00:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055D35E4F8;
	Fri, 29 Aug 2025 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT2YknUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4C35E4D7;
	Fri, 29 Aug 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511916; cv=none; b=WNJwG3TtXJIMXWGQW7ZDUR5XoUa5h+FAFx6oZWPsRJ8xxNHa/TdvNo9KdfsyC90EwrykA3pWngAIgn2MHwE9U+V3/UY61Lq2tWemNM/47g5fFV7jOyifM5a5iLZTzJoxikNF6i9wYwZassnvZENBCDPyVEJH5BqsOXC9qxP1qLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511916; c=relaxed/simple;
	bh=9ChcMqWHr7YUWNpBrwkY10BHDeR08xrICOcgnNW1JQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwMfMyBXSfK6Wwkj6LFcBtptQlOpYvA8YXbVRpKzpuKfQ0uT8wxNkGBVdd4QZb2YsAuBVHlGpAfpgwqG7E/U46O6YZZP/r36KEUUqa0gvCYbnJLofSGc+9Ev8tf2mwAu1iIwFL6nJ81eR4Bk0bSmJD5HTN+XJ38sKPeOXCRJt1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT2YknUp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2326586b3a.2;
        Fri, 29 Aug 2025 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511914; x=1757116714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pcWt9J0dpXRUUCvpQHIeTIYS0KomayC8+Y4qs2SW/g=;
        b=UT2YknUpQrEMSl6bI6a+nE8+bYNUiwDMNA7i9lnSs0q4wkED6wv2SEoSpBP5u6ViwN
         GLMJwcIAWwCZxefyX3U4f55wo5jO5PI9SKnuSjD0Z3T3ERdhFOmAzDR+GeOZA62trXTb
         KwcQv6RLz5vXhk0IyU9MqfMcYjHMM5VB2QGa3qbR8KTlG7BIJLh0dWu1O9i5FSKBm0rJ
         Mny35SdQr1zcd6il7jEv79W3tkf8QHlhlyy0NamgRwC5GEHCHpW1VYkHBJG128rkuU9W
         3Qv5ay7kIpzviBZI0w5eIqjuZBa50bS0KJQdTweVorrEIrnoUYfKj/btJ0qAiGIL+oRU
         ywTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511914; x=1757116714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pcWt9J0dpXRUUCvpQHIeTIYS0KomayC8+Y4qs2SW/g=;
        b=gAHNF2US8SdYLYA79oBxLwUiaVnjpRlSqDpkX9EoA3STMAX632NfwSJDJV4ISJs7Hf
         gn2LiouKWRpZl2ac6V65jDJZ6797s119gJ99sZQn/SrirN+EvBCSw+3lnLAimYdov++M
         W+wgCif5lxskwJnX9hxCH6Vg2TPNulAneSI0BiDBhBCreolEr8mCAOmB72d7lRoG6mnW
         8NKZf9eEXCnL9z7axB3d3fAt7tgGgWi1M8K16Q1UyOC7bGrtii9to/P76Kz7+BPF05jl
         WRNXP/3hEChWEm3t+BZrBSoOAt6CSv/jZkGfdlfiQP5cqhO2bAs3DiXiwevQHPnfh5vQ
         DxNw==
X-Forwarded-Encrypted: i=1; AJvYcCWqjxPThWk8eg5+1ZbqyFb4pqz6t986q7Say4jwh//zvTB7R6o7lJLhSySa+/on+EfyJ9Z906yrZrM=@vger.kernel.org, AJvYcCWvOp5ohYqghuuKtkjYk2Bydx3JL+WXcPbdCnR34y7Vykl39OLU4RSXn7lLdm8POps+PMQapjk+s7RheNtpGg==@vger.kernel.org, AJvYcCXaw68x8TuGjEIav+UYmRDs2vsThkTUKJypB+KzAJI2G4dd7Ya1KjYPnBCDCl0jIanrI4o46j/WTXCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2WY/ZTGOWN0PT2wt6oN1150GrS4CQ5R5U4I9rbhRJjO8tX2F
	tA4BfJ7FEnkSvUYqte9646Os08E6emv5MKvd+O7hQjHDKgldCAfCp8n5
X-Gm-Gg: ASbGncveqhV3mrcKHn5m0jxlkmK9PZqjBYf2wus/HMvYOYMxMbwJfmzz4n89nPYFsWf
	fijLeJow+nmXZDqvTuWs8fgKciqJIkDdB9O8+lB/3p/YYeNAfToNyp48wghaqqy2GJsT1VkP3Au
	HzG6c3pNNo/PKiy5Z2UBmUcxai9ZtAWCI9iyTjdOeQ0COGatnMkX+oGo42KFpGhkoR9XrO9Uck4
	s9SPePvkdNP056Z7pvriN7VddhU/yCYh8+8+IhnniHT4dfk2PXNA6+lqWeQ9zMh5bHcsrx11uW1
	4/C74uG46GX6WiRNYWQqBu1rfsy8aZfAivDkwCIIwsdz+jX2m1KRqXM4dMuH88QiD9zmsUexeu3
	++7aCF9FWSeebH/nlwA==
X-Google-Smtp-Source: AGHT+IH2aCRdSuTovB6rGkwUS21AUc4hZyg4XknbBgsTMLXG+/5RR2PNmw/F9tiHecqo6r6cq23POw==
X-Received: by 2002:a05:6a00:9a6:b0:772:3d51:7cc6 with SMTP id d2e1a72fcca58-7723e38ab88mr498619b3a.28.1756511913542;
        Fri, 29 Aug 2025 16:58:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4beb67sm3487941b3a.65.2025.08.29.16.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:33 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 12/16] iomap: add iomap_read_ops for read and readahead
Date: Fri, 29 Aug 2025 16:56:23 -0700
Message-ID: <20250829235627.4053234-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "struct iomap_read_ops" that contains a read_folio_range()
callback that callers can provide as a custom handler for reading in a
folio range, if the caller does not wish to issue bio read requests
(which otherwise is the default behavior). read_folio_range() may read
the request asynchronously or synchronously. The caller is responsible
for calling iomap_start_folio_read()/iomap_finish_folio_read() when
reading the folio range.

This makes it so that non-block based filesystems may use iomap for
reads.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 19 +++++
 block/fops.c                                  |  4 +-
 fs/erofs/data.c                               |  4 +-
 fs/gfs2/aops.c                                |  4 +-
 fs/iomap/buffered-io.c                        | 79 +++++++++++++------
 fs/xfs/xfs_aops.c                             |  4 +-
 fs/zonefs/file.c                              |  4 +-
 include/linux/iomap.h                         | 21 ++++-
 8 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 067ed8e14ef3..215053f0779d 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -57,6 +57,25 @@ The following address space operations can be wrapped easily:
  * ``bmap``
  * ``swap_activate``
 
+``struct iomap_read_ops``
+--------------------------
+
+.. code-block:: c
+
+ struct iomap_read_ops {
+     int (*read_folio_range)(const struct iomap_iter *iter,
+                        struct folio *folio, loff_t pos, size_t len);
+ };
+
+iomap calls these functions:
+
+  - ``read_folio_range``: Called to read in the range (read does not need to
+    be synchronous). The caller is responsible for calling
+    iomap_start_folio_read() and iomap_finish_folio_read() when reading the
+    folio range. This should be done even if an error is encountered during
+    the read. If this function is not provided by the caller, then iomap
+    will default to issuing asynchronous bio read requests.
+
 ``struct iomap_write_ops``
 --------------------------
 
diff --git a/block/fops.c b/block/fops.c
index ddbc69c0922b..b42e16d0eb35 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,12 +533,12 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..ea451f233263 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -371,7 +371,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
@@ -379,7 +379,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..bf531bcfd8a0 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -428,7 +428,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5d153c6b16b6..06f2c857de64 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -335,8 +335,8 @@ void iomap_start_folio_read(struct folio *folio, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_start_folio_read);
 
-void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
-		int error)
+static void __iomap_finish_folio_read(struct folio *folio, size_t off,
+		size_t len, int error, bool update_bitmap)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -346,7 +346,7 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		unsigned long flags;
 
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		if (!error)
+		if (!error && update_bitmap)
 			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
 		ifs->read_bytes_pending -= len;
 		finished = !ifs->read_bytes_pending;
@@ -356,6 +356,12 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
+{
+	return __iomap_finish_folio_read(folio, off, len, error, true);
+}
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
 #ifdef CONFIG_BLOCK
@@ -379,7 +385,6 @@ static void iomap_read_folio_range_async(struct iomap_iter *iter,
 	struct bio *bio = iter->private;
 	sector_t sector;
 
-	ctx->folio_unlocked = true;
 	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
@@ -453,15 +458,17 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
 #endif /* CONFIG_BLOCK */
 
 static int iomap_readfolio_iter(struct iomap_iter *iter,
-		struct iomap_readfolio_ctx *ctx)
+		struct iomap_readfolio_ctx *ctx,
+		const struct iomap_read_ops *read_ops)
 {
 	const struct iomap *iomap = &iter->iomap;
+	struct iomap_folio_state *ifs;
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
 	loff_t count;
-	int ret;
+	int ret = 0;
 
 	if (iomap->type == IOMAP_INLINE) {
 		ret = iomap_read_inline_data(iter, folio);
@@ -471,7 +478,14 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
 	}
 
 	/* zero post-eof blocks as the page may be mapped */
-	ifs_alloc(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
+
+	/*
+	 * Add a bias to ifs->read_bytes_pending so that a read is ended only
+	 * after all the ranges have been read in.
+	 */
+	if (ifs)
+		iomap_start_folio_read(folio, 1);
 
 	length = min_t(loff_t, length,
 			folio_size(folio) - offset_in_folio(folio, pos));
@@ -479,35 +493,53 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos,
 				length, &poff, &plen);
 		count = pos - iter->pos + plen;
-		if (plen == 0)
-			return iomap_iter_advance(iter, &count);
+		if (plen == 0) {
+			ret = iomap_iter_advance(iter, &count);
+			break;
+		}
 
 		if (iomap_block_needs_zeroing(iter, pos)) {
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
-			iomap_read_folio_range_async(iter, ctx, pos, plen);
+			ctx->folio_unlocked = true;
+			if (read_ops && read_ops->read_folio_range) {
+				ret = read_ops->read_folio_range(iter, folio, pos, plen);
+				if (ret)
+					break;
+			} else {
+				iomap_read_folio_range_async(iter, ctx, pos, plen);
+			}
 		}
 
 		length -= count;
 		ret = iomap_iter_advance(iter, &count);
 		if (ret)
-			return ret;
+			break;
 		pos = iter->pos;
 	}
-	return 0;
+
+	if (ifs) {
+		__iomap_finish_folio_read(folio, 0, 1, ret, false);
+		ctx->folio_unlocked = true;
+	}
+
+	return ret;
 }
 
 static void iomap_readfolio_complete(const struct iomap_iter *iter,
-		const struct iomap_readfolio_ctx *ctx)
+		const struct iomap_readfolio_ctx *ctx,
+		const struct iomap_read_ops *read_ops)
 {
-	iomap_readfolio_submit(iter);
+	if (!read_ops || !read_ops->read_folio_range)
+		iomap_readfolio_submit(iter);
 
 	if (ctx->cur_folio && !ctx->folio_unlocked)
 		folio_unlock(ctx->cur_folio);
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_ops *read_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
@@ -522,16 +554,17 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readfolio_iter(&iter, &ctx);
+		iter.status = iomap_readfolio_iter(&iter, &ctx, read_ops);
 
-	iomap_readfolio_complete(&iter, &ctx);
+	iomap_readfolio_complete(&iter, &ctx, read_ops);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readfolio_ctx *ctx)
+		struct iomap_readfolio_ctx *ctx,
+		const struct iomap_read_ops *read_ops)
 {
 	int ret;
 
@@ -545,7 +578,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		WARN_ON(!ctx->cur_folio);
 		ctx->folio_unlocked = false;
-		ret = iomap_readfolio_iter(iter, ctx);
+		ret = iomap_readfolio_iter(iter, ctx, read_ops);
 		if (ret)
 			return ret;
 	}
@@ -557,6 +590,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @read_ops: Optional ops callers can pass in if they want custom handling.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -568,7 +602,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_read_ops *read_ops)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
@@ -582,9 +617,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx, read_ops);
 
-	iomap_readfolio_complete(&iter, &ctx);
+	iomap_readfolio_complete(&iter, &ctx, read_ops);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 1ee4f835ac3c..fb2150c0825a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -742,14 +742,14 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..96470daf4d3f 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0938c4a57f4c..a7247439aeb5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,21 @@ struct iomap_write_ops {
 			struct folio *folio, loff_t pos, size_t len);
 };
 
+struct iomap_read_ops {
+	/*
+	 * If the filesystem doesn't provide a custom handler for reading in the
+	 * contents of a folio, iomap will default to issuing asynchronous bio
+	 * read requests.
+	 *
+	 * The read does not need to be done synchronously. The caller is
+	 * responsible for calling iomap_start_folio_read() and
+	 * iomap_finish_folio_read() when reading the folio range. This should
+	 * be done even if an error is encountered during the read.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct folio *folio, loff_t pos, size_t len);
+};
+
 /*
  * Flags for iomap_begin / iomap_end.  No flag implies a read.
  */
@@ -339,8 +354,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_read_ops *read_ops);
+void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
+		const struct iomap_read_ops *read_ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.47.3


