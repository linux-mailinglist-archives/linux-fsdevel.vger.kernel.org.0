Return-Path: <linux-fsdevel+bounces-61848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AFAB7ED56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C709583012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0002F28FC;
	Tue, 16 Sep 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGNw+XlW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0A2D3A9B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066643; cv=none; b=TK7gb56X+HOehZ8PPMYlbAw6LrXgKBC/6bVQqyGqgJKDDvEfCyolrWgoq4K4t5lS1tarYGVD4jLCsgvosF5MOyCDmD7KShdB3nHWh+hrVW2nEfK06R4iKOrTJZn76x1OGnahkQ3hV1JnkIq2uxh3Cd32pCKzyYO9ElJ2fPp4cO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066643; c=relaxed/simple;
	bh=v/oH/bA3zHlDx6AoS8dJvAX6fNMwGzGWbHWWcg+4xes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9Vcw3iz2BdrRBoBqIvtQhbJRrHvKo9Ej4j3N6z6JGOBTmIw0/887fed4JJwEzcX13XnQkCDIq0ZA5D3XT0JjdtgiRZvutzytjnNv3b6YJOyHmNouPxRilbN6pg7qsOLhedWpwaeMhx5imgWFKizeC7MmbDsl240cjG8bbJ1px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGNw+XlW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24457f581aeso60815315ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066641; x=1758671441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpiD9B+H/ZQu+kBE6NMyJEPBPyApmQSIRlPeCw99S60=;
        b=jGNw+XlWHkH/Cag743KDhCQy7rmeJtUXYa5shBAB23kyjBRMliL+GwtJvfzgymhCtk
         h6VRzf8DZKuORGOwiKCaCVzCd1Kkj6Ea2PTYiT/IHF3BMtL+jCI4hCzD6kl7evasx9TD
         aMVIy53eNCF2iixfYMLfzr8KgA20GknfslzyQUT3N3eKB9W9z2cg14ZFtNmX+qYHCwPL
         06x0h00qu1X0OGJed4U9i4g6ud3DJ42PfKTzDo8U7jd3muGxyIeRCs1cloy9nHfeA6qC
         EdW6Q2WHmvJX7LHL9VfCtvOiqoCQiDIcllfNM63hMwsXCBAf6US7EMcutXt1s4M1hj+z
         liWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066641; x=1758671441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpiD9B+H/ZQu+kBE6NMyJEPBPyApmQSIRlPeCw99S60=;
        b=JYz/24zq+VhnSqnsOKvbj/aiGHB9LmHrXvz2sAq1uDoq8/stTQlcEfQLZPaL6kQ3Ud
         BZKtgLkgHIWQlaQsv48SWkCAmlzSgSHN4HfTnrbk+n3lLoVoLN4MTPAID5Dt3MtpUFvz
         g4Br6PEPGA1pP14Uff7LgrHTAaG9+ZiWFeEb966zWIhiurgNOCi2s186FSZ++7qJf1Y5
         wAVOtN1q+sR/SC8T6C6hNsaWIw6PjDvaIC1S+nyuZ6mhuLOz1j8rKtOKr0gR+mwBRHRR
         8RFAVlwFCVj0+F7uXzHG6V/PC9KPyDnBvWRhVFGvE+3mPPk2CXTKh0eWQFKgH5nheJmL
         bdxA==
X-Forwarded-Encrypted: i=1; AJvYcCUX1trUmCsxocLU8XhUzf55qxvfgDtHQhzqZcnZMl9yIiMV/xcP4TfElrFfmKvGnPSOrVeDXC08HrUJ/Uq0@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJCEqNVYz9TvVweghUK7ykYxcT0Yd1MDNCtK8orHLsncg8czJ
	RXGc0LotmobfKu1ZnjraWiPmwExMmdye84iAihXTt1fSUAGOhI0EnVmZ
