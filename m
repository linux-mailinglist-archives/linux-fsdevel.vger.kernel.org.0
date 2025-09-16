Return-Path: <linux-fsdevel+bounces-61840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC6B7F3FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FED482D03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC382D3A9E;
	Tue, 16 Sep 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOGKUWqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B82D3EC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066631; cv=none; b=PBBnOY+TRvhFSvShaRfHg/FyWbth0EefiP2avEcYdcZQXq4+jZBYwjnYmYV2xaqGDKW4Ttlmafq4Qbllhj+eqZ01iiJriW0gaYEZz5MrKvisMklvTJrSmAmiQsH892rdXBHMf6+r0y/sUVb/Uq0jd4SZSKnUk93CRBbOXewvjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066631; c=relaxed/simple;
	bh=w7oHmQ9XFnwraqw2yEaSdByUgxP5t881lYwL3uOQXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0JAp3Pdcvha01uP5hLSH/ACivoNYIhwIk+tBeCA/3tObT1aEFqjIVt8lwlMXbcH6oEZX2mB4WgdzHwNdC7YAEldHksfq1GTJDf6Ik5aICaut+WGR4At599Bk1fwFdzNpcFk4vMjzVxZJ+nvNcIQSHMHjJl37+tynou9fv7V4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOGKUWqM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4865552b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066629; x=1758671429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=JOGKUWqM6hmg8NbRBW8fKEvclPVuamXSEsrc3Vq8RX4Y6rL4ut7srCj3Ymj9DmOKtQ
         gfF/c65n88R1WHXKGRiXbsLBNOnNo6/wnr5UNaei5t47oue3dL52cK7ovdEobS/AZVKP
         nXupuxq6FG/pY7lVe+4c3Rol+kLx5+3huLIFXfnjtlSpGNIbm5miis1wQKox0FRAgbH3
         BoOxIGJ8k6D8bnIYxP0eh65g9Gp4d5OJ0Tzu/yj6FsyKGXEyPD10C584QKY+MTdn2IRT
         TBkBNphNrcFzDIo1Macncf1cwpjgLft3w5WsNQD8C/dm6IdcrRJ+f+JA4xImJ3r4B6Q4
         Zlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066629; x=1758671429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igl0szEKM52u4N7LjkG17Yn1ot1jDVlccs4WBeJ3GIU=;
        b=VNIf53f5pctlH0qDGMCWB5wUDgmQVGY+1btjajgNuUKouSsegyPirWZ5nMYk45BfcD
         aiEKCave8yBk442Fpmu4GxneINzkNY8F2gnTcMZ3A1+2xvG1+ZN6J8TPGKpVpyuglRof
         rifOsCuiEiwDXx3BDc6lq8KCaFHD3o73B87qqXADy38JY+g8MDTn6itCfAB6e7PrI4Pc
         efWleFzeIvI/4H8/RSmR3NbIBBrusHireZbjayLUXPQitsYy5VCeH6E8cIHuGdAvhqLD
         0tfYkpguFhj9t3yxe+Tnv9dbxe0e8Vr2T6SapWgv1JsIatpWy6awU9kCUEcND8jCg9Zz
         HieQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+Y1MM7x7ry9mlu95FkaRjq1YVhABmQVukYM+bvQrc5u2HJVYZBZ1sMYxpkLEBo0X8zyDBFsHC1jWcnGP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6s439HCdYGIoiXFXk5HBadsoN1mF4vgl6Tvf2gmIXMpqBxh8c
	Ylnv95sgpCkapPBO84y9oc3Iy7ZdwZ07/Q+bZXYq2+4HOmvfvbpAfV5T3uM0UA==
X-Gm-Gg: ASbGncs7WqWcxjzdbaZtQWwUIW4nQH/SJXnNOuIozsnGFtLEG4HmGssB8WSi2/YTgIO
	B5oV6oGOLXeRC7yq4QvEIMB6V0NatijDC9wSycIhRP+ShSu4+FEMu525uN6jN3LF3nsMezySCX+
	GFxN/UPcqtdVMAzW9ieCWHfnEG2EE1cvx9GeFIZcIijT7qapE/S9gqT3IIbG6j+kyjODsZpSfZz
	FDVSH9k1uAbA0xHO5a8GA5l9OA0acEPtTaxk5xWJjSiEDGMqyIsVFroZE5s55iQwFxJVSpCq8GK
	Fu5UZkctKusoWrZ+zaGiJuBYoCgnWqCc8Bpt5YDn/Hz8VRSojMEgqut7r0tQ+beEe87R0fQVX40
	YC1Ssqm9SbJ8Qglge1kF/AjxKwx1kOdCmX+f8HzHLOxNEOSQAhA==
X-Google-Smtp-Source: AGHT+IEwM37n6OeuEIlANEEpCI0EjMz/gqdNYw7ssUAAFOa4ZLo8dnWTZo/sk9QfoO9n62XpLdWOZw==
X-Received: by 2002:a17:902:db0d:b0:265:c476:9a53 with SMTP id d9443c01a7336-26813cf234fmr721615ad.41.1758066628820;
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2680889f486sm3438975ad.137.2025.09.16.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:28 -0700 (PDT)
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
Subject: [PATCH v3 01/15] iomap: move bio read logic into helper function
Date: Tue, 16 Sep 2025 16:44:11 -0700
Message-ID: <20250916234425.1274735-2-joannelkoong@gmail.com>
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

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..05399aaa1361 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,36 +357,15 @@ struct iomap_readpage_ctx {
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
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -549,7 +559,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -562,7 +572,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -739,7 +749,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
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


