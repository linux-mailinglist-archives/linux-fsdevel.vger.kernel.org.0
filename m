Return-Path: <linux-fsdevel+bounces-51624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29906AD97AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FE73AF2D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE228DEEE;
	Fri, 13 Jun 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVO3Tl1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476C28D8EF;
	Fri, 13 Jun 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851449; cv=none; b=OZwDOdNp2CvvTRVe7P3/Pd2Dj6O2eOcN7s7McHiqUszHOIRl1mIvjyp97b0p7+hyICi2fEUlbEEayPcafEZ4D4YC34X4vE+rKF7YTGNmY1jbYFs5xv4+4ub9cYsFiAsczRnzYDEGJ5hVJpCTlS873RU0hxmzWp3Bjpz/C/uEDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851449; c=relaxed/simple;
	bh=0QRmqQ2lG0OExy/aH/wMv6vO6zx9h8zB7PdqWITHJqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3LHURJKd6Ua5FdBqep3MNst6OpAVecfqMHLbVLUSxl5WANl3zGF1BoiawFy1qV34r9FtsAg1IvKeCU0dmEcEZxN3jBy7paiVoFiGLGl3APrUxfsxhHxuXeZNT5nPUxEtyd+pyik2biNeZF8JZlQLIrzL05XpT0Dwtry+SnS17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVO3Tl1w; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2269898b3a.2;
        Fri, 13 Jun 2025 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851447; x=1750456247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdJ7TARLe98sT8yHqOMw3nfbroAol4WaQeu9GwWvtuo=;
        b=LVO3Tl1wbt+6RMSWa7jqiO+Yc5Qylssryhk/kNJmXii+Bt5aWdMXuNZ6oeYBz+B8Dj
         RVd8oojdypEqMwBdMcgSbQMxPEw/y0X05JpV/2knvenLMoHV5s2AUGssn+ktAMh/sUMK
         br4MlsNOEULCcOei6uL8qzT9i1GEQcBUt/EfmL38nqSQEd7+j9TeLhgypxpArFI5RAPc
         sPCTcSfIz5/44FYReB2khckAuHOOt4n0FH4erF0LjwzdjWbn/I3aX3e2Ye8gRdll1lex
         NQYCakwSx4v9PTRef5y/LTyVccd/m1yHDx/yj3uJa+3FM9QMiMPZWfXBdJdywcMpVvLV
         dP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851447; x=1750456247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdJ7TARLe98sT8yHqOMw3nfbroAol4WaQeu9GwWvtuo=;
        b=HST/3nIW6D53bmiSxboETpUfmvYIAlhW/Kl6voec/aTvRw7sQxzncCnee3MKfkKHZP
         OLRfMl7i5NOdv9lAowtb95QbYVOLrAa0RNgtAlmK4GDseN7qFnT2fUOtxKgEgdSWEj4a
         H4nGRQ/2/a93fZLzGJ7fXwbXyZRHLHDJ8v9GUhs4a21IcNUZJXEIjYrSAb9Z0dNwwvTn
         qhRgXShn5f/G3AEwIucFLKR0zANxlsBAe8YodR336YnL2nRcjd/RiER4996FT8mjknMa
         ikhcUpWk255D/GckHNI3YxpP7Qe1+nV4/fqogUPFZlAJbBOIYkkixqp48UpKQZawoaxb
         3Fcw==
X-Forwarded-Encrypted: i=1; AJvYcCVE1S7xwlqkSfM+anbs32dJ4XMkGpWW8Z+TO8VPwewbn2e+BzxOVkMnGirwCj8MdASZBa+KszZOaxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbcqpB5rL2f0NgRZ1Q9T7Qjv4/r/Ehi6cwUL0MKHMMYChtwbo
	VdQv9zmjx0WSqRS4tYJ2Pf3rSpQXYN093aK+CBuyONz23b+1n1rJ8Rq9Sg8zQg==
X-Gm-Gg: ASbGncsdChTAxvSL3wNKVV85eXLSCuycQunjwlB9/XJdANEnBHd4UmwIdcHC33tMubZ
	mBvBr/+npe+PWh2v62aZC9clCFc/E8X16217+anE9/vYDGO50UIfvG9kbXtCBMx2vtBX7c6e0Kf
	gaFTU1m6in3kX8dE4EnE6btlqooOlNFmiZaz0hrYQtP8eh2iOWa532IJtzR2t93GacnnatusJWA
	BA9Q49vcunaT23327VoI1IivgmRcfif1QGTEwRJMsfv7uw1jCG+S8fKjUoKQH6nCR4GmEO03Tis
	PDw4zgkGOBRJ6mYjAU5sTo/o1tdQt2ht2SOAG795lEg+6LXR3M3/IwnI
