Return-Path: <linux-fsdevel+bounces-13310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917B86E63B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D628DA56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B842873191;
	Fri,  1 Mar 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GTvMRiJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1043FB1D;
	Fri,  1 Mar 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311521; cv=none; b=hs1aZWaJsth9d8I7hILBaetJ0kr2Xg6xT6qF1y8/c0Ph1B3d6qNZO/1EaxRZnd0JzsSm0Z0IBNqiYh8j6egDYL9t7JkXL0HOKUWxyBDl0bnzWfN47Ar1BDEXLgwP/kGRli3u28iO7zfDonS9igrqxQnU39MrB4i5HfsKARaWjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311521; c=relaxed/simple;
	bh=FMbtxZRjXXq41O8f7Gs/qtCnSgbVemzQiH8ZkpI8wCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8t1HrK3Y1Y/ZJfvcUbxRJZOtf5hMFUDnIFrMInHsgRODIwhsou8ap7oGOktPRp/sgwaq96EYmsrbsopTVFm3CcTrLxQ+LgbcsFHnbWovprK9HxQ5sftTYSjiq7Klgu2Vp7zu+Kx67fCPFaAqvyOorNH6jWGgyPbE5IGRawOHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GTvMRiJf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYqJ1Kr0z9tWS;
	Fri,  1 Mar 2024 17:45:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvw2rzk11TxuiUv97J3TlgZt9xwdAbT4PmWWnU5r0+0=;
	b=GTvMRiJfwP1CM9YGAN8fjl3pwLxOZk9Gjl/t9vwy8fr7jW+Wufva3/mOFVv/mPJ1wAqh/X
	2XKnWTgFH/VlymrO7JqlRSExaN9oXj2IOFhR7Y6qPalDbQtLS6T/oWq4uXm3kHimID0E7i
	XfGjXVaUhu6kbuAvHHGrVKvfk7wBZiOMHKUB1jxvSNAGa6OxwxT5bmwHB/hjAmTZLipfiZ
	pkU2S8yLNWUOZ1HtCb5FiUBq/8oK4BURcysJPANZhPHgBabo3bLhcWu89AgRmDqb0SXsDb
	wKOCAZ1pTj+fuvYcuMhbu40x5DSNsukW4ZietZo/NSJfFBrXmRMcDA99zOCd2A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 08/13] readahead: allocate folios with mapping_min_order in ra_(unbounded|order)
Date: Fri,  1 Mar 2024 17:44:39 +0100
Message-ID: <20240301164444.3799288-9-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Allocate folios with at least mapping_min_order in
page_cache_ra_unbounded() and page_cache_ra_order() as we need to
guarantee a minimum order in the page cache.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 mm/readahead.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 65fbb9e78615..4e3a6f763f5c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -210,6 +210,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 	unsigned long i = 0;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
 	 * Partway through the readahead operation, we will have added
@@ -231,6 +232,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		struct folio *folio = xa_load(&mapping->i_pages, index + i);
 
 		if (folio && !xa_is_value(folio)) {
+			long nr_pages = folio_nr_pages(folio);
+
 			/*
 			 * Page already present?  Kick off the current batch
 			 * of contiguous pages before continuing with the
@@ -240,19 +243,31 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 * not worth getting one just for that.
 			 */
 			read_pages(ractl);
-			ractl->_index += folio_nr_pages(folio);
+
+			/*
+			 * Move the ractl->_index by at least min_pages
+			 * if the folio got truncated to respect the
+			 * alignment constraint in the page cache.
+			 *
+			 */
+			if (mapping != folio->mapping)
+				nr_pages = min_nrpages;
+
+			VM_BUG_ON_FOLIO(nr_pages < min_nrpages, folio);
+			ractl->_index += nr_pages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
 					gfp_mask) < 0) {
 			folio_put(folio);
 			read_pages(ractl);
-			ractl->_index++;
+			ractl->_index += min_nrpages;
 			i = ractl->_index + ractl->_nr_pages - index;
 			continue;
 		}
@@ -500,6 +515,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 {
 	struct address_space *mapping = ractl->mapping;
 	pgoff_t index = readahead_index(ractl);
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	int err = 0;
@@ -526,8 +542,13 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
+
+		if (order < min_order)
+			order = min_order;
+
+		VM_BUG_ON(index & ((1UL << order) - 1));
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.43.0


