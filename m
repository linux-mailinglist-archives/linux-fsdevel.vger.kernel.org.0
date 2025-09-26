Return-Path: <linux-fsdevel+bounces-62828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3498BA2129
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAC062820B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2011C32FF;
	Fri, 26 Sep 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVhoifj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70895170A11
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846578; cv=none; b=dSFos3BQ4xc9+Gh1fp5IJxzS/Xrw17AclbdRlrBENuTx8oZITNPmcG5esIJr2c+TZAVG6JYmCn9JJyJ8H5lXaYnJM85X2d3LfGoarYTmcec9v9RDa2CVEZxeL5C5ElINq5EPLxcyoyXl2i2GaQpjzt+1x6PI3x51dqdZRG46XBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846578; c=relaxed/simple;
	bh=vIAY62bPonaFy7vGVNyvqO/mtaIvl07zVQLoOf2yQSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/4qGpcUsP/IyFwGe8aQly/Mp5gNFZJPWPeoATCGE1fXmEgkrbVKscM/w+EWPqU5K7lB7Wmbueqkh5TtEkxVajmDmX3MpwQXk7MmmGpQJ20be/LvIJl0jzhGXwdxvtacLWx6Myrk3Syr2n3/JuIc1yoyAcbcDP5+6DQY8GY7pxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVhoifj2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so2032095a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846575; x=1759451375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=BVhoifj2QvJEPBhUBsx+Z/o3VunIVABUfPNrHrFKDlFoLc6El5GjeeLWu75NgtOdhP
         FdlRRmBGPnDDFlSTJep2+2lp42UF24GPmp4qjD9j1LUwF3+NxHq8qEPkdmczwxblupvp
         weDbeymXApAW2snpoYCwtQv/h10r0aledVY/tRGZX5u/DOHUvYPGaE3NnFplZ9kUnJWV
         Hj3L8zNuFsYvCc93/wAbv/rGgGzJiDIitzQLQ0Obg3R0fTGU7zohowhw5PUxd2v6aTtV
         aA4Gs0DbD6EY412y+71v0ADSttQqq+4engj7a/79jit7YKZzAKKaR2JJTwKNqFCrTIxW
         bVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846575; x=1759451375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=tQVqUH7rZsZ7E88YhCIrebpyIY90iR5nmtd6GB2TxZEUXLRbbdRRmun4IEgEhPUP2x
         Nm3JnMehFexqQnJUSneA4JuHfnrDispjS32LkrdB1Tmf1Dk7TaPGSBmsjl1wr7elpl/n
         Xc2v9tNA3pQ7preVadxM6Y5GxLYTkLoeZytCgpKb1zharFvng1nEtrHr7bYSQixjuw48
         6jZ1w2L13uCfGdYkTSxfUrUaNGdKOnrGpS6kByBu7psVDjEx3g9tQNZPWvSgbnnui2Nu
         KZR0J/XahDFiK7kf8uCY0AYzJXAWryArl9aAyvtO1XfQuBHljNHqsEzBmizhoYhr9PaL
         gTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKluWTLXkgvqmm+CVTeYacdci0JlR0idAP/ldaCjCkRFzW8qf+WsRC8bBgPP12P+twbXYEeXXeZpq3If9P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8j2Rc0NQSyXcppbyYUVyAbbcmPpyZiStKuLUKq+2+rPrGxyqp
	UUGNFzFKl3dihrM+IW2RVYU3TlW8ejjoxH5WBRe0mr+5GEkiTVGNb3Wr
X-Gm-Gg: ASbGncv2dwSHRwsuOKLTNvWOL57Fs5KBttJqjpx3e7eMrsR4YD6GLQQZX889lZ6YMjZ
	ZHpz33b2ZZ5LO9Gi/je5B+KDwvDWVDZPKXjRJ8M9An6tMszxYXDV2qrkmtzsqI/7OEyJLENB4N3
	ov+i83I4iwyxDgpfDEAhrbCEfD3/6b9FYdWmiDJWyoaJyM2vwOPxaVuVW9EeC3OyRZP2Mip3lkR
	/m1UuVp7Z1SCdB3dJN7gCewO91xgAPXClS7J8AAgQJFNtlRjzK8UVgSH6uFlQSmLd/+b668x3xI
	GHaOIZtjJBsOkCWKyeoF1Z0ksxhf8+go9/N6y1KLr8P73rvx+V0Ly9AVM+CJl5b/9wac/VoDyYj
	i+bI7BLANmM9TNplYrjbaZp9H6NLoFQV//5SrmUIW8hnmlxd0TA==
X-Google-Smtp-Source: AGHT+IFjaZEdrafbvd2zyiTkt6VCFBB0ZO2mwZEYv3mz1oaOZduHe0Q3Y+mjwZVDt2v6FhCaKr5ObQ==
X-Received: by 2002:a17:90b:4ac2:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-3342a3070d5mr5430211a91.34.1758846574661;
        Thu, 25 Sep 2025 17:29:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a339dsm3185031a12.40.2025.09.25.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/14] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Thu, 25 Sep 2025 17:26:01 -0700
Message-ID: <20250926002609.1302233-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 23601373573e..09e65771a947 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -360,14 +360,14 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
+struct iomap_read_folio_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
-static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+static void iomap_bio_submit_read(struct iomap_read_folio_ctx *ctx)
 {
 	struct bio *bio = ctx->read_ctx;
 
@@ -376,7 +376,7 @@ static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 }
 
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -423,7 +423,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -479,7 +479,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -504,7 +504,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
 	int ret;
 
@@ -551,7 +551,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_read_folio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3


