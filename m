Return-Path: <linux-fsdevel+bounces-61846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6FB7EBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AF65810BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D52F3604;
	Tue, 16 Sep 2025 23:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzxHvt25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E12D3759
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066640; cv=none; b=DlQ8yEfXo6bbJ2bfj3O+UpgDQXvMhKkjbur8poDefO35Giquup6g8o/WQtSbyt2YO0kcShjUcMUmcGgnk8pGe7X0yvp3M0wZmsEHHIREe6uFlBbDEKwrRNmAHf2Q/UZKdbN1u/JCewF6QYmyurCKpKace1jWRqEoUkRsYc+AO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066640; c=relaxed/simple;
	bh=eIOFnuBbEEhNrCRJgPMN/EYiLsFJzBzjn8Hty6/2sSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDkFeu8Pxmk6ci+x61N62sFKT4PQaCKtibBsQCSxQzCHLFW+a6bKAnpedJU7YzPWkDu7iZAsDx6H5MuSxxn2QZ/cawUZngqtwjqMDXUiJ3MD31qp4gWogOKNnuw+X1whfSDyEJRkhsasxSoaxVzKGBL20Z8ehU4rHWuBYJ7cXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzxHvt25; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7761b392d50so5402934b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066638; x=1758671438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTOBSsCSO8daJuxMquSbd6R0XZgS18qgaXRjlxCtvSo=;
        b=bzxHvt25GSYTgODOFss1tC6Clyeti7GP4iIcle4aIwjSFBvbmvcMgBstuNl9n446VT
         EUgvApW4dC90mbgT5/swXD58lB+ClOiaCzbEMaKeeERP6ZquhIJPYuu5huOgHTMySiDA
         Cq/ulDpCdo4Eafh2ufz+KlTh7MgRelK4SLryGOvHXQyhJXd/kqGYKc8iZas8S/EgUqEv
         ItROCONN7QS/y0qd7ltkH42zPV+ps63cnjAbitcysd+tvOKXjZ8CejyLrjvu4evPinfE
         6zvts9DTt1zsVjCgJM1I0J1wtNPeL2mufOdZcySXTCLplRvdgACJxtoL/c7bfxIpMFS6
         u0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066638; x=1758671438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTOBSsCSO8daJuxMquSbd6R0XZgS18qgaXRjlxCtvSo=;
        b=PHX+SD/+a3jZ6ekidJxCZC1M6pfzh8G3EM2nW9RPlzAaU69p6AtQsvOAAB7kY+L8Wx
         WwVOzcjGZ8ruzCgEkPoI7fLUPa9SNO1t6/1IoEDPs4avTv7ANJeiy8P/SWyc+QCK+5ET
         0fwlpTSkT5A7TOrZbhaofMWHg+CJlQW2cQfDxZvzCQwrfCnja8UFm80ycgyT02vSDxQx
         0gxDb8WoZvquncsKYJfYXJfPGridOfRAdBmp9wnR9WxsIATSlaxeDk8OryOhrPKd9DXf
         WyJKRur66hV3yDYEt1BXSh4qFOCj9sSSg2YgOCOQdmE53ecNbVKf+4Xhblnb5LmftqeU
         DIIw==
X-Forwarded-Encrypted: i=1; AJvYcCVbytDiCbQZ/bxMZj80aDkJOxoi4UXmI5FcKIc+a1Pyb/gIIYxOyeexMCxRH3eyQM7WJ5ytsur0QVCp2XD6@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLBFQFOc0LVfTeKmNMzVNBy1MPfaQ07rm/5OMpIfJAx79kw9b
	PpV0PFZAEY+04SDtdUkqsLIPoDevNdxPNdYkWxGm56GaagSodUzPNIWY
