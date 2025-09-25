Return-Path: <linux-fsdevel+bounces-62805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D3BA12EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BC43BCB14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27E31D384;
	Thu, 25 Sep 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV1u3umb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD431BCAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828537; cv=none; b=nTbwdGnLGI2yO0RBJa1fbw1TaWD5vFayWPt8CyRJFAUVMDdKMvMw1A12L0IQauJUCJgk/nkqUuHc/K9EA7orT45ORc16u6UtKOxtIpdyEkHi0MisCw4AIeznm8kglU7HaI8FnqWa5WQAYaF+0OSDLQrA95d6TZ6JmG5zjKPzac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828537; c=relaxed/simple;
	bh=kOCORXCAXXJ2qj0YE5bKRj+HTBCxeKD9S0E68rhLDkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPRsMdhvkzg+nY2k2sXSN8ES8uqNazD9KBwvahxeY18/fGzSfvoH2I0dePNaKSQlpdbhOLpkUSyYM6OnrBvmoHbRNEOsu7DzVBEZduwP8lxgmdID6gytefUWFBQK/9oU2Ej8ODoa6gJz8qtbistVAqsIjvZaP7bzJbbF1jOOvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AV1u3umb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758828533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bq7ppmqVgZHliLbZBRvvT4qAn03nm4JKVOlNO1X6M5U=;
	b=AV1u3umb3hAJ0jcLxmdhLYawnY0G3iX1qbhr/VYpjd2MkS1bb516uC2cZCceG9a3Dfz0QQ
	0L1P/WseG94jvUw92qeeP6wreJBTJL0QdHJSQ+NjosQXZkOorpwMjSWXdWELAX7B5Ab/Sk
	Dz33CVrxT32WL8X1SGZiyFj1Olb8N7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-UZ4_tzW3OIOSMcPQB-kWgQ-1; Thu, 25 Sep 2025 15:28:52 -0400
X-MC-Unique: UZ4_tzW3OIOSMcPQB-kWgQ-1
X-Mimecast-MFC-AGG-ID: UZ4_tzW3OIOSMcPQB-kWgQ_1758828531
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e36686ca1so8609625e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828531; x=1759433331;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq7ppmqVgZHliLbZBRvvT4qAn03nm4JKVOlNO1X6M5U=;
        b=X/AZ2GJlpXqV0r0uVxw8Z8raf6L1tJr4/Dhm+ij5ufntFdVOLh+zI1xMEYKKdBSBrv
         3l65+wWenXZ4m39jtRFv4CTmxoffPbi8P7eEzep1KrKMpmLMl0jEaaJjFudO9cZQmNPx
         KtB0iibPSZ0zgoY5KRFkpybmJv+74CX9g0UQP2buK1T+d89Zvgwhe7iC/+UZBVTK+uut
         ukC/j2eHKXzoEqvF0mdEkIfVIGMTZjggQ4GbvRQly+CVeVyhhWjq3da5oeBE8rQM7BDJ
         SoQRii96t4GcpHuJPXB06g+pBHWt2+RpUsszxFTg2eCuT30SeSSotB1+szd6oxF1WNjg
         ZPow==
X-Forwarded-Encrypted: i=1; AJvYcCXjWltuj2yixQVssL1nBcagXOqd4rRRWjE1xwrbw70F1bg2u4i7E4rm1oETU7uMrXprcTXnk1tir6P93k4I@vger.kernel.org
X-Gm-Message-State: AOJu0YypiQLEjfeNPVhPqaX4FNoUNXkllnS91oFV/0aO0AP5gbVgvSa6
	wlsbcy7+C0tYLU2oJxIKiYDiaB1ibdHDNtgXaufo6q1oi959dTH77xgOKpbbIdplwkInaayRBpN
	6Cfas5h6dXTweCO7wVjmsrDvcXE9TZj81GtUNrPnyHJurAxhrptd63DhRRNwA0KFDvUI=
X-Gm-Gg: ASbGncuf3Vkt68bzgzV3pgnggKNcUsF8xyFdZmGf+ZpqBMnb86qNQprpuDkBxEICuEM
	aHaE0/3HF3jTF6Fg+ey8ayUaQBrd+hUNU2IofQB7FdJ8fi6MBpVVzMlI19iZLerY7nwZCCwlo7n
	kErAxujOnUioR6tTseEYd7zsQSbqEFF8FFxF34l06QSFctgBsVSN3m21s/hEhiZu520XFieOas2
	gutn4HVodDhb+f+4fFv7Ta6oYgCLL2yaF4+LRFgFmD9Mi/tT98HQ0hNhA7EYMpfgXFuE41vfHZ1
	3RLVD+hHLHqHWmVTrAy5muSpry7uH/ycdZfD3RBTcb0v4XtomXXly1JA1lTcQ7KsEt9chUh+CYM
	Fe6E3ONJuutk3yxakG9Q951Y77tWJc9n5cZm843EhbRBNpFb4QPhf3BKVxgw2aVWNbAFg
