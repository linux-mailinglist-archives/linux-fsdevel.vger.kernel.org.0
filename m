Return-Path: <linux-fsdevel+bounces-62447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251BB93B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCAD188FC4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDF1E1DEC;
	Tue, 23 Sep 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8tsuwoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5311F8755
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587649; cv=none; b=ZytKmoNcHeN5kuepdDtm0a4LrXaZ/3roUOfhOPyqWPV9Ak5EEFVp3ZGRhJBulRQCLbRlbRaxbWvprCroTdQmtDd4zmBPzUsV+8+yK9KHAx9657swPfPRR82LnnEdFF9badAxMXhiTEHhPmyDj20MLjr1ylV56kSA8iJKdFgm77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587649; c=relaxed/simple;
	bh=Wu2JwtDRAeZn4LkmdLkuPXTih0zW0KLFfb48whBOb2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miukbo6mk8AuL6ZU+Y2VcOF2szw5mm32ABvBi9axbbVGA7M/6ipecKUgzrww9hUFuhqT7mbTnBRlZhvGJECQQapgancTUop0Vdi0Y4JHm0coffvRas1mENDwFs5JbejA3lmOn0IoDxxfYHtUUt6W1jdeQN8ziHMuOLNQNL5wddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8tsuwoJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5000529b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587645; x=1759192445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BozOtmGP+a7aPouxnlnguX04qjwMoWZ9FgN9qeSLzS8=;
        b=i8tsuwoJ8q7+XWaUYB9NeqSAW1vh6v0FmxJWQM4zS4umfwjQP3F4Gv2hDotOa83svi
         VVxZ9/4xMKqsCvYSThh2dN4/KXFp74KSMWRkZY4/QuGFbzvquUQNgBW7RLg8x1ZvOrYk
         n0rxHHiNKvNnsvfJhU4vl69UDuvEWf0eUdABvm0QLp0lKrhcuTJGafx71oXLLqb9ELJB
         fCyWkIYhRI8dLmxab1mfFuB3pAlJnT/rj4nwnrcgCRS7T17mgOAAXlgdj/mqqMO/Pp1d
         Hwbo7LN9Pf2LIKVUVzaKAAL6RyRLDO4CIFqGIQt3EAKxPf+PGdw1JWqQnLPApycNOnaf
         oNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587645; x=1759192445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BozOtmGP+a7aPouxnlnguX04qjwMoWZ9FgN9qeSLzS8=;
        b=LWJZeSA+2+JxHUm+3v165aDrA++vgrOfqZF/uWNECR3otHe75lguP5CWPkksNymbN9
         LcWcAN3ACDJeUeQhyFBamFuXkDsMTH16z39t/G+93yMnLtSxZG9OCxFG2ooSHgzzzx2L
         tr2xwDMx0EN4o6B9YLoR/4YOpA8F+747rQLshy2DlwpG/J+EXYGDbKaE92W10KIsYRx+
         /FUVjZLC1W+DcWYOqd+wPIonUufJVkf5qIVIeAea2FmuP9UiMa42FgsmH6Gg+ZkxF92p
         09iZ68JJrxQLsI8DSHaZ3cU/KYI091THjkHUkBtacuAlHKPxuCm1B3Oie1Ffx/0ljOgz
         TlEw==
X-Forwarded-Encrypted: i=1; AJvYcCVndeByKAtBo6CiPWke9C0P8rIzT9C3uA2K1J305PV+P72I4lnqHY9dR/oQUixUpVWbsLW3m5yISptEbpFk@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQLJyzbM2iEDpA2X2etAKf6PPuiiLDEwRpXzPUtC01zet5otv
	n/4Mat8onDoJzffjjk+wGlpYd0go2vtBxGF6BLAVHNQa2IRpymKRiLW6