X-Google-Smtp-Source: AGHT+IHaIhOYL8rn/+cs2Fpc4arJ6H2ZV6C3OQ2myH3IC+O0vSdwWEynXjwj4p40195X18SdbvsY+A==
X-Received: by 2002:a05:6a20:430d:b0:1f5:7cb4:b713 with SMTP id adf61e73a8af0-21fbd55995cmr1152752637.19.1749851447061;
        Fri, 13 Jun 2025 14:50:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe163a0f2sm2274755a12.12.2025.06.13.14.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
Date: Fri, 13 Jun 2025 14:46:29 -0700
Message-ID: <20250613214642.2903225-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper function, iomap_bio_readpage(), around the bio readpage
logic so that callers that do not have CONFIG_BLOCK set may also use
iomap for buffered io.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 71 ++++++++++++++++++++++++++++++++++++++
 fs/iomap/buffered-io.c     | 71 +-------------------------------------
 fs/iomap/internal.h        | 11 ++++++
 3 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index 798cb59dbbf4..e27a43291653 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -10,6 +10,77 @@
 
 #include "internal.h"
 
+static void iomap_finish_folio_read(struct folio *folio, size_t off,
+		size_t len, int error)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	bool uptodate = !error;
+	bool finished = true;
+
+	if (ifs) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		if (!error)
+			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		ifs->read_bytes_pending -= len;
+		finished = !ifs->read_bytes_pending;
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	if (finished)
+		folio_end_read(folio, uptodate);
+}
+
+static void iomap_read_end_io(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio)
+		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_put(bio);
+}
+
+void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
+		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
+		loff_t length)
+{
+	struct folio *folio = ctx->cur_folio;
+	sector_t sector;
+
+	sector = iomap_sector(iomap, pos);
+	if (!ctx->bio ||
+	    bio_end_sector(ctx->bio) != sector ||
+	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
+		gfp_t orig_gfp = gfp;
+		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+
+		if (ctx->bio)
+			submit_bio(ctx->bio);
+
+		if (ctx->rac) /* same as readahead_gfp_mask */
+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
+		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				     REQ_OP_READ, gfp);
+		/*
+		 * If the bio_alloc fails, try it again for a single page to
+		 * avoid having to deal with partial page reads.  This emulates
+		 * what do_mpage_read_folio does.
+		 */
+		if (!ctx->bio) {
+			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+					     orig_gfp);
+		}
+		if (ctx->rac)
+			ctx->bio->bi_opf |= REQ_RAHEAD;
+		ctx->bio->bi_iter.bi_sector = sector;
+		ctx->bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+	}
+}
+
 int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap)
 {
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b7b7222a1700..45c701af3f0c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -267,45 +267,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
-{
-	struct iomap_folio_state *ifs = folio->private;
-	bool uptodate = !error;
-	bool finished = true;
-
-	if (ifs) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&ifs->state_lock, flags);
-		if (!error)
-			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
-		ifs->read_bytes_pending -= len;
-		finished = !ifs->read_bytes_pending;
-		spin_unlock_irqrestore(&ifs->state_lock, flags);
-	}
-
-	if (finished)
-		folio_end_read(folio, uptodate);
-}
-
-static void iomap_read_end_io(struct bio *bio)
-{
-	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
-
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
-	bio_put(bio);
-}
-
-struct iomap_readpage_ctx {
-	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
@@ -354,7 +315,6 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	struct folio *folio = ctx->cur_folio;
 	struct iomap_folio_state *ifs;
 	size_t poff, plen;
-	sector_t sector;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -383,36 +343,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		spin_unlock_irq(&ifs->state_lock);
 	}
 
-	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		if (ctx->bio)
-			submit_bio(ctx->bio);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
-		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
-	}
+	iomap_bio_readpage(iomap, pos, ctx, poff, plen, length);
 
 done:
 	/*
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 7fa3114c5d16..bbef4b947633 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -21,6 +21,13 @@ struct iomap_folio_state {
 	unsigned long		state[];
 };
 
+struct iomap_readpage_ctx {
+	struct folio		*cur_folio;
+	bool			cur_folio_in_bio;
+	struct bio		*bio;
+	struct readahead_control *rac;
+};
+
 u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
 u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
@@ -33,9 +40,13 @@ int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
+void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
+		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
+		loff_t length);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
 #define iomap_bio_add_to_ioend(...)		(-ENOSYS)
+#define iomap_bio_readpage(...)		((void)0)
 #endif /* CONFIG_BLOCK */
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


