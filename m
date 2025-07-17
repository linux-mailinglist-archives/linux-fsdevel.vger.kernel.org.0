Return-Path: <linux-fsdevel+bounces-55250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75CB08C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1B33ADCD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067F2BD030;
	Thu, 17 Jul 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv6CbUsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E62BCF6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753150; cv=none; b=IJybYlVncwO+SBYT2kQImyfwFQXu8nEEk9m2simToznGUv7VZTYfUzPGx5SY9Ksiu3cOyvfuh2BRcs5roJU6mXMnMM6V/j6UufRA71EaRiWhaDYB3vggpb1XfFFNDNJP4fsFirZ8AZK8bgH0FbShcoi2H6WCoBuZlhYv91Xa5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753150; c=relaxed/simple;
	bh=NrAlEw03z2qiGco0Xa1ZOehtWb1pLnxzif8JiZozP3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eakqZ/hzignjaH1Q6JxjyiLOgDBoSsZTKrjI3s6fMs+JNhB9J6quQDiimUY20ISKrxa+DyGcMvQqTeeGhYP3V0IPvYWAZP2+3w4zDOHWAmTOPBoL149okqyd2hApnNKAdrESmVgZRVFLc+kX9YVUkLNjHdPKwojuclyxfBkv6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lv6CbUsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WawR8xzOLp+WGO3JwZK8yJOVf+K8h9KX2DcE6xt9pRU=;
	b=Lv6CbUsMPabslqoOVuesT3rP7J1EAfJIEN8Jh68kFTa1np2Cw1WSQ4Kr0sJNBPEmiL8iyL
	aR7+2sU9c6ct5ec3SKZSRCnUFzyCySQqNVhud6yzQ+njB9bFWbE1cTrEMEnSLwrZzA7UGI
	wu6XaCpMWbyxYZqEPKNCyZNR2OhlN3A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-By49L75PNJmqcdqs2jYHRQ-1; Thu, 17 Jul 2025 07:52:26 -0400
X-MC-Unique: By49L75PNJmqcdqs2jYHRQ-1
X-Mimecast-MFC-AGG-ID: By49L75PNJmqcdqs2jYHRQ_1752753145
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so8744505e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753145; x=1753357945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WawR8xzOLp+WGO3JwZK8yJOVf+K8h9KX2DcE6xt9pRU=;
        b=AfFWS84rYKFybu8XhwD2fYZdJ/8Dd6xkzsTUSghIa4nSCr8fPN6Y8768CLoIRwfLF7
         4a2jHPZHJKJxJCGH112HrY9R9B37ZAS7USp9aZxVE7qyWBA8av1htAY4i+P/bQEZKNhJ
         8PNLznolPJ3lvxy3XXCIVDpATqDgsHKdf2jOiJZdRu34VoHZTJY6SQH4QYruR0kPLsn6
         PuybnRp5Co3cxhm59fPYtjaD1vV/3otlkq6gQ5pXcFD4S2lT4jUEf2C9r/uLlxIQ1q1p
         +a2zruo7C2v4kbjlIvWvlPb7YYcIJIhNeWUihB5Cs8EuWKBVgP1hsekFb6G2GEuOZkU2
         X4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu6bOLZ2KHhZCl78wLelLjFg39sOi4/yqk/ZpxWzZfYL4UIdP/FmKbf+yUbMR4QtumrEvbY+m+uNxzGDJn@vger.kernel.org
X-Gm-Message-State: AOJu0YwgHXJgbM8BqkFQP6ikj8lLPSSYJJw4Oz1/iThxHTHjtrnAdLV4
	V54oPP8JsyB4wA7W4Ux3GAuZqNaKlCabG+I6dUsR9rCMlB8gs89x7HBTkoz3ia4pbJVrlsX1qaM
	iY4o9n+4xuls5jyQD8ziLzesv9m+47uaCFETEGDKDgSF4Ov7BnvYZFleptm0c+2ocnRE=
X-Gm-Gg: ASbGncvgqc38ufTwvl0NblXraIHmv8MaWSf5zQveVelee1RSym5LbCpEKY2ExMDxNB2
	YFMkWlcg4PniBwcYF46X1qrmPITPxCQfIbr8/mrMRPnpCl7go9GkQGeunQ4A5TEyK5Oq1D9C8R4
	DblokUueiSBeA1+2agdL4gVS+K2XieRzNO+8eb6QWJl74G4rJZ1ofz2kOgLyxhTRkejdQYcc4G5
	tgUb053eeb4JBbede6FptX901kVbvHjIC8PiCdLwKnDeZ5g2cLzvbdaxUQsXKT0Tl+h7K/l39F6
	63hXqd2wDKmD3ktvGHVxcdX3Rk1XbVy9lYEWAbXkpKH/DS72Oh5CdU+5QGNc7ZiX9LSYWtOb+Xh
	jxRB9sCgq9z0A751ykC0qTpw=
X-Received: by 2002:a05:6000:4b02:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3b60dd4ab27mr4713891f8f.8.1752753145092;
        Thu, 17 Jul 2025 04:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDhmg9Ls7QQA6yWIIBzDvc6abI92P/fYxcVRDFmyoxlxNBqWLFwcd4nrVInyOX88jAc9Q7DA==
X-Received: by 2002:a05:6000:4b02:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3b60dd4ab27mr4713858f8f.8.1752753144606;
        Thu, 17 Jul 2025 04:52:24 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634f9d599sm19697745e9.33.2025.07.17.04.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:24 -0700 (PDT)
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
Subject: [PATCH v2 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Date: Thu, 17 Jul 2025 13:52:07 +0200
Message-ID: <20250717115212.1825089-5-david@redhat.com>
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