X-Received: by 2002:a05:600c:a43:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e329e4aa5mr41390915e9.22.1758828530776;
        Thu, 25 Sep 2025 12:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdB5XKgMH2Lxe6a6vu2Xy7Adch2dis5Y1Fy7OCZ/mT526GuwLzR5bO47EzrRa1c7ysWrxW0w==
X-Received: by 2002:a05:600c:a43:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e329e4aa5mr41390605e9.22.1758828530238;
        Thu, 25 Sep 2025 12:28:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc749b8f9sm3988405f8f.50.2025.09.25.12.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:28:49 -0700 (PDT)
Message-ID: <ff818815-8049-4595-9525-734245122443@redhat.com>
Date: Thu, 25 Sep 2025 21:28:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/12] KVM: guest_memfd: Add flag to remove from direct
 map
To: "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "haoluo@google.com" <haoluo@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
 <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "maz@kernel.org" <maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "pfalcato@suse.de" <pfalcato@suse.de>, "rppt@kernel.org" <rppt@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "seanjc@google.com"
 <seanjc@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "song@kernel.org" <song@kernel.org>, "surenb@google.com"
 <surenb@google.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "will@kernel.org" <will@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>
References: <a02996f3-fdf4-4b5f-85b6-d79b948b3237@redhat.com>
 <20250925155237.3928-1-roypat@amazon.co.uk>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250925155237.3928-1-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 17:52, Roy, Patrick wrote:
