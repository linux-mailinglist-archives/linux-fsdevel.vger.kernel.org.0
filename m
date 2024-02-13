Return-Path: <linux-fsdevel+bounces-11338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610FF852C83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161B8287DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DECF38DDA;
	Tue, 13 Feb 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="q+QdcRp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98353717D;
	Tue, 13 Feb 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817062; cv=none; b=lFkCJ4jp9HkVLEC0CY3A33K+5FjMA2kWuEQ6a8eckXhX8WC54WN3xeGkAcltp6R+9kG8xFeYfdIUoOfQXK6zYmng8HtVV/6TfEI9zCXo2+VlQCD+Getd5JPsq5CzD/ruZeR9q4oLCZbgsk2eAyD8lYVgXbMVDW1IkLT8RAJ3FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817062; c=relaxed/simple;
	bh=5Tcmh5wX4+jbi1nAENBTznd19HcP0yxR7V36BhmJnQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DieC8/CbYUbwdN2tKkpa+Pr+FAYButNcK3hu/iWfCa2J38WAPEhePkRd6vcWs3XLpTE3dpCMc3dMl8SnM4JcJCqZOdLHg/4jsbMbR3UNNiLgAZcRpg7H7bvV75JDq6l+WaakPe+2bhNVpW0qOBhziLuSBXR6dHQQRv/0Iuftt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=q+QdcRp9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TYx7h610nz9sp2;
	Tue, 13 Feb 2024 10:37:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2fO/D/MPNOVLZ/qHSRb69SYJGOgunRGzbPIdUcBFeY=;
	b=q+QdcRp9VMFfzBuHWmwG0y4c6GTja5nXRvH9aAJ/+ewY7aP/tIt9Dp0+UfOMBoqce1hD6r
	4Jr9W7xXq0c5XSbK3Y2hbZrDNo/2DpL4R/2wGRvMP0RY1PSm+kdlNNZopEmK/dOkqMb5CQ
	QTAmRx5ZdiGchLWnc+Dw0wyZ6d5eD6QTsN5x23PoMUnXNKkk0pbacHYf/5S1hQFRYemGuR
	9i+kZrTl/z6yLaQCs78brNS7z1wN+GvZgsWUiCXs3qO0ElouvrUdzXa0IKodiwYR5QLZ59
	gBxcaEjI6JuH8GEXz/8F7YnQUXYe9S3rD1b7DEMAcw07PdMjtyAMdrCImC2L8g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 05/14] readahead: align index to mapping_min_order in ondemand_ra and force_ra
Date: Tue, 13 Feb 2024 10:37:04 +0100
Message-ID: <20240213093713.1753368-6-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx7h610nz9sp2

From: Luis Chamberlain <mcgrof@kernel.org>

Align the ra->start and ra->size to mapping_min_order in
ondemand_readahead(), and align the index to mapping_min_order in
force_page_cache_ra(). This will ensure that the folios allocated for
readahead that are added to the page cache are aligned to
mapping_min_order.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 4fa7d0e65706..5e1ec7705c78 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -315,6 +315,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -324,6 +325,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * be up to the optimal hardware IO size
 	 */
 	index = readahead_index(ractl);
+	if (!IS_ALIGNED(index, min_nrpages)) {
+		unsigned long old_index = index;
+
+		index = round_down(index, min_nrpages);
+		nr_to_read += (old_index - index);
+	}
+
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
@@ -332,6 +340,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		ractl->_index = index;
+		VM_BUG_ON(!IS_ALIGNED(index, min_nrpages));
 		do_page_cache_ra(ractl, this_chunk, 0);
 
 		index += this_chunk;
@@ -344,11 +353,20 @@ void force_page_cache_ra(struct readahead_control *ractl,
  * for small size, x 4 for medium, and x 2 for large
  * for 128k (32 page) max ra
  * 1-2 page = 16k, 3-4 page 32k, 5-8 page = 64k, > 8 page = 128k initial
+ *
+ * For higher order address space requirements we ensure no initial reads
+ * are ever less than the min number of pages required.
+ *
+ * We *always* cap the max io size allowed by the device.
  */
-static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
+static unsigned long get_init_ra_size(unsigned long size,
+				      unsigned int min_nrpages,
+				      unsigned long max)
 {
 	unsigned long newsize = roundup_pow_of_two(size);
 
+	newsize = max_t(unsigned long, newsize, min_nrpages);
+
 	if (newsize <= max / 32)
 		newsize = newsize * 4;
 	else if (newsize <= max / 4)
@@ -356,6 +374,8 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 	else
 		newsize = max;
 
+	VM_BUG_ON(newsize & (min_nrpages - 1));
+
 	return newsize;
 }
 
@@ -364,14 +384,16 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
  *  return it as the new window size.
  */
 static unsigned long get_next_ra_size(struct file_ra_state *ra,
+				      unsigned int min_nrpages,
 				      unsigned long max)
 {
-	unsigned long cur = ra->size;
+	unsigned long cur = max(ra->size, min_nrpages);
 
 	if (cur < max / 16)
 		return 4 * cur;
 	if (cur <= max / 2)
 		return 2 * cur;
+
 	return max;
 }
 
@@ -561,7 +583,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
-	unsigned int order = folio ? folio_order(folio) : 0;
+	unsigned int min_order = mapping_min_folio_order(ractl->mapping);
+	unsigned int min_nrpages = mapping_min_folio_nrpages(ractl->mapping);
+	unsigned int order = folio ? folio_order(folio) : min_order;
+
+	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -583,8 +609,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	expected = round_down(ra->start + ra->size - ra->async_size,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
-		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->start += round_down(ra->size, min_nrpages);
+		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -603,13 +629,18 @@ static void ondemand_readahead(struct readahead_control *ractl,
 				max_pages);
 		rcu_read_unlock();
 
+		start = round_down(start, min_nrpages);
+
+		VM_BUG_ON(folio->index & (folio_nr_pages(folio) - 1));
+
 		if (!start || start - index > max_pages)
 			return;
 
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
+
 		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = get_next_ra_size(ra, min_nrpages, max_pages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -646,7 +677,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 
 initial_readahead:
 	ra->start = index;
-	ra->size = get_init_ra_size(req_size, max_pages);
+	ra->size = get_init_ra_size(req_size, min_nrpages, max_pages);
 	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
 
 readit:
@@ -657,7 +688,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Take care of maximum IO pages as above.
 	 */
 	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
+		add_pages = get_next_ra_size(ra, min_nrpages, max_pages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
 			ra->size += add_pages;
@@ -668,6 +699,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
+	VM_BUG_ON(!IS_ALIGNED(ractl->_index, min_nrpages));
 	page_cache_ra_order(ractl, ra, order);
 }
 
-- 
2.43.0


