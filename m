Return-Path: <linux-fsdevel+bounces-51930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650AADD2DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCBC3B3662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118A2EA177;
	Tue, 17 Jun 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEwAZKJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73062EA15E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175060; cv=none; b=KFKQSzU0ncdwLzab9+mugrQ4GvGDZU7eb5YuK1dDGyXHghT+7eMf+NGW7pkopfnx8YjB6DfYIzGrfKwFG6kSMMLg1bd5g1UeUzOB6ohbi2kQxm05KNfp6YPrlyu1IjxnmypLYAK1Cw8asCG6eFDJpqmdD7laGWCfJzP5J6d4ADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175060; c=relaxed/simple;
	bh=uAEe2Dwzev9r3qmzV6kZ+4qAK/kSGOMAxFtOCuL/PmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9kxnPHC4JWdGh1x4B0QDZDOcEK0x4fInCekGpNIcECqIVGhzN63EbA7Nz6cGgxzRBGyBwf1rEDJxsdp6NC4xIu4Ouan6aIx6LvGCy1Q4cZ4gbw53dr5c6M+nfk6zqu+51ybkfBXVT4pK1xjUkk4Og+ZuyruBM+Ysj2trCy6uKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEwAZKJ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWxrDUiAyufMO24k5ZrEJY14fbMO3RlCzXis3T5vcIs=;
	b=QEwAZKJ9IInUPbvS/U0yJCjxhC0IJ4MHXYRVGrbzUHUkmG+T1Hcw83IrfbWS65equa768c
	VDjPERIIOUxrc8ntxUXJl/gxF+d6gn2uoFfa3HmZnxp8PDu2ZtFcFe+CLC+ttpNqVlDOZl
	E116J6u4kGyBUi47RLxP206OplxvE9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-Cik_mFO2NMCWmNX08w2eog-1; Tue, 17 Jun 2025 11:44:16 -0400
X-MC-Unique: Cik_mFO2NMCWmNX08w2eog-1
X-Mimecast-MFC-AGG-ID: Cik_mFO2NMCWmNX08w2eog_1750175056
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530623eb8fso42180335e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175055; x=1750779855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWxrDUiAyufMO24k5ZrEJY14fbMO3RlCzXis3T5vcIs=;
        b=upKI+LeA9cAkqsPXbXSgVY+Cg0R3Bip2Xg/1TLK00P9qqphVYWLZ/90f2FcmSF9llX
         FZ6nqCyp7XdOZ/0pmgwZiduoehS8nr8qS+uf8Pe9LtCe2qrSN+mK+MwUS1dE9KvDI7rA
         jG5GXid2mpavVVQzP0jESZG+1DNRmHiGZYAFqkQxsKF/FGqpiiHFGgcGZ9MvKArMpMJa
         yTJT58vqgF9ysRZ1k910g2KJsfV9FscXzY5GG7pJa23pTjryHc9DRPTPe5v6Ne2aKQ/w
         s3GXHH/LVBisaot5vNx93akcrWNsXXO9BkRjvfULqZAVewbZF4AYW627Qb8EPHD4A5Lb
         dO0w==
X-Gm-Message-State: AOJu0YzAgy0jiNCzXS26dvaurAHRGi83OarPtzMyNDYilKEP8ey+jQIk
	SuWARvSd1LymXOgPXQ73MJz1EjEBqVPlj+5f6eltpitNSTmWubSshuqDx+hgMhux8QkXF1PtRnn
	EGQjL1D4Di8aIcde36UF3lxJXQw22WHkbbWPUtyOr+62nSzSKihPkAxy5FLR6MytWmLI=
X-Gm-Gg: ASbGncsg4E0u37bw/PRwl/jA72eE8uBnMcUd32e/HoJX92g1azJLCqTaDZlu4hwHRYI
	fn8eeQ5wdGXmAdWGwQM9NSgDBsc5t2NYvEXw880L5DH0BAUK6gw+k1p3I0XzM4+BtQHVOJ4Nbg1
	YoECfQbfBDsDz2fkFhsCDB0uZbSBru7WaccqSv9ZPVFA54sSDjW0VburZ642+KgUkK350x0t+em
	Ih75GptgNg2d8FOPrWs4WRAp/K23R+LNmtmNMiIM83Q1dW/nqD5TFwR8AFqjccdgYqFCR+YsRzs
	THv4yvvmjVe7FKZUk7+ghUiYmwoeQiR3aCbLicRgieLldSq+dUJZLKXXieTS5HFQ59WU7isYDOr
	rCPmQSA==
