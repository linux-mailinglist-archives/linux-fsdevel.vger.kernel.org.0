Return-Path: <linux-fsdevel+bounces-59690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171ECB3C5E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556EA178EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CBF35E4D2;
	Fri, 29 Aug 2025 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKwIoPhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CA30F7F8;
	Fri, 29 Aug 2025 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511911; cv=none; b=gNIBW9tDREi0Cv3tWFlP4LCdZo1n+fSHlJlXEXDD2qDQmqY2uCY/PavTh5fIP7ZHBGrog4Ks230u7wLgWqajwqtQaAWw1Qyuo8Ed8I/AR5KplpbizCHcAh4vQYvzK/8GxsmSK29gJAxY6X6s/Y2UXNUEvdg1cOl78deVveG+/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511911; c=relaxed/simple;
	bh=7fOMmbxF/fYiUKpKtqR2F9mpaRVgbVrhOsNVD/j6WiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvNecogCrlxd0GYq1QxNjeDERnl4mSRiX8YU7s8NdUDXK5CgeNgRaCMzbfeSJlEGXO/Rg7b9vBQ0TZB5fWQD4ZX0ybGeUvzozjU/OokePpRYJiCA0+ryIRahddPb2j8Cu/aCLA8WgoCz0NdiZqPh4I75CVio/iq6dSkDUTh9NBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKwIoPhA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7720b23a49fso2975575b3a.0;
        Fri, 29 Aug 2025 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511909; x=1757116709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCVEeb4s7I8vE+S/JKRr/Vkyan2zMN6cRT8Ww9pBsq4=;
        b=FKwIoPhAd8M70mA2eraQq3iJDKC7qDacALERqHmeQzKzN9rNV8/X3SEgqjLYvD5qMQ
         ECR8hA1afiKZ/IK641jS/+ClDXckYKIrZqCJcPVuJqkOtcnvoyCVE/2VT/gJc4D6zc2H
         kYpudl+Wz+Lw1hszrTMP8c5qhD/dRw59inJiWiLCDskf1ANO99yrxa3z3BHXGclFXpko
         n+w6g9o7UhmrZzJ6HCO2htQdZ8oAeDaRk0LKhElCb/tUh8sh7ZwFk5qP9aoltN3CWclD
         bZqxb4+soipEceHYWEv3CI862YCa3TG2thRNY082hslzG9DC/mw8Alazd2116+EXaueM
         6N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511909; x=1757116709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCVEeb4s7I8vE+S/JKRr/Vkyan2zMN6cRT8Ww9pBsq4=;
        b=bfLlZfO0zgkufK4e15vLIdhDWlqQIr+Q900qUnM+ZjGUT6/8qwsk64FYENtWZft1KD
         fIsbiuye/pJFl0/EG5KFMaPk7q/W+SrCagcJzFDSTXstSej9E1WIqNaEhgmKLt67Kg0j
         tv3EI/et9Q+8lX6RRrsDr6ZXYnIdXxCxvoKzE6F5vldhZahowjI1OxxC8dHgVPNeY0el
         IPRBcRsBRRwIClq9Jud9TbatFIFnWvxj2cPfjESnpB/flR55k2BK0cpEhk8hUZ+K2d84
         LgSyzH7hOuvKe258SLYPhkGcBlqGrDue7OWt1ZVehgq7pOQ6bDEWtwqFbrPQN0lUZbcZ
         bcVg==
X-Forwarded-Encrypted: i=1; AJvYcCW5zDAmwASHvG8RWYQGws0KIc3cJfyFh2tMruOjDAeTlrbA0zD5nu342nyFdER9T5jXZgOMJLHI++8=@vger.kernel.org, AJvYcCXbntlxhMvkwGperFeoR6p5nOIQLzTGFhmWFC1sK8vbJoIo5rSmES85cIg0K0tyLoKOMhbGPwIQuJxwenMUDg==@vger.kernel.org, AJvYcCXjEDDedJHoECrBsiZa2GdwpXZrTkxFNJYYJxC0SDvHojQT3NtS9eZUuzlY6cFSYoVhtwCix19N7ID0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5tZffX68CcfUQsL3pAzafD0XaMNfOSOljPNvx21XgUmu+9Qc
	q789kk6DLB4QK3xNh76zTJZD3IQOFzvw9xilTRJR9aYD1Nre1husMZtY
