Return-Path: <linux-fsdevel+bounces-54965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBFB05C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA4D7471C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA372E2657;
	Tue, 15 Jul 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs/Anef/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EE2E49B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585848; cv=none; b=CMKMIem6xsxLakN++jKWqU5igkJgiI6wdTTz+NIFMo79uoihjpSySgU1Cw/hGIh31WCQBBA0/gzLBq/eJOZ7yHl+wc0/aLywGygpyuPeIue7yQccZc5VXNf4gSZAdIUD1RTwdnbrXeVaREiuO5Xrlrt/PW/D3RXoRlmbEd9BKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585848; c=relaxed/simple;
	bh=yZaVydwJy2K+pkk0zyqpHMa7aAU8xrX/gvDj6EOoSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZynv6ssMqu3YyANuhNnd5sTql1XHF983m7/iSLhx1D8z8QLj294ulCOiWOvgPtxM6Ht/4RTh9NSIuSOu6LzgHi860mZ3c3+ONMlzOmtjh+jyCYrShuSbOX48ud13VSdOQU4gfzYISS6XXRrvu0dfUgl+H7HILB8FQq/xMWJgWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs/Anef/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80PJLXORrw3H7rwjCmXyFxVPsu/BFZ5pBpUGrZ/8JVA=;
	b=Cs/Anef/bnSC9P96TDXu95gr6AW+RGil4wc84f+vTY29JF2Foy0YXPOBqwRp9gUQo5BSLT
	CPE6T3Z/9lfMA+/3ruJQcVgU/LCOwnfu/We5Vq9/HSXWRI9hoBd6rDNthH9Ia8gH6Qg4/l
	ikRZk2Z0QQNLQBLgNlZDlLUvs7IiKpU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-FCa5GgQFM7KNDH5NQkBhuA-1; Tue, 15 Jul 2025 09:24:03 -0400
X-MC-Unique: FCa5GgQFM7KNDH5NQkBhuA-1
X-Mimecast-MFC-AGG-ID: FCa5GgQFM7KNDH5NQkBhuA_1752585843
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b604541741so1394956f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585842; x=1753190642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80PJLXORrw3H7rwjCmXyFxVPsu/BFZ5pBpUGrZ/8JVA=;
        b=Yq9hx3tPie8PnTFN6EBepcbrv7W485wtZADIQ0IcsuEaCbH5g/pn6PNSWsRHtjnjG2
         PrNWGc2RF9YYZ1s8S8KHbRRB2Br8BYVBPFUWf2Cxz7YhG8U7oo10Wt3XqDrGCQJIXZQP
         ZSqSG9CxYkBVd0dgalFSgFo4JuLEw/tk+840VuqEg2dR/8Aa7811sCdkgZD23ypEY9r9
         Ml18rb698GTv8luDf3/QAo7ATjHtGgCcpmjQgPSAwHU8lNEMa12kfToYq13eOdw1tqOo
         EOvUk4hBTSuPiPIcEOJZ9V7G7RGjAB5bbo97lImoverqh+FqAlPZfDFaPSAT0ahfcHzz
         cP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA5JVt9wmanG6n3IfA50FlnEnshbxksLL6kGnFbwcY45X1+hFpvBiH+UBzYvJpamG7s2bmOkdZuJWMp7+y@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqTdbV37x1t1C3K05NGl+It0xDoCsFhx2dZ5MRD/Iut7PHT0w
	TwLjSOoRVBnRL5Nf63IVqdS32JnvvppyHFJgNczRn/sGIBchsCkMz2mvYvJIun+vDkdnd+Myq60
	SC4JyKZYGuMvj2Uo6UmKhIokc9mvz6Yu2w39hmYb2jJnD7fRGUBtgsWeYyAVaq98K7nc=
X-Gm-Gg: ASbGncsuxvd/2uLovOH2Xou6XzA17ov6ktIcCurN6ACRzWJVzvRwlUBX/6iKkc/C7cZ
	NZWztoYD86nxqTZEc69JTtUOo8cnVVpW3K/RKGAWVwP/YoQ497ZUfzf5B0JvTbJgzOwdAeElcUr
	q5QQVxjWE2qnS+ItZi7mbphu2eRGKyGPDfpwIjjBPdQCGVde/XThXqTe/IKyhKC/zFsCg3Iq9iH
	NMrP8Apt7BYypKh1mUeYeosGG30DfUKarYfSdJhJd5R7mqhbuCMuAbPiZnUV7Sr51Nx/HnZ3NQw
	rlHSXvcq/KaiBNs59iRGHFgbN98hk3Mis5BY6dBbrJ/crzypce6KLsMgWXcyVHtdFKGdy87T/tw
	Z4uT9k1bU028Iy5MQ9ozBbhjU
X-Received: by 2002:a05:6000:230e:b0:3b5:e6f2:9117 with SMTP id ffacd0b85a97d-3b5f2e3083dmr13500630f8f.39.1752585842445;
        Tue, 15 Jul 2025 06:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4Mv4tTd5MMu5ncCf3BOQ9JFfOJXwaxaOdtEK+d74QRgh71f+xeQhxUGyEq6hfTSErOkM9rA==
X-Received: by 2002:a05:6000:230e:b0:3b5:e6f2:9117 with SMTP id ffacd0b85a97d-3b5f2e3083dmr13500595f8f.39.1752585841971;
        Tue, 15 Jul 2025 06:24:01 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e0d719sm15297274f8f.54.2025.07.15.06.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:01 -0700 (PDT)
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
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v1 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Date: Tue, 15 Jul 2025 15:23:45 +0200
Message-ID: <20250715132350.2448901-5-david@redhat.com>
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


