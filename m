Return-Path: <linux-fsdevel+bounces-57301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B551B20526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9163818A17BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31A22A4CC;
	Mon, 11 Aug 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W68o7ghb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B81E3775
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907694; cv=none; b=cv9AKSkNJ8PQR+fYjmrQ2cwDXs+7DQEnj6gvDCmUBjxu9MvqN7Cx4BTC3cXKi3uq2cDdUp+gW0ku01Qx1QBohArfwSs60rySAlz6Qm7p37NUtUWnrCVUllWfTRCsZpvZW4lpMhkoG36j4++EvUH4umldNmhIbEq9BEjqgdwPqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907694; c=relaxed/simple;
	bh=ayqtFmkixjwDnTODx7shUTJ/SJAbYwLdJtISrLlnuaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAeo2NPGM9ymLY2B60zARbGtCvWD2bjwEnTI9sfSvBuedjGec/0ib5iIovxA3dLGhxTq88rDQEPCEtcf4i3IFUlp+rG+NB7yZQTguqzNEIVx182GEhtNplZ9Xd2rEIQ8UUSkmEZpzQi9hbUOUenggzJE3OBNXmS4j5b0bifaHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W68o7ghb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754907692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LH3iRZK7IeDS4TzLmHxpdhHsh5vYYAvHRC+uGiYwcF0=;
	b=W68o7ghbQEWRA4oblSr/KJW/UHS78B2odqWVmlk6H94Er1B/Tq/mzkBBRXr3Xhv1SMwbIQ
	lEQGoG6bOZeFT3ftQxRxp5kGDnBgq6W5dq/v+lZYO8l5MwXzjYrhkX1jlaxW4wcIDLxMgT
	XygXPCOWojzZk5iU43klbro19uJtges=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ZvyVkVmXMCihJ-9imPU31w-1; Mon, 11 Aug 2025 06:21:31 -0400
X-MC-Unique: ZvyVkVmXMCihJ-9imPU31w-1
X-Mimecast-MFC-AGG-ID: ZvyVkVmXMCihJ-9imPU31w_1754907690
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b8d5fc4f94so1738208f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 03:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907690; x=1755512490;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LH3iRZK7IeDS4TzLmHxpdhHsh5vYYAvHRC+uGiYwcF0=;
        b=TSF5Fdi5F9UOJiFAPfxzwRFbSRjj+nU0CnRjbkD+EdrB33HsjwTgGnOM2Pe34F12NF
         0yt4lGMsDoAd40WB1N6sd/ZqeXwSbXQuGC8ms3gQp0yO4olg3ajU5Er7H8sze67qAQeH
         acJdIHCg3zl/rnlThFY31QuekYV0RQvuA5lANeU8yVD6YkIqbs8aKEZG5Mqj8JrjkDKD
         Xa3j8SAKyhjGIRG7s+LsREMp6ty29qoMrZJAlOtVmZd3Vbd8b+C/vkxGJhAdDrfpJlli
         jcBnnRKIjKk8UIvdWvgl95mI9/9k3ROjNfLC828O92NKa8hhEimraPZsiVxOiptYwxDi
         SNhA==
X-Forwarded-Encrypted: i=1; AJvYcCUvW+m2WMtfhd6UiCRbCrAjInX7E4sgLa7fgzLzDbMlt+c46T08f8MV5SGvo/iml332h1QVRrqZz7Ro/ULG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyapq1+ZRlBBcbAxHcMbeffisOVyzW5uZwBst7YePxt/Ryfc7np
	EJXBOCvs/4uhCQaZGH2RshhEcU+qjklW2ZMSwjgmjT5N6LWmy1fkas57kqW+VMPh1shhfVXC73C
	UE2PZK597EQrzf0Zsl0iMWhe10OZbukQ1BJm/vRwNkaFinfzppqig8NUxCXDUut2kASo=
X-Gm-Gg: ASbGnctO9P/XUosYukuNOesFIhb9ASL6wH06xBCYdZ+e7q8g8j9ZxXrpdnEaCGC8udO
	kDmxIyjdBSC5V5wYe/UGafei5DBFpD+sNKfnSnkV5aiXMQP4gOK3wf7vvprun5Z0pzX02K9Cp1G
	+SpbW8GGCeV00ngrpOw1/9Lsby4EzwPO/j9RDHTTa1ffe648dnsMFocPsxuSOiFC/vZ3BWxzQYI
	pKyKmmJo6CmLhyhgeAPfbx2l3Wvb6mGpvtXHyjhpucJqXe1yFGtdzLFL8O91rS+EZaQfTKEPklx
	XgccbgUCxzuaBZWUJocdc6K3KW7fAVMSV3zJM6slIlVScNETWdytVW9A18oBN415LXFS9vpgYSu
	NXywf77BCsPHQ8anKr+KfKokf7fLE/kP6ixwObdJre3M99PWgHLhq00rvBaUVyvv/9bc=
X-Received: by 2002:a05:6000:4383:b0:3b8:f887:c870 with SMTP id ffacd0b85a97d-3b900b3243dmr9367057f8f.19.1754907689632;
        Mon, 11 Aug 2025 03:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9BiKofT8pklvpbhpv0YQsdaHNqXbde6OX7E3hrFNquhTSOBxDSVsC4PHUt1yybczkNcsvQ==
X-Received: by 2002:a05:6000:4383:b0:3b8:f887:c870 with SMTP id ffacd0b85a97d-3b900b3243dmr9367002f8f.19.1754907688990;
        Mon, 11 Aug 2025 03:21:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm345483105e9.22.2025.08.11.03.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:21:26 -0700 (PDT)
Message-ID: <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
Date: Mon, 11 Aug 2025 12:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
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
In-Reply-To: <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 12:17, Kiryl Shutsemau wrote:
> On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
>> On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
>>>
>>> Well, my worry is that 2M can be a high tax for smaller machines.
>>> Compile-time might be cleaner, but it has downsides.
>>>
>>> It is also not clear if these users actually need physical HZP or virtual
>>> is enough. Virtual is cheap.
>>
>> The kernel config flag (default =N) literally says don't use unless you
>> have plenty of memory :)
>>
>> So this isn't an issue.
> 
> Distros use one-config-fits-all approach. Default N doesn't help
> anything.

You'd probably want a way to say "use the persistent huge zero folio if 
you machine has more than X Gigs". That's all reasonable stuff that can 
be had on top of this series.

-- 
Cheers,

David / dhildenb


