Return-Path: <linux-fsdevel+bounces-49962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91354AC64E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281E217FE9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8C2749F3;
	Wed, 28 May 2025 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb9z1b/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003112459D9;
	Wed, 28 May 2025 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422528; cv=none; b=ExnoOR+00L4zicL/K+Na8eElHW4+sam2dHpgIEN1XCY1mPLKeRWqjnReNe8s9m0SYJEChnjPTEAp853c3S6ZbNNh/w3aokZEAGUdEfoz+KBRt65FI/4osVqhfN1AEI0dZmfvl2NxSACAa9VlsjfuwKngcYonDMNp0EIXbXvYdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422528; c=relaxed/simple;
	bh=o/IBf/bL4uUQfqfko7CVRmw6Pl3VESZqBWXrtTbKLHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6bVmoaG2Zue6EhVB61zFqqS0E/GRoiUml8PprsByYg7twoFp890DFjNaHebvCPXaQ6kpzvh0ScgnklL1FHdpyhIecxga72PD03ACGF9tFiAVyirC35f6YAHNR/dHvk71h5fgiNc2hlaOY1GEV3d8SMJ3/LDLPGqLC9+x805Mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb9z1b/B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748422527; x=1779958527;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o/IBf/bL4uUQfqfko7CVRmw6Pl3VESZqBWXrtTbKLHg=;
  b=Kb9z1b/Be7vgBgT3nxMLgZpNH8w24y1kZKjH8ruWxRf9AM7HXq2Anijl
   sVkd8YQY7m6eX7a4HKw7bmtdJd3gyIUSpBClWkOpvyNkJyApu1Mp6NVqt
   C9dJU+NHnyH2n+LBY2OGveyuDtLF14bfLZU/34FmTY8p+Woi2f/ix8Xzg
   LCUNaF8hLATTy3X1KYrW+vJPm6kTu6CsAt/JrigfPbrXBiDYZeL4yinOl
   mmyy3GxTcgVS7uPwIR+YosvI5eutfl4NH10WHiKc5gWUuzQh3yJS2Y9r0
   dkZqYmZgAI8ic8vGwSEAdmszwirTE6Ma7RARTCGF2adOTEmX+7Xk3xDfc
   Q==;
X-CSE-ConnectionGUID: TqxAGj1wSda+VGBajRT0aQ==
X-CSE-MsgGUID: 5b9Wh10cQtOTLPyMz/GCyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61098598"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61098598"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:55:26 -0700
X-CSE-ConnectionGUID: 1yTLA9bhTNGc1WfrftagLg==
X-CSE-MsgGUID: YJGTweprTPmbgT0LpLaE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="166357521"
Received: from unknown (HELO [10.238.3.95]) ([10.238.3.95])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 01:55:08 -0700
Message-ID: <ad77da83-0e6e-47a1-abe7-8cfdfce8b254@linux.intel.com>
Date: Wed, 28 May 2025 16:55:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 16/51] mm: hugetlb: Consolidate interpretation of
 gbl_chg within alloc_hugetlb_folio()
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
 <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <8548af334e01401a776aae37a0e9f30f9ffbba8c.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2025 7:41 AM, Ackerley Tng wrote:
> Previously, gbl_chg was passed from alloc_hugetlb_folio() into
> dequeue_hugetlb_folio_vma(), leaking the concept of gbl_chg into
> dequeue_hugetlb_folio_vma().
>
> This patch consolidates the interpretation of gbl_chg into
> alloc_hugetlb_folio(), also renaming dequeue_hugetlb_folio_vma() to
> dequeue_hugetlb_folio() so dequeue_hugetlb_folio() can just focus on
> dequeuing a folio.
>
> Change-Id: I31bf48af2400b6e13b44d03c8be22ce1a9092a9c
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>   mm/hugetlb.c | 28 +++++++++++-----------------
>   1 file changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6ea1be71aa42..b843e869496f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1364,9 +1364,9 @@ static unsigned long available_huge_pages(struct hstate *h)
>   	return h->free_huge_pages - h->resv_huge_pages;
>   }
>   
> -static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
> -				struct vm_area_struct *vma,
> -				unsigned long address, long gbl_chg)
> +static struct folio *dequeue_hugetlb_folio(struct hstate *h,
> +					   struct vm_area_struct *vma,
> +					   unsigned long address)

The rename seems not needed in this patch, since the function still takes vma
and uses it. May be better to move the rename to a later patch.

>   {
>   	struct folio *folio = NULL;
>   	struct mempolicy *mpol;
> @@ -1374,13 +1374,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>   	nodemask_t *nodemask;
>   	int nid;
>   
> -	/*
> -	 * gbl_chg==1 means the allocation requires a new page that was not
> -	 * reserved before.  Making sure there's at least one free page.
> -	 */
> -	if (gbl_chg && !available_huge_pages(h))
> -		goto err;
> -
>   	gfp_mask = htlb_alloc_mask(h);
>   	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>   
> @@ -1398,9 +1391,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
>   
>   	mpol_cond_put(mpol);
>   	return folio;
> -
> -err:
> -	return NULL;
>   }
>   
>   /*
> @@ -3074,12 +3064,16 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>   		goto out_uncharge_cgroup_reservation;
>   
>   	spin_lock_irq(&hugetlb_lock);
> +
>   	/*
> -	 * glb_chg is passed to indicate whether or not a page must be taken
> -	 * from the global free pool (global change).  gbl_chg == 0 indicates
> -	 * a reservation exists for the allocation.
> +	 * gbl_chg == 0 indicates a reservation exists for the allocation - so
> +	 * try dequeuing a page. If there are available_huge_pages(), try using
> +	 * them!
>   	 */
> -	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
> +	folio = NULL;
> +	if (!gbl_chg || available_huge_pages(h))
> +		folio = dequeue_hugetlb_folio(h, vma, addr);
> +
>   	if (!folio) {
>   		spin_unlock_irq(&hugetlb_lock);
>   		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);


