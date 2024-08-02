Return-Path: <linux-fsdevel+bounces-24882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5F9460FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DFB1F2255B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160522101AE;
	Fri,  2 Aug 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmfGRusL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540B1E4859
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614173; cv=none; b=G1q32BAstrH17S560VJExGM00nJrI57jlfueAiU6dVxDj7EKbnaYPeAXH9Eckt+spxm75xoYSemNSaCWO+IV04Hp7Tlny4VsKSKZrcznahqwhpgAfWFlTn3G4vcflpTFfzUmusUp7TFJWkRyPl6n04kmecGXJix5AqYfHFGlwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614173; c=relaxed/simple;
	bh=0PHdseon7tXgt7KnjM1V2dOzESCD71xZm07JeIYRqCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOmkYpXBvLb8eAxAMBEhUg9i8TUsd7hdrzEiAC1Tfpezg/jwv4prXgh2Y/UgQRqA8VPm5Gv8fokaM0EtqpWrK+Mk7/Xi4iRn7fnbdNXMfR7VewQjuk8mBSCoy9em4LAnx2+axPC8XnTQtIN+4CtU0DlJzj87oL88FR8qPMvLsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmfGRusL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722614170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGUlr9yCrIjZfp2Jios2/QtrJcjV6+nMbt6NumQJE9A=;
	b=NmfGRusLDsn8ZhFQOcycswqLMDmHQEqOUUo65sb9rgVNE7lgTP/5jmfeAxFXLw5KOVJDY9
	rx2rBCLX0XV/hynkKoQfKdo0AUvFlKD+KZ0QSIljPgAztBSI95J0lUMyvmVSqalxN60qRh
	VNteyYYwFWEv2+Ss+EN1BWhcF6zP/BE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-GL6qdjBaOLKZo_tI8pVNMA-1; Fri,
 02 Aug 2024 11:56:03 -0400
X-MC-Unique: GL6qdjBaOLKZo_tI8pVNMA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9722A1955D4D;
	Fri,  2 Aug 2024 15:55:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 863C5300018D;
	Fri,  2 Aug 2024 15:55:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v1 04/11] mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk
Date: Fri,  2 Aug 2024 17:55:17 +0200
Message-ID: <20240802155524.517137-5-david@redhat.com>
In-Reply-To: <20240802155524.517137-1-david@redhat.com>
References: <20240802155524.517137-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's use folio_walk instead, so we can avoid taking a folio reference
when we won't even be trying to migrate the folio and to get rid of
another follow_page()/FOLL_DUMP user. Use FW_ZEROPAGE so we can return
"-EFAULT" for it as documented.

We now perform the folio_likely_mapped_shared() check under PTL, which
is what we want: relying on the mapcount and friends after dropping the
PTL does not make too much sense, as the page can get unmapped
concurrently from this process.

Further, we perform the folio isolation under PTL, similar to how we
handle it for MADV_PAGEOUT.

The possible return values for follow_page() were confusing, especially
with FOLL_DUMP set. We'll handle it like documented in the man page:
 * -EFAULT: This is a zero page or the memory area is not mapped by the
    process.
 * -ENOENT: The page is not present.

We'll keep setting -ENOENT for ZONE_DEVICE. Maybe not the right thing to
do, but it likely doesn't really matter (just like for weird devmap,
whereby we fake "not present").

The other errros are left as is, and match the documentation in the man
page.

While at it, rename add_page_for_migration() to
add_folio_for_migration().

We'll lose the "secretmem" check, but that shouldn't really matter
because these folios cannot ever be migrated. Should vma_migratable()
refuse these VMAs? Maybe.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 100 +++++++++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 55 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b5365a434ba9..e1383d9cc944 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2112,76 +2112,66 @@ static int do_move_pages_to_node(struct list_head *pagelist, int node)
 	return err;
 }
 
