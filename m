Return-Path: <linux-fsdevel+bounces-59688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF801B3C5DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10CF1C87898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89D35CEB7;
	Fri, 29 Aug 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzDvUr+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD7273D92;
	Fri, 29 Aug 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511908; cv=none; b=TM/ryO+SWGo87dKqBgOCYpK+P0CgCVpvKhXl+6QBTajlIUMvoYEFFBYadw8Eec0DOmmpmOH2hgXaxxyr1P3xs7XSRMU0L55eXF8Rrzhz5GSOunCI9ik9x4JTEcspUE8ObJtkKhWD0Lt0Pp6G4Sxv5OSTUC2gER0L3BlJX3WLJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511908; c=relaxed/simple;
	bh=7gZzOIYrwlVtfNsN4r5OEIDd4zjlKei+WnTPigLK8is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYsMtLv/ymieDsYm9bAy0ziysF4IcjFAda4QpYt3S1HZDsndT4yIUsIAOJ6SKgvpDVMLMgg+vdHZAp2ERPHpsiqBMxtoGfBBgZLhfnX2X8IqE3CXE13S9TTvBjIotb49+VZulMg2tEijRIT8C+/+828sdmyfUKT446fAi5ZKz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzDvUr+D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445827be70so29270175ad.3;
        Fri, 29 Aug 2025 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511907; x=1757116707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td3zBZvieF9RjYuLCMEsRT84YxGnGPLu8XHNCbniLyQ=;
        b=JzDvUr+DE+QtyKzblEiP26hNTrI4puPXCBWnuaYL/P/6SbABpEuuakkodEypeVlgNp
         KD4633T38qqgCKng6Aa6iYL8Ut3ta+MbYksh8yPJbc72RTr6qa8Irrby8ilIwdV9+78y
         HslNr5rP0qPmvFdBTHmO5UdWo9m1A5AjJNN/r6tEAs/CcUa5assK7R9xzSaRbD1pGHIX
         1WZPj/L1jdymRxHQzSYqaGNA9nbl++WCMcke8Y+mw1UhbIRRjJGIPUSSMdedmtEZS4Nm
         FQdoun94jaRta+zFOWd8lABAErB3ehJ1ACqWY+50A3ZcTNz0tmyK6RRfFMlyZ4jSWVDd
         IDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511907; x=1757116707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td3zBZvieF9RjYuLCMEsRT84YxGnGPLu8XHNCbniLyQ=;
        b=ZMqVns3cIpm2NH9d+OxnEW9wNHQ7CgQi/9Jgobvpu9Ja8N7iUfeWer8HIV+G/l/E2E
         DbCcmq7UgYNlA3R8DfyLHDo7wvWAFOoegOYg0HTY6bxjCR8Nf5UVmElkwOG4USykqKwF
         UcMRjnuHwmAm3hR5y8dzKRCnOYBFe/zTahkHHUbuRBJsYLRKwK3nRyKvjSMniaftqsqx
         no7F58buXXNvnYAuK+mDt+qYZKK3b4zbGvjDhO5Rt9JmojTXD79JRhr8QxBBdyT5qM1/
         h7HfsaNxnTwN+XJaNpG5hzinkXtblqcdd/Uycf/Lyn+WauyVksGuPUXlYAk8/e54vO0N
         exlw==
X-Forwarded-Encrypted: i=1; AJvYcCVH5MzhAaeuuLo1FLtFwGj6CHxkNfUGcrBlGqAg9IVVO8r1uubiP0epfeisGi3WXF3maxe/mzFqy4Q=@vger.kernel.org, AJvYcCWuyr61dnVhhJQdGE9rTy1sk/Nxu+iCf/2YQRmdnEtszdJqngVu8cUBPaLtvdSaS4RfZ/YBBgmRYyP8@vger.kernel.org, AJvYcCX+11WAbrerHPDeDM6vCH1L/D/0qD4+MYYvF122TGQtCu9veVPvgdqBSwK9OQ/FrM09lMtWm1O2V93fDgE4kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcZI6FBRHLqICL1txd3yvcxcEzABfiA3I5kJeM0htMrq6QBSI
	pgc6TbEHyb33Kx6/uaAw3TLlc8DwpX1J4CbS8jhDLI5CDq1bM5eWZ+d0
