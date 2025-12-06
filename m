Return-Path: <linux-fsdevel+bounces-70928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0CCA9F55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B13300EDC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8262299A8A;
	Sat,  6 Dec 2025 03:09:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02A2957C2;
	Sat,  6 Dec 2025 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764990562; cv=none; b=LIg/I6hYF3Id2/eHTjQrsoDARckZS2rhYqWLeG4eY4Cp2+b6kRwqQSdA2NV2NlB7CNvy1DElNWhAcZOoHJ3B786PmHzcTFam+fXKr2E1Xi85Qid4XxHRcaNpRoNKqAapNKU3BLQh3BIi000dcLgNmvRDXcnw2JZUvzRxNBb5kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764990562; c=relaxed/simple;
	bh=zKcXl1TdUErTysLfipxoxhbS0jSvihrz9qcYnUw2dmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvnopbCZwrD2mRV9f6XlhUaciVe4ZF/xKUr87Fu05Ez8WIbPGVfor/1lkcGJy2bHknB1ig5S90SI8VTCfJhtW1n3eGRg83o8F6E0V7uQqPDvMHXpYDzmc6pvTB3ZWco+ckPTXacZOXxOaYuI6WEI44DG5vMJrx+GBopYiaTUOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dNY9z2JYNz9tv1;
	Sat,  6 Dec 2025 04:09:11 +0100 (CET)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Michal Hocko <mhocko@suse.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	tytso@mit.edu,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 1/3] filemap: set max order to be min order if THP is disabled
Date: Sat,  6 Dec 2025 04:08:56 +0100
Message-ID: <20251206030858.1418814-2-p.raghav@samsung.com>
In-Reply-To: <20251206030858.1418814-1-p.raghav@samsung.com>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Large folios in the page cache depend on the splitting infrastructure from
THP. To remove the dependency between large folios and
CONFIG_TRANSPARENT_HUGEPAGE, set the min order == max order if THP is
disabled. This will make sure the splitting code will not be required
when THP is disabled, therefore, removing the dependency between large
folios and THP.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/pagemap.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..1bb0d4432d4b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -397,9 +397,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline size_t mapping_max_folio_size_supported(void)
 {
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
-	return PAGE_SIZE;
+	return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
 }
 
 /*
@@ -422,16 +420,17 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
 						 unsigned int min,
 						 unsigned int max)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return;
-
 	if (min > MAX_PAGECACHE_ORDER)
 		min = MAX_PAGECACHE_ORDER;
 
 	if (max > MAX_PAGECACHE_ORDER)
 		max = MAX_PAGECACHE_ORDER;
 
-	if (max < min)
+	/* Large folios depend on THP infrastructure for splitting.
+	 * If THP is disabled, we cap the max order to min order to avoid
+	 * splitting the folios.
+	 */
+	if ((max < min) || !IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		max = min;
 
 	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
@@ -463,16 +462,12 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 static inline unsigned int
 mapping_max_folio_order(const struct address_space *mapping)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
 }
 
 static inline unsigned int
 mapping_min_folio_order(const struct address_space *mapping)
 {
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		return 0;
 	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
-- 
2.50.1


