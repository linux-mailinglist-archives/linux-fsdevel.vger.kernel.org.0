Return-Path: <linux-fsdevel+bounces-60584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B982FB498DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F7824E13AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73131DDAF;
	Mon,  8 Sep 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4Z5t8hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0D31DD8B;
	Mon,  8 Sep 2025 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357543; cv=none; b=jiU9mOZM4+njnFbryZjvIATWR3XTCMT96bkvhwWxAU6lN+8yrCLlNVeeInRYtoSKKc7563WOx7z1PHZCF+EL9EqCzt+ZCOKwUgNS1LVPBgh3N3o77lHA+Zu9YiKgDSa8Rp7mNp8xmh7hVCJRiRAq1PhRZfM9qGILUgRZb6TIINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357543; c=relaxed/simple;
	bh=03ZJHgsYmhlSs1nq+6Xf/GUNcyuYrHRU+DwlBYzjY0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeRSGYFg19fupWmQQnDl3c1WFQ83YeP7KFWx/TKRBJrUxLQKXzAhgoseO45/tDCeMB3PBdwm/aODX/X1S99v5lpHB/HcR3krgOHDHR+FL92zKwde72SMRcZiOmSLifV1l4SkZvaOTsUdS5zfFM/U+QDaGsfL/T27NR9JY5Uv5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4Z5t8hg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24cde6c65d1so34703645ad.3;
        Mon, 08 Sep 2025 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357541; x=1757962341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HVCkh1UKWPFtgzXfqyKtp7JpLoGe6FH7DH/+yG/OV4=;
        b=h4Z5t8hg2kvTpd1z1N4uUD0vOmavbarbwH8Lu3fWSyrQyFFrGUstqPzQnJh2IyVcOq
         Hn6ibYp4HekHckpRyw/8n9VRN3EA6p/GPPji0Kw8ocvi8BlXnAvtNAzbvDmJzIldQYL8
         QqW80wnB2BbziC+MjqpAejWThYs/yaCk3JV8UEVdjaC1P27XGygR+mP+sqL818ReKBD0
         Gh2ZkLwr9/Opoq60x6RetFjIgwaAqUVOV01oBlyCM1fcC19bmGJIv9RrsoVReXq4c1in
         gUBNw6t3jrlwUczH04kjGZ4FLRFrw5bUhS+DH/gciw5vpwDXEkkLOFN/Z2hpR+JEuwSZ
         wOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357541; x=1757962341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HVCkh1UKWPFtgzXfqyKtp7JpLoGe6FH7DH/+yG/OV4=;
        b=r4oLuFbUmqc8a2+MV6ig9vYd7RNAEs0uHM4vZPmmo152ITezVSelJnrz1Taut/g88E
         bWBI7P5g4vECB7hg9OgjXHhhdU9gb7q3ZunhwPlccFvZZ0z438KkWe4PhwNrS4W6lcyt
         la/HENxMRuFEIstXBScfHoH3mDcIxrNDlsJudPltQGnNRuORlMwNNUqAzVppzX8OtsTn
         05JBbsfogWTdvjXKAKXE5XxKp93ioQYSHWUMHtR3Xj6BFnk6sk6HtMiVcq6c4dzOduq4
         ac1buJxI6StgCZJ8ZILiNOFje64Hc0XCOaIDJRPN28X9rU8ncvvhpCm/iX2e41+rvBYH
         FKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/LmpYtjZSfjj4bkZ53fj5L7NSvXQgjaOakDHn1DMAI8bZ6yXIeiLejPxH/aJJfIFR04h+Ac0I7e0c@vger.kernel.org, AJvYcCU7dmFv/ePOdPNckXC0nfOKNzXcaQxtfH2Ql4WJxmv8lHKAoYmwfjCFsrjYw2pttaQFT4koEe5PvZt3@vger.kernel.org, AJvYcCXX/giCyrN5qPApXcFllIQ3n6Em10M7Uy3LI7sqoQwjlTdgOWoHkk6+iE5mTMij5ppUXIstzCrpnvVwzg==@vger.kernel.org, AJvYcCXaYl67lfqcqSgW2pdLw8OQx6KTQ9TmsjzzakSBQSJnk2/89gt+GfBPLN+Ns5mF5e80cwHRTDhQnarnuyMEZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yKOYSV6Wt/nkyAugdI7ISvHQ8RQrZE5UudflRv1UT4Vk6fBf
	Q3xkvlJlSGoTrMXR4t+0zuJ3E7AFZvdl1n7qf82zIYxmf4CeOA2k0Fv9
