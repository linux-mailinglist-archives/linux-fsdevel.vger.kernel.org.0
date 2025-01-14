Return-Path: <linux-fsdevel+bounces-39159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F6A10BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D671639C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD44B1CAA8A;
	Tue, 14 Jan 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1y1wuVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B71ADC88
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871365; cv=none; b=C7iE2hHHbzeC9cZMzuDp9sERhjnHwtWRj4IT3Au1vEg7rVI6YfIMZE16BZPfLSGW+CQaBGwlrG+EhtR37L376tngz5QD6lw2jjkLjPFCtOPoAK7rkl/Dl8GYoaWTAAXe5S0527i5UYe4OUZpqOYWI0HX2V2eoYz88WB3obirv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871365; c=relaxed/simple;
	bh=9QyVPolCezUvbBdiIcGpoR8EeYVhurGkFpaIP1HsnmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYS2rnmPEoWDHFB/YuPpAbHra73UlVVsvvmaUbiDg3VoUURAT7taazNsTxLguwFYyTq+/ZOVwjxIEyi38DL37c9K30m0QdPH2tZC40ItW6YvKH5KNaDztDQbqtNLicJ3hBUq80ayAV4Xyxe9Ps8bxXXKMw29e398XtBJgbYnxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1y1wuVP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736871361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BKZGegbns0oO2BiwJ3+f97YYTvSOiPn2dNKausDj72c=;
	b=K1y1wuVPm0xeJfz6ZhVEMVOUv3iaV9rbyHlBxtoRIgb1B81Vfispdpb+aI9i+ZbMuHdYFh
	DbebOj32TDyrlQy8TeMfJ1+vvgzIpth16crtap4CzUZ/Q6Sk5yjLilbKvy/pIBWBXSTF2c
	4PcvgdtWcY106xuWx2/rWbg7pX2h4eg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-30R9YrLSPNSvc_pEsuAF1w-1; Tue, 14 Jan 2025 11:16:00 -0500
X-MC-Unique: 30R9YrLSPNSvc_pEsuAF1w-1
X-Mimecast-MFC-AGG-ID: 30R9YrLSPNSvc_pEsuAF1w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362f893bfaso31087815e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 08:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871359; x=1737476159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BKZGegbns0oO2BiwJ3+f97YYTvSOiPn2dNKausDj72c=;
        b=uLtDkhLKThTsS72eF7EtH5k4bEpj6YRPKUT+2e3ftk0BHMhA/AI2N4UNiPQ1Uap2kb
         qG+3eyvPw/7WKgpW7pJCdDbQBK2fC68zxIdti0FfMkur9ujHoPl8vpPcBQtN8AVRy0dY
         8yLKkcbm9D2kxX9vvDqSZutIEGZXjfT8ExGpxYhzKkvh21erUOEeWgruszuDmarZQi9E
         183XysiuN8KWTEerISyF/QFLo/Wbs/tAF8B6PFC1+Ya+LzfAxj2JT8zck5d32lhSl1OD
         lw6eU8J7LyRmU3xi7CCcKAhDbxkx3Ecnr4OqOCU51JZ4aTf/KbaEiQsdu0SToGaCqXLO
         didQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH0WDSWSiwCozjhif4Esvxd6lOOvLMHcuUxvoTbEoyni9KxO3pEigQsOX+aED4st492rfq9kc2T6L4yvQj@vger.kernel.org
X-Gm-Message-State: AOJu0YxFA+qrjHkr4arw8Z0B2nFNTaul81ifBWXLT7GLlH+ClG41ZDvO
	jx7aIbXwXs8fWKpCX8zc8chJuajXkKprqXMLbrImbIjoDZ442/rLf+RH1V1qHB6470eZlT/sJkL
	XwnqUvnNfAdXUk6xms7xSscyFlUiwnYsUG2L4+1kPkR5bi0An8PBXj4qWBRB59OA=
X-Gm-Gg: ASbGncuS6YIL1Up9XvwZ8nGuqKijeuSAHJPctNN2HYLHf16Mu3m3tXjz/2C3J1OKsc3
	UlIUGwq06zKHXR0SkOfhOsvazev+8g9gcQCqYZx3DXfWaR2Iifig9VpL1AjFZJlTDD/Femm0LRQ
	4ZiLaGGQhmYmVSuXzr4GulzjXW+f3v5H2z0TYeQha+waDtrzN1we26nf1pcvmXppaeCzhPuEjc0
	rq8bJsV0/Tp1VjSe/c5AEX4WVwPBQ7+OvnZZpRGBH3iNGmbpTSThiqAtHJHA0SCIymS5o02gKio
	a4Ke2CUvcPl19hmBjMiqlv0NGTrAt3ddGiWC9waf5V7oiky8Ab5bdfXVHyd0kiyfhplGII1WJiT
	9OxSD3kUj
