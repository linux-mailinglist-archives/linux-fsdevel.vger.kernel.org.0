Return-Path: <linux-fsdevel+bounces-51925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9956ADD2C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E2A3BD2ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A72F5495;
	Tue, 17 Jun 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGyuA4lb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AE2F5465
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175050; cv=none; b=SkNDusvQuKl0NCSLQAJoXGrBLOctya0g2Ikzkv+VDxPGhYleLzl2fdByIEvPNlmM5LSTJLfZXyTN65hpSGkoXwIV1u/ako1ChxUNi1wbs3Zprhuefn12lCGubUpQsLTPfXmedM5ttWl4GIqqNopG1LfGwj4+kpKvt5G8ruu7JZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175050; c=relaxed/simple;
	bh=3FCxZ8zDcceG27Pi1n4ipPgji5pZnfBRAxjPk2GRm/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaWwrGewhVM4C5yE1z9GqbHQGCr/QCf4o5zkZR94Q02Z8X9CJywNbU+bDRUqQrLg+zO+pbG5qMaeT/dzirzafpO4saJxbSlZ7ETyo7vxZu1ZV3PYP1EZcFPjEq7fLj8tsxK2lx39wCgI1Te7sBhpBoVa8iurHZgu018fOQ5zXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGyuA4lb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs4285BVc9AdSpQGnU9ous2Jq7UzfwNWKMh/gkXW9pc=;
	b=IGyuA4lb6EyOZvI83QJ6eqBP7UXjqYJMk+pK+JTY1B4MbJAPXBhhgAeYMXf+XQe4K8ACkM
	7dhZ5zw7HhVr3aYwn/IJzGJonIFRw19dVfkUN4v/bcXHNc087kuaIs5CD2O8gglPclJfBN
	65c/njgF3jsBXVbsV2aAdlSX16jFaqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-eYuzv46JO8mzIjkD1CK1IA-1; Tue, 17 Jun 2025 11:44:05 -0400
X-MC-Unique: eYuzv46JO8mzIjkD1CK1IA-1
X-Mimecast-MFC-AGG-ID: eYuzv46JO8mzIjkD1CK1IA_1750175044
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so3556373f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175044; x=1750779844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gs4285BVc9AdSpQGnU9ous2Jq7UzfwNWKMh/gkXW9pc=;
        b=vbRE16PQ63m9Z+66ycFgGesWKLzBXPNSemKJK7xRVf1Z+fYaL86yQDmh07iLd9VJkd
         o4KvvG98Yugu2ThF0Jp6nsC5MFRzWx3n3+4zsW/hQuNAAiAFi4hhu1PAOgde0TbrJiuI
         eJBvBffii4/MSY+hVAC8VMWvt3FVKpF8LVUw5lI0g1vE+psMZe07uDN6FeardsCkRiMm
         jLCFonPL6XVIM1RSJQ7whlQAtdNsVMelZ9UlDawvdSp80rDXYxPLStmPGY0JN0wOfdSV
         WOyOpTfrz/c352iLlZOzsD2aJstUHmEaBnvq2fWI7qQAX/mqCiC3Jzb0z3xBBBzIlPdN
         dtng==
X-Gm-Message-State: AOJu0Yx3+wHnezXifPFp3aCrnull8lsZV06Qul6ckC58n0l0KZGXTJzO
	aDr2y3KRD+KFMgG+zhufh0iOzlDBwkE+JiTNMmSz5xFM7Sb/VJyhiISeTadjuTd27hy+mLw8eFu
	yWeTrpvihBAnVzHXNAcP1TMnyNcyHWt4p1IwJohchukxbxz/5FBMGbjCWWeuU8mC/3Mw=
X-Gm-Gg: ASbGnctIYteDw/BXVMBKR00T8DLKsS945vEx5Sbq+CprOAwjR2YlX8YxWSLn6Tx86r1
	Apb6g+iuWXoq439/yXskliT7hyH5/q0OSZgJdxnVAh7Wf9xOldkKk2mXrV3aphqGOg0OULlATEH
	UsWIaBfSBjXORgb4jVlPmXCxGzACIpJn4VOF6ibk6ga/I8+xBSCJdy+fyzJEqXVWgMI+h+D0rdZ
	eX0yCkl3l/Uciv8OCiTem1Uky3gJKwExEBasQEVC/ElyWoGA4PmQ1GaTIU/5FAbCmRQQwHDpW9F
	3T/RK6mO97RpmDdJCSYB8FW0dkgKs1cgPbkc+XYp/NV+xdcqz/Ia5YT3WkKA/S6AMYlS8os37yO
	rx8o6xw==
X-Received: by 2002:a05:6000:1acb:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a572e886ddmr11868361f8f.53.1750175044551;
        Tue, 17 Jun 2025 08:44:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo66SwAdCOqzoQeskB1+JNa+FajMdh1o2TiDbiY6YeDDtEJko8k8Xcyqba8MVeHhWH2HTahA==
X-Received: by 2002:a05:6000:1acb:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a572e886ddmr11868335f8f.53.1750175044129;
        Tue, 17 Jun 2025 08:44:04 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b28240sm14420724f8f.72.2025.06.17.08.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:03 -0700 (PDT)
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
Subject: [PATCH RFC 07/14] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Date: Tue, 17 Jun 2025 17:43:38 +0200
Message-ID: <20250617154345.2494405-8-david@redhat.com>
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

Let's convert to vmf_insert_folio_pmd().

In the unlikely case there is already something mapped, we'll now still
call trace_dax_pmd_load_hole() and return VM_FAULT_NOPAGE.

That should probably be fine, no need to add special cases for that.

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
2.49.0


