Return-Path: <linux-fsdevel+bounces-54966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CDEB05C2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649C03B9042
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FFB2E610A;
	Tue, 15 Jul 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGODFzU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0C2E5421
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585851; cv=none; b=iSlU98Ckp6gVtnUBOVPU+z7APSjuMXTgFqONs9PntKCqCAvbe+sAJpf06nmfMBgYDLJXs6CqwNUrD15O0H6RsOEwKVJXGgTegmF2p613YfsEWD1NLy6Hrs2bcDC7pSRDga+ymifZyJrluOj46nKHp+46lnPf3/h4VOdxlZWoccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585851; c=relaxed/simple;
	bh=OIxBntJu8g9nWJfOzokERv1JQQlXXcbD5TxB2GYJTwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocRVlpz19JuR26VrtUQBAQd6vjkJ+KivnJSRBaZirRZx82n04Dlex2OCFCCJlMjJzNc1DYmb9LNToFLpo6gXFVum66ta4fH90+S6IWQ37VbcjnRUGhlKYoDCuW+Ixd8EDN20aP4eUrejARf+gTdZ1NDc53OT3e9iYlj9QFv4veU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGODFzU6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf0T+96rABqxKpEz5mD8vzC45xOAiNOzYXCwXWS86uE=;
	b=JGODFzU6dd0+3HBeTyYMkwhbEyDpu7UCGY8UMqF6dOxsAagT082MEqwfsiMqOH/ywnmXHp
	pwCQILbdBA6MmrvblxX4LF3UNvR4qI+OhaQABKg2hlpmdsPZ8kMrNmuBl4LAFsi+N1mnqk
	UbnI1rxs8l96lj/JlVLEibz3BZafB2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tmsHAJCcOcmdPDwoX6kfWA-1; Tue, 15 Jul 2025 09:24:06 -0400
X-MC-Unique: tmsHAJCcOcmdPDwoX6kfWA-1
X-Mimecast-MFC-AGG-ID: tmsHAJCcOcmdPDwoX6kfWA_1752585845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45617e7b82fso12705005e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585845; x=1753190645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf0T+96rABqxKpEz5mD8vzC45xOAiNOzYXCwXWS86uE=;
        b=q+ag9QSOD91N+5NWc6e0chcy5gacaiaxdpz78HnNU7BYp2+qB1YmR25JvPpBWmy1n0
         BfKU4xDE1tI6LD6Jy3DqP2m9SYdHweJzUhn65QbUqBpMMQNqsFHv6+x5E3BysVkVbSu3
         vL59nireD7D5TDGGEMobgd6MnqfbFVq5x9N5K5k0a8PBcdTuBMFRFanGlUXnb50G+w9M
         UviZpLbdTcwfeYnsLLT9NN7AK+3QmljpWV2JZKPMcCgQOlFK4JBlJ8dkz9o+itvRd/OK
         dm2w2CdPsT/fN41v16dOOdTv5md0hIAsaIx8Xo2Z3zuUhF/Di0D7HlDwvQ99rMhN1+NG
         d6sA==
X-Forwarded-Encrypted: i=1; AJvYcCUm8mWrHoZnFgfU9Ms5it3inEI8I5bdP8F8nU6hnTCjyUAt3eGOVNgcvXdDqcCn2yH8cpqXzvv7mWbmGjFl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wzX/4pn9wkuKdaA6hp12n9+VlLnMKdjMnbAyyw45l6GqUoYJ
	X2xa+WehBBSdZfixqHbimcUTosY9CVSmWFQQ8E+KMONSkIpfZULw7H7wsQyrPBJjmR/fBy6N+GK
	gZrmcre97aYqmjaGJL68kO7QuVKG5TYaSnRQdahyNk/R/6YYHKoqRIz3g6x0HZmfJfgc=
X-Gm-Gg: ASbGncu75bz26dD1X9HaqKjx9ON9MmRTLlULwx7HEDyj7MxM9BOW0y/qbfEzPLr0h4u
	EnuPu0mB92H7evZdLZP1IhQy96KNIAyYAi6RCUrFYZUzTSqfQwm4VxdngvPhVzKHq6XCkilO7tt
	fUwlP/xL7OxgG8X8u4r0R87mQbikuwzJGFrV/HgDl0NovQd+JO6mbzpWNxCH0OppWh2ewX8r4Om
	e2yQhPlmJ/WRYYFQcem3jNHevJvF+eXGIAHfDgXuJ7HhBjo5oxvQ9UgtPrZvxg29og1W7OF64o1
	BHrkW5TC08SErdGFNejf88NNdWeyT4jaEahWBRU/AD2KVr8Hg0fAdWjiNmB0QHso1AWCWGjb1nK
	qjuX36G2GYL94qgiXTBg6zXdH
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-4561e5a903dmr64876015e9.9.1752585844772;
        Tue, 15 Jul 2025 06:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkvm/o7SOv8gvxBFeHAl5ZSVtKwdA8aiblR66hArUogUqCn7BZUev9VVrmUri129a2+K3wA==
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-4561e5a903dmr64875585e9.9.1752585844257;
        Tue, 15 Jul 2025 06:24:04 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45611a518c2sm80433825e9.31.2025.07.15.06.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:03 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v1 5/9] mm/huge_memory: mark PMD mappings of the huge zero folio special
Date: Tue, 15 Jul 2025 15:23:46 +0200
Message-ID: <20250715132350.2448901-6-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715132350.2448901-1-david@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
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

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  5 ++++-
 mm/memory.c      | 14 +++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9ec7f48efde09..24aff14d22a1e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1320,6 +1320,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 {
 	pmd_t entry;
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
+	entry = pmd_mkspecial(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -1429,7 +1430,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
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
index 3dd6c57e6511e..a4f62923b961c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -543,7 +543,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
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
@@ -573,9 +579,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
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
@@ -655,7 +660,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/* Currently it's only used for huge pfnmaps */
 	if (unlikely(pmd_special(pmd)))
 		return NULL;
 
-- 
2.50.1