X-Received: by 2002:a05:600c:5355:b0:436:ed33:1526 with SMTP id 5b1f17b1804b1-436ed33162amr182756845e9.9.1736871359375;
        Tue, 14 Jan 2025 08:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQbYca8iq/sXXNIyR3sSpTPcooFVjpwvneyEuVZssY7PhZf37hAnmkM55yUX0wAVqiodKD2A==
X-Received: by 2002:a05:600c:5355:b0:436:ed33:1526 with SMTP id 5b1f17b1804b1-436ed33162amr182756535e9.9.1736871359013;
        Tue, 14 Jan 2025 08:15:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6249csm178402255e9.38.2025.01.14.08.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:15:57 -0800 (PST)
Message-ID: <17d32dc8-39c1-4aa4-ab8c-873c78097fde@redhat.com>
Date: Tue, 14 Jan 2025 17:15:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/26] mm/memory: Add vmf_insert_page_mkwrite()
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com,
 gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <e75232267bb9b5411b67df267e16aa27597eba33.1736488799.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e75232267bb9b5411b67df267e16aa27597eba33.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 07:00, Alistair Popple wrote:
> Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
> creates a special devmap PTE entry for the pfn but does not take a
> reference on the underlying struct page for the mapping. This is
> because DAX page refcounts are treated specially, as indicated by the
> presence of a devmap entry.
> 
> To allow DAX page refcounts to be managed the same as normal page
> refcounts introduce vmf_insert_page_mkwrite(). This will take a
> reference on the underlying page much the same as vmf_insert_page,
> except it also permits upgrading an existing mapping to be writable if
> requested/possible.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Updates from v2:
> 
>   - Rename function to make not DAX specific
> 
>   - Split the insert_page_into_pte_locked() change into a separate
>     patch.
> 
> Updates from v1:
> 
>   - Re-arrange code in insert_page_into_pte_locked() based on comments
>     from Jan Kara.
> 
>   - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
> ---
>   include/linux/mm.h |  2 ++
>   mm/memory.c        | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e790298..f267b06 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3620,6 +3620,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
>   				unsigned long num);
>   int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>   				unsigned long num);
> +vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
> +			bool write);
>   vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>   			unsigned long pfn);
>   vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 8531acb..c60b819 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2624,6 +2624,42 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>   	return VM_FAULT_NOPAGE;
>   }
>   
> +vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
> +			bool write)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	pgprot_t pgprot = vma->vm_page_prot;
> +	unsigned long pfn = page_to_pfn(page);
> +	unsigned long addr = vmf->address;
> +	int err;
> +
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	track_pfn_insert(vma, &pgprot, pfn_to_pfn_t(pfn));

I think I raised this before: why is this track_pfn_insert() in here? It 
only ever does something to VM_PFNMAP mappings, and that cannot possibly 
be the case here (nothing in VM_PFNMAP is refcounted, ever)?

> +
> +	if (!pfn_modify_allowed(pfn, pgprot))
> +		return VM_FAULT_SIGBUS;

Why is that required? Why are we messing so much with PFNs? :)

Note that x86 does in there

	/* If it's real memory always allow */
	if (pfn_valid(pfn))
		return true;

See below, when would we ever have a "struct page *" but !pfn_valid() ?


> +
> +	/*
> +	 * We refcount the page normally so make sure pfn_valid is true.
> +	 */
> +	if (!pfn_valid(pfn))
> +		return VM_FAULT_SIGBUS;

Somebody gave us a "struct page", how could the pfn ever by invalid (not 
have a struct page)?

I think all of the above regarding PFNs should be dropped -- unless I am 
missing something important.

> +
> +	if (WARN_ON(is_zero_pfn(pfn) && write))
> +		return VM_FAULT_SIGBUS;

is_zero_page() if you already have the "page". But note that in 
validate_page_before_insert() we do have a check that allows for 
conditional insertion of the shared zeropage.

So maybe this hunk is also not required.

> +
> +	err = insert_page(vma, addr, page, pgprot, write);
> +	if (err == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	if (err < 0 && err != -EBUSY)
> +		return VM_FAULT_SIGBUS;
> +
> +	return VM_FAULT_NOPAGE;
> +}
> +EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);





-- 
Cheers,

David / dhildenb