X-Gm-Gg: ASbGncsQmDLaofMCy5TICM4k1aQdO137VpZxbjFSv3J0nhPfBhwSU/swUBp0drDajgd
	Qxrh/iKWIMtTLBQXdPNpnGlZ5Qb/kfzgxjZwJU33iQt83ZnlzxiohS64VtjAcqA0sRNdu8YMgYl
	9gGG94M8b9/JwmJqM2PY+ED+siG26a7TzWhN4R1svXT0Z4zVMAKwo8qTkQA031R9HPeGF1XSQNB
	rDhAauZn86thGQIVMMXhGtRDzVifeK4sTDJLwE1ql8vie98kM948vIkf2pPAWmPmQFzVPrW/qky
	AmD21mOtNlUJwSElbyek0kq2V1RvniyHx5IGUJw6i7eEzwjco84ld+DxV5NaMwazTwMSqa3xMMu
	yAhzUp7hk6gAkZNRJfQ==
X-Google-Smtp-Source: AGHT+IFD4weOh/oiSOcwog2pV9NNYNqX8sU4Gr98amPMDcLO2pOkgMhFoE7MrD4uuJYhlpFB5RFtEQ==
X-Received: by 2002:a17:903:32d2:b0:248:b28c:144d with SMTP id d9443c01a7336-24944b81235mr4552325ad.59.1756511906623;
        Fri, 29 Aug 2025 16:58:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490373eb17sm35957745ad.54.2025.08.29.16.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 07/16] iomap: iterate through entire folio in iomap_readpage_iter()
Date: Fri, 29 Aug 2025 16:56:18 -0700
Message-ID: <20250829235627.4053234-8-joannelkoong@gmail.com>
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

Iterate through the entire folio in iomap_readpage_iter() in one go
instead of in pieces. This will be needed for supporting user-provided
async read folio callbacks (not yet added). This additionally makes the
iomap_readahead_iter() logic simpler to follow.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 76 ++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f26544fbcb36..75bbef386b62 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -452,6 +452,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -463,26 +464,30 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_read_folio_range_async(iter, ctx, pos, plen);
-	}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos,
+				length, &poff, &plen);
+		count = pos - iter->pos + plen;
+		if (plen == 0)
+			return iomap_iter_advance(iter, &count);
 
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, &length);
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_read_folio_range_async(iter, ctx, pos, plen);
+		}
+
+		length -= count;
+		ret = iomap_iter_advance(iter, &count);
+		if (ret)
+			return ret;
+		pos = iter->pos;
+	}
+	return 0;
 }
 
 static void iomap_readfolio_complete(const struct iomap_iter *iter,
@@ -494,20 +499,6 @@ static void iomap_readfolio_complete(const struct iomap_iter *iter,
 		folio_unlock(ctx->cur_folio);
 }
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
-
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
@@ -523,7 +514,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_readfolio_complete(&iter, &ctx);
 
@@ -537,16 +528,15 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	int ret;
 
 	while (iomap_length(iter)) {
-		if (ctx->cur_folio &&
-		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->folio_unlocked)
-				folio_unlock(ctx->cur_folio);
-			ctx->cur_folio = NULL;
-		}
-		if (!ctx->cur_folio) {
-			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->folio_unlocked = false;
-		}
+		if (ctx->cur_folio && !ctx->folio_unlocked)
+			folio_unlock(ctx->cur_folio);
+		ctx->cur_folio = readahead_folio(ctx->rac);
+		/*
+		 * We should never in practice hit this case since
+		 * the iter length matches the readahead length.
+		 */
+		WARN_ON(!ctx->cur_folio);
+		ctx->folio_unlocked = false;
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
 			return ret;
-- 
2.47.3