X-Gm-Gg: ASbGnctTrg7QiSzNFZ5s+j1rA70cxKGbRwbz1FIewlJOgHYvH1Yyxs1mszgdZQ0tVV2
	yWXhCDvFWH1AJYpTH2U6M/4EMFm7a9+4xZeqrezsdvn75iZx5xPo+y5R3m4UOlwK3e2Sc6G6mYY
	l8A5XjQodYR4K15JwuQ5CvBF82erjvQpP0E2ZmmJySEgAXFitF8Nw32J4df78GFfOtLodrqMEwG
	QsF6HXspUBow+Pkb1+5WMRK5CWHMQmaor+5SkEAhKujgrbSrpFM3Rxedh2jORlU1gyTvCTDuEPU
	rSMaE883fryvX3/NhkyDCDHT7DVJnnIfNNFGPgZ/lbIBChJO6zR8N+h4z2NWOdYRV/3Kn08CdrO
	qqjeX+hN4uegNEEY2SaMLF8o8fcdUNn1Gs/LSSpOkgDXWYQjz2g==
X-Google-Smtp-Source: AGHT+IEirYeCXLT3dAffxiMRRPLfaV9HxapLO/E1ob2xcQ5viLZt3Jlci0m3Ax0Uc4Ro+PVF6IUXXg==
X-Received: by 2002:a17:902:8b85:b0:267:e8a9:7e72 with SMTP id d9443c01a7336-26811ba510amr965595ad.12.1758066640823;
        Tue, 16 Sep 2025 16:50:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ff5199a91sm117987795ad.73.2025.09.16.16.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 09/15] iomap: add caller-provided callbacks for read and readahead
Date: Tue, 16 Sep 2025 16:44:19 -0700
Message-ID: <20250916234425.1274735-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add caller-provided callbacks for read and readahead so that it can be
used generically, especially by filesystems that are not block-based.

In particular, this:
* Modifies the read and readahead interface to take in a
  struct iomap_read_folio_ctx that is publicly defined as:

  struct iomap_read_folio_ctx {
	const struct iomap_read_ops *ops;
	struct folio *cur_folio;
	struct readahead_control *rac;
	void *read_ctx;
  };

  where struct iomap_read_ops is defined as:

  struct iomap_read_ops {
      int (*read_folio_range)(const struct iomap_iter *iter,
                             struct iomap_read_folio_ctx *ctx,
                             size_t len);
      void (*read_submit)(struct iomap_read_folio_ctx *ctx);
  };

  read_folio_range() reads in the folio range and is required by the
  caller to provide. read_submit() is optional and is used for
  submitting any pending read requests.

* Modifies existing filesystems that use iomap for read and readahead to
  use the new API, through the new statically inlined helpers
  iomap_bio_read_folio() and iomap_bio_readahead(). There is no change
  in functinality for those filesystems.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 .../filesystems/iomap/operations.rst          | 45 ++++++++++++
 block/fops.c                                  |  5 +-
 fs/erofs/data.c                               |  5 +-
 fs/gfs2/aops.c                                |  6 +-
 fs/iomap/buffered-io.c                        | 69 +++++++++++--------
 fs/xfs/xfs_aops.c                             |  5 +-
 fs/zonefs/file.c                              |  5 +-
 include/linux/iomap.h                         | 62 ++++++++++++++++-
 8 files changed, 159 insertions(+), 43 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index 067ed8e14ef3..dbb193415c0e 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -135,6 +135,29 @@ These ``struct kiocb`` flags are significant for buffered I/O with iomap:
 
  * ``IOCB_DONTCACHE``: Turns on ``IOMAP_DONTCACHE``.
 
+``struct iomap_read_ops``
+--------------------------
+
+.. code-block:: c
+
+ struct iomap_read_ops {
+     int (*read_folio_range)(const struct iomap_iter *iter,
+                             struct iomap_read_folio_ctx *ctx, size_t len);
+     void (*submit_read)(struct iomap_read_folio_ctx *ctx);
+ };
+
+iomap calls these functions:
+
+  - ``read_folio_range``: Called to read in the range. This must be provided
+    by the caller. The caller is responsible for calling
+    iomap_start_folio_read() and iomap_finish_folio_read() before and after
+    reading in the folio range. This should be done even if an error is
+    encountered during the read. This returns 0 on success or a negative error
+    on failure.
+
+  - ``submit_read``: Submit any pending read requests. This function is
+    optional.
+
 Internal per-Folio State
 ------------------------
 
