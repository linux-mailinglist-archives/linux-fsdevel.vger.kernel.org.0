Return-Path: <linux-fsdevel+bounces-51926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0AADD2CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B5B3A57E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D162DFF23;
	Tue, 17 Jun 2025 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LA5nN60J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B302ECEB4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175053; cv=none; b=LsUvonMy7UOMqNmPIsXuUhOPGaMqXiEL/TBcHU/bdx3VvEClhpEkp7hFNOXKHjPHY66wMqg4xx1AS74j1jaFUbVdwhE/m2zfWtSWvcCfc22iqZdGDABgu3FARaggJVt/i8FrdQflfE0InGJDZen60FrtG7eTUYqfUeAOJ60aoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175053; c=relaxed/simple;
	bh=Qesw7FWBdB790FSeVsoF7pLTin07jZCKibjTFQ1N/4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0FrgIKoSfU8emHT6K5oOxOiOJ+16JWt/hdCGOnr6/oPPf4CwW83VIgk1lj0olwmFY33EtWGFADIkRXbVlYQxJr/Qi9V06X4indclRHirjvbHQMx1X2Zc8RYkLcaajkIr+yOwHNFfAn1H6M0Ux67wQkwpXoNN0Ah+rNonTaeBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LA5nN60J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8pCpCuV3SHMatGSJCijHr+IJztx1AQFgmUpAFfOuvk=;
	b=LA5nN60J85cVeuPFax7G1hLDhovss6toL7z3FuK/B/0nfvjQEr4AYa+NzdJ5vy9PABVyfU
	69QPGC0845mH9l+dtoMA9txw8MCdt+m0xWYlEpW5qzB2xuJcask76bbacfHEvUmQMo+yAC
	xAm+o0MKmyPsXhsnA2AQOdSkHUT+WOQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-FRQSVKexPPiOWnziAOMvFQ-1; Tue, 17 Jun 2025 11:44:08 -0400
X-MC-Unique: FRQSVKexPPiOWnziAOMvFQ-1
X-Mimecast-MFC-AGG-ID: FRQSVKexPPiOWnziAOMvFQ_1750175047
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so32906845e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175047; x=1750779847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8pCpCuV3SHMatGSJCijHr+IJztx1AQFgmUpAFfOuvk=;
        b=H3Rs0HNYHwE/MQ2BwDQ27CIFVArsgDQtJ6hqjoI6L+tEusRGIQ/+kgU8YRHUIUyke8
         aNtQO6IcEi4GmGJS9x8+i7VmeTiftVG9jD9EO9VHOb1qW5qJY/aiS9ZTmiuIqGocPTRL
         4aUY487aKM0LZ8QUKHUlTsznMS/ba/L+sVyuSpxyIibI11HyQXtS2ERnxSIXNRHPfZzN
         xOdA1ujFxlXb8aLeMoiyf2RkItv/FK0WkvHAT7NG+Xo39avlK2+gIHBH/1naDqkkudD2
         di8s0L+M43lfckhsIHsLj0GcTWNI69rI3Kmbj9U9gsdwLz9cN6yP/bqYVe0KDWxdVXGX
         /GDw==
X-Gm-Message-State: AOJu0Yyq0idJkB8X1Fpf6/rXF4vGR3H3r5T5VFXrFAFOdkPJ+VVfuKk9
	RHdwDMscB3gnQwEzLcdYhNeWPvRIQKe8hOoBT9K9mjmRXNc7xbs+WiBKATRrvEBBFX/zItQHvxC
	kr9paTnRU3D1xMpxX9bwoVFvzhiLbnCq7rhmaVvsYhFBnLFt8EMRhx1j91yklh6u/+oE=
