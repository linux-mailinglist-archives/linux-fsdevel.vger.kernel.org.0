Return-Path: <linux-fsdevel+bounces-51923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B3ADD2BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB72117EBD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD72F3649;
	Tue, 17 Jun 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3vsOxw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A42F3634
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175045; cv=none; b=NyPQwZooeW2XUDpWF27SZeJwvDwF2ha3ur1P3xtSYwtjN7aSTYZXCMZKTKbjyMiZ2msjpTgu4FfxYKOhD318kJGErNM15G1m8DGCBD0zOV8UM9i4oEkowNfeqPzsW3z05JrIQ8ZjITyLvXvXsVxUHz4+oBU7NQGbHWTkW3iSrFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175045; c=relaxed/simple;
	bh=Lmnd5ZdzMmI5UAgfdf1SJgbeKDVj30wC0SI7xpkFiMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDTX3jK/yAFynCcCdp4/pdp6XbetqiGxhdM6c/Kc4MhhS+8QMRdbv/F2CmNGRiMblAHHxCwfRspTn/nO5nr2iElpe9UIcRkhPACEtp6dnUgJVgrE7umyDG1kvoz8JJ5xq7FdHOA1oXTaD1LOj68P+ta3X+RA9PYyDIrkcR3PrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3vsOxw4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L8RMUDCiRiYUMLt7aYvOaTdy74+EjgVDuyzYaNy+k8=;
	b=J3vsOxw4T6/7W98lteezdAZpJffa86VAE9b+YbyloGvxcK46PzZ4hDhQHMxr1SZ34IdLO5
	JcGSdhWfUKIs/TXtoLmq1MFiOjAjPhuqTiqv9EEFRwiu4TGUJxu9J3t78+FZD+Xa/9Hy+C
	unkN3XWQFfWabztB3L0OH+5EZhq9JSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-7106QI57MKuIb_mJ2SzvzA-1; Tue, 17 Jun 2025 11:44:01 -0400
X-MC-Unique: 7106QI57MKuIb_mJ2SzvzA-1
X-Mimecast-MFC-AGG-ID: 7106QI57MKuIb_mJ2SzvzA_1750175040
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704d22so38769805e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175040; x=1750779840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L8RMUDCiRiYUMLt7aYvOaTdy74+EjgVDuyzYaNy+k8=;
        b=D1SABM/DtCy6C0es+f8Rn2AhmoE+xp61RyM87osWHyb6SP35k/609lrHqWhdB4eTnc
         sSiLCfB0YbMWd8EakIme39j91rJvbfpVfuSus/f8xN1PbI+JCvaKwmohjgRzuqf0p6FD
         07N0j067xc5CzvVmPwhP7EtvXzLMBtMdgzF0Ooow6bfBbhvciWj5PHGWZuBdNeVQ5DTs
         ffDsmm0tRoFuemIyXRX77g6o5y5wSD9UJdPV4rsg3vqYj/2B1MCqsSW6k5kJrNejmXoY
         SZbaKpuJz0bIVYTEhAZUqpBaLs1+wxyTot5mVcMwRni6/t9f/Ce6mBvZLMUfLTRfwf5l
         0DpA==
X-Gm-Message-State: AOJu0YxpABN3mglJVeVVBUH8NbmlXtC+Mplr6suafdYawD3Zmu5pG9dE
	S0eltilXNOfrUxhDaZTo63aCLLEZJVaRwo2LYKBIRKk2KueisSVmWtzOOERzr23/oXNVNvBcH8B
	ShgymLZ4HvxUAAGXZgO++u8T4sBdtCHpq1n7b5VHBFnCeIy1zAGAqY1KgM1838WT0V+4=
X-Gm-Gg: ASbGncusycqj8yO0kIREcdTzhkOTjtrYUYCWh7H/mLG23yV988uDXfkKsRmYg+I6ixV
	5q0fgtP/pYlDI36J98YR2j+H9IIJx8OHHHmuA3XgAzmWYmVUkkHjbN774VeAr3bDxFNz9nGU1AU
	1lmzgtYb1UHA4S1606T3JnUV4ddiZaqbfwHhMmbwn4/R6+FTYhG6KCKupGahkO+Q2h5DJyy7bkL
	1w7Zuhyn5p7HaiOoFaX8jhhvLuMydq1XggLIW141DkGUTBnCEzs+cIMKNQRwhC0GoMW/bac52bS
	/AS5BRDo1lKUFZxMP5rOIko/OO/G951uZO9pIlRkUvucM8DoUgy1Q97SWjt/ZNlQsgWpTTU5FjT
	4r5VS1w==
X-Received: by 2002:a05:600c:8710:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-4533cadf840mr119660135e9.1.1750175039948;
        Tue, 17 Jun 2025 08:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6BFmn+0lN3d+8pZJ+Q6QIbSjyAC/18B9P+xMU7OTx196gniDr43GvtKhKD3/WRsO3OGi0Uw==
X-Received: by 2002:a05:600c:8710:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-4533cadf840mr119659825e9.1.1750175039526;
        Tue, 17 Jun 2025 08:43:59 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e25f207sm178703705e9.35.2025.06.17.08.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:43:59 -0700 (PDT)
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
Subject: [PATCH RFC 05/14] mm/huge_memory: move more common code into insert_pud()
Date: Tue, 17 Jun 2025 17:43:36 +0200
Message-ID: <20250617154345.2494405-6-david@redhat.com>
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

Let's clean it all further up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a85e0cd455109..1ea23900b5adb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1507,25 +1507,30 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 	return pud;
 }
 
-static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
+static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
 	pud_t entry;
 
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
 		if (write && pud_present(*pud)) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
-				return;
+				goto out_unlock;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
 		}
-		return;
+		goto out_unlock;
 	}
 
 	if (fop.is_folio) {
@@ -1544,6 +1549,9 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
+out_unlock:
+	spin_unlock(ptl);
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1565,7 +1573,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1577,16 +1584,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
-	spin_unlock(ptl);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
 
@@ -1603,25 +1603,15 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PUD_MASK;
-	pud_t *pud = vmf->pud;
-	struct mm_struct *mm = vma->vm_mm;
 	struct folio_or_pfn fop = {
 		.folio = folio,
 		.is_folio = true,
 	};
-	spinlock_t *ptl;
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
 
 	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
 		return VM_FAULT_SIGBUS;
 
-	ptl = pud_lock(mm, pud);
-	insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
-	spin_unlock(ptl);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-- 
2.49.0


