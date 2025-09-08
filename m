Return-Path: <linux-fsdevel+bounces-60589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDBB498F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE8324E116B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03E320CA6;
	Mon,  8 Sep 2025 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+5WmZQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B231CA43;
	Mon,  8 Sep 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357551; cv=none; b=ZxhaGU6s5Z2JFI+r76YQfT+58vZCq71JSv/rme7iIra0auyHygvj7Ic/lGWGUuERm+NBoP+wn7hfKlFHK9tUMU9o9MW9yPrwkG6uBcJcgH0cdBvNQne7/xE2nriPoFd4NNiyykIyP/PoG+HWiJNwjSNR5yndN+JHyfWQeyfpFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357551; c=relaxed/simple;
	bh=6XccISsz+ntFq8fevte/A5CjKeD+krT4OR6S/88mrlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6NO75W5N/KzWGYhff/GY6VgspDADk1x9I/kOyVWlahX1VXRlHsCliqj7ypeTZx7xFFmzBWGJyXw/67G8onNVr2G5om6XPKRkPJfKBd1wAkS71kutFhTbORWB9/OY5MvrQSWPnMw7sdzPG0FvUqslwNOL2nh/jt+hNA9/ckUBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+5WmZQx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445826fd9dso56844135ad.3;
        Mon, 08 Sep 2025 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357549; x=1757962349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOMiqM1QeSbN4ac7J913ToJx9WAvKVveBeJyEZuKF2U=;
        b=h+5WmZQxUCc5CUCmVcJFvt3w1XYOVR9u4v6XS5HygdSsrZgkEkVG2CW1jZNp46jQIY
         pWHPaJ9uV4JSiFSh+Pc+AxY9HWWGsZYSbqNKcF9ZLDQiH5U+w7sUTQIAn0Xi6QIScq8W
         oSk3OZA3MTQKdF/Ew8qQdhZTELlw9Mbt6eBLZoeuwGeS3qJsH0VhsMaNbcUcfQrNRu9a
         w1/jvrWZuSyonAxIyjg3b8PCgeg4Pb6bAqxGYnlAEAjiQA/kGtlL93XXA9KTjCUvPiTC
         RQQQGIRt1VZX8xNM+lr0Ef+1mdHlLUbVZ6dOhXR3/osbziMSCyEqFEz3ncHwjgDz+fY8
         TnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357549; x=1757962349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOMiqM1QeSbN4ac7J913ToJx9WAvKVveBeJyEZuKF2U=;
        b=a6eVAZAOH9DO0903meRBYziYkuP6nIYVADlsrEbp1aEz3QiJAhgygBnS0OWh6QW9zP
         m60oJ4SWrmHWXMZDITyXfW+n6DUfi0zqhwtSsynLqWkoL1BMloFF0pgbbjU2CI6iyrJ9
         JSZBNT3hE0DQk0An/pATsdSw7tcpSBm26dbzx7n5wHs7WfQRF/10gBbeT7DHM9Yoe81u
         txYgtdP8+O3hUdx6/T9tjFzbsWayDqzdQgdrOuqCkHXnTLR1KpR7UnFTt/HNXJNRGxDn
         kkDO+p6kY5Erdx778/FTa3z/hZ6E3lqOuXpf0xykOxcyBPt4XyUq3/4m0ElF8PfXfnhJ
         rLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkB8F8ulgpFD3RfqASTqV7gLT10BP+GmPqeKVODfd/oqUFmt6GD6n4Td6Jfi67u1r9a2hKejl/EfnJ@vger.kernel.org, AJvYcCWXFvmCELpslM8UPoP3iW+ptE5qW8eYsRHf6RaH9/P1RoMD3V2oymGZ0stPOnIH2jesx/1JDy8MLCGmWw==@vger.kernel.org, AJvYcCXW7clysYH+b9pmTb3Fb6SYk/bJ7I3HaDAc96LRmpB6g713qUkV7QvmaNlURzw+RgZQVssQd8wFIRbsBCGEbQ==@vger.kernel.org, AJvYcCXcS5fttdKrDe0Th2TO7gpZoYIK3hD6Ucx63l+PQLTUW1qn6MJkm46E1Lf5eQPP2ydaIJe0Lo/lwkB/@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWppC+MjeAVAbUwBinNhDjHN5zv5yFmUOKb7F7kT9Ebdx90Gv
	POSysVseUrpit/XbUx/I//IF+vZ4m2Tz3tBX371c9vZ2GP4v5MfMdB24
X-Gm-Gg: ASbGncsxQ9rESTNPW07VPSa1tYSG88KKol6JMqMM60JBqaxYK+9Na3EKgZqL2RW0bmH
	EwMkQ3xrDpL0AHaz0FJ/qnb9kVD97fI2VJMvdCxt+AwfBMijikqTbVme7XJt7d9dYL/0jhwiFOy
	dWQAz6tN3Ssetp7wnp/fgHBGmWGE8dWlIHyhySFRq+hzYygldb9II47O2DOlfhVD0IUuncXujYj
	oYguObPOdfneGi5Yq9qfLNXx9cugdYYUD0AMHAcPO4si9nclMDDbhz7PutjQ/pwqAxyPW8nApS2
	H5fTGznhh+mWxlw9KwFREL1iD++iQjDqt/soVASv+NKSEFUu3ZSTirXKSF43n3MbvfI4EvZpbiI
	ZqKOzbJvwTKpG3D2hBw==
X-Google-Smtp-Source: AGHT+IHi1MFyQZT07vphTAJQQWiqcbxVXuRnoTuCifv2FfLggyElxludiM3V7rni+FTWE8DVZOm1MQ==
X-Received: by 2002:a17:903:1c2:b0:249:1213:6725 with SMTP id d9443c01a7336-251753d88d0mr123342085ad.50.1757357548763;
        Mon, 08 Sep 2025 11:52:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc56ec1sm117436505ad.59.2025.09.08.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:28 -0700 (PDT)
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
Subject: [PATCH v2 08/16] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Mon,  8 Sep 2025 11:51:14 -0700
Message-ID: <20250908185122.3199171-9-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c376a793e4c5..008042108c68 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -350,7 +350,7 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	/*
 	 * Is the folio owned by this readpage context, or by some
@@ -362,7 +362,7 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
+static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->private;
 
@@ -377,7 +377,7 @@ static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
  * Buffered writes must read in the folio synchronously.
  */
 static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -424,7 +424,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -476,7 +476,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -496,7 +496,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -541,7 +541,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3


