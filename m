Return-Path: <linux-fsdevel+bounces-57318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC84B207C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C46016F0F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3D2D3EDD;
	Mon, 11 Aug 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzezCLDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1D2D3A86
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911610; cv=none; b=o9pFcq+NFCEwJW6apFkNWv8q8ooiveH5UsgPBGGL/ghUDwSRVW3SuQSm/VDZHe6U0MNxXt+Jvqrb3SeikdVZuEBBg3ImTJNgaBkFBz/PRg3olPasmOLO06EsIBQysZ/XJnanhJPbsKK6+dcHskvQeMpscEHFYi+DHpbvch79eMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911610; c=relaxed/simple;
	bh=eXpOz3QD8NbTu+ic8ivqaLXg+1OSU3HgP2CuXfIC8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZGuU9HYD+sruIHWgGnJ4dXu0yQ1brUO/9amOmEggBU/gNITxm0oM5Ucetecsg8fLThBaIjUFUxFQnZVz6iLz8uMEUxnM51haz8MjqPud7XJDa/dcinlkOayceQmlrgd6Skoob9GxhqBJ764I+qYyXKRLXelpy8lAqZukuaVURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzezCLDs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CQ37fr3U8Nz67n3Rs/zLbnQBIPHeKcdveRJNY/DHTc=;
	b=CzezCLDsx3nrzyL6tyG7otXMBDL9WlSKlYKG2DwmXOIXJWhFHI9iKSw9UR2RlTLFc0oGVW
	iOzXr/xXTAwbD1c4OlMy88z8LNVjSN6KpKpwbWDGHZLbQ6DeT6r/RHhS6g2j+ObiANo9ln
	6hutsoT3XEfclCxfI2+x3aBpJvmgYxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-06oupEIJMlSd9Jc-rjNpTg-1; Mon, 11 Aug 2025 07:26:46 -0400
X-MC-Unique: 06oupEIJMlSd9Jc-rjNpTg-1
X-Mimecast-MFC-AGG-ID: 06oupEIJMlSd9Jc-rjNpTg_1754911605
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so22157395e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911605; x=1755516405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CQ37fr3U8Nz67n3Rs/zLbnQBIPHeKcdveRJNY/DHTc=;
        b=D5ammt6iTy8RRaXyr03oKQgvBe6p0j2qE612xnKZhqU5ZRTd3cGK+OTkEYKvIkPShC
         IYk80n4UDcSGd+3M0x8KgKZAurYN9WnsdppcAvb1h80ZmzLePoaqQ+ammTBAPHYxz52g
         qnx5XYmsGA47+dO87/8gA7RmQXsnjCzdy8/cQ8EGtZcleoU9Kgfs/VM5E0/LE2UEdVNi
         FFl4z8kigCUc6OtxWbBzog0MUbrfk+bWOSjlg8U4JsvaW5LIE+/9eMVSU/VE9YimBfYA
         oC2M+JPzO6lgcUSOgNiLi6+XsDSjnv3bCF37TLiVWMJgpp+/noNcTFj5dFm6RmtVS9ww
         DY7g==
X-Forwarded-Encrypted: i=1; AJvYcCVVNvvv0kPP03YxdOPg73Egwrz5HOgpgCNw9mcwgfyb0B12/JuDpVZkSA5xlClurHm6rXlMDaAGlKNa7I0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwl48PLEbx5xwenn21qNQ8aAXJeKBV2oO+NXKOZY24U6np2n/N
	LncepLsgwKvXgBREzl6G8RaiHIDC/a7nTNknHV68+1Ok/pq5dwQ6VbCZY7wyN5nb1VdvEAIjvzJ
	033ZRtK4vA12SnLVMrOzUsicmT5dwz/BukRdOsP8HgQp730jAf/LqCN/Zkrk8sRUn8lk=
