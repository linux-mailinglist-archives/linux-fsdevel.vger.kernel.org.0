Return-Path: <linux-fsdevel+bounces-51625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D717AD97B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A254A09CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32728DB64;
	Fri, 13 Jun 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL+gqsNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9A28DF00;
	Fri, 13 Jun 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851453; cv=none; b=mlmvvRmXtN6pUFHq8Cs3tfBJ5TPL4hS6MfDcEofnjU1LjXPBT4feCzlcVa+d7y0dpX7JdstVXdHft5o84Y76RINGASYyF9s27TbkSeL+TNhQop8BM3Kgtk5/0uQgArLfKDPXo1MdnMPzfECfkw98ShSsMnOYEsLgSmxHVIKCjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851453; c=relaxed/simple;
	bh=Pb6jswVAsYn1ZNW/9khlQQ13FtnAUu8XxLjLT7AVEOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBUMcNgwS6WWIOm2TQBq0nPoRGmhu5yAEELWzXQTIYzIMVbJhS6DrCkhWZt+L63now5S5j/5YjcdL32+WUe611UFbwDCEwyYb2wqk+CijzgWuyWaf8/rEM6aAeo+c3Fo4KHa4/X2FKlZxia5NTcZrgcZUfDvhtOcns+Ja6o42NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL+gqsNZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so2198669b3a.3;
        Fri, 13 Jun 2025 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851450; x=1750456250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgdk4/sOQPiZPKe08libGj4nf7W9EWuJbBbiFcac7TA=;
        b=fL+gqsNZqRZ25MOpsoHTszx7dWVzd+akjgGzNEfYPV8s1SPfV+OFMgn96WFYtiZsOA
         XR69y4hfG+D5ffiNDsX5H5clhmOpk90QoOkXbYxaXO8RxMFbmbSHjBwHoNFGEMxh24Cz
         leTvcX6l+cPTt5bW3rJWtnMk751SdQ2LCHLyRVD9a+vhwGQdTLXEm0uNaemhWTmrkmkf
         H46lziI7nMC9JkliD2VXAGGxSEsZpFnd/j2GReoeeh4U2Eh1gAjcd1XS7mE7VkPRkVCd
         9YxjgCzDp+Y+Uvq7ddaiGjmtcY+TQORoxdmGB64Y3QdOe6EYrcaGmdKelM9adgmosoPp
         LaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851450; x=1750456250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgdk4/sOQPiZPKe08libGj4nf7W9EWuJbBbiFcac7TA=;
        b=IxOv1eQ6L+pP83IcWIx6YE4aNKKh+poQLLmRvYwULCuoULhZ4TOmHmRTc2MxWvZXa0
         JFcNeF4YVoONHkkaAZgRRfvFqMHNUfs0YgsLYO+PFWQS8zVLR/FcRtt5tOkMEO1xMe1B
         m/xQOYRKQ16FfZIFKW5ZvhXERFo8Q8xLBRpAlDD3vmV0P3dLzfC0b4ivJIz7K9I08LN/
         bDaBpgYug9QxsUz+bkrnfYBbSwbxX5n3PCTCG4dnGC9jgGc3ltCnkK1iAk4D5VSIwJ0+
         bQdTNYqsKrvz3axBMpBnzrzZphMoVnYqQ2RALw2o9U0lzcC74s0NMt9VC6NlO81INN6n
         UK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUOrVHrV2YYURy7y1FfifpPH5XMdHe6OoAemiy/caNvw45VsSKLRSj7E/BPBY6iLd/CnJEwTFFfPkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0HjGBKtorOLQVmLWHdzzcs5CVeUxUWALEfB3Te3Pw2ufhHtC9
	TOO7P+QqRj8AKzZ8nzLAZ6Ck9HBbwx/vogNux2ZJ2K5hXpfA+tNAGI3l5/Prlw==
X-Gm-Gg: ASbGncspqMwcaZxFntMz8evx8M0qSU6YAwNSOjP1p8dOUR5I7UVykldiOl1F0oLMYnm
	DfAd/nISp6ZZ9ZObFl3Pxube/770xDylA8jtZ8Hr6Iu3DUYruw22WLgklQjguG1dvJPzckflpxs
	mXM59Q73byy3fS39fefxVtBVjlYlgdyJFWxMkVNJAf7eYf68Ir7OZA4Re0zghp77kAh8b7PL8HL
	g97cM1q52XCZhdjnNQpDjbeU7n7Abg9HwHOZ7EHGsHc9fqNP216cGoJvhq68tmT2ZAU4uCT/lgy
	gIdkHD61+L1qKt8NvGzVsVxKioMeywGR+za75+pIqT43k/w8jVzcGf8PpQ==
X-Google-Smtp-Source: AGHT+IHUu3qFHeWzhJEs3oBkVWVF+mHefksb1kVXfUUFHg5c99Xc2LQ1NZE/NzJD9pv5Jjf2pTf0Zg==
X-Received: by 2002:a05:6a00:1823:b0:737:9b:582a with SMTP id d2e1a72fcca58-7489cfdb64bmr1334023b3a.24.1749851450669;
        Fri, 13 Jun 2025 14:50:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890006064sm2141834b3a.43.2025.06.13.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 05/16] iomap: add wrapper function iomap_bio_ioend_error()
Date: Fri, 13 Jun 2025 14:46:30 -0700
Message-ID: <20250613214642.2903225-6-joannelkoong@gmail.com>
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

Add a wrapper function, iomap_bio_ioend_error(), around the bio error
handling so that callers that do not have CONFIG_BLOCK set may also use
iomap for buffered io.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 6 ++++++
 fs/iomap/buffered-io.c     | 6 ++----
 fs/iomap/internal.h        | 2 ++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index e27a43291653..89c06cabbb1b 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -145,6 +145,12 @@ static void iomap_writepage_end_bio(struct bio *bio)
 	iomap_finish_ioend_buffered(ioend);
 }
 
+void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error)
+{
+	wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
+	bio_endio(&wpc->ioend->io_bio);
+}
+
 static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode, loff_t pos,
 		u16 ioend_flags)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 45c701af3f0c..9ce792adf8a4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1466,10 +1466,8 @@ int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
 			submit_bio(&wpc->ioend->io_bio);
 	}
 
-	if (error) {
-		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
-		bio_endio(&wpc->ioend->io_bio);
-	}
+	if (error)
+		iomap_bio_ioend_error(wpc, error);
 
 	wpc->ioend = NULL;
 	return error;
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index bbef4b947633..664554ffb8bf 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -43,10 +43,12 @@ int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
 void iomap_bio_readpage(const struct iomap *iomap, loff_t pos,
 		struct iomap_readpage_ctx *ctx, size_t poff, size_t plen,
 		loff_t length);
+void iomap_bio_ioend_error(struct iomap_writepage_ctx *wpc, int error);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
 #define iomap_bio_add_to_ioend(...)		(-ENOSYS)
 #define iomap_bio_readpage(...)		((void)0)
+#define iomap_bio_ioend_error(...)		((void)0)
 #endif /* CONFIG_BLOCK */
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


