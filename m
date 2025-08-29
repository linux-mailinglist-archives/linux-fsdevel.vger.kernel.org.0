Return-Path: <linux-fsdevel+bounces-59683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC915B3C5CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4188B7A374D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC43148D2;
	Fri, 29 Aug 2025 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJgJm96U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF6481B1;
	Fri, 29 Aug 2025 23:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511901; cv=none; b=U/ICBDsH00t026lmiFfT4qebkHQCSMRNARA1nn+vxqLWBrtsSQPZRRj4D8Z4Z/8oGLAJ7L7DcI09wCcccXlX0UEIpSaQzeZEU2tmjQZir1lTJgYs5r3/XMpgRPt1tNC0lxUnnKAtp+wFp+/IO+sFMoXS6JnpE4kzQYthO9oOjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511901; c=relaxed/simple;
	bh=vtLvcpKEFHYSRXW1aL0Ibf4r8rF3eXE7gEwYc4yfNTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD5tTOxOYgZUj6WRAWTChOKQoH/bbwJZ0o3NMjRHM2814vhpiw550t3Vxc0pDd02LGrQf2R+ey59KJmG2EEVNAd2/ebNZQS7mT0lvBvDNGAeuNmLSqNjUupG54apBx72KsdHv2SuuMofhHeIa/ZQnsHoo5Tk9maRA8M9mPWTHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJgJm96U; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso1797385a12.0;
        Fri, 29 Aug 2025 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511900; x=1757116700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv9o3X7cBBJxdKZs+gzCwQCT6rm30MTuI+uzZmxT8UE=;
        b=eJgJm96UZEIlAUqKty2L7C4J+5Q2dGsHopDVsDr2af6XWgSL2ufm1Rw++gSRaw+wIO
         YpJe8FAmYOj13Pgqy02KhVdjYQm23zmTO+g7q9FgZ3n3WY2nAatRS0r1h4tdpsi7XOKJ
         fAx6MGYDOc7tghWPJLzytDNFnsR4l/2QpfzoIVvR7crfLj+BRt2gvAosRnTEk/qYViXW
         0+CgI72dfrZN80gpk5BT4qwIb3mXYSCcI73fYFTcy5eyFx2lMW4gE9l2w6lk3MJ6Edha
         o9KcBJRBP/3zPf83r43ZfyrNk5DI4qSEEM7xLSOXGIIfIZqBRAXRuRvjpTDGRBqDiplA
         qvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511900; x=1757116700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv9o3X7cBBJxdKZs+gzCwQCT6rm30MTuI+uzZmxT8UE=;
        b=pBmi3ndP6IaV27RmbWsXJbxxXnJUxQwCq4BRv0UU+C7SlVf7W8GZDcPWr8v4VXDdvI
         KhCXpyj3AFRhb6X0rv+h4gMeUMHd7xQV1BmqU7YGa5OYda4Og+7OoNWAU89B16bue3Yi
         Ru0Yq3Tq6OtKtd26qrb8LshgfxNXPJMkNqhWQJejo9GeyZB9CAO94tTw5m+XJe3EuwCC
         0d94OYqVWzcjbszuha0XdURnkCYvYluKw0CVMNpw/eNjKSXI5hcrD72z5Q+gYFnYVtdL
         6a/TEeUKc5kUBUvUH/6H2s9qKzi4h28mJQ7t6KVN+BKcgmLyCLvFhOlJvj7kUV+xiY0Z
         aGsA==
X-Forwarded-Encrypted: i=1; AJvYcCUigGYBxgp+bWMAv0vKirhLkkXmt6aqOX+4RQ3HqsFQTSr+2YCUXxfFmFmAU2tvUC+VPZwRluE0uDdlu9M4ig==@vger.kernel.org, AJvYcCVAmCC395W0vSbdsUOTJxrL/+NUI/4/pDkP06J+Cf1h5mkE60XUPUXe43lu6hQ4XZuYjk+ToxGUTu0j@vger.kernel.org, AJvYcCVHCa6tZRJu99WTycGK/IrWxGmLxAOy/8T6MF47EiHn4T2RmC0EgUpliIG+Lk7sKobdeNcfvS6ev1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CWAxCrEbBuIHbfAvUm1GjN2MMWOcYtpcacUiHi5b/QPYAl++
	4nYZlSxYXCRaYAp69eO/WdEhIcvlyyNIxHjrza2iZRSAxgKEmXi+c2CvvpeXwQ==
X-Gm-Gg: ASbGnculMgjTfCLy0jd9d41MrYCkFqrTNHKmQknMqXURo8clcjtokAtiVJEykMcU5OT
	Y+uN0Sygg03HsYYcN+Rh8wUCSK24M3zQg+HIzac2ZQYBZqRaBh2xyCsREDWpb7ovC9WfqbSXyav
	FjH0ivylxf24NWz142g12FfNBS7tNsXcKKf29OiFL2lj1/Gd4VTnCA809QFhZhpB8Kj/XMhVaBY
	PxzK2Ck4uDn4RJ10gjJ0OcWAICKaxk40Vr1WrbAZkdBhx+I4uyRdNSYYTsmjKpqjhI+FdMrH2Mn
	uapEOY8GjcCYuYs+sJwPE56jqHY5oh/i2e8XsZWVHu0rRlNjCcCeFw3hVaotZk7LPAk0r4aZb0O
	4loPUNfkV8mmtozq3E/F/R0t/10uf
X-Google-Smtp-Source: AGHT+IEvAmedXJLhEcw8qSvJGhlaw65+utItApu8XWwYNb1CeMpg9qBoKQfR5v3N0tU4Ws1h4mlwHA==
X-Received: by 2002:a17:903:384b:b0:240:84b:a11a with SMTP id d9443c01a7336-249448f24abmr5341595ad.17.1756511899680;
        Fri, 29 Aug 2025 16:58:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067db6basm36161655ad.148.2025.08.29.16.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 02/16] iomap: rename cur_folio_in_bio to folio_unlocked
Date: Fri, 29 Aug 2025 16:56:13 -0700
Message-ID: <20250829235627.4053234-3-joannelkoong@gmail.com>
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

The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
if the folio needs to be unlocked or not. Rename this to folio_unlocked
to make the purpose more clear and so that when iomap read/readahead
logic is made generic, the name also makes sense for filesystems that
don't use bios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f8bdb2428819..4b173aad04ed 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -352,7 +352,7 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
+	bool			folio_unlocked;
 	struct bio		*bio;
 	struct readahead_control *rac;
 };
@@ -367,7 +367,7 @@ static void iomap_read_folio_range_async(const struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 
-	ctx->cur_folio_in_bio = true;
+	ctx->folio_unlocked = true;
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
@@ -480,9 +480,9 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
+		WARN_ON_ONCE(!ctx.folio_unlocked);
 	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
+		WARN_ON_ONCE(ctx.folio_unlocked);
 		folio_unlock(folio);
 	}
 
@@ -503,13 +503,13 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->cur_folio_in_bio)
+			if (!ctx->folio_unlocked)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->cur_folio_in_bio = false;
+			ctx->folio_unlocked = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
@@ -552,10 +552,8 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 
 	if (ctx.bio)
 		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
-	}
+	if (ctx.cur_folio && !ctx.folio_unlocked)
+		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