X-Gm-Gg: ASbGncv+AIoC1qA/VLNX3479h1dCbtnbrunWqXzlxaUKgaw80gSRtzaJW6pbAjtHCNm
	4LLU0uAM3rellRu0Oc0LzL4reEwof+cqid972ePW9HsHLLT8lBgCMtyhZdkBv/e0DQ2X+OkeNM0
	vhl6OtyqbsaSiE32RROnd6Iv2kfxyLmkPxPAViU2rxvWNF2VU7kKqYzDInDKtAmsRmaX4/riK9B
	VDFMdoKI5yhq3SEE7awqCX434j4SuVv8VATjsTm+CvdfGe1ezBFvXllb5Hphjy5PHT2tYcf/992
	2jAo/Li2w19X6GzkGsdkn9K0XuJuVEXAd62QaQpDMWCFlHNA29sfPWkoUiPKUAIDasY4UB6L2og
	vRN4RQw==
X-Received: by 2002:a05:6000:2c13:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a5723ad5dfmr10866449f8f.24.1750175046950;
        Tue, 17 Jun 2025 08:44:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHpBD+dKVpYruKbhanJPmGuA69TQLBLGeutEiQZdQL6alvi0yDoDZEPOFHzDtmskCoeBKHRQ==
X-Received: by 2002:a05:6000:2c13:b0:3a5:1241:ce99 with SMTP id ffacd0b85a97d-3a5723ad5dfmr10866409f8f.24.1750175046528;
        Tue, 17 Jun 2025 08:44:06 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b4e4f1sm14054457f8f.87.2025.06.17.08.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:06 -0700 (PDT)
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
Subject: [PATCH RFC 08/14] mm/huge_memory: mark PMD mappings of the huge zero folio special
Date: Tue, 17 Jun 2025 17:43:39 +0200
Message-ID: <20250617154345.2494405-9-david@redhat.com>
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

The huge zero folio is refcounted (+mapcounted -- is that a word?)
differently than "normal" folios, similarly (but different) to the ordinary
shared zeropage.

For this reason, we special-case these pages in
vm_normal_page*/vm_normal_folio*, and only allow selected callers to
still use them (e.g., GUP can still take a reference on them).

vm_normal_page_pmd() already filters out the huge zero folio. However,
so far we are not marking it as special like we do with the ordinary
shared zeropage. Let's mark it as special, so we can further refactor
vm_normal_page_pmd() and vm_normal_page().

While at it, update the doc regarding the shared zero folios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  5 ++++-
 mm/memory.c      | 13 +++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 92400f3baa9ff..8f03cd4e40397 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1309,6 +1309,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 {
 	pmd_t entry;
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
+	entry = pmd_mkspecial(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -1418,7 +1419,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		if (!is_huge_zero_folio(fop.folio)) {
+		if (is_huge_zero_folio(fop.folio)) {
+			entry = pmd_mkspecial(entry);
+		} else {
 			folio_get(fop.folio);
 			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
diff --git a/mm/memory.c b/mm/memory.c
index 9a1acd057ce59..ef277dab69e33 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -541,7 +541,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * "Special" mappings do not wish to be associated with a "struct page" (either
  * it doesn't exist, or it exists but they don't want to touch it). In this
- * case, NULL is returned here. "Normal" mappings do have a struct page.
+ * case, NULL is returned here. "Normal" mappings do have a struct page and
+ * are ordinarily refcounted.
+ *
+ * Page mappings of the shared zero folios are always considered "special", as
+ * they are not ordinarily refcounted. However, selected page table walkers
+ * (such as GUP) can still identify these mappings and work with the
+ * underlying "struct page".
  *
  * There are 2 broad cases. Firstly, an architecture may define a pte_special()
  * pte bit, in which case this function is trivial. Secondly, an architecture
@@ -571,9 +577,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
  * page" backing, however the difference is that _all_ pages with a struct
- * page (that is, those where pfn_valid is true) are refcounted and considered
- * normal pages by the VM. The only exception are zeropages, which are
- * *never* refcounted.
+ * page (that is, those where pfn_valid is true, except the shared zero
+ * folios) are refcounted and considered normal pages by the VM.
  *
  * The disadvantage is that pages are refcounted (which can be slower and
  * simply not an option for some PFNMAP users). The advantage is that we
-- 
2.49.0


