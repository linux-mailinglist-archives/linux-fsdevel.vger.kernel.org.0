Return-Path: <linux-fsdevel+bounces-60591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D07B498FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69B644E217F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFD320CC4;
	Mon,  8 Sep 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtw0T+B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08431C583;
	Mon,  8 Sep 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357554; cv=none; b=aD7iAYWYEhDAbzJZAIWo95or94bPEtqODK6T0PRW4w3eAIUfCR0dKiUyFaVogpF7AzSEV6+4WtviMQ+jyYktDLnAHgnfo1jDWHtOcyALoJHsEuaHRS9oFg1yu4UbtMLRl2VvQrfQmCKNwGM3RHjDZegHcuFCAtH34m1rhnNF53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357554; c=relaxed/simple;
	bh=1ijod9ueXQ4SSnlq4mOIvyMyfYnUffGvbM8owg25iAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STetY0ElZEZeimdqUubc9xDvnYC9twXLCFCc3ZBPyMebJVmmiux7iUZregEBMWGngKVwGMK/l2pXCqWPSJzY8tVjwglp7J9I2SxDRcX0LGwXq5Pg5he2IC0JSVfLONhZQvtZi67oozXbW84ZFWwDuyZdrPYSNkqHBNvb4pw0TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtw0T+B1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-251fc032d1fso25167465ad.3;
        Mon, 08 Sep 2025 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357552; x=1757962352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhEE3c+8uQGuRrR/KCqLBGF4v8yEMjYf0S5ji0Yl468=;
        b=jtw0T+B1JfRGWMvaLjVWYCb+sFs4TO/ZIuAXLxuSQNPxaqQM5IqBmY6WpnxVNi+Z5r
         7SdLCnW5ehKloHQOYNmyNcLJEZg3itMGsux5v6qIPbqSf4n5qr5ARCEwjpA7Bz+thA+c
         0iEzTOWo2h35wFwmXyp6QIYMT9sySYRsrKAjPlikrWuSSags/qgdEg485UgXTSgf7Q1W
         94+9dawqcwj6OdrfZNN5r/d3ZcmwMkgQ4EjlddLQYycAUnv4NthK2zA5p0EM3ZkQ758x
         64YJMyRdmh1fAuvbydR2CMCQIjRMhuSRtLkTUNjWH2SqcQB2Zs7kgPYSt0R2E1mZUeJz
         x/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357552; x=1757962352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhEE3c+8uQGuRrR/KCqLBGF4v8yEMjYf0S5ji0Yl468=;
        b=H5CRW3JWC0KP94hqYoeLutSZ3nG4zDjcqI/clxV2zIg0pDl4KkiTpkXPfUmLyUbw0P
         Zk6Ur23dMyRC5RzUY/ts9dzmHtUlTkkShxTVrxWA5ntjCq3nl3TNyZauZRMm3eSqadAh
         ALaJnbhJyM7pCTFog//hurcu2eJlqxMqdjcaY5ZiODw/MXlU2kxrXRGKKhb0tmqqKYYv
         Ih5EYPsEvz0MP9yujTdjy7VkSP1sRVGkHGjYkZTDHWYympYCgLqaqCjl9Yrg2b4ti/Zf
         2YFgVLu03dKrqc0Wk3tj+fJquoUv3rU3LwQ10iyci7DECXvkzKxFrFBsgeDWhifvJchV
         q4kg==
X-Forwarded-Encrypted: i=1; AJvYcCUiA0ZqqZ9O5w1Z//E6tfdjfoJWI89nfhmo4a4xirtUTMhLVg/gfMkcbQ43aq9DWO5gF93SInQKSu0G@vger.kernel.org, AJvYcCVFAm9FAO/hYv/HmhcH0BDNkZ+Ycj7tVdyj8cnhRbNJU/o6bh8dOWWfgic7tK4SdTJfxCVM+Da+Ajzi@vger.kernel.org, AJvYcCW1CcpxQFl0mfFt5iL4+rx9LllwtSA+4NkxhIHcnIPE+xeEiMT6QFKXyM1ajPTBNEnkvfsx6CTmA+czvw==@vger.kernel.org, AJvYcCXQTtPwR9mhQAj/NnAQ82jlLkTxMDoYJgrkvdHMUD+4buwkkJ+iWMQZ1UYWMxMEU0MATXQNBptQSsL2DTjizw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/5kJJIdcRwiRkK+yFaZr4QvFYb2gBPtAyQ2JKn6K63ZYgrk3
	Z+olh5eDD0Ksz0sm1i1gmYVYGdgaL9uhTyz03VJT8VNLKa+eSCM0B4t31EpUUA==
