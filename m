Return-Path: <linux-fsdevel+bounces-21193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B290036C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190101C22F74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BD194A4B;
	Fri,  7 Jun 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN+JgBYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F49194133
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763053; cv=none; b=XJZtQQioTxv4jKx2eJV9nkzQ2TDJbOq5v7RF4+X48yBuzSpDMug9vmvD2Hh8W/3EijAoHuMx+o8WX9qnLZsp5nOArlTkruW6vICcBobU/zLmT9mRdyoaFMfhqX3OLJGYooLQ+2Jo+o4KNQfLXEW5smnROvsC/DvFCONTJhSOFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763053; c=relaxed/simple;
	bh=Ec4k3e66hg4z9z133SHENd5EvlVIm84PgrgP6E8dHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBQdxD+iKdU3KWPSIaF7dD2ym5pAloXvf60CCufMeNG68pHA9yPVmVNeetepX6EouOf5K32pD6bUmNa2ajZoLr5QjEOyCjg3ZDFCoNZCyqiJUBU7+/RCJ/W4OT4h4zcVoZ46FbDXj+Fsd4cd5InRK7qeej5PjgoaV9w4Apkl/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iN+JgBYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovOsFhoeBcVzjRXyHZJ60IBLz8Imu+IZUpS2p2waMJI=;
	b=iN+JgBYUshaQQ8lnzBSn1ka5dpNDzAm+kbm2wdBQ+ghG5GpxwqKK7JjkQLrhj/Woe0UZ16
	LQMNP+81rujmUJO3KYjnMX7bKItoJme6LcaFO/WpdlnM4LkwvIgOpK2sQ8HO3UlvMhFLjT
	sorpQrUxEsYhuh/2WSK8JvnIjCiTIwM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-Fs9Zz3hfOzmviTqkwaPypg-1; Fri,
 07 Jun 2024 08:24:05 -0400
X-MC-Unique: Fs9Zz3hfOzmviTqkwaPypg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B888A1C05129;
	Fri,  7 Jun 2024 12:24:04 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A76D492BCD;
	Fri,  7 Jun 2024 12:24:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate PM_MMAP_EXCLUSIVE without PM_PRESENT
Date: Fri,  7 Jun 2024 14:23:53 +0200
Message-ID: <20240607122357.115423-3-david@redhat.com>
In-Reply-To: <20240607122357.115423-1-david@redhat.com>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Relying on the mapcount for non-present PTEs that reference pages
doesn't make any sense: they are not accounted in the mapcount, so
page_mapcount() == 1 won't return the result we actually want to know.

While we don't check the mapcount for migration entries already, we
could end up checking it for swap, hwpoison, device exclusive, ...
entries, which we really shouldn't.

There is one exception: device private entries, which we consider
fake-present (e.g., incremented the mapcount). But we won't care about
that for now for PM_MMAP_EXCLUSIVE, because indicating PM_SWAP for them
although they are fake-present already sounds suspiciously wrong.

Let's never indicate PM_MMAP_EXCLUSIVE without PM_PRESENT.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 08465b904ced5..40e38bc33a9d2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1415,7 +1415,6 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 {
 	u64 frame = 0, flags = 0;
 	struct page *page = NULL;
-	bool migration = false;
 
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
@@ -1447,7 +1446,6 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			    (offset << MAX_SWAPFILES_SHIFT);
 		}
 		flags |= PM_SWAP;
-		migration = is_migration_entry(entry);
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
 		if (pte_marker_entry_uffd_wp(entry))
@@ -1456,7 +1454,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 
 	if (page && !PageAnon(page))
 		flags |= PM_FILE;
-	if (page && !migration && page_mapcount(page) == 1)
+	if (page && (flags & PM_PRESENT) && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
@@ -1473,7 +1471,6 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	pte_t *pte, *orig_pte;
 	int err = 0;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	bool migration = false;
 
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
@@ -1517,14 +1514,13 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			if (pmd_swp_uffd_wp(pmd))
 				flags |= PM_UFFD_WP;
 			VM_BUG_ON(!is_pmd_migration_entry(pmd));
-			migration = is_migration_entry(entry);
 			page = pfn_swap_entry_to_page(entry);
 		}
 #endif
 
 		if (page && !PageAnon(page))
 			flags |= PM_FILE;
-		if (page && !migration && page_mapcount(page) == 1)
+		if (page && (flags & PM_PRESENT) && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
 		for (; addr != end; addr += PAGE_SIZE) {
-- 
2.45.2


