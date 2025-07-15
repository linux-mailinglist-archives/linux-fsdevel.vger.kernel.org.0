Return-Path: <linux-fsdevel+bounces-54987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7EB061B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA2B7A4378
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95418BBB9;
	Tue, 15 Jul 2025 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzKpmrWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3961D8DE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590807; cv=none; b=jV/YLsprIqrR8WrEobjQEfqLxWV2PiQi5qb6whGL+vQNQ0IKNTKdi1Ti/lRTDeQA4xq9PBrvAaAZT0yHrG22Z4qT9G5Pp3OMxSkeAysRK2sfAvM3qVXO+91csqPoDP62HlfaIsifdNXZhBVla03aEanJDOs6YKCJPV3diJ/CsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590807; c=relaxed/simple;
	bh=4Dx7X+adfNMe1QrirxtiVSDzHq+xAnMsYW1YjuFFRVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ms4g6HG3Wx5AKj1dqNwB8EtuuzfmV95kN50qVeUTm49DBkEavkIuNPS5hAZ0jqEHNRZSQmwBBZYMvyRWHIMrS74WjqqHilBB/awHMQxT0FnEWQlhA4g3cZrz39/Non06qsntWL6TX4XIkMZMcJiKmfD9OZAk5L4UMkFl3CVvH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzKpmrWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752590804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
	b=KzKpmrWofBmZWxpJBMHqrVzjHGMoDuK4HQRDvni01RR4s5GuOVaLPC18ZD7fq4Zzp9fOSC
	DUfLEFAmGb4h5qyg0d8dd4Jod8XVVpCwoUiLQMkq/q9O85hrsgic6ihYuUix8Gh0iyUUhd
	pBxSs1zDBFP2svld/d8H+7pBQRij4UY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-F9TCAWT-OHmI7NxYKORkLw-1; Tue, 15 Jul 2025 10:46:43 -0400
X-MC-Unique: F9TCAWT-OHmI7NxYKORkLw-1
X-Mimecast-MFC-AGG-ID: F9TCAWT-OHmI7NxYKORkLw_1752590802
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so32147135e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590802; x=1753195602;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzGhqdPWIdp6qa4/aszQPMFbX29AViQCZYajzErY1Go=;
        b=SLyliK32NGZr8N+IkSwgkLvZois7+L8ZOerkFox6IEqiglD/kig51HG4tia3w7yWDV
         KjPu7xJ1ORm89NC0DBwcUl4S0lta4+enCHSq3NtjmaCnSWadQE0uZOL3kaPsgm4CedhP
         uuYAwerhbhWNn0IIZw2wG8PfadRVXMYQsH2Ars4MKKmkicbd45ac+1TJKmMZAgLxOqis
         /NBYX+u8r/LV1jMG6PUtzt0YzqyCoefAS6IO+2JWZcunSKW7fcLGwI5/MpnNMEmauJ+k
         UH6e6MnCSOwlbgQ5FoIayy4Bbi23+rwxukIG27UUSnMRAy+atI3kj89KTpVRuYm/QoIF
         9SkA==
X-Forwarded-Encrypted: i=1; AJvYcCV14A7Q5ewLPd2KJoDkuyVvnPSj1EMXcwceC9fmk3Bm90TErI/DRco8RU014nFvM89Sr24VBQ3qSn9WBK+W@vger.kernel.org
X-Gm-Message-State: AOJu0YzugiTOwOm+uxAwkUtOuJnzXkeV1Ou6Y5VBrGWQfHSzKWlsvuU4
	pj006l8G9xwd+fkXTKqPv5sHDb1bP26DD3wC8euu38fj2rCHe8ZtFiGn9VEJQ9OeFKWY7UoAZ3T
	qr/GfXoRK8xIAE60/CT0YtqCjkmaOXyDAWo+OFUIsvKfxAlE1zGSWI6csXuH4XvWGD9c=
X-Gm-Gg: ASbGnctHlhOZAdwKZq4+thaT9eXcd4uEVdFIpB5csujUZCAKorIp8VETdIDH84gWI2p
	cHKBtFFyQj298iEPm9X+hoEIMhjSfvENnhp3ONYXi4kfP47ZhmTfyWnWPJ5FavbMhiOgu40T4Kh
	wk7XeRRwWkVqOR0yiOD0JYpUjh5o6nQ+4OW6Jyx35M7B9WBJEvJR4cXeWPqp2HL4AG5PF3OcP8A
	KKWfpE58q26OTCavC1s5uCBHDFrditojLJE1YGLryHqVeXmEJqmFUlMumB1/qMukdvKJbUMT/vQ
	g/UYzpwGUW6o+i63eMejK3bxP1oCLusdkv2B89ZiokOOLNPuiXFqiWRkDaqmCGGRCWwWTRMDJIk
	1hOSQ1n5ukyyrmaTf/4cTkMbIxnqE6wAmZGVPJgmlK2TygbJk9guAbQttWxN9LT7yLNI=
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92241405e9.12.1752590802069;
        Tue, 15 Jul 2025 07:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjgRt6fG2l+5726ftG86wKHrZnvMgD5gCYV3wjOd0XaKxS9B031j2vkd+aj4JONoIpTYuyQ==
X-Received: by 2002:a05:600c:1913:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4561a16064fmr92240845e9.12.1752590801526;
        Tue, 15 Jul 2025 07:46:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm7615699f8f.23.2025.07.15.07.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:46:40 -0700 (PDT)
Message-ID: <bfbb1fa6-6537-4714-b5ff-a386a86c06c8@redhat.com>
Date: Tue, 15 Jul 2025 16:46:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
From: David Hildenbrand <david@redhat.com>
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
 <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <0793154d-a6ca-43b7-a0c3-01532d9cccc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 16:16, David Hildenbrand wrote:
> On 07.07.25 16:23, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Add largest_zero_folio() routine so that huge_zero_folio can be
>> used without the need to pass any mm struct. This will return ZERO_PAGE
>> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
>> allocate a PMD page from memblock.
>>
>> This routine can also be called even if THP is disabled.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>    include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>>    1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 428fe6d36b3c..d5543cf7b8e9 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>>    
>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>>    
>> +extern struct folio *huge_zero_folio;
>> +extern unsigned long huge_zero_pfn;
> 
> No need for "extern".

Scratch that, was confused with functions ...

-- 
Cheers,

David / dhildenb