X-Gm-Gg: ASbGncsRooxiBQnsHXQkGTJb79xIDoWEquh6bgE0P9N8GxyhVpZ034pF+a5Y7MeT2N5
	rtcE0pnF1uwhTi8k++va+mEtidQcdcuat7S7fxCVSZ4GRHJnnI4eEBc0KcLctbCSZv2of5MiBz5
	PsgZW4GhGzrhzcrCVnZC86MRTgHE3yyvHsYgy8cF7iVQAdrlINr9a8EXkPJwuNHIiEJLkOQh/bO
	m/j6P8J+KGc+sl0DBmeUoyAvP8tsTRelPeVer0aVQZ3L7OfUJ0RyMrd900ERrGddvoqebjH6q5J
	QBomW7VKvp3gDVYmazaLw6dCuDhnMB8c4IM946yHiAFwhJLlbaGRDT+j3iA+5lhWBmGSMdLGnWI
	W8GXHVJSBuuTJKoyKHESsrN/GodZI
X-Google-Smtp-Source: AGHT+IHj2AZh7WLOlDTRFjKet08p3W+JhKEPAKQcEvWvYOnGDlm2VnfwamI/+unisK2bFixMd+3Omg==
X-Received: by 2002:a17:902:f681:b0:250:74b2:a840 with SMTP id d9443c01a7336-25172483a34mr130706265ad.44.1757357552184;
        Mon, 08 Sep 2025 11:52:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c180f82cbsm166544935ad.100.2025.09.08.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:31 -0700 (PDT)
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
Subject: [PATCH v2 10/16] iomap: make iomap_read_folio_ctx->folio_owned internal
Date: Mon,  8 Sep 2025 11:51:16 -0700
Message-ID: <20250908185122.3199171-11-joannelkoong@gmail.com>
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

struct iomap_read_folio_ctx will be made a public interface when
read/readahead takes in caller-provided callbacks.

To make the interface simpler for end users, keep track of the folio
ownership state internally instead of exposing it in struct
iomap_read_folio_ctx.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 50de09426c96..d38459740180 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -365,12 +365,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	/*
-	 * Is the folio owned by this readpage context, or by some
-	 * external IO helper?  Either way, the owner of the folio is
-	 * responsible for unlocking it when the read completes.
-	 */
-	bool			folio_owned;
 	void			*private;
 	struct readahead_control *rac;
 };
@@ -399,7 +393,6 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	sector_t sector;
 	struct bio *bio = ctx->private;
 
-	ctx->folio_owned = true;
 	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
@@ -432,7 +425,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -465,6 +458,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			*cur_folio_owned = true;
 			iomap_read_folio_range_bio_async(iter, ctx, pos, plen);
 		}
 
@@ -487,16 +481,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio,
+	 * it is responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&cur_folio_owned);
 
 	iomap_submit_read_bio(&ctx);
 
-	if (!ctx.folio_owned)
+	if (!cur_folio_owned)
 		folio_unlock(folio);
 
 	return ret;
@@ -504,12 +504,13 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx,
+		bool *cur_folio_owned)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio && !ctx->folio_owned)
+		if (ctx->cur_folio && !*cur_folio_owned)
 			folio_unlock(ctx->cur_folio);
 		ctx->cur_folio = readahead_folio(ctx->rac);
 		/*
@@ -518,8 +519,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
-		ctx->folio_owned = false;
-		ret = iomap_read_folio_iter(iter, ctx);
+		*cur_folio_owned = false;
+		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
 		if (ret)
 			return ret;
 	}
@@ -552,15 +553,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio,
+	 * it is responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx,
+					&cur_folio_owned);
 
 	iomap_submit_read_bio(&ctx);
 
-	if (ctx.cur_folio && !ctx.folio_owned)
+	if (ctx.cur_folio && !cur_folio_owned)
 		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.47.3


