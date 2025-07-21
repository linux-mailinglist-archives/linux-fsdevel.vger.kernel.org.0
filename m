Return-Path: <linux-fsdevel+bounces-55583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998EB0C0FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0AC18C2695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23028DB4F;
	Mon, 21 Jul 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g52yxrs7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A428D8F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092644; cv=none; b=WJtcY4A972xZIo/9RtReJvU61R1KqkDHLPSxiZI2uSc6FcinJHzr5kTbI9JgO2NT3AHWfd7LDhfuF7icaBNlKkcsw7mOQBXJJdjXaiqX4ltfilwyqfo+SbngvZCKUrP5hTElT/QlSFZethmO54uikGmI3lIYVa2B61+xGibI55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092644; c=relaxed/simple;
	bh=7QET8QCnNLYs3jbtPVbIvk6HIXzvVH/bTeiHZw5lSao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBNBs2IUiTBXwDnbjZ3I6dWR/f+t5KW2k65UFdJtv2rSS17NxqMks/s5VldxbDMiY6Xdv7Tp89SJpK8ns8Jq+Em4OaAuTQe20+hxNRbEzhnXibLccwh+i6W0JzGC4oRHtj/PbRDqC+8S1nSXeFK+GFQBGHD8iYhs5wmWamcu2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g52yxrs7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0NugjdIePzRcMM8ZGljv12Jg4kfxteOSlIrE85rj4U=;
	b=g52yxrs7jNS6UrV52iN/0rAUMhVNeuo/TOwqiHFgGDjVGwIIwFesHX0vXmY9/PF7xN6vmQ
	fdyEkul3QVUOnx6DAg1OYgNkkTbgCmSZ08Yxwn0u70piWj7ze02BM+zrnF7xnTEh4v00CU
	0us8tO9WOYoXFl8ysPQOJ390G/gobyk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-VJ7dzg41MVm227bF_SqkdQ-1; Mon, 21 Jul 2025 06:10:39 -0400
X-MC-Unique: VJ7dzg41MVm227bF_SqkdQ-1
X-Mimecast-MFC-AGG-ID: VJ7dzg41MVm227bF_SqkdQ_1753092639
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so1764766f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 03:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753092638; x=1753697438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0NugjdIePzRcMM8ZGljv12Jg4kfxteOSlIrE85rj4U=;
        b=kbyorGht4hay6oc4fRjkb03zpVtkw7cJmycZq2Ri8Pfr7gIiCy9G4oejiN1DppSXd8
         vSYBj3VmpQM25wy/frrX3ffl2r9sCkfxVxhF778JxggiBzJXFvxAVLRV/Swj0SEvJjpH
         4kBINb6RhrdksxytkCz+m/Jxc8zPrAMt8Y8YZxwxHNI9TCDznA6hZCJGetwoQplK+r0E
         FIc1N0oYuEZJbmur7CVSMHkGWk7gFagRMeAs7W1GodLqnGiHyuJkNsPDSaUE29Q9eGqr
         1EeAzjDlYaGZkT9idnPTgLeRBj2YosYZE83NHwvAPyD9Iu41TTVonGrf9zmmAyAYGzm9
         4izg==
X-Forwarded-Encrypted: i=1; AJvYcCUeQc5B5G9kWeXSQB6v/i8pmcJob+KSoLgTLCdhWLGMRNDH8bDGIOsqjCQ4LSZUzZedcZ4ORtZ599D+dgEu@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCAeyTPM/UUwoUB7n6v44nh1lX58S1FTmbkttGSDTkkqCaIDV
	se7ijlawVHzi/xdCz7Tm+7nyTlhrb/hKaUf+EXksv+hKmFMnA/2CKJq6BdnJ/GKwGQqWS4rV6On
	CBWP10N0Kr0vWxpcDg4nkJYjfSzOVaMdvP15Ta4Ddh1a3oBkTQs8PWu8Uym1cT6KA3NM=
X-Gm-Gg: ASbGncs0WYtnoSPJhy6FtlNex1XBBTah377YCvKfmRunYqJlsf2Qj8eMlz9O4tybiPG
	1i+uwZGKEQBhNxz3RjhnRMiblwhjlNqkY+AHn2ts4GO8RB1gkM/OazqX1Rh+JVoue41NQq1nmH4
	F3T098PhSyQ3uC7iTnc1qIId3UkXXwQIhiKswyPg4rvhehTma2l6KeXwx5fXx+drRXkf53b6hYI
	A6uzRkqeiWiRnDY3aJrEReDTbAhG3RI0tMgcdJXyI/R7uDGDkKQBe5WEfI345GroIMN+YQWvFes
	qG3fE45w4rCJ6lniSHw+2UgfiGx2M0cmtiWBBo2c91Er0bQV9BFUUVtol8x02JB5uOPWGR9OpVv
	l54s0GFkpPGJjhBKL8wEuMtuG4oqOv/7TMDEUGjl4M56mVsZkCGyyCil8+OJDGY/0
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id ffacd0b85a97d-3b61b2188bdmr9213718f8f.38.1753092638522;
        Mon, 21 Jul 2025 03:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr9Bj7npF3emkZ6nnaN3iiQO29Uc95teKauJtipnBERj6xbTMIzTBxhnuJwBBOmhGP/0a7rw==
X-Received: by 2002:a5d:5885:0:b0:3a4:eecd:f4d2 with SMTP id ffacd0b85a97d-3b61b2188bdmr9213656f8f.38.1753092637918;
        Mon, 21 Jul 2025 03:10:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48719sm10064791f8f.47.2025.07.21.03.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:10:37 -0700 (PDT)
Message-ID: <5dffdbca-c576-489c-b84a-ec2747cfbc21@redhat.com>
Date: Mon, 21 Jul 2025 12:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Usama Arif <usamaarif642@gmail.com>,
 SeongJae Park <sj@kernel.org>, Jann Horn <jannh@google.com>,
 Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>
References: <20250721090942.274650-1-david@redhat.com>
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
In-Reply-To: <20250721090942.274650-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Two additions:

> 
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>      disabled completely


As raised off-list, this should be "only if THPs are disabled completely"

> 
>      Only indicating that THPs are disabled when they are really disabled
>      completely, not only partially.
 > > The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).
> 
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
> to PR_SET_THP_DISABLE through another flag if ever required. The known
> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
> that is not added for now.

I don't think there is any user that would try re-enabling THPs through 
that interface. It's kind-of against the original purpose (man page): 
"Setting  this  flag  provides a method for disabling transparent huge 
pages for jobs where the code cannot be modified ..."

So if ever really required, one could investigate forbidding re-enabling 
once disabled. But that obviously needs more investigation.

(also, if a workload ever enables THPs through that mechanism, probably 
it is to blame)

-- 
Cheers,

David / dhildenb


