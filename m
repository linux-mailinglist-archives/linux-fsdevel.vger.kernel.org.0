Return-Path: <linux-fsdevel+bounces-65751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B4C0FDF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39DF74E3668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F617C9E;
	Mon, 27 Oct 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUbyOoz0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F823815D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588932; cv=none; b=rCMQXpyjkP14ugJ6tSe4Gu8plNEfyT6iuILG5ivoF9ADQcG9FnnieOY55Sphap3F57xSdZAEn7tnok/DzpLK4W9ukMkeewC8+YI025nv60qWzprVKTcjuwXUoZYIM2HLpiSmhu9IDAYz7yevNJ+yqfKCBhYigGGoiLS1R5tLvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588932; c=relaxed/simple;
	bh=wwNvjKiYjLRlJUm9NTy0MYsIbiHnusvDrJ3J5xQbm3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIFCDOqr3BscRKwkk5xdvIOvwWXGlNaHGglMy7lz+rNtsBOd86wyL8gTt3hSNUbpvhZW7hZ/sS9DqagJwJwq5aDiSfT4w1SHLgIMbLARF1ymd4v2vj2/PdK36EHBm9Xczw+V6TqUk1tKIjYJDAIwtBFH9r324Ip9Dxm9JO/1HAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUbyOoz0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso5059257a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588930; x=1762193730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H9/vLy5V/pg2ns6KF5LXXWGmex0sjz5Kc/caXUPaxI=;
        b=HUbyOoz0ChOt0Oq6VeWO+fZFbM/CqrZDtxlQrziG95obhxNm4PUxBkbgQpwVxr0uUT
         s8DMGa9xcoSPo30uzyeB+9Y0+w8jNIcyUCG76tokO7vbGL2++k31y6uWLO0gkrVRksad
         jEJMIo4s+7CR59A+hJ4nWNAAdwcte6N26XUXAaIevKa5EnzDaq/bT+9QfSPtSvxOxGNl
         G862AbfdQjh8gI4++DjsBPYo9uSTFV5XSL1M2O5nrOUf8gusWS/8FFSrZ1DRlb/FfUJ+
         k/zmd9VXh4gp/kwG2UAJz8bLKLXaMwIrBJdOXmgHlyjpRUyhjzm2bAMUWlYOZjwkJEw7
         61QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588930; x=1762193730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H9/vLy5V/pg2ns6KF5LXXWGmex0sjz5Kc/caXUPaxI=;
        b=urYAVvmgrkA0cpA91kduuE6nNfQ6aOcSIhUvFx3dwxGrkqTVaWXRJy9S4nhBfwxtYX
         hSFMWOjSSVMmf8vCJg50optE2ZZZ9+67fj1AYRB2XT0NwcbCWi+uY4VoOrDf1Es0QUeJ
         UE3FUoxctEu514gch7TU/z2wshL9560Et8e5cr7ZBTW7WkK0lQ2N4P3Ipeu0LCri2pyW
         wR2IS+yjOSetbzGqXZOl32YBxzMahP9DqUZiIxxIvNEk6bV7xbTXM+vlMXuQtuO1Fbdr
         sST1FFh67ICjtqSS1Vjgu52WHBDY/XBqVxkCdclP7OBAQeACn0QE0mMuxAyvKzgKWlqI
         ivHA==
X-Forwarded-Encrypted: i=1; AJvYcCXTyHqov6IMEnM6X6Lm6JaoT5XqtBCHN9FnEW2MB1ehZAUEErcI8HN6ZShcfE6Kz0oxEwfltZbAm/JX+MJ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9K5NLFtb+vr6PbkExqRtPgp2FWi49P2pvZIQFiF9ArX56sM3
	gEyHN/WWSVoEsR62fUO1D0nvxewdK/v+/oxjThQLmTgvKFXF0/aR/VwV
