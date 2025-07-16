Return-Path: <linux-fsdevel+bounces-55178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E6B079BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740A0A410EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5F2C17A8;
	Wed, 16 Jul 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8jFtMlj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89C1E0E14
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679463; cv=none; b=OU2xuub7fzwW15tbpiSkeMfhWaRmgEpfh+IBkDOT3sBy++op+jHbnx+tSFrxhbJfWPP5Bp8f88hUh//TlJ+v/K8cDjyhYeQ6vfwkARnCkpLoeenIWOvpbfHm3uZezli8l0DUtGqJQwwd94n3klKrtAE4xImrgzt9jehqtp8Q338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679463; c=relaxed/simple;
	bh=DSlA9dD8ZHLAS7jGHsLfZpClyYfaGsrYQtqA4+tdm4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbtBiNpM82/KwUnajkDszErj9mWEm3lHINrF89ZbxiutwSXKMmDqdbDlq5NZIIeg+M7m1dJdywdUsU3iv9eyuT4rTPwnxoMzxj23HqZj+BFxLabRqIXN0OujINeBLwB6w/Dzeym4AUGrTicHYtK6Edw+Eq5eOCS98LRtSMJVzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8jFtMlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752679461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SNFlWBNpt9SYbkpdkC3AxTClHyrZUSfwmCSW8R0rlhI=;
	b=T8jFtMlj0ndhFitistB6zgL5ci8LHXjlRuIdHxevm6gDmV9Td+/V1QBBmx+7bJ3Ek1tIF7
	a36fjWFzBK5eUvnNII7/JaiaxKeOk7uw4tp1qV1sf3iXGz1PCXWti5wDVpxBB/dExSYT5v
	BKYO37uEDoF792EUc1m+/OGRnt3sjCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-pZBZxiD2OxG7basUIrvZkg-1; Wed, 16 Jul 2025 11:24:20 -0400
X-MC-Unique: pZBZxiD2OxG7basUIrvZkg-1
X-Mimecast-MFC-AGG-ID: pZBZxiD2OxG7basUIrvZkg_1752679459
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so39629145e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 08:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679459; x=1753284259;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SNFlWBNpt9SYbkpdkC3AxTClHyrZUSfwmCSW8R0rlhI=;
        b=PFTEcBJkbtOmscPb7qcDIlUERXMoFdZWJoxugvzx9UbuFSvuoks9llsZMR9J4UfPVk
         fVG/SAiCTXNlPYyKdWolpK+aWrIrsDiyOEsJ2HSXH2atHL7e3uowp3RnxzfMTfqmogMk
         pwR/hGEpTQ+F/leXQX0aUbIom1TamiQuJp76RX6tPj6WcXXlHRBHfzl8JFmV6qtg/M3k
         yjvFXy9V09jtTelKs4MNG6VFPqFboDiNcoHz9zHfZupXG+BgUaFz8vQCHHkAfiArHdm0
         3hljj0DEMzOmVZ6cqL2n+JNRV9t84nwoUw1tGL3AbBIXMd3i/DxFSNkOTHXXvYNcUcqZ
         ne4g==
X-Forwarded-Encrypted: i=1; AJvYcCWZtlMtHa/94+wXBAgDWB+IN4q361lJslEB+DLDnqbm5lxsGJS46gYN0N8Zc+5tTjpME8B3ADEKWROvYji9@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6iUN/atl8J8eCfZ4KRkByO/99b05J9NLny3Hh82N8Gqt1gxS
	II/CeCbKXxQkvNE54mE8QQL/fsJQcZ+L+JcT+hmZ1XExgmZ82PmV4/sXAdqUX3xEhf+GRZyMpf1
	Hncu19W3yfza6vGtXpw1hQVc8DbMNlft8zLojzZX0zF2UNYLlSdNiW9S22QD1JeebrKM=
X-Gm-Gg: ASbGnct9UhSWLhS6lcoa7fU+XJk5HlG+PjOPCGaHVdvkn8d+bmi9/yO9nNdjn79x/jw
	iwD9c955RmXb2mJHwl+zMcvBYU5Er8YK/6ywhDzQZ+3HrVR6m0135bP07VRaQQk/wa/D1HVUe9R
	D+n0PjH/ye8DT0DONfnmOocfv5BKsn9nUflnIncRUnR7fWebCE7LEkOx07vJ35CgalVv1bs0KZ+
	R1KvLydJC65OUlnUMPGL5HKidTuAo29jpLBg5ilQFzn/0I9141E9N3rFdUUfV+9hIW3KvNVKSSt
	YOxDTnbuSjgnGCtADIlXc0uL2cxpBcW+Lh6xbyADxCFFdltcIuWucTYjb8ekYxYl+iQuYrXERjd
	Lx4UKb54s5BG14z0vv53183Z0HVnx8a2ufBjcn5J2E1SnS8lOu/eom0Bcxu6KVj41jBc=
X-Received: by 2002:a05:600c:1987:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-4562dfe73c0mr37112545e9.13.1752679458455;
        Wed, 16 Jul 2025 08:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxuqbrkcZx4M5Xzniv4108zBNJL/oqX3SoCcALdEHsTatmbIhhC93lstqiOhvQonpy37IcTg==
X-Received: by 2002:a05:600c:1987:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-4562dfe73c0mr37112315e9.13.1752679458022;
        Wed, 16 Jul 2025 08:24:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm18558624f8f.34.2025.07.16.08.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:24:17 -0700 (PDT)
Message-ID: <da5aea8a-bae5-4cd5-83a1-94cfcb61a29f@redhat.com>
Date: Wed, 16 Jul 2025 17:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: move huge_zero_page declaration from huge_mm.h
 to mm.h
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-2-kernel@pankajraghav.com>
 <a0233f30-b04d-461e-a662-b6f20dca02c5@lucifer.local>
 <hi7i4k7gbbd27mtjyucwxjgwhjq7z4wtzm2nd6fqfnd5m7yo52@k7vwf576a44x>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <hi7i4k7gbbd27mtjyucwxjgwhjq7z4wtzm2nd6fqfnd5m7yo52@k7vwf576a44x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 09:47, Pankaj Raghav (Samsung) wrote:
> On Tue, Jul 15, 2025 at 03:08:40PM +0100, Lorenzo Stoakes wrote:
>> On Mon, Jul 07, 2025 at 04:23:15PM +0200, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> Move the declaration associated with huge_zero_page from huge_mm.h to
>>> mm.h. This patch is in preparation for adding static PMD zero page as we
>>> will be reusing some of the huge_zero_page infrastructure.
>>
>> Hmm this is really iffy.
>>
>> The whole purpose of huge_mm.h is to handle huge page stuff, and now you're
>> moving it to a general header... not a fan of this - now we have _some_
>> huge stuff in mm.h and some stuff here.
>>
>> Yes this might be something we screwed up already, but that's not a recent
>> to perpetuate mistakes.
>>
>> Surely you don't _need_ to do this and this is a question of fixing up
>> header includes right?
>>
>> Or is them some horrible cyclical header issue here?
>>
>> Also your commit message doesn't give any reason as to why you _need_ to do
>> this also. For something like this where you're doing something that at
>> face value seems to contradict the purpose of these headers, you need to
>> explain why.
>>
> 
> In one of the earlier versions, David asked me to experiment by moving some of these
> declarations to mm.h and see how it looks. Mainly because, as you
> guessed it later, we can use it without THP being enabled.

I assume, in the future, most setups we care about (-> performance) will 
have THP compiled in. So likely we can defer moving it until it's really 
required.

-- 
Cheers,

David / dhildenb


