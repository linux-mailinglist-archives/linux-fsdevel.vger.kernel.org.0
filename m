Return-Path: <linux-fsdevel+bounces-49305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D01ABA4B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070533B0366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA227F4F6;
	Fri, 16 May 2025 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED2xmyzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F791A704B
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427623; cv=none; b=UH1m/8y8Ysu9nMqZDAztN9MhVvbDJ9vQUQw9+4eKmhRlc/ZOsnUd+EorFz+UQX/ac1/Y6b+HnZ25FxofAnYRcP17cmfzo47Cb2Fs8TC9KPqvGWgEzZRfVaFaq4gIzqwa/K+ZoQsVF6SibNPyZOq86yhuNNPjv7EUbpWO1bu+w4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427623; c=relaxed/simple;
	bh=cc97xfAiYvGKTGK8fMD2xSISeNEw80Ypm/iy+wjwmxE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=SdAglQ4EclT56/02oxWOcAgXG1JMw3Ync6JDjQQKVoaZ3j1YTf8J6oA7rAHyN1lyoTqj662Hhgwtug7MQSGq6wibFo1lcvuxVuLjghj+9p61uwC0xWbzJ6fHY+Paich4dHP1RwZz7igl2n7yAbNpVRfElrErDSM/L6D0twExM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED2xmyzS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22fd34d248eso20303645ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747427621; x=1748032421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m5gCf9jZx6CekOZ1/hsjj0G+6GTcjpxM10CINdzrmS8=;
        b=ED2xmyzSmVecdlJhTu0pcI6tZa5Jedhi2aloKfYKtunzzEbfw+Efleo0MI5AWe01fn
         Ub7f3GAKCrXDJfX0Sjty0WaHnYrCJeqKf5VKPrXiynLDpDzLlMcbzgjVvktttXny/83e
         MYDLdRaF8NUownVUYyh9lPVk2frV7WVueX9swPFIUVwrKq8TR7ja17zPVfYnS6eaqjcX
         sT3JLWKw/Z9rXxcJpkGNksGnTyKjWbMjGQ1kRU7AwUY6sKNvGLHv12MmDfmty2Y9Qg7r
         eD30m7NKmWdIX3YaQ5JQcCs6hJ+yzcAnKVivzfioBhdhQep5MlixyVxwHjCHU5noUrIb
         uF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427621; x=1748032421;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5gCf9jZx6CekOZ1/hsjj0G+6GTcjpxM10CINdzrmS8=;
        b=MGyLVbMCKGmB1OCBVtJ381wfVzALjcPAhF6cYStNdLitbJ3eSDfm7iOOz0LDQ9I0pX
         pOWjI5RvabdqaYiXGq7voW5j5Pbyee7O5jtVQi6Kl6IN2IZtO4tLik17jy/J2CJtsBuP
         VlmW8ZX30xCah42vdUZHT3AeC4PFyBQKiy8mTH3tT+R994ozoHY3z0uOwVbeWS25buGM
         x5VOfmrfG6G2SA2Em1zIobB96YYt3s/fX70Ay/1M9ZQFSQrW3jOntNCgFf2ZSURC7GqE
         7Ewb43YEePwI3XFjxWdYfHhaxS0krfFnS//H73OT8hG/sPpAW8IHdb8N/eh7k/pFwC1B
         D9pw==
X-Forwarded-Encrypted: i=1; AJvYcCU9X2QKGK2xN3kni4sS36VbpVoH/go0p/rz6NBUiKSQbLDOMrPqhRYcN3fBoJdQZn82S7y89tQOP+kV8Ksc@vger.kernel.org
X-Gm-Message-State: AOJu0Yysv8iKcI6U3hxsQhOCqb7qT4T/xi1AiUm6xEgpqdjcMHUk0oOx
	CK1mln4JjdfLvJMF17BzHO9lGpXvDqjqPOc5w7q2CRC2eaSzkusEOnyGudOzwUsevJTCd6JZpAO
	bGj+L+d2M8ZDlY0wN2QIP1MQwZw==