X-Gm-Gg: ASbGnctmKg0jX/1H2Sjovgr/dGmtqtARUtQI9AsM1OI4yaB7PdNmOY3jYNTkAZ1of9G
	YRUredfw1ZUir/GHLTj6o7PKgKn+azVkZifhJTQYSfCTx34oBRGZ99Sjl8uMKlSkWkpkBgJs67B
	UjNiTvixsAoBuGw1nDhfV86w5r7s5yYPnXXU4Ahmjc+j/66LM8TxcGygxeIL2JjvC8kLA1ST8x6
	Ya45eO0ECN2VjwcV8jiaPMhFxaX/i8xwwDXgLMQSfN7MaQIOUTsbIDah8ZN/0TaA0pV8CtLk0kU
	RlpQelHwReABbbP+IDDHDXrgDFFY4rdZmMAX2tsoI5Abs3TQ5oCnMiPVhDCZb/ruuVkP/qZllDa
	9E6JLCuG1Kuo1XFj5tQlNgXyN5BhNX5Y/pElUVXhnhpQcBOAqeXyxFNgAK7m65xETudFmNwU6AK
	JzWLQEnOK+Y+9PqWaeTGQNWnVqmC7eYROy38Hja7dcQ8AM6coV
X-Google-Smtp-Source: AGHT+IFnOSLfXaNlfLcg8HKN/V3Jw7RrKDuweZLOe3xRxNLP3ZXAr0VNd8hHhKH78Lh8OlzY++oLkw==
X-Received: by 2002:a17:90b:1c04:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-34027a8b6b6mr926564a91.17.1761588930106;
        Mon, 27 Oct 2025 11:15:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81ca93sm9262375a91.19.2025.10.27.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:15:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] iomap: rename bytes_pending/bytes_accounted to bytes_submitted/bytes_not_submitted
Date: Mon, 27 Oct 2025 11:12:44 -0700
Message-ID: <20251027181245.2657535-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027181245.2657535-1-joannelkoong@gmail.com>
References: <20251027181245.2657535-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned by Brian in [1], the naming "bytes_pending" and
"bytes_accounting" may be confusing and could be better named. Rename
this to "bytes_submitted" and "bytes_not_submitted" to make it more
clear that these are bytes we passed to the IO helper to read in.

[1] https://lore.kernel.org/linux-fsdevel/aPuz4Uop66-jRpN-@bfoster/

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72196e5021b1..4c0d66612a67 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -364,16 +364,16 @@ static void iomap_read_init(struct folio *folio)
 	}
 }
 
-static void iomap_read_end(struct folio *folio, size_t bytes_pending)
+static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 {
 	struct iomap_folio_state *ifs;
 
 	/*
-	 * If there are no bytes pending, this means we are responsible for
+	 * If there are no bytes submitted, this means we are responsible for
 	 * unlocking the folio here, since no IO helper has taken ownership of
 	 * it.
 	 */
-	if (!bytes_pending) {
+	if (!bytes_submitted) {
 		folio_unlock(folio);
 		return;
 	}
@@ -381,10 +381,11 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
-		size_t bytes_accounted = folio_size(folio) - bytes_pending;
+		size_t bytes_not_submitted = folio_size(folio) -
+				bytes_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending -= bytes_accounted;
+		ifs->read_bytes_pending -= bytes_not_submitted;
 		/*
 		 * If !ifs->read_bytes_pending, this means all pending reads
 		 * by the IO helper have already completed, which means we need
@@ -401,7 +402,7 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
+		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -442,9 +443,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
-			if (!*bytes_pending)
+			if (!*bytes_submitted)
 				iomap_read_init(folio);
-			*bytes_pending += plen;
+			*bytes_submitted += plen;
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
@@ -468,39 +469,40 @@ void iomap_read_folio(const struct iomap_ops *ops,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	size_t bytes_pending = 0;
+	size_t bytes_submitted = 0;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, ctx, &bytes_pending);
+		iter.status = iomap_read_folio_iter(&iter, ctx,
+				&bytes_submitted);
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	iomap_read_end(folio, bytes_pending);
+	iomap_read_end(folio, bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_pending)
+		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_submitted)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			iomap_read_end(ctx->cur_folio, *cur_bytes_pending);
+			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
-			*cur_bytes_pending = 0;
+			*cur_bytes_submitted = 0;
 		}
-		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_pending);
+		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_submitted);
 		if (ret)
 			return ret;
 	}
@@ -532,19 +534,19 @@ void iomap_readahead(const struct iomap_ops *ops,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	size_t cur_bytes_pending;
+	size_t cur_bytes_submitted;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, ctx,
-					&cur_bytes_pending);
+					&cur_bytes_submitted);
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
 	if (ctx->cur_folio)
-		iomap_read_end(ctx->cur_folio, cur_bytes_pending);
+		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


