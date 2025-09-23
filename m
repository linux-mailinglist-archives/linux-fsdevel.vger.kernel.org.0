Return-Path: <linux-fsdevel+bounces-62442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E997B93B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A837AD637
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F9C166F1A;
	Tue, 23 Sep 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXhkpGQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E31DE4C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587640; cv=none; b=FNQf7XaN+zyQYzcWzMdt+lXWM/HW1v3KHOIJymNwp1xK2OdyK3ANb5oNeCI59Zmsko0LUAwreb62v9ic77ozP3H+qq48SDZ4kOSs5BMtKQhUFmmdFovRPCwcwn3LUDoJ2vdMvW3L5lOaj9GlbYRKkdKXY0gcOIDI3RB2+3X0kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587640; c=relaxed/simple;
	bh=a/zyIEvLQc/XUbs4Regz+PNxwhBjl1k4o/jZih5gfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4k7FxSUtXonKhbx9bm9eMOwwM+2VBE2vaHqFFz84/iJI4ar51mR04RiWY3LJIh5wOgOOb6sFiNtS+vZTKYmntu+j1vq7L9ml4hoXCwSAhwPTkH/wOaBfMugcFPtSpHragHvewfiUtz0ypzb2Z1OnDhs82bOTbQurnGW2+0qFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXhkpGQL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445806e03cso64246385ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587638; x=1759192438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=FXhkpGQL/gTgFwPNnUREcfYZCX98ZU4B5pvjzfspzeKJjPRi5wEBrLufkZ8GGkDC1b
         IWPSwuF6ts5wTUYZZ0uF/U3wnn831Ub9BuobGeiTYduIDCzoNLgsz0hnQRQ/gynJmm7X
         Sf/7q65mOmKhWOb08nabUs72CrYfQl4GuQV33CEMHZhZqWojZR9IUQPU3Z0JBiO9hPmY
         yDxpIXlYthNOUO4gNxE0WChEBP/wyC0IVfUD1cARmdYnn/Q1lfG1v8DqCMriLl+f4i6r
         59xE/3NTb2fZQHpoF2Suj440KEqZQtHdr1qapR/T6inl5mJPkceM+821tr3Q17JlEUAF
         ajBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587638; x=1759192438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=f2F4dUIqNM8u/Qgqa4hWI17l+LgxGU38Lyv226IUfyadk9sm8Oo/vhdYO3JNBmELTI
         0VpNYPG7LH59bSTPp+i6SPZurN6VFWQN9EXN94torNNoPhMibcc5CSzlkrAlNgjqNITO
         VFz3hHwHzob9g7CwlhdZg/BPvqQ/liYxCTjL5j9ulUFBSs5ea+mhh2yYlyuqCsqY2hBV
         b2Q4KytKTUVE5Do0XCAt0dAJhhyU+bjT5iZww/AH15eKZJTS7TI4RjdPjDP5UeCmJZxa
         ZwplKYKIBDr+vz7HDnlpnBk+sV0VfaZfjC8iz1GTXpodS8CPd+oCEv9P8nHmGHzlgC/s
         Y8lg==
X-Forwarded-Encrypted: i=1; AJvYcCXnzi9LCR1u9Y1nhWWjso7CfeU2a/B6cHJ+ZxrklVJ8OA6X7Qa7Sjqdy9pawqmscs9Ijowd6qDAlPcEO84K@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jzaNp5m/0i55ElGwqJqRkaWOMB9RPSuopHvWRm8KxQM7Qhse
	LSwGMYtA6+s4aDAmSad96ds8E7CnZ9Wp0ERVpoHYIV1HWnpQNV8VG8iE
X-Gm-Gg: ASbGncvVfNP64UVqk5SXDtaCrMZf1uoL3gHS03x7Cyo72T6KpW9hNQ3SIVh/Mpz4tsO
	4R85SLguKlQ+8HwQcYGc4PkiHjRgQdhheqvpy5TUWQx5oIlKK1sJsTOvvoLuA1TmELJ0CGQjWdx
	shkTj4lwV5YRiIs2jYbh8saxgTuqqKzNhxcMTDdsCjdkHTtZFbbSz3rOezSjfdPP0u05Vvnm8om
	3upJDHPmBCYts478hTUqim8NGrXv7BYwJIuBsYG4MDsgS+r+aoURKRc6cSC0t6sIZJthWl2VK3B
	cbAfdClmYEeL9o4tj5VkMhqU0XYZi5vL1PbR+VnEG2J0LOWYzejOYKJNOLtofHI+Ndb0ISYbZjO
	Ti3Dp5cESbK/ErHZZ7efVEKPVW9plPrPojppR/mOgzHAcT7No5w==
X-Google-Smtp-Source: AGHT+IGQISl64Y5Qz4l069Hr+dg6JwXOBP5WOcZIs2GDXy1YtKD9sDPga2/FeznyhaigCtWuIUSimw==
X-Received: by 2002:a17:903:46c4:b0:267:cd93:cba9 with SMTP id d9443c01a7336-27cc696e79cmr8418715ad.35.1758587638366;
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053dd5sm145263185ad.26.2025.09.22.17.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:58 -0700 (PDT)
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
Subject: [PATCH v4 04/15] iomap: iterate over folio mapping in iomap_readpage_iter()
Date: Mon, 22 Sep 2025 17:23:42 -0700
Message-ID: <20250923002353.2961514-5-joannelkoong@gmail.com>
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

Iterate over all non-uptodate ranges of a folio mapping in a single call
to iomap_readpage_iter() instead of leaving the partial iteration to the
caller.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b06b532033ad..dbe5783ee68c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -430,6 +430,7 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
 	size_t poff, plen;
+	loff_t count;
 	int ret;
 
 	if (iomap->type == IOMAP_INLINE) {
@@ -439,41 +440,35 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	/* zero post-eof blocks as the page may be mapped */
 	ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
 
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-	} else {
-		iomap_bio_read_folio_range(iter, ctx, pos, plen);
-	}
+	length = min_t(loff_t, length,
+			folio_size(folio) - offset_in_folio(folio, pos));
+	while (length) {
+		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
+				&plen);
 
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that, we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	length = pos - iter->pos + plen;
-	return iomap_iter_advance(iter, length);
-}
+		count = pos - iter->pos + plen;
+		if (WARN_ON_ONCE(count > length))
+			return -EIO;
 
-static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
-{
-	int ret;
+		if (plen == 0)
+			return iomap_iter_advance(iter, count);
 
-	while (iomap_length(iter)) {
-		ret = iomap_readpage_iter(iter, ctx);
+		/* zero post-eof blocks as the page may be mapped */
+		if (iomap_block_needs_zeroing(iter, pos)) {
+			folio_zero_range(folio, poff, plen);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else {
+			iomap_bio_read_folio_range(iter, ctx, pos, plen);
+		}
+
+		ret = iomap_iter_advance(iter, count);
 		if (ret)
 			return ret;
+		length -= count;
+		pos = iter->pos;
 	}
-
 	return 0;
 }
 
@@ -492,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, &ctx);
+		iter.status = iomap_readpage_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -522,6 +517,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
+			if (WARN_ON_ONCE(!ctx->cur_folio))
+				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
-- 
2.47.3


