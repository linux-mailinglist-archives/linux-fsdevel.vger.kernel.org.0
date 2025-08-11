Return-Path: <linux-fsdevel+bounces-57309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449AB205EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB3F17FD41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E605244665;
	Mon, 11 Aug 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9hSuZqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F2239E82
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908993; cv=none; b=IhsLUMMMYRvGqAoLt4yhgEVsx7FhT2x4iK2vrCswS5b29K5oU/SfFfpEB1RBxQEDiLryWZJgfCnEk4Pje3uc/vHVRPemLPIy/rad+RQB+bGGKSqY4qaffVmpdovtqSE4WAypZrkjhyEDXpw5FXBi7r1V9D6WRtlHFOFl+Pm+ees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908993; c=relaxed/simple;
	bh=MdOy/Vxue/t5Cm8NtySn/XHB3otuzfZost+Y82ARVgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW4Uitz3D+II3P8abiJ0+o3tFnMpQjZy0DHx+ca73sWEzsuzxUKk5p+mWDY1K8CHGIlYQ4sMeE8Hw66xIBnuH1KTVtJ06ZiM9Qpub0Ai38E8VwbQACEmZSYaTn9J8q0X+b+R3aXSciEgAz73soHvdvTckigCCDG9TDFBOLTqS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9hSuZqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754908990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u3YjvvbdyzhFmGp/7Kma3wP//jygvfsZwyPlqFhfats=;
	b=T9hSuZqMqZhjnazUrMslebmSOcvBiyS+3ksYOi0F5ZvEHYo+RIC95VykoPsrsxBfGWXJYd
	0eanFZyiTIlDtrPFaUy0ngy7vpSIlgmN1PVOJYLVxSu4oLdYcR+SlV5dTYwVivBq9dleO3
	7FXSxXVR/lHKJ3ee4EaAv6VJcht3sFw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-i2zPNXaSMnyfFh8RO1hCzQ-1; Mon, 11 Aug 2025 06:43:09 -0400
X-MC-Unique: i2zPNXaSMnyfFh8RO1hCzQ-1
X-Mimecast-MFC-AGG-ID: i2zPNXaSMnyfFh8RO1hCzQ_1754908988
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b79629bd88so1804548f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908988; x=1755513788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3YjvvbdyzhFmGp/7Kma3wP//jygvfsZwyPlqFhfats=;
        b=D0gr4/l6FuDmL7wlujoD/ZBMc8g2IKaEItPEm8tEaMXm2KFbbna4930i267UyESwVu
         C2Ezyz1YyQLDNPEKtbLEDs8l8CthWlqowlOHkGmMNvUg75fi9ojv4iFyaBt8aQh2URDb
         +nzZ4dIHW7cWeT2uETWTKzvt5SyvC4Pht44wFSEmT7dkx/Hjs8iCvou6Yb13coauoGVA
         qPNJZEdIqeobhfxlgR3hQUrUnTrEglnyHP5krSNw8fsoO/6T7kd9VjhaKYzUJ7ELPj9z
         o8Q4Vj+7CbP7LOQmHLQg+7xDnxqS7qggrOD28d5Slx5UTta78w1R1bSmBgxHFJFCt2mw
         HBsg==
X-Forwarded-Encrypted: i=1; AJvYcCX2GrcLj28lkNOkJaxCFXCA0ni289PDx+vLsUt0d6JX1vrIENOOP8ugoApl8pUj4wVO8p/j7ht0eWiTTsSk@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUBEvJiCdRQrKBxHsQA7gsc8FAjHmXez9i3WVFz0gHp6i0ooV
	XbrjhULw44DGTv89VPSeGms34T/ML1/fZs5F+HhcasFQjPWVwzGL+1d/GRAR7wxxXAUhlcWWCbT
	K85eUUNTxlYAjcsM/yBLCLY3cWUJGsPzAYwafmeI8eI/QEPJHjegaO46WvpGdi9vo7P8=
X-Gm-Gg: ASbGnctz5gmBeo2XPDy/NPiyt60dBHW3sh57wASxnp4DNKgj3Ay9TV+IOuUYe0Ekk38
	UV/HhEhoVnSd5VebWERuoJexEkKxBBfeWVfOM7xFkq/kKUu2CKyKxxAFNNjS3e3LRGHGbHYCCz7
	JfU4z2sc/lgeVfsmlJ3saY9y6yTrhFM7GrCVhr8tho8H5ji+DhPCxDFrTLopMlIntOv4Db2XFud
	95Z9K5L3m88Rjs7I32qgk/goD6Zh0UcKIgH6tj/+YhofYol0deQspnQWkIg66LW/PtVXbjwcNgf
	Dx0mDKEh2/SPaGcfr4MDWEq1HBxZVvGKDYtXkxiZLv0YHDJD3TCTW8/ipfM8XW4v5RmYqTREB7s
	SnCT9QBbBIZ+Zo/GZCUIZS4KurEum5BC+mirQfuQIbZ+ROTGP30/nSAe/yeZfq5Ag258=
X-Received: by 2002:a05:6000:228a:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3b900b55fe3mr10404671f8f.56.1754908988061;
        Mon, 11 Aug 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZc2pYHJDG26+kHcbxUcn2VM0hxurOtrFpvAMDZsz3M0NPAfAOBWGBM/o0246hxTeJIrYCjQ==
X-Received: by 2002:a05:6000:228a:b0:3a4:eb80:762d with SMTP id ffacd0b85a97d-3b900b55fe3mr10404634f8f.56.1754908987580;
        Mon, 11 Aug 2025 03:43:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm249292745e9.6.2025.08.11.03.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:43:06 -0700 (PDT)
Message-ID: <6afa5cab-2044-46fb-9afb-8be82fe8a39f@redhat.com>
Date: Mon, 11 Aug 2025 12:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
 <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
 <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 12:36, Kiryl Shutsemau wrote:
> On Mon, Aug 11, 2025 at 12:21:23PM +0200, David Hildenbrand wrote:
>> On 11.08.25 12:17, Kiryl Shutsemau wrote:
>>> On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
>>>> On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
>>>>>
>>>>> Well, my worry is that 2M can be a high tax for smaller machines.
>>>>> Compile-time might be cleaner, but it has downsides.
>>>>>
>>>>> It is also not clear if these users actually need physical HZP or virtual
>>>>> is enough. Virtual is cheap.
>>>>
>>>> The kernel config flag (default =N) literally says don't use unless you
>>>> have plenty of memory :)
>>>>
>>>> So this isn't an issue.
>>>
>>> Distros use one-config-fits-all approach. Default N doesn't help
>>> anything.
>>
>> You'd probably want a way to say "use the persistent huge zero folio if you
>> machine has more than X Gigs". That's all reasonable stuff that can be had
>> on top of this series.
> 
> We have 'totalram_pages() < (512 << (20 - PAGE_SHIFT))' check in
> hugepage_init(). It can [be abstracted out and] re-used.

I'll note that e.g., RHEL 10 already has a minimum RAM requirement of 2 
GiB. I think for Fedora it's 1 GiB, with the recommendation of having at 
least 2 GiB.

What might be reasonable is having a kconfig option where one (distro) 
can define the minimum RAM size for the persistent huge zero folio, and 
then checking against totalram_pages() during boot.

But again, I think this is something that goes on top of this series. 
(it might also be interesting to allow for disabling the persistent huge 
zero folio through a cmdline option)

-- 
Cheers,

David / dhildenb


