Return-Path: <linux-fsdevel+bounces-70929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7963CA9F6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA4AF3288AC0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D7299A96;
	Sat,  6 Dec 2025 03:09:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5728CF7C;
	Sat,  6 Dec 2025 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764990568; cv=none; b=eqVS7wZ6XXIT4bynIoUhsPFmMMz4URm4v3WwqPvieN3Z2m1WmXzhxW3W59AXrRCNaTZQYTAH0S4Tljcibg454g+YmD2INHxUJFKEMGfETN4okzbO35x5bMadavjGOVtURpmeqhPMamFSJ0RBbPSqg+cBGA1x2kHwd3Eg0IFnyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764990568; c=relaxed/simple;
	bh=a487cd5EpadzxqRhBf1PDfusbx9jxsmOC9FDsmizOuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucGW+P4rQC8AdKBsWBBYFYWqXHhkfs67Sebbf/0VA0kcjiZ6pAlvuNIVgQj5mllR1RqbhRx7XVzUDBTre07wDXCeu5YnU7g3ASWCE9wkQladOrqzXiQ4aHKxC1LkUCq12QeFBDhsvCqAAXAqsFhkZIu1O3UEbY3vXW9XUGHIEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dNYB4093Rz9v56;
	Sat,  6 Dec 2025 04:09:16 +0100 (CET)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
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
Subject: [RFC v2 2/3] huge_memory: skip warning if min order and folio order are same in split
Date: Sat,  6 Dec 2025 04:08:57 +0100
Message-ID: <20251206030858.1418814-3-p.raghav@samsung.com>
In-Reply-To: <20251206030858.1418814-1-p.raghav@samsung.com>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4dNYB4093Rz9v56

When THP is disabled, file-backed large folios max order is capped to the
min order to avoid using the splitting infrastructure.

Currently, splitting calls will create a warning when called with THP
disabled. But splitting call does not have to do anything when min order
is same as the folio order.

So skip the warning in folio split functions if the min order is same as
the folio order for file backed folios.

Due to issues with circular dependency, move the definition of split
function for !CONFIG_TRANSPARENT_HUGEPAGES to mm/memory.c

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 40 ++++++++--------------------------------
 mm/memory.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 21162493a0a0..71e309f2d26a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -612,42 +612,18 @@ can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
 {
 	return false;
 }
-static inline int
-split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-		unsigned int new_order)
-{
-	VM_WARN_ON_ONCE_PAGE(1, page);
-	return -EINVAL;
-}
-static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
-{
-	VM_WARN_ON_ONCE_PAGE(1, page);
-	return -EINVAL;
-}
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+		unsigned int new_order);
+int split_huge_page_to_order(struct page *page, unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
-	VM_WARN_ON_ONCE_PAGE(1, page);
-	return -EINVAL;
-}
-
-static inline unsigned int min_order_for_split(struct folio *folio)
-{
-	VM_WARN_ON_ONCE_FOLIO(1, folio);
-	return 0;
-}
-
-static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
-{
-	VM_WARN_ON_ONCE_FOLIO(1, folio);
-	return -EINVAL;
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 
-static inline int try_folio_split_to_order(struct folio *folio,
-		struct page *page, unsigned int new_order)
-{
-	VM_WARN_ON_ONCE_FOLIO(1, folio);
-	return -EINVAL;
-}
+unsigned int min_order_for_split(struct folio *folio);
+int split_folio_to_list(struct folio *folio, struct list_head *list);
+int try_folio_split_to_order(struct folio *folio,
+		struct page *page, unsigned int new_order);
 
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
diff --git a/mm/memory.c b/mm/memory.c
index 6675e87eb7dd..4eccdf72a46e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4020,6 +4020,47 @@ static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
 {
 	BUILD_BUG();
 }
+
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+	unsigned int order = mapping_min_folio_order(folio->mapping);
+
+	if (!folio_test_anon(folio) && order == folio_order(folio))
+		return -EINVAL;
+
+	VM_WARN_ON_ONCE_PAGE(1, page);
+	return -EINVAL;
+}
+
+int split_huge_page_to_order(struct page *page, unsigned int new_order)
+{
+	return split_huge_page_to_list_to_order(page, NULL, new_order);
+}
+
+int split_folio_to_list(struct folio *folio, struct list_head *list)
+{
+	unsigned int order = mapping_min_folio_order(folio->mapping);
+
+	if (!folio_test_anon(folio) && order == folio_order(folio))
+		return -EINVAL;
+
+	VM_WARN_ON_ONCE_FOLIO(1, folio);
+	return -EINVAL;
+}
+
+unsigned int min_order_for_split(struct folio *folio)
+{
+	return split_folio_to_list(folio, NULL);
+}
+
+
+int try_folio_split_to_order(struct folio *folio, struct page *page,
+			     unsigned int new_order)
+{
+	return split_folio_to_list(folio, NULL);
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static bool wp_can_reuse_anon_folio(struct folio *folio,
-- 
2.50.1


