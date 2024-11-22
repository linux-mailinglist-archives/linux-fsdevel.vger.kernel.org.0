Return-Path: <linux-fsdevel+bounces-35606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEE9D64F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CEBB2274B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128B189F43;
	Fri, 22 Nov 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx0k6BAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B517B428
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307939; cv=none; b=BDBdGmbmKFEbjAW6UOmFWuXNp4DmtBX2HsDN8ZxX3yN2f0RzXX7woSoerWE1owk3f7l9FqBBHKOOOnXa79agzLBGI2DbdFY2itHkOfMwa3wFG+d/fYP0u5SWvTWirpFda30rO1zON7P/5jWcCQJG4sqn9mNuHMbW53ClFEJxOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307939; c=relaxed/simple;
	bh=4JV/qqNB1CiLSM5H0MLjYsrrHdadzisZfdZ/NnT62Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgSvTfUMW4ZrzzVf9ue7tq+4vqUi3C/pfdOgc0LXGQQ2NfCm7iNUpv83AxTqvy9Atw10b4v3xuVm2Nw4XTljAZDfu4MI8rY8wEJmlXFlOgSCSgajkFfycRf9b53f/yvRpTKabxqmCu9GfQA9TxcG1+uV8kHvbDYpAGhC93Vm/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx0k6BAL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a761e21ddeso8839905ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307937; x=1732912737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nas8eIV96EE2tCIE/RR89rZ3FmEkH4A6p7KtVBi+ag=;
        b=mx0k6BALM93ZTVFprQeVwpCSQhvDaaoy2i5DTfU/cEW/EwnBaUVvskCWfgayE9DFPX
         2yX7bZHmWSDrba39PS2RLswbh+8plRl4XpcAF3jgPZNiBL5lGO55REoaSOl5gDmdT059
         MSZ6Cr6PjmwL/ppaK1S8foZGKW+5d70RMe2I/f69yA2V4Lu6vRBbenv/rtEU6xhpmBzq
         kXcmXvfFcd3vD+oSiBr7rAFLlLelRW+QG6qMe8zOKhZy7GYd0bWOywSTTsT6KISAiChV
         ophbJrxdeURaMhzF2xH4LcDtrlQ/CILaacb3XfPFMWsjFJDer7+fi9+hykCwnOxRd1/I
         Ns6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307937; x=1732912737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nas8eIV96EE2tCIE/RR89rZ3FmEkH4A6p7KtVBi+ag=;
        b=bUqUURSpRw+5z37n+5aGGu2B5dCb6Tlel8R1n0bStdZi0l9H0F82y1D8R6r8rOR8KT
         48JOcenUQK+I5Ns+F0Mq991t21RbmDq5C6Q5py/2sRkb7GElG7dLabuZakrXWS0gS/q2
         vPRJ0BlTvN7ySUhw5Rg7MVcnqIBsWde6qw0e6RukUAuXLSyHEpFHA/bnkyQTVFIKUSNH
         51Ij9HpDxXMQh3tnTDCA2Sb4bn+YFRbEm/OQBLtWfEgokywiLhme5yqqvjF7ZyI39tIH
         UWwnIZtXKYNVizNmesSh+Gppuzt5XinI62oPgi3hNzKC11rQbZ4y6A+t+xb20fuP7gSK
         Eb2A==
X-Gm-Message-State: AOJu0YzgDWAxnlcsiSJBId/bBQKjkq4ktzVcaRDsfhN7UtiVC7JB36ST
	98DpfCYQ3XDSxvskNw+2kvQTIegRQtBi55UaNlYWu+ZqY4IcoWFBXxyA4BPH
X-Gm-Gg: ASbGncsQp/CwXYu6/501K4K3KWRqkbZBKJoFzv1GsXrlcEZ+k6XP32m7aPVlESxBZLU
	3BXiPR8X6cq+r/kJigklFfUAGAfHOl330C0mPqIdfSjdAAne1dSdiORUWoACQVOezXlldph1WfZ
	7nXaXrcouhGZkXnleDoKmrHT9I4A6laSvbWDkMZSUGsapg7Eq+yPTbwoAEOA+IpFe1UChJNHnBY
	oejMUd7GU2ZK9efWc4xl/Bp1FqEn+wSf/mJ1kjbbmlQOGylWnR5Y8C8njfn3rVwApKnF4mObjY=
