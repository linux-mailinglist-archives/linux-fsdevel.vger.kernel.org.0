Return-Path: <linux-fsdevel+bounces-51503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30FAD7444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAC7B2586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC7258CF5;
	Thu, 12 Jun 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="grviRRGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5F24DD01
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739154; cv=none; b=UYhRFPYa6FgAvfFzX004DQx2YhSxfiZV9AKE3+8jkeK+heMBFglmCsr/5Op1fyRrI/tJMDZqv6MUFU3LdkfOGp2PCy71CZ6X/QmwZaN+qXjS9HQ6TQgz5IQiUgUiLAtGO6DAd7ITWBGb2ejrA+sS7g2KVlVqKiYjk5MXAAYh3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739154; c=relaxed/simple;
	bh=s9o5ZuF5GFow2CXrhQUkr/+66WSjXUF7EHQpCO1n3Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt9E8kkidAVtqBFuGmrYFjuN+/LDmwDCH6C3uHG0DlHyNLE8ft/TnZE+Kg8mz1MLgxyqhvhibYLc4yxa9Kuwy2dgarH2L9q+3Nd++Dzb0Zi9XDBvZuZznPiytqNCI4/XoZdorPJXksPALxmAFunlKYHewNLoj3aH7ZLWqpylfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=grviRRGv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UtDO6pUUhMQHps6x21x9mgsrsqfCfgpOGbWgDUBxgag=; b=grviRRGvqnNmErNrmNw0K+pzvy
	1+BVnbO/Jd5YGDTkiVRd59xGRh0qhSk2a/IqvHr0spvHPh+Kt8YNaYdChUOtIG7mHobXN+mlVyayN
	sgiEwfg6u5QmlK/em0J+J+Ks2vnC7XK/XZO260FQRnBnXT7QJZeVjT4VsbaSd8BoKX8utxcp6nFsL
	Dvoe5IPWck6rJa767Yhx3A5S/Ki3qSaRMquPX/v6r3ir4P4yERay/Z5aa34gcdeWBy6KfGOsjHD29
	PAN/Ba6h0RqIUrQ6oCSvZy6r4Cr8DFrcQ2LogNh+JVuOgsbd5MBQ78xcwBqqPa2ENFsDEUyW960ik
	pFe7wMNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj57-0000000BxEe-1QtV;
	Thu, 12 Jun 2025 14:39:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Phillip Lougher <phillip@squashfs.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] squashfs: Use folios in squashfs_bio_read_cached()
Date: Thu, 12 Jun 2025 15:39:01 +0100
Message-ID: <20250612143903.2849289-3-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143903.2849289-1-willy@infradead.org>
References: <20250612143903.2849289-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an access to page->mapping and a few calls to the old page-based
APIs.  This doesn't support large folios, but it's still a nice
improvement.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/block.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 3061043e915c..296c5a0fcc40 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -80,23 +80,22 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 		struct address_space *cache_mapping, u64 index, int length,
 		u64 read_start, u64 read_end, int page_count)
 {
-	struct page *head_to_cache = NULL, *tail_to_cache = NULL;
+	struct folio *head_to_cache = NULL, *tail_to_cache = NULL;
 	struct block_device *bdev = fullbio->bi_bdev;
 	int start_idx = 0, end_idx = 0;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;;
 	struct bio *bio = NULL;
-	struct bio_vec *bv;
 	int idx = 0;
 	int err = 0;
 #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
-	struct page **cache_pages = kmalloc_array(page_count,
+	struct folio **cache_folios = kmalloc_array(page_count,
 			sizeof(void *), GFP_KERNEL | __GFP_ZERO);
 #endif
 
-	bio_for_each_segment_all(bv, fullbio, iter_all) {
-		struct page *page = bv->bv_page;
+	bio_for_each_folio_all(fi, fullbio) {
+		struct folio *folio = fi.folio;
 
-		if (page->mapping == cache_mapping) {
+		if (folio->mapping == cache_mapping) {
 			idx++;
 			continue;
 		}
@@ -111,13 +110,13 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 		 * adjacent blocks.
 		 */
 		if (idx == 0 && index != read_start)
-			head_to_cache = page;
+			head_to_cache = folio;
 		else if (idx == page_count - 1 && index + length != read_end)
-			tail_to_cache = page;
+			tail_to_cache = folio;
 #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
 		/* Cache all pages in the BIO for repeated reads */
-		else if (cache_pages)
-			cache_pages[idx] = page;
+		else if (cache_folios)
+			cache_folios[idx] = folio;
 #endif
 
 		if (!bio || idx != end_idx) {
@@ -150,45 +149,45 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 		return err;
 
 	if (head_to_cache) {
-		int ret = add_to_page_cache_lru(head_to_cache, cache_mapping,
+		int ret = filemap_add_folio(cache_mapping, head_to_cache,
 						read_start >> PAGE_SHIFT,
 						GFP_NOIO);
 
 		if (!ret) {
-			SetPageUptodate(head_to_cache);
-			unlock_page(head_to_cache);
+			folio_mark_uptodate(head_to_cache);
+			folio_unlock(head_to_cache);
 		}
 
 	}
 
 	if (tail_to_cache) {
-		int ret = add_to_page_cache_lru(tail_to_cache, cache_mapping,
+		int ret = filemap_add_folio(cache_mapping, tail_to_cache,
 						(read_end >> PAGE_SHIFT) - 1,
 						GFP_NOIO);
 
 		if (!ret) {
-			SetPageUptodate(tail_to_cache);
-			unlock_page(tail_to_cache);
+			folio_mark_uptodate(tail_to_cache);
+			folio_unlock(tail_to_cache);
 		}
 	}
 
 #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
-	if (!cache_pages)
+	if (!cache_folios)
 		goto out;
 
 	for (idx = 0; idx < page_count; idx++) {
-		if (!cache_pages[idx])
+		if (!cache_folios[idx])
 			continue;
-		int ret = add_to_page_cache_lru(cache_pages[idx], cache_mapping,
+		int ret = filemap_add_folio(cache_mapping, cache_folios[idx],
 						(read_start >> PAGE_SHIFT) + idx,
 						GFP_NOIO);
 
 		if (!ret) {
-			SetPageUptodate(cache_pages[idx]);
-			unlock_page(cache_pages[idx]);
+			folio_mark_uptodate(cache_folios[idx]);
+			folio_unlock(cache_folios[idx]);
 		}
 	}
-	kfree(cache_pages);
+	kfree(cache_folios);
 out:
 #endif
 	return 0;
-- 
2.47.2


