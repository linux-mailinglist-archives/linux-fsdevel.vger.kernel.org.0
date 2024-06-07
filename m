Return-Path: <linux-fsdevel+bounces-21196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD0900376
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A01F26D71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75C195FF2;
	Fri,  7 Jun 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaUVz8B4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DC194ACC
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763056; cv=none; b=Y6IiyLrMo0eXjFyzuornpr4rsg9hLdP2uqsA+AsjXx91tTiZWD0uINH9zB0XmB7o936RWAq9H5rAQg5pzLEbeliqzWOqDb3xH0hk4DKAZLnntZc1e0MO4yQfTJakJBTc2taybyX5CjXys5b4ulkzcxGsApTusqWC56oD21XKUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763056; c=relaxed/simple;
	bh=tqRveSp+nk5b1gcqOA9DfmBAfkuN9S+BMP+/LLSkI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUFqWEvOznaKwSMUnqerudnAQ8itBUxYbi6q+uXHAPzFOnF1cQSjPB0OGfSpHyuOyxkALa1M8rb3LA4siDgHdo/jMloh7AEMq/JpTTX77VgjLMZdOf0AG2sYJnP9iVNYRz9FTWlNFWrqKkm7zYoQHzWfDIJCoh21XJYVBxdk4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaUVz8B4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx3Qbyh+Nn+bqmSyWmDh1sWt/uN/FzGydIKvFJPogXs=;
	b=DaUVz8B4PDHFZElIimfwp9ogm/PfWgrA6tI4y1pdoTY5diVnbNa0tG1nfwf/Fs7DzQ2FIo
	H25ASjuY7O0i2QulH4HqZUUkwLleVcmQZBXMa+092fNRdqSibmd6oXoUCiQuEYOF2maQRe
	dyWPO65Gqe9WpjmHNKvGW9eP973regM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-FRJ1tLmeM4SPq5VPjh0mRQ-1; Fri, 07 Jun 2024 08:24:08 -0400
X-MC-Unique: FRJ1tLmeM4SPq5VPjh0mRQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A49BC811E79;
	Fri,  7 Jun 2024 12:24:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0098492BD0;
	Fri,  7 Jun 2024 12:24:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 3/6] fs/proc/task_mmu: properly detect PM_MMAP_EXCLUSIVE per page of PMD-mapped THPs
Date: Fri,  7 Jun 2024 14:23:54 +0200
Message-ID: <20240607122357.115423-4-david@redhat.com>
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

We added PM_MMAP_EXCLUSIVE in 2015 via commit 77bb499bb60f ("pagemap: add
mmap-exclusive bit for marking pages mapped only here"), when THPs could
not be partially mapped and page_mapcount() returned something
that was true for all pages of the THP.

In 2016, we added support for partially mapping THPs via
commit 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping
of THPs") but missed to determine PM_MMAP_EXCLUSIVE as well per page.

Checking page_mapcount() on the head page does not tell the whole story.

We should check each individual page. In a future without per-page
mapcounts it will be different, but we'll change that to be consistent
with PTE-mapped THPs once we deal with that.

Fixes: 53f9263baba6 ("mm: rework mapcount accounting to enable 4k mapping of THPs")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 40e38bc33a9d2..f427176ce2c34 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1474,6 +1474,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 	ptl = pmd_trans_huge_lock(pmdp, vma);
 	if (ptl) {
+		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
 		u64 flags = 0, frame = 0;
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
@@ -1490,8 +1491,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			if (pmd_uffd_wp(pmd))
 				flags |= PM_UFFD_WP;
 			if (pm->show_pfn)
-				frame = pmd_pfn(pmd) +
-					((addr & ~PMD_MASK) >> PAGE_SHIFT);
+				frame = pmd_pfn(pmd) + idx;
 		}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 		else if (is_swap_pmd(pmd)) {
@@ -1500,11 +1500,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 			if (pm->show_pfn) {
 				if (is_pfn_swap_entry(entry))
-					offset = swp_offset_pfn(entry);
+					offset = swp_offset_pfn(entry) + idx;
 				else
-					offset = swp_offset(entry);
-				offset = offset +
-					((addr & ~PMD_MASK) >> PAGE_SHIFT);
+					offset = swp_offset(entry) + idx;
 				frame = swp_type(entry) |
 					(offset << MAX_SWAPFILES_SHIFT);
 			}
@@ -1520,12 +1518,16 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		if (page && !PageAnon(page))
 			flags |= PM_FILE;
-		if (page && (flags & PM_PRESENT) && page_mapcount(page) == 1)
-			flags |= PM_MMAP_EXCLUSIVE;
 
-		for (; addr != end; addr += PAGE_SIZE) {
-			pagemap_entry_t pme = make_pme(frame, flags);
+		for (; addr != end; addr += PAGE_SIZE, idx++) {
+			unsigned long cur_flags = flags;
+			pagemap_entry_t pme;
+
+			if (page && (flags & PM_PRESENT) &&
+			    page_mapcount(page + idx) == 1)
+				cur_flags |= PM_MMAP_EXCLUSIVE;
 
+			pme = make_pme(frame, cur_flags);
 			err = add_to_pagemap(&pme, pm);
 			if (err)
 				break;
-- 
2.45.2


