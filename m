Return-Path: <linux-fsdevel+bounces-52870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C66AE7B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61829179E31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5228641B;
	Wed, 25 Jun 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfIGmdUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636A285CBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841867; cv=none; b=OA/0A1I+sJR3xLgMGAnIAFPlyZKkJpKVa3w/ZrFzD2qHd1ITGknP5g3g11ai03tsKKD+WHVx66GF6s+kYG38mGaG44Yztq/MjySbuqBp93SdZemLw4g7PkHPFkSyi2tZgt6qrtwX058+ybSVfKq8kHemBipHlxROUCKkReVK1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841867; c=relaxed/simple;
	bh=8zwWj2BJqjCHizpJytaa7v+o0cziQmCq2pTQn7WAbp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut1kNQPH7cv/JiQf4uB/pqLoLL9ea2DDEOe1TOXWiYWL6nUQkPw6CopSVmJULzvIAYJUS5cx++QvKwpvXnzRhYXLYsmBkqeLbzsOZ++/CN/qrCRCcfb1wjgItkbKX4uuZvg+Cb5oim1a9S/uAXGVRapydmdoVSHeonoaI/oE6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfIGmdUQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mN4I4L2hgAMe8omNzujSzKavpyJh1uCnngDNdOxcT+A=;
	b=EfIGmdUQAArAfLaIJYiKVrP8C8b+G8ukoIk7CK8uNjqh1CKco6HpYOEq5nKUDNluKk6H8K
	ciT+K77IgzZv20/OPO7iTXmCi22Io6Sod0RHWLaCBhQ8cSB596HHv2DwfnIBkXFg1y9ip6
	nJ/9JC3CPX0bisyXqRhE8lasEwTLAjU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ou6RqxHbPGGBbiqXB0jX8A-1; Wed, 25 Jun 2025 04:57:43 -0400
X-MC-Unique: ou6RqxHbPGGBbiqXB0jX8A-1
X-Mimecast-MFC-AGG-ID: ou6RqxHbPGGBbiqXB0jX8A_1750841862
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so2500421f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 01:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841862; x=1751446662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mN4I4L2hgAMe8omNzujSzKavpyJh1uCnngDNdOxcT+A=;
        b=p2/kIKILO2BDVlgo4Y+8WxdV61uJfYQZ5o/VVgxWZx2BtJxXxMDnGf4n61M+meEghD
         ivSnwMBvvNCvQ9ty+JziEgJ+E2LcsnYFMB2P/R5CmPfEm+IgVDbuTlq9tWmVnmdDVEJC
         gtZl0ydkL7hLbou5Elwwi2e0oLxZvplrsq+1e15kHBEYJnr172gAJz1lrtnFwIox43Yf
         dpDaAo9x0gv/1e7r5kvMECZqiGvI139GO3ivwRjH6qUcG/rKmUyhOc63NDL44YRATxCo
         LGKYpoCxeuk9eFVtnah0ND4BEeDsGUvdO74k3YdkLLWApbAtWCAXLFXiU1dNNmAA0Sym
         KlvA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Oq1LuTqZCnnZSdbrjwq+U0u7QxcvnqcWs/ge7HAqFtaiG8KkCoCMajgcnYHkGo+RqARB5Bm4PhbV8Mwy@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPN2ETYR2Uvss07RgZvLMBEY1ymYCPjrNNG8CEyalnGjYj73b
	HUlr2nU3WFyZHm8oJOJdjTan60UW3A5nyaZyLru0dFYt2vM4D4V/wfR9TiMR6h8fZuQykKdftgf
	gzR9xa97yvCSnBBtKCsfCi07VfexDVBRKxQEUZ5SGSNdQm5P9R7i01JyNHjPYeSmIzu4=
X-Gm-Gg: ASbGncta3H0/wcS+Q/26aY7FlP9Rku/k6TyK/ZEKjYI6XnP/1cxIq2pFjJFWSw92EBC
	rPzrOf4qTTAEL2I4uE68UGDJO5yflCjc6lN03px1Wd6BbedznrpTwNGP9d0j7wqkKjUx9fPD0xG
	9uNL9+kFMaocsoHQGeEedSNGLukCz6L/D/bzG2sCvy9BgWgwrqzzxdga/8x41QeLat9nJgRHuOh
	TGGGNGYGomKzYVLO4IpFDD2Rhf4LH97lHjf8eWdnwIoWCv1w0wras69tujZmmD+opTtgAD3d9Y+
	KAOzG4VH8jo9MmJAPixACXKtm+gcz/jc1aBKYfcXTGJ/Gp55Ymg0D85TcMwBeXDf5tR1RJ35j8D
	23YF8igqWxUf6oz8LX2ykaY1cL4LSprBZI6q/mi5voDso
X-Received: by 2002:a05:6000:4a0d:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a6ed6412e5mr1866867f8f.25.1750841862292;
        Wed, 25 Jun 2025 01:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2wzVVSUssZLp51IOGd4e/arg5P8SkkJKDt1VKkOp/GrEtmtzZfN1e1gqooQJhBiA1eP15VQ==
X-Received: by 2002:a05:6000:4a0d:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a6ed6412e5mr1866814f8f.25.1750841861910;
        Wed, 25 Jun 2025 01:57:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8055f0asm4046669f8f.4.2025.06.25.01.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:57:41 -0700 (PDT)
Message-ID: <1ea2de52-7684-4e27-a8e9-233390f63eeb@redhat.com>
Date: Wed, 25 Jun 2025 10:57:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/14] mm/memory: factor out common code from
 vm_normal_page_*()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-11-david@redhat.com>
 <aFu5Bn2APcr2sf7k@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFu5Bn2APcr2sf7k@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:53, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:41PM +0200, David Hildenbrand wrote:
>> Let's reduce the code duplication and factor out the non-pte/pmd related
>> magic into vm_normal_page_pfn().
>>
>> To keep it simpler, check the pfn against both zero folios. We could
>> optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
>> case, it's not a compelling micro-optimization.
>>
>> With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
>> really.
>>
>> It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
>> scenario in the PMD case in practice: but doesn't really matter, as
>> it's now all unified in vm_normal_page_pfn().
>>
>> While at it, add a check that pmd_special() is really only set where we
>> would expect it.
>>
>> No functional change intended.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Comment below
> 
>>   struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>> @@ -650,35 +661,12 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   {
>>   	unsigned long pfn = pmd_pfn(pmd);
>>   
>> -	/* Currently it's only used for huge pfnmaps */
> 
> Although the check kind of spells it out, we could leave this one and also add
> that huge_zero_pfn, to make it more explicit.

I don't think that comment is required anymore -- we do exactly what 
vm_normal_page() does + documents,

What the current users are is not particularly important anymore.

Or why do you think it would still be important?

-- 
Cheers,

David / dhildenb


