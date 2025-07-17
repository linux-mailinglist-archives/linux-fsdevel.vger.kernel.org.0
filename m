Return-Path: <linux-fsdevel+bounces-55247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA2B08C01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC214E5522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BD29C33B;
	Thu, 17 Jul 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGj2NEce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9F29B789
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753143; cv=none; b=aqiwIUJX+UNNfgs286JB+zQEIElFi3/8YTvjv39BoQNHOnfRIHGtfcioXkMKG2L9Detd/PBm7zMbaMrTolRV7QLAQSqCHyODo1yCa9hzbs6UletfZLG70l0OS2SxTB9wPgsNy+jwDgp6GZvnkhdaWndn137Yx5F/JXTHlDuVbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753143; c=relaxed/simple;
	bh=IDYUE1mlBZ4qeAnXwwqLmIQJkJvDRguy41kJWq4WCn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMsNtOCpZ7gXNk8+Cv2BEAVdtgh0wc21efZSNU1tu3lgTV/E1JUO9r0Fx2U9ec8nq2tulDNS5N2L0YnWhgls3Prcgi7KAlDT5TDe6jy84S/2sPhxNdM0elz0+Eq9M9piBvneo84fE6mJRdM9mXtInKCZ94N7TJ4Z4rJfCP2/8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGj2NEce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIbOZw1x2GVZdwaR5iaeVsCQGMgTtSbEtHQ5YhAco0w=;
	b=SGj2NEce9BkYiGHv61HfZsXFBM01nmpcGMqjQw5Ds1yAt9tY8lEzkEZVdZtwesWBRDvO48
	NTj1U7Hxrjv3aluLakSDnPSCTKc2cg89hQ3ev/ETgycmCofhV6Z5wdISfzGxHz4nC2CRTW
	fSOJ7zxSvDfEIuJ6SJ3MQo5LEjruiac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-j1gqkv0FORqcIcqxcSTCwA-1; Thu, 17 Jul 2025 07:52:19 -0400
X-MC-Unique: j1gqkv0FORqcIcqxcSTCwA-1
X-Mimecast-MFC-AGG-ID: j1gqkv0FORqcIcqxcSTCwA_1752753138
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so4556095e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753138; x=1753357938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIbOZw1x2GVZdwaR5iaeVsCQGMgTtSbEtHQ5YhAco0w=;
        b=i3kWmdxQxbU0TuS+v1IV0EOFAxZYoFcoCO5BSw+WYNWDh5wmJY7rIY08uRpc4W230z
         ExFEeTvQ/AtWdE7iyx5fDFvaw+loB8aAvvG8SzHX8S1g4qj373ISN82wsCSp7yBoCCTF
         +CZAeFBXI2JN1NHcD2DV4bTZGCE7JBZDZ6FX3EfehhIF9WYfHqbo/7MBDmZ6AMyT3bO2
         fINQo39Q7vMJ8bPgz+Y8+R2LQu1qNpqSOtKHoXlVd3aPV4x8smSv1ltUX9EjLrecKUCH
         u94mfgnh+QXOE9eAK9fKIg2jpzlXixUdGi3S+PX1GWLsoiP4/3++3LVUFsveznNGpkHX
         dRxg==
X-Forwarded-Encrypted: i=1; AJvYcCUWVh2RqonBjkQ6tK+ZgmIsGgSLrcpwtMaTOTmcSvmWP1k2/L1GjJcB+uOo9j/xjXjeU8bCFMBmTLBC6QNu@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFsCvNjpR1WolORugZla1tyWzFb5LNmXC1vRzyVHY/Sd1TxhZ
	9iFGUwVp+2zzu3BzK/mmm6K7xiLMIM5Qbuo5UzS3qnCUa2rDI5rz8XeYWoLE3uvVJwvL95MfRxO
	xv0MwoTtarccVAYhvln3k38UG+hG+Wl0UNPxt+8BaNWdBpDwxQtVBBXp6ZRsEC3n5Jvk=
X-Gm-Gg: ASbGncv39+oJqSnfvPN3T/z/xgfl6d06OfTawd+CwaVYQrmqxz8E9yH4uaKcdrN2GkG
	B0shuUMIxtQED2NGV7mDQM/t43RO+cFHkSHMKoifC5/vpXDfmttAiqrjmiRXbwh27cluIG6f3MS
	bjWXtzl18doEs3Txa9Zd3j4j0EdWK9/Nk2Zrc+Ji5momN6Sb/6CB8IHBE0xZfF3F0yhpse1GyJ4
	DWIgBurgTS0ySN4G3NfZOyX6UmHL8O1H3MlmerpXj5MQN8r7JAV7eAnlplnWo++wplkdxiTGI3o
	skxdC6v42Jj4XglUmoGOKsrYEq8TIHcfoqYJ+5Bi/BcIL9/lDXnSSKrXIG96cVHeCpEJEo51KhH
	VzjwJBp4EI9BT2cx5s3gH3ds=
X-Received: by 2002:a05:600c:3e15:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-4562e39865dmr69601965e9.30.1752753137820;
        Thu, 17 Jul 2025 04:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNej71yyxo4EvVsey/pvqYl543s0okqsAtiv/nbzqOk+Nei3ADHbojZnjuyE7SwluE3g0Pw==
X-Received: by 2002:a05:600c:3e15:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-4562e39865dmr69601365e9.30.1752753137339;
        Thu, 17 Jul 2025 04:52:17 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f8cc6esm20532295e9.26.2025.07.17.04.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:16 -0700 (PDT)
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
Subject: [PATCH v2 1/9] mm/huge_memory: move more common code into insert_pmd()
Date: Thu, 17 Jul 2025 13:52:04 +0200
Message-ID: <20250717115212.1825089-2-david@redhat.com>
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
 mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fe17b0a157cda..1178760d2eda4 100644
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


