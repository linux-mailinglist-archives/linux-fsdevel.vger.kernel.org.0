Return-Path: <linux-fsdevel+bounces-59682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E8B3C5C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEEE87A2D05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5B313E27;
	Fri, 29 Aug 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlCvnbgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0E27467D;
	Fri, 29 Aug 2025 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511900; cv=none; b=iH+qJF8yHw3hTroid6aTrK70VsuWMyZmYrfw7/wktsbMF3/LCq2ITM5NeiMWTBawjh/LyVGbL7qUw1jCHMONh8nvzir1zFzbz1jps3V8TGTcGxDIpqEBlquFTH4hLH+eVHRCGGR82e7Jq7fLPxOOY9PPAarVqEtn5mgyqxahRek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511900; c=relaxed/simple;
	bh=DdzokSLS5RsQ0wkYGfvlcczKndV1tvvrcwdyNubgLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIXhbtzofKYe3184Qk3580z4OElabN65GWJgL0nZ4Y328NCgohVHhCXpir+NZd4h2jswEBmjv9QeiDFNZfPiHfWd81mi30ZxkHBguU1WxDwsAN26flrmBLpSUCKENGVArCTQGwv76aU8kvWLyrPwjuHQawXJeqWtMtc4xFhaAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlCvnbgo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c5467617dso2398232a12.1;
        Fri, 29 Aug 2025 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511898; x=1757116698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roYKiz/VsUAVzG8EVIzibfj8H/DAHoimoxcgBeVScIE=;
        b=hlCvnbgo5Jf7WjiIGLpz1hJFXTY663c5UAv/O0wOkhwDEZX5Qn6orHEr5UsI06Djoi
         vc20ZgHt4Q90UEkuHVcRzvNaaVuDkM2vZPVbTJ7iZgatfrQgrVkXiNYNvkr1BFBX6rpl
         wBEUANPRL/zfEAd1MkkltUJf3xLVa5Pg4tPldi4jMe1Ig/KeiJaXEm+odhRlKgOYRo7n
         dsxCTp4XfJlEV3yNGhaycecxpCk3+cZjxf81a6xBqJDslMc2cFHIyfBm5a8aNzO+ES9Y
         KcsCvrm+sPhUlCSFTpHmooRe4qjUBXS6DNOndMV25w5BXVevUr2NjlJdnQvnMPJrL127
         W6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511898; x=1757116698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roYKiz/VsUAVzG8EVIzibfj8H/DAHoimoxcgBeVScIE=;
        b=JmgVE7qVgC3WbJlAfFr9Sf9BBhK9Wmix46lIeC4GxvCavWwT/lPTuV5ZYHlhgyXVqt
         +/ht4h2gM5okQ1+l8NIAC3xdwBI4LQpIVqQojBCX5uIC7/Qk6eEOaiZrr1Nj0hGaqGKR
         Q3Dcn9SSiMvC+SxunLHMkohGlg+1MGFTptmoKDqG4hMEbkmuWrJwfD3+Q2w+Nr0lYgua
         oIV7hP68fKOUEDyouNAUD1wsnyDH/JEK5FxwaR1Vb6pEYBHkc2rSe1WotwmKH8QKtTAl
         2us+ADh8P0VbCa0t9DRMLCRd8l60B0fgCCl9yEiDow3/QGrcQOTdj3z0yr8X+3H8TRqj
         AO6g==
X-Forwarded-Encrypted: i=1; AJvYcCUbABUzKiNkUhDk+c0XriLhDqhJHNuyQT2fF23zOyzxGNRmxHFP9cMJtJ1TYywOFMw9P/2V22Cz/cQ+ZZI8Zw==@vger.kernel.org, AJvYcCWHFxyZZPsoKyKSHQaMOMguS0PPPLw88rEXRxenODp2tuza0vQIiuqH+BfxonCT9VFnAbZNnyXYGzg=@vger.kernel.org, AJvYcCXFv0E9x2aHrvkCFtHgDPEzZqOs6bi3zKu4XHGwgFLbktvHp+d8xVDngzAMQznnTVsFdVJvVEhqTHSG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1QxnxZM6ROCAvPQs1e7YE7Ye0j3uDM2fGazUxmuSJZwJYtDOC
	Xe76GHHnqRbBA6vhDsotFCtlhOJW1x9l83xEp1FU7GlFPR7Ijt1orgaz
X-Gm-Gg: ASbGncsXgeWkzm2wfgHwC8sGFTM2FTZZk1Fmv5NgZ9DIe+Xpjpk0Iu8dY/OkmujNGua
	NUjs+FFEVynvjn6auaPWxonHyGm0YiIFaNPHVcJD31NK9UvfZr4mFnSgV1Lk4SRFQynA8R8QQi9
	ZomnmV8YSf+v7304fXxkAgHgN2csxZI5/w1qCRspx4YtElbj28jNnOTyH63D7Mup+SZBKRM/UdJ
	Sfm3U/nozJDWU8VMiY8pOg8/xd8IbZNIvY9MGIgJufW0eZLsrXWCG7L3K7PCXLRONuqyQAlCjC5
	FnCGVds3byqHwqB5fqQDDTHxAi/r2ZLMjBrnS/QhraToKSIWeaqYV1tEVe67oexkyVdkXGBtGRd
	JCmwGbX/f5UC46uTdL5VnFrSnOPhm
X-Google-Smtp-Source: AGHT+IFwKwmXgQoTz2Tpwo15cdhAtfbE2TJdDbZjOGCKs5USq2MJJM3BdxdhMy4WUkfTry5EbwzY0A==
X-Received: by 2002:a05:6a20:2588:b0:243:a52d:7a70 with SMTP id adf61e73a8af0-243d6dd55c2mr557709637.3.1756511898272;
        Fri, 29 Aug 2025 16:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d8f66f16sm3920653a91.0.2025.08.29.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 01/16] iomap: move async bio read logic into helper function
Date: Fri, 29 Aug 2025 16:56:12 -0700
Message-ID: <20250829235627.4053234-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() async bio read logic into a separate
helper function. This is needed to make iomap read/readahead more
generically usable, especially for filesystems that do not require
CONFIG_BLOCK.

Rename iomap_read_folio_range() to iomap_read_folio_range_sync() to
diferentiate between the synchronous and asynchronous bio folio read
calls.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..f8bdb2428819 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_read_folio_range_async(const struct iomap_iter *iter,
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
@@ -425,6 +404,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		iomap_read_folio_range_async(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3


