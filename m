Return-Path: <linux-fsdevel+bounces-54961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A1B05C0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D42745976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918D2E339C;
	Tue, 15 Jul 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAG81uwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509151F4CB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585838; cv=none; b=jzzPyimwdrhDT7Ua5F05R9ESHV/FIYR2qOfet60vGlBNaZMP1Xq0ohobg2imn1XQTEu+dBuyT7R1xBimpN4wXTf7LNM25lPbQc4KAKuwJUcjwiQ9DyAZmidOI29zMtTq6Rr7PT4MCp5GuSpIgQyAtZ6iOTMVJZs6lEme3FL73xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585838; c=relaxed/simple;
	bh=kXdFNneQJlViZW8aFNu2Wo0nKhuTK82N9UJKOX0x5tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3zF7vao5ANU/j1hT177e7BGNETIb0O8m89Xot2xY/ASZE6M7iC9gxwV9c0JXdg46AD3XztNgV3AcYQfC0vFloUk8QR1oRfMChaHXEy3/aRz6utGXb9IqI483IgZE0a75UeKPMnWGrZNU2PDBIZvrX11MvMjblMlBISQftxbt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAG81uwt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I+njjEeJUfoyHVChoDSaOpmOHc6CwMwYKPYbj7nDuS0=;
	b=gAG81uwt6fdY6E9aBkudzVqbG5XOLNFoJq8cQasFebpFDmJ8UsYC/uKfAUjfYGkw3zfTsr
	VwkbFWG3JiwB5B6lxmJjR/vjZLG4bbrP2KBm0APnJQ52OWmfUs2qDMlBf+hNJMYMAF6lcu
	zExfdn5+S3RSUtxSDZO7bbM5N5k+b6w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-VJ6aDpHaPT6exaI5_Bi7TA-1; Tue, 15 Jul 2025 09:23:54 -0400
X-MC-Unique: VJ6aDpHaPT6exaI5_Bi7TA-1
X-Mimecast-MFC-AGG-ID: VJ6aDpHaPT6exaI5_Bi7TA_1752585833
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so35045225e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585833; x=1753190633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+njjEeJUfoyHVChoDSaOpmOHc6CwMwYKPYbj7nDuS0=;
        b=uodAQleBL+i1h4G6QH04p6HSmd4ToXpFpj5ASWqHI6MqL39j1fPEaz1l3E2a9Y+nL1
         KphQ4aDF7Ogm7ujNRugFgGNr5KVc9UQ+S03dX6cCVn57LIxlDA2SocSyDyMhkWAsrOvO
         CmJXbbC4UCb5inQy5sl7TmvEWJp00t4lQVyonKi9J45bT8f9+t7T/YbgMCxnfAul8toU
         SdTd1horhRg1MnWC1TRGb8mfiLQRLlRnsYsCpUNd4pnQxBoNEg5aDZEk3KKUAJPN2hcz
         EF5SdYU1xz425yw/bW+TXcoTHoXFt3EcgwwssXuauHj04l+IJiEWHifUcMbN5LkuJQpf
         c66Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2WH7hWRRT95zyJUrgsE2GHOfTbUMS3d8BBlxd/K/9rv4HHbxWR1U6hCriMtO6dVOeuaEwQ/8GTg737o+k@vger.kernel.org
X-Gm-Message-State: AOJu0YyicSU7JJNEmEgUqaBO6H4OnQfPGkat7cNGbYTw7eHT+xAP5THZ
	dqkcGtHgPcrp2UdPstjrWoC7gc+L9Tpof/Sr1uAn4zzbSmGyjbMXYl+bNDZTFrLQ73PLXJNqLfL
	8+ohL7FMgPsvOXcm2LGE4bgEeugrUIfzuCHRN8++psTgeOvVGLlPWNAPvM7rPW5nhZoU=
