Return-Path: <linux-fsdevel+bounces-62824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CDBBA20F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBCE626F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9064823DD;
	Fri, 26 Sep 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmmG5T6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43016132F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846571; cv=none; b=ofTtMGkluyVbMQoAetTh8zu9++kIfmsgxVHoJh38asoAqwBkNpdVuyOEyXO3HyL9ZQNGw01lXACU3Dyzb4swLCDQ8IveDSFBfIzxpfwIyO2159NDmOo3wwppm0Tz2yd4YbII9TizieiewqJEAkQZSeBOvNbsb+SZj3dTcoJFcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846571; c=relaxed/simple;
	bh=EIuqb+bEXzHKheYSg8/gT99wnpLEGYyBUdzthx12unM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ0BNIdu8U1uuHqGP2/3NXEc+1leIFj6CuzWhQTfA/nvo3dzdSooK4w8pVtSVPHZLPxqAuiH/swdTGay51pp4deBzBqaGp3ho3jkKjF8ugG77CsZ0h4VKaJUghiT28GzdpyWIFQTd3Ftzt0xF2h6GRp01xrhF3z0FWEzC35KZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKmmG5T6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57f361a8fdso195977a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846568; x=1759451368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=VKmmG5T6vkrGY2k7DgKj3GuReAhB2ZFCsDa3KUZ8TFL7rFaKQuyrHXDz8mbPBOt6Jf
         03BGyi+O5o6AE5Iwqa0kIp8WT0biZHlMveNf/DC0IpYObOlTwvWFfpzOZugLqC8pgl62
         3bgUKf7AFU6s0doBeOgvgXMY15rcc/m4Bn8C3rYKXDmEqqxheTJdfnlxStA8WKnxcp88
         kiS1h2c4xpArrG2eUJf+jYOXegskASvhokggGr71e7sBJmA9TLjgWeQgdud0IUbAZJSo
         0R4AHa1vucuaIRvyeo0JDBMGhB8Bjd3K958lRZtA8/RZ2i6WGmkMGsXFVYmN8BdcqPUP
         3/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846568; x=1759451368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vApv1A8U/+p+Slbx14eQKwBqtf6JexlqDhpDLkVD4XQ=;
        b=dqiFWc/rJnKKBNm4VgG/yekr5rKVQaFt1RYnJMe9zH9XT7lkgsGSECFF6tTtYfsA55
         SxpgOrKfQe3hGL6CdGClzMjzBZFCadrzu9DAKrUvoWPS5TYVMgpmgwNzMZnSKv/EIk/G
         9WdnSNFAj8Rb7Ax6I570ngeUyRBC2NXCNu1EBpCwY2kFNO+euOt5qA+jwrlWUllJ/HZm
         hMvyOE5cnvfXmVbP8gdC6TVT401rO1OZFrznnP2X0PNXXMtZpCc4vxczgOOHMfDCUwFj
         ZKd3Wf3xBB8/sT0kfcibcxqwcYQtmvWFK+pmHP6n4LUCXjE6oqLs/bhCiAvdT2dWi211
         O3+A==
X-Forwarded-Encrypted: i=1; AJvYcCXSzn0lxkXfy3ia8D+5g1K/eLnMHqtsDyeFwPime12jAICFqoFaqNQ0P7Muxrx6QygbFVjUoF6YsyNXknV2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zJia5sDKYY7d99YRQ8u5ZREjsuwvLOg4qqi7ZenLHUnNQRIJ
	QXbIAB/ydXNhn12mj8o0xWIZiYWj10QBv4UfLwkJ4aborY5NbsDsifve
X-Gm-Gg: ASbGncse3oNcTfob9YyX95GH3gargMeD8uZuMQX/c1ku7Eou8+jZk5vjfIDgZtgMgvr
	1qnvXcfkTz6RFyixZtZiyPs0J0ZqmTO73+8N5f0sbL6PJcHVW9dX1EuZEAvGCBvfF5VGjw6F6hR
	fweA5G4oWl8M+y30HVFk9T2Rird3ODoKkecNNVSTqBEsslodJq/YQnlrZsGrXT9Z3cy/x9RFS72
	28ydV5vb64H3TYAZJzkIEKiuniuRb2qCNbqZ8H0TasXtqd+vq12Gg6pTg/fSz3QU00H6zRrFYQm
	DSdxW9w2HK49t5GLObRUIRK+BcLtGrcW2HRB9OWxUuLezNYrXPOkFJLKfvQscKvydDtJsZGwC9f
	u+B+4olKC5k9pUqz6Vmd8sMsChxhT4ev5UFs5HHxfbaeAbLBClA==
X-Google-Smtp-Source: AGHT+IH23dwF1NgLX5PleNnijXd7QbsowqYTMDXXK2Av0KZS7klqMtWV6FrRS8eSIiqXbBxh0MCuvg==
X-Received: by 2002:a17:902:d4c2:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-27ed49fbd2fmr63113575ad.18.1758846568053;
        Thu, 25 Sep 2025 17:29:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm36331395ad.30.2025.09.25.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:27 -0700 (PDT)
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
Subject: [PATCH v5 02/14] iomap: move read/readahead bio submission logic into helper function
Date: Thu, 25 Sep 2025 17:25:57 -0700
Message-ID: <20250926002609.1302233-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper.
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7e65075b6345..f8b985bb5a6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,6 +367,14 @@ struct iomap_readpage_ctx {
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
@@ -392,8 +400,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_bio_submit_read(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -488,13 +495,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
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
@@ -560,12 +564,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
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


