Return-Path: <linux-fsdevel+bounces-47047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD239A98016
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750DE3BEFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF732676D9;
	Wed, 23 Apr 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TchZbYGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF71C5490
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392064; cv=none; b=DTZ4mUV9KB7RrSXNhaTJPuCffiWVXEr/SNNJBjywWYstKVXiBtPeFoQ/IkLmriD0IImA+0tJAWua9wj9/lydE1AI1tvC4ckASkeDJhpowEFCThYpqKsz9/2NC4Z1HoKxKoCm40Mxh+yUtgpKjkU29cU33yJzKkmCC6RwVTAPja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392064; c=relaxed/simple;
	bh=XPPxI1EePJ4jyAPmTekOSjxtM9GFxM850aU6g30qXUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtowNB00ObPCZYR942hIpIk3SCSYFb2c1W0/6TiAXdbEALkx1cef0hUGTrXU1YhSRWZKDmqjLXJI/mh7vgtBGUEsQLJceFoHm2LbsV2h2JeTzcthTs557GE1CEFcVwDqtfu35FinrgUuhbgyJi90hxu+L31qAYzviqdJcwrHwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TchZbYGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745392061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bSQuFpFcF+zoT6TtvXA/st2f5GKi8OfxXR7q5g/A83o=;
	b=TchZbYGIv7akgfoqIedaiRrb3fyMB+psBvVfPzhL6FcgA99yKbFQ+TCYNF+z7921wEBDl1
	pgIRRi3PpKXFk0AfUIfk8t20/m9IR80supipevm++pzLKx6l+Q1ivhYu8bktk+uG+uo1RC
	G79ccz5tEo72Z5pg/dQW5JAQgsc80Mw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ca_5IyDvPH6mxhoVHlMvKw-1; Wed, 23 Apr 2025 03:07:39 -0400
X-MC-Unique: ca_5IyDvPH6mxhoVHlMvKw-1
X-Mimecast-MFC-AGG-ID: ca_5IyDvPH6mxhoVHlMvKw_1745392058
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so43694495e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 00:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745392058; x=1745996858;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bSQuFpFcF+zoT6TtvXA/st2f5GKi8OfxXR7q5g/A83o=;
        b=NAjFm2XXc5lVr3IKWHJi+CrIepbIwZ1lEZ5DXBPnue3xkMCEXNZwBdpziRMndpNxg0
         tPNQRUOKVV3Y1KpXeagX3582TzvYRda9124zvmKOMN6bY3nft9OaiYX1u0reYanxK5sj
         IuxgxM5zVDRkicM+TkYUOdKTtzh4eHqcop2C4rpx+4g/4fTsn6MGntCFzTpSxprQ1pb0
         TBBQw0+92YUQw6q3cdqyTIgD4+vJuR9txt461S7cR8FB6gRmzoaOS2DNefyb+SFp4JPg
         lry9R7o5k1AlWmDyab/OmXsJnQzghXlU7rVuGjSosa8PgTy9fD76bJGdcJym5gmxu7K/
         cllw==
X-Forwarded-Encrypted: i=1; AJvYcCWQfoeBd4erOj/r+YR5cqlu83AHd9To1KhZojCIpznIqClPHfs5Zwz8xcGlCWLKBFPEpsvJl/7qf0R9kUec@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76dWw7PViknkQ8kqpFaSXJqljXKLidqNyGlgb1271Qu1PzjaS
	AnceI//r3hgiToazZcyZYb0fz7bccaXeHVJrdvp1MnxcEEHDyQSQhs7XMeZP99A/0y93nsGYTCD
	Hayxn2vycC1X0oDhnU5sPsxo70yn9tUQVg2iH21qtRINYnijPh4qf7HU9n+6Ga5k=
