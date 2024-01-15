Return-Path: <linux-fsdevel+bounces-7931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0982D747
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB97C1F2106C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8610795;
	Mon, 15 Jan 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Ma9o8yAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9286101C1;
	Mon, 15 Jan 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TD7ZG3BF9z9s7D;
	Mon, 15 Jan 2024 11:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1705314326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I6WPSYrEhpH179qV+EG35SRGfadWNyiGiKrky1Z1nu8=;
	b=Ma9o8yAAOszrcoUwv0JAvjwmi5YVn62TpCA5NIRZzsV+GcO0hMuvXSTGBU++kUsjtCQ0KP
	SvEvXSCi3b4wfIp08MejNwIbYDfxOA7PCAL9U63oagy03VsEA4LurnAj4TqH8UYcMK2v2o
	qO9q3ovXwmfr9G79/wx9o24uwCQA4vO8x6w6WA4fTvJjT/k0ivpr8lH52cWLReylbfqJIR
	hmFNQ7zOCT1W/n5luotdnF/Dj65d6WGGTYzoAsgFVj2gz12FVG4svR3GKtJ06kwVegr67I
	FkvsNMiDngHKwN4CZrvDRLfzwzGRzumnECrMLgcwX6yjHFIl50ZgBY4ioLOfWg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] readahead: use ilog2 instead of a while loop in page_cache_ra_order()
Date: Mon, 15 Jan 2024 11:25:22 +0100
Message-ID: <20240115102523.2336742-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

A while loop is used to adjust the new_order to be lower than the
ra->size. ilog2 could be used to do the same instead of using a loop.

ilog2 typically resolves to a bit scan reverse instruction. This is
particularly useful when ra->size is smaller than the 2^new_order as it
resolves in one instruction instead of looping to find the new_order.

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c81234fa655a..18b23126eb52 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -500,10 +500,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	if (new_order < MAX_PAGECACHE_ORDER) {
 		new_order += 2;
-		if (new_order > MAX_PAGECACHE_ORDER)
-			new_order = MAX_PAGECACHE_ORDER;
-		while ((1 << new_order) > ra->size)
-			new_order--;
+		new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
+		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	}
 
 	filemap_invalidate_lock_shared(mapping);

base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
-- 
2.43.0


