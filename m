Return-Path: <linux-fsdevel+bounces-49055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FCAB79F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9291189B290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134D255236;
	Wed, 14 May 2025 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWNXuEX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B94253F28
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266226; cv=none; b=puwDDK3s1IrYsuJjroQ5yWlL/Hh7JP1JicOamI95DMu7IQxOHtLukh4Vr3jsa89mZSR0ajo0ndR6Slt1gQOAd/K+h0deuZf0ty4GY6jpAnN0bnX0MRpdnwZeZys6eMH6wefnWeEXhEPmK2J83o+zy2On5w3uMZBq0ocgWBdtOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266226; c=relaxed/simple;
	bh=2eqGb+Z54Yf6chN7C9tBb9iG2LUsZRU/FE89bpzSmJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fe+hqZHr33a7F+xK9+mrhPHbubE9hW4uSRsAfLVklAyh6cFcDQW0e6JUXCDyyM5Y/kWlWW/sju8FnMJiSVz4WHRNCodyQiuf2o0/1pBBqYtHdxQbW71nCtvBV2Tg6Fzg1hVfRyDy5DjJRJB9QM+23ymt6M1JlPYPThjA1jFJ4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aWNXuEX7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c371c34e7so404285a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266224; x=1747871024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZHhjGByLJzVXtoqJOTMMGXn3R5joV4I6usoUliN7uk=;
        b=aWNXuEX7cDO7EekPjQNk5sZnm613GFjh/aFf+2MdTDHO18fvEX0HXle0hAk1j039T8
         lycxb2dpSkGCee8KcULM+sY9CEGECF+xtlDWT6Cw1meJTMx4AGA9McvfimYQ9ia0+KSs
         fZBsZdYdRp3RqR/RNdxwvwZIPJ6GPTDhJ5MQyf99pka8GgzTZteQ8sq7/66+eYb7my1q
         5Jzq6xYiSxGkZiCcREszbKsK614SayXJyghlGeKftvK7YT/SVjRimiVzPdPWpP1jDd4V
         RQB9xULsU/2l3u5Ji1onD4/RIc4OSacj0Y6x0BxdmQX5Ms56CjxTkYPweWjHBml8rG9P
         pHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266224; x=1747871024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZHhjGByLJzVXtoqJOTMMGXn3R5joV4I6usoUliN7uk=;
        b=JPHFTc/bm86iYMjnK/WEeP6M8pIa2LHS8pvHKgA4y7flAQ0AtjKKpxN6z8zoADZmB1
         y+0Y5JfCZws7ZsJL/UpOG0goEs3gAXj96KjtW3bS2NQ2/vNQ3X4p4hz02ahsAXzN+Q63
         vBbwbH6emL0Fahd6ceZWJp+cNWXCwwO6R+bMJKVdjCLQJfIwu8N5o7UUH10bJX2UEUKb
         SCWzSdTHQc0HuSpuI1WquDDAdNp0cy+gANqGvlVvdP1TnDs7S8mt6LD/6PTXNoCuIEFi
         SYElpvgJf8ofghjF/C9USCgB4kLDXTj7BBMLaw94Uqc+iImH23OUxaAQrCE73aSymM/J
         2SAg==
X-Forwarded-Encrypted: i=1; AJvYcCVf15nXvquuAg0kiJkxk/zVAtMuWNK9k3r93dANL2j7MZerxZhoIxdfJeVxsj94g3kfktcw3RBVIBKfzITJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAuh/mlT97QMgbX6txb/pCIUGTGAAPis8vsh26qzrnCexGIM5n
	e9q/11apDbwYxmya7mv4VGcZqlUiTSFd0XDlE/joyrIquI1oa2ZpHkSU1TVQOnn37a3OyRiaTbw
	cjbLI7lN9EVgxrG6JvbhqrQ==
X-Google-Smtp-Source: AGHT+IEyquCcT5XxZ9BgIpP/32+sIegfX+nvFI1VSjxlaKftnmHI/Ogt7pc+GLW7KEnHncBj/7BeWAroc3//byxO4g==
X-Received: from pjq12.prod.google.com ([2002:a17:90b:560c:b0:2ff:5516:6add])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c51:b0:30c:5604:f654 with SMTP id 98e67ed59e1d1-30e515873cemr701793a91.9.1747266223852;
 Wed, 14 May 2025 16:43:43 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:09 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <cebe2aa139ba2cdeabcef69eca235cada32b4a70.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 30/51] mm: truncate: Expose truncate_inode_folio()
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

guest_memfd will be using truncate_inode_folio() to remove folios from
guest_memfd's filemap.

Change-Id: Iab72c6d4138cf19f6efeb38341eabe28ded42fd6
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h    | 1 +
 mm/guestmem_hugetlb.c | 2 +-
 mm/internal.h         | 1 -
 mm/truncate.c         | 1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e4e73c231ced..74ca6b7d1d43 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2530,6 +2530,7 @@ extern void truncate_pagecache(struct inode *inode, loff_t new);
 extern void truncate_setsize(struct inode *inode, loff_t newsize);
 void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
+int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 int generic_error_remove_folio(struct address_space *mapping,
 		struct folio *folio);
 
diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
index 5459ef7eb329..ec5a188ca2a7 100644
--- a/mm/guestmem_hugetlb.c
+++ b/mm/guestmem_hugetlb.c
@@ -4,12 +4,12 @@
  * as an allocator for guest_memfd.
  */
 
-#include <linux/mm_types.h>
 #include <linux/guestmem.h>
 #include <linux/hugetlb.h>
 #include <linux/hugetlb_cgroup.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/pagemap.h>
 
 #include <uapi/linux/guestmem.h>
diff --git a/mm/internal.h b/mm/internal.h
index 25a29872c634..a1694f030539 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -448,7 +448,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
-int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
 long mapping_evict_folio(struct address_space *mapping, struct folio *folio);
diff --git a/mm/truncate.c b/mm/truncate.c
index 057e4aa73aa9..4baab1e5d2cf 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -176,6 +176,7 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	filemap_remove_folio(folio);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(truncate_inode_folio);
 
 /*
  * Handle partial folios.  The folio may be entirely within the
-- 
2.49.0.1045.g170613ef41-goog


