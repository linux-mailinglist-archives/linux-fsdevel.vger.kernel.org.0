Return-Path: <linux-fsdevel+bounces-54819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64CFB03924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BB617C39C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E32242D87;
	Mon, 14 Jul 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E67V9qC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BB242D67
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481095; cv=none; b=kZ1wy1IJnsnKjwfFSW5XaCRt9ahtteqP/VtyiHomU/c7/IpvLKzpWv75G1ntXtj+l1OHKN+S/nApYQi0huLRAIWWWUxCTxF42Sj0LDJTIpWwxGsVEKWzByTl2RJMxQIpM4T2a7GyDtX+satxBk9qkw4tG4xRZyHZdzG7tqw5O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481095; c=relaxed/simple;
	bh=4UkhoCEI+OZdrHgP0Txy3tJqI9wFhRo8i5m72xMx17w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxFjWmbLkyfxj9Nr7kJbCtNGlM2MFkZIrMVai1o6IGedoacDMzz1HomGi+y7Lo96TB3Hz9OtKfHvcD/3fPIszZxNNB1ch1jnwIUUycUwOc6OGUiX1w5yW20kd+SpenLWwo4TDPp+uOj55QCC9Lydy4nsg/GPSAQ48rU1YdzKtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E67V9qC7; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id bENfuHN2LILtwbEO3uVImY; Mon, 14 Jul 2025 10:18:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752481092;
	bh=RnfKm2axSn6c9/D3xR+Q4qW13WDSptzOFVvdfV5HM1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E67V9qC7Om8BeKti2vu/NHkKuTjjpJ6tRrVhkUFT61x71z8X7M89q6kneyKNf5mB0
	 mOMwcmmebuj6gkIjmDX0fZhh/wEc/OesCVJeXrle9UAd7m5moRFPxklwMHfs1rzTS7
	 oQTeK79JRQL7QRF9MxheL8nWhMpBVfTWNa/9coRM6dnfDtZFltLZIXxsjJwQOt2oUS
	 d1X+4KtXUTvs8mEiZuB4uHCZWmrJ3W9N0+aK5AIkn4v67h9D147YQr7Or5+Y/rAslV
	 B5hT5/+Xr92jf9NPidr6rDGnI7sxDeSJmhB+nuw2ijOFMPemKl+YkPoBw/CiU1rsm/
	 xAOKCcIcCwvvw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 14 Jul 2025 10:18:12 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srini@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 2/3] ida: Remove the ida_simple_xxx() API
Date: Mon, 14 Jul 2025 10:17:09 +0200
Message-ID: <aa205f45fef70a9c948b6a98bad06da58e4de776.1752480043.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
References: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of the ida_simple_xxx() have been converted.
In Linux 6.11-rc2, the only callers are in tools/testing/.

So it is now time to remove the definition of this old and deprecated
ida_simple_get() and ida_simple_remove().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v3:
  - Synch with latest -next

v2: https://lore.kernel.org/all/2e9b298991fb8cd47815c917a8fc069b553cea10.1722853349.git.christophe.jaillet@wanadoo.fr/

Changes in v2: new patch
---
 include/linux/idr.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 2267902d29a7..789e23e67444 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -334,14 +334,6 @@ static inline void ida_init(struct ida *ida)
 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
 }
 
-/*
- * ida_simple_get() and ida_simple_remove() are deprecated. Use
- * ida_alloc() and ida_free() instead respectively.
- */
-#define ida_simple_get(ida, start, end, gfp)	\
-			ida_alloc_range(ida, start, (end) - 1, gfp)
-#define ida_simple_remove(ida, id)	ida_free(ida, id)
-
 static inline bool ida_is_empty(const struct ida *ida)
 {
 	return xa_empty(&ida->xa);
-- 
2.50.1


