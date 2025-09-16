Return-Path: <linux-fsdevel+bounces-61842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97251B7EC4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9244E583219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A42EDD7E;
	Tue, 16 Sep 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhNQ3Nsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27F2D7DF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066635; cv=none; b=p/TqRstRlaeJSmc8TDkauxr7ykmU+RtnsxgbTTG/Wj8fGb7MuQRKBCMf4vaLkqT0TbjscntI2kkVVvGgNLmp2pCPwDrmj/eh6zszfHVR9ERuV7KC7pBR9Eohbuah71TBjU/3M9Pgu2lB/CQIBXIIP02bXHMYtMR2yvk61wsyvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066635; c=relaxed/simple;
	bh=rjAgCi3/eMn5KyVZd+dOJ4WV8eyPp2yZu1uzgiUzyCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlV1CoGlWtNmplkmT2QFerOf4IZAc1p2fN2i9T5L+lPPtTjSf5ip64Un7dJMFMoVEJXO+MZup/0J6i29K5Oio2pdC2K2xsKn2EJq1lG631Dv4TPbFN2Ujk7eueltIhYBASayzV0vsqZKtiIie2XjonvL/9Z+BQFGkkeXBU7nzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhNQ3Nsw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267dff524d1so8314115ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066632; x=1758671432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nMNXXiW55M+I0FZncr65g30DqrOJDGj0I2j26ezOyk=;
        b=dhNQ3NswZJknSC7QRy/QtFyJdDWPbbNpaBzj8y1ytXFW1YDwqWhGKaw2nDIx0D1nGe
         sn4DjQ3nywtCkcrZN3TXStSXR9xWL3zLzmhcimJ5fZkQuLvW9w/9CVuYuZVQW76Om5fh
         byzklz6TpGyZfpWxEDDoSSx/s1pCLwz7UUjiSW2n9Omw6289gjckFuJG806LXnzyKuNr
         u1w1zTKHw69QK6xb2ZatGFYMqgRQt4dBP2t+qUwFBDaO8yw9Aocz1vfKSg6D2ZFrKr29
         KuGqc8e2rRtYYDC2yqQEmon/f+1H+z2bmXtLNycnmA4eoSP5XtfMyZAzLUsinqpZifVU
         RimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066632; x=1758671432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nMNXXiW55M+I0FZncr65g30DqrOJDGj0I2j26ezOyk=;
        b=Oup5g0n1j2tApAzjwYbOK5QFWpVstu2R0tqYMW/OKEDLpQKwpZNAdaApF3C8obTRJ7
         yR2AYszx33JoQavi6rdV/gis18BrHPfyOWWF0N3GFluzWDjpKQbsMtqjrTVn5p0/DbvX
         WBOzgOnCIClDJDXdX33ZpJDnrqM/isPTmQWlNUe30os8Wu25Dc3CYmsC+C6o4xqPdSqu
         W3TccutgfaBFt82mbHG8pGo/rKurzacIyVlP3bMubrZwCKBeCRTReCRNigaOKGm0dsdM
         izcsDMqpQ4DJp0QoYA0pWpKNPken07Itt/pP0MRbE3kuiGMjCxEcVJWzyBLxkT64FXgV
         qZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUAAun5cCELAiiyAu95sA7WGfWYSPrp2/nqLvLaPHXE4Dd9t0CzKeUZNRRbZjVBgLkEyspGGDlwd/thn97J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyog+sm5u9DjtXDkIqoMdNcCkW+UZ1NGpvfVP+JMGOLpdZY51DM
	eZHmqKIU0UuNQp0O7KmLMJPyovFcSMngqnXbIeOH6v6nXSWibsPH22hX
X-Gm-Gg: ASbGncvG2lMVtWgmAHM9ru2tXv4Gu+KFT3DqHQH0GoG3GtzDEnaCEDAmiKVu9zKvvB8
	jKl5KPXFTcYn4rN2ym457+VcQOmkiuZKM5x0zwry8lueapV62AAmZQ35Sz67JNo18T1cvp6p0TY
	SpEvA1j2wFS7A/jmYfTOrN5Hk7C+uGe+M/MIX5tNaw+obx+62W6nFSeswY1ZzGQry9r68dz6Jrq
	nkMZFjhfDQ+pPdeO46/9p47dyRJYud6VFasiLT2BKJqz0i34w5yRJTBb5eARuwL9ueRrwrl/IQi
	mBpCewGpnWO0cTco5pXTtuo3wbrWdnOe5xeRHsKrml4iLsCRAw6y9cfFiLz0FxwPme4Ek/6Ay8R
	SQlAF2f7QL56KHR9fhDQKFONy4qqL1YN///0A7YtEcGtB/34aHg==
X-Google-Smtp-Source: AGHT+IGG9poxGSaItOpERv7KdyBVrmiU9DM8ctL/8CBjU6dxWdiXC+MY/afeQfS1uk7JGq3+BJJyuQ==
X-Received: by 2002:a17:903:2b0d:b0:24c:1a84:f73e with SMTP id d9443c01a7336-26813f1bb6emr618025ad.60.1758066631648;
        Tue, 16 Sep 2025 16:50:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267fa950089sm9719725ad.100.2025.09.16.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:31 -0700 (PDT)
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
Subject: [PATCH v3 03/15] iomap: store read/readahead bio generically
Date: Tue, 16 Sep 2025 16:44:13 -0700
Message-ID: <20250916234425.1274735-4-joannelkoong@gmail.com>
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

Store the iomap_readpage_ctx bio generically as a "void *read_ctx".
This makes the read/readahead interface more generic, which allows it to
be used by filesystems that may not be block-based and may not have
CONFIG_BLOCK set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee96558b6d99..2a1709e0757b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -353,13 +353,13 @@ static void iomap_read_end_io(struct bio *bio)
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
-	struct bio		*bio;
+	void			*read_ctx;
 	struct readahead_control *rac;
 };
 
 static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
 {
-	struct bio *bio = ctx->bio;
+	struct bio *bio = ctx->read_ctx;
 
 	if (bio)
 		submit_bio(bio);
@@ -374,6 +374,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	sector_t sector;
+	struct bio *bio = ctx->read_ctx;
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -383,9 +384,8 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
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
@@ -394,22 +394,21 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs), REQ_OP_READ,
+				     gfp);
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
+		ctx->read_ctx = bio;
 	}
 }
 
-- 
2.47.3


