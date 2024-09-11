Return-Path: <linux-fsdevel+bounces-29119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED7975996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E07E1C23111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2AB1B7917;
	Wed, 11 Sep 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rC42Agfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630151B5313
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076317; cv=none; b=nMppshTd+lqgSQ/vtk/7TV0i3OCF4s0TefCxKiaeD7QbrVy5xdXGt/Owj9G+occ/gVnlRCNZBaaXV16KQ8cOtJ3L36jC/f+RYqo7kBzLl5S79PowN7P0k9Bu3cZsvL+I0uhWKoajUK9a69exdHoATCGnw0fFietOoATSUzRX/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076317; c=relaxed/simple;
	bh=B3XEJ47A+TN3w7pB/zIoKra4vHtux/OwOB1FhKSv00c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bu4iiwTFbdMPhMaDt9/x7zy5FKI667u4KmdFjbFBzVkoBtgH1UzfzYQPwoQbSW8G1EUWWJEwf4gDmnmtzPISizz2IUHlLWhzPChQEaS9ZhuYSVVY4yZf1okJJ/c3SemNFBFEKQEQUtDvlXH6o6jm30A+LewpFDxwuGJloaoimzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rC42Agfr; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726076313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blLN8n4flyGWr3hsLAYet7XCBYXkxyU8EtHvF5BdGSk=;
	b=rC42AgfrSZDE1gM2LisYttlqg2nTsGs+2RjgNNF3idGQLRUNdBK8Q+NACoSlalBr9GJn+J
	HNqqL0okrp5lCmSo9fNBaap9g+Uzh8N+fu0lAwUU35g5gwJjLCX5M7YEuCdIIFcru0UuLT
	8PtzQKKlg/S2/F20cK9EeDnKLV8v/MY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Omar Sandoval <osandov@osandov.com>,
	Chris Mason <clm@fb.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] mm: optimize invalidation of shadow entries
Date: Wed, 11 Sep 2024 10:38:01 -0700
Message-ID: <20240911173801.4025422-3-shakeel.butt@linux.dev>
In-Reply-To: <20240911173801.4025422-1-shakeel.butt@linux.dev>
References: <20240911173801.4025422-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel invalidates the page cache in batches of PAGEVEC_SIZE. For
each batch, it traverses the page cache tree and collects the entries
(folio and shadow entries) in the struct folio_batch. For the shadow
entries present in the folio_batch, it has to traverse the page cache
tree for each individual entry to remove them. This patch optimize this
by removing them in a single tree traversal.

To evaluate the changes, we created 200GiB file on a fuse fs and in a
memcg. We created the shadow entries by triggering reclaim through
memory.reclaim in that specific memcg and measure the simple
fadvise(DONTNEED) operation.

 # time xfs_io -c 'fadvise -d 0 ${file_size}' file

              time (sec)
Without       5.12 +- 0.061
With-patch    4.19 +- 0.086 (18.16% decrease)

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/truncate.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index c7c19c816c2e..793c0d17d7b4 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -23,42 +23,28 @@
 #include <linux/rmap.h>
 #include "internal.h"
 
-/*
- * Regular page slots are stabilized by the page lock even without the tree
- * itself locked.  These unlocked entries need verification under the tree
- * lock.
- */
-static inline void __clear_shadow_entry(struct address_space *mapping,
-				pgoff_t index, void *entry)
-{
-	XA_STATE(xas, &mapping->i_pages, index);
-
-	xas_set_update(&xas, workingset_update_node);
-	if (xas_load(&xas) != entry)
-		return;
-	xas_store(&xas, NULL);
-}
-
 static void clear_shadow_entries(struct address_space *mapping,
-				 struct folio_batch *fbatch, pgoff_t *indices)
+				 unsigned long start, unsigned long max)
 {
-	int i;
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct folio *folio;
 
 	/* Handled by shmem itself, or for DAX we do nothing. */
 	if (shmem_mapping(mapping) || dax_mapping(mapping))
 		return;
 
-	spin_lock(&mapping->host->i_lock);
-	xa_lock_irq(&mapping->i_pages);
+	xas_set_update(&xas, workingset_update_node);
 
-	for (i = 0; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
+	spin_lock(&mapping->host->i_lock);
+	xas_lock_irq(&xas);
 
+	/* Clear all shadow entries from start to max */
+	xas_for_each(&xas, folio, max) {
 		if (xa_is_value(folio))
-			__clear_shadow_entry(mapping, indices[i], folio);
+			xas_store(&xas, NULL);
 	}
 
-	xa_unlock_irq(&mapping->i_pages);
+	xas_unlock_irq(&xas);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
@@ -478,7 +464,9 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		int nr = folio_batch_count(&fbatch);
+
+		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
@@ -505,7 +493,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		}
 
 		if (xa_has_values)
-			clear_shadow_entries(mapping, &fbatch, indices);
+			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
@@ -609,7 +597,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+		int nr = folio_batch_count(&fbatch);
+
+		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
@@ -655,7 +645,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		}
 
 		if (xa_has_values)
-			clear_shadow_entries(mapping, &fbatch, indices);
+			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-- 
2.43.5


