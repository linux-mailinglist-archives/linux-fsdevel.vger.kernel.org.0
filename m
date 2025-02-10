Return-Path: <linux-fsdevel+bounces-41437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA8A2F781
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472687A20A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA4257AD1;
	Mon, 10 Feb 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHfABv4R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE125A2B7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212895; cv=none; b=UvY2//Z0o2g6dFkGaKZWhtQu//5FdQFOOZal0hzXElXu211rfGmTJ+J2kce5v0zMqEKa/MRRBJ2OQLYMdGV9qURfC5J4MfKFaEIAIgwv52Nh3vJl+EgakZrKHnzzAqPDXjXkN6lSPzBuB9IN1G4d/UnDreyL9+621yI5YLPO7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212895; c=relaxed/simple;
	bh=bygnSuQXiuOQjyaBUGwyRn+UXTRR8Z74RGWMpAmL/Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIvDtwSwfVN5ViwWc8N+DCml+Mkz/NpLyU6EeflsPfJ2kCkzdEa2EOB48dGwTd6WRG4VIr7RKV8YqOlIGqMBWqFx+nhb0ns2pRI9XaQo40deM9PuuOalQkUenXHf42CwLy3GkGI1SQXPNzze3ccQr+EgYJ0T/I10t+t+eQ8+Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHfABv4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739212892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
	b=HHfABv4RYeWqipXHSq04/wi4MMP0m9hznxA36W2EYX2tPB7aNG16Qru2I9uOnCG+uNGPL3
	EBxRaEid2bVY9OVosrqB5GsoImZ0siYJOvaSJYqgNi2kzpBS4VFDJZDCmx1wvR5NlPiLMJ
	jwyKYA2azhRRLMdtFR453Vyljj+rFEk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-PdX6QDOJOsKJo121POqmeA-1; Mon, 10 Feb 2025 13:41:31 -0500
X-MC-Unique: PdX6QDOJOsKJo121POqmeA-1
X-Mimecast-MFC-AGG-ID: PdX6QDOJOsKJo121POqmeA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dca55788eso1786967f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 10:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212890; x=1739817690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
        b=kTOZp/7g+g02+x2IW87knOnMMnVoXv0sP6p1HAsqkatp8MFKZ3BgxuCBlidgMAItqn
         IoCEGc5TMNicaaP4U0JaKQJ9aBOUn/Q9+FNjURKSS9l+bWt1VzwkUExh8QimuVbHz08d
         +C6qFhNHj9H1HsHj8jWTPx6Dtj+f/0Dn/UDLVivIDkVPp1BISGCTe8WLkCSy69+R6MhL
         B4Ajz3opn99zLnsfeBOPwPgbeKA34GE2aF4ISRWgQKuwijcXRdGT9Qiho6Bn869aZiKJ
         53x4MmfMIiqcZO2hVnUGxWCrZaytCC8Cz35fZeci3CAxhv+f49Pe3qHxHQNviFv3eLv7
         73Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWoFiggQDKiNXXK26+Bmhs5W3PImCSIeyCYz0h28KujLdRw9j64Y+ctUhPK6e8nFkU7cmynMNYFZgR0/Hyc@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUvwUK+IF6DCu8q+Zsnz9MHCt0RUomEmJ4GC/9AlKIf1Trgs2
	YutSvrlAqlSqBOIxaMOhFBdqO0PwEC7iOclnunssEMGu3ccChHLbDtl1U+01uLb4s0olLiv103G
	44ADCQJ9fWwAsltZH0MklEC6uD+G8zee3KHKMyV9MK8jlNzXSrNzHLdBbRqPW1S8=
X-Gm-Gg: ASbGncsxEBykbyZy7LZfSLBHZuJPTlfG1JBz4Kylpmuo6IHQZKx5ckmKACnAt27Lg1h
	62FiS043UcGdSFA8MZ8OTS0rFKsakdOcNdY52O/mORkHTLSEVLn/mii0LzeIh/tFDZNjwVy4W2Y
	lxt6Fa/rU7/elncYFr2GwFrvhGI+KLlPQXrh90ZMWUnmOsCR+U8jTAgR+WBzQWaGnBPeKHblkr2
	xDMmii9xiR8USAK6x2l2d7kPYCo9GZC2bQLULvn1Ej5jVS1u/afDDXtjvVy5EkT7CpJZwIp9AxV
	xuMEB4mgow68vNi0moEFcnVFnO7VHmSlTvjvvh/vbEYkdKNhwUut404a0a843/KgbzsFHndS7l9
	TJLFYcLUYHSu+9tM1+zxoREOGolzbXUJ2
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356789f8f.52.1739212890432;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjt5GOWnPQL8qWJWzWicp05/2CzwbVpqP4Iexee9A79WecGjReB/qxF3GuYmscVUvKpxlGrQ==
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356754f8f.52.1739212890044;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd34f2af5sm7815443f8f.78.2025.02.10.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 10:41:28 -0800 (PST)
Message-ID: <cca05a6f-fbfe-43c9-815b-eadbdcd7050b@redhat.com>
Date: Mon, 10 Feb 2025 19:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/20] rmap: Add support for PUD sized mappings to rmap
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
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
In-Reply-To: <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.02.25 23:48, Alistair Popple wrote:
> The rmap doesn't currently support adding a PUD mapping of a
> folio. This patch adds support for entire PUD mappings of folios,
> primarily to allow for more standard refcounting of device DAX
> folios. Currently DAX is the only user of this and it doesn't require
> support for partially mapped PUD-sized folios so we don't support for
> that for now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Nit: patch subject should start with "mm/rmap:"

-- 
Cheers,

David / dhildenb


