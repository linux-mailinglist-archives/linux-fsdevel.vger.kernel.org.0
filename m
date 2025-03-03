Return-Path: <linux-fsdevel+bounces-42965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79FA4C802
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B33AE583
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A10D25D1FE;
	Mon,  3 Mar 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyvAeqap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA6257AFB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019470; cv=none; b=peJ3XgRSqHkhL7d892lV/+MjeYXLD/zUIFmn68beO0688O6FaGSy9whuVUuWIIG3NP2Ms5n6nI2dU+yHrOoHZMlwZnaAcYUtRIU/UXrR80WRPb6PR72kAGH82t9iRnBJ9O/PuI2caLxz32NMCS3q2xO2pgKXHugeM/6uhcIeIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019470; c=relaxed/simple;
	bh=RlWl3fpiF9O9sdm/iMb9TRR2Zh30yDuqbmqk7QeHHkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR2Jl48d1hh+pNeO0NQJ7F7OOh6m4+3ECO0bKd/s/mA1XYZJpmR6L9JBgD6IZsEdFnidLwQhw7J00oPsvBe0XppWanp2gO9kzKu+z+7/7B/4pvYXSiID0Yil4yZyswMJ0fBMNiFuymJLo1Tt9icG4MWL8chUC7VxUOLIhZ1I+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyvAeqap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
	b=gyvAeqapEWbqanOW503M5RTMqRVCGP+TYTKT1voPWWHbevmcIBHot4EqttpkMn2TH6CXEn
	BCVfV+sxUM2egVpb7WO4yryLVX0Xi5mTabYAADMzUErSRR1jfCglgrNsBSqv7P/RvJlqA8
	sCK9BmQjCVLy0QNy9mCKZmJKhOjoxfI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-KakhCHQiOg6-NWqRWHhOOg-1; Mon, 03 Mar 2025 11:30:44 -0500
X-MC-Unique: KakhCHQiOg6-NWqRWHhOOg-1
X-Mimecast-MFC-AGG-ID: KakhCHQiOg6-NWqRWHhOOg_1741019443
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f11e6fdbso1358853f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019443; x=1741624243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
        b=OzCi0MTC8LX4b4ThfzLcGMNNFKJXARNbKcCM0wiGt241o44wZT1IA1N7l9hXW+j5vY
         mA8ZhBJO6EFoIKITDCYITCi3dl2yO+Z0HHEAWXLYNcnfMoCZzA4zS/sBEHd3tzuOPN1f
         KSZLO1XkOZs3Vo+P/wQ5FkYHFfGtOTleBB9CGdzvk9OZkCF4IOnPbmRTIc01NTBY1sJI
         LL1lutucwl+Y3vjMt0WKCSa/9Y6J6cumygaw2xpQRBh1W3hGkc0WMacVEWKc0/s40RNs
         eP66qjWedx3PEk0G10HgVkD5TqmVkiskZp/RWjZBXpnwQM4vUSM8IgCawxxppxV+eYpd
         shDA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFwvaliT3j00Kmh9GUR2SCyHqlVVUcp9KMJ3s80axZzbTJwvBgowHRIb3b62wKxF257/xY8jYmsjtg75v@vger.kernel.org
X-Gm-Message-State: AOJu0YyxA00x2FqJVqp2j1a/S5IkRu99xqaQoggqSUtdKgI7TWdnXlWT
	zFuk3kxxWy/B47KMo7IB3bprBf+Q/H1Vb+22vQU//tqinXI0cjeuhG7Kr3LgB/tBCFeVwJJ2xsq
	OJ8JpfdaUd/tSrdoE3Lcxnp77xOZFoeEYAAWoVCNDLapGAR6sI0ZoQK4K0FhGigY=
X-Gm-Gg: ASbGncs2DVPfA6f0fxRy8+RA0cn/Y+a5w5C3kOdL6xz4gfDZGI2/W3WxaTgg7jFbScc
	QBTbn5gLhcu7i45OgMPTpbO4Q7vQyplCmz/th6YzWDnpA2tzRNURusKB8qEvoTLzuV8wmhFqDr5
	kPf2g8+EZev0UfSy9Yah6y/1WWyZBROYp5LBI/Rxz8F4HFWS8qwFqmhYkDtoVa6zpPqx3A0axJs
	MQV7cQjYUx9pAryMfbvWFo/9EkB0d5tIgN/1n79owTRrk+Qy4hHF3MdM3YvWTZ8ty16drVEs9w0
	9pPXtCJLUf7k3N0pqAT6oxCmncAMu8ZRnW0oSKb0x+nLQJL/oNdb0siFlEVxCe1bnpZX79GH6B6
	R
X-Received: by 2002:a05:6000:1fa3:b0:390:f400:2083 with SMTP id ffacd0b85a97d-390f400227cmr11383301f8f.0.1741019443577;
        Mon, 03 Mar 2025 08:30:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnhjPORrAR9y+RvgL1OaYsuXRTyHneFQKcSCvW+9sKqMuJZykkJsayBSNel9nRS5Z27sSgaA==
X-Received: by 2002:a05:6000:1fa3:b0:390:f400:2083 with SMTP id ffacd0b85a97d-390f400227cmr11383264f8f.0.1741019443130;
        Mon, 03 Mar 2025 08:30:43 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc032d049sm46650855e9.5.2025.03.03.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:42 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 11/20] mm/rmap: use folio_large_nr_pages() in add/remove functions
Date: Mon,  3 Mar 2025 17:30:04 +0100
Message-ID: <20250303163014.1128035-12-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's just use the "large" variant in code where we are sure that we
have a large folio in our hands: this way we are sure that we don't
perform any unnecessary "large" checks.

While at it, convert the VM_BUG_ON_VMA to a VM_WARN_ON_ONCE.

Maybe in the future there will not be a difference in that regard
between large and small folios; in that case, unifying the handling again
will be easy. E.g., folio_large_nr_pages() will simply translate to
folio_nr_pages() until we replace all instances.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 08846b7eced60..c9922928616ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1274,7 +1274,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				/*
 				 * We only track PMD mappings of PMD-sized
 				 * folios separately.
@@ -1522,14 +1522,11 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
 void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
-	const int nr = folio_nr_pages(folio);
 	const bool exclusive = flags & RMAP_EXCLUSIVE;
-	int nr_pmdmapped = 0;
+	int nr = 1, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);
-	VM_BUG_ON_VMA(address < vma->vm_start ||
-			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 
 	/*
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
@@ -1547,6 +1544,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	} else if (!folio_test_pmd_mappable(folio)) {
 		int i;
 
+		nr = folio_large_nr_pages(folio);
 		for (i = 0; i < nr; i++) {
 			struct page *page = folio_page(folio, i);
 
@@ -1559,6 +1557,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
+		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
@@ -1568,6 +1567,9 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		nr_pmdmapped = nr;
 	}
 
+	VM_WARN_ON_ONCE(address < vma->vm_start ||
+			address + (nr << PAGE_SHIFT) > vma->vm_end);
+
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
@@ -1681,7 +1683,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				if (level == RMAP_LEVEL_PMD)
 					nr_pmdmapped = nr_pages;
 				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
-- 
2.48.1


