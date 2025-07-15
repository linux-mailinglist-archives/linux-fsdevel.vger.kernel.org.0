Return-Path: <linux-fsdevel+bounces-54978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7AB06126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7055825BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F2202C3A;
	Tue, 15 Jul 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0UOYUtj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BDE3597E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588978; cv=none; b=DtGnoBrjAfciVm17KBVKdGXmkXUt8rjKJv5hI6PL8oWyhpGBr4/bQaAWg9XJLQ0mKMMbpH1yiu3+8AR9hP1hZjgHV9/H10kCF6jm71/jKuBcC/RQQ6WlqsWbxq1w3/+2ax6I1kpFySs0ZXWhg4eNiqQMrxEYE1jooMm98wtVVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588978; c=relaxed/simple;
	bh=8O5XHcA9URsEqVwfZ2BVmgYjHoEc3boGu08XIia6nIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxuO0y1wn103RACF7d+RXNi0XukZETypI0AsLzpksIRXvwfsHaVUKJ3vYEYVgY5VReWCOc9VqrrzhZV+SeoxyTMuNyE+Fls8ruIl1NYEgbsJ1Ff4UCCQIKGHiQUexfD3g0KkYJO0oQvXKBABeBb5LmdE0q9BJR6E4xS2RWBJWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0UOYUtj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752588976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XcCNe/nf+U5xyNDth20FvcaJ04LceEfyGFSZgo7zRQ=;
	b=H0UOYUtjApWr+FrvIbXiYAEl7yhL6EvNeW6vVuTuFhqnb7RpVcgNuZJTfJ3BJYtyKLERTK
	HfvYnVPhvh8Cy41ugvMXrFpAzkk3IoHTNSwYqoBtzh49vRu9U6qrEHqHzb4ktsBzmbq7g2
	Ln7X3evVjqQgJKtYqQMeoa4F8FiKjxM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-v9nOwMLrM1iwbxX1oGmyfw-1; Tue, 15 Jul 2025 10:16:14 -0400
X-MC-Unique: v9nOwMLrM1iwbxX1oGmyfw-1
X-Mimecast-MFC-AGG-ID: v9nOwMLrM1iwbxX1oGmyfw_1752588973
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so6753945e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588973; x=1753193773;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XcCNe/nf+U5xyNDth20FvcaJ04LceEfyGFSZgo7zRQ=;
        b=ofpj1V/n/EXh2N+vBoHBxGnNXZbQgyYoRCtiwdykzn/Ulptx+rbWzuVW1hMxRs+xWx
         CRjHf/tBv6OZ211/eT92vQONz+gjcfftwO39kp3JZUiZk3VcQ6555SioBnZRrjww/AXQ
         KIZlG3egCYHMGld4ktN5Nis36a4KKzu9gNFYGIjIWsrDFCnoDtJanhKd4jToXzdovAlo
         QvLHtqARxU2jleqVNJZYpdj3ZyrBj8I55ASECmpMndfpNDDvCLZMVXGwv5TjpuqqOQ7v
         xLhEmlBGfq8vJ9Ga6hRGdZGO75X7lz6JCFcaZN3v4M147nCfsCbUBXLzwXF5qRyJr+PD
         5jCw==
X-Forwarded-Encrypted: i=1; AJvYcCXwRxKX2nwQA1VTLLojz8tguMIV3W9GaACxXy5XHLzDBDMn2xpxvnsuMEPEnfvCpConaok/umUpet5UJ47e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VU25FkdKUsCYHQMDckgSx1s5Ep/ZF7pcu/Hw1moufQikB/Dr
	3rLKwPyw5j/dDiE6xOopK9f3b4wCtYSY8qgB+8QvVM+Vu1ic1sjFkxBdzSZxn9L+vQf/lbpQJ2x
	NlMO5J8abjHTpgPLfRZxcjXUoxQt8A1NEdM0YpUYx4BmBWxYFQqAgqvraMhqZ0aGWREs=
X-Gm-Gg: ASbGncvMzVSmIhjDh/N5VB108d+bYICwEutRJdsEwOg1LvYEctkI+KGxNp9CITsx9Y+
	a8C9rihXs5gbN/6RlKUBrGBhdkPXnghbTcKeCrJjp+k8+LEfqnA1LOkzT9LxT4pQc8M/waWxovp
	3EF7CsboLsgIP9QwHRYmfpHiAA+s8ZDDmj9785pQzCAMNrdwYf6LGreyWkvy/+W6JXbnabPhJ7L
	cwEJ9E9Ydjs9tnGur5SN/XPp9fLqG3jisanXl/of2JCFCRxJkVW1XR+lwVG4Ozwd9kjQiiHbNXX
	cUUgJyWCBruPEjQZ+O/zneG1Q4Q3UDLwUGvcELzyJo+hpKwYhjBzDjIUilYJHg8Qp/bjjZVCd+h
	4+e3uVPVjsGftfAx9CW/QO9tiVG2ZsPMQlWlVAxxZOGH7ZoykmiSooWJKwQWAhrhRLLY=
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr74094215e9.13.1752588972822;
        Tue, 15 Jul 2025 07:16:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdAqd5mpjTzNtfViNTbx93bOKhaoN2CcHdxMowaucQPZVJnCVBn40lvRB+aBNGrYrmkgSNKg==
X-Received: by 2002:a05:600c:1ca2:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-4561a699783mr74093285e9.13.1752588972104;
        Tue, 15 Jul 2025 07:16:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032fcbsm203995455e9.6.2025.07.15.07.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:16:11 -0700 (PDT)
Message-ID: <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Date: Tue, 15 Jul 2025 16:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-5-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250707142319.319642-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Add largest_zero_folio() routine so that huge_zero_folio can be
> used without the need to pass any mm struct. This will return ZERO_PAGE
> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
> allocate a PMD page from memblock.
> 
> This routine can also be called even if THP is disabled.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 428fe6d36b3c..d5543cf7b8e9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>   
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>   
> +extern struct folio *huge_zero_folio;
> +extern unsigned long huge_zero_pfn;

No need for "extern".

> +
>   #ifdef CONFIG_STATIC_PMD_ZERO_PAGE
>   extern void __init static_pmd_zero_init(void);
> +
> +/*
> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	if(!huge_zero_folio)

Nit: if (!huge_zero_folio), but see below

I assume this check is only in place to handle whether static allocation 
failed, correct?

> +		return page_folio(ZERO_PAGE(0));
> +
> +	return READ_ONCE(huge_zero_folio);

READ_ONCE should not be required if it cannot get freed.

> +}
> +
>   #else
>   static inline void __init static_pmd_zero_init(void)
>   {
>   	return;
>   }
> +
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	return page_folio(ZERO_PAGE(0));
> +}
>   #endif

Could we do:

static inline struct folio *largest_zero_folio(void)
{
	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE) &&
  	    likely(huge_zero_folio))
		return huge_zero_folio;
	return page_folio(ZERO_PAGE(0));
}
	

-- 
Cheers,

David / dhildenb


