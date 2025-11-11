Return-Path: <linux-fsdevel+bounces-67980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778A4C4F9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FA2189CDC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A9329E55;
	Tue, 11 Nov 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHxmx0pY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361C329E41
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889923; cv=none; b=tQG0HGvMThNy2T3/nwnLsHBuhK5tMQbFQzJ3w2QTNWzO3zTyfZYDGvqG+xWziVdmy/9Rqi+3MRH3EVXcd9hMWwBBw43mv8pud4FqteT2QHw0gCZK++Rloa0iLMVyCR0L/nEPip8cX65bIWIL5jTMsEPXTJARZvulCt4GD1cmmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889923; c=relaxed/simple;
	bh=gMT/hocM7W2qgazzvVAgao6o+sx1btKfAnUs3inuowo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJxXzR6i/35m1Jg+m6JjuL7jro5ptAtJWIy0TjDw/nbwA020wlKs951LV43n1//sWhI9DN9ewIvLN5qjFeWilIRW7UPMx0BuNJdQRipvaeA4ZXquX6I9lz6ACgLEYOja3PinFuZsqItJ0v5B0EgrEHHArs8ufFJxKZiiGIjKLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHxmx0pY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b4933bc4bbso1166b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889921; x=1763494721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1W3tjaEPosbmkLY9CLbi8C6flb0iko2DpfWC3/V1Wc=;
        b=JHxmx0pYWdTIFgZHfpU68HIXA/TtffIhsEOtIl9l6Yh9Unrb3nAhom545qy/pxGb1q
         tCf4h4hPIfZmF84Tw0atX6ytVhopRhVOfuJK3uCUqTjkInYXia23fndAzAlNwx/tU8PM
         TufYGYulayAC/bJp0sPubHv6XueIRREJgUXZXZIWOKDHczAPCOeMLlHXr2RaAmkbLMqj
         CJZtWm0IcnmiKlR6KFHUx1/VwGL271dq8iiqxbz0SrfM6vxwemVq8KTSfjVElgAjodGg
         /792NFtC3CQY1bS8eO3CZjaXgcT+qH/z1UaHy2aAvhyPEKUQg/TWKiI4kMEaCD2gvgTa
         LbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889921; x=1763494721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1W3tjaEPosbmkLY9CLbi8C6flb0iko2DpfWC3/V1Wc=;
        b=tnzynk01Ned04Lh7cnjpoFa1pD4tKBsWROd5iJsU3y0t4kidB4zWEVvtdatO8o7/74
         p3+e/32dsyG6TetOliU2IG5pCu1f8n65Gn09Fz6K9vaTdLivwcLVSkNDv0r9hywhRCdI
         CD2QaKU02g9O/N1OcEXYyiwkBL7yd3Nqb4zw3VdsYlRwbgGiEscgLmbmP2Qi66sv062H
         zzGordP5D5IBkithxGLJZDvZKtv/RH7sGdZ9JVcaxSRoe6arKxblEUaZqjdID2T6bKee
         BaNwHP+6duYZOpTOj5/XEwfMHVhN8+To2mkXAqGPgt4dBgbIjrn71dU83rwGjYdlx+Yz
         B9+g==
X-Forwarded-Encrypted: i=1; AJvYcCWjDpL6xBU5iKwW5XqXBV/93G6AWE63QlpdB8rCMKGHK07oFyUxsqnbZTChKL25P5qqkJbnT4GS/flZUfxE@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9irPJ8HpEOCSBrPafbMA8xbQADcg+twoaZAHljBF3HL9RGAI
	JsI+8dszEainvkJvyUv4yuaPQ4HAI18/u50whN6TDRrSS6OlaEEMUOa4
X-Gm-Gg: ASbGncu7kYbvwvitUUeoG9NZmqY3/SplaE9L2eGXCQsteZU4qbyc9wfNoW7DVMIANOO
	qBXLAz25Q22SLtMjC2VPELgsLy3a/V0SrkQ85EucrebAxKYMvNZB9gMDs0J5l+OGPErwPl1Fbao
	t9Xp5rzdntRbOuRdhzauAL9IA/BtkIVQJiiyAZnFZ52C8hKvptmNDD59cbhNnOcIGJIKpaL08+V
	RmCRB+d11vftNr+5tIucKcrR0q4tDMulXoDiy5/xxQ0yhARzjfWwwlLZDovbzVD+Rrbyz3v5jVO
	5IBOGYG4ITyOARTZOCthRyNpSL4CRw/2xIhzPBA6Jv5l5jI/oPD2e1jJfK6uA1FBiEC7BdLN8K5
	hPeK/MvHeMv7Zxi4tviN0CFfyDhG1f19Aqjqoan8TA5iemI9sIUOyoan4/JYHBZZzWqFQUJJPw/
	4kGtO3wT9Hqhp4SC8cwKGsC4IQnxk=
X-Google-Smtp-Source: AGHT+IE37le4bXtbwognoPPPOuGj20c6Ssxm2nX51cAHApb0414QPQTkzHRAdujtfoZhsgWm+27OGw==
X-Received: by 2002:a05:6a20:94c8:b0:32d:973b:e02a with SMTP id adf61e73a8af0-3579c78f302mr5813933637.30.1762889921270;
        Tue, 11 Nov 2025 11:38:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf17c00d8esm382893a12.30.2025.11.11.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 1/9] iomap: rename bytes_pending/bytes_accounted to bytes_submitted/bytes_not_submitted
Date: Tue, 11 Nov 2025 11:36:50 -0800
Message-ID: <20251111193658.3495942-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The naming "bytes_pending" and "bytes_accounted" may be confusing and
could be better named. Rename this to "bytes_submitted" and
"bytes_not_submitted" to make it more clear that these are bytes we
passed to the IO helper to read in.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6ae031ac8058..7dcb8bbc9484 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -394,16 +394,16 @@ static void iomap_read_init(struct folio *folio)
  * Else the IO helper will end the read after all submitted ranges have been
  * read.
  */
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
@@ -416,11 +416,11 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 		 * read_bytes_pending but skipped for IO.
 		 * The +1 accounts for the bias we added in iomap_read_init().
 		 */
-		size_t bytes_accounted = folio_size(folio) + 1 -
-				bytes_pending;
+		size_t bytes_not_submitted = folio_size(folio) + 1 -
+				bytes_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending -= bytes_accounted;
+		ifs->read_bytes_pending -= bytes_not_submitted;
 		/*
 		 * If !ifs->read_bytes_pending, this means all pending reads
 		 * by the IO helper have already completed, which means we need
@@ -437,7 +437,7 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
+		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -478,9 +478,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
@@ -504,39 +504,40 @@ void iomap_read_folio(const struct iomap_ops *ops,
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
@@ -568,19 +569,19 @@ void iomap_readahead(const struct iomap_ops *ops,
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


