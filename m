Return-Path: <linux-fsdevel+bounces-59687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E84B3C5D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D3177895
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A902D876F;
	Fri, 29 Aug 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXioL81U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA282345726;
	Fri, 29 Aug 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511907; cv=none; b=eSAv9IyIXDB/Ck7hUN74mWhk+ODUnQRfDT7bnmBzHzkctvMrjeQi514hSEjeGz9U41Xgdw59Lbsa5HUE2qyXvAOjVYPhFc1fygtxPCjfSXPbTfVqkhoQA/3tdzjZkn4aU1cwANP+08M6dAmxX8L9woZ1dN6fFciMh8mfEtuh2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511907; c=relaxed/simple;
	bh=NFTpp1UGqn4SkkijOkfFZ+sX60fsYTmhb+28LZUAp74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMnEBUv7JAl0F4AugPdy2bD+qYQeC1N+rOW4isfRpbPExOmAdOQBEypGz7j+hmddF+UXjerEcno2+k+li1XcUUloUCzHJcvkV/tg5NeElO759cBf3+Vvlx1H2LoKQDbI+Fi/48LlVpV3wjXKWfaWnWGG7hhdG2U6tXKkT5rTrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXioL81U; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7704f3c4708so3158470b3a.1;
        Fri, 29 Aug 2025 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511905; x=1757116705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpVUrBTL8tTk5b+xFJjrEm6dBlMYCUIk/rqKLsUjKDE=;
        b=SXioL81UMKHvOs58q6ZoWsktIwgguNqD/aVRoW+vrh5kUXIMbv2hc/orrCWRuqaNbh
         ck7WeO6V7/SIX8+FjaRSpLjhHFSQt78KVlEtIxved1i7MyTgx7VS0wsNd8xCYrafZ9UL
         r+Nby8EXPGzzMIQAecIkR19H7+021/AVJqZwPQXK/gMslIlroPwQfS9gp9jtU92skiRp
         x66pPA+S29kL0OzcThBdtuDma/2CRE9REcncPdFQyDWzF54gXLHNhpMeanYpv9qNwz6Q
         9hstbwxzMSVdBZCuodTVSCy9/pouK5jmdljOLyRXO0qhoF3DT1l2n3lv00gp1Xu8tK/Z
         TBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511905; x=1757116705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpVUrBTL8tTk5b+xFJjrEm6dBlMYCUIk/rqKLsUjKDE=;
        b=G4/s/s5HWDid3dEGRmzzNbFC7PdEwFJg7mRqcOQJlF1MEGCdatjnLwaebjgTYhONDH
         U9fZkzIYF2j3TYac4ovVYd7ah3mXIdC78GJwkDu5vBN3EQ3x/LfuIeaft8oIdYr7WztM
         FeZaZTzDBNMNjfTMCs61ATOw4XRdksAwJhKe5Y3VtiDhBuNR4tWTdexf/vXP91AAN+SO
         btMgMLmKmvZBSSIkc7sJs/azvEPs3sy3WN3rHtF830oFPscDJA8BZ05HLfq21UAZOh16
         c/S8kkL7Jnn2RE0Fc8Hzv/XvJAQjmlkE+1EWXTagp+oqrWiqrnrDAH30JeXD9BWtv34A
         6vGg==
X-Forwarded-Encrypted: i=1; AJvYcCUslc0VZDOSpnGrsCu8ORQx5dtQoIzmEjX+ADpiaILQgGCo5H0yaPlXcirt8kedAU94afcKU/wrgkzM@vger.kernel.org, AJvYcCVRjv072jGI61DtRwEU5ObDn7Ro95Qnrugckf+WfMm5h1wiZ5uKDK9i6I/3eNG8GcO+bPi6Dhsopn0=@vger.kernel.org, AJvYcCVr4hUl/93BeSL2AejEAQqPeqb06fNQIubwY6XT9duZdr9XoCrmjeNPIQlXDW4+k1EiTOtxvFBSgkk5f6oRNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeso/X6aNkt6qONksK9v5vjUqlmodsGH95FHIKqMk0D2az/lU5
	8YgjC+6fTizcoPtgsmRL1MRNs9e+4pMx3MgoFP9zAH4O1u69olp5xgDh
