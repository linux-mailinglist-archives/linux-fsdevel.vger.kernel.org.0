Return-Path: <linux-fsdevel+bounces-49948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C35AC6286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547F37AD91A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B8243946;
	Wed, 28 May 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiiIIB0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D461A23A6;
	Wed, 28 May 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415716; cv=none; b=GGtMVbikouvXDVHq1VTpEGNAU/S341wtRzhwoYKkrPnIdTIUarwJPSBFx+vwMLKfm5ZSAJOFZOwjAM2LSd9ttefskiAyU/mTIu+X+ZuBK2xHrff3/y2oSCY+1iRy0Ewu2qPv+WMPVqTqwoPKlUxs4IDaOZVO7BbPYZHToWc7ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415716; c=relaxed/simple;
	bh=F/OH2byaWIb39+LvX14LmWOV3JG5wy+sTXzFUhj4ogI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ya4rhUcmqZ0ghJOqXHYfUGGXvvuRJtTkDRV1tz/woVnJl1DXormVGPtX8YB6XT3t7pA4YVD1Kmkcn6n7hySlC93FMEvOD1j3RJ5FgYxjlc3tcuofKZKTayat4fQ3v0pu252PhTXwvqhSNobzuzBU/O0h1UCtCqPqh/vpCp+vTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiiIIB0b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748415715; x=1779951715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F/OH2byaWIb39+LvX14LmWOV3JG5wy+sTXzFUhj4ogI=;
  b=BiiIIB0b+MDLWemHViCUf1tYA71vjUHu9kC1Kz+j12MIvsK56hit2/Jt
   Jiro5llJJaQMQ0HbK2kNwJKfZNP16mWiw/x9QZKCSN/XgGJa+l1UroNxK
   9YvXjsoce2vms2Evrc2iPhipAqT9ltZs9IklCAxUrOJIIMmLnpxDO0crR
   OpHx2PELsIpIIdcwHOeJ0sPO3txLQ+C4IexyfP3xA4V98QDKSoxGvjToR
   IesWxQDK9Y+sUBFCCkg7WqB4pS3SanqJXWJhUvARPTDUKuJ7/yZp/xoDL
   bL8wD8jnzbIrvA/b/sU+uB65lurCJA+7MkJpTmu0TViPkgbfFRxLIk2wG
   Q==;
X-CSE-ConnectionGUID: PYChIjCbQsKMihv8+/Ud5A==
X-CSE-MsgGUID: H/fseoArT42maVjVt50cOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61058292"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61058292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:01:52 -0700
X-CSE-ConnectionGUID: wmW7fVgDR2+XxtYJ87FHnw==
X-CSE-MsgGUID: 6tDCCgNVQZqzAr6aeJPyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148016015"
Received: from unknown (HELO [10.238.3.95]) ([10.238.3.95])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:01:33 -0700
Message-ID: <21b9b151-6e4f-47b8-9c6b-73eeb0c20165@linux.intel.com>
Date: Wed, 28 May 2025 15:01:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/51] KVM: guest_memfd: Skip LRU for guest_memfd
 folios
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz,
 james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com,
 jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com,
 jun.miao@intel.com, kai.huang@intel.com, keirf@google.com,
 kent.overstreet@linux.dev, kirill.shutemov@intel.com,
 liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
 mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
 michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev,
 nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev,
 palmer@dabbelt.com, pankaj.gupta@amd.com, paul.walmsley@sifive.com,
 pbonzini@redhat.com, pdurrant@amazon.co.uk, peterx@redhat.com,
 pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
 vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
 willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
 yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <37f60bbd7d408cf6d421d0582462488262c720ab.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/15/2025 7:41 AM, Ackerley Tng wrote:
> filemap_add_folio(), called from filemap_grab_folio(), adds the folio
> onto some LRU list, which is not necessary for guest_memfd since
> guest_memfd folios don't participate in any swapping.
>
> This patch reimplements part of filemap_add_folio() to avoid adding
> allocated guest_memfd folios to the filemap.

filemap -> LRU list?

>
> With shared to private conversions dependent on refcounts, avoiding
> usage of LRU ensures that LRU lists no longer take any refcounts on
> guest_memfd folios and significantly reduces the chance of elevated
> refcounts during conversion.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: Ia2540d9fc132d46219e6e714fd42bc82a62a27fa
> ---
>   mm/filemap.c           |  1 +
>   mm/memcontrol.c        |  2 +
>   virt/kvm/guest_memfd.c | 91 ++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 86 insertions(+), 8 deletions(-)
>
[...]
>   /*
>    * Returns a locked folio on success.  The caller is responsible for
>    * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -477,8 +509,46 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>    */
>   static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   {
> +	struct folio *folio;
> +	gfp_t gfp;
> +	int ret;
> +
> +repeat:
> +	folio = filemap_lock_folio(inode->i_mapping, index);
> +	if (!IS_ERR(folio))
> +		return folio;
> +
> +	gfp = mapping_gfp_mask(inode->i_mapping);
> +
>   	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	folio = filemap_alloc_folio(gfp, 0);
> +	if (!folio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = mem_cgroup_charge(folio, NULL, gfp);
> +	if (ret) {
> +		folio_put(folio);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index);
> +	if (ret) {
> +		folio_put(folio);
> +
> +		/*
> +		 * There was a race, two threads tried to get a folio indexing
> +		 * to the same location in the filemap. The losing thread should
> +		 * free the allocated folio, then lock the folio added to the
> +		 * filemap by the winning thread.

How about changing
“then lock the folio added to the filemap by the winning thread”
to
"the winning thread locks the folio added to the filemap"?

> +		 */
> +		if (ret == -EEXIST)
> +			goto repeat;
> +
> +		return ERR_PTR(ret);
> +	}
> +
> +	__folio_set_locked(folio);
> +	return folio;
>   }
>   
>   static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> @@ -956,23 +1026,28 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>   }
>   
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +static void kvm_gmem_invalidate(struct folio *folio)
> +{
> +	kvm_pfn_t pfn = folio_pfn(folio);
> +
> +	kvm_arch_gmem_invalidate(pfn, pfn + folio_nr_pages(folio));
> +}
> +#else
> +static inline void kvm_gmem_invalidate(struct folio *folio) {}

No need to tag a local static function with "inline".

> +#endif
> +
[...]

