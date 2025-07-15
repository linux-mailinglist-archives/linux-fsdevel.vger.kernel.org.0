Return-Path: <linux-fsdevel+bounces-54964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D7B05BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC56118995FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB92E541B;
	Tue, 15 Jul 2025 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzF93sPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1042E3B13
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585846; cv=none; b=BL1oNOTYO66d3UidzN+WylSL+Td5nZakWdEvCA3461zlI/9P4YhSTz/0aZxfWEA38sQh+v51j1tSR8hbsVLRt/qTTJHpVP5SSmqBo0+PFNWgdUhL+s8crQIRzHR2uLJpsG+NfqYy0itl+inuKDK+JAOBzZOFk57Rsp6AvzZVCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585846; c=relaxed/simple;
	bh=pbPnEp6aaXv016kkLIdATYY5utELjl0Lfjdju0xIO5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKdxcib1pXgtdjP0LmNaiEgLhlYFQZggZpTmEbZe5mYIZfvpMyzsvmlKS+NMnxmsGIduPJmkCT+rIYMzzv0CqYaR8l7k59IWrICs/0rBciUtMJsLIeOdVqtAqwQvldUuboJFiAvTBGgBxkUaJj0VsKmlBmNBnWvZdglWjHOAF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzF93sPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykT8pgWXFgvGFNKHweTL3CrCV9vUidi0sNJ9Np/Hvr0=;
	b=XzF93sPJwwpq5tiBh/usOynLdFq9K/Jgq2h4daP+ZWB36CQ5kNsyBIkqtHu4EIyYOBMHRj
	OuefoLRXW8CVKPS7G7iHWNPfFFcF6TwNbDye6V7EysreFJTDw4kx5ajT/rpt+vl//DbRgt
	feTD7b7kA8vCyp1nHCMiR3mphMiuZjE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-LyPVw01oPL2KHR5otU7i1A-1; Tue, 15 Jul 2025 09:23:57 -0400
X-MC-Unique: LyPVw01oPL2KHR5otU7i1A-1
X-Mimecast-MFC-AGG-ID: LyPVw01oPL2KHR5otU7i1A_1752585836
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so29042305e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585836; x=1753190636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykT8pgWXFgvGFNKHweTL3CrCV9vUidi0sNJ9Np/Hvr0=;
        b=sNUKi613DDXnkCXBEJf6JHmBckfQ8xzcpPVJ2TTfdILkIc9zFx5YU/FsjRqMGdVFGM
         q0DOGpjIteCJFhA+NIJAu4YvlqDv9YmuzHmvn4ibQ0YMxCQyGY9KhXkRratradTTq2vm
         4qUCoIIL5v07unGCrBZ26Ip2+UT/NA8k6+0hGyMr5pjmQJVPpBUUWI6WKLc98lmRJYWE
         jUKBlPh7Gvyw/sNzYieUxLvSwvIxlw0FiMNzXjkZ5yOce9i9tzpyurpQkCkozPo/LQ/a
         x/qm+7w7kqqx4c/B/eTva7oKUoo/eUJhuoz2lksYwBkao6cQWTNhBRaLX+6jxA11Emf+
         6KPw==
X-Forwarded-Encrypted: i=1; AJvYcCVErculH0iTgJy0AbHP6cRBYi41dgA3/ogep8SphHgUZCztKoI4TJ03ykPsn7NjLHnkiZk5fAxIl/T2klw8@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTnwvGRSIg26qIImIFztvPIb57AfUJVqEr2BJ1CrsUjkvdpD8
	ZrSKRUC9+PDql7YgT1CPeKHmmW5x8KGccFYFNmgQ4oyBIoZrwB84nL97yfbuf6BYRFpmBE923Nd
	sObvPainq7AYdjPQvYCV2x/tPJftVx+SDuFpdctDr5AEKaXODTtPQupBqX71SIVZqopc=
X-Gm-Gg: ASbGncvwR7Npl8Y9ixJoaNaLJXbjztwwymNTIZBkmjRPp6nDRJOVlVRDuXMqzkiXy4a
	URedPnkEG/Hs1Eir1rGactXKnNMyjEWoYKheDSvf0X1Au91BIvMIxya7mWBik+FqXUAslqvo6T1
	ES73w/wu2MUZcEO2M0Ey9wM6pcmEbv3RQvqUU7zsKs+6x98nu75ZOSwBhvxxpUftxfP0renE5Uv
	VaroN6Exm07mF1KokN6pNTIdFcAAbBdtOSnyGcOf1VrLzlZ3OyE1461G6dpybO9FNeEi90a4yMk
	f33S8bOzIFkM2OQXb3N3E4bNFIN0BaIaoemxvgJwPU0H+T41cLhC/SQvvykj58xOgc4gXfrsMVX
	m+c9J5DviL3zHm4o3RR+L0PGZ
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr14507427f8f.51.1752585835284;
        Tue, 15 Jul 2025 06:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKDFYln2JrtTRhld2NwLX7CnQQsSirIV2K0GbAl0c8l2mNgbUwK9i9nFjMxSZj5YkY6MStUw==
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr14507363f8f.51.1752585834604;
        Tue, 15 Jul 2025 06:23:54 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc23cfsm15410702f8f.37.2025.07.15.06.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:53 -0700 (PDT)
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
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v1 1/9] mm/huge_memory: move more common code into insert_pmd()
Date: Tue, 15 Jul 2025 15:23:42 +0200
Message-ID: <20250715132350.2448901-2-david@redhat.com>
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

Let's clean it all further up.

No functional change intended.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31b5c4e61a574..154cafec58dcf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1390,15 +1390,25 @@ struct folio_or_pfn {
 	bool is_folio;
 };
 
-static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
+static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, struct folio_or_pfn fop, pgprot_t prot,
-		bool write, pgtable_t pgtable)
+		bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
 	pmd_t entry;
 
-	lockdep_assert_held(pmd_lockptr(mm, pmd));
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
 
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	ptl = pmd_lock(mm, pmd);
 	if (!pmd_none(*pmd)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
@@ -1406,15 +1416,14 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				return -EEXIST;
+				goto out_unlock;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
-
-		return -EEXIST;
+		goto out_unlock;
 	}
 
 	if (fop.is_folio) {
@@ -1435,11 +1444,17 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (pgtable) {
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
+		pgtable = NULL;
 	}
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-	return 0;
+
+out_unlock:
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1461,9 +1476,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	pgtable_t pgtable = NULL;
-	spinlock_t *ptl;
-	int error;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1475,25 +1487,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
-			   pgtable);
-	spin_unlock(ptl);
-	if (error && pgtable)
-		pte_free(vma->vm_mm, pgtable);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
@@ -1502,35 +1498,15 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PMD_MASK;
-	struct mm_struct *mm = vma->vm_mm;
 	struct folio_or_pfn fop = {
 		.folio = folio,
 		.is_folio = true,
 	};
-	spinlock_t *ptl;
-	pgtable_t pgtable = NULL;
-	int error;
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
 
 	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
 		return VM_FAULT_SIGBUS;
 
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	ptl = pmd_lock(mm, vmf->pmd);
-	error = insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot,
-			   write, pgtable);
-	spin_unlock(ptl);
-	if (error && pgtable)
-		pte_free(mm, pgtable);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
 
-- 
2.50.1


