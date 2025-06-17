Return-Path: <linux-fsdevel+bounces-51928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081EADD2D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB35160674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102FA2EA164;
	Tue, 17 Jun 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERH8QETS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC22EA142
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175058; cv=none; b=KYl3x5esYqZ8JPQc8e7dRQDRQJ8wJvYhvVWKqVN03WC4OLQBOhJaWeQB6K81/8RzgZPy26xBqC3LFMJrzagTR0oMoYYqJwYPA82oBjth2nsOVKmnBW9hHZYQpvwpLDfvbk69ZcvfrSXeqoZ7qoBWx5fCIuCO2eIUBx+Ndjo+XGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175058; c=relaxed/simple;
	bh=CpTPvCWCiY6s8YcaOvOWvnzj3sq5tS5GAvvZ9Q2kmdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apF83Eg1ehlx5e7tbrjCW4xExtboQ59KrNsa/LWVR2BK9PKX4lMbswTwNe2pcnt3V8V8tqwcUcU8gnVxzYMc3QAVQumGKK17QX8kMGWNUK1ps+1/4nS+aU1Lp3g+3Tcccj1Wdh5amsQ9SzIFTPI3FjyxNbCUVQeuVKa9uFsmkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERH8QETS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nQwds7Yyk6JA3H6HqbSBsBU+gjLOchhVzRWSpa3UwQ=;
	b=ERH8QETSmKktYbfjfhCK6tI6nseJQYY21scUm0tMvoTlO3alZZxr2G2BzNBbFmtLLG3eT8
	gOpDu5WH4Rdc51uKJg24Rthkm7D/0lZZ/CtaMKHp+cgoOyIxkBFXPdjzOWzUVljO+1JL6s
	frSLHak/9FjtaDRBrCDcfwLZDzBhDdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-bNuvMBlAN4qrdEXLC3njAQ-1; Tue, 17 Jun 2025 11:44:12 -0400
X-MC-Unique: bNuvMBlAN4qrdEXLC3njAQ-1
X-Mimecast-MFC-AGG-ID: bNuvMBlAN4qrdEXLC3njAQ_1750175051
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8fd1856so2864346f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175051; x=1750779851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nQwds7Yyk6JA3H6HqbSBsBU+gjLOchhVzRWSpa3UwQ=;
        b=BP9WY7V0FsR/oWTUwGMRcWIhWOreOek1xAIO/70kOwIKIb+cdYleTJcU/ygYQI5kUi
         +mLcfYbHYKtBEyfQM72w4wk0TN1X6OT65a5C2RPPmNTtoNDs3X3kokaZBN4XX4NJNupF
         CWDAX1uIFPR1rEgzXmwuIWAJrfMzRYw+xKZGHRN3P646/hna72XWcwFqqEhgwjM/G5kd
         R2RY81JESOR3X51kBkhePF5TQWlugg0hEYZxwJSmLHfR6/E7WD2OO8JXZuGOxZP5flyp
         OSezs7zXOwfMUnPqyGhYD6nBiMhqkBMFG7wMgGy1QKo3GHAaVWChE/AjugFlJFOYSPzA
         96fg==
X-Gm-Message-State: AOJu0YweQsWC3m5XS/kr3YKi5YaKZtO365Fkw3DctBuUCjHjo2GZLmb+
	kJVtUepfXGxS0/Q52RnO0F41fvtex5fPEosrig9p80T4A//J9/VontOzmdK3vW+ppCwibiYlHwI
	24txtSPEpdOjJqhNcv+PR1P6pndk4hojMls0RloGBXVcbP7tH72gUw2uwWb1dxrJInTY=
X-Gm-Gg: ASbGnctFRd01pEZJT7uNllitspdrQjIMm4VCJGBzgX4pfT89Taf3ahH3/Oc0NhIXq/x
	H+wXBSeR8/uG9UkW6XZgo4QsuG6p4o9jaWqnttXpwLHuJrx03aK1qg4A5BhOU/s/weZIT0Dr3p5
	No16OP7d0se82HgZ2Nd9+yKLlY0Xr7n1IPOq59davZD4boTfL5cH3+dbD2XHgZRWkn6KOxI0eEp
	PFAp5I7wvIEZlQolC65crky/hraS0upeIn7d6A7OZNYqhgtj9Nb/Xe1aEMDoGe4d1fTcF+m527x
	gg/PB4X+zKKByNRKHxSA0ybCG2WyugtXJFbL+I8QlHxSY/EBEc1jb+39e4I9N2RLpo2c5Lb3x1y
	j55V+Qw==