X-Gm-Gg: ASbGncsHoVrmOAlOhK52j/7L4moXFw3PMKOongYuKPewYsBACXra4a1Keg/5KavA2kR
	sOZVQI3V0Fvpq6qwlofJesMIGsNI6K6gWUT5tPOWwe6K7G9CTBtEGrFLstacRAk+dMFnPFqMFa7
	nAbeilyV5ZbfDlWceEP++5YLsbEzWgjsVeyGmaL1rL5p3EoqMAdGWg5nRBEc7Ht2BRGk19YrWSC
	4JTSAcbuJsYz9vMf3zPXjdOf89LZ71TSrkJjte9Eg1z8zXvtOlb7rrCL/Oa6IBTQZbQXs1pLnCv
	cfn2MZIVpuLlFaFNPhudYpguKaPqSLuL8ZjjGCeQbAnkOAKSUooyVnTkvqZ4jdbxjJlQjb25KZj
	IHYox8jKDTIXj4zN0OsadnmStj14h
X-Google-Smtp-Source: AGHT+IHwAxSykgXXOv48JaL8csLHyeAGCLaALSXSdtfig0O32TPebehTjgp1a5Xrznsga5/ZgBwm3Q==
X-Received: by 2002:a05:6a20:a11e:b0:243:c5c0:9c3a with SMTP id adf61e73a8af0-243d6dd0c97mr607968637.12.1756511905167;
        Fri, 29 Aug 2025 16:58:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a1b9sm3466565b3a.7.2025.08.29.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 06/16] iomap: move read/readahead logic out of CONFIG_BLOCK guard
Date: Fri, 29 Aug 2025 16:56:17 -0700
Message-ID: <20250829235627.4053234-7-joannelkoong@gmail.com>
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

There is no longer a dependency on CONFIG_BLOCK in the iomap read and
readahead logic. Move this logic out of the CONFIG_BLOCK guard.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 81 ++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8dd26c50e5ea..f26544fbcb36 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -317,6 +317,12 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
+struct iomap_readpage_ctx {
+	struct folio		*cur_folio;
+	bool			folio_unlocked;
+	struct readahead_control *rac;
+};
+
 #ifdef CONFIG_BLOCK
 static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
@@ -350,12 +356,6 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
-	struct folio		*cur_folio;
-	bool			folio_unlocked;
-	struct readahead_control *rac;
-};
-
 static void iomap_read_folio_range_async(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
@@ -404,6 +404,46 @@ static void iomap_read_folio_range_async(struct iomap_iter *iter,
 	}
 }
 
+static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	struct bio_vec bvec;
+	struct bio bio;
+
+	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
+	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
+	return submit_bio_wait(&bio);
+}
+
+static void iomap_readfolio_submit(const struct iomap_iter *iter)
+{
+	struct bio *bio = iter->private;
+
+	if (bio)
+		submit_bio(bio);
+}
+#else
+static void iomap_read_folio_range_async(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t len)
+{
+	WARN_ON_ONCE(1);
+}
+
+static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
+		struct folio *folio, loff_t pos, size_t len)
+{
+	WARN_ON_ONCE(1);
+	return -EIO;
+}
+
+static void iomap_readfolio_submit(const struct iomap_iter *iter)
+{
+	WARN_ON_ONCE(1);
+}
+#endif /* CONFIG_BLOCK */
+
 static int iomap_readpage_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
@@ -445,14 +485,6 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	return iomap_iter_advance(iter, &length);
 }
 
-static void iomap_readfolio_submit(const struct iomap_iter *iter)
-{
-	struct bio *bio = iter->private;
-
-	if (bio)
-		submit_bio(bio);
-}
-
 static void iomap_readfolio_complete(const struct iomap_iter *iter,
 		const struct iomap_readpage_ctx *ctx)
 {
@@ -558,27 +590,6 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
-		struct folio *folio, loff_t pos, size_t len)
-{
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct bio_vec bvec;
-	struct bio bio;
-
-	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
-	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
-	return submit_bio_wait(&bio);
-}
-#else
-static int iomap_read_folio_range_sync(const struct iomap_iter *iter,
-		struct folio *folio, loff_t pos, size_t len)
-{
-	WARN_ON_ONCE(1);
-	return -EIO;
-}
-#endif /* CONFIG_BLOCK */
-
 /*
  * iomap_is_partially_uptodate checks whether blocks within a folio are
  * uptodate or not.
-- 
2.47.3