+static int __add_folio_for_migration(struct folio *folio, int node,
+		struct list_head *pagelist, bool migrate_all)
+{
+	if (is_zero_folio(folio) || is_huge_zero_folio(folio))
+		return -EFAULT;
+
+	if (folio_is_zone_device(folio))
+		return -ENOENT;
+
+	if (folio_nid(folio) == node)
+		return 0;
+
+	if (folio_likely_mapped_shared(folio) && !migrate_all)
+		return -EACCES;
+
+	if (folio_test_hugetlb(folio)) {
+		if (isolate_hugetlb(folio, pagelist))
+			return 1;
+	} else if (folio_isolate_lru(folio)) {
+		list_add_tail(&folio->lru, pagelist);
+		node_stat_mod_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			folio_nr_pages(folio));
+		return 1;
+	}
+	return -EBUSY;
+}
+
 /*
- * Resolves the given address to a struct page, isolates it from the LRU and
+ * Resolves the given address to a struct folio, isolates it from the LRU and
  * puts it to the given pagelist.
  * Returns:
- *     errno - if the page cannot be found/isolated
+ *     errno - if the folio cannot be found/isolated
  *     0 - when it doesn't have to be migrated because it is already on the
  *         target node
  *     1 - when it has been queued
  */
-static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
+static int add_folio_for_migration(struct mm_struct *mm, const void __user *p,
 		int node, struct list_head *pagelist, bool migrate_all)
 {
 	struct vm_area_struct *vma;
-	unsigned long addr;
-	struct page *page;
+	struct folio_walk fw;
 	struct folio *folio;
-	int err;
+	unsigned long addr;
+	int err = -EFAULT;
 
 	mmap_read_lock(mm);
 	addr = (unsigned long)untagged_addr_remote(mm, p);
 
-	err = -EFAULT;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !vma_migratable(vma))
-		goto out;
-
-	/* FOLL_DUMP to ignore special (like zero) pages */
-	page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
-
-	err = PTR_ERR(page);
-	if (IS_ERR(page))
-		goto out;
-
-	err = -ENOENT;
-	if (!page)
-		goto out;
-
-	folio = page_folio(page);
-	if (folio_is_zone_device(folio))
-		goto out_putfolio;
-
-	err = 0;
-	if (folio_nid(folio) == node)
-		goto out_putfolio;
-
-	err = -EACCES;
-	if (folio_likely_mapped_shared(folio) && !migrate_all)
-		goto out_putfolio;
-
-	err = -EBUSY;
-	if (folio_test_hugetlb(folio)) {
-		if (isolate_hugetlb(folio, pagelist))
-			err = 1;
-	} else {
-		if (!folio_isolate_lru(folio))
-			goto out_putfolio;
-
-		err = 1;
-		list_add_tail(&folio->lru, pagelist);
-		node_stat_mod_folio(folio,
-			NR_ISOLATED_ANON + folio_is_file_lru(folio),
-			folio_nr_pages(folio));
+	if (vma && vma_migratable(vma)) {
+		folio = folio_walk_start(&fw, vma, addr, FW_ZEROPAGE);
+		if (folio) {
+			err = __add_folio_for_migration(folio, node, pagelist,
+							migrate_all);
+			folio_walk_end(&fw, vma);
+		} else {
+			err = -ENOENT;
+		}
 	}
-out_putfolio:
-	/*
-	 * Either remove the duplicate refcount from folio_isolate_lru()
-	 * or drop the folio ref if it was not isolated.
-	 */
-	folio_put(folio);
-out:
 	mmap_read_unlock(mm);
 	return err;
 }
@@ -2275,8 +2265,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		 * Errors in the page lookup or isolation are not fatal and we simply
 		 * report them via status
 		 */
-		err = add_page_for_migration(mm, p, current_node, &pagelist,
-					     flags & MPOL_MF_MOVE_ALL);
+		err = add_folio_for_migration(mm, p, current_node, &pagelist,
+					      flags & MPOL_MF_MOVE_ALL);
 
 		if (err > 0) {
 			/* The page is successfully queued for migration */
-- 
2.45.2


