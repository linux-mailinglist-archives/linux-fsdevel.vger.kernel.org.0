Return-Path: <linux-fsdevel+bounces-34811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF609C8E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB728373E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244113B288;
	Thu, 14 Nov 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AazWmzX5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213A19B3E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598097; cv=none; b=JX8QgOcyHDOvnsltJ+O/D1pcuNmRKBUzUInGXIshqDCa2qIosQgr+ZkcCsocSel6CpmOsjnxL5HWSVOwF4x59qIE2pfKggOVQtMo8MVytT/vLTtbQp+nO+O3SGQEoT5B+L4kTx9CFyhzlH81HTwoCCfAuNiq+Ryf4J1cby854ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598097; c=relaxed/simple;
	bh=DvaplPoN0uFc8s2haQH1BvU7ppNotoZgida5jWixk9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AebVdmtm1Pt5uM7NzVojX0u45KhjmJZcgtihrSV8ffRVgWmzXc2g0KtgPB9dqloc49/18LdcnRLHkXn+v150B/uzHS5rbz1xet2UKv4ljKqOGANlLEWNZLQ4bNCcSv/yRTCdD4mqqxRjstSjS+PNH4v7lGxUAiXS63Wcp1YUi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AazWmzX5; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc27fdc30so329596eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598094; x=1732202894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSo08QFzm+JiqHz4hWmAqopvA0C/7UNivlhAphA9PAA=;
        b=AazWmzX5eeAsU8Xu0NaiseiCfM42rfUilq+4ewe2Z21r9ikwkCoF/e4T5odgOi3+88
         4GYpCMogj+vWesfwJjiXFbim6l8Rd8bweRI5SuJG2D/dbrxtyJrYgzplEUqa2P+aG3Cu
         s0pGffc/WwmWF7wQzCEMRxHOhQh9IsUYCgfGCUyyxovEqS7pdjQG6WpLOyBRh1MptgjP
         UWF4/FKRJxDG0QwTGM7Xu6UTpPldaAZgW/rym6fwyJ+M1hVdhpun0RUI4HHcyGmhdqZE
         ZyDOji3OJJYQ/FVTrNFZs2eUxQ8vsbtIb7Iczfvi+42dMteJRYIRvhChElqd2z9RFoBB
         nYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598094; x=1732202894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSo08QFzm+JiqHz4hWmAqopvA0C/7UNivlhAphA9PAA=;
        b=hMHF5yOL5Je4tuasg18HrLQNhci8iTFo8Fj8AmzrKyYWNf4WRyckotHVaKRCrS2pNb
         2JtQEaDfI2SqCuZrbwEKHvj3pjktzkdDVMazhnG0wE+sMLPJIw4kg3fhvwEnkLJxzi95
         YQbEurhjCKPl8QUTh5mhAtVV34M5ajFz5TNWJnyPN3XC4+xvKy5M7IfxM9q/xyFuP8oo
         i+HWTtrOLJRmEZyAbGKvq80CHchWkFTO2RW3HwyQg/seXIFwQsyhuL6HCWl7VUTgR/U3
         mkfmjJZsBCxpNQN4wU2CngohD+qYG7lvUU4njwzdFsusFgBKy46stmen7r99hNSA/E6h
         IqDg==
X-Forwarded-Encrypted: i=1; AJvYcCX4agYBlWabMNpDONArPq7GSZLuA1EFBA5RhDbMnFV1CFEBAyXj5zVHLm8kAe39kXSWLOLu5NahDS3lojdh@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcNvszSvMO7ErMNmiJ1/v2QgyuCtx7F4DfBWjdIF6mI09mae8
	amhvwqumxtVau+/t8eTRj8exu0Sf6XdOk8oXsFCa88iMEfbFZG4q1gT92CAXIxc=
X-Google-Smtp-Source: AGHT+IF/wU8hdLitBYUw1Xm5/VEAvnGHF/Lmj1TdlA4Dk/xHse2V/nkks/Gl33gMzxUMuX6RfmQ7hg==
X-Received: by 2002:a05:6820:983:b0:5ee:bb2:bdd4 with SMTP id 006d021491bc7-5ee57b96aadmr18195949eaf.1.1731598094397;
        Thu, 14 Nov 2024 07:28:14 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:13 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/17] mm/filemap: drop uncached pages when writeback completes
Date: Thu, 14 Nov 2024 08:25:13 -0700
Message-ID: <20241114152743.2381672-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as uncached, drop pages when writeback completes.
Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3d0614ea5f59..13815194ed8a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1600,6 +1600,27 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as uncached, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset uncached for that case and latter completions should invalidate.
+ */
+static void folio_end_uncached(struct folio *folio)
+{
+	/*
+	 * Hitting !in_task() should not happen off RWF_UNCACHED writeback, but
+	 * can happen if normal writeback just happens to find dirty folios
+	 * that were created as part of uncached writeback, and that writeback
+	 * would otherwise not need non-IRQ handling. Just skip the
+	 * invalidation in that case.
+	 */
+	if (in_task() && folio_trylock(folio)) {
+		if (folio->mapping)
+			folio_unmap_invalidate(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1610,6 +1631,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_uncached = false;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1631,9 +1654,14 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	if (!folio_test_dirty(folio))
+		folio_uncached = folio_test_clear_uncached(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_uncached)
+		folio_end_uncached(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


