Return-Path: <linux-fsdevel+bounces-51921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437DFADD2B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D93BE5EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C22F2C41;
	Tue, 17 Jun 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpMMW94D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD02ED860
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175039; cv=none; b=XfvOcsvLq/6KTPPkdVyVIRnWjlcBANilP+5uTcEjf/mZSbA2hUzNp1xhaHN7OyCS7t9Kyw8e/1ORqAYG0j5FfZQMNBnxX/fVRnGonfDVvBlxr8qxq0OSwRWsS54PJ2KpdxwnwQplsjIp2XsJzgM1PdhDY6vuymD/NH+q5rrOAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175039; c=relaxed/simple;
	bh=QWNOR+1eFkXIAwi4188jXafhSE+uLJ9EpozLL4/g7bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh52Avikm7xtsZA2ia5SJrtxfxwLyOkHh+m73N4J/clYOP3tQA4rjNEyIvbKquHqaYorHJk87eybTkiUEArqUDz20hNSZs6B62of6rEw1GAI7U/SmfyLHpgkKwmuktYPZNBGHpuXta6Pu9dL0U4d4zwtFCWukXjQtMF9eDTDFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpMMW94D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIojkghjiOfK3qS9mo4araH3tv/iIJHq9NK1Pu9RhVw=;
	b=fpMMW94DQPqVLGF7wHVQtxI2EHwx/DaQmeyHf7di0xl8BLAhzMiE5u5eBWH0F8uGr0KYHm
	92dhc6E6OYy36nDBrIrGztLH+v5njslOVd1EZYPgWXUiJVlL4IEdzMfbLWo0i8eKTxVEZJ
	fpklndtunzyQD+Mzu3vZLmlheKUsBH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aOBqvLL9NXuV35yqNOHL3w-1; Tue, 17 Jun 2025 11:43:55 -0400
X-MC-Unique: aOBqvLL9NXuV35yqNOHL3w-1
X-Mimecast-MFC-AGG-ID: aOBqvLL9NXuV35yqNOHL3w_1750175034
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so2456708f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175034; x=1750779834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIojkghjiOfK3qS9mo4araH3tv/iIJHq9NK1Pu9RhVw=;
        b=jB1ySdmtRqwGAA7+f39OFfEZf2H99yEefBhgzlODuhum2FmsRuwYLxo9EKOSQfrQ9t
         +YP0eGvLBBaMWOzrYv4jC5cBWnXTYIcWgCCs6t+C2xKFfJGsUcRy1GFRfLsDkXDtYzPA
         onDeYC3GhBxoyFWgMUcjA3PNQW2PLMJhbNoEskyTOcKFK+Q/CmUv1bNHtY12g0u1qUhS
         nbAP/GCoDfQewvGQ/nmerRRKd9S5WIqPJwYBByvlUwxs48mosgMqtD135opmkMKmfQvI
         Rlw7yu4Av0jZthIeNzDlFkZocXhf2yi9imTZ993/2DdVvo25nyS1SS9SdfeMglYV02gM
         d+VQ==
X-Gm-Message-State: AOJu0YwKF6G3uZCFo9HeRZR8Ks++4f8Z7J1ujf6gSO/Mn0cVKJQoGfRB
	kR5+MryyOh9O0Lm7y+uuYkTlrY7Lc9IysS1ATkntSH24ldN1i+RFV8aSwF9nE5LIV52yQkiuJKf
	jnsTaW38TIgvjMgVD2z1nga2wWAotZkuSIYREUAGnpGbpelrUnXigsPvBWmzZ8LmPmdI=
X-Gm-Gg: ASbGncvXgLWQIRM8r5EBagfebEUWFB5qcpAAMRnf0ZAsrO7i0O8fwiS7JZPihtV7Pl8
	ZOY79FXNqoczuuPdvFj9k08nQDUcR+rqZpcFLtBAdWUAAZafUA5ZCVrJ+urTNZV28Bviab3G45v
	8fQzm8194TwWfHcaI4Ojf65S3RtRbpy4wXOWwsdeblpxNNAgdzTbhxSN/Q3ruh0y2fcJGBXARSF
	vQsOuPjZkhTUQYyLQdb7gavJjKvBUvybfma4sKFQB2nXHLFdM8hvqxWZGkZVZY5/KckSFzaoBwR
	wpCr3hgejZCCFLyfY0dQRylNa1t62NKOeaY4meH1JBajBqZ4CkeL6tP8m2dSAFFgJ3HgwkSBZi+
	hDhF86g==
X-Received: by 2002:a05:6000:178e:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a572e92862mr10792694f8f.49.1750175034348;
        Tue, 17 Jun 2025 08:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuUUJS22/cv8lxbktZwrzLsxc7yFEH6CvMGkxQ5Sx5aQp7V5zrRMyeFF5jQJ+MyIsqVh3uOw==
X-Received: by 2002:a05:6000:178e:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a572e92862mr10792665f8f.49.1750175033907;
        Tue, 17 Jun 2025 08:43:53 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a543d9sm14118342f8f.5.2025.06.17.08.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:43:53 -0700 (PDT)
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
Subject: [PATCH RFC 03/14] mm: compare pfns only if the entry is present when inserting pfns/pages
Date: Tue, 17 Jun 2025 17:43:34 +0200
Message-ID: <20250617154345.2494405-4-david@redhat.com>
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

Doing a pte_pfn() etc. of something that is not a present page table
entry is wrong. Let's check in all relevant cases where we want to
upgrade write permissions when inserting pfns/pages whether the entry
is actually present.

It's not expected to have caused real harm in practice, so this is more a
cleanup than a fix for something that would likely trigger in some
weird circumstances.

At some point, we should likely unify the two pte handling paths,
similar to how we did it for pmds/puds.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 mm/memory.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e0e3cfd9f223..e52360df87d15 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1392,7 +1392,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
-		if (write) {
+		if (write && pmd_present(*pmd)) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
 				return -EEXIST;
@@ -1541,7 +1541,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
-		if (write) {
+		if (write && pud_present(*pud)) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				return;
 			entry = pud_mkyoung(*pud);
diff --git a/mm/memory.c b/mm/memory.c
index a1b5575db52ac..9a1acd057ce59 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2137,7 +2137,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 	pte_t pteval = ptep_get(pte);
 
 	if (!pte_none(pteval)) {
-		if (!mkwrite)
+		if (!mkwrite || !pte_present(pteval))
 			return -EBUSY;
 
 		/* see insert_pfn(). */
@@ -2434,7 +2434,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 		return VM_FAULT_OOM;
 	entry = ptep_get(pte);
 	if (!pte_none(entry)) {
-		if (mkwrite) {
+		if (mkwrite && pte_present(entry)) {
 			/*
 			 * For read faults on private mappings the PFN passed
 			 * in may not match the PFN we have mapped if the
-- 
2.49.0


