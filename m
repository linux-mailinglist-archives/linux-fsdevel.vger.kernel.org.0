Return-Path: <linux-fsdevel+bounces-62450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03371B93BA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAF62E0D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 00:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CE221578;
	Tue, 23 Sep 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQg1+N+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CA218AD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587651; cv=none; b=jvr8V73twwXSqECCzlSIPv9A8wsrrnH/IJrjdfG5LRunZX2KUen6OFDlfuX/KG7Y8W9Egcgla979kLu4iXtNqtAa2VtvkjvF+Xy1vUgszqTSoNFGaWjWjt/pxJciwQ5RXrMYpFVHMRPFjaaFzmhBdfhOWY2jEiMYEo0PPtGvFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587651; c=relaxed/simple;
	bh=6gl5Z+JZLYv55qqXi1LyVpN6JlxHo4rap/E6cwLJcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/ocHnnLHngy6ZfevgdQMeMyqhWbQspzvjz+Z1Xj8GM0JO5Emfw+pu8X3UGYR+wVvs3nqw0B3hB+x6gC/6YnpoYokn1yp8RcV/tbKB1bdR3S25IQ2XdI1vBjM/a4fDkaJ7nrTfF15YXUZnfmiiu3L3Xkr1miEosh2qWG9D6tYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQg1+N+I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so1777520b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587649; x=1759192449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfDhWqoAEKFVOf/mlnVW8HkSqt5eAKrI9BC9iX0QNTA=;
        b=VQg1+N+I6wgsWicFvuceUi3taXEX7Cl0HfJPJE38vcy02wS6sCakS/hxZtj8R+zidX
         9pgie9tLnptq1T5yuBaDarZ/b7b+TIhnoHx4zjaPPWBoAFHeDpO2D0j4kFAi3npX1JUS
         y9EryXy8qmfWMgFUSAyQhXlIY8jAHFMSQwzhgvoyswQN2yWBHYmCAzO00VvAHfXb9oFB
         8Ak0f1xuLZc9UC5RM2f5Y/1Ga1jWp+0oeiIZLQG6xbtUd0T7HeauNFMbKKEoB5Yq9YBF
         ufJN43/LEqAn98LrbQoSaAfc1C/miwwebzbhWiVrIlT2Ztwt8YS/U7quNL0yOUPB+lqJ
         CASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587649; x=1759192449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfDhWqoAEKFVOf/mlnVW8HkSqt5eAKrI9BC9iX0QNTA=;
        b=p2PNvKW0eAjvYbLT7o+vpS8JLvYsx0W1gvmHI1zgeWiVU4Qouwr51Y2lI+MoV2tuPv
         CYV4iWNPiNO64lH+ZoAdcO+CJsKKAUmMfQpJSvPqBv9rkGEPRJm97n105f9EBpu+ezHN
         QMIC5WLCUfDPyj30KapZa2Rn6urAmEGYDbzUZlMNwT6Z0f+E7tCi89yhqr+tLQHArX/X
         Q6MYWvB/3gWxdyUkZ11mnHAxA1TPG0RApejbI/t9oH9nkWn9df6RVf5KquLW7z/lT312
         GkFFGHqgFOPOYqXcfhewmcl7/5iq77wUtZsJpulDtxWWxLWhwwKfXG0ykOI2TXI6gkNR
         /hCA==
X-Forwarded-Encrypted: i=1; AJvYcCVsw4Ya8XnGjhouhwVphQyZ1OxAiPxiAFVUobv/o2WtI8GmvskQyLgua9u1MZDKZI+9k9jUq3nuFP5eY/sU@vger.kernel.org
X-Gm-Message-State: AOJu0YxuamwPLSyVTfPp0/dzcruRF9LxEy3RLQbrDkhbabA3YEqRi27m
	eG8lvyOD2XNPylfkKmmCRTON8GT7DByB5+CnwbAs3JTbYB0dZ2CVAkqIgs/AKw==
X-Gm-Gg: ASbGncs0d4ZIiU+Tq7tqMUeBNRamMO3q4B+HC8/sz75L1uf6XCKRGBPc455HPwFOnEd
	WnKLYtfuUEmKOSXcyNAve+XbKwtfF0XVBdMMvebpXY5teUnw95u2kwKKwKUBNYb81t7TsOogryj
	uQ2fKur2fU2NfoI3ku3zretyQ7SRDFWdn4AD/+J/3AtbWwmHw+vq8WGmrwADcUYiHw2/kzpj+9s
	rKMtEOHOuc6L9dHi59Ri1bzy077ZV1ZhWcFCe3ZHt5rnNDTQRYiC39+++iPyWAArleoZoRxLQMq
	Vezg7ckWhxOpJIgMaQlCyk3K42wDStEK3YO4+x5Hp8LyATfJApP+T1iTnpuVVa3LZugOKmtNsEC
	L1NQUVNcDzEILFwna98tkuh5T7oMNl5pf/WdgItT+1grK2kYS
X-Google-Smtp-Source: AGHT+IHwN6QET28Com0mnDzTsPnGxiZ9CeU+qh1qBSs7SYJ7KF36Ej3bcT5nNRqK/1il2tMZr28MWQ==
X-Received: by 2002:a05:6a00:4fc6:b0:77f:5357:2c07 with SMTP id d2e1a72fcca58-77f53b64b19mr919389b3a.27.1758587649243;
        Mon, 22 Sep 2025 17:34:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4fd7223esm1127430b3a.103.2025.09.22.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:34:08 -0700 (PDT)
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
	kernel-team@meta.com
Subject: [PATCH v4 12/15] iomap: make iomap_read_folio() a void return
Date: Mon, 22 Sep 2025 17:23:50 -0700
Message-ID: <20250923002353.2961514-13-joannelkoong@gmail.com>
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

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ed2acbcb81b8..9376aadb2071 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return 0;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -481,13 +481,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	if (!folio_owned)
 		folio_unlock(folio);
-
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c1a7613bca6e..f76e9b46595a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -338,7 +338,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
-- 
2.47.3