@@ -182,6 +205,28 @@ The ``flags`` argument to ``->iomap_begin`` will be set to zero.
 The pagecache takes whatever locks it needs before calling the
 filesystem.
 
+Both ``iomap_readahead`` and ``iomap_read_folio`` pass in a ``struct
+iomap_read_folio_ctx``:
+
+.. code-block:: c
+
+ struct iomap_read_folio_ctx {
+    const struct iomap_read_ops *ops;
+    struct folio *cur_folio;
+    struct readahead_control *rac;
+    void *read_ctx;
+ };
+
+``iomap_readahead`` must set:
+ * ``ops->read_folio_range()`` and ``rac``
+
+``iomap_read_folio`` must set:
+ * ``ops->read_folio_range()`` and ``cur_folio``
+
+``ops->submit_read()`` and ``read_ctx`` are optional. ``read_ctx`` is used to
+pass in any custom data the caller needs accessible in the ops callbacks for
+fulfilling reads.
+
 Buffered Writes
 ---------------
 
diff --git a/block/fops.c b/block/fops.c
index ddbc69c0922b..a2c2391d8dfa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,12 +533,13 @@ const struct address_space_operations def_blk_aops = {
 #else /* CONFIG_BUFFER_HEAD */
 static int blkdev_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &blkdev_iomap_ops);
+	iomap_bio_read_folio(folio, &blkdev_iomap_ops);
+	return 0;
 }
 
 static void blkdev_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &blkdev_iomap_ops);
+	iomap_bio_readahead(rac, &blkdev_iomap_ops);
 }
 
 static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3b1ba571c728..be4191b33321 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -371,7 +371,8 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 {
 	trace_erofs_read_folio(folio, true);
 
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	iomap_bio_read_folio(folio, &erofs_iomap_ops);
+	return 0;
 }
 
 static void erofs_readahead(struct readahead_control *rac)
@@ -379,7 +380,7 @@ static void erofs_readahead(struct readahead_control *rac)
 	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
 					readahead_count(rac), true);
 
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	iomap_bio_readahead(rac, &erofs_iomap_ops);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..38d4f343187a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -424,11 +424,11 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	int error;
+	int error = 0;
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		iomap_bio_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_read_folio(ip, folio);
 	} else {
@@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_bio_readahead(rac, &gfs2_iomap_ops);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 379438970347..561378f2b9bb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -363,12 +363,6 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_read_folio_ctx {
-	struct folio		*cur_folio;
-	void			*read_ctx;
-	struct readahead_control *rac;
-};
-
 static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
@@ -377,11 +371,12 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 		submit_bio(bio);
 }
 
-static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
+static int iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
@@ -416,8 +411,15 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		bio_add_folio_nofail(bio, folio, plen, poff);
 		ctx->read_ctx = bio;
 	}
+	return 0;
 }
 
+const struct iomap_read_ops iomap_bio_read_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= iomap_bio_submit_read,
+};
+EXPORT_SYMBOL_GPL(iomap_bio_read_ops);
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
@@ -426,7 +428,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
-	loff_t count;
+	loff_t delta;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -445,23 +447,30 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
 
-		count = pos - iter->pos + plen;
-		if (WARN_ON_ONCE(count > length))
+		delta = pos - iter->pos;
+		if (WARN_ON_ONCE(delta + plen > length))
 			return -EIO;
+		length -= delta + plen;
+
+		ret = iomap_iter_advance(iter, &delta);
+		if (ret)
+			return ret;
 
 		if (plen == 0)
-			return iomap_iter_advance(iter, &count);
+			return 0;
 
 		if (iomap_block_needs_zeroing(iter, pos)) {
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			*cur_folio_owned = true;
-			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+			ret = ctx->ops->read_folio_range(iter, ctx, plen);
+			if (ret)
+				return ret;
 		}
 
-		length -= count;
-		ret = iomap_iter_advance(iter, &count);
+		delta = plen;
+		ret = iomap_iter_advance(iter, &delta);
 		if (ret)
 			return ret;
 		pos = iter->pos;
