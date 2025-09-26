Return-Path: <linux-fsdevel+bounces-62823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADDBA20E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4611B26C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C52155C97;
	Fri, 26 Sep 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8S+lD3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA968635C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846567; cv=none; b=NwGUMMlu1fpZJSqFTb+f8pGIrdSfjeufi9kmOx85QDhW0wPPJ2B2keqiaixnlndfpofV3ThR/hI7DUoBR74Mn0RtUAKv6qgROBkZ+1/9vZEX/U3N82dX3NAchY7qVA7XF2w2TykkEQO220IPUd4fd8K1RwuqeYYd/qoyz1J/4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846567; c=relaxed/simple;
	bh=CSiGtKrWb8zqpNUe8yL7Pevqy9qFJhFmaY58ZJGrYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC7h6HiqEcajR4oEL3YTuMsH/LThhk1RzDcTAzBiZM0TXgbrElBZo/0YVvvNzmJzi0q56RmbGFa88LQ8VNTknclGpofFQ+6cTuL1V1Dmf1G5QKP17ZZlvVOQK47edGGeC/FqkIrG3x4YYz6bFuMO4Z8vqeB/kJqBfZgSmT8Er/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8S+lD3d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26a0a694ea8so14807695ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846565; x=1759451365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=B8S+lD3dhzSUP09O2UevSQy9dxglRsq0XlUBNrJyWk0RM0pteAxqO1UD0d2AEP+VaC
         e6QMlr5A/P+I/SOyJ8sqe/VCx26ZyWVD/SL2Nf6PJxEnxPjHGYzBQMjam8iACnsTuySJ
         hWomCj3ltBaXIPEmjy9IhOcFnokdwu5Ezhw1D21k5q3Iu5e4vhuDx51euf27pUIyPrrB
         XuYTfphRdGXR8uoV9JUbC9M/IFNiNTWjsGDm6LXLRx5qzN6ny25XxgkMGHuIgdmoX0JH
         cpe77a2KeacbEtglivcxOsN8OWGf4E+otT0Vg7uuuptPpEKUEAENvAkHMXUC4yqeeXOX
         CTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846565; x=1759451365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=cAExdGOjdmTl+s0q7j5WqhwXrUG5pnqV/4lMleAaygBsB11/OaJSxl5Mj9aK+cAcWx
         1eV9stifUTfhrPNLCTZ1W+2WSOuylop3pL13b2uI9/yYG1k64RL/7TFW69zV4zhGtBxY
         2nIHWVYu0ljV5T15xtJpl9AMTG6Z9gIcHk6Qothcx4mILhW8ouQ0skDNJUG5OJJ3eZX9
         0ct/VLH3vg9YAy+53jqpsUoY3BqOA+bfYmkd+/0TcJedy6TZ9ZnO9LEW2GTDOtwBU6j7
         NN2lA1Y6Ugb+IiMloJO2aH+DFb8B9My18ZQ+UdmsUXMXvrfSuVBWDg7j2j7pURv2LwFF
         paQg==
X-Forwarded-Encrypted: i=1; AJvYcCU3TsQPFrSmZvbTaj1uq7o7dKTv0CayvXBvFZJRkDdFvG/hqWbE4ozDFrtv+aeq6dB+prayJLd4Qlp3f8Uv@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZYZqDtAsq9I2hbOHPErOuBR2Q/k02BKWO4nx+AhqWoU31rqx
	IaclFRuopp49/Dz7C4AdlzQU/4dQBzNIAoAcLv2cHpWg/AX+ZzA6vKHm
X-Gm-Gg: ASbGncsHQpNVoyvfXo+vsXS9jVJouG+4SQS7cdHTk6t/z45gNb3mj7rqGlM4fDDE0qC
	cNuxeIuLJVlsjcol049t7Mmy+OohUBh7NvmJEN/02BguppAlTqQL/dMjkSGr/ffob5WJoUxf9Mr
	kL3nQgdOJ1FQRP34No3Bl5MMlyQ4+jjq2XkY0X7emrqF15N00RguH68gpU0cW0URN0iYeNIJgbm
	ZZiBgEwk26wizi+giUjXNvUFJqmIXhe8yj/5fUjeICM88LfgJri7hTdn+P0PRmZ7SSOIuveG9tx
	yxYRqwgkDlb3KN3zrFDBGoQjgluJWOMngXXiptpQFMoVUseB7FNBxGo7+gPU2rM65TumxatB+vE
	4OmuaC7HaumpdDUJy8NIG1eVacX7jaY6oM6kIRSWQCoL6oXgr
X-Google-Smtp-Source: AGHT+IHNIEbxa6UAWQsKzdL61JfAyD30h+IPFl21tAc/+urvhLse02Zgh6O344jn51W+QYvc3zIEvQ==
X-Received: by 2002:a17:902:db06:b0:25c:46cd:1dc1 with SMTP id d9443c01a7336-27ed4a2d078mr55247085ad.33.1758846565475;
        Thu, 25 Sep 2025 17:29:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671225fsm37637505ad.43.2025.09.25.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:25 -0700 (PDT)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v5 01/14] iomap: move bio read logic into helper function
Date: Thu, 25 Sep 2025 17:25:56 -0700
Message-ID: <20250926002609.1302233-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9535733ed07a..7e65075b6345 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,36 +367,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
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
-		return iomap_iter_advance(iter, length);
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
@@ -435,6 +414,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		return iomap_iter_advance(iter, length);
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
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -559,7 +569,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -572,7 +582,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -749,7 +759,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3