X-Gm-Gg: ASbGnctvwS5R2T3/rVpnBnPBUW4oReItsYpiHmm5EnIb5+endy6NtkF0ozuWAZTUTYP
	y2u+LlURF9h1Gemr5T3yvbvW2EBSFPexXtPIuq7sZl1iFe551bD4T1JTWQ+MtgsWesrvXflWjDM
	ZPUl7USefk9qOVM4+rWEkkqbGXHeZmLc6j3KZBVtiS0Biu1aBv+3cd3NWQ+AYT4D9LPgs/RSsA9
	zr95KOlqncblZOugPSCeMFKSPbZqvi3wsRKp2amXcAPz4CT7LfNYFgpkocfAXI5wgJzhXXhhlJX
	GCVdaxgyQntJYqZfIXuNhUbQGdOqD2wxk0nxUwu3EYLH4v379KXcR9Uv3zZguaet7213+hlUvbI
	D07Swmn9cjXqYR7PByXA9h226hrXPOrIu1fU5zsV83rOYXcBEnRtu0TSwqmRu
X-Google-Smtp-Source: AGHT+IHG+jSpIkbtJUu1peZn/Sr9iCMu4pM7x3him/KiSzOc37XyKtkpEeq7vc70mI8C1ZnRXOj2Wg==
X-Received: by 2002:a05:6a20:7f81:b0:2c4:5793:3415 with SMTP id adf61e73a8af0-2cff0834db0mr1046373637.57.1758587645148;
        Mon, 22 Sep 2025 17:34:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551c279cd5sm9886542a12.3.2025.09.22.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 09/15] iomap: add caller-provided callbacks for read and readahead
Date: Mon, 22 Sep 2025 17:23:47 -0700
Message-ID: <20250923002353.2961514-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c                        | 68 +++++++++++--------
 fs/xfs/xfs_aops.c                             |  5 +-
 fs/zonefs/file.c                              |  5 +-
 include/linux/iomap.h                         | 62 ++++++++++++++++-
 8 files changed, 158 insertions(+), 43 deletions(-)

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
index 469079524208..81ba0cc7705a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -373,12 +373,6 @@ static void iomap_read_end_io(struct bio *bio)
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
@@ -387,11 +381,12 @@ static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
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
@@ -426,8 +421,15 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
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
 		struct iomap_read_folio_ctx *ctx, bool *folio_owned)
 {
@@ -436,7 +438,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
-	loff_t count;
+	loff_t pos_diff;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -454,12 +456,16 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
 
-		count = pos - iter->pos + plen;
-		if (WARN_ON_ONCE(count > length))
+		pos_diff = pos - iter->pos;
+		if (WARN_ON_ONCE(pos_diff + plen > length))
 			return -EIO;
 
+		ret = iomap_iter_advance(iter, pos_diff);
+		if (ret)
+			return ret;
+
 		if (plen == 0)
-			return iomap_iter_advance(iter, count);
+			return 0;
 
 		/* zero post-eof blocks as the page may be mapped */
 		if (iomap_block_needs_zeroing(iter, pos)) {
@@ -467,28 +473,29 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			*folio_owned = true;
-			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+			ret = ctx->ops->read_folio_range(iter, ctx, plen);
+			if (ret)
+				return ret;
 		}
 
-		ret = iomap_iter_advance(iter, count);
+		ret = iomap_iter_advance(iter, plen);
 		if (ret)
 			return ret;
-		length -= count;
+		length -= pos_diff + plen;
 		pos = iter->pos;
 	}
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
 	 * If an IO helper takes ownership of the folio, it is responsible for
 	 * unlocking it when the read completes.
@@ -499,10 +506,11 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx,
+		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&folio_owned);
 
-	iomap_bio_submit_read(&ctx);
+	if (ctx->ops->submit_read)
+		ctx->ops->submit_read(ctx);
 
 	if (!folio_owned)
 		folio_unlock(folio);
@@ -545,8 +553,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 
 /**
  * iomap_readahead - Attempt to read pages from a file.
- * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @ctx: The ctx used for issuing readahead.
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -558,16 +566,15 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
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
 	 * If an IO helper takes ownership of the folio, it is responsible for
 	 * unlocking it when the read completes.
@@ -577,13 +584,14 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
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
index edc7b3682903..c1a7613bca6e 100644
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
@@ -337,8 +338,10 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
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
@@ -476,6 +479,35 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
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
@@ -541,4 +573,30 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 
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


