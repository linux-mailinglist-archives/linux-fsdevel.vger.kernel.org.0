Return-Path: <linux-fsdevel+bounces-60594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1A1B49906
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191DF1BC6B79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723A321437;
	Mon,  8 Sep 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHze/H03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346C320CBD;
	Mon,  8 Sep 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357559; cv=none; b=iw9fBKLa32hgreaYzcLhPma/DnnU1SUrVSOAvO5v/skJDiuI4VWKdJ28HJT0asjLOTfXxsamY5AYtvvNtq98YNkmt4Zrygd7kn1L7LOvei3FRLblX9xfcKXOaFZhbUBpTi9sDu1ZAqeVFses7O0js3sutBJuP82QOg3ermU9teQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357559; c=relaxed/simple;
	bh=BVHH2oEGwhwo7ow3sZ4AdznwXo/wREEoF3kV7H69pU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjXBDDOwFumI2Qs/1IajQFvskxDYL9uEei45T3CAIufe403qEpSQMppSMAgdkUOzyA9TFU9fa5H4zu508ETHM5wp0gjzWplSLXl6gKKZbXTfzHNSNfZikTzGAmXK/KxKvtYP+juVibVNZEQmXjtBU6HCM65UWk/zpikLg/Vmdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHze/H03; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24458272c00so54988085ad.3;
        Mon, 08 Sep 2025 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357557; x=1757962357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5iaIVvSnv6dy53ZNAW4os4OkbWvNlAu4AJs/GGHBY4=;
        b=XHze/H03LpTTOWhnzDyr9KMsKBXFgiGWkkC0WLLgsZaQUsUSBPoM+eWTKYKIVe1slg
         62mCUzmAfN3z79aiiLf6yT3yc4ar4bkYM9YtRNFz7Sb8p34d32G2Z1QG8hL3HokEy6i0
         zk5RcgP7dW1QS9o1amE+4halTLbgLBHL9+Kz8pq9X7LOa2aGwKiq0lpY01crzAT8p0K2
         34SsDRw0ecGz+448ETWzRUxkDOR1XuLk0ya64uGhS7soz3WXzZb0FjMemuc/xmbT6vmw
         YNpSO8j68+8rtqeg3aVVeWlWhQbDmMY6NSwG6AW1+LPSWwhrK8TjSqdxU+ZToXi4Kgeh
         TYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357557; x=1757962357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5iaIVvSnv6dy53ZNAW4os4OkbWvNlAu4AJs/GGHBY4=;
        b=P8IG1VOj3phaBdY7PkMZjNHMjb0fxLMe0D+vewzEO1bx7VbNYRHFq6PttA9lPsTllG
         lTHh3CphVLjheJ2gDLskS8MlfbRJN7VS8kXAYXJWqsEOVb4Jwj20rmllll295l/9Vz0D
         JK3ivox4zixS+b9V/pfm2QvY08BYDn4J/f5cC/nEg2DlLtE4fm2NIMSHHy2NEQsp0NPc
         1Ga39YPy+e1bHsECqRg83ugIBlz587+YNh9uDJGXyB1thXLlOIel+LugFVe8cLcrov2z
         AxWBwneaVl7bWEGPQz/g1/eX6hqs1DgYBHu3NkQgsg1vYBv0eFsoRw2EumozfpFnuv2z
         zLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq6gu+goiHkhejIymuoo4DmiZcaUL7lpoe5/7exzEm8po11v62R1n/+epJBMyttTLs16HZqnzJ6l70@vger.kernel.org, AJvYcCW6Mrwtuf0fnWxJ7r90pSIKG+NVCIlvxwz9gXQRr4CITj4GCQRCNly0d6P3bfjCSCITGOiZHAP4VtXg@vger.kernel.org, AJvYcCWUmMwChJA2A6GhxF1P05Y+KrbaiteyEJ6gmzBAo8jfaFsXt/2bkX/Xd7bV8piJFRCNfnXeA6nbJU9Q74zBcQ==@vger.kernel.org, AJvYcCXngVO2HWrXX5CtMiEkBubMlkQmtYEAhApp0xBBR5RKoqx1EBv0SWwVqD51vdf9K8gsRXp2dxwmFIKx5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfGH3KSC2Jsh87BdcyHcIveyOYeJbd2IbUsR/zWHbghO87Le/
	ggvAhEVrGf10/XYr3cvh3YZ0TlkoRwI+bKXYyVQkqV2F2Liw1X1P1lKx
