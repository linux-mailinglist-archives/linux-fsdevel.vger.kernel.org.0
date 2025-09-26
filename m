Return-Path: <linux-fsdevel+bounces-62826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6417ABA2114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1904562782A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B719F40B;
	Fri, 26 Sep 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsXtOm4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD7187346
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846574; cv=none; b=Fm9X18OEFRKJIbt2O+/2v5dFvl1y+1rKKcuwypGI23Wc5JfppHpuDXZMh4mx+y0Vqzwu9+r3QtXtYfRqpTW7MGvhzRW2ka1J9AY5b/ynOZpHph15Y6PW0p4smT9bqrTWrt3TA1qbdfibOdyBVa6BoydE+oFJxbdkyBqqzT9xXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846574; c=relaxed/simple;
	bh=a/zyIEvLQc/XUbs4Regz+PNxwhBjl1k4o/jZih5gfXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9bFrDpjiPwM2oSSEZWOwSKtNekRWg2CMbkqk1jOTB3J239LeqaV2uRfnsQXBHNW27E4zTTH2h0+m78PFiTdAE7foN4vNbg6HqmatMwgEqMcAYRYrs7cqx9P28DcENnNPGJXcwuWsPqnGyq70sfkpCwfhRDsqUDDRJ0SHAt5RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsXtOm4+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3352018dfbcso893899a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846572; x=1759451372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=KsXtOm4+swYd1IuB+WbyeC/E7xFvzvOvg7u3ETbMc32wm6w0qRSsIhDneSHWExKt9p
         9jpI7mtjHbIzlTFC0shx7Ml35qVThjNk134ZyRzelO5jtfXDIO+HkO/JqXnAMq2YpclS
         QxOBb70CY3j1CKVBjsrDLViK4ZcvKcLA9yRhesx+kg42y7a8KFmKZd+IJk+odiP2Y1yy
         WgxFRTnDacqoSz0byXtc3imEBy+m2BEn+79ZXXnXitGvJEh/bKVTLlzxdeTE8Ljy6OVw
         571usIf3vXEYVtPytKDZlO5oKYOfxUwSxKaeJmUUL2twfrrmNnbAAKB82oy1t7wmwlpR
         J1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846572; x=1759451372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt8zIXCwfRruji0SsRLpuIon4IqvB5IR8pbhHdgxKmc=;
        b=H4FU9q07KoUJpKsiWVP8oqXznqLG0ojpe/dP2hrNV76fbDvGby/HtSsGCek/XkkSc2
         JvXOKkihCo1EydFjiQPs2jtOgFhd8N5+/tlA5uIFuqBduq3jgMf7i7H6l0L2VIhd2h/o
         gqC/WX+0sHcSD1VSS1+9DkRePe7cj8LG5bkjUbPJDMuCUumqMRhSZQ0zsXwPy2lH5rIK
         ki0sj7tj8nh2DmICajUSbepWVakjfQsmFcRn5rdWNcCbWPhBhnR4CFl21vtScBZU/K1Q
         Ycrh+SsjSKoh5nXt22n3eOqRKypSPoWZ1q3p/voHFnqKx5Dzjfro0tbRHtGRuTncYchy
         fwKA==
X-Forwarded-Encrypted: i=1; AJvYcCXzbwyUevQa2a7+YG7P4SQF4GpMjBg0QMJI504NWXDAqNdVOHV8/MTIJFcsLTdk6IqA/A+DZs4QHGOhPFH7@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlVF4v/D7uOMhPzHkdnxDpbyOIUvLJY8jd7FwE0rb6LiSPKwl
	JCYS8pdY8kYvO9foDuCW/64vFDiGNBm2R8lfyvIvzlOg0m8d0bdI/YG99wR1IA==
X-Gm-Gg: ASbGncv6vN3DBwN+MPmPcNpchc4h7pey7oM7Bu0ep02ChzGKlsLhxj1U3AN4EbmNjYu
	gTv1BDkKsJM+vQLOhYh7MYvGJ2nuuvKog0wgqAoDxiR+yPMbYq2j2tLdTzXeSAyBx7UHisucamo
	r02NZIUYLApFb1xUiWhKN8wj3sa4rifguchoLXChFvnsLyM6aPJzgINizleGIwOvBWkNQDdoC/5
	Qemj+uV4gnjoTRyBC8L/8TXFEKGDagEtV5k2eP9pS8nHS2WiUWrlytMb139lRuBhRgqytzvyNX4
	sFAc9ETYA9R08CAnoJpJmr9TrkB91tIleCYXxMXpKNiHTGZ85+01r0eE+TlmO13TeF1yzfk83CF
	4WyzGQ3gI008ssbvdNTCXL7dPuk5QYrnD47mpr+m4oyftD2dB
X-Google-Smtp-Source: AGHT+IETu8Xg6FKNcFj6KdxYVe833AhhKxJaGKFG0k6oD3PiYvStleW8dB/qiT8f+QPOWW4g7bx/lg==
X-Received: by 2002:a17:90b:4d82:b0:332:afb1:d050 with SMTP id 98e67ed59e1d1-3342a28c02amr5853259a91.14.1758846571573;
        Thu, 25 Sep 2025 17:29:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53babe8sm3275923a12.6.2025.09.25.17.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:31 -0700 (PDT)
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
Subject: [PATCH v5 04/14] iomap: iterate over folio mapping in iomap_readpage_iter()
Date: Thu, 25 Sep 2025 17:25:59 -0700
Message-ID: <20250926002609.1302233-5-joannelkoong@gmail.com>
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


