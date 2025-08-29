Return-Path: <linux-fsdevel+bounces-59685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EDB3C5D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C04A08BAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E72343211;
	Fri, 29 Aug 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrNAEHpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193493148D5;
	Fri, 29 Aug 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511904; cv=none; b=on4Qxenw+tyRpiN2zIKNA/ON8yFv0Q4M6YEwkZE7bnTAxMMNFaswZtgyBAZ3LNpeclG62FGqRZ27f/yXAhZ2pFX0jDXPkLZTFCOCbEyXV+U7uBt3Wv6758Fje+TQlfyrIzQm7HW+UtmLSElHm0qbZ+O6TmYuXFRbBJwf9QrXOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511904; c=relaxed/simple;
	bh=wiZ3ow7V9ZNFO2HdmvjZgANbBPMhy2OGSN4tc1X4WBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTZ8XzFtf126l3Mlx+CjjBQovu63hYti1kCs+hDATPttgD0rJEFkGr1fu8ILQHn2WxUxqK2fKqnFLppJNxaIU93mEcqHIrGE5VwXFxaecq+MzzYrzKD1zNcteidlyQGAYllgH6sxKXqzQWsIlJOW/8+Gq2gcbJmOWBM5W9A7c2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrNAEHpS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77201f3d389so2855442b3a.2;
        Fri, 29 Aug 2025 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511902; x=1757116702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK2rwbi0jkjcqpO52cwa+CvtNmL3/pKVQ7BLQhFJGpU=;
        b=VrNAEHpSvk2bfZloUFa9J5rZv9UZAtu5r4Iti93CZsMzafOQSnWFwUL6hMmmXXYHZd
         aq/sIFzj6m8RU4V5qLp1ljaH/+ll6SAzxaqVp+eL7skn90clhNwvmri3Hkj86Pf7mShc
         cLhpwg9gRcuPB1U2OPkmJibDpg+RWW30qJCiihN6dxmWDD9jxLnp+WzXADnk6qZTCM85
         gT+vH8TXcVrDuZqz5KaXiaPnkE1LKX4XBCqf1tN89pwKbEaOdgCyaDX8Xl20K5bIyhrM
         7BIzHtCB1FmBqYla0jQkArHba0VCCjmJt4wu/2Jl/iXOVpC8X9ZP7q0cnKQmGR3pm5Ii
         vSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511902; x=1757116702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK2rwbi0jkjcqpO52cwa+CvtNmL3/pKVQ7BLQhFJGpU=;
        b=WgCDFySr3Sk9gUhZR7gPhdsAUtConv3awT90+vq1qbGmT66uZNBQKTNItoV4bfrZJz
         BvzVKmtvMxi4CfXBIBypjwya7DpaYcHXXDO27Jz5i6gMfjyGOXg3e935lGPtolpoKyet
         T65RxoBKeINIKL0Q6T2HAq/lucenqh//FV1Z2zvAcGJ7urFJy9MCubLjFXqwb0MOXHg4
         bmCx83yu3eplMwJKzD3OqIp2WzXZgBZi/qvSZx53k5/hJICxu23s41bdcAmDKHX/brKc
         S1OqQjOxXG0PdQ3qtfV6txaeP8eT1kOzgDWeLX5sxMYWlxAe5uVjAWJjhD911z+fAcyr
         B5FA==
X-Forwarded-Encrypted: i=1; AJvYcCUsoyI8+mZavhVeREaAPP96GT6xKwa3FaFcnehbh7ZvtLQ0qYot1EIGyYfedMNcmhTJBuFbdUlY7ts=@vger.kernel.org, AJvYcCVX/kbgGiNiTwLMdlrwFYcabwbL0zvf+rbGi9u4Ks428aQEodiDwBy60/642cCYOjM7C2RfujxrOwGM@vger.kernel.org, AJvYcCWpDzjPpkpLKTcAdmLpC5k4q2I16nG+0rZFjzY+wLyLuScIv27ugrnmWzmd3LjelFd1YCad5iHsoBigcZIFKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxL1el7H0SNN+HKz0dJ2nZPcji8D5p0c4s11Xev8Q8RIPGbI/j
	oCYvNS7FXKGq9upVz9RsUWrdjI/MYr47/1eMskM2gnaTyDKa5oT9lO0c