X-Received: by 2002:a05:600c:35cc:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-4533ca466e5mr128888165e9.4.1750175055515;
        Tue, 17 Jun 2025 08:44:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxLp1jc85N2QDOuW7BFdm+pgJpsU2NEtjPimOvIk95HaJi7jSUq03BgBarqHz3clTjH8a/dA==
X-Received: by 2002:a05:600c:35cc:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-4533ca466e5mr128887725e9.4.1750175055093;
        Tue, 17 Jun 2025 08:44:15 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e14fc8bsm179773215e9.28.2025.06.17.08.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:14 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH RFC 12/14] mm: drop addr parameter from vm_normal_*_pmd()
Date: Tue, 17 Jun 2025 17:43:43 +0200
Message-ID: <20250617154345.2494405-13-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
References: <20250617154345.2494405-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No longer required, let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 6 +++---
 include/linux/mm.h | 6 ++----
 mm/huge_memory.c   | 4 ++--
 mm/memory.c        | 8 +++-----
 mm/pagewalk.c      | 2 +-
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c4ad3083bbfa0..36ef67cdf7a3b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -861,7 +861,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 
 	if (pmd_present(*pmd)) {
-		page = vm_normal_page_pmd(vma, addr, *pmd);
+		page = vm_normal_page_pmd(vma, *pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
@@ -2177,7 +2177,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_WRITTEN;
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
-			page = vm_normal_page_pmd(vma, addr, pmd);
+			page = vm_normal_page_pmd(vma, pmd);
 			if (page && !PageAnon(page))
 				categories |= PAGE_IS_FILE;
 		}
@@ -2942,7 +2942,7 @@ static struct page *can_gather_numa_stats_pmd(pmd_t pmd,
 	if (!pmd_present(pmd))
 		return NULL;
 
-	page = vm_normal_page_pmd(vma, addr, pmd);
+	page = vm_normal_page_pmd(vma, pmd);
 	if (!page)
 		return NULL;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f52871becd3f..ef709457c7076 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2359,10 +2359,8 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
-struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
-				  unsigned long addr, pmd_t pmd);
-struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
-				pmd_t pmd);
+struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma, pmd_t pmd);
+struct page *vm_normal_page_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 67220c30e7818..bf2aed8d92ec2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1994,7 +1994,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 
 	if (!(vma->vm_flags & VM_SHARED)) {
 		/* See can_change_pte_writable(). */
-		page = vm_normal_page_pmd(vma, addr, pmd);
+		page = vm_normal_page_pmd(vma, pmd);
 		return page && PageAnon(page) && PageAnonExclusive(page);
 	}
 
@@ -2033,7 +2033,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	    can_change_pmd_writable(vma, vmf->address, pmd))
 		writable = true;
 
-	folio = vm_normal_folio_pmd(vma, haddr, pmd);
+	folio = vm_normal_folio_pmd(vma, pmd);
 	if (!folio)
 		goto out_map;
 
diff --git a/mm/memory.c b/mm/memory.c
index ace9c59e97181..34f961024e8e6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -663,8 +663,7 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 }
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
-struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
-				pmd_t pmd)
+struct page *vm_normal_page_pmd(struct vm_area_struct *vma, pmd_t pmd)
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
@@ -676,10 +675,9 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 	return vm_normal_page_pfn(vma, pfn);
 }
 
-struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
-				  unsigned long addr, pmd_t pmd)
+struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma, pmd_t pmd)
 {
-	struct page *page = vm_normal_page_pmd(vma, addr, pmd);
+	struct page *page = vm_normal_page_pmd(vma, pmd);
 
 	if (page)
 		return page_folio(page);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d2..0edb7240d090c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -944,7 +944,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 			spin_unlock(ptl);
 			goto pte_table;
 		} else if (pmd_present(pmd)) {
-			page = vm_normal_page_pmd(vma, addr, pmd);
+			page = vm_normal_page_pmd(vma, pmd);
 			if (page) {
 				goto found;
 			} else if ((flags & FW_ZEROPAGE) &&
-- 
2.49.0


