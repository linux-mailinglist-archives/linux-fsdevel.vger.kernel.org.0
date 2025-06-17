Return-Path: <linux-fsdevel+bounces-51922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7349ADD2B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACF317E82F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B12ECE98;
	Tue, 17 Jun 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zcdmn5eN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D362F2C59
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175043; cv=none; b=Nh1CI85Sso5ZX7du3MsxRjlCpSpTtAtiGP109Clug77Q1SmMr2qTRKc5Ktqcwjzs2WxIIgzI1VUR1iefaYJzS1cX3pKjj1STI9YOMm4GjtoKPcm//uBgkfChLa7LZ7NcsBIPxKF8JVrXSHiNoLWCBQfblkTuUrv8w811dszfcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175043; c=relaxed/simple;
	bh=iM0Xdm4e3e5wygmWbk96k2XyIm1O0G4shrhlooh7yec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI62Jn74PMmPvKFtU3bUJ87gxdDXs+KBl1FReA7x6AptiFr73P61Nmf/JdIR2ox45xG6TvL27tLmbeiMXuE3ff6hwL39ujmPMntGFhs/TrL6vp8AWTzYSLYXgvEJrHnhXTns4QyvSDXJq2LMiD0fzdXEzfvvBdGCzcq+ZYe0ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zcdmn5eN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5t+2oURhuR4fay2j7MSZreHj5RBEUrxIhgwh9uqVL44=;
	b=Zcdmn5eNXyUO57DWLH9o+eH/vggx9e39YSufqXEqw7b0UnpEv19qttJ5e9P/aEXMd6xL47
	dkQkIRQftKWI8pHR3HSiEeiloeWHjyS5j+Dvbe1KzDy6V3O5tuaHPjF3k8x/hZSmqISG2a
	csVVNIvZjWVL+Cb4rCZSwh3+7Zybhr0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-ZHndwz25PjWR9gKQ1Mznuw-1; Tue, 17 Jun 2025 11:43:58 -0400
X-MC-Unique: ZHndwz25PjWR9gKQ1Mznuw-1
X-Mimecast-MFC-AGG-ID: ZHndwz25PjWR9gKQ1Mznuw_1750175037
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450cf229025so20945145e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175037; x=1750779837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5t+2oURhuR4fay2j7MSZreHj5RBEUrxIhgwh9uqVL44=;
        b=PkQuiTqAsvgCCpWD53zIs6RCx6cCWj2oe2Z48Vzwi8zl4B4wXSsBOUUe7FtXQ5XPu/
         jt/4bap/aOCfp5UQy6sNkYxJed4SuH6G5Py6mdGjLIq7blwzlwz3meiRMIMqvPi+14es
         G59+DG8quFUw1bfaEg5bDJmCX7urYkqg/aeI81QbNRiSHTEaL8FEs5P8xV7WMtHYPZi1
         V/aQp/Q6+T4k4+LjkS8FNSA/ZO24G+iU7rsI65RqQqs2fLkSXVDPvuj3syTV/eNSwK72
         g/DraLGODL0xNaUNxHKnsRyede2xv1dKYbaXSqf6XR9y5EVggWsCI3APixzsy/hacZj3
         1+Aw==
X-Gm-Message-State: AOJu0Yw4J6zaLyV46PkAPnAML+znoYVDKeChjJMk9mvLPeJ4PoVY7BIq
	GXLn1jA1OxgUHByka4fPKhKwjWdE+/aYJRr1ole647M478IYF/4nw1MQDH+ezxhjZ7mJxublBGe
	6F0APCu77X0S3Jer5UuYlDUyWeWWSS9V70gf0xK7qlZu+pWOgwDeaA0idvY0bC/iDyHM=
X-Gm-Gg: ASbGnctaQmvwFbzWz9PrQbIkBEd7JyaH7ilBtzsBvE0pwUbi25+b0aSv4sScJw1o5by
	QB9rBYoPjzxzL2Lx7Wp1GpCiuI07fgmycDuy/Y9/NIWDZYC9PU5tP49FpNdUgwvKjhdxIfOD+AM
	OrsnDxwPSyyJflKTBJPsd9WfcCQk32Vqd8Uqjy1zy02p66GhEV7Fotq3sb4YXSjQvQceubuwx7C
	Y5oeeC+DoNPyMtHuEXRjsOdAcUCNF1NZhJ4ChZlW7VNUB60jAUzk8yD366IXNdGkZAAFLZ8F0XS
	zuN1cbewGrIHwqfySFc0tsGT9O0AuIHZiu47i+puHgS2uqLt3w==
X-Received: by 2002:a05:600c:8509:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-4533caa3d54mr172176265e9.10.1750175037007;
        Tue, 17 Jun 2025 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKe6joB8XUUUHr9L6o0Yf1elMxRlblx8Zso9tX4QaAEAaXQGULg7L379TE9a6MvFpj5CfDTQ==
X-Received: by 2002:a05:600c:8509:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-4533caa3d54mr172175925e9.10.1750175036588;
        Tue, 17 Jun 2025 08:43:56 -0700 (PDT)
Received: from localhost (p57a1a266.dip0.t-ipconnect.de. [87.161.162.102])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4534226aa44sm108387495e9.13.2025.06.17.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:43:56 -0700 (PDT)
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
Subject: [PATCH RFC 04/14] mm/huge_memory: move more common code into insert_pmd()
Date: Tue, 17 Jun 2025 17:43:35 +0200
Message-ID: <20250617154345.2494405-5-david@redhat.com>
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
 mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e52360df87d15..a85e0cd455109 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1379,15 +1379,25 @@ struct folio_or_pfn {
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
@@ -1395,15 +1405,14 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		if (write && pmd_present(*pmd)) {
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
@@ -1424,11 +1433,17 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
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
@@ -1450,9 +1465,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	pgtable_t pgtable = NULL;
-	spinlock_t *ptl;
-	int error;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1464,25 +1476,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
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
 
@@ -1491,35 +1487,15 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
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
2.49.0


