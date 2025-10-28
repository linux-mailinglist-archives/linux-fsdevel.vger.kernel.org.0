Return-Path: <linux-fsdevel+bounces-65947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F88C1668C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 515B74E070B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E034EF05;
	Tue, 28 Oct 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL0Y30X3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2834EEF5
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675103; cv=none; b=BqGpSpVtA7QvfpNDtsb1TdsHP1ugoPF5QnoOhqKjEjh1KymZLEWAJNzUTTiVBlp1+aBPbp6k1CVYbv2rq8+TYMcSKX+hbAhcmlH97bYdG10lgAjbt7CqzzTb00P00ZGYWr3lhDdLocdKsOjiYO6fqtHRfwhx9jUulj441nJ6KYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675103; c=relaxed/simple;
	bh=wwNvjKiYjLRlJUm9NTy0MYsIbiHnusvDrJ3J5xQbm3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgF2Rwzu6Gv9zE5vQi3ZOcfXJp4qoBX4DYIyE7kiu8cSV14dSgzKRcIc/sICE/7ZxK6WraRq+YnYImrOGLEcUYdC+gwoqBNpyI2rd3RzrTkjtk4JmFSehFnayM5bXp5UeAwWOE9Yl5egCnTcE0tshxguXUALZoHYQERmtqWKpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL0Y30X3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4003577b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675101; x=1762279901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H9/vLy5V/pg2ns6KF5LXXWGmex0sjz5Kc/caXUPaxI=;
        b=RL0Y30X3A1OVFduRefXA23fkf+uiIoy+laVPAqnUZzHuBQy6iuIwbefclEB+AVxBQU
         p99KhE0gvzY0inoFVsNs4SQbAfge8y6c9YHh0Ayus/7J99K4BNK40TkJh/lTfCO4YCjl
         0/gYkUFKm/00ei/GP4pq2ohDSUCZs4vjGF3tVGa10wDaAIiO9txExP1SwTkNo42adokh
         1YSoEinn/lpw+ZNz8VROCP9i5A5soo+PiJmTbrGGcmnlwxq9SMZ2gFBqZbgu5d5yqBDa
         MV22vzinQdSLEpxJvg16HtlBkP0FOPcgwl9W8aH1WYApEe/r0KM0UhaAjku6/ui+SaIr
         snKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675101; x=1762279901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H9/vLy5V/pg2ns6KF5LXXWGmex0sjz5Kc/caXUPaxI=;
        b=FXqUd4pCFtXkuyu/M4dWYlSKgQ/oVh83DWsB3RAjhJ+ba78B4HWDL/UhxAN22HwpTj
         QYaig1ShmrDdXvJj4rdLD5H2mBUc6tVVTePkoXb+65EAe/AxVIBmtFxDKlCS+bLEdOZR
         nCYjIp83vAv9aZvRUtoF12d2Fx6jlGcx4zhu2U4BYaQ6ZOjWMWxMdT2OAEmYxzSyEvJ8
         1AKhaKOVUpEcqbkJzEPApasxx8TPxvQ2Kdj6UnWd1Fljf8gsTfsMLznIHnOevW7TMw5i
         G31o2UgwBgzZxog8DW6hY1cEAdHckwh2aqoYPvtCOl84sGDNHCRhOr5nGdTAE9AD4C4P
         Qp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIFlbEkY2DLmqmTxjAeQNs4N0Qpuc1Liqdx7giJe1oWhbIaDu+fahlVStHihABAgZChnwSnBa6RuwYFLn/@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfxHVza3udNx2fL8WUNz60YN4RKohY16sfDz1nMMdRUNkCEcD
	h7sJWvVU5Vz3tSTd2QKNZxw6ISW/PK0dMuC58gZjsdzBXp/uMATGLdPp
X-Gm-Gg: ASbGncss6s7QBMhsrMylKoHCtgiI6lK1hltTmFGcwh389szJXNKKHRvrSvT8qhIJ8lZ
	6UPKMouQm9Z6/AUXrpAnOLD2Nj1hVG0bgwWmz6ite18/L3x9lPzHMsDgA7a99K6uONSCDPXggG0
	RLrcYxyQ0pmiebx1Uq/JcVd5KHOstH2xZrEMtyePl/x/uf6nHy9/qSx+K7kFY+T2dDUQGegqo4P
	UXTe6VIsniKBxhS85VvbJLE+6HgVps7QI5+yNEEsqZQ96+8VLCXUcFdyHkCS4zTgFvvHnHRiRg6
	wrq27AG5NibmpaGOOVIxNOnVXMKiStv/osdAzhkXljqtZ70L85h85baEb9UKA8jqscqW/1PV5hQ
	iFGlUCRNoMUau8JZjppI8SahzxLMTzW0i8OMC7o3N2F7YdKTsXkAwJqVyl++iEZAKSEuzef3fBK
	yziFMeWR4FqhcL6Pc4NaT1rZ33agdyYaSJw3EmCg==
