Return-Path: <linux-fsdevel+bounces-57315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1AB207B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135B73AE6D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65A2D372F;
	Mon, 11 Aug 2025 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TA+t0GPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57982D29B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911602; cv=none; b=h/rSeCL7gNTGxAhUvCryQR/qTe7gV7kNngKCq1WBS5iDpz2Bh6dGCvbRy0Jw+w9/5T1LVFxwngKenAX84Srt5o9ko0i21t92DqSSIGqsRcqFNBoj2hy6Tu+4ay4YTXbayPZ0KgJ/DPEQn8YicC2pwxmSlbZ1uQMXv6dE1H+kdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911602; c=relaxed/simple;
	bh=ZGAnHpfBp1WZBWcLrOrxfVSmjre0MJHRGXddITS2PNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O789J7plNYybXZ0vfPYQ4nB2alsiWUkSb4LQiW4dTBNvmQfAXl9WKKBtASLp5MocwRrL9GhdQvyKsgLPKvLy9kC3DbKKfb4NkrYIGHg+6FSwh/IlOdX/m0hAItKTBwjRzmh3IP8WyECJOo4M/vxdcUUzCs957FpOnZDsDhlkMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TA+t0GPv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Htya8lk0ohNZGoVKNkWH4Tb4G28S+mHG9GYTekXNGbw=;
	b=TA+t0GPvuaNsXjVkw8HlnoPeMaXMo8kdaLkRqQjcbVOwIbTtrEyj1ZHVwD7dZEw6PeYZNI
	6qtMdEiQQHq0uosN7zmmQUniJPoG0k4QL3ToxbNLbb/IYPKW8EuO0eRnk0wK+eyaNhagfQ
	VWCGeb+zjOGpm5u37Ah2QRozVjNkofc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-QF_ohNUcMp2OezPh2T9YBA-1; Mon, 11 Aug 2025 07:26:38 -0400
X-MC-Unique: QF_ohNUcMp2OezPh2T9YBA-1
X-Mimecast-MFC-AGG-ID: QF_ohNUcMp2OezPh2T9YBA_1754911598
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45526e19f43so14204985e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911597; x=1755516397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Htya8lk0ohNZGoVKNkWH4Tb4G28S+mHG9GYTekXNGbw=;
        b=C9xl5/X5V1Pvq++Bk/ICMT5vE2OwQx5WEhNjKXTA/viaPt7tdzYVp4C/Kjmx4Gzork
         iP0Lo2T/bnpoxFpLlD/1RsO8OGJPShgCB2Z07Hd+Q8CBWh649gVhkqQIvpwXIplIpQp2
         eq4ku1ni2HeCRkEQ7QAsUa8phVFP02RPaZF2sAGFFNLIVgzqzkqgLijEGGk8viEAE+XR
         zH33+JxxJAzXN08Ewq2uG5ZljH4mD9NUNxnH6wKVJ37P0sBB1zoFWCEdNeZ+sr3aKPTb
         ggxVOSZZCv5cI9QpJEROHHll885+EMcsb4gWC1n8Y39pEqlWBKrdAHspRgmp0lBxOQfN
         htmA==
X-Forwarded-Encrypted: i=1; AJvYcCUIayMjo8/KaD7jazpLjMX/o2NyZEwnf3laGgfsvIpgrjgftccfQKjBilwML2xccJB2HOGreA3mZ6KhPrvs@vger.kernel.org
X-Gm-Message-State: AOJu0YzywkaXWoxYUMK8nHGTEROyCxe1W3ZTlCP86JK5wMkEURia0Ax2
	rqcmgOhZcnZD3t13sJJ7WxR0RHRqa4GO46OIUPMN4CFHzOcO8hC+cCInVcKO3DVHXEqfaAxNOlC
	Yv4E6xnXTPuzSMEi6zJ4tO271+EhtjBInC5qU4EoXJhyK5+F4NEWt3+l3HKbzEZKAtCI=
X-Gm-Gg: ASbGncukD51x1d8jld19OHXpcQtHmLYoaugBON5/LqkE0glFyK2Cz98E4f40f61jpgV
	vJirvqTYsu1Mbanv73WaHwPmhR/qdpwJq3ElA3yCj24n8oKTYJqFLD7eqszBhyeYRTVZvIZt/4e
	mHAA6/WOlRNSXU7mZKU9OHJdhp2OGrOMmqRySbnfQPMHFPeuu9ibn7tqKrqDz5JcijSN/kAjlvX
	Z8yF4j6q7sI/s655kzoqQqZAHa+aeRM74D8XbjdlsFWNALhoJdJ6MpTZQozKLXMwvozhH5+em8N
	8FmWglfPYTZL6tCjKE43GdtXvxMbYN8s3GT5wYhEDWO7MChDtHcbbcgeufxNKqMyPOx+NXd3+3k
	C89Dd2u8XretCdfVZ548vwEs9
X-Received: by 2002:a05:600c:458b:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-459f4eb4176mr127957965e9.10.1754911597515;
        Mon, 11 Aug 2025 04:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdNxb5gc4DwQKatpkXot61uX7cGVvKpORGwTw8/tHuwPs0r2lWbt+TytrRicLCoC+zeQmPIg==
X-Received: by 2002:a05:600c:458b:b0:459:e3f8:92ec with SMTP id 5b1f17b1804b1-459f4eb4176mr127957415e9.10.1754911596965;
        Mon, 11 Aug 2025 04:26:36 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abf33sm40550137f8f.7.2025.08.11.04.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:36 -0700 (PDT)
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
Subject: [PATCH v3 01/11] mm/huge_memory: move more common code into insert_pmd()
Date: Mon, 11 Aug 2025 13:26:21 +0200
Message-ID: <20250811112631.759341-2-david@redhat.com>
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
 mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b4ea5a2ce7d2..5314a89d676f1 100644
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
2.50.1


