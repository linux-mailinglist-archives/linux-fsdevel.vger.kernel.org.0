Return-Path: <linux-fsdevel+bounces-29118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF44975991
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF402831A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CB1B3F3D;
	Wed, 11 Sep 2024 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sKbgIhC5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E81B1D5E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076308; cv=none; b=S9TN7sXFB4dJsVdmxlNZ7HnTRYGt5KlCexGReVOuJfPqK8ws+0mhBvRZQi3wtIAEylTdEmAQJTmJQ4dqEc1WnKRDZGDJRRpP8yeODADXazfbpBmmfdyKlK+J3Oo/PNuA5ua+MCci1TT/m12JGr/2xfdjRDvEAjRw6kMGaQ08VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076308; c=relaxed/simple;
	bh=qtxnw7qh+1XsyvwzmeOIvcx5EHBYVBzoCXfIw3qb1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr6D8gV4fp+40EDfA9td9QwLyNEne17/tXOhDV/YMQ8FreYCrFBelx6Fzq36AP5fvsQvNZ1ErKQa9RshP+Jm+E2iYsZIU0w+by9nTBkv8bLMEHZ5z/GXNutwzOxDPf/yFMprlYy11wKpIe6/tQcBBhSjmdlj6AWRhFSdIJ7P17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sKbgIhC5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726076305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdRYrmHTTIwJmPoGD8yXUb5ju89WcIe4B/6wB3n+klc=;
	b=sKbgIhC52Z4AaapQANOdJh+4RWQIISni3JuRbutGf66gah7JT7+031Q1R2aM1Bpj+VTBT8
	nbwZfHeHH7PbbmBeviTN+5nXKc+CWO+E0zZytvbJFWeDIzwHkPj7y9eEHhRXwNuIkp6kpk
	m2Fz6RQCzJyk0GVpNWMmMXPusdlaFE8=
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
Subject: [PATCH 1/2] mm: optimize truncation of shadow entries
Date: Wed, 11 Sep 2024 10:38:00 -0700
Message-ID: <20240911173801.4025422-2-shakeel.butt@linux.dev>
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

The kernel truncates the page cache in batches of PAGEVEC_SIZE. For each
batch, it traverses the page cache tree and collects the entries (folio
and shadow entries) in the struct folio_batch. For the shadow entries
present in the folio_batch, it has to traverse the page cache tree for
each individual entry to remove them. This patch optimize this by
removing them in a single tree traversal.

On large machines in our production which run workloads manipulating
large amount of data, we have observed that a large amount of CPUs are
spent on truncation of very large files (100s of GiBs file sizes). More
specifically most of time was spent on shadow entries cleanup, so
optimizing the shadow entries cleanup, even a little bit, has good
impact.

To evaluate the changes, we created 200GiB file on a fuse fs and in a
memcg. We created the shadow entries by triggering reclaim through
memory.reclaim in that specific memcg and measure the simple truncation
operation.

 # time truncate -s 0 file

              time (sec)
Without       5.164 +- 0.059
With-patch    4.21  +- 0.066 (18.47% decrease)

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/truncate.c | 50 +++++++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..c7c19c816c2e 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -72,50 +72,46 @@ static void clear_shadow_entries(struct address_space *mapping,
 static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 				struct folio_batch *fbatch, pgoff_t *indices)
 {
+	XA_STATE(xas, &mapping->i_pages, indices[0]);
+	int nr = folio_batch_count(fbatch);
+	struct folio *folio;
 	int i, j;
-	bool dax;
 
 	/* Handled by shmem itself */
 	if (shmem_mapping(mapping))
 		return;
 
-	for (j = 0; j < folio_batch_count(fbatch); j++)
+	for (j = 0; j < nr; j++)
 		if (xa_is_value(fbatch->folios[j]))
 			break;
 
-	if (j == folio_batch_count(fbatch))
+	if (j == nr)
 		return;
 
-	dax = dax_mapping(mapping);
-	if (!dax) {
-		spin_lock(&mapping->host->i_lock);
-		xa_lock_irq(&mapping->i_pages);
+	if (dax_mapping(mapping)) {
+		for (i = j; i < nr; i++) {
+			if (xa_is_value(fbatch->folios[i]))
+				dax_delete_mapping_entry(mapping, indices[i]);
+		}
+		goto out;
 	}
 
-	for (i = j; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
-		pgoff_t index = indices[i];
-
-		if (!xa_is_value(folio)) {
-			fbatch->folios[j++] = folio;
-			continue;
-		}
+	xas_set_update(&xas, workingset_update_node);
 
-		if (unlikely(dax)) {
-			dax_delete_mapping_entry(mapping, index);
-			continue;
-		}
+	spin_lock(&mapping->host->i_lock);
+	xas_lock_irq(&xas);
 
-		__clear_shadow_entry(mapping, index, folio);
+	xas_for_each(&xas, folio, indices[nr-1]) {
+		if (xa_is_value(folio))
+			xas_store(&xas, NULL);
 	}
 
-	if (!dax) {
-		xa_unlock_irq(&mapping->i_pages);
-		if (mapping_shrinkable(mapping))
-			inode_add_lru(mapping->host);
-		spin_unlock(&mapping->host->i_lock);
-	}
-	fbatch->nr = j;
+	xas_unlock_irq(&xas);
+	if (mapping_shrinkable(mapping))
+		inode_add_lru(mapping->host);
+	spin_unlock(&mapping->host->i_lock);
+out:
+	folio_batch_remove_exceptionals(fbatch);
 }
 
 /**
-- 
2.43.5