X-Received: by 2002:a05:6000:4282:b0:3a4:fefb:c8d3 with SMTP id ffacd0b85a97d-3a5723af0aamr11566057f8f.40.1750175051260;
        Tue, 17 Jun 2025 08:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/V6oFuqHOfr5zNP3xy/su55zH7TFZMZO7NjqgYAqVSSsBW8t2gqFSXD3CPoL3K9BbxYOdvQ==
X-Received: by 2002:a05:6000:4282:b0:3a4:fefb:c8d3 with SMTP id ffacd0b85a97d-3a5723af0aamr11566020f8f.40.1750175050826;
        Tue, 17 Jun 2025 08:44:10 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b087f8sm14566243f8f.53.2025.06.17.08.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:10 -0700 (PDT)
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
Subject: [PATCH RFC 10/14] mm/memory: factor out common code from vm_normal_page_*()
Date: Tue, 17 Jun 2025 17:43:41 +0200
Message-ID: <20250617154345.2494405-11-david@redhat.com>
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

Let's reduce the code duplication and factor out the non-pte/pmd related
magic into vm_normal_page_pfn().

To keep it simpler, check the pfn against both zero folios. We could
optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
case, it's not a compelling micro-optimization.

With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
really.

It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
scenario in the PMD case in practice: but doesn't really matter, as
it's now all unified in vm_normal_page_pfn().

While at it, add a check that pmd_special() is really only set where we
would expect it.

No functional change intended.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 104 +++++++++++++++++++++++-----------------------------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b6c069f4ad11f..3d3fa01cd217e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -536,6 +536,46 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
+/* Called only if the page table entry is not marked special. */
+static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn)
+{
+	/*
+	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
+	 * (incl. shared zero folios) are marked accordingly.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL))
+		goto normal_page;
+
+	if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
+		if (vma->vm_flags & VM_MIXEDMAP) {
+			/* If it has a "struct page", it's "normal". */
+			if (!pfn_valid(pfn))
+				return NULL;
+		} else {
+			unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
+
+			/* Only CoW'ed anon folios are "normal". */
+			if (pfn == vma->vm_pgoff + off)
+				return NULL;
+			if (!is_cow_mapping(vma->vm_flags))
+				return NULL;
+		}
+	}
+
+	if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
+		return NULL;
+
+normal_page:
+	/*
+	 * NOTE! We still have PageReserved() pages in the page tables.
+	 * For example, VDSO mappings can cause them to exist.
+	 */
+	VM_WARN_ON_ONCE(!pfn_valid(pfn));
+	VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));
+	return pfn_to_page(pfn);
+}
+
 /*
  * vm_normal_page -- This function gets the "struct page" associated with a pte.
  *
@@ -591,9 +631,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pte_pfn(pte);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
-		if (likely(!pte_special(pte)))
-			goto out;
+	if (unlikely(pte_special(pte))) {
 		if (vma->vm_ops && vma->vm_ops->find_special_page)
 			return vma->vm_ops->find_special_page(vma, addr);
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
@@ -604,34 +642,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
 	}
-
-	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
-
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
-			if (!pfn_valid(pfn))
-				return NULL;
-		} else {
-			unsigned long off;
-			off = (addr - vma->vm_start) >> PAGE_SHIFT;
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
-				return NULL;
-		}
-	}
-
-	if (is_zero_pfn(pfn))
-		return NULL;
-
-	/*
-	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
-	 */
-out:
-	VM_WARN_ON_ONCE(!pfn_valid(pfn));
-	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
-	return pfn_to_page(pfn);
+	return vm_normal_page_pfn(vma, addr, pfn);
 }
 
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
@@ -650,35 +661,12 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/* Currently it's only used for huge pfnmaps */
-	if (unlikely(pmd_special(pmd)))
+	if (unlikely(pmd_special(pmd))) {
+		VM_WARN_ON_ONCE(!(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)) &&
+				!is_huge_zero_pfn(pfn));
 		return NULL;
-
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
-			if (!pfn_valid(pfn))
-				return NULL;
-			goto out;
-		} else {
-			unsigned long off;
-			off = (addr - vma->vm_start) >> PAGE_SHIFT;
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
-				return NULL;
-		}
 	}
-
-	if (is_huge_zero_pfn(pfn))
-		return NULL;
-
-	/*
-	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
-	 */
-out:
-	VM_WARN_ON_ONCE(!pfn_valid(pfn));
-	return pfn_to_page(pfn);
+	return vm_normal_page_pfn(vma, addr, pfn);
 }
 
 struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
-- 
2.49.0