X-Google-Smtp-Source: AGHT+IH84ZXuguW5NeIKMjIEW1e8CTOIrQYKEK8pZg5bmF51hPpd6+LMDLkZbGnKlu+xUy04ChImeA==
X-Received: by 2002:a05:6e02:1a08:b0:3a7:4700:7c1 with SMTP id e9e14a558f8ab-3a79ad748f5mr52242395ab.12.1732307936778;
        Fri, 22 Nov 2024 12:38:56 -0800 (PST)
Received: from manaslu.cs.wisc.edu (manaslu.cs.wisc.edu. [128.105.15.4])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe52506sm794682173.77.2024.11.22.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 12:38:56 -0800 (PST)
From: Bijan Tabatabai <bijan311@gmail.com>
X-Google-Original-From: Bijan Tabatabai <btabatabai@wisc.edu>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	btabatabai@wisc.edu
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mingo@redhat.com
Subject: [RFC PATCH 3/4] mm: Export functions for writing MM Filesystems
Date: Fri, 22 Nov 2024 14:38:29 -0600
Message-Id: <20241122203830.2381905-4-btabatabai@wisc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122203830.2381905-1-btabatabai@wisc.edu>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exports memory management functions that are useful to memory
managers, so that they can be used in memory management filesystems created
in kernel modules.

Signed-off-by: Bijan Tabatabai <btabatabai@wisc.edu>
---
 arch/x86/include/asm/tlbflush.h | 2 --
 arch/x86/mm/tlb.c               | 1 +
 mm/filemap.c                    | 2 ++
 mm/memory.c                     | 1 +
 mm/mmap.c                       | 2 ++
 mm/pgtable-generic.c            | 1 +
 mm/rmap.c                       | 2 ++
 7 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..9877176d396f 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -57,7 +57,6 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
-#ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
  * lines.
@@ -417,7 +416,6 @@ static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
 {
 }
 #endif
-#endif /* !MODULE */
 
 static inline void __native_tlb_flush_global(unsigned long cr4)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..f054cee7bc7c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1036,6 +1036,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	put_cpu();
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
+EXPORT_SYMBOL_GPL(flush_tlb_mm_range);
 
 
 static void do_flush_tlb_all(void *info)
diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..8532ddd37e7f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -269,6 +269,7 @@ void filemap_remove_folio(struct folio *folio)
 
 	filemap_free_folio(mapping, folio);
 }
+EXPORT_SYMBOL_GPL(filemap_remove_folio);
 
 /*
  * page_cache_delete_batch - delete several folios from page cache
@@ -955,6 +956,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	return xas_error(&xas);
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
+EXPORT_SYMBOL_GPL(__filemap_add_folio);
 
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 				pgoff_t index, gfp_t gfp)
diff --git a/mm/memory.c b/mm/memory.c
index fa2fe3ee0867..23e74a0397fa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -448,6 +448,7 @@ int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
 		pte_free(mm, new);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__pte_alloc);
 
 int __pte_alloc_kernel(pmd_t *pmd)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index d684d8bd218b..1090ef982929 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1780,6 +1780,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.high_limit = mmap_end;
 	return vm_unmapped_area(&info);
 }
+EXPORT_SYMBOL_GPL(generic_get_unmapped_area);
 
 #ifndef HAVE_ARCH_UNMAPPED_AREA
 unsigned long
@@ -1844,6 +1845,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	return addr;
 }
+EXPORT_SYMBOL_GPL(generic_get_unmapped_area_topdown);
 
 #ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711a..1a3b4a86b005 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -304,6 +304,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	rcu_read_unlock();
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(__pte_offset_map);
 
 pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 			     unsigned long addr, spinlock_t **ptlp)
diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..fdade910cc95 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1468,6 +1468,7 @@ void folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
 {
 	__folio_add_file_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
 }
+EXPORT_SYMBOL_GPL(folio_add_file_rmap_ptes);
 
 /**
  * folio_add_file_rmap_pmd - add a PMD mapping to a page range of a folio
@@ -1594,6 +1595,7 @@ void folio_remove_rmap_ptes(struct folio *folio, struct page *page,
 {
 	__folio_remove_rmap(folio, page, nr_pages, vma, RMAP_LEVEL_PTE);
 }
+EXPORT_SYMBOL_GPL(folio_remove_rmap_ptes);
 
 /**
  * folio_remove_rmap_pmd - remove a PMD mapping from a page range of a folio
-- 
2.34.1


