Return-Path: <linux-fsdevel+bounces-60583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9342B498D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C986B189E73A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB031DDBB;
	Mon,  8 Sep 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUWpQXMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428F31CA45;
	Mon,  8 Sep 2025 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357541; cv=none; b=LRR26dtXxGq4Yuye/ufriIy+pV9YDDjmcMMUxmAp0mqgqUR2w4qXRF92JjQC/46JVtZZaGNFlzfCjaCT2C0YXx9ouEDOgEJP6jJdyuuvyX9PijfYy/f0KDVZaW9tV+e6E2oH617ufdbNTIQ77qYelTQBoClViGW4ZkaQgX+gGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357541; c=relaxed/simple;
	bh=dmjQNCdEMtXZ68orYoy7VaC5n4q3qVKlf0rQscQcUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdNqviJfAZ1ffsOjT4NCxGsABSjjwQgr1LANlNdM67Dzwfsx9Q/tXgxdkI/m2ff1mNq/hn0zAxKsUSfUfwHmt6K+veWXLTvBkLR+MVpm//BogWjU6ynrq/mNkHko8/YnC/F7B92dtx9O3f3+oodG2XmWe3AMaH+VtXX7/q5uxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUWpQXMy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24c784130e6so52534395ad.3;
        Mon, 08 Sep 2025 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357540; x=1757962340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX+m1+nAD426im6+oubkUf1KY/aIRrScfpZiZHj8kyc=;
        b=HUWpQXMyjF3y5FqwoG/KWagGh91Eiw/yeAx0oypoMaocG9UY9SvnnJ4b8wC/Jf7eDU
         L9WtcLY9DQbb0PdIIpkmgDte9LCe2jnZxam8HwwGk8pKmHNSt5XEzTadDKBZr8R5kfuN
         ToYji3Fe5hMIxFFzLrmZVtN9w6NAxurR6WnJ0bh+2hdhKbrwZ/9hkIdRzkqdyOoMvGYs
         AsTC/lw1v+OaylBVElcYlArzptTgXHSjyhe2Hg3+sd979mED/fLSE5HrzelKtuIdGphT
         1gifRgBp/QZ1ZlCgVmDEHntDO37nsmRDGV3ENS+8KbbZ0eNPk93SjA0clmqkVld7bGuN
         7Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357540; x=1757962340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX+m1+nAD426im6+oubkUf1KY/aIRrScfpZiZHj8kyc=;
        b=EhcOcrSed1UXMlg28ZJpDLaKZSi2fbtSwMqoOsON1L/V4P5+AwhfJZpw272p6FBWLW
         P4+w3KGIBMvzrpQaVky7X1k5ZzdRxq51mxkDlf7ezGfqTzQ6jUQQuPQQN/pVcQHSAnST
         kuMMvH76Jl3FW3mf5KTWHxDLVFHpACZlgmRZr2ki4nWrBChBXnLmBhhDWSsRW8usEQ2R
         iYYwTbzl6gYzA4WRqASRBL12/Kq7hK0mv6SrQLRXzeG7HsJGuUGunYf6ZkzIZu78xRea
         OZgiMLJIrVLG25OwIhJfX8YIe63t27ch+p/s3AgMpbsBgRtAqB7a+laDuDFCEFym+w+k
         RYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS0F2Mivhd+YW1C21prxMiDePI6P/QsU/lmwqR0hfBAiLkXsKvW4j5Lbv4Pkw0x7UA5zNOUI4H0Yga@vger.kernel.org, AJvYcCUl04LVCRERVU3kY9Az7588q/ReJ3pkXdcomSAoHa34OWITzEtaQai8gOijX2JwvegjHyL7tYUL0+5l0ppefQ==@vger.kernel.org, AJvYcCWgYEthFoQqogdwT9XD0Mmx6+UiDhGgQxhxl/c7yddrjg2HUSQ1AEzsdHqXOSMdorFNZaAQmtHiPwym2A==@vger.kernel.org, AJvYcCXIKP0hXy5zboDJwPpuYdZwjA2OgPDqY0oqBlggZeDxmXAA9tE4Y6lBstCOI/vc8T2CATR2ZTDM1SLr@vger.kernel.org
X-Gm-Message-State: AOJu0YzpMPF4wtPPeAHNjhsKAA+BQo08NfV+UAMzzPSyuMKlXm85e4zt
	hvc7GygY8jJF6frnBPONahHTG3GWSdQy0s7yDpYqQNEV5yOzidsC7DAc
X-Gm-Gg: ASbGnct/tgn9DtLE9wYr0N7zyeVTL65cwn1rkGadxbXMjY9gfrgv6einXLMcU1bS3dc
	nXivd9UID+wb+eYeeiTubXBzl5DKd4XSWJJKFCfAqHeixlrPLC/aY0c9YFKbo2/D11N2/UAgIXx
	2FWPpdmyLGDwm5hcPQMELWWOYPAfZXsCZcEfz21CRYdbOZtjcscwXRzkqUyMdzlukyB/pzEkLVz
	VpH7ZDZGvYJEz5N/k6EPXDzc6bMiOPQu/C5NDq+NONMRrREklErlE8FEue7A5evxhMrcJR8dTXz
	6cwzXtrWQbo/ZAU3XVoSGsuFbprCb3Wbcs6RwW1SeI+2zFfW9DP89N/V+KIYKfGaqTs8eyvNLzV
	VFwwANn5MEoSmTSG/NXz39aIpPqsn
X-Google-Smtp-Source: AGHT+IGMIOa4tR9asY85ktd8K/WzmNPGqpzx3UT2MHs6YS3aCfimlBQ0a6hVrfam2YKMflIzE75mLQ==
X-Received: by 2002:a17:902:d505:b0:24e:8118:cc28 with SMTP id d9443c01a7336-2516d817d4dmr125296655ad.11.1757357539540;
        Mon, 08 Sep 2025 11:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b790sm150291985ad.67.2025.09.08.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:19 -0700 (PDT)
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
Subject: [PATCH v2 02/16] iomap: move read/readahead bio submission logic into helper function
Date: Mon,  8 Sep 2025 11:51:08 -0700
Message-ID: <20250908185122.3199171-3-joannelkoong@gmail.com>
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

Move the read/readahead bio submission logic into a separate helper
This is needed to make iomap read/readahead more generically usable,
especially for filesystems that do not require CONFIG_BLOCK.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 13854fb6ad86..a3b02ed5328f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
+static void iomap_submit_read_bio(struct iomap_readpage_ctx *ctx)
+{
+	struct bio *bio = ctx->bio;
+
+	if (bio)
+		submit_bio(bio);
+}
+
 /**
  * Read in a folio range asynchronously through bios.
  *
@@ -388,8 +396,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		iomap_submit_read_bio(ctx);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -484,13 +491,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+	iomap_submit_read_bio(&ctx);
+
+	if (!ctx.cur_folio_in_bio)
 		folio_unlock(folio);
-	}
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -556,12 +560,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	iomap_submit_read_bio(&ctx);
+
+	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


