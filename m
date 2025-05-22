Return-Path: <linux-fsdevel+bounces-49674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85983AC0BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B991BC73E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E128BA81;
	Thu, 22 May 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDIuJ2G8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB252F41
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918227; cv=none; b=jg931ss7YJbeDsea8xfbNhfhIfonO5aeNKIXdtlXb0NQxbxExyajZHW82Bu/zhmQjadDFPYjOvyFA0mnHJDhCaYSZ8Sn4yiJZgGTO6T51zaEuxuoesbB8dP/jF68Jc+PZsVVdmiXxK3Akaymx1MQ/x7Uvn4+ebTTbygJcVeM9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918227; c=relaxed/simple;
	bh=QpkY9r1mt0Qh6PDkfZqElFxquznfMB6ymlK6B2iiEu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJIFruKXTzFmnOM8XjkEms5jovD8Wi1FqouhmWNtw6S/UfGGGdTyGm8crc5UcH2sPh6S/v3Er6P8QyWmmGSZWHtZJJ+lRYvi/Lrk0JfarZoQh4ifZav/BSGCacMnut8/ofFrp8Iw7U1Y2VTDbBz+nQPD6fe4P2TUlcXCtlWdGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDIuJ2G8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747918225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fx6oiSpfXxbM5W7Ps+W13NostgzfLtcsszzWV/K4XTM=;
	b=KDIuJ2G8cJN2AcfXnyCHNa5oEKoVKfj5qWrbpObAMH4KF0Z1bMxY+IS5l6lq2mdIjCxO1v
	vyxlEkPd7HAwtYsx9Qb/pNR23V51OZ+Y6/bEPcEQHqlgajvUQhYENiK55nl8V1Yv1GK7Zt
	3vgl3boMZFDaEIkStnYNfW0N6dxCwHg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-dBR0RdKZNRCkjTTCx4W8Pw-1; Thu, 22 May 2025 08:50:23 -0400
X-MC-Unique: dBR0RdKZNRCkjTTCx4W8Pw-1
X-Mimecast-MFC-AGG-ID: dBR0RdKZNRCkjTTCx4W8Pw_1747918223
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3561206b3so2848844f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 05:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918222; x=1748523022;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fx6oiSpfXxbM5W7Ps+W13NostgzfLtcsszzWV/K4XTM=;
        b=a8NMDk2LGDqS97QQuKrZq7XafkQI7S/8z6MeULKdgtGW9piYt34F4Dk33dGCDEqVY1
         klA2dgzOQ83s1F8oOfLtqL1qUFaxCTBfFNQFSx4jx8fpCMtA+Tw1jWEgAxWZbGtEL8cn
         /jThoPhQxkTVs7/uBHNNS79uVVvTgOZmaS0TFxqr7OxVjoCkn2yz0OJr8NIwaf8m2qYM
         DEw1nPjGFB5uSBxOqrG2fti9GbiH5CYfKUNdLy4OHz+VC3iWBwUDELPhrWO8+CPdh3+G
         6OvB0+sgoQbt6M2MNFRd78SC0qjO2sWw2rcX8Qr1x7WVKsOq00cHdVWnJCes1WRIgrhJ
         mXUg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1MwHqDx/pvgJqxRSzMRODcMJ3onR2fUXVl6uwDEyjbHAK7c1Zqh3sIqjUMmY7Tju7y57JpfD/Geen5wX@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCzzH1kis5Rq4XuDchBlYdJACA8n1s6e1gRayyP/kmribosM3
	JHXryf+WoTqvcGHaXgqlwhV4czlnTQisF7edXCqCj6JlOnB7aOQpBrbsDpuDj4Y2ekl1M2TxpOK
	e88mCs+vhF3o3lM0kKQxV7xr3PronsCzmycY2BLFndmg7z3L0yIpZyiBQQAkoXneyUAQ=
