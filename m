Return-Path: <linux-fsdevel+bounces-59684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4612EB3C5CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4BA1C87BFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA6273F9;
	Fri, 29 Aug 2025 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXDyLQ8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC927467D;
	Fri, 29 Aug 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511903; cv=none; b=jyeZIfLQxtALiJQKGPKMcIUoAD7K8taapdOK5Sj1FfEzG+c7SI2Ah/asrmFOzLZo/hQQpZgC/Mdnks5/2qsJ982zNeDYbXwPiMl/chMGdn7wn9vMvTNiPzA+xpgJv/WDaDezyKmTMYVXOTIHIPwSwTeeavNM7Vszst6L/Yn3ZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511903; c=relaxed/simple;
	bh=xUaksf2opwMJgwVohf2SNA3TTKbIUSswrCzMkgeR94A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyuB5Lgk5BM1NAS0YKFF8Ounr01Y4oX2gN06G5zOSvnoB1HP66GwcCbLYBzT7TVQkAdBH6ZX9Xn0gZIiZiyTT9xxuwm4iBFaxKYrB6Jjc70MyNjriJRvn8Mjk0HpmR1pj76n4KbM5pAsrykV7m/Xty/CUH+lKFvE9uYd5HCYUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXDyLQ8J; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so1095392a12.3;
        Fri, 29 Aug 2025 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511901; x=1757116701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoUwTHiMDsXQATLOoGThU9GnkJqeR9Y5ZzU1vTlEXR0=;
        b=OXDyLQ8JDWK3YNZzqxAzt2Eods3TvJykHcV8L1/f21XER31M2ikyP6504VDERsXn/o
         /0R1Yeqx31dFHosQDD7OIkQ3Q1zGIrCJ/4bRIqsAGIveLyaC5s3N2qRol5yQYMZvyHJY
         zNB68qRy4lIsRlw27Sht79fuQD/DD2I/yBfufRNaIPAYVC7bkE2S7GTYWjJrKobmFaor
         BdUxy5QZXZXg2I5SwN5RkWvVsmhv1NiP5iV/yjJky6tBqr6uDlDOoxL2DJATf6rJ3fLY
         KXPV7S9G6GTGeToxnSX9NjULDis7ZmwhVHi3C4bPKG+bUrgI9Js+rIi03IUDxBJ3N2C4
         skMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511901; x=1757116701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoUwTHiMDsXQATLOoGThU9GnkJqeR9Y5ZzU1vTlEXR0=;
        b=nJmIb+cwKaa9urVVVsVYnr+GpffklQTLPdcvCM5bSVGdZTtwG2eLCz0sO/4csAUOEG
         UvYNV0A6F7Ev0/X53I1/sqv9gxynXH9GxSLWm3KszA/ZxuYxSmaoKuQFtiFt7QDnNjN/
         59aiP/xg7oZWUq2ZnIINLvnEA82R9DwHISeQOjJPCoDNVTAd5RMAoS+9EiiYJaGNBmaU
         Gz6uuxjOMJANLDki9JMu5Dr5T6c6gHKJXL5n7ja910WpyWtRLEPgpw+0dI/e2vJYKtvA
         80YCqhguIzH0GxoIyQ0k/7Ip+uTc+AukjihN+TnTrsju/5BmIaZoahfrx5iRoHiiViBR
         /GDg==
X-Forwarded-Encrypted: i=1; AJvYcCVnQSdjgKRXo34xJLR0Q5vuF2tY9b4wICqgbC0DWaaUdZXIxambawf0DlfPnRC4HtK/o12E9QdM65GEaKD2zw==@vger.kernel.org, AJvYcCWCWIqegQwuOKMAtsjzmzEEzVveHpfLgNGGavSfb/Qz+P6P4JK8n7bPcuZaErmXUwUv81tL7wgYopcr@vger.kernel.org, AJvYcCXnzjxe7wWSjGHtzS0vMchDMicshqXTR/1rKXQ+VDqEpczO1J+fbN0jaNpejFMzDC9TfEusO/KC/Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIiq2TjwmuOc37lv3cqZhrJ1l90fZ7o+RouyacHfU4R+N7l13b
	QYoR+ae4YHdOmkFkeG0xg7E9M46CPo7KePirAlJn9A4qWI9FOfDaVPRg
X-Gm-Gg: ASbGncsODxOCa6I2tw/udjFhTjQF0wxF7R+Qob/KCIWNQCO5pUFCywNEkk9GC4OehMu
	NuO3VlWSohnm0p4o04dOn80h2Vew4oYYrxrXxTxGtLwEpoq7I4Ti4vnzAV0HDhje0en6OiYSBo7
	OHsg6VgiyEq6QMk8Awuuvs2IC1tBjzUxY8to0xdc5aAU1J8KD2EI3Z8B0GYzI9mY73DPOyCHjAH
	BiH1lJ1oUrsGFf3NmUtIoKLeyyr5lidXFgVyA/cDme6cDrdQP8NR0Xcv31OVfIYJqgz47CDLQy/
	Apg2kvLwl4YgtBLZXx3GaJLuDgl6zlyd5XGl6xOqqhWVRdGQxMxA5JNYrJM3YNy2AAmIPxtTE2Y
	PtidLCQDC+8n+vjBN7AoxeoBtd/69XK/Hwwi8B5c=
X-Google-Smtp-Source: AGHT+IHjegFBLJhNQdkkd6xSVj/DYBVnn3vhvfGYAuY88u3I42ocpnnfk7eS6S1PcGNXopy2mFZFAQ==
X-Received: by 2002:a17:902:d54f:b0:249:3027:bdbb with SMTP id d9443c01a7336-249446d2688mr6753075ad.0.1756511901075;
        Fri, 29 Aug 2025 16:58:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da28b9sm35571205ad.76.2025.08.29.16.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 03/16] iomap: refactor read/readahead completion
Date: Fri, 29 Aug 2025 16:56:14 -0700
Message-ID: <20250829235627.4053234-4-joannelkoong@gmail.com>
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

Refactor the read/readahead completion logic into two new functions,
iomap_readfolio_complete() and iomap_readfolio_submit(). This helps make
iomap read/readahead generic when the code will be moved out of
CONFIG_BLOCK scope.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4b173aad04ed..f2bfb3e17bb0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -447,6 +447,20 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	return iomap_iter_advance(iter, &length);
 }
 
+static void iomap_readfolio_submit(const struct iomap_readpage_ctx *ctx)
+{
+	if (ctx->bio)
+		submit_bio(ctx->bio);
+}
+
+static void iomap_readfolio_complete(const struct iomap_readpage_ctx *ctx)
+{
+	iomap_readfolio_submit(ctx);
+
+	if (ctx->cur_folio && !ctx->folio_unlocked)
+		folio_unlock(ctx->cur_folio);
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
@@ -478,13 +492,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.folio_unlocked);
-	} else {
-		WARN_ON_ONCE(ctx.folio_unlocked);
-		folio_unlock(folio);
-	}
+	iomap_readfolio_complete(&ctx);
 
 	/*
 	 * Just like mpage_readahead and block_read_full_folio, we always
@@ -550,10 +558,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, &ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio && !ctx.folio_unlocked)
-		folio_unlock(ctx.cur_folio);
+	iomap_readfolio_complete(&ctx);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