X-Google-Smtp-Source: AGHT+IGZsqgq2G2XIkR7qcIy/VW6gTpaWqSm/97lo1vVmXSkPBk6jSv3JCyUAX+95O4wmkeQ/wPnsUapN2qJLw24ag==
X-Received: from plnq12.prod.google.com ([2002:a17:902:f78c:b0:223:5693:a4e9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ec8:b0:224:1943:c65 with SMTP id d9443c01a7336-231d44e64e6mr60539585ad.14.1747427620934;
 Fri, 16 May 2025 13:33:40 -0700 (PDT)
Date: Fri, 16 May 2025 13:33:39 -0700
In-Reply-To: <diqzzffcfy3k.fsf@ackerleytng-ctop.c.googlers.com> (message from
 Ackerley Tng on Fri, 16 May 2025 07:07:27 -0700)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzecwofg7w.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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

Ackerley Tng <ackerleytng@google.com> writes:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
>> provide huge folios for guest_memfd.
>>
>> This patch also introduces guestmem_allocator_operations as a set of
>> operations that allocators for guest_memfd can provide. In a later
>> patch, guest_memfd will use these operations to manage pages from an
>> allocator.
>>
>> The allocator operations are memory-management specific and are placed
>> in mm/ so key mm-specific functions do not have to be exposed
>> unnecessarily.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>
>> Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
>> ---
>>  include/linux/guestmem.h      |  20 +++++
>>  include/uapi/linux/guestmem.h |  29 +++++++
>>  mm/Kconfig                    |   5 +-
>>  mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 212 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/guestmem.h
>>  create mode 100644 include/uapi/linux/guestmem.h
>>
>> <snip>
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 131adc49f58d..bb6e39e37245 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1218,7 +1218,10 @@ config SECRETMEM
>>  
>>  config GUESTMEM_HUGETLB
>>  	bool "Enable guestmem_hugetlb allocator for guest_memfd"
>> -	depends on HUGETLBFS
>> +	select GUESTMEM
>> +	select HUGETLBFS
>> +	select HUGETLB_PAGE
>> +	select HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>
> My bad. I left out CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y in
> my testing and just found that when it is set, I hit
>
>   BUG_ON(pte_page(ptep_get(pte)) != walk->reuse_page);
>
> with the basic guest_memfd_test on splitting pages on allocation.
>
> I'll follow up with the fix soon.
>
> Another note about testing: I've been testing in a nested VM for the
> development process:
>
> 1. Host
> 2. VM for development
> 3. Nested VM running kernel being developed
> 4. Nested nested VMs created during selftests
>
> This series has not yet been tested on a physical host.
>
>>  	help
>>  	  Enable this to make HugeTLB folios available to guest_memfd
>>  	  (KVM virtualization) as backing memory.
>>
>> <snip>
>>

Here's the fix for this issue

From 998af6404d4e39920ba42764e7f3815cb9bb9e3d Mon Sep 17 00:00:00 2001
Message-ID: <998af6404d4e39920ba42764e7f3815cb9bb9e3d.1747427489.git.ackerleytng@google.com>
From: Ackerley Tng <ackerleytng@google.com>
Date: Fri, 16 May 2025 13:14:55 -0700
Subject: [RFC PATCH v2 1/1] KVM: guest_memfd: Reorder undoing vmemmap
 optimization and stashing hugetlb folio metadata

Without this patch, when HugeTLB folio metadata is stashed, the
vmemmap_optimized flag, stored in a HugeTLB folio's folio->private was
stashed as set.

The first splitting works, but on merging, when the folio metadata was
unstashed, vmemmap_optimized is unstashed as set, making the call to
hugetlb_vmemmap_optimize_folio() skip actually applying optimizations.

On a second split, hugetlb_vmemmap_restore_folio() attempts to reapply
optimizations when it was already applied, hence hitting the BUG().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/guestmem_hugetlb.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
index 8727598cf18e..2c0192543676 100644
--- a/mm/guestmem_hugetlb.c
+++ b/mm/guestmem_hugetlb.c
@@ -200,16 +200,21 @@ static int guestmem_hugetlb_split_folio(struct folio *folio)
 		return 0;
 
 	orig_nr_pages = folio_nr_pages(folio);
-	ret = guestmem_hugetlb_stash_metadata(folio);
+
+	/*
+	 * hugetlb_vmemmap_restore_folio() has to be called ahead of the rest
+	 * because it checks page type. This doesn't actually split the folio,
+	 * so the first few struct pages are still intact.
+	 */
+	ret = hugetlb_vmemmap_restore_folio(folio_hstate(folio), folio);
 	if (ret)
 		return ret;
 
 	/*
-	 * hugetlb_vmemmap_restore_folio() has to be called ahead of the rest
-	 * because it checks and page type. This doesn't actually split the
-	 * folio, so the first few struct pages are still intact.
+	 * Stash metadata after vmemmap stuff so the outcome of the vmemmap
+	 * restoration is stashed.
 	 */
-	ret = hugetlb_vmemmap_restore_folio(folio_hstate(folio), folio);
+	ret = guestmem_hugetlb_stash_metadata(folio);
 	if (ret)
 		goto err;
 
@@ -254,8 +259,7 @@ static int guestmem_hugetlb_split_folio(struct folio *folio)
 	return 0;
 
 err:
-	guestmem_hugetlb_unstash_free_metadata(folio);
-
+	hugetlb_vmemmap_optimize_folio(folio_hstate(folio), folio);
 	return ret;
 }
 
-- 
2.49.0.1101.gccaa498523-goog


