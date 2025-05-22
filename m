Return-Path: <linux-fsdevel+bounces-49671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD920AC0B10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B86A1693FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2028A1EA;
	Thu, 22 May 2025 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPe3DAwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475A2356CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915467; cv=none; b=LTqYnaZksCNsmcEXIWruca94FFOuf+lXKccAb52hmUk1dNgmD7r/J6xsToYsrjlM6QGNLyqmzgD7WKkyKQnq5jybpgb68v/b3J4kB+WWFhKUsVf7FcpCvGecLPp1A1qnTgZ9m76AZmMJyxegm1A0Bh1PrP6v9xnuqAwlMcqLw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915467; c=relaxed/simple;
	bh=4wX/3Pa82sfG0nToWe9Rdgbq4x29T+ZV/w+SFWDYNZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xf/IeRQwz/tITAGVmeyNkkRsazqA3e9M7H/xKfUnAjtUat41eEbGyD3sKyXgk920RWIsPX92SD3aUmSsSKBNzHpItOfNxKbkvV7u3Y+45dyvgOyCOlTwrWNyrbWQXIeetpNf3QnOfJ8JZNUF+y9p5AS7ABYYDsWY8CG2ZttZVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPe3DAwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747915464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SE1l7LwOJdzhSNTpk1qJSyj60i+zwkLVGGrsHxlqMck=;
	b=YPe3DAwigoGffLDS4GiL/TLKBfnhp/Yjde/tMppnZGAMT5XchVwQrYDGNsXjbTvBu5NeWG
	sfOEXXCESEiKyN74G/TrFJPhbjVMrxg0cbwbFEKN79OK8oJtNFqflXr0T7i/1C0ymfUCTx
	13wdN5/yUhvyDBeMbrPJjEsog48Qf/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-sJS_dK6UPxKVzkcpm-luJQ-1; Thu, 22 May 2025 08:04:23 -0400
X-MC-Unique: sJS_dK6UPxKVzkcpm-luJQ-1
X-Mimecast-MFC-AGG-ID: sJS_dK6UPxKVzkcpm-luJQ_1747915462
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so49547175e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 05:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747915462; x=1748520262;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SE1l7LwOJdzhSNTpk1qJSyj60i+zwkLVGGrsHxlqMck=;
        b=Ta1W1ccstOEsOILRO0ySFIVqQjHvQ2wn6b9kbztD1cDA4ifsj+FhyLIFFM6OASuH3u
         F9oL29hYQA4H+rCrxoRLfkSBcz14uyoRxUTcvBJ5xQHjoVy3/fy0YDUH5CUROtnZ8hI0
         s+5OMfsWPyMwjqiMZ4/01FI41lH+WwUpv3ytdYXIqq8l04hy3kQwcrXTbPTgmsN3LMbr
         tBrKMMmreH12o4cNncDGriWuCZabWeY3+/jrb2RAWtrWpHD/dH0pHWJQ2bXEY47yRAXa
         Fxi3mPNuS1TrsTSOntjP9XnRy+xRjCddVqJCZ55AaLt6BnfmHftdK0X2Kt9OFyriInsE
         3dJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi7ow/W73uAbh1bm8JNsSZl/P/MBVLPen/E3PiK/nJXt71QodqGNACwAtH8HCW1UGJybQus6fKBkoMQRYf@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEpdq34skXmCshmWE2cLmKSDpoywPZ+r95KP87v5TuhaOZvYf
	AvYyLLfAalrAt9YmUhwkXFtx6zXV31j3hKZnY4z3UMQkmqvvnpJLKoZ9ESI1IN7PzqHi1sKndsq
	zP/CdjqNLKj85GZ9bLuzAZKvilEXtiWCR7WOOMWs+eJgURR5mABNMIDq34fkcOYD4C+o=