X-Gm-Gg: ASbGnctbFFyvOr+9ZDA+Wz32aOIJsz3Gh6H6IELh9ZbuO/iKR8HzgD/ThcvBQlTAbSQ
	zEc8hWQjrhMMjCWn+84Q5PNau7Hob/3uY9nhC5xlGZcr0Nhg8AVZeUg55oUFqj9akdMuepzjSSS
	faagvmr5GJtr+Y95CnKqrSGBZoRx6/RkUqnkGQvUY4SE5DleWjiu3i/4/9F/8Sj4OngZrXEdtk+
	moW61WZs5kojL4VDV7VhDqemHykU1APR4088P9O2n6YcqhWsGx41XAvNPUNa/YNQ/schGDZvYZ9
	lC/Gk/p6pzfuYGP8Cn24TrHggZncx82WB/2yRF/aeCdmbRKzXZV+ScliwZgJ1dvdc25FpwHxbTV
	6zv/U4P8hpNfXteHLZXYbjWgWycAjrLsWxoFH6vg=
X-Received: by 2002:a05:600c:1e0a:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4406abfba46mr151994935e9.20.1745392058237;
        Wed, 23 Apr 2025 00:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0EPZTLlGttK0N2o8iNNcN0hsdGNP9+NvPegWHPoUw3XLmkd9/3/Wm2sbUUOuSp9r9Fx8Cqg==
X-Received: by 2002:a05:600c:1e0a:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-4406abfba46mr151994555e9.20.1745392057893;
        Wed, 23 Apr 2025 00:07:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2c00:d977:12ba:dad2:a87f? (p200300cbc7402c00d97712badad2a87f.dip0.t-ipconnect.de. [2003:cb:c740:2c00:d977:12ba:dad2:a87f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d37332sm14653105e9.30.2025.04.23.00.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 00:07:37 -0700 (PDT)
Message-ID: <b64aea02-cc44-433a-8214-854feda2c06d@redhat.com>
Date: Wed, 23 Apr 2025 09:07:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: Fix crash in smaps_hugetlb_range for non-present
 hugetlb entries
To: Ming Wang <wangming01@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@suse.cz>,
 David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, lixuefeng@loongson.cn,
 Hongchen Zhang <zhanghongchen@loongson.cn>
References: <20250423010359.2030576-1-wangming01@loongson.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250423010359.2030576-1-wangming01@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.25 03:03, Ming Wang wrote:
> When reading /proc/pid/smaps for a process that has mapped a hugetlbfs
> file with MAP_PRIVATE, the kernel might crash inside pfn_swap_entry_to_page.
> This occurs on LoongArch under specific conditions.
> 
> The root cause involves several steps:
> 1. When the hugetlbfs file is mapped (MAP_PRIVATE), the initial PMD
>     (or relevant level) entry is often populated by the kernel during mmap()
>     with a non-present entry pointing to the architecture's invalid_pte_table
>     On the affected LoongArch system, this address was observed to
>     be 0x90000000031e4000.
> 2. The smaps walker (walk_hugetlb_range -> smaps_hugetlb_range) reads
>     this entry.
> 3. The generic is_swap_pte() macro checks `!pte_present() && !pte_none()`.
>     The entry (invalid_pte_table address) is not present. Crucially,
>     the generic pte_none() check (`!(pte_val(pte) & ~_PAGE_GLOBAL)`)
>     returns false because the invalid_pte_table address is non-zero.
>     Therefore, is_swap_pte() incorrectly returns true.
> 4. The code enters the `else if (is_swap_pte(...))` block.
> 5. Inside this block, it checks `is_pfn_swap_entry()`. Due to a bit
>     pattern coincidence in the invalid_pte_table address on LoongArch,
>     the embedded generic `is_migration_entry()` check happens to return
>     true (misinterpreting parts of the address as a migration type).
> 6. This leads to a call to pfn_swap_entry_to_page() with the bogus
>     swap entry derived from the invalid table address.
> 7. pfn_swap_entry_to_page() extracts a meaningless PFN, finds an
>     unrelated struct page, checks its lock status (unlocked), and hits
>     the `BUG_ON(is_migration_entry(entry) && !PageLocked(p))` assertion.
> 
> The original code's intent in the `else if` block seems aimed at handling
> potential migration entries, as indicated by the inner `is_pfn_swap_entry()`
> check. The issue arises because the outer `is_swap_pte()` check incorrectly
> includes the invalid table pointer case on LoongArch.

This has a big loongarch smell to it.

If we end up passing !pte_present() && !pte_none(), then loongarch must 
be fixed to filter out these weird non-present entries.

is_swap_pte() must not succeed on something that is not an actual swap pte.

-- 
Cheers,

David / dhildenb