@@ -469,16 +478,15 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return 0;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx)
 {
+	struct folio *folio = ctx->cur_folio;
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_read_folio_ctx ctx = {
-		.cur_folio	= folio,
-	};
 	/*
 	 * If an external IO helper takes ownership of the folio, it is
 	 * responsible for unlocking it when the read completes.
@@ -489,10 +497,11 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx,
+		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&cur_folio_owned);
 
-	iomap_bio_submit_read(&ctx);
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
 
 	if (!cur_folio_owned)
 		folio_unlock(folio);
@@ -533,8 +542,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 
 /**
  * iomap_readahead - Attempt to read pages from a file.
- * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @ctx: The ctx used for issuing readahead.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -546,16 +555,15 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx)
 {
+	struct readahead_control *rac = ctx->rac;
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_read_folio_ctx ctx = {
-		.rac	= rac,
-	};
 	/*
 	 * If an external IO helper takes ownership of the folio, it is
 	 * responsible for unlocking it when the read completes.
@@ -565,13 +573,14 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx,
+		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_folio_owned);
 
-	iomap_bio_submit_read(&ctx);
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
 
-	if (ctx.cur_folio && !cur_folio_owned)
-		folio_unlock(ctx.cur_folio);
+	if (ctx->cur_folio && !cur_folio_owned)
+		folio_unlock(ctx->cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..0c2ed00733f2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -742,14 +742,15 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
+	return 0;
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index fd3a5922f6c3..4d6e7eb52966 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,13 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	iomap_bio_read_folio(folio, &zonefs_read_iomap_ops);
+	return 0;
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_bio_readahead(rac, &zonefs_read_iomap_ops);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0938c4a57f4c..4a168ebb40f5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -16,6 +16,7 @@ struct inode;
 struct iomap_iter;
 struct iomap_dio;
 struct iomap_writepage_ctx;
+struct iomap_read_folio_ctx;
 struct iov_iter;
 struct kiocb;
 struct page;
@@ -339,8 +340,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+int iomap_read_folio(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx);
+void iomap_readahead(const struct iomap_ops *ops,
+		struct iomap_read_folio_ctx *ctx);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
@@ -478,6 +481,35 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
+struct iomap_read_folio_ctx {
+	const struct iomap_read_ops *ops;
+	struct folio		*cur_folio;
+	struct readahead_control *rac;
+	void			*read_ctx;
+};
+
+struct iomap_read_ops {
+	/*
+	 * Read in a folio range.
+	 *
+	 * The caller is responsible for calling iomap_start_folio_read() and
+	 * iomap_finish_folio_read() before and after reading in the folio
+	 * range. This should be done even if an error is encountered during the
+	 * read.
+	 *
+	 * Returns 0 on success or a negative error on failure.
+	 */
+	int (*read_folio_range)(const struct iomap_iter *iter,
+			struct iomap_read_folio_ctx *ctx, size_t len);
+
+	/*
+	 * Submit any pending read requests.
+	 *
+	 * This is optional.
+	 */
+	void (*submit_read)(struct iomap_read_folio_ctx *ctx);
+};
+
 /*
  * Flags for direct I/O ->end_io:
  */
@@ -543,4 +575,30 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 
 extern struct bio_set iomap_ioend_bioset;
 
+#ifdef CONFIG_BLOCK
+extern const struct iomap_read_ops iomap_bio_read_ops;
+
+static inline void iomap_bio_read_folio(struct folio *folio,
+		const struct iomap_ops *ops)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.cur_folio	= folio,
+	};
+
+	iomap_read_folio(ops, &ctx);
+}
+
+static inline void iomap_bio_readahead(struct readahead_control *rac,
+		const struct iomap_ops *ops)
+{
+	struct iomap_read_folio_ctx ctx = {
+		.ops		= &iomap_bio_read_ops,
+		.rac		= rac,
+	};
+
+	iomap_readahead(ops, &ctx);
+}
+#endif /* CONFIG_BLOCK */
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.3