X-Google-Smtp-Source: AGHT+IEDiE/eoOxboeOl3L/lu/rjXtW2OjAuu9Ptfx5gZffF9NdWwGh47iPJlBOBOLzuJHYr8Heiww==
X-Received: by 2002:a05:6a00:c95:b0:781:275a:29e9 with SMTP id d2e1a72fcca58-7a4e47257dfmr35606b3a.16.1761675100651;
        Tue, 28 Oct 2025 11:11:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414062b6csm12487498b3a.42.2025.10.28.11.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:11:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] iomap: rename bytes_pending/bytes_accounted to bytes_submitted/bytes_not_submitted
Date: Tue, 28 Oct 2025 11:11:32 -0700
Message-ID: <20251028181133.1285219-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028181133.1285219-1-joannelkoong@gmail.com>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned by Brian in [1], the naming "bytes_pending" and
"bytes_accounting" may be confusing and could be better named. Rename
this to "bytes_submitted" and "bytes_not_submitted" to make it more
clear that these are bytes we passed to the IO helper to read in.

[1] https://lore.kernel.org/linux-fsdevel/aPuz4Uop66-jRpN-@bfoster/

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72196e5021b1..4c0d66612a67 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -364,16 +364,16 @@ static void iomap_read_init(struct folio *folio)
 	}
 }
 
-static void iomap_read_end(struct folio *folio, size_t bytes_pending)
+static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 {
 	struct iomap_folio_state *ifs;
 
 	/*
-	 * If there are no bytes pending, this means we are responsible for
+	 * If there are no bytes submitted, this means we are responsible for
 	 * unlocking the folio here, since no IO helper has taken ownership of
 	 * it.
 	 */
-	if (!bytes_pending) {
+	if (!bytes_submitted) {
 		folio_unlock(folio);
 		return;
 	}
@@ -381,10 +381,11 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 	ifs = folio->private;
 	if (ifs) {
 		bool end_read, uptodate;
-		size_t bytes_accounted = folio_size(folio) - bytes_pending;
+		size_t bytes_not_submitted = folio_size(folio) -
+				bytes_submitted;
 
 		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending -= bytes_accounted;
+		ifs->read_bytes_pending -= bytes_not_submitted;
 		/*
 		 * If !ifs->read_bytes_pending, this means all pending reads
 		 * by the IO helper have already completed, which means we need
@@ -401,7 +402,7 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
 }
 
 static int iomap_read_folio_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t *bytes_pending)
+		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
 	const struct iomap *iomap = &iter->iomap;
 	loff_t pos = iter->pos;
@@ -442,9 +443,9 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			folio_zero_range(folio, poff, plen);
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
-			if (!*bytes_pending)
+			if (!*bytes_submitted)
 				iomap_read_init(folio);
-			*bytes_pending += plen;
+			*bytes_submitted += plen;
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
@@ -468,39 +469,40 @@ void iomap_read_folio(const struct iomap_ops *ops,
 		.pos		= folio_pos(folio),
 		.len		= folio_size(folio),
 	};
-	size_t bytes_pending = 0;
+	size_t bytes_submitted = 0;
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_read_folio_iter(&iter, ctx, &bytes_pending);
+		iter.status = iomap_read_folio_iter(&iter, ctx,
+				&bytes_submitted);
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
-	iomap_read_end(folio, bytes_pending);
+	iomap_read_end(folio, bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static int iomap_readahead_iter(struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_pending)
+		struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_submitted)
 {
 	int ret;
 
 	while (iomap_length(iter)) {
 		if (ctx->cur_folio &&
 		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
-			iomap_read_end(ctx->cur_folio, *cur_bytes_pending);
+			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
 			ctx->cur_folio = NULL;
 		}
 		if (!ctx->cur_folio) {
 			ctx->cur_folio = readahead_folio(ctx->rac);
 			if (WARN_ON_ONCE(!ctx->cur_folio))
 				return -EINVAL;
-			*cur_bytes_pending = 0;
+			*cur_bytes_submitted = 0;
 		}
-		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_pending);
+		ret = iomap_read_folio_iter(iter, ctx, cur_bytes_submitted);
 		if (ret)
 			return ret;
 	}
@@ -532,19 +534,19 @@ void iomap_readahead(const struct iomap_ops *ops,
 		.pos	= readahead_pos(rac),
 		.len	= readahead_length(rac),
 	};
-	size_t cur_bytes_pending;
+	size_t cur_bytes_submitted;
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, ctx,
-					&cur_bytes_pending);
+					&cur_bytes_submitted);
 
 	if (ctx->ops->submit_read)
 		ctx->ops->submit_read(ctx);
 
 	if (ctx->cur_folio)
-		iomap_read_end(ctx->cur_folio, cur_bytes_pending);
+		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-- 
2.47.3