X-Gm-Gg: ASbGnctxB68bVx5YMi8G1CHJ2+icIbGvte3ikV3XfdLWU1oSXFnX2ItokFGUT8VuPmG
	Ynqa1D+Gv0Po7XAelZDWdmzWAXDpuez5eLjR/QYsjKOVN/0D8VcO3ffOJu8Zy8mp9tWzYnLxyMN
	u6Wrd8AnQNtjetcYMuW/KnDvgVsPZpckZiY/sY7c4x59KwWvOlOFDdWMSBzeBF3SOBgZMrkZVIS
	EWLiGhJIpRcHjSu6U25rd4JzAGL1n1MStEhbaAI76PiQlbAqoUUzonHLKgVMqwBmQubPbKnPwKc
	Vlv/2uKqPsBpWA3DqF/9T4lWaYyCVVtrPtNLgHOQW6herTT0eoyBI5oqK0rw++Lw8fQwqQwvoIT
	X4lTxcWbR4Dzd8aivXJa8E+RdmDTwmiMtgzNagzg=
X-Received: by 2002:a05:600c:6748:b0:442:e011:7eb with SMTP id 5b1f17b1804b1-442fd671befmr283747175e9.30.1747915461987;
        Thu, 22 May 2025 05:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBeNOf9p7XQMEo661VsP3lNb83xqKoazNsruCMHoqOB07PdLk122+DzoLdl3opzWhYkLxpDg==
X-Received: by 2002:a05:600c:6748:b0:442:e011:7eb with SMTP id 5b1f17b1804b1-442fd671befmr283746665e9.30.1747915461561;
        Thu, 22 May 2025 05:04:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:2e00:6e71:238a:de9f:e396? (p200300d82f222e006e71238ade9fe396.dip0.t-ipconnect.de. [2003:d8:2f22:2e00:6e71:238a:de9f:e396])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm103717145e9.24.2025.05.22.05.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 05:04:21 -0700 (PDT)
Message-ID: <6894a8b1-a1a7-4a35-8193-68df3340f0ad@redhat.com>
Date: Thu, 22 May 2025 14:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6lhepdol4nlnht7elb7jx7ot5hhckiegyyl6zeap2hmltdwb5t@ywsaklwnakuh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.25 14:00, Pankaj Raghav (Samsung) wrote:
> Hi Mike,
> 
>>> Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
>>> the huge_zero_folio, and it will never be freed. This makes using the
>>> huge_zero_folio without having to pass any mm struct and a call to put_folio
>>> in the destructor.
>>
>> I don't think this config option should be tied to THP. It's perfectly
>> sensible to have a configuration with HUGETLB and without THP.
>>   
> 
> Hmm, that makes sense. You mean something like this (untested):
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2e1527580746..d447a9b9eb7d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -151,8 +151,8 @@ config X86
>          select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP   if X86_64
>          select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP       if X86_64
>          select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
> +       select ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS if X86_64
>          select ARCH_WANTS_THP_SWAP              if X86_64
> -       select ARCH_WANTS_THP_ZERO_PAGE_ALWAYS  if X86_64
>          select ARCH_HAS_PARANOID_L1D_FLUSH
>          select BUILDTIME_TABLE_SORT
>          select CLKEVT_I8253
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a2994e7d55ba..83a5b95a2286 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -823,9 +823,19 @@ config ARCH_WANT_GENERAL_HUGETLB
>   config ARCH_WANTS_THP_SWAP
>          def_bool n
>   
> -config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
> +config ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
>          def_bool n
>   
> +config HUGE_ZERO_PAGE_ALWAYS

Likely something like

PMD_ZERO_PAGE

Will be a lot clearer.

 > +       def_bool y> +       depends on HUGETLB_PAGE && 
ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS

I suspect it should then also be independent of HUGETLB_PAGE?

> +       help
> +         Typically huge_zero_folio, which is a huge page of zeroes, is allocated
> +         on demand and deallocated when not in use. This option will always
> +         allocate huge_zero_folio for zeroing and it is never deallocated.
> +         Not suitable for memory constrained systems.

I assume that code then has to live in mm/memory.c ?


-- 
Cheers,

David / dhildenb