X-Gm-Gg: ASbGncsJwwy9IPiRBymqJCePn02Gx/JTrDWALHNvLeqkxzaZQayfOs9ad/VOgkwMG27
	6IAmJrduU2wXARhQvY/4kk3S7Zv8q3Ms4THkllXKy0DzdXOueNgTRIQisYD+jfjtMKCZy+JXqQg
	IOpI59JxVsbonXQ5SHYQR9S4aeacG2t+4pUid4ra6XG9oRZLycRuOMv7gEoA3IG0zTMJgH93rPd
	7rtrju87vdepHaOgO17HkcrSpszkYoZROTQNJEyl8wnR/vYItxyyJCmV3lvxemlUMwMB9gwNhjL
	odo6AxvK1ZC5LXpyyo5d2L4cMPEA469lf2+syS63+wvbqhnX/3XIoygZP0ndANBHUUJChmEsigz
	Do6v9ykkuasztixYZ2pg7An6pQfFZrP4ofIkd2CA=
X-Received: by 2002:a05:6000:2282:b0:3a3:7bbc:d940 with SMTP id ffacd0b85a97d-3a37bbcdbe0mr11775967f8f.39.1747918222505;
        Thu, 22 May 2025 05:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+kyGLojq8h/T8VO4XZrWF8YZH8eZH2PYErLG2heEckxcUG749bgICqDS3VcMXObIs6BDDSw==
X-Received: by 2002:a05:6000:2282:b0:3a3:7bbc:d940 with SMTP id ffacd0b85a97d-3a37bbcdbe0mr11775923f8f.39.1747918222139;
        Thu, 22 May 2025 05:50:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:2e00:6e71:238a:de9f:e396? (p200300d82f222e006e71238ade9fe396.dip0.t-ipconnect.de. [2003:d8:2f22:2e00:6e71:238a:de9f:e396])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7bae847sm100971515e9.36.2025.05.22.05.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 05:50:21 -0700 (PDT)
Message-ID: <eab4b461-9717-47df-8d56-c303c3f6012d@redhat.com>
Date: Thu, 22 May 2025 14:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com, hch@lst.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, mcgrof@kernel.org
References: <20250522090243.758943-1-p.raghav@samsung.com>
 <aC8LGDwJXvlDl866@kernel.org>
 <6lhepdol4nlnht7elb7jx7ot5hhckiegyyl6zeap2hmltdwb5t@ywsaklwnakuh>
 <6894a8b1-a1a7-4a35-8193-68df3340f0ad@redhat.com>
 <625s5hffr3iz35uv4hts4sxpprwwuxxpbsmbvasy24cthlsj6x@tg2zqm6v2wqm>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <625s5hffr3iz35uv4hts4sxpprwwuxxpbsmbvasy24cthlsj6x@tg2zqm6v2wqm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.25 14:34, Pankaj Raghav (Samsung) wrote:
> Hi David,
> 
>>>    config ARCH_WANTS_THP_SWAP
>>>           def_bool n
>>> -config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
>>> +config ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
>>>           def_bool n
>>> +config HUGE_ZERO_PAGE_ALWAYS
>>
>> Likely something like
>>
>> PMD_ZERO_PAGE
>>
>> Will be a lot clearer.
> 
> Sounds much better :)

And maybe something like

"STATIC_PMD_ZERO_PAGE"

would be even clearer.

The other one would be the dynamic one.

> 
>>
>>> +       def_bool y> +       depends on HUGETLB_PAGE &&
>> ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
>>
>> I suspect it should then also be independent of HUGETLB_PAGE?
> 
> You are right. So we don't depend on any of these features.
> 
>>
>>> +       help
>>> +         Typically huge_zero_folio, which is a huge page of zeroes, is allocated
>>> +         on demand and deallocated when not in use. This option will always
>>> +         allocate huge_zero_folio for zeroing and it is never deallocated.
>>> +         Not suitable for memory constrained systems.
>>
>> I assume that code then has to live in mm/memory.c ?
> 
> Hmm, then huge_zero_folio should have always been in mm/memory.c to
> begin with?
> 

It's complicated. Only do_huge_pmd_anonymous_page() (and fsdax) really 
uses it, and it may only get mapped into a process under certain 
conditions (related to THP / PMD handling).

> I assume probably this was placed in mm/huge_memory.c because the users
> of this huge_zero_folio has been a part of mm/huge_memory.c?

Yes.

> 
> So IIUC your comment, we should move the huge_zero_page_init() in the
> first patch to mm/memory.c and the existing shrinker code can be a part
> where they already are?

Good question. At least the "static" part can easily be moved over. 
Maybe the dynamic part as well.

Worth trying it out and seeing how it looks :)

-- 
Cheers,

David / dhildenb


