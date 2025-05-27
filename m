Return-Path: <linux-fsdevel+bounces-49911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06890AC4FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAD217F4D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41B274FD6;
	Tue, 27 May 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BLBtQoUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76C242D79
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352788; cv=none; b=DkqVGjYOOwhWCmqPowtv4WpDmrdPOGh9AiLFJi7D9fvH8Y68KwWHkB+fTPYFlO02v4rU7fpwjDBzwgid3yVr0o+qDiQ/xD2K8q7kS5NdOvdZFyxr5H7ZgsJWd87n07sHwEObOpwf09d/an2t239GORNUeTgyrJicFZ8oG1RM1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352788; c=relaxed/simple;
	bh=p7fSFMGmDJ+opadKDwoyR3f928BEZUZvPB7YBPRGq0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTGQ0Z34ngKGz+wHIVnH3ltdvfYRe759/+wztEHjHBORt/oi3GRx7B9jk+a163+XIW7xtl93+ubYCWCrdb4KNwyjvHvjosXI3lvnio+hdtgRVFhwmCKrL3YHX/kVT5I3xW/fvmbp8eQkBxpGFx4k3viLbbTd5SibIRFnM6+GJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BLBtQoUp; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86cdb34a56cso18537539f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352785; x=1748957585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9QE3iCmnlBUUUA9W60asbsxN59hls5ffQoJsWOqBaQ=;
        b=BLBtQoUp9qBIR9uAEhGUqah2fLBAnydCKcDrNUHbKP/lK1yw+A2ctYk+Aq575ac7Yp
         utlTW9sglOgbSMEUpphdIzwuE7ab4nrIevCVYbB2Ry+86UyEcWQiDHMMdUh2oXdijPIS
         TOwPPp0+qD8HK0DStjKpFzFuB5tHYKMC8tvwbZwiiAb/o8aGE3977WG0bnAQo05bUwD+
         Yxj1EHeyKtnheu1xbhc7IS/flnM2SyWktpnT2SpI1sVqcbiQZWrMnvzK9ypcslAkEnnp
         xEQHfloR4gcQK82HPpu4/tRIoa1Yw85OaK+eNYtZKlUIUpmMpKDFLBk+rlx0oO8qX7TY
         WgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352785; x=1748957585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9QE3iCmnlBUUUA9W60asbsxN59hls5ffQoJsWOqBaQ=;
        b=jmXbcdOwF6ek7Mqx9icsHzw3CeXsiHxvX7bgdUG8rJsvIybEF4/jSHxzyNDeXvuoto
         9pdFnH0mgOZH0oWmko/GhR4dFImjnWqdgM6+Z6Lu1eR85HWshetpgBS4nFsfHvO7lXU+
         3ul42x0A1Fs1KNF6CEjt3UBO8A+/67+C3RYIbGinF9qWKISEczfJ2FA6KKj3IobkQRX8
         LqT77UUJFp+0cXlMI4CYZltMCcijeb3nVo0LRR9nZYErqrDC9T46e9jsxcNuYOttzDuo
         ZEtyzwoZPB/tEKs2LJaI6lhLdOt+h0y+iyXY1qSox6wXY4clS9b6rMY/3pStMK8oKPd2
         Yo4w==
X-Gm-Message-State: AOJu0Yzd3m9bh3IRuuYhms+5S/cucRDMC/a+e0k3QjTo+PJxtoe5fG1a
	Wp32FRRe1OYYQNZK4oFKfqXiHyXslcB220fspAsY21IcaVpY/bqNOGyrjOPucj5PZwq0N7Bc8jv
	XWgAz
X-Gm-Gg: ASbGncu5CqSNCFvUFx4EqBbsZ1waXOQUwivg4JYKWTL5tifCYDQ5Et3kgq6JKduMGug
	bEofjFFieWwCu/enNXDRhds62UWJumkjyGwgpjng36LZZjTxZzj2BvFOGc+03OHaYL9ztiuhV7o
	KAUmyN4BUE0PciL8uMSEB4sU1BAdqDLKPg09vc8OmW9Tn4tDywezFEK+m9M7cCIUWw1ybwuo9SS
	n7JGmBYcVdruzF+GGABYrJro+x1eS+BkkNps1eCmoA2CVG8CJRZQRH/v7mmTFw7QQaBgmh7W9WV
	O5d+r3FoVU41H2xa2dvudqU7qehrDPXiSftk8iIq2zorrSq/N04lJ3E=
X-Google-Smtp-Source: AGHT+IGax5eT/vPDNeiTv5b8TzLJ3KF2U5zPxnwM/X+veUJMP3M+tSKmnFcU/NqWZlODGkK0czTxtg==
X-Received: by 2002:a05:6e02:3788:b0:3dc:8273:8c81 with SMTP id e9e14a558f8ab-3dc9b719446mr128347285ab.22.1748352785455;
        Tue, 27 May 2025 06:33:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:33:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/5] mm/filemap: unify dropbehind flag testing and clearing
Date: Tue, 27 May 2025 07:28:56 -0600
Message-ID: <20250527133255.452431-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read and write side does this a bit differently, unify it such that
the _{read,write} helpers check the bit before locking, and the generic
handler is in charge of clearing the bit and invalidating, once under
the folio lock.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2ba1ed116103..eef44d7ea12e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1595,7 +1595,11 @@ static void filemap_end_dropbehind(struct folio *folio)
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
-	if (mapping && !folio_test_writeback(folio) && !folio_test_dirty(folio))
+	if (folio_test_writeback(folio) || folio_test_dirty(folio))
+		return;
+	if (!folio_test_clear_dropbehind(folio))
+		return;
+	if (mapping)
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
@@ -1606,6 +1610,9 @@ static void filemap_end_dropbehind(struct folio *folio)
  */
 static void filemap_end_dropbehind_write(struct folio *folio)
 {
+	if (!folio_test_dropbehind(folio))
+		return;
+
 	/*
 	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
 	 * but can happen if normal writeback just happens to find dirty folios
@@ -1629,8 +1636,6 @@ static void filemap_end_dropbehind_write(struct folio *folio)
  */
 void folio_end_writeback(struct folio *folio)
 {
-	bool folio_dropbehind = false;
-
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1652,14 +1657,11 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (!folio_test_dirty(folio))
-		folio_dropbehind = folio_test_clear_dropbehind(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
-	acct_reclaim_writeback(folio);
 
-	if (folio_dropbehind)
-		filemap_end_dropbehind_write(folio);
+	filemap_end_dropbehind_write(folio);
+	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
@@ -2651,8 +2653,7 @@ static void filemap_end_dropbehind_read(struct folio *folio)
 	if (folio_test_writeback(folio) || folio_test_dirty(folio))
 		return;
 	if (folio_trylock(folio)) {
-		if (folio_test_clear_dropbehind(folio))
-			filemap_end_dropbehind(folio);
+		filemap_end_dropbehind(folio);
 		folio_unlock(folio);
 	}
 }
-- 
2.49.0


