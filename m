Return-Path: <linux-fsdevel+bounces-50428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCDCACC15C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB96A7A3E1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12593271466;
	Tue,  3 Jun 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx2v9pM9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074512701CA;
	Tue,  3 Jun 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936663; cv=none; b=LEPSz0hZ0iIJ4wrrt9Htt569ZC4eIHAWdUHC7tufRFO6fYtONs6zAqB2dhTnLYNDOcDYmYiRYTpSTM/WQRvxdC4s0E2XUXOWP/S3D/WaqHKFpq6Z2PiduhwnItLWeYHQtiRi7WJTZoQ5MeQSAEuIAK+wNqEtjJWQGy55ynFuf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936663; c=relaxed/simple;
	bh=UpRslWg9pkIdLUbErUepkqcrN/Ri7GcT0ZXvqzK9Dbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGzFRo7GXxJ1HABCqwc5d47GF3pAeCMwGlGMo1LfWCJKMEZeybetKWffr+uRxRpwznnas8ecqBGtmSe93EDGhl7FARTlHGJOYeO2fmtL2vbjsu44/EHKYqwwXtQLtmfcfUaJ4iQczGQIGPaKAFbiu98otpHzWcZG3LTTT2D+J1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx2v9pM9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748936663; x=1780472663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UpRslWg9pkIdLUbErUepkqcrN/Ri7GcT0ZXvqzK9Dbg=;
  b=mx2v9pM9/bey/s6GzqJJoaMcVEsCAmszIgfQk9BRKPCZu1nFdVC5/wq8
   AWfqr0zGOfDCPdo8I5OcLXE1KACB1KqzX/y/PPaSmFhASovSfKnYzjqM4
   NkQ01rX/Kj9w7+iQWFXFUcE1WmGrbeuja1+u03O3yEb3/oyKBmEnfEvJ+
   8VC1r61qicIG2AR8qTlb8MuW7C+lmwwYisPZeGoWx1BYWUuPTD2Uwz+R1
   fMtGAHaS76oeGbu/w3ajrqWuOYOai9J5kggL+aHNeI5/1g066v9lUhUhz
   1dS7MqtAWTKGXkdLcFcVxhVKbpFjwSS/i7m+J0WxE5Y1EQ+3WKF1+Bumb
   A==;
X-CSE-ConnectionGUID: aBo1HETgRLiENWCa4Wfgqg==
X-CSE-MsgGUID: OP7KxDaCSNiS9Qo5/A5TOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50658915"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="50658915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 00:44:21 -0700
X-CSE-ConnectionGUID: CjIy0pOCTVaGKVXeABbVtA==
X-CSE-MsgGUID: u2fHNmR1SmipYHN6PBBHdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144670277"
Received: from unknown (HELO [10.238.0.239]) ([10.238.0.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 00:43:59 -0700
Message-ID: <d0b582cc-0cf7-4cdc-b148-d8f61dea7253@linux.intel.com>
Date: Tue, 3 Jun 2025 15:43:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate from
 custom allocator
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
 <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2025 7:42 AM, Ackerley Tng wrote:
[...]
>   
>   	list_for_each_entry(gmem, gmem_list, entry)
>   		kvm_gmem_invalidate_end(gmem, start, end);
> @@ -776,6 +879,16 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>   
>   	start = offset >> PAGE_SHIFT;
>   	end = (offset + len) >> PAGE_SHIFT;
> +	if (kvm_gmem_has_custom_allocator(inode)) {
> +		size_t nr_pages;
> +		void *p;
> +
> +		p = kvm_gmem_allocator_private(inode);
> +		nr_pages = kvm_gmem_allocator_ops(inode)->nr_pages_in_folio(p);
> +
> +		start = round_down(start, nr_pages);
> +		end = round_down(end, nr_pages);
It's weird here.
Should the end be round_up()?

> +	}
>   
>   	r = 0;
>   	for (index = start; index < end; ) {
>
[...]

