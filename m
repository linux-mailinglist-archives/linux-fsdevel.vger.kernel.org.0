Return-Path: <linux-fsdevel+bounces-60582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46381B498D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0AC44E2181
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B721831D753;
	Mon,  8 Sep 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aloBv/Zc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F431C59E;
	Mon,  8 Sep 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357540; cv=none; b=JiTeqCPwPodQJpr6pFpqwxMt2136PqCLScQ7ar1IJuxb7Xd5f/M0ls4DLEYmeZh+wzFX1fM5ym5MhoFCM4hO9Ld0LmAYDtlXzqm6ZNwwi7gWbVWnNdWmIqH0Iw0RdIN7sjgQbIQZkIjJtKDBVD2IIesdkJ0OU0h5whBptRPRHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357540; c=relaxed/simple;
	bh=mKseg24DgTQpi06pk2MwjDbMG0wYTGbtYibipXYcGB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HibsU5PfZ+ZklWQDtPwCMuVSzd4WSzuq8NJmPa0Ywo9LnL+GCwN3hioudHdXeZ5xWhXfbsfZox/3xyfKYRylYlPohP4r9FvU3DZYWYEO4RkjE2tf0+FTpavVO0Omb0aMb+ERRnBivT9LtYImDPc4h1sQVv9C2/lzV/AgGdLXpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aloBv/Zc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7728815e639so2557464b3a.1;
        Mon, 08 Sep 2025 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357538; x=1757962338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIeVhf/GaWLdHkNpayC1qTsZDGwWA9sTHoMGLVj+54s=;
        b=aloBv/ZcCWaJaiHztUkhvioLkviBSw/SABo9CHBpegAWowZQ0HiRxi6ZdMsqfhRTc6
         EQO8p66lfBf+0V25YJ2i3Wgl3NmWqmHf4oKrJ+chNduE7iLcY+FnEfnQPgGHMpvbFk1r
         Qy5GWFRLQh504GGy8pJY1bx/wErblmwKR7RKEaLQPhJkSgDA9avfO3J2HRwz5Agm70wh
         cFxQyeRNkFqP3ivlajbO20+Ta+dupdBKDazxOYLSIkouhjWbnFunHX0EJkGvVymTYLWu
         pSwVxb+Xzekw0mq24RQMDhyFj9cacesV/lBFqft+gKIQEv2zemLNyoXjWZRBHHhA2J0U
         lkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357538; x=1757962338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIeVhf/GaWLdHkNpayC1qTsZDGwWA9sTHoMGLVj+54s=;
        b=J0pTaGL9fshihrLv7txy3w8NG8SjAViOdQUCo65AscXSqR8DIGl6IKMCL4EU1XsQzK
         Fy08UBNfSGyCM8KTw+49ySkotKbJulAHAEkCQPlW+1L5GIdA8xKf/sEtpWt/e7yWYsep
         Zq6qoHVAw+acVAkwBpy7qUFAwtqVzmJfd7NY8aTfcPsemUAVgColKJ032dZVDgmK+F4d
         wRaUXbbtIZ+qpAlOKEJSRAgzYrXvnwl+oiV1YejIfcXYhQ6jC1HnMSa6TEWkcH1cdhO8
         jV3dYteJlAoH/XO+kctIQOrnroY19QMvI+p4A1tcKTwdWGsxGBZbjjB3hXU544JWF0BU
         4zVw==
X-Forwarded-Encrypted: i=1; AJvYcCUCXFuBZcLpJB+SZy4NBgivQGt5StunmLTJC3213Am+0WkeepMaiTZb1sS0/KvvU+LrcabbLhb1+fz9yQ==@vger.kernel.org, AJvYcCWCBVlzBOnlRT0IbGG1P6jsPOFxq58DX2K00BHDlrsfHtv1FM81/ZHpiVGSrmiM6LyYiVT8Ilw38G+g@vger.kernel.org, AJvYcCWSSZMWC7kM29R0eYR62JjEPdQr6cDL8XUEJbjr5SSfNForfGYh11pGdzRABNQ8H4y/2AWufjveFoSZqu/rzw==@vger.kernel.org, AJvYcCX3EyCeGKcZkaJ6A/vdOdQwT5osBjJFDOuuk/isLm50NWAUz8xfFceqnLpnk/VMAsa9P9gFZhA/TTWQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+If30Wlt+9OInDzPD/9Kay1pZKrhCV1Jf+5dSND+EeedGGmf3
	krK3ifwEM6ou3vqGxGyqnkkNibiCVYzFXbK6QGSYpw8ly7Idp0bEALU4
X-Gm-Gg: ASbGnctR9BBPc9tgUMAkIx7gGrFbW30LEQsg5Xf7j6Wb3WPeuUenhC0NwBBjfqqofrI
	2C1ZhBVfBiiTeN1snZmumaX8cOxTCR1EaPQjIRbI4bZ15UxKAiuc1wTA4f2xRkIPRbUXbacASfP
	RsrdcxwuIPCVRwl9evc/FU995iI7yQ14IayX2OhZwpNOeV4pQPw14GTtZ+jkcLifr40V4gUvkZa
	GzZeqRRHYcWCueBU5Mj/UT6pOWAOaAfs0+nZJxH8gS2927bVGus6PT4JYED7SIhkiueO/X5RnZ3
	A80Jm81Ork4mod6xiq8sN5uLkeTlNfyd9A6JvQiX+khWtSQ/te+1dm2OmjhNwoDPRUrzeK+Oflw
	uSR9srBKAMCt8+KSGHw==
X-Google-Smtp-Source: AGHT+IHIeFc3reqItOkoNY6BMOQV0VjpxZyofFhYsEk3kbis5gUV4G41jZkE1649r+xsPMAzeYbqbA==
X-Received: by 2002:a05:6a20:3d89:b0:246:f1:bec3 with SMTP id adf61e73a8af0-25344415094mr12739543637.42.1757357537850;
        Mon, 08 Sep 2025 11:52:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b617b104csm16042737a91.21.2025.09.08.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:17 -0700 (PDT)
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
Subject: [PATCH v2 01/16] iomap: move async bio read logic into helper function
Date: Mon,  8 Sep 2025 11:51:07 -0700
Message-ID: <20250908185122.3199171-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() async bio read logic into a separate
helper function. This is needed to make iomap read/readahead more
generically usable, especially for filesystems that do not require
CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..13854fb6ad86 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,21 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+/**
+ * Read in a folio range asynchronously through bios.
+ *
+ * This should only be used for read/readahead, not for buffered writes.
+ * Buffered writes must read in the folio synchronously.
+ */
+static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, &length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -425,6 +410,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, &length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
-- 
2.47.3