X-Gm-Gg: ASbGncsshF/PeOfZdariP7JyT8ipgfLxoUo/nz23slOtWTqhuRQyWh9kr2YPFbe2f1B
	Zk0ybVwigtcSchcQ0qdpylW7GTNpVgkxa/BfYRi1Lc8tP/TR5+vSQ63by51nLLxwXvh662R8fDl
	+FVhvR+EQqJukprxwzM/Qf7Gniw7UC4Ch90RvMzm/6qRJWMv752GFKsuefBfjdZqXET8UGEHPYl
	Xt78ANsNyA1LuiHwTYK8KepfXjZm3/gfqWivGCm6XmMHtcDc2iGHkrM3AP/dg3SR6NC2Q29tDDs
	/MGzd3d5mlnianWLfbwQiEQ30Z2HmYxW3qN+rwOInj0tKaGCIO0yppn1lyctfwr4Pzg1d9FJXz1
	02saNiu4HkivgTyGVFfquWZ0CR3/5
X-Google-Smtp-Source: AGHT+IFMnKZdNK9NBwmOCSTQ3eO2IANH00bHS5GPR1akE8ZsHzvjnWsh1OP0ONzV9ZVSjTpODH2aGA==
X-Received: by 2002:a17:902:e801:b0:24b:1589:5046 with SMTP id d9443c01a7336-2516d52d41amr127897625ad.5.1757357556917;
        Mon, 08 Sep 2025 11:52:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-252184a16c2sm66265655ad.38.2025.09.08.11.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:36 -0700 (PDT)
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
Subject: [PATCH v2 13/16] iomap: move read/readahead logic out of CONFIG_BLOCK guard
Date: Mon,  8 Sep 2025 11:51:19 -0700
Message-ID: <20250908185122.3199171-14-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908185122.3199171-1-joannelkoong@gmail.com>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no longer a dependency on CONFIG_BLOCK in the iomap read and
readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
allows non-block-based filesystems to use iomap for reads/readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 151 +++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 75 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f673e03f4ffb..c424e8c157dd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
-#ifdef CONFIG_BLOCK
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
-static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
-{
-	struct bio *bio = ctx->private;
-
-	if (bio)
-		submit_bio(bio);
-
-	return 0;
-}
-
-/**
- * Read in a folio range asynchronously through bios.
- *
- * This should only be used for read/readahead, not for buffered writes.
- * Buffered writes must read in the folio synchronously.
- */
-static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
-{
-	struct folio *folio = ctx->cur_folio;
-	const struct iomap *iomap = &iter->iomap;
-	size_t poff = offset_in_folio(folio, pos);
-	loff_t length = iomap_length(iter);
-	sector_t sector;
-	struct bio *bio = ctx->private;
-
-	iomap_start_folio_read(folio, plen);
-
-	sector = iomap_sector(iomap, pos);
-	if (!bio || bio_end_sector(bio) != sector ||
-	    !bio_add_folio(bio, folio, plen, poff)) {
-		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
-		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
-
-		iomap_submit_read_bio(ctx);
-
-		if (ctx->rac) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
-		/*
-		 * If the bio_alloc fails, try it again for a single page to
-		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_read_folio does.
-		 */
-		if (!bio)
-			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
-		if (ctx->rac)
-			bio->bi_opf |= REQ_RAHEAD;
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(bio, folio, plen, poff);
-		ctx->private = bio;
-	}
-	return 0;
-}
-
-const struct iomap_read_ops iomap_read_bios_ops = {
-	.read_folio_range = iomap_read_folio_range_bio_async,
-	.read_submit = iomap_submit_read_bio,
-};
-EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
-
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
@@ -601,6 +526,82 @@ void iomap_readahead(const struct iomap_ops *ops,
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
+#ifdef CONFIG_BLOCK
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
+static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
+{
+	struct bio *bio = ctx->private;
+
+	if (bio)
+		submit_bio(bio);
+
+	return 0;
+}
+
+/**
+ * Read in a folio range asynchronously through bios.
+ *
+ * This should only be used for read/readahead, not for buffered writes.
+ * Buffered writes must read in the folio synchronously.
+ */
+static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
+{
+	struct folio *folio = ctx->cur_folio;
+	const struct iomap *iomap = &iter->iomap;
+	size_t poff = offset_in_folio(folio, pos);
+	loff_t length = iomap_length(iter);
+	sector_t sector;
+	struct bio *bio = ctx->private;
+
+	iomap_start_folio_read(folio, plen);
+
+	sector = iomap_sector(iomap, pos);
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
+		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
+		gfp_t orig_gfp = gfp;
+		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
+
+		if (bio)
+			submit_bio(bio);
+
+		if (ctx->rac) /* same as readahead_gfp_mask */
+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				     REQ_OP_READ, gfp);
+		/*
+		 * If the bio_alloc fails, try it again for a single page to
+		 * avoid having to deal with partial page reads.  This emulates
+		 * what do_mpage_read_folio does.
+		 */
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
+		if (ctx->rac)
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->private = bio;
+	}
+	return 0;
+}
+
+const struct iomap_read_ops iomap_read_bios_ops = {
+	.read_folio_range = iomap_read_folio_range_bio_async,
+	.read_submit = iomap_submit_read_bio,
+};
+EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
+
 static int iomap_read_folio_range(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
-- 
2.47.3