X-Gm-Gg: ASbGncvdMSU1CBea8+u8nMaxGG+0sA++DJpV+tJljkio4LLWWgbwYndNFp4wfiB5jv1
	6FORr2yntzsXioFoWMxugjG5YQX/WI6pJjLKw1SSKES57JtN0wfeQUrLj6PU+uoPwGyrwh0kBcN
	p0rjTtOYZfdzKDJ2BP0Cn/AoFUVq+C2b9buxNFuWcqfJ6FD/soqO0R70ODbmCvdxxmEKwU46UM7
	jH/VzwA7L/a4vyG9xKCiLHRE0hC6h0nQbNf4xo+ORMG6hTQZyySp8mNjDDKVBXbyb2tYJzw4V3P
	eKxOj9/ozgmnmaDOea03iaQ0rIc9/VdzY5e28SxG5I7hN3xgI7YVfuNjDNDMNYQe7lhm8KT5dQ1
	s42EVvSYf4t/2qanugkJgL0p8
X-Received: by 2002:adf:9b97:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b5f18808c9mr9743492f8f.16.1752585832740;
        Tue, 15 Jul 2025 06:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEkZDRkA14IcXQD+lQPeKL7StailaRmICkp2BJ1WOb6DFxYeWLDyvLUcHDBHF9Bf7MHtKqWA==
X-Received: by 2002:adf:9b97:0:b0:3a5:7944:c9b with SMTP id ffacd0b85a97d-3b5f18808c9mr9743472f8f.16.1752585832205;
        Tue, 15 Jul 2025 06:23:52 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e14e82sm15213383f8f.71.2025.07.15.06.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:51 -0700 (PDT)
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
Subject: [PATCH v1 0/9] mm: vm_normal_page*() improvements
Date: Tue, 15 Jul 2025 15:23:41 +0200
Message-ID: <20250715132350.2448901-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the follow-up of [1]:
	[PATCH RFC 00/14] mm: vm_normal_page*() + CoW PFNMAP improvements

Based on mm/mm-new. I dropped the CoW PFNMAP changes for now, still
working on a better way to sort all that out cleanly.

Cleanup and unify vm_normal_page_*() handling, also marking the
huge zerofolio as special in the PMD. Add+use vm_normal_page_pud() and
cleanup that XEN vm_ops->find_special_page thingy.

There are plans of using vm_normal_page_*() more widely soon.

Briefly tested on UML (making sure vm_normal_page() still works as expected
without pte_special() support) and on x86-64 with a bunch of tests.

[1] https://lkml.kernel.org/r/20250617154345.2494405-1-david@redhat.com

RFC -> v1:
* Dropped the highest_memmap_pfn removal stuff and instead added
  "mm/memory: convert print_bad_pte() to print_bad_page_map()"
* Dropped "mm: compare pfns only if the entry is present when inserting
  pfns/pages" for now, will probably clean that up separately.
* Dropped "mm: remove "horrible special case to handle copy-on-write
  behaviour"", and "mm: drop addr parameter from vm_normal_*_pmd()" will
  require more thought
* "mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()"
 -> Extend patch description.
* "fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio"
 -> Extend patch description.
* "mm/huge_memory: mark PMD mappings of the huge zero folio special"
 -> Remove comment from vm_normal_page_pmd().
* "mm/memory: factor out common code from vm_normal_page_*()"
 -> Adjust to print_bad_page_map()/highest_memmap_pfn changes.
 -> Add proper kernel doc to all involved functions
* "mm: introduce and use vm_normal_page_pud()"
 -> Adjust to print_bad_page_map() changes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Lance Yang <lance.yang@linux.dev>

David Hildenbrand (9):
  mm/huge_memory: move more common code into insert_pmd()
  mm/huge_memory: move more common code into insert_pud()
  mm/huge_memory: support huge zero folio in vmf_insert_folio_pmd()
  fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
  mm/huge_memory: mark PMD mappings of the huge zero folio special
  mm/memory: convert print_bad_pte() to print_bad_page_map()
  mm/memory: factor out common code from vm_normal_page_*()
  mm: introduce and use vm_normal_page_pud()
  mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()

 drivers/xen/Kconfig              |   1 +
 drivers/xen/gntdev.c             |   5 +-
 fs/dax.c                         |  47 +----
 include/linux/mm.h               |  20 +-
 mm/Kconfig                       |   2 +
 mm/huge_memory.c                 | 119 ++++-------
 mm/memory.c                      | 346 ++++++++++++++++++++++---------
 mm/pagewalk.c                    |  20 +-
 tools/testing/vma/vma_internal.h |  18 +-
 9 files changed, 343 insertions(+), 235 deletions(-)


base-commit: 64d19a2cdb7b62bcea83d9309d83e06d7aff4722
-- 
2.50.1


