Return-Path: <linux-fsdevel+bounces-57316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F987B207BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA392A393E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEC2D3754;
	Mon, 11 Aug 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaKfx++Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38D2D3733
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911605; cv=none; b=JIqxbrxyH9B3OOJyZ2HkfeQOG8Gi61pduwmdTjqCe2/K3pWJzMExvlQua5KQR9kWtVPiM9bwInVGSRqiEsCqggPHUJmx9rboAxx+roLSSMM58mIX0BpTGEz40GtI/C3GCnp5O6B6JuEOD+vJEcMY8nEIZYBHAq8J4n3AZASe4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911605; c=relaxed/simple;
	bh=bM37QlmnrcS12YEaYV2r5fiBbtnDtVLS/N1j1vpTu04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXm+2lkBr+mpFBXk02J2Vc6j5D/FdeC1veHIrL9clj2Kxl7BF+GK9eOfk8QC+fw1Fs+DHwMEmEZujyk1KRPEYkGi1qspOdUPDxNJO1tTHUDED+/oTwKxodsEMtix57GB1rv506xnEkj14Hm+WVZ7Z6RUE4YofudOzzjgLk8QeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaKfx++Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1yyyzSa9KFCInkfs6rUjYFvQXjYygLyaHB4l27+lC7g=;
	b=SaKfx++ZYkVLtl26/XyEOPgyWYWRMfsltIJPjxt2BPn0oAFSxsHjCIqMfT/InpSC8wipWg
	fRt+aDvgAUweSFf1EP1E34zTkkTJgui0Reh0OyYCV4LLzIrsts6VZ20WNIFhpJQSIQ8TkA
	aT9yZyGn27Uf+/4TZlWFDc8y4SuA3FQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-e26yaQuBMw-9SKYBbMb7TA-1; Mon, 11 Aug 2025 07:26:41 -0400
X-MC-Unique: e26yaQuBMw-9SKYBbMb7TA-1
X-Mimecast-MFC-AGG-ID: e26yaQuBMw-9SKYBbMb7TA_1754911600
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b78329f007so2578865f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911600; x=1755516400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yyyzSa9KFCInkfs6rUjYFvQXjYygLyaHB4l27+lC7g=;
        b=UkiXTG0FNMaScuZhpFwVpUbiH/30l3A9afKvgjSsGn4rXzIlOHwiftCuo45DWzUtdX
         qph9/buSi9Xi13yM7qN3rBZ7QxB1hU6B76NhCxd0AMAytalZH+LTT8H1nZ8603Att27k
         lakNAfrpNtB2z13MjW1DRnUWFm0FC/RaTNG/L5J/VmEJPkZ/TwceuLDYBhexmu8ZL/3Z
         dFvboA1uDM6TA3ntzKj74MUlg0oCtc0G0/izt2vIGwsLVoaLLQvdhDPwEpG7L9+pUcKv
         D9GyKUDEUCso+/eX16mN93KJSJ+hmF/D+vTdw42jKQForogrNPf8sqsZtXNiCtDTYWjL
         T5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVd6dSg8seTOw4w8KP7tVMbUVt4LoVUAl2rHWNLqqHFbwECprTXNuqNCtjzSeyRGJ/SgRTQK6WpgpB2n7KD@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXZQcdbX6fEtI2WwcCfDpawfwyloTKaGliJpwF3MxOdmARlHc
	rRebFEvI6J/ngHvMjx6isGh76L1LKqHl7TD24By3c5Ap5UIuvnhJp84I5z7FgJPJLaK+G87YFPq
	yJ5XtXm6OXD1XPvX4RPnxNmdFgOnXle+rmktQP/MWMvO2iiSgD9VDWg0S4jiAtQAaJP8=
X-Gm-Gg: ASbGncv6+k8GtW9yFSEfaCI6yE9EPA2jAAFMqVv4jof0wIWYUu+2+Ty7SPHaxefzCpz
	pXqtORdNWQOHi+LJMcG45IgUx9qJWDTDjkk1IzvqXsjNSyC88ZWdgxgVIiRKrK5PcYHZCBIlR3w
	KVvpVGsJso4heWOsoLpYcLMQbe06D2Ia+kWXNk7J6uJIoA0898PEOE59UakC1eHzKeC3ElgKyP2
	sQ9Kr5AA4Ak3N13abvE6C2ery+9Ee3uS+oKTcdTTGoIIMdNDpFHCeeWzHCLO2ZhcWpRcIxe7v3o
	wm3Ri9rPOQEACXhEYkrBkPWAlaCTdHIezh/7Hz7qvSpvk/wjqfM7J3o3N0ju1w29OPnRx30KSh5
	y4P8JS/OT7NcHv/j8wL440ZDo
X-Received: by 2002:a05:6000:420f:b0:3b7:8c98:2f4c with SMTP id ffacd0b85a97d-3b900b750bfmr10920302f8f.33.1754911599896;
        Mon, 11 Aug 2025 04:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6Mu1XA5qq3G00OwHlXO/yqxgcBzsacx06Jz+W5A1O+vqwNvOeLKy9GaCA2AZU3zaKT01H6g==
X-Received: by 2002:a05:6000:420f:b0:3b7:8c98:2f4c with SMTP id ffacd0b85a97d-3b900b750bfmr10920251f8f.33.1754911599405;
        Mon, 11 Aug 2025 04:26:39 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac158sm41049329f8f.4.2025.08.11.04.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:38 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
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
	Alistair Popple <apopple@nvidia.com>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 02/11] mm/huge_memory: move more common code into insert_pud()
Date: Mon, 11 Aug 2025 13:26:22 +0200
Message-ID: <20250811112631.759341-3-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5314a89d676f1..7933791b75f4d 100644
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
2.50.1


