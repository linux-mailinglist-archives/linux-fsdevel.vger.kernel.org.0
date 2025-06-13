Return-Path: <linux-fsdevel+bounces-51626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E259AD97B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F78B1BC2490
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7FC28E61E;
	Fri, 13 Jun 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo9w2+Lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0C628DF20;
	Fri, 13 Jun 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851454; cv=none; b=Jc14lL1mbNJLvBMYOSj9/4FjFNUU5tJpOOOb2lNOsJypPtE1+iYSCI/fWMy6Wr+cMetgWbg0X0cBtYF7reW2ChvcQKoDHnsymgFfMkilFKNDo5n/dFwoK0pgwEXRnpordDkbq9QtklDrH6FxS/io7zpcvbbDy9A0XZ9HK1lcuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851454; c=relaxed/simple;
	bh=F4sXzGZw37iQoA5DeQQYwhDoE+Bw+JWBMmnuhjR7kr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFZsaSm1NCshlrsytv2FQoeifk9FZ85uLFVOI4bIRGZfrfF1tXWf7LzIP9qSFvzG4iezlKAra2THCKzmg0ofMMx2LmLh6HPMDLyI03bZMZzqYGPWRVkgumGaV2+6+L4EHwM7k3mEBhPTrPpCQOjrWm+I9AKqutMmUH8ljM9mQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo9w2+Lt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso2831703b3a.0;
        Fri, 13 Jun 2025 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851452; x=1750456252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ3lYHn54c2lYHHZQCO4xgP1CbUP0gqdxX5aXC7DX5I=;
        b=Mo9w2+Lte80yES0/tQq13BOJCxUiq6AZSOm9DDB3wMnBE6nyB6EHcPkUE8XSeDH1cZ
         RoeiDAc2mSv5cPkVF052125SteeVVv0Lc34Y66eHtUaCG15joAwbla3HpB2N8arBfGcc
         BouAcboFYi/zW68pA3i/FILDbnRl4yfhH8bmrRGs42J9ei7pr520lMQYVAXko39Cc+9W
         8jeGvP+ceuKrds+p6+9S8fmjXyxsLSjlUX0GcjGXAdZ3KpVy7PIOCBHtyAX2FZuC603E
         WO11CEmBDrWvMfvzN6XJmtaogA0yMzXT6LhuscsodMSXKeGAyKhl9vJBQsWyLGbP96Cw
         sX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851452; x=1750456252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ3lYHn54c2lYHHZQCO4xgP1CbUP0gqdxX5aXC7DX5I=;
        b=h6otuNYsUotr2bkVxwO3EV/oYQ7UkTg6DlZxo5sT3iqFOVBsrkKpj9FXxRjNTWLR4t
         kbCz4TH9jbZNMaY0TA0CMtUnIX0p7dw0YePlfp/HC8uzendFUALmRju9SZY3C4x1zZpd
         xTORmsYsqW/uIqTXKcUX7Gzgx0qlS69/NPk5QctzJd5S0zj6WnN4rQ8JGLDHIlRRw8th
         7bK+yVHM2CsCUsJ+j3NLiLDStXaVjUwqEdzGmdd8P2Edys9YzDnDvJMDAadmZj8286d5
         ohkv5/gaPjGpHb+IGq54tooOv5exvQvMeyo8cJwUMnhpX6EFHEewz3BtBLMBojj3ouK6
         Zobg==
X-Forwarded-Encrypted: i=1; AJvYcCXylAsdvk8aSyBMKKxSPwHkY6a2SjezAvudoe2SLq2JWtDM0V3xVqnbQj5u6Bz4BzSbJxxeG9IBde8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGtLMttOw9Hk5hK2oMZoY0OGFUDXHnklp9Cm4QLxwHDFhhYy7
	xMlxylv+3zZdS0O45YmAA2a7m+G25c04c9pRO7NGACHaFKDJB7AHSDLWxU4UMQ==
X-Gm-Gg: ASbGncuEjTX00mNdSUYTexzMdMPsorOWJKmCNKl14yOwr+iWFZCWdW/WJDgsCTH9KTU
	KwhQtKBewVEbZ+y7zJc3sDVut9Xw5O/nIPgMFCqYsogcxXLnZYAvsuGO7GYvY7B0niKokPzW35f
	qER7FOVoD7i7qw+xyL+QOymesa3DXXn6ZuHfRqb7oj5+RDT2Quq4AsAneW8tEQBcb7pyP7tmj2R
	hLcADFDX8oz9w/z6mTuuP13SkVWr47ZFl+FnuPblxe5qiQyzGaHoS/ueHMXeNWOaKNINTvEhFJO
	d19tCc3DrCWiwXOTyAa+ebPnywC+5Ie4S1tZBlw60T6cjs9/amFWCNSOgw==
X-Google-Smtp-Source: AGHT+IG0HlLxWJiHmBuSs+Xdq5ajT/OxM4mOnVDLsdf/DtFMqgpezXo3iYoyN41Gs1T4jM309WcYBA==
X-Received: by 2002:a05:6a00:ac9:b0:748:2d1d:f7b7 with SMTP id d2e1a72fcca58-7489cffa98cmr1297415b3a.21.1749851452310;
        Fri, 13 Jun 2025 14:50:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b1d95sm2132211b3a.120.2025.06.13.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 06/16] iomap: add wrapper function iomap_submit_bio()
Date: Fri, 13 Jun 2025 14:46:31 -0700
Message-ID: <20250613214642.2903225-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper function, iomap_submit_bio(), around bio submission so
that callers that do not have CONFIG_BLOCK set may also use iomap for
buffered io.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 5 +++++
 fs/iomap/buffered-io.c     | 6 +++---
 fs/iomap/internal.h        | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index 89c06cabbb1b..d5dfa1b3eef7 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -81,6 +81,11 @@ void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
 	}
 }
 
+void iomap_submit_bio(struct bio *bio)
+{
+	submit_bio(bio);
+}
+
 int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap)
 {
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9ce792adf8a4..882e55a1d75c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -388,7 +388,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	if (ctx.bio) {
-		submit_bio(ctx.bio);
+		iomap_submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_folio_in_bio);
@@ -460,7 +460,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
 	if (ctx.bio)
-		submit_bio(ctx.bio);
+		iomap_submit_bio(ctx.bio);
 	if (ctx.cur_folio) {
 		if (!ctx.cur_folio_in_bio)
 			folio_unlock(ctx.cur_folio);
@@ -1463,7 +1463,7 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
 			error = -EIO;
 		if (!error)
-			submit_bio(&wpc->ioend->io_bio);
+			iomap_submit_bio(&wpc->ioend->io_bio);
 	}
 
 	if (error)
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 664554ffb8bf..27e8a174dc3f 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -44,11 +44,13 @@ void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
 		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
 		loff_t length);
 void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error);
+void iomap_submit_bio(struct bio *bio);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
 #define iomap_bio_add_to_ioend(...)		(-ENOSYS)
 #define iomap_bio_readpage(...)		((void)0)
 #define iomap_bio_ioend_error(...)		((void)0)
+#define iomap_submit_bio(...)			((void)0)
 #endif /* CONFIG_BLOCK */
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


