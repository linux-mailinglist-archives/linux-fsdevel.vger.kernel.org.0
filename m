Return-Path: <linux-fsdevel+bounces-56134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00581B13B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1247516A698
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE392673A9;
	Mon, 28 Jul 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cisC2RQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789D924DD01
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709331; cv=none; b=meOfwQILCRpB6bDXAV3dBxfMXJQ90KG3sGZnbhVhw2jLbfbLfuY0LQEyPQ/BTSJsExd5CnggFduNs5VIf1cHzgBSPVTqBPrc1xIBQzuoAJrvJW+MTCKtETBpmJP1S9WeoPAsfhWhBsvDBRtqTyEM+ha4l3XUp7CSGZYToR9h378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709331; c=relaxed/simple;
	bh=TlSoO3vPV8cZBvh33T6m3vWvJPn44ULMpjGzeTRvAiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnhLNWslEhy2HEEHu6Wmshay1Ig9gMnJeFzbs/KekqiOw/bZ10VRR09e2fCBecPsxcURTJ2BpeVSjc3YE/B61dilScVnk4Kmor0axdkIFqSNbpm/blSLQXcOlr4KNPgrO+pENomzmp+TjoBU0AsehkxMmj0wsrlZlLpUj/k6FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cisC2RQ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753709328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Le65crWkL2r0S+fv/QPgs84i+1vkmflDFPmUD2ynLfM=;
	b=cisC2RQ427Q03SUBhXnvlXYrVQJ8rFpN/C0YkOIK34AeLNdNNR6yoFZOaN/GYK71Mr0xBg
	2Qb27pZZlO0YbPSihza7K377kGIUHDMZyPUIM2Bq6NJNOKqRTM0tdMmn9+oSNKm2QrNhRb
	N3fwamXtDGJbEinYWAfYvreZ8+kK9Wg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-0pH-jMHtOLS6p6ia8Oh8cw-1; Mon, 28 Jul 2025 09:28:46 -0400
X-MC-Unique: 0pH-jMHtOLS6p6ia8Oh8cw-1
X-Mimecast-MFC-AGG-ID: 0pH-jMHtOLS6p6ia8Oh8cw_1753709324
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4563f15f226so9010315e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753709324; x=1754314124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Le65crWkL2r0S+fv/QPgs84i+1vkmflDFPmUD2ynLfM=;
        b=sbVNKVZPGsWHNPW0hVZy5uD28Wkc2L3lC7w4yyFpNtLmwcrZZHq8J7LiZR3fI7IvWF
         emnqc69WvWLmm7IRsDEcmclslpP3kndx1HofUYkHAQkErojhzN52o68IftXyPpuq8tps
         YWrB1zZ/KKPnRCBJhiv+cuG472BNglcDCw69Cf6OeYN+6Pvx5LYXT+7D9ciH4qv32IAv
         gkzyhhhj0Kfc3P2Lf5sFLwAXMM1yg/kCVFawBJvVMCRe5NxaEf0JxVxDC9Z7jqboXqNf
         9KLnhAT8vlhIMiVsTvu9swwQk8E/8ZZ5Z8quDoyQjVEkFKFMo6GO9+eNLxGzVWZYyrNr
         JnMg==
X-Gm-Message-State: AOJu0YxxuY2pZAWNRL8VTmAeKJdAyy+Y1U6nuQlfBVD+pwL/xlQBuCeF
	OYzLOwp5QMB7t31HEKYevFJrPaLMqKWDaRpvZqErmxJ797wsPkP8Lylm16KBN/tkNN6M6a3So4W
	Xl3LdWp0ciFaOL3pGZuj000c5fRuSKYHECKXi3rzarvvY0Nw7nSDJG/sif2hSFF0sK4s=
X-Gm-Gg: ASbGncuma/NSHiMdM1N6XUq2IHGu3XRm9jNQDF2F03cRHfKt7AbgPnnhAhXlKrDDuQL
	ZdodIHdfXvw07BExpUqsfTFYSpKPodO/loQuu8/lBNjJPDkFf0vVfXK2yjHRwvNaiA0tUAETYWv
	NV2m4q034e/VARF5QBCeAkIykn3P2cY5appujxFy0cVXYA5NYHTkUhlBoHQZsihjMuASTR2GO9a
	2RH+RnTLLFL7SDejeHvEtfPujoAkko+aX+I08kfzTHQ2P5JAe19iD23fnU4O7rRaaBc0TnJcByh
	Vu2n9f1FoUYMZ7uuhC7UQCVud7Loc+sqrDhaSRTy+zrhyK3PyqPRN3EA3Sh68O5sXNdUupu1eB+
	E/C3X9y8xVxqXuCvGbWhTs2FSXvGiVpq+gTrNzv1IS0ire+LpNxgHuH4EOyOBW/Iif3I=
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45876447cfamr87417925e9.21.1753709324267;
        Mon, 28 Jul 2025 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsVPv+MWr7O6tN7PNmT8Q2J8IDZY4LgEZaJPbBaAXxPD+wuoWYfzqkdrvfI0jOOB8Ha1wgzg==
X-Received: by 2002:a05:600c:821a:b0:450:d37d:7c with SMTP id 5b1f17b1804b1-45876447cfamr87417625e9.21.1753709323785;
        Mon, 28 Jul 2025 06:28:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377f0sm156708195e9.6.2025.07.28.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:28:43 -0700 (PDT)
Message-ID: <e83ac8e3-06fa-4ccb-95e5-4f95ba5aba7b@redhat.com>
Date: Mon, 28 Jul 2025 15:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-3-usamaarif642@gmail.com>
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
In-Reply-To: <20250725162258.1043176-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 18:22, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Describing the context through a type is much clearer, and good enough
> for our case.
> 
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
> 
> Really, we want to ignore sysfs only when we are forcing a collapse
> through MADV_COLLAPSE, otherwise we want to enforce.
> 
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>

Nit: if you forward patches untouched, make sure to add your SOB as well.

-- 
Cheers,

David / dhildenb