> On Thu, 2025-09-25 at 12:00 +0100, David Hildenbrand wrote:
>> On 24.09.25 17:22, Roy, Patrick wrote:
>>> Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()
>>> ioctl. When set, guest_memfd folios will be removed from the direct map
>>> after preparation, with direct map entries only restored when the folios
>>> are freed.
>>>
>>> To ensure these folios do not end up in places where the kernel cannot
>>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>>> address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.
>>>
>>> Add KVM_CAP_GUEST_MEMFD_NO_DIRECT_MAP to let userspace discover whether
>>> guest_memfd supports GUEST_MEMFD_FLAG_NO_DIRECT_MAP. Support depends on
>>> guest_memfd itself being supported, but also on whether linux supports
>>> manipulatomg the direct map at page granularity at all (possible most of
>>> the time, outliers being arm64 where its impossible if the direct map
>>> has been setup using hugepages, as arm64 cannot break these apart due to
>>> break-before-make semantics, and powerpc, which does not select
>>> ARCH_HAS_SET_DIRECT_MAP, though also doesn't support guest_memfd
>>> anyway).
>>>
>>> Note that this flag causes removal of direct map entries for all
>>> guest_memfd folios independent of whether they are "shared" or "private"
>>> (although current guest_memfd only supports either all folios in the
>>> "shared" state, or all folios in the "private" state if
>>> GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map
>>> entries of also the shared parts of guest_memfd are a special type of
>>> non-CoCo VM where, host userspace is trusted to have access to all of
>>> guest memory, but where Spectre-style transient execution attacks
>>> through the host kernel's direct map should still be mitigated.  In this
>>> setup, KVM retains access to guest memory via userspace mappings of
>>> guest_memfd, which are reflected back into KVM's memslots via
>>> userspace_addr. This is needed for things like MMIO emulation on x86_64
>>> to work.
>>>
>>> Direct map entries are zapped right before guest or userspace mappings
>>> of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or
>>> kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where
>>> a gmem folio can be allocated without being mapped anywhere is
>>> kvm_gmem_populate(), where handling potential failures of direct map
>>> removal is not possible (by the time direct map removal is attempted,
>>> the folio is already marked as prepared, meaning attempting to re-try
>>> kvm_gmem_populate() would just result in -EEXIST without fixing up the
>>> direct map state). These folios are then removed form the direct map
>>> upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.
>>>
>>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>>> ---
>>>    Documentation/virt/kvm/api.rst    |  5 +++
>>>    arch/arm64/include/asm/kvm_host.h | 12 ++++++
>>>    include/linux/kvm_host.h          |  6 +++
>>>    include/uapi/linux/kvm.h          |  2 +
>>>    virt/kvm/guest_memfd.c            | 61 ++++++++++++++++++++++++++++++-
>>>    virt/kvm/kvm_main.c               |  5 +++
>>>    6 files changed, 90 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index c17a87a0a5ac..b52c14d58798 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -6418,6 +6418,11 @@ When the capability KVM_CAP_GUEST_MEMFD_MMAP is supported, the 'flags' field
>>>    supports GUEST_MEMFD_FLAG_MMAP.  Setting this flag on guest_memfd creation
>>>    enables mmap() and faulting of guest_memfd memory to host userspace.
>>>
>>> +When the capability KVM_CAP_GMEM_NO_DIRECT_MAP is supported, the 'flags' field
>>> +supports GUEST_MEMFG_FLAG_NO_DIRECT_MAP. Setting this flag makes the guest_memfd
>>> +instance behave similarly to memfd_secret, and unmaps the memory backing it from
>>> +the kernel's address space after allocation.
>>> +
>>
>> Do we want to document what the implication of that is? Meaning,
>> limitations etc. I recall that we would need the user mapping for gmem
>> slots to be properly set up.
>>
>> Is that still the case in this patch set?
> 
> The ->userspace_addr thing is the general requirement for non-CoCo VMs,
> and not specific for direct map removal (e.g. I expect direct map
> removal to just work out of the box for CoCo setups, where KVM already
> cannot access guest memory, ignoring the question of whether direct map
> removal is even useful for CoCo VMs). So I don't think it should be
> documented as part of
> KVM_CAP_GMEM_NO_DIRECT_MAP/GUEST_MEMFG_FLAG_NO_DIRECT_MAP (heh, there's
> a typo I just noticed.

Okay I was rather wondering whether this will be the first patch set 
where it is actually required to be set. In the basic mmap series, I am 
not sure yet if we really depend on it (but IIRC we did document it, but 
do no sanity checks etc).

"MEMFG". Also "GMEM" needs to be "GUEST_MEMFD".
> Will fix that), but rather as part of GUEST_MEMFD_FLAG_MMAP. I can add a
> patch it there (or maybe send it separately, since FLAG_MMAP is already
> in -next?).

Yes, it's in kvm/next and will go upstream soon.

> 
>>>    When the KVM MMU performs a PFN lookup to service a guest fault and the backing
>>>    guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
>>>    consumed from guest_memfd, regardless of whether it is a shared or a private
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 2f2394cce24e..0bfd8e5fd9de 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -19,6 +19,7 @@
>>>    #include <linux/maple_tree.h>
>>>    #include <linux/percpu.h>
>>>    #include <linux/psci.h>
>>> +#include <linux/set_memory.h>
>>>    #include <asm/arch_gicv3.h>
>>>    #include <asm/barrier.h>
>>>    #include <asm/cpufeature.h>
>>> @@ -1706,5 +1707,16 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_id fgt);
>>>    void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res0, u64 *res1);
>>>    void check_feature_map(void);
>>>
>>> +#ifdef CONFIG_KVM_GUEST_MEMFD
>>> +static inline bool kvm_arch_gmem_supports_no_direct_map(void)
>>> +{
>>> +     /*
>>> +      * Without FWB, direct map access is needed in kvm_pgtable_stage2_map(),
>>> +      * as it calls dcache_clean_inval_poc().
>>> +      */
>>> +     return can_set_direct_map() && cpus_have_final_cap(ARM64_HAS_STAGE2_FWB);
>>> +}
>>> +#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_direct_map
>>> +#endif /* CONFIG_KVM_GUEST_MEMFD */
>>>
>>
>> I strongly assume that the aarch64 support should be moved to a separate
>> patch -- if possible, see below.
>>
>>>    #endif /* __ARM64_KVM_HOST_H__ */
>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> index 1d0585616aa3..73a15cade54a 100644
>>> --- a/include/linux/kvm_host.h
>>> +++ b/include/linux/kvm_host.h
>>> @@ -731,6 +731,12 @@ static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>>>    bool kvm_arch_supports_gmem_mmap(struct kvm *kvm);
>>>    #endif
>>>
>>> +#ifdef CONFIG_KVM_GUEST_MEMFD
>>> +#ifndef kvm_arch_gmem_supports_no_direct_map
>>> +#define kvm_arch_gmem_supports_no_direct_map can_set_direct_map
>>> +#endif
>>
>> Hm, wouldn't it be better to have an opt-in per arch, and really only
>> unlock the ones we know work (tested etc), explicitly in separate patches.
>>
> 
> Ack, can definitely do that. Something like
> 
> #ifndef kvm_arch_gmem_supports_no_direct_map
> static inline bool kvm_arch_gmem_supports_no_direct_map()
> {
> 	return false;
> }
> #endif
> 
> and then actual definitions (in separate patches) in the arm64 and x86
> headers?
> 
> On a related note, maybe PATCH 2 should only export
> set_direct_map_valid_noflush() for the architectures on which we
> actually need it? Which would only be x86, since arm64 doesnt allow
> building KVM as a module, and nothing else supports guest_memfd right
> now.

Yes, that's probably best. Could be done in the same arch patch then.

-- 
Cheers

David / dhildenb


