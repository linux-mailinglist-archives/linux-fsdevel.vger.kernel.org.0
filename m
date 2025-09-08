Return-Path: <linux-fsdevel+bounces-60585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76298B498DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C601B21F8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815F31E0EC;
	Mon,  8 Sep 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv65a+jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3131C583;
	Mon,  8 Sep 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357544; cv=none; b=J7QwQWPSF5D3fMkodcN0zJXNwR79NRnqOyEU6C4SoUml1AIzlvQTfXeUawEFAX3T8rVNhoobflfsmKNMtH/Ft5+VNtgDHNgmNTADi3mNOGD0mGsRYSOFzTtMYdpOWzOPCP/v6YsXIcPoIAu0QAwYJq1+RpHYVJP/4XzCWlfQjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357544; c=relaxed/simple;
	bh=HlWf+60XajNJzrOv/o6ql21t9thkZ3f7qfmma60hGSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/0PD5HrQEsKRpmuvglY/GSCn5r/7dBo9HmILJsPe526SZMwQmuNWcei/4R+0OpI+fCsH7Sn9ff64m98kuix45Ti3dhMHs81jmiNRCLapDOcB0Jn4AXd3RGy+ir419NxOJfW4dCFBakjrFxettvukpI5fvPOriDGZUPDdzw32dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv65a+jw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326e8005bso4310521a91.3;
        Mon, 08 Sep 2025 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357542; x=1757962342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbAhfZzoGj7BINNVnRQfg3QUv+j5nbtzByJhIRBZ6BI=;
        b=Mv65a+jwQj0sDEmKS7H49V4om95vqukE7eijsGXFyELnshSol0nZyUxERtZlHkj39k
         2hM4/a1h2POpQY/cORrF58+82ZVKnFYCyQakirTQLPg7nPDWgWIJ/W4xwMnf8w4etUQ+
         em5J+FzRPSC5CrTUEbd+FqYxhWh9jBF6RocBRNfYlWytX0n+NIqqaRmL+k9eKYE6hpPN
         PxnOJbmUlxjwN8Ar7Pef7chVR8vQW+GRh71x6YAsOYXIJUcn2zAE5/MVdn3r63tMHEMl
         BbDhUICa3glMJwKkopavOcISLBGv1eLH9CRbto0PZ3Ml1Gi+Pu4VIsL+pjlcwuvMI+q5
         eKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357542; x=1757962342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbAhfZzoGj7BINNVnRQfg3QUv+j5nbtzByJhIRBZ6BI=;
        b=rkkHwsj9OohJN9o4VFjwJ5kSuz5DiTvnIJ2pRclbCTGdxf451VhNS4ZqYVEY0pXH01
         2t7v1BBlZ5DjRy3/fc55phf6jD3z8pxU4UZDdMMopz/FY9qMiGaq+3BtqbDrCaZXlMrL
         6FOHVOfX/E9bE0Iz0/o/Q3aIZwCzrHQwiE9AOUgIJesePumZOmnmtdAZYfPutFxDPap1
         tyoY6kN7K6DPsld5/JpTTRHlTk8ERgjTBBgRNzuDmZ/fQHpER+XQ7B87tLIa8cuTTt6R
         R18I++lsxvzZbxrOKBkwjdHuY0TSMUmO5VIuCMfXw/IlDhpM40+NlZgqCQXSSyg2fWmc
         IMKA==
X-Forwarded-Encrypted: i=1; AJvYcCU/WWxhQlkjpzN6YAwXJTraURJe59sg5ReeRj4+bG+Z41RHp8uqdv0xyHH2jn+Zma6I5ynF2G56/nCX@vger.kernel.org, AJvYcCX2Jpw5EqIAhzHCDjGxobnH+GMKC8SGazS25XrK1Rp9B8Z6D9wvUgtBSapYi7gg4nqgq3Oo0L5OoVkA4DdhZA==@vger.kernel.org, AJvYcCXhl/cWNY3jcVRFUT/1AohoG2Nh4mNe4CmqSd400Zxp9q0Vwacm1TtvGJtDZ/0HgRTXPlHZWNOcsZ3R@vger.kernel.org, AJvYcCXsAv9sALKhG+4+f2XkCl9+vSCj1/kXYE9pFGtd0GZB/Iti5zJ6jzrx7TbE6RbqNSI50XcOWAZQDxB6dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0NJjMBQrJn3l0BhA+nwbBvl4IcKpCXDe1NLbHc+O2eO7pkYU
	wpaAFChJ4VG4kc/pMzL4n+loZ5lWlEj56Gz8oonPlBHaw/CURSKYNMsW
X-Gm-Gg: ASbGnct5FUMpTw0+ENUAxwCefjpv7MPOUyKKgOs6sIv+a+o0CLFCB4qEw6YLDTbtm0R
	ImJ73t7ZeLRPhcneXSdVpK5NnbSE4phQw6Ykh5YbxRZvubFQhfU3jUivzHm7+9AOOg3o3Jb/9zb
	aSv1VjkX9pjjjuH+tnUdxiX3dDZh4cRAaoCai+onN7ba2ZSi6X70r+zkAipSIwqnek5i19FEETs
	FY4ztuL9bK4LbbkRD7AIvVWsJWimX527cvQdMQtuSxXq8hLTDRNc5aTul6nEijVurjN2H09Mol6
	7u+idTFxExOfUn5emUommSkCXDccB+NRFqmRT8D+NtHnE8uNPc0XchrNxHHmVMiQ7rpwdTG5HN1
	hS5ayvdN1bsuDvUEw
X-Google-Smtp-Source: AGHT+IH5oWGt7OEC4zYedM4irtBrlr8Zu6x8woV1tHH464aupZ9uvD16MfYmjd8ehMyotB7fyPyi4A==
X-Received: by 2002:a17:90b:5343:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-32d43f937dbmr11422558a91.27.1757357542549;
        Mon, 08 Sep 2025 11:52:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57b227sm37661021a91.6.2025.09.08.11.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:22 -0700 (PDT)
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
Subject: [PATCH v2 04/16] iomap: store read/readahead bio generically
Date: Mon,  8 Sep 2025 11:51:10 -0700
Message-ID: <20250908185122.3199171-5-joannelkoong@gmail.com>
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

Store the iomap_readpage_ctx bio generically as a "void *private".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 598998269107..a83a94bc0be9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -358,13 +358,13 @@ struct iomap_readpage_ctx {
 	 * responsible for unlocking it when the read completes.
 	 */
 	bool			folio_owned;
-	struct bio		*bio;
+	void			*private;
 	struct readahead_control *rac;
 };
 
 static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->private;
 
 	if (bio)
 		submit_bio(bio);
@@ -385,6 +385,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->private;
 
 	ctx->folio_owned = true;
 	if (ifs) {
@@ -394,9 +395,8 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	}
 
 	sector = iomap_sector(iomap, pos);
-	if (!ctx->bio ||
-	    bio_end_sector(ctx->bio) != sector ||
-	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
+	if (!bio || bio_end_sector(bio) != sector ||
+	    !bio_add_folio(bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
@@ -405,22 +405,21 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
 				     REQ_OP_READ, gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
-		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
-		}
+		if (!bio)
+			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
 		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
+		ctx->private = bio;
 	}
 }
 
-- 
2.47.3


