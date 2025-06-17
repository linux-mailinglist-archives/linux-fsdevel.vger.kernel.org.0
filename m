Return-Path: <linux-fsdevel+bounces-51960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC8ADDB4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB743BE90C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E01BC3F;
	Tue, 17 Jun 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S52GKHgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823931AAA1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184748; cv=none; b=MQ4gHNpP8wlSY0SlQfcq6fQJufEaM928LH12fatRQnvFd3EGDHpUkdJNduuvlsF7cbsU1XwfJWOIXFRZG+d6reYlrnDf3kGKakITG2EkxooXEPhuEBYHS9PqzTMFzArdLu9gM/+ET0Bh1NpN5U3SVgUINOEdxha43Ynples8k3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184748; c=relaxed/simple;
	bh=z1HS8C/JLe/RLbl0lUn0/hVKMbgjxeQeiEfHWc5ibyY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CJUUgXeT0iRf32yk1vvYPU4aOQ/kGJTzKCHc9Fyh/uLBc7YBw4fbvlVnatADCNH4zlYsId3YVkAi8OUhq1GtgYLdydfTQIVD38Tb2koWoqzLc74wVqNwKirl7zzGi3W5CBaWbY8u0JcwzYYelVl3n/Bd4E3Px5XQYzt7nOVxR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S52GKHgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750184745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rv8+go54DTXcKgASbvJVTrFfjolX5M2ijJlOPxlnV/8=;
	b=S52GKHgLcKyd4MuFUqDxndHzF7czQplnjkq+uIpBmwZU+OScVqCdab7akTPI3H6A/55tMN
	VNGTj8cYi1yo9Qg+22jSIC9ahMJ4TR5CMtcPx/carUsIubumqIhZKHlheS8QW4L4+/c+ny
	ITV8fRIfzYU7PSH9LkAW6CCMsUX9wHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-cfEXonn3N4iPX7y6BVxH8A-1; Tue, 17 Jun 2025 14:25:44 -0400
X-MC-Unique: cfEXonn3N4iPX7y6BVxH8A-1
X-Mimecast-MFC-AGG-ID: cfEXonn3N4iPX7y6BVxH8A_1750184743
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso37098095e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 11:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184743; x=1750789543;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rv8+go54DTXcKgASbvJVTrFfjolX5M2ijJlOPxlnV/8=;
        b=WziVkflewd9r0f2yPUlg40mY9J31MzkCt07Pen6VqPzBtb83eeEa+MK3I492JT5NZu
         iMIHZlA28uUjh3n28291Rd+I18he049i+kTB9vONhBM2M3ukkBjdGruAZ8bC/fkjlpHu
         umfKbJgKAj9NShv5oztFeBz8AjrExsqhMuhHSOuB7bfF2JPA9sgmFUfrwNRg3xsEvA2O
         RiwHDKWS69zi8eURa7xMum9mqEWQRm1le+zsojP60CETbxb8shp801eNJ/f7OjBQ7x9g
         +CsMnQti6u/Zs7AomETxUEybPr0hcLOobqDFOMnkPGpFjqbcuuvTHehm3RxxBTYSt8lE
         jCBw==
X-Gm-Message-State: AOJu0YyNEDpTrms7N9kvnXAmU0SL58Qjo2ILGSjrWpUK4CXVaqNkr024
	Q2Im7rrorHCQ1Rm6lqGV9giX0fBw5wWs+ImBO9IwDbyAioy8J2MEZQnh9CbWQAgytanFjpI3FPg
	A8bea1Db4GOlP89/R8woYuR6ASKVKURavVynSxkONFdlNChMD03DywMMcUoVv2KY9jvA=
X-Gm-Gg: ASbGncsnwiiVxFSUv3h+TkwecWRG37ESex3vGobRMv6vNt3Ae7AdfKK0Mvu1q/Wqj/x
	sd0onRZ6uzdhDKe8Q/y/7Hh7R9tN5PjGiPP082elAMxPhZXz0FkhqulDlX4JxrJFV4NonvRdAMj
	EmaN4V1chwltYu7VAyEFfqwZIHxB2EDDcLqohwpbVlgR7a9TFBS02DpjKsg1eg0uXye+mJdk7/C
	a6EG91QpC7OkP5gjUBrw+ew8JMcI/HPGkhRyogbaAhRkmrpi2kuHftrQrMj3MnQDGpkK4VkI5r0
	MRToS/BfIsSaR5Dzw7iXK48He+tqtJSR/U/Ia0DS85TN5+oOXdcgAIDsiacmPJvmlDTM9glAzCu
	JFAzdUlTz3BWOkfy0/gAysR51XrEi9wU/qh8RKEzn1tmJP9U=
X-Received: by 2002:a05:600c:1c90:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4533cadf6c4mr138587545e9.2.1750184742869;
        Tue, 17 Jun 2025 11:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt2u6/6Xe6ws+6S3kiQ4YJn4fe1Kd4pUR7bYe/o2ypTsCl50EnR9pKn3olpsSnQpCyTQ0oWg==
X-Received: by 2002:a05:600c:1c90:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4533cadf6c4mr138587385e9.2.1750184742504;
        Tue, 17 Jun 2025 11:25:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25f207sm182230225e9.35.2025.06.17.11.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 11:25:42 -0700 (PDT)
Message-ID: <338bc820-3e43-4da6-b09e-936bf55f657f@redhat.com>
Date: Tue, 17 Jun 2025 20:25:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] mm: vm_normal_page*() + CoW PFNMAP improvements
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
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
 <e7a6b0de-3f2a-4584-bc77-078569f69f55@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e7a6b0de-3f2a-4584-bc77-078569f69f55@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 18:18, David Hildenbrand wrote:
> On 17.06.25 17:43, David Hildenbrand wrote:
>> RFC because it's based on mm-new where some things might still change
>> around the devmap removal stuff.
>>
>> While removing support for CoW PFNMAPs is a noble goal, I am not even sure
>> if we can remove said support for e.g., /dev/mem that easily.
>>
>> In the end, Cow PFNMAPs are pretty simple: everything is "special" except
>> CoW'ed anon folios, that are "normal".
>>
>> The only complication is: how to identify such pages without pte_special().
>> Because with pte_special(), it's easy.
>>
>> Well, of course, one day all architectures might support pte_special() ...
>> either because we added support for pte_special() or removed support for
>> ... these architectures from Linux.
>>
>> No need to wait for that day. Let's do some cleanups around
>> vm_normal_page()/vm_normal_page_pmd() and handling of the huge zero folio,
>> and remove the "horrible special case to handle copy-on-write behaviour"
>> that does questionable things in remap_pfn_range() with a VMA, simply by
>>
>> ... looking for anonymous folios in CoW PFNMAPs to identify anonymous
>> folios? I know, sounds crazy ;)
> 
> I'll mention one corner case that just occurred to me: assume someone
> maps arbitrary /dev/mem that is actually used by the kernel for user
> space, and then some of that memory gets allocated as anonymous memory,
> it would probably be a problem.
> 
> Hmm, I'll have to think about that, and the interaction with
> CONFIG_STRICT_DEVMEM.

The /dev/mem mapping of arbitrary memory is indeed the hard case. To 
handle all that, patch #11 is too simplistic.

I have some idea how to make it work, but have to think about a couple 
of corner cases.

-- 
Cheers,

David / dhildenb