X-Gm-Gg: ASbGncuv3gofj62YWdhUfabi3hs/UEJMBD2SGUf9/NU5+w4qQ/VeGeJbKqwENOC2IJN
	Vb/S76mHCNtyvg5CDBrVIM/wNk/xGEXgPnodj6mSbr67nHuK085s1luk/OU1ekepK3OgHctqxWI
	I2nab8+HZj0Wt455EPmYlbJSpCPdDv8eGm0pebyxKY55+HeYM0Qzt0pnqMc5lDVyXgoqPJZhkp3
	pg4rYI9roK7ETUqV2vuqDDFKethLMsyvrSg/X0x6bGsgUog3dL51q/0rvNg8zRUyCDFbvfQzZvA
	ygndOyEd61AQfC3sPv+6fntZEjSVSaglIfjILfT0fWMUOnSwdY+hDQZbXQROhHg6Z7hHVZxa0qO
	SqWXbcPCv/3ycdw3gw2brveoe
X-Received: by 2002:a05:6000:220c:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b900b579abmr8417852f8f.59.1754911604959;
        Mon, 11 Aug 2025 04:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtoj1JC1TeyGzrT2XifHRNOizQnW6DZ2myFR7vrwjVvSFSoQpoWzRIG0dK3lnMunpNHs17g==
X-Received: by 2002:a05:6000:220c:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b900b579abmr8417828f8f.59.1754911604480;
        Mon, 11 Aug 2025 04:26:44 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4696c8sm39325003f8f.55.2025.08.11.04.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:43 -0700 (PDT)
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
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 04/11] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Date: Mon, 11 Aug 2025 13:26:24 +0200
Message-ID: <20250811112631.759341-5-david@redhat.com>
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

Let's convert to vmf_insert_folio_pmd().

There is a theoretical change in behavior: in the unlikely case there is
already something mapped, we'll now still call trace_dax_pmd_load_hole()
and return VM_FAULT_NOPAGE.

Previously, we would have returned VM_FAULT_FALLBACK, and the caller
would have zapped the PMD to try a PTE fault.

However, that behavior was different to other PTE+PMD faults, when there
would already be something mapped, and it's not even clear if it could
be triggered.

Assuming the huge zero folio is already mapped, all good, no need to
fallback to PTEs.

Assuming there is already a leaf page table ... the behavior would be
just like when trying to insert a PMD mapping a folio through
dax_fault_iter()->vmf_insert_folio_pmd().

Assuming there is already something else mapped as PMD? It sounds like
a BUG, and the behavior would be just like when trying to insert a PMD
mapping a folio through dax_fault_iter()->vmf_insert_folio_pmd().

So, it sounds reasonable to not handle huge zero folios differently
to inserting PMDs mapping folios when there already is something mapped.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/dax.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4229513806bea..ae90706674a3f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1375,51 +1375,24 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		const struct iomap_iter *iter, void **entry)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = mapping->host;
-	pgtable_t pgtable = NULL;
 	struct folio *zero_folio;
-	spinlock_t *ptl;
-	pmd_t pmd_entry;
-	unsigned long pfn;
+	vm_fault_t ret;
 
 	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 
-	if (unlikely(!zero_folio))
-		goto fallback;
-
-	pfn = page_to_pfn(&zero_folio->page);
-	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
-				  DAX_PMD | DAX_ZERO_PAGE);
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (!pmd_none(*(vmf->pmd))) {
-		spin_unlock(ptl);
-		goto fallback;
+	if (unlikely(!zero_folio)) {
+		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
+		return VM_FAULT_FALLBACK;
 	}
 
-	if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		mm_inc_nr_ptes(vma->vm_mm);
-	}
-	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
-	spin_unlock(ptl);
-	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
-	return VM_FAULT_NOPAGE;
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, folio_pfn(zero_folio),
+				  DAX_PMD | DAX_ZERO_PAGE);
 
-fallback:
-	if (pgtable)
-		pte_free(vma->vm_mm, pgtable);
-	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
-	return VM_FAULT_FALLBACK;
+	ret = vmf_insert_folio_pmd(vmf, zero_folio, false);
+	if (ret == VM_FAULT_NOPAGE)
+		trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
+	return ret;
 }
 #else
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-- 
2.50.1