X-Gm-Gg: ASbGncvl9s1Xqf600lHQsiSicr7XFKf/HmqyHol26Hegr64CnXe0HQykcnKI+/CQxYN
	y7N8KVsRSVovIrjomkIWmDodUAB7OakUil8LDeTvmZKqljR0n7HJBNdLZoPsfHh4nRd7dI+lVap
	woKftv89mYuuabHS3T/kVluicxGEWokF0wzpD6JM5cePxONAG64CBTGPI5wWdJq2ZV9yKq9wNsX
	okWfIEh0pso7kAI1O1LZeWoLzu/gbdU1T9yO8qAiV+hDkbpYOPJUVcNl6xhsvmJ856TZnwfSYM2
	BlHfb3qMdQdbjpPZ2wxJREuVv/sfH/g/zt5fWoYL1BUuKR761pJ1RqYpHcj+xRlaXDS76MnwUnR
	T93nlfA1wQaYbnLSarA==
X-Google-Smtp-Source: AGHT+IFG72y7Clny8aCD6Sn14+X8WmcLDwUJIUWQp2xJBzCzAcXeYFo4xUxw3GPY5uaJ0Z21BiduUw==
X-Received: by 2002:a17:903:1585:b0:24a:8d5e:932 with SMTP id d9443c01a7336-2516e981584mr116482435ad.23.1757357541032;
        Mon, 08 Sep 2025 11:52:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9669a0e1sm149008375ad.56.2025.09.08.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:20 -0700 (PDT)
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
Subject: [PATCH v2 03/16] iomap: rename cur_folio_in_bio to folio_owned
Date: Mon,  8 Sep 2025 11:51:09 -0700
Message-ID: <20250908185122.3199171-4-joannelkoong@gmail.com>
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

The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to track
whether the folio is owned by the bio (where thus the bio is responsible
for unlocking the folio) or if it needs to be unlocked by iomap. Rename
this to folio_owned to make the purpose more clear and so that when
iomap read/readahead logic is made generic, the name also makes sense
for filesystems that don't use bios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a3b02ed5328f..598998269107 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -352,7 +352,12 @@ static void iomap_read_end_io(struct bio *bio)
 
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
+	/*
+	 * Is the folio owned by this readpage context, or by some
+	 * external IO helper?  Either way, the owner of the folio is
+	 * responsible for unlocking it when the read completes.
+	 */
+	bool			folio_owned;
 	struct bio		*bio;
 	struct readahead_control *rac;
 };
@@ -381,7 +386,7 @@ static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	sector_t sector;
 
-	ctx->cur_folio_in_bio = true;
+	ctx->folio_owned = true;
 	if (ifs) {
 		spin_lock_irq(&ifs->state_lock);
 		ifs->read_bytes_pending += plen;
@@ -493,7 +498,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 
 	iomap_submit_read_bio(&ctx);
 
-	if (!ctx.cur_folio_in_bio)
+	if (!ctx.folio_owned)
 		folio_unlock(folio);
 
 	/*
@@ -513,13 +518,13 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			if (!ctx->cur_folio_in_bio)
+			if (!ctx->folio_owned)
 				folio_unlock(ctx->cur_folio);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
-			ctx->cur_folio_in_bio = false;
+			ctx->folio_owned = false;
 		}
 		ret = iomap_readpage_iter(iter, ctx);
 		if (ret)
@@ -562,7 +567,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 
 	iomap_submit_read_bio(&ctx);
 
-	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
+	if (ctx.cur_folio && !ctx.folio_owned)
 		folio_unlock(ctx.cur_folio);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
-- 
2.47.3


