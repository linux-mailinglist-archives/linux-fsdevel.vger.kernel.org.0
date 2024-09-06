Return-Path: <linux-fsdevel+bounces-28890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19796FE4F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 01:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052561C21E52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC115B125;
	Fri,  6 Sep 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UwaGGXZk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11AC1B85DC
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663937; cv=none; b=T/49am8K5M94WJHBo5z1S9IL40B4TV117jS01hloMXMnqx5Ffnfwsxf6qNHCAkaQ6ZX1lOk4URalkutpUoHRWvBDdvRdOIRqNTPB3Rq3ocDzVfxoVs+4zAKOpj9Ab7DrYSaCqT1MTsxmpuks1Y6EExj9kf+mrot4aQSmBkxm5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663937; c=relaxed/simple;
	bh=jTUoZYycIeut4S8sadLlwjtbwK1QvoH+O7/jgdB1c9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfxxtP8EfyDrY38THOcVp3PrjIj+cTxaxGlPj/+kjul9sQHHMvNISsvXm+hxwRl0Ql82fB6SDouRlPndBgQKC+tz4JlgVbXsUgnK7Dn7N0l//DUbF0FqsoWKInOPZu2y80MD5nHgfBCFOodcqsdC4ARbqthahZKm0j7zqhOBdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UwaGGXZk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725663930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UXsA7JIUtdewb9efDW2qtqZcJCZNaaCVs6rSPdPNFlk=;
	b=UwaGGXZksKdpWGS/XwT8uzeptMqy69/DEemlXIe3a0cnaLw4fR6ucXBGs67wwJgfBv4umB
	QGyr36p8W/4UutTAmBMO1FAkadXRxsBmSUa53FAV7DjfBgfJSdEUA08gUPhl4MdjwFuBDU
	K0RNWcV7rQDJ7YA+rEER0FyisbeiATc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: replace xa_get_order with xas_get_order where appropriate
Date: Fri,  6 Sep 2024 16:05:12 -0700
Message-ID: <20240906230512.124643-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The tracing of invalidation and truncation operations on large files
showed that xa_get_order() is among the top functions where kernel
spends a lot of CPUs. xa_get_order() needs to traverse the tree to reach
the right node for a given index and then extract the order of the
entry. However it seems like at many places it is being called within an
already happening tree traversal where there is no need to do another
traversal. Just use xas_get_order() at those places.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/filemap.c | 6 +++---
 mm/shmem.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 070dee9791a9..7e3412941a8d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2112,7 +2112,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
 					folio);
 		} else {
-			nr = 1 << xa_get_order(&mapping->i_pages, xas.xa_index);
+			nr = 1 << xas_get_order(&xas);
 			base = xas.xa_index & ~(nr - 1);
 			/* Omit order>0 value which begins before the start */
 			if (base < *start)
@@ -3001,7 +3001,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
 {
 	if (xa_is_value(folio))
-		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
+		return PAGE_SIZE << xas_get_order(xas);
 	return folio_size(folio);
 }
 
@@ -4297,7 +4297,7 @@ static void filemap_cachestat(struct address_space *mapping,
 		if (xas_retry(&xas, folio))
 			continue;
 
-		order = xa_get_order(xas.xa, xas.xa_index);
+		order = xas_get_order(&xas);
 		nr_pages = 1 << order;
 		folio_first_index = round_down(xas.xa_index, 1 << order);
 		folio_last_index = folio_first_index + nr_pages - 1;
diff --git a/mm/shmem.c b/mm/shmem.c
index 866d46d0c43d..4002c4f47d4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -893,7 +893,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
-			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
+			swapped += 1 << xas_get_order(&xas);
 		if (xas.xa_index == max)
 			break;
 		if (need_resched()) {
-- 
2.43.5


