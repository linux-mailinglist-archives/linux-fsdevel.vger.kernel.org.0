Return-Path: <linux-fsdevel+bounces-51919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BFADD2AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04741884B76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFE2EE5E9;
	Tue, 17 Jun 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hijnM21g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D82ED84A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175036; cv=none; b=LMVHqK9X6ft2H6tNj4/Bt9mHPJ1jwBKRKKojV3MNL1PaFbdh0P5BJS0xQmstlWXiJXiFLhqRPBZwcN6lBwWEN2krAmUzZT6eISQjqzRZoDdVx9X1e8UWCPH+4W3/PSc6/q47IHj6CCzUhESrn+oYvSPZ2CXnQ8h3jA6l5VjIE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175036; c=relaxed/simple;
	bh=gfOK1w8At4LCO+SEz2YxE1sL/b3knNVAuIBGQzCExJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhKdBC4rnpgxbGkpPvpIGekvFBrexwXHCQ+/MyvicuGogWqNG0I/MefXeIyFlMeyr58g/p/qZ7Qp8RHQevSHW3QXDGa4lhGzK2Fi+F2wFYcX3y6TyYJuaMgJyfkKRP6+VDDNr9kCb35WWxj5LdrWoEvPsjX/2QyTismgXIUZSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hijnM21g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4hXdfl2BxaEs0JquHL/H5jXrrSdl8LRqFfGRUF6aUs=;
	b=hijnM21gvhNT2cliRuPXkB4Hj+0aBB6vg1PlJSpu9JEztsk2LFZj1TAYk7HgDUq3dzlabH
	KJxQ8TqKylt2NGd9w0Wum2lzEA34dkca63kTjZeDtHrrloKxayHu+8a52W+to7Xc4Yf6lV
	kvhd49fo6wTO6OG//E6oTe/FF1jbFxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-VnsvYp0eM7O0n7H09KHTng-1; Tue, 17 Jun 2025 11:43:51 -0400
X-MC-Unique: VnsvYp0eM7O0n7H09KHTng-1
X-Mimecast-MFC-AGG-ID: VnsvYp0eM7O0n7H09KHTng_1750175030
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so548085f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175030; x=1750779830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4hXdfl2BxaEs0JquHL/H5jXrrSdl8LRqFfGRUF6aUs=;
        b=O4GG9d+r38cnPnrtku13oX8Jdm6ET8L3C0AlG/8ZK4yGyOrCvwSaUGTB8GfbzLJTys
         EF6dbJhz1wlV4ux1uio5/KeW0Tw5NNHhF7v4IMa3UKqWTlR7mBsh2++CjdAqD1I70cEk
         jzZbpHg79x34oOqtcRNV2OeXRlIkoruuz7mTG8pb8M62kt1T3JlxZ22pQBTHzB9XwkBR
         qBtYGwgoW6yV3F0Uzw/hsmPdiVAGdaqJ03z933wUsW/IzrMeb2iqJSNs3kWs/QNhsBA0
         QDfktL2eehNxA9zVaUBFXo/ckyfvible9bhd1Hd8+akQGrq+d7BtYggb2aFtsgeWvAxa
         NloA==
X-Gm-Message-State: AOJu0YxefcQKGH6CjR2KAr9Uj9GriD1/NWvi3cm7wQYYk3hUlki7WxDP
	e4KL2xNgmSQi0vme0PMVOqRO0Vq/b+FqNIYJROZ68xSp5dxyj6P9E+tpN3vYg1C+LETc0/wLVW7
	kvwmQilh4N1LxXu4hqWyWkliZniyZhX8cj488tkmEa2q/dWmftEVdM4fgeGHL4QFnhJQ=
X-Gm-Gg: ASbGncu4j+iYpuEvaVVChT4b67tCWbktyzoaNFal87Pg1XuBCdF3aau1CdHq4a1n6e1
	zH3qMNDtWP0kv9e4Ae6IbD+NJKMXElyRWAwUsnt/WclteKF8vDE2ILWvHYZKBTtQpF7DcE7VCQT
	LO++Ghi1PvqLxsNU6q7AvKE1XPQnhTPr64fRD5PcFr87HSaJjLn745vy5QIh6kUlEDWz+38NfNJ
	6o8BvNJ3nzbKrDxT/zoXaQj8/jEu0yuHXUbVrwwTQbC05CiM+Ew97wsoHEqYKePIRyOqR6SV+tS
	bXHhdQXfQJ3JFwm98eRFSByG8Y58k2v9JNyoJ3H3WbPc0ryVldGXsmlL3qHUGzGqR/tqpvwHAjH
	v3NxLng==
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr12961311f8f.16.1750175029924;
        Tue, 17 Jun 2025 08:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcoD8JqLOB4EjbN+k5qD0zJS7SAB63dB1ZbzMQjH6b78ztWbJgN3nPYj9/mZ7cyKIKJjAtyA==
X-Received: by 2002:a05:6000:1884:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a56d821e4dmr12961278f8f.16.1750175029492;
        Tue, 17 Jun 2025 08:43:49 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568a54a36sm14542075f8f.15.2025.06.17.08.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:43:49 -0700 (PDT)
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
Subject: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity check in vm_normal_page()
Date: Tue, 17 Jun 2025 17:43:32 +0200
Message-ID: <20250617154345.2494405-2-david@redhat.com>
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

In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
readily available.

Nowadays, this is the last remaining highest_memmap_pfn user, and this
sanity check is not really triggering ... frequently.

Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
simplify and get rid of highest_memmap_pfn. Checking for
pfn_to_online_page() might be even better, but it would not handle
ZONE_DEVICE properly.

Do the same in vm_normal_page_pmd(), where we don't even report a
problem at all ...

What might be better in the future is having a runtime option like
page-table-check to enable such checks dynamically on-demand. Something
for the future.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0163d127cece9..188b84ebf479a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -590,7 +590,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
 		if (likely(!pte_special(pte)))
-			goto check_pfn;
+			goto out;
 		if (vma->vm_ops && vma->vm_ops->find_special_page)
 			return vma->vm_ops->find_special_page(vma, addr);
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
@@ -608,9 +608,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		if (vma->vm_flags & VM_MIXEDMAP) {
 			if (!pfn_valid(pfn))
 				return NULL;
-			if (is_zero_pfn(pfn))
-				return NULL;
-			goto out;
 		} else {
 			unsigned long off;
 			off = (addr - vma->vm_start) >> PAGE_SHIFT;
@@ -624,17 +621,12 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	if (is_zero_pfn(pfn))
 		return NULL;
 
-check_pfn:
-	if (unlikely(pfn > highest_memmap_pfn)) {
-		print_bad_pte(vma, addr, pte, NULL);
-		return NULL;
-	}
-
 	/*
 	 * NOTE! We still have PageReserved() pages in the page tables.
 	 * eg. VDSO mappings can cause them to exist.
 	 */
 out:
+	VM_WARN_ON_ONCE(!pfn_valid(pfn));
 	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
 	return pfn_to_page(pfn);
 }
@@ -676,14 +668,13 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
-	if (unlikely(pfn > highest_memmap_pfn))
-		return NULL;
 
 	/*
 	 * NOTE! We still have PageReserved() pages in the page tables.
 	 * eg. VDSO mappings can cause them to exist.
 	 */
 out:
+	VM_WARN_ON_ONCE(!pfn_valid(pfn));
 	return pfn_to_page(pfn);
 }
 
-- 
2.49.0


