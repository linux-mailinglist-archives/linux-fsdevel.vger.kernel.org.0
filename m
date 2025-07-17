Return-Path: <linux-fsdevel+bounces-55248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D60B08C0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6EA42218
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9BC29E0E0;
	Thu, 17 Jul 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSP+4Win"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C528629C353
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753145; cv=none; b=OOfYvhoB1zf2v+0S+QvRqMfhIaaHgfXn9YYh7fw5oE3OhqGSljn4LWGukjvOvBv5hmMkGExyxuAXoVwPZdeBjQLN2RQzTyXTX9TWcPF1QK/Ymwik9EdtsM+hBCGfd0GnrDiXcQOaz4DMCrT8swbtINDHw++jxy/AGeGskxt+wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753145; c=relaxed/simple;
	bh=/JG9qVz09j5fWDCOiWpFGOXUQNTiI3Nxqeq+HPrp2jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjpRq2EYEHh8D0WhEKmLHfJQz5YQe+AiWV5m2piAA8W1a01erZhpRNXQ2HXx24wl1i0TrVFOmaY/hVa0UVc1gvVaP3mS4rjdYqOnW8RpX92rJPzuNdrtnqp7lhVGcEDQLjZ5Z7jXBnoqv2pvLKkpl9H35e72zFk1R6mC9qMRdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSP+4Win; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8U/VSSfKctO+2Q0R03xR9syW7Y0P/UCdJOxdygVgan0=;
	b=DSP+4Winz5v2DQjZAMyCjdIg+K4TF8ZmNXbSfTtACnwTO7JmVPLA/kbIZYeWvKPl1uFrLt
	9ceKq70GifO4q+TSI7LS0Vs2a68NmSEBK6MlJxAmwkzKuvtQYp4di9nfDplktzPtC59biF
	k+FEy65KMUNg40ObgHNQarR1AclAhT4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-JrwMvSF9Pme4nQyB5K_2YA-1; Thu, 17 Jul 2025 07:52:21 -0400
X-MC-Unique: JrwMvSF9Pme4nQyB5K_2YA-1
X-Mimecast-MFC-AGG-ID: JrwMvSF9Pme4nQyB5K_2YA_1752753140
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455e918d690so12107425e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753140; x=1753357940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U/VSSfKctO+2Q0R03xR9syW7Y0P/UCdJOxdygVgan0=;
        b=l60hdbF1xMrKeNy+eXyn5W87iK7bZfBJVyhzhCzNdad3QMd2pJp9NYyug/g3f1Thce
         uCJGXfQ9sKwCzELFcLk1GcqObCstNTMEkRrjQdEEyjPt65lqple1aEqDHEAPBTphHoW8
         JTiy2EIiGMlfdPrm2lhTwuFpi3Rv2QI5o6DHMa4PSCm2e7kT0yCOOKCILO/wH27HMh0M
         Fjaxwk+L9i5DFDi9AyQLBb8Ru0BsPRc8YgGfPlOk/qjcqWwi/FPdj1KqcXZhaXB1hQEo
         qPLykOunk9s4P7Qx5dyOv5ftwywg1W6c3cxzvzZkT9y1PtkzGyN7/+vWCuQkf2XdChzN
         7h1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDn+HqBHom+YHbBEBcTcyFb7piw2Ximpjlo4CgCQz2gFrutjMJVNeeTX/VznjC167eu1nN7D+iMh4rivDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93k0Px91DG8kVKybQ3crECzM7E41mIWm1Vy6gQOvgcg98Chjc
	ABe+/tfNRvNDX5Nh76t1FPnCylrYt3g5nD6srz6DArF2W5bNUfVmBMceK7qQ4F6myiNGLVFOr+5
	HJXnva2l6V4nY/aYliE6RUaxzugCrsY4JUSTMZcfESrN9RAFt+JsNv21nLgPPQgqOD5Y=
X-Gm-Gg: ASbGncuuBKW0h/fK2LQJF5/+uGj9ykooyih2yTZMufsb6JHiCIAvLSv1CY3jyVpfw7Q
	82y5BmH0obtJRpuEFpcqIirFx5x5JZN8RBNJmUtebS1/uWf052k3TYG8UgP8JHhJWNIu2iu2JG5
	skhGphI9zG5ZlvX2tNIelTVdpYHgeNV7eJrEnWFKeXAadF62XavFcBEdK0q9pKH++pKT4nBe7cm
	dvrqhbK+yJ/KtWvTKV3TILBY5FwXfQOFsqRUwRNV0vxwzFB3wSKL0mC1OvrXa2wRoROmK5uB4Om
	8KDObQnJDC205oIWGJhBKmBaF6mDmLjyPZCe7wBRSPbuP6r2bjMidT6NgxAGaAePeYz7JAHaLV8
	FGmvu8ASHUBVFDSYPFY9CYEA=
X-Received: by 2002:a05:600c:c0ce:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-456346e2767mr22598045e9.0.1752753140281;
        Thu, 17 Jul 2025 04:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRhI54TwDUdDBNIeRKh7AVS/hfT6FB+wtUWYU/lc2VhuDIhVT1QHk+Jezb55nN35RC/TrzYQ==
X-Received: by 2002:a05:600c:c0ce:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-456346e2767mr22597745e9.0.1752753139781;
        Thu, 17 Jul 2025 04:52:19 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f82f29sm20129705e9.23.2025.07.17.04.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:19 -0700 (PDT)
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
Subject: [PATCH v2 2/9] mm/huge_memory: move more common code into insert_pud()
Date: Thu, 17 Jul 2025 13:52:05 +0200
Message-ID: <20250717115212.1825089-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717115212.1825089-1-david@redhat.com>
References: <20250717115212.1825089-1-david@redhat.com>
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
index 1178760d2eda4..849feacaf8064 100644
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