X-Gm-Gg: ASbGncu0tnzMCtQbD3C3P2g4p8THtHqz12c5xubRHHm3AGR9Emc/8wGX8YXkz3uTwN6
	nODsuCxZjUpjOfnk4Ora4YeK+SGwkEfDXh5hsx88kl2KJgY6cJNGB4mX/B7SQbx8ifpEqM7znJY
	ynpTkq2xk+ffGraIUv/+0WaINIj5pX6tE0jlemh+isxRgkGg24kL2z8DTO2xesvk8dsoolbNtT7
	tAXjLSCXG1ahzzsLzsL8NAcoCie3ckEkeUpdIDkJULOcQkljwCid7QxEvlmepHIjTi2aK/50seR
	xxxO1TopKCGsLao1V3fixV+SNQKiydsKqtYhzn4Z6w2ePqF6WurLDWoJ9ODQPBJIc15DtVym3Yv
	YQIKS7C/VJkTMY6gnWw==
X-Google-Smtp-Source: AGHT+IFLpa2gaNhyiayN8ty0xzcWpsdf7ADLdYe1rNnWYnDez8Jds38zpYgw4NqWOK13VEiB4lqZOg==
X-Received: by 2002:a05:6a00:2d06:b0:770:53ed:b7b0 with SMTP id d2e1a72fcca58-7723e0d39e2mr319049b3a.0.1756511902478;
        Fri, 29 Aug 2025 16:58:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723d79fed2sm325722b3a.9.2025.08.29.16.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:22 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 04/16] iomap: use iomap_iter->private for stashing read/readahead bio
Date: Fri, 29 Aug 2025 16:56:15 -0700
Message-ID: <20250829235627.4053234-5-joannelkoong@gmail.com>
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

Use the iomap_iter->private field for stashing any read/readahead bios
instead of defining the bio as part of the iomap_readpage_ctx struct.
This makes the read/readahead interface more generic. Some filesystems
that will be using iomap for read/readahead may not have CONFIG_BLOCK
set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 49 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f2bfb3e17bb0..9db233a4a82c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -353,11 +353,10 @@ static void iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			folio_unlocked;
-	struct bio		*bio;
 	struct readahead_control *rac;
 };
 
-static void iomap_read_folio_range_async(const struct iomap_iter *iter,
+static void iomap_read_folio_range_async(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -365,6 +364,7 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
+	struct bio *bio = iter->private;
 	sector_t sector;
 
 	ctx->folio_unlocked = true;
@@ -375,34 +375,32 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
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
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		if (bio)
+			submit_bio(bio);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				REQ_OP_READ, gfp);
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
+		iter->private = bio;
 		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
-		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+			bio->bi_opf |= REQ_RAHEAD;
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_end_io = iomap_read_end_io;
+		bio_add_folio_nofail(bio, folio, plen, poff);
 	}
 }
 
@@ -447,15 +445,18 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	return iomap_iter_advance(iter, &length);
 }
 
-static void iomap_readfolio_submit(const struct iomap_readpage_ctx *ctx)
+static void iomap_readfolio_submit(const struct iomap_iter *iter)
 {
-	if (ctx->bio)
-		submit_bio(ctx->bio);
+	struct bio *bio = iter->private;
+
+	if (bio)
+		submit_bio(bio);
 }
 
-static void iomap_readfolio_complete(const struct iomap_readpage_ctx *ctx)
+static void iomap_readfolio_complete(const struct iomap_iter *iter,
+		const struct iomap_readpage_ctx *ctx)
 {
-	iomap_readfolio_submit(ctx);
+	iomap_readfolio_submit(iter);
 
 	if (ctx->cur_folio && !ctx->folio_unlocked)
 		folio_unlock(ctx->cur_folio);
@@ -492,7 +493,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	iomap_readfolio_complete(&ctx);
+	iomap_readfolio_complete(&iter, &ctx);
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -558,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	iomap_readfolio_complete(&ctx);
+	iomap_readfolio_complete(&iter, &ctx);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


