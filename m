Return-Path: <linux-fsdevel+bounces-49670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AAAC0B01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B61BA827D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F628A410;
	Thu, 22 May 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dThDvdcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0A23BCFD
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915295; cv=none; b=K/f4bHaFVMJ5o1I/59Ods9N9M4e8cS0PxakphUxYc2hXXYp8Pm8A5KOw14/Z9qAiJ7K2C8s/WIb4GP114mTTrTR4YR7/cPuJ8QPeUbI+6SUT7bNR2DVFQDDN6yhabOZhdXb2WGYYEwV2zRW4wLFp48HlDHGaxSe5u55YoBCcUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915295; c=relaxed/simple;
	bh=3cZkJgLKEdh8Znywjyh4tvd6kpRmgvfQ093vzDrlQiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prb7V3LvCLSS16gsD/gz+sN5BZ5ns1/GTza3HyvHr0B+VErHLXwqwNr7IxjmY+agq5q5AyMBeuczThpqzZCaH5jX/G7d3njMiqqFzmt2BFNNaMaO7Xxl2x2O6CMpPMkb95TkNqJ9lv8J8mkyBygkel9FDYg+2Tks/BA5d8Xo3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dThDvdcu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747915292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iNKHItieFldlVHFOlaztfdsZmomMboRlw+z49HMe4ok=;
	b=dThDvdcuBB3/HdkPufQ5SH+tTPYtTwio2yCyJUJCeUGgIwskSAmw2YKuCZdVPSzaE1MfMy
	mvHqZKRShr3FMUJM4HeIah3atqEVvISKejRZuPuQp0pcdP8qUOK3+dDTXCyjRa645ds2oT
	hYZWnYfaCknZ2/SRkKgsBs5+VboL5tQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-eTmJ2Q-RMsC9gdw0PramJw-1; Thu, 22 May 2025 08:01:31 -0400
X-MC-Unique: eTmJ2Q-RMsC9gdw0PramJw-1
X-Mimecast-MFC-AGG-ID: eTmJ2Q-RMsC9gdw0PramJw_1747915290
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so58957725e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 05:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747915290; x=1748520090;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iNKHItieFldlVHFOlaztfdsZmomMboRlw+z49HMe4ok=;
        b=gZfIkO3inzErzjCeX1lttR2FAT0hIR1cdgARD4O4pwPHkd33nxFtKIeu0eHoDvJVEZ
         KGSbJQXXYsggZp26Bc0xRQDMMRGI9ZVetZnn5l1Wvgvg1TTHb8v2D5RugOYGfZnfb+7h
         YcycQZJ1TbFSHgCmCZmNwyM8CApDR5EMKUTFK9yEyyLAOpWG/sW76eIo1PqBD6tSlV1P
         bWs18Slu2rzzyAiFBYIKtrPAY7ASL6tzq35Tss9zWvr4AHuiV6/oE8SWOA5XiMibrZlU
         sbj82J6U0LIwX2swMcm2psvAGepGrOn38h3opZZxWesaNq9NTwSoLC0PuBg60bt5wr9o
         h70Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB0nh3dJAMZuBwY5USIkdlxaf/7APAqxcjK6xaqgHk1E4Eapxkip7UJEJ9LDSyiZYHGVEiV4povFg1GMYZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbUdDaRrXeUVyDI6NouXTUPxgU51U27Pec+G/hOvckTDQkZ86
	McI86IZIHgb71zGx75WAXfArwsCUlvxqJxgbZwy9qyrfn5orN/7rUv9oqdkweXmQcz/t5iV/WIc
	gHx47RYKe28sPGtyt9RrkU1i8bePBfBdCzQOem/L7wKOM282WUKWAFDh9CTfsEe/GCmI=
X-Gm-Gg: ASbGncsStAAFvpg5k5IPq7jDfzpQ2dDqjuwfDQPFd6WxP2CqDiP8TNWWyZaR1yQsop/
	PjGlZyi5JxPrFOHExrj7LXOQwezOvwe2vKs9aykDHs+Dt7t+Cio9S3tVvpsg2JzTergGiwd3NaH
	d1Foj6Yqj2/fhj7lVtvrjcV2tv/VUUDMcMFNcZJhst5YNCGyYKf+DGIPvUvfQv40j07dHoRAKh5
	DnWGfNQbUVqqSyCcTFfVa5a47V6h2h4XIZsZ89qFigJr5iofCC5Gh4x3RIqyE3f70whhC5OTyoN
	MHORHiS9yyHL3AM+scWW2BSImuHC3lh2VbS08DnFAQ==
X-Received: by 2002:a05:6000:1862:b0:3a1:f69f:3341 with SMTP id ffacd0b85a97d-3a35fe929c0mr20912548f8f.26.1747915289974;
        Thu, 22 May 2025 05:01:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErMUayE2jYtY0hACROYIHryKUvps/DNFcId2ztdIhvw5IaHZ+RDOk4bPfWfqVqksX/ZTFcKA==
X-Received: by 2002:a05:6000:1862:b0:3a1:f69f:3341 with SMTP id ffacd0b85a97d-3a35fe929c0mr20912491f8f.26.1747915289482;
        Thu, 22 May 2025 05:01:29 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f532.dip0.t-ipconnect.de. [79.224.245.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d230sm22458617f8f.4.2025.05.22.05.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 05:01:28 -0700 (PDT)
Message-ID: <bb57ac40-5579-455f-be79-f0e373d5569d@redhat.com>
Date: Thu, 22 May 2025 14:01:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
To: Mike Rapoport <rppt@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
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
 "Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com,
 kernel@pankajraghav.com, hch@lst.de, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, mcgrof@kernel.org
References: <20250522090243.758943-1-p.raghav@samsung.com>
 <aC8LGDwJXvlDl866@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aC8LGDwJXvlDl866@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.25 13:31, Mike Rapoport wrote:
> Hi Pankaj,
> 
> On Thu, May 22, 2025 at 11:02:41AM +0200, Pankaj Raghav wrote:
>> There are many places in the kernel where we need to zeroout larger
>> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
>> is limited by PAGE_SIZE.
>>
>> This concern was raised during the review of adding Large Block Size support
>> to XFS[1][2].
>>
>> This is especially annoying in block devices and filesystems where we
>> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
>> bvec support in block layer, it is much more efficient to send out
>> larger zero pages as a part of a single bvec.
>>
>> Some examples of places in the kernel where this could be useful:
>> - blkdev_issue_zero_pages()
>> - iomap_dio_zero()
>> - vmalloc.c:zero_iter()
>> - rxperf_process_call()
>> - fscrypt_zeroout_range_inline_crypt()
>> - bch2_checksum_update()
>> ...
>>
>> We already have huge_zero_folio that is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left.
>>
>> But to use huge_zero_folio, we need to pass a mm struct and the
>> put_folio needs to be called in the destructor. This makes sense for
>> systems that have memory constraints but for bigger servers, it does not
>> matter if the PMD size is reasonable (like x86).
>>
>> Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
>> the huge_zero_folio, and it will never be freed. This makes using the
>> huge_zero_folio without having to pass any mm struct and a call to put_folio
>> in the destructor.
> 
> I don't think this config option should be tied to THP. It's perfectly
> sensible to have a configuration with HUGETLB and without THP.

Such configs are getting rarer ...

I assume we would then simply reuse that page from THP code if available?

-- 
Cheers,

David / dhildenb