X-Gm-Gg: ASbGncuWAScqt6xCcg2fNVAv35T7doIyMZS1rQl+B71STQ4frGjkMURanYPpVj8mL5L
	0zPLNqE0SWuHStjM5YFXsmJMrDBY9Tga/ffm5akvuedxiuyogJWYF8xFm99Snu2gSrKsyIme8e+
	FYIJu2J2MDaei62oTGGC+/hJgqXp3d/CsLHUI5uKORWa03xTirr619mCJoj+BdKStAFxQU5PyTO
	CimTBYwYBDNWZSUTHkL2rOLI2siMnInlU1bBcQGvl6VsIYd5041kqoy2itICtusIiHcGr7zxQxM
	jyBI7Xx8nceK0FUwa1KsOCAs3zDzeKxOcOb6FgWvEXJ0G1Lktv9tFda3CX6wQ4SKfHR0IGEYqHg
	UWdei/DfEE2NQ4D1EosShYahyOITtuZt0GF9hAfecKmOWR0X4BQ==
X-Google-Smtp-Source: AGHT+IECDExDzeNFXpW8LF+8Eh4/U2VcB9ARfSR+udYUrCEyTsOh9fUUukMEN4AkshjPHgZP49IV8g==
X-Received: by 2002:a05:6a20:244d:b0:262:4378:9dd5 with SMTP id adf61e73a8af0-27aaf1ce777mr50260637.34.1758066637658;
        Tue, 16 Sep 2025 16:50:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b5568a82sm11608169a12.34.2025.09.16.16.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:37 -0700 (PDT)
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
Subject: [PATCH v3 07/15] iomap: track read/readahead folio ownership internally
Date: Tue, 16 Sep 2025 16:44:17 -0700
Message-ID: <20250916234425.1274735-8-joannelkoong@gmail.com>
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

The purpose of "struct iomap_read_folio_ctx->cur_folio_in_bio" is to
track folio ownership to know who is responsible for unlocking it.
Rename "cur_folio_in_bio" to "cur_folio_owned" to better reflect this
purpose and so that this can be generically used later on by filesystems
that are not block-based.

Since "struct iomap_read_folio_ctx" will be made a public interface
later on when read/readahead takes in caller-provided callbacks, track
the folio ownership state internally instead of exposing it in "struct
iomap_read_folio_ctx" to make the interface simpler for end users.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c5a631848b7..587bbdbd24bc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -352,7 +352,6 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
@@ -376,7 +375,6 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	sector_t sector;
 	struct bio *bio = ctx->read_ctx;
 
-	ctx->cur_folio_in_bio = true;
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
@@ -413,7 +411,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -450,6 +448,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
+			*cur_folio_owned = true;
 			iomap_bio_read_folio_range(iter, ctx, pos, plen);
 		}
 
@@ -472,16 +471,22 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio, it is
+	 * responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx,
+				&cur_folio_owned);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (!ctx.cur_folio_in_bio)
+	if (!cur_folio_owned)
 		folio_unlock(folio);
 
 	/*
@@ -494,12 +499,13 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx,
+		bool *cur_folio_owned)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio && !ctx->cur_folio_in_bio)
+		if (ctx->cur_folio && !*cur_folio_owned)
 			folio_unlock(ctx->cur_folio);
 		ctx->cur_folio = readahead_folio(ctx->rac);
 		/*
@@ -508,8 +514,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
-		ctx->cur_folio_in_bio = false;
-		ret = iomap_read_folio_iter(iter, ctx);
+		*cur_folio_owned = false;
+		ret = iomap_read_folio_iter(iter, ctx, cur_folio_owned);
 		if (ret)
 			return ret;
 	}
@@ -542,15 +548,21 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
+	/*
+	 * If an external IO helper takes ownership of the folio, it is
+	 * responsible for unlocking it when the read completes.
+	 */
+	bool cur_folio_owned = false;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.status = iomap_readahead_iter(&iter, &ctx);
+		iter.status = iomap_readahead_iter(&iter, &ctx,
+					&cur_folio_owned);
 
 	iomap_bio_submit_read(&ctx);
 
-	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+	if (ctx.cur_folio && !cur_folio_owned)
 		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.47.3


