Return-Path: <linux-fsdevel+bounces-62444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40FB93B50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1B18844C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E21E501C;
	Tue, 23 Sep 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEWacAz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBA1E98E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587643; cv=none; b=NUw7IpZtOXG6SmAjAGP/wkjDbxp5nrJJJV72UXOHk/Xj6qCZPH4u1+4PUdWsO7O6TGQdS4Z6+HlFd+Sdd2ZPtTMGTk9fdR3Rt/BblezQ6BTa1pYlWYoNQ7qudolXlMkIaoqfwEF1ndugJhvuZWOSwZmffKjCaqTbGLFhfpDOzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587643; c=relaxed/simple;
	bh=vIAY62bPonaFy7vGVNyvqO/mtaIvl07zVQLoOf2yQSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP0p616GcYJsfx85HuMp3gyWcRW3YhMaiCGBeKjE4v1DUjkzA8LxwAj43JYBDlQKnSPjsDqSwTRfieiSv3Ox1W/z/gEk/5rYWyJUBLoJsFQti+sp/8ZvtTo6c4fI4UMch6Mt9ottc3qSvmZfG9UbP6zyEiVsnukFufxL5Pto268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEWacAz+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5000489b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587641; x=1759192441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=FEWacAz+TzaAoR23MprISMWa/YYtoB6UqG0ltNJeol5EJy7I57pGWkQG2OFd29a28T
         pc+BmZFhySuus3qx2yfkC80uitS4LInaTzLJMoFYOZ/nU6ifHdV5J2cvoFO0Io0SFxnR
         foh0r5YpOzP9m3TcefmaPzZ1ZCVlesMjUvGNLxr/OFsVxdum5v87N8PguQSH/6lsnUPZ
         18krXn13eESq726MmDIrkCEtoKDpInztdYDpySR9tiBZUOImGEy9RSmT+KRim7GVPwtA
         Jkj1Do+gZFyujBrJB1iF84Ftw21RpXHnoTAVj7ZOysCpCYDGDEgbFfYUIrtg+Xd3wIFC
         yHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587641; x=1759192441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5+CvxTz0as+KK3qYoCdGCPxNBywOK1cIFwpk87cxKA=;
        b=RfwCHhl+6SmRjaWsTtoLCCLmzbWbldRjVrtAn4SmwfQJxr9MKVnFW7fquvcu6EhVKu
         mNKnKZnSsIz8cZz/xr4d3oAst+/rb+Ic6Mm2si25gIFgzRtf0/L2ibU3LyGVDygVvrmm
         4Rke+I4oRITCDDIP1LJm8yqLyeVmMsh/inglxno8PRrO1qtH8wsoC3SsNQybvHejVF4d
         vqztaS1sKy2o5OhYhD0IJQ2PSiz0xG5xU2cRFGLdB3UknMPn7hEMPpQPtUYiXjWlZej+
         b6XUGV1xxJZA/3ENOCKnuF+upE64vjj5l2w5zwRubRiKIfKlcGIUmD1l+CJdhg2bWPlC
         mRmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3P347AuoQ+fbsLmcPzrzhjvWqY90r6fqFSTT9aDdnY+JBBJ8wXIA9yDA7GdDuTkTuGjyAbHpfGG6EwkOk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyom5q2PPVAflWuaOwFeh4nIUO0YHq47Gh0E5M3UnwAB+eaeUfR
	biM86Ji2mozmPJc1zEb5zmm5djwjqT+ok0PIuAuPqH4nAidpk9d/Q9l5JhbKiQ==
X-Gm-Gg: ASbGncuwg6meErTA3DEIewuQJ9YjGp4WIGYYR79nErXWpEkshwDFw9F8pzqOpkdBwco
	tjuZrDxYs211rlxYN+08TMnJopoRlL9yEe719KFt2VJ5Jns/1agFkC4vKqSjzGKEbVC0D2bBOW/
	Top0+ssNSRb6OJzPi7xUqM98yE1blYp82eFNBIkZ7mAyuVjV8VGYXyF4YABmXHYYQe+YHTJ2Wv3
	W+FREDYsWzkyyX0C8kL+BTgQeG38Xh8UZf702b4TZV6KGGZeWIDh43CH+LFgc4YKl6c120dJXn1
	oniOMdjViW8v3KYPM9A/1a+gb4rSwh6tCyEjrp/mGNGw7Hj8KE3eZBbSjvQjXlmVPwEkST5YXTD
	DNyrLB3vOAx4Y/zhANnO1KLwAUm12cVZM8Z67eMqz2yZ/rMyf
X-Google-Smtp-Source: AGHT+IF5uyA51QP5B/v0aEpZwjC0gnuJm8CE+r/VEqv2kg+QAhCE4gI4DiBuU/4bl7VHU9GQ+zierw==
X-Received: by 2002:a17:902:f70b:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-27cc5431730mr8985485ad.38.1758587641125;
        Mon, 22 Sep 2025 17:34:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm144543225ad.64.2025.09.22.17.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 06/15] iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
Date: Mon, 22 Sep 2025 17:23:44 -0700
Message-ID: <20250923002353.2961514-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
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


