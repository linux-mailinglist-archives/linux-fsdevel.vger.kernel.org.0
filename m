Return-Path: <linux-fsdevel+bounces-61841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5EB7E84F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509101C04566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4062D8383;
	Tue, 16 Sep 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibE84cvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA902D3EF5
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066632; cv=none; b=EjbtL5vddxJedV/GcBaZEVY/FDgVmLzA5uO5YRN7r9ZL0peT61T6S6qQUedSiKANQBhnq2iUB8DuFyIVQv4I5TqtUVbuMLPbABc0TeKXJObxHJNyd8lYhE16Nttr4BPySNFeD3oC944HfmLU1BGsq9qoGqz0djQvXba+vO0COrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066632; c=relaxed/simple;
	bh=oQMvt3x5Q2N+uSt74k4pmpTEp6W00XYhfBugSskMdWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2ai9T0KtAx9KhwWzD9yn4/D/TkGW/moTxiLDFhL9CFMFO2arcaGRxC1JxDwWNsyF/wn112PdrXtUzciLZ9OoU5BTy2nzRcBH98vU3KjofjSSTiyeKw5pH3q0dSs6PKCZP7oZMJpBAR4yilGrfXM3f39GyfvYXfRQ9/HcndVMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibE84cvN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54d23714adso315518a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066630; x=1758671430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=ibE84cvNHpHe2yOPUS1s1jKOO+ztjpBHw/t3qKGb2i1FzRB1waAMhUFT1SggEHkxf4
         EKWJl7/5ye/RqcSI14hRRqYW4cG2Xgr7OtkEa17eOCyzfRR7PczlbmRdCP1juLsJSJzJ
         5ubYiHkijurimBzyN2CDTVgehM1UgE9YeglNwC3VeqAzHceAPkQ/PWi6BRIGSbK+3zPj
         PzJIF4ld81KLW5UzcugTztVyRwsidwkABVfxXKlY+33fNfiZAeTiMZ+H+HXh62SXm8IY
         jGxLLF3/tCjs7dtgkZfAx/dufr3wJ2DUKw66JZRaFUu2BU2XTbIIEfNQlgwYrxnEBp7C
         Haew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066630; x=1758671430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ad09+MQKPROP4xJOPPVDT/APdYePwOoTN3n11YylRQ=;
        b=DBrVr1/aVxTdyco62svwLV+8LrYUMkDJwzrs7nyZIIYhkvuw5BQ6bUbeyW4K361FKC
         OhvV5DOOsQNyps/iN8ZgGdzItw2/dPrIDNd8KPzRZdrKGVy0ehsq5eefhHN1o8DZbuEo
         shV+FVtHcJkk3oJCcmcrIIJVqRPGT2c6T0zaKBFmbDvMJyADU7TjCV2suyWZz5lKaxbb
         wO5r08cu3HKeTnsw0YcyPpsbClmN8pPQP6owvjDWe40stbKP4tRA0gMmMRs+DRTjAjap
         bnaYXs76yqiJMgVPEgmodPkB5IO0+WdyonVzDTC58DzMRYlH7GEUxtcKhE6AeuCMsFfT
         xPWw==
X-Forwarded-Encrypted: i=1; AJvYcCVsex4xnvEr4MDqk8DTaKjaiqTBCC6MCn6jwu64+n9q/u7ogurwLRoUmZ5V+hDJ0QR9WWysgqqWi72R8iKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKKQNnXKgGi9I7XgysiWyw/CqhKdkgXH2W1Np8Anvkn2oOFq8
	gDiRvnrzDsJL4nDL0VEJKqOCjhmI7QMM6Dp5dN0vDA5nKdei1ktOimAJ
X-Gm-Gg: ASbGncsTfSpMjJ42Z4o2Vc1azHa1GMEbUcHno0fIoGva75HS0ZZd/7ii7gNexth30NV
	6WKe2e77gSGxOZjwKz88e8/GwIhfMURrHD9UJUBEjVorPUV6xYPhSMb1toL+nJddqUB09/pyzgf
	qTnFEnyXyxcHSFHMrTrNkTN0tFbx22x3ybYapvOO0QcjnuuF05hTiTvfOn3+7pVXvTGJDnLHeDK
	cRQLlS8pI14EW1SSGUjcofpwuUjEeO88qHhuQaRpbFNdMrk3gC11kvarHQxoJCqizkbLPHytB42
	p4G9OVhm0ax00urmPq/SXBYWjHD3cUzlzf8ugtBYxINhGSOJg6l32D/ZJPaJDXIFV2MMI8eOytK
	jqPz0G5XoA28Yp2AVt5wxfNgNAmPULQqxJG5bBNdVxWZgRIX1
X-Google-Smtp-Source: AGHT+IEBXsoPFEqPmLi3eim0ez8AD7ra+R5wqscn78wj7CppFc2BDvERHIUoydzeJ3XEBjfYKljMBg==
X-Received: by 2002:a05:6a20:3ca6:b0:261:ed47:c9b5 with SMTP id adf61e73a8af0-266e5bf9c68mr6068804637.13.1758066630224;
        Tue, 16 Sep 2025 16:50:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398aa76sm15413902a12.44.2025.09.16.16.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
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
Subject: [PATCH v3 02/15] iomap: move read/readahead bio submission logic into helper function
Date: Tue, 16 Sep 2025 16:44:12 -0700
Message-ID: <20250916234425.1274735-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper.
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 05399aaa1361..ee96558b6d99 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
+static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
+{
+	struct bio *bio = ctx->bio;
+
+	if (bio)
+		submit_bio(bio);
+}
+
 static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
@@ -382,8 +390,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -478,13 +485,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+	iomap_bio_submit_read(&ctx);
+
+	if (!ctx.cur_folio_in_bio)
 		folio_unlock(folio);
-	}
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -550,12 +554,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	iomap_bio_submit_read(&ctx);
+
+	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


