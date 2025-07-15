Return-Path: <linux-fsdevel+bounces-54962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE17B05C65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459C97B7E28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77CB2E4980;
	Tue, 15 Jul 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWXpudUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49EC2E3382
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585844; cv=none; b=s06VmFzzrzaaEIm0FoveyPVjK4oV721IYkLH/rQW+EtINIFpNP8PbjBvJ+psSSypNEnSuXDa1X8EMsqzq7Th7NQSRiWwDEwFQR6ZSvof+030YA5PD3CHYWJV/HkkMrWnXtHsHJ0i4xB5CWqM84zjajt66FwB7t8BcOTEOEnQfwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585844; c=relaxed/simple;
	bh=ne3nE0vrAY5S0hOjuSZuCjXi2ceWjqlUEku8gXbVmoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQMAfoNFaJQZxkTZ1RnOsggX1tUP6cFrEI7xrgN7TctPJZeNTAjC5mtFxuvTSF2oPh40GtAHHiggXDNCjtztlLBe7I2yfhQSpV8KwEUB4/JuFEncbYSFXJVCTM7/HYxwXv3qh5MZqujkvuvVO4w6lwqag03FLNz1dXfubo/tbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWXpudUd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD0dyDm8lg70iaRDQ2YlIByz/7M92Pfar0orAStmNLA=;
	b=dWXpudUd+7uFKpi76cTtiTaK2Ga2BbpE4LD6hcXiNX66vYofj+RGjGPcAEkmkVuNnN9v2F
	w+PzPfMAaFpSdBq82xq9aUvNcpoozWjt4smx2CaS5hx3yO09ldSKj2vT/xLqo4EXpQLV7a
	rBMPFRqvlCIjB3ExgXr8p9nKcnWStcw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-iv4l_lxBNWCdCnS8qes7kQ-1; Tue, 15 Jul 2025 09:23:58 -0400
X-MC-Unique: iv4l_lxBNWCdCnS8qes7kQ-1
X-Mimecast-MFC-AGG-ID: iv4l_lxBNWCdCnS8qes7kQ_1752585837
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so32088635e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585837; x=1753190637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD0dyDm8lg70iaRDQ2YlIByz/7M92Pfar0orAStmNLA=;
        b=LWIjUE0xHobna/Yi/6+25Fv4I4POeCrYuIDLJFhJogv3CqnGAwpRdg8oNftkWE4Pcf
         FHbNG6Qj3IVYDxK7tX74cN/KcqY4mTUAD2HSGGZktA6lpbIWN17lFtcVbr1ZNBRFTmZo
         zKzEHLlm4RHsHOi2Za5voABfiOczTUW7YtpU3riDqHzy5pDwGxZi4Fz1JGZyANC10kbx
         EJPR7oq+nqmQTr5+DJl0Q1czyQl1K50bLK9UHzF7BosyeSARmv+y9YB/QexI0Tk8EU/v
         SyW78FweGb6Jsw7Q08fy5eWrZDkDn04WFbO4z0RkdDy8AanVW0RI57LwmN4pgi8FMSzm
         jdnA==
X-Forwarded-Encrypted: i=1; AJvYcCU7bcxYAekHGWMV9gR/1JchAkRJeeOgJcNVcAb80PHkluPHHiuxRX/ksjtRqcycl2ri0AnZJ4Ve4jwRWX/i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zkqZr12JtiviLX0ghsD3acKZoLkRYAaMogh0S3GEgi6Lgw+2
	nACh8XXs0axyLUawFCYAeJ46yQXjek4aRnq6Vby0CbwMQa2YN8skaBNU2EPp3057qDdIsp408Ze
	q+LoaYlC9kCwTFKxAFdkklRFN8V6qGTSoy7cgWBdQsI/V/lZ4VwVKWMISK2tIYQPsiZY=
X-Gm-Gg: ASbGncvNtKH16/G6pNG37tQsxVmMHZ6olLGP0j3qzRIR+V6D7qxmfLDehJf7MIbJmKs
	Tbp4CCBImQgD6DqJpE5vhNm3jIAQfisw2RfvzeqqjvnyOOg7r4S6NiPtPYFBFJ3T1xMxAdSVRfu
	D5DxYNVyxZfeg4jNQjlg73/AJkkW8RRj49V/y3WHfDf6c/u42iueE1PRDO6Q4/WFhsvjuVslRdj
	bDfpAbQ5oNuXVEEvABFq/eIvzyvFB9bAieNpCzhuldrdAIb3RiCXRn0k7NZkyddgy8Ifak38KnT
	J/z4XspK5ZxtHeKYaICbKALUu+Yhaw4voEKPnRB2k5zUoiP+k/TtLMvBWwyErFHxBQMWDpoMxV2
	60vofnzcUDy5KM/cmhy7pFfH1
X-Received: by 2002:a5d:6f1c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b60a144d0emr2333546f8f.1.1752585837423;
        Tue, 15 Jul 2025 06:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp1q78RzrsyhD1CJX8BXKE4JqnpAS3jXZChO9oe8FS+N0ne3lTOJKZGuzSFKSesdJ2HD0wXw==
X-Received: by 2002:a5d:6f1c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b60a144d0emr2333512f8f.1.1752585836975;
        Tue, 15 Jul 2025 06:23:56 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d5037fa0sm200348205e9.7.2025.07.15.06.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:56 -0700 (PDT)
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
Subject: [PATCH v1 2/9] mm/huge_memory: move more common code into insert_pud()
Date: Tue, 15 Jul 2025 15:23:43 +0200
Message-ID: <20250715132350.2448901-3-david@redhat.com>
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
 mm/huge_memory.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 154cafec58dcf..1c4a42413042a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1518,25 +1518,30 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
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
 
 		if (write) {
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
@@ -1555,6 +1560,9 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
+out_unlock:
+	spin_unlock(ptl);
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1576,7 +1584,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1588,16 +1595,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
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
 
@@ -1614,25 +1614,15 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
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
2.50.1


