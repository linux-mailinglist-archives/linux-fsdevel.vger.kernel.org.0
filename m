Return-Path: <linux-fsdevel+bounces-43847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250DA5E72D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87E93A9820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C61EF370;
	Wed, 12 Mar 2025 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsTVUJjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EB1EF0B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817846; cv=none; b=jY+MH3KNe6Kmj9TCaFqmUzVbHHpNbTwsBpl8dipmdkK1hwmDRsAMhXul5HpewYVM2AorNitjYecw1B3uSSxWcmPlCu1mrv+jmlATQAyena0iA4p6Ewjw6qdgvTsO7PomiQLN9dnaMyl2qVs8PC9w17XIcqWM+XWmOPOvpzugyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817846; c=relaxed/simple;
	bh=4tzBduGpo4HlaH1Lba8OlV8YQVTkSgbFX9CeezO16SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8kfHRa1ivAMPCUFUXg44r5HvWvbuemFmmjfc2DQK0D3Xrrb2mb4X230ul1O4yWJCH97NBYH2EHjWSShPLNcq8YqXKrqSWWAEvBC6/kttvFPqDdQ1cBXRj7oPgcaCZHvSoM/XvTp0cw2tADQhsrNEdFRr9MQAPuboiMqS7PbxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsTVUJjz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741817844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GjIBl5yndOQdnleTRVmAst04zzkiJlZJAcEZZ6NnjC8=;
	b=fsTVUJjzDXEHNpUnHCfXnx2R+4HQap2dE0UtmwSsexdxRwUhT8tTzh6sEa/7ARB3KFKn5e
	RUC0C6zRZhuP6bUvZMbBM6y0J8m916O7LV45JzuuPObffpO2ggR4IoDsVMa3FP+HwPsQCs
	QvV3F/q1X4LE72M3Uc48qFvVBpENx0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-U4CxwvTaNEeNSZTmuT-t8A-1; Wed, 12 Mar 2025 18:17:22 -0400
X-MC-Unique: U4CxwvTaNEeNSZTmuT-t8A-1
X-Mimecast-MFC-AGG-ID: U4CxwvTaNEeNSZTmuT-t8A_1741817841
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39126c3469fso138413f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 15:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817841; x=1742422641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjIBl5yndOQdnleTRVmAst04zzkiJlZJAcEZZ6NnjC8=;
        b=EePFZs5gQjgzWks5RbRNEtun8iqKtC4fZse5IzMkQmpfCNIIkvrxn0CI3HVTr/xMmG
         fybGLcmbM+B0MBocygZ6VP2oAKQaGlf9OWNlD8PqEfAxU2PZpiVlpp3IKSoJoYCW+F4w
         LN0FCapxi2Cx/CCxuIzcwztnCBKPDPAjCvg9hhQkocHBvwKgsIZB1g3ui6yYgu/GZCh2
         1eOpS7kFw2WYUbMt9yBlFxBAkpk/3ouaCZDIxuwIo3fwtTlpr6eHbbbIjh+Yekagrr6t
         gWeVwDcLdIGvjcxCbG86MXsPYOu6ELcrX8XAZzgacWVaFlRPaNRnUdaoFCWo7T3yDayW
         ZndQ==
X-Forwarded-Encrypted: i=1; AJvYcCURwPULmOKb6xjuEZeeSyegT5t+cJxWY4SsmuKeolhpEsqOU9fpXF2cG/KTvpgp7zKaQwTFhFfjNt4Z6kL3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5Yi0Vo4gnQBNvvV8KG2JYdbrIAwaFoDZqjd08DE6ZDT7c36y
	MFUvk3vJya+B7wajEBHTEW/0mXhTrQEsFez5pa8GVc5+2U4VgKcjOukpwK3WVqVHcPhE8YBsi3U
	FpY++jZ0epzQufIpaGxPwmJHWb7FYLoRlANjXt+Ejnm5r6OkTmg0us5hBaG+lx2M=
X-Gm-Gg: ASbGncu7dDZ+ZVnhAXTgvSqDlvoymVh0ZjgTt2XwNiXI3zMQvEmds/o5UFHBBMkmWNQ
	YaiprPLMrW4I/YjwxxVCcXcYOkGxzcUxjsFXSt/oy81PSw1h+3kAbmE9DWC8o61TSIF0GIlQnQx
	Pvb2p0KFOUUH5HlY/img2FJhLbt8ygz9ibf35lFMnpyxRCm9t7Bt7HTtxK9mgJ73/LIc6Owl/5O
	lMWP3PLRzlontkrqmouI4Z+587Ek3DE6v/CBp1RVLu16LkaQfXtC1aqLVvK8kcNOz6UNFw7qT58
	gB/MOsfrpf2j8sLkZwmy/Izoi1zupIAVGfM9fOpq7nRiEYNN9DmKZWdYRZaTvSo7Co3hzB2unOs
	BSbSollIiKCCTIXlqbjkXfhnX7y2IQ6vdtjZWAJrsGbU=
X-Received: by 2002:a05:6000:156d:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3926c1cd9e5mr10444693f8f.39.1741817841284;
        Wed, 12 Mar 2025 15:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7ajs+DbkvWkZrtvS3kgtwWoElT+oDfxGjlF1xcQLWnYsT+dOgzewtbm0o82DOv1DRYwzp5A==
X-Received: by 2002:a05:6000:156d:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-3926c1cd9e5mr10444674f8f.39.1741817840917;
        Wed, 12 Mar 2025 15:17:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm62270f8f.0.2025.03.12.15.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 15:17:20 -0700 (PDT)
Message-ID: <26e942e3-4e06-4644-b19b-ae0301bf9b2a@redhat.com>
Date: Wed, 12 Mar 2025 23:17:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: Nico Pache <npache@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, nphamcs@gmail.com,
 yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
 <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
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
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
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
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.25 21:11, Nico Pache wrote:
> On Wed, Mar 12, 2025 at 12:57 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
>>> Update the NR_BALLOON_PAGES counter when pages are added to or
>>> removed from the VMware balloon.
>>>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>   drivers/misc/vmw_balloon.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>>> index c817d8c21641..2c70b08c6fb3 100644
>>> --- a/drivers/misc/vmw_balloon.c
>>> +++ b/drivers/misc/vmw_balloon.c
>>> @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>>>
>>>                        vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
>>>                                                 ctl->page_size);
>>> +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
>>> +                             vmballoon_page_in_frames(ctl->page_size));
>>
>>
>> same issue as virtio I think - this counts frames not pages.
> I agree with the viritio issue since PAGE_SIZE can be larger than
> VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
> for each page. I fixed that one, thanks!
> 
> For the Vmware one, the code is littered with mentions of counting in
> 4k or 2M but as far as I can tell from looking at the code it actually
> operates in PAGE_SIZE or PMD size chunks and this count would be
> correct.
> Perhaps I am missing something though.

vmballoon_page_in_frames() documents to "Return: the number of 4k 
frames.", because it supports either 4k or 2M chunks IIRC.

I think the catch is that PAGE_SIZE will in these configs always be 4k. 
Otherwise things like vmballoon_mark_page_offline() wouldn't work as 
expected.

So I think this is correct.

-- 
Cheers,

David / dhildenb


