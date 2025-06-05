Return-Path: <linux-fsdevel+bounces-50705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6BACE94E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AD3AA6EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 05:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF81F4E48;
	Thu,  5 Jun 2025 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zk9VwQ1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A261DE8B3;
	Thu,  5 Jun 2025 05:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101125; cv=none; b=H+RLWtXlW9+IBRBDFRIU8rDc7jtJHWF/TWvcnjwTivU+jn8Y6dC6bn/9tX6nn4FkSmyFsnwYV8eZ7vKqXtI1SCLHE9sBhFIkwc5xM4P3fv+iN+G8xTu0jF9+ail6PmygRD9ra/GdBu1sB/A4Evr03vtxzaze2DIE2+1vigkhcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101125; c=relaxed/simple;
	bh=+cdbKhZjBoZDRwbRa0KV1PYNo7teLIa2Q8X716SvQ9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D306UN0RcRMCuRXVlTXFheHRwITJY7KP5kTrej0wAGi/cbnnX3ErPgzHvaFm9+0SPDi5F9sAsRHpd7/Y6VTphlpnunv9ZQVHvv8H7IwB19tPob4RneyNLdC1tdOoknfaWKSZrL8cbFOEguZuWxEljvZMIA//OwGmsLHR5ltUEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zk9VwQ1/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749101124; x=1780637124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+cdbKhZjBoZDRwbRa0KV1PYNo7teLIa2Q8X716SvQ9M=;
  b=Zk9VwQ1/Jfs7pCflyWK8VdUgL5I4GK4y27mycU9DZ9j7sVBpc3zrUXsC
   POSROZrgswPZ79AXeg4fQLj7aRA6XCSGoQjmIrDBsFpzvGLoc0ZzUc1K1
   Og0XwdrmK/er74IrDJQjyIlFfVg5RCh6NJs1U4edosvRd3Mj49zNo/Ajo
   pNQJyl5bOXm2mIyRkgM3D0GA2m4AfWhdoKqodtNT5F+bua+Wc19GQQ38G
   Z7MdEyj+UJdqI0JvV0KqYUv+EJC/paY2PL9tG5JuOBCydY+yOQ14gFWof
   +d5Iic789ZT+rAut9j7PVgew8OOQEjv+ug0sWlot1Wdpy7O/Rb+tq8dnn
   A==;
X-CSE-ConnectionGUID: y58tkR3HShKZn0EMSi193Q==
X-CSE-MsgGUID: cqZv6qh/SsKKi/qcVqoYBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62560127"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="62560127"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 22:25:23 -0700
X-CSE-ConnectionGUID: xg/4fCFnQ4G6T1ilLlHNzw==
X-CSE-MsgGUID: mfb3AFnxSWG0gS83KmOkWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="182602137"
Received: from unknown (HELO [10.238.0.239]) ([10.238.0.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 22:25:00 -0700
Message-ID: <558a649d-d419-46e2-adb8-4027e105c1ce@linux.intel.com>
Date: Thu, 5 Jun 2025 13:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 38/51] KVM: guest_memfd: Split allocator pages for
 guest_memfd use
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
 <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <7753dc66229663fecea2498cf442a768cb7191ba.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2025 7:42 AM, Ackerley Tng wrote:
[...]
> +
> +static inline int kvm_gmem_try_split_folio_in_filemap(struct inode *inode,
> +						      struct folio *folio)
> +{
> +	size_t to_nr_pages;
> +	void *priv;
> +
> +	if (!kvm_gmem_has_custom_allocator(inode))
> +		return 0;
> +
> +	priv = kvm_gmem_allocator_private(inode);
> +	to_nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_page(priv);
> +
> +	if (kvm_gmem_has_some_shared(inode, folio->index, to_nr_pages))

What if a huge page whose attribute is shared?

> +		return kvm_gmem_split_folio_in_filemap(inode, folio);
> +
> +	return 0;
> +}
> +
[...]
>   
>   static int kvm_gmem_shareability_setup(struct maple_tree *mt, loff_t size, u64 flags)
> @@ -563,11 +1005,16 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   		return folio;
>   
>   	if (kvm_gmem_has_custom_allocator(inode)) {
> -		void *p = kvm_gmem_allocator_private(inode);
> +		size_t nr_pages;
> +		void *p;
>   
> +		p = kvm_gmem_allocator_private(inode);
>   		folio = kvm_gmem_allocator_ops(inode)->alloc_folio(p);
>   		if (IS_ERR(folio))
>   			return folio;
> +
> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
> +		index_floor = round_down(index, nr_pages);
>   	} else {
>   		gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>   
> @@ -580,10 +1027,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   			folio_put(folio);
>   			return ERR_PTR(ret);
>   		}
> +
> +		index_floor = index;
>   	}
>   	allocated_size = folio_size(folio);
>   
> -	index_floor = round_down(index, folio_nr_pages(folio));
>   	ret = kvm_gmem_filemap_add_folio(inode->i_mapping, folio, index_floor);
>   	if (ret) {
>   		folio_put(folio);
> @@ -600,6 +1048,13 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>   		return ERR_PTR(ret);
>   	}
>   
> +	/* Leave just filemap's refcounts on folio. */
> +	folio_put(folio);
> +
> +	ret = kvm_gmem_try_split_folio_in_filemap(inode, folio);

When !CONFIG_KVM_GMEM_SHARED_MEM, kvm_gmem_try_split_folio_in_filemap() is
undefined.

> +	if (ret)
> +		goto err;
> +
>   	spin_lock(&inode->i_lock);
>   	inode->i_blocks += allocated_size / 512;
>   	spin_unlock(&inode->i_lock);
>
[...]