X-Gm-Gg: ASbGncsLZaK3DzwVYsNXQ+RpwXmhoVaks1HG0R60zc9TARzyPwUGQHxX66CFW/sjM2Q
	hP1dl3AKFPIplV91S/MgDpysH8onDjXKd51SwiJIg8ILXuA11lNQkn9RG/x8fOIMCMuQhfelNSs
	gKIAG6btvFhY7PTMf0/TskUnVSdywkzhuZRFCMrzGJEZiUQ8FUsQ/gGNj2tkCMWCwoDfSylyAkT
	IFJif/mMGPd2M19B9fI/efXYPPLAvgAfybhxszPhJQ3tMMXxDF5K5QJyne7fUBs5glDBSidg/1f
	hUIuB6tMmcfBB1Trm9nGQ1TkjUrf8XeLWuOTU0tiTKyMT7y8wL9dugZUnRRRdIP1mfE57Ygis/A
	08HWDn8/50GPRYEyARxLmbUlzXJ2i
X-Google-Smtp-Source: AGHT+IHD5KtqAFXeKlNryny8k0PxgfPhQXXr+ooA6EqoSIlj1kD/PJz2MBUDWLU5FhSbZdEYpYnP9g==
X-Received: by 2002:a05:6a00:4611:b0:76e:7ae5:ec92 with SMTP id d2e1a72fcca58-7723e400e3bmr495284b3a.28.1756511909333;
        Fri, 29 Aug 2025 16:58:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4ba1d8sm3534967b3a.51.2025.08.29.16.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:29 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 09/16] iomap: rename iomap_readpage_ctx struct to iomap_readfolio_ctx
Date: Fri, 29 Aug 2025 16:56:20 -0700
Message-ID: <20250829235627.4053234-10-joannelkoong@gmail.com>
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

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 743112c7f8e6..a3a9b6146c2f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -317,7 +317,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	return 0;
 }
 
-struct iomap_readpage_ctx {
+struct iomap_readfolio_ctx {
 	struct folio		*cur_folio;
 	bool			folio_unlocked;
 	struct readahead_control *rac;
@@ -357,7 +357,7 @@ static void iomap_read_end_io(struct bio *bio)
 }
 
 static void iomap_read_folio_range_async(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
+		struct iomap_readfolio_ctx *ctx, loff_t pos, size_t plen)
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
@@ -426,7 +426,7 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
 }
 #else
 static void iomap_read_folio_range_async(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx, loff_t pos, size_t len)
+		struct iomap_readfolio_ctx *ctx, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
 }
@@ -445,7 +445,7 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
 #endif /* CONFIG_BLOCK */
 
 static int iomap_readfolio_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_readfolio_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -491,7 +491,7 @@ static int iomap_readfolio_iter(struct iomap_iter *iter,
 }
 
 static void iomap_readfolio_complete(const struct iomap_iter *iter,
-		const struct iomap_readpage_ctx *ctx)
+		const struct iomap_readfolio_ctx *ctx)
 {
 	iomap_readfolio_submit(iter);
 
@@ -506,7 +506,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_readfolio_ctx ctx = {
 		.cur_folio	= folio,
 	};
 	int ret;
@@ -523,7 +523,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+		struct iomap_readfolio_ctx *ctx)
 {
 	int ret;
 
@@ -567,7 +567,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	struct iomap_readpage_ctx ctx = {
+	struct iomap_readfolio_ctx ctx = {
 		.rac	= rac,
 	};
 
-- 
2.47.3


