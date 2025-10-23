Return-Path: <linux-fsdevel+bounces-65300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85AC00A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48C53A3F20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BE92FE047;
	Thu, 23 Oct 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2Q+nLSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B92BFC9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217910; cv=none; b=hZwOH9Qx/bZZFJVhvZVWL6sUv4SV3Twemf960zOvAKOdCd7Gzs+UZfr5DVKJhaxrYN34Z2kQWSTG2xKtuNtGMIABeGCHm54R0BNS188F4sAMGZ4Btu7UJrfDIWfImlT5jEpd1v3ODxHel0rGomzZTtymG85y+xnmlGVHVlgGacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217910; c=relaxed/simple;
	bh=Gj/bVUJkNXQApb9nzb0hnPq0cByWN/WZWtmKfxGFS3g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZ57gqbvDvjP0eS012XS1pqttxLLyjIybnNCeQ81kJ5Vi+0wy3Maht4zrjYYorJV3WTuCl+6m9a4Kh3azn0MKdQ64iouCezpRbLcqDvXzUftkVjA5HBgB/OZryq7mERe1IczFz1vzfB4Vu7wDQJVPF2Ej0g48XZCNA3HA05sR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2Q+nLSG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bhJ9D9puoNFe1MUqX6TKFTSvBgiw0Qt1Ir2FpXvY+U=;
	b=G2Q+nLSGOc4QspVK7twDHAwX31QTeZ3DaNgAG5vWbIC8OEGXa/MzjIuMtBUwaC1Was+A/f
	E+dcATiwmge+HOC/4RT3Aywe4AElivIwcur8cnuM7fUoKXmu5HfWIR62HgEFcbqWIyxheS
	QMiVwKfb0w1DrC+tkRDAOpYYO6TKvpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-1CrnEAPJMXuL7XH3LELnLA-1; Thu, 23 Oct 2025 07:11:46 -0400
X-MC-Unique: 1CrnEAPJMXuL7XH3LELnLA-1
X-Mimecast-MFC-AGG-ID: 1CrnEAPJMXuL7XH3LELnLA_1761217906
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso2964415e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 04:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217905; x=1761822705;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bhJ9D9puoNFe1MUqX6TKFTSvBgiw0Qt1Ir2FpXvY+U=;
        b=j8LCV+t1Gcl9e4RUjGJsH8uNyAjsUjcaus/M1PSyPsnPFYGYpMtiKrV3KLlGiJBTxp
         rl4JUnleyOeAu2OEjqoV8W21caF3eHDqtviX1WGC2qtScr4rzjQhN16S6yhSqR1NXflL
         gHs1TjMce02zWa2Ip/43wWoUrvHmgoBLV6dBUUubKNpiZ2K8S7qjpNCslDZszjCSnIn5
         y0KtHzcjvR3CPbEuhWmSQKCEc/jAGUwgnhY+pbFNSPogXR7K7so9UgBi/VOYlwoFIpJW
         HDBR/DRX3RRLuKgblawIL6uwvkBbsPA+oWgf67QgbMi7LS7WLhJDbqrTmhigpyHAeKP3
         HPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWpmAP6NPyUdP69soAQnY4e1eJGVfLd+NqP4IyvlaK4PCNtUWvcB1181OX5l/N8Yzpqzgk7TaQbUN4CPTwd@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUxSFkqN4Isp9I+DkSQA7cq50UHLmV5fugl48aOC2RwlgnQjt
	LOtKaeGg4nYNGQGXL8ZS9syDD9hUXgNDeh2d2IoT4plY7A+gyRM8XwO0IMyaCTtiZIaBsaybSuP
	Mf1pWOtsyEoZ/vrxwIQ6+1MJlvUB+hLMYNJ3JKvPyC9XZiwHKWYV9AcmVuSRvDSe0on4=
X-Gm-Gg: ASbGncs4JCZPeQoGrU0cNGMRuMqiJJd69Wkv10hV9Q4B/Z/bG7KhxVVfGUk7kCSvQ79
	pE5imJmXRc1QS3SJ1gHxbzeoeErrldte9hFHuMPc796+5wtRq/hfriP+jO/xXkdCIulPP28Gf6L
	pFBkFxk96zgU8WK80hvPXfRLpQPkfPcP2xM6tps7FZSmVMTDrQa8lLrxGMr1SpBG/D32o8AqRIu
	dsaPWUtVWByzIoH802VuKV1Ba5cmFDR9x8ogalmuyp3Y/tjaW60DL46c/c+PexOD7K7160VrR/7
	xF+X6J0SHk4/sJ2VRovfvfAdoSvEgkCT5rS9WXRVi9IT3Kiya23enxMLGfyyCuaDwdFz3Y1ktf6
	ZwezZGuHkm/aPPWmRAwqIiBhpv55CW7837FldEPd9C/O+3vgD9IdvrB7KgdAiQh9kSK9g6IfGsH
	+ex3BYsd/3btUBPpLuzVECsSSJmSY=
X-Received: by 2002:a05:600c:a02:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-475cb064926mr13576535e9.36.1761217905504;
        Thu, 23 Oct 2025 04:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjOTIGLdchiCXBCt7631vjjgeG9GW8BcZLSQPY9hw9ONCdFryCE3QwKhyQwOYvrWIr0Y7WWQ==
X-Received: by 2002:a05:600c:a02:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-475cb064926mr13576225e9.36.1761217905063;
        Thu, 23 Oct 2025 04:11:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm60171795e9.0.2025.10.23.04.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:11:44 -0700 (PDT)
Message-ID: <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>
Date: Thu, 23 Oct 2025 13:11:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
From: David Hildenbrand <david@redhat.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017141536.577466-1-kirill@shutemov.name>
 <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <06333766-fb79-4deb-9b53-5d1230b9d88d@redhat.com>
 <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <56d9f1d9-fc20-4be8-b64a-07beac3c64d0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 13:10, David Hildenbrand wrote:
> On 23.10.25 12:54, David Hildenbrand wrote:
>> On 23.10.25 12:31, Kiryl Shutsemau wrote:
>>> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
>>>> "garbage" as in pointing at something without a direct map, something that's
>>>> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
>>>> undesired read-effects.
>>>
>>> Pedro already points to the problem with missing direct mapping.
>>> _nofault() copy should help with this.
>>
>> Yeah, we do something similar when reading the kcore for that reason.
>>
>>>
>>> Can direct mapping ever be converted to MMIO? It can be converted to DMA
>>> buffer (which is fine), but MMIO? I have not seen it even in virtualized
>>> environments.
>>
>> I recall discussions in the context of PAT and the adjustment of caching
>> attributes of the direct map for MMIO purposes: so I suspect there are
>> ways that can happen, but I am not 100% sure.
>>
>>
>> Thinking about it, in VMs we have the direct map set on balloon inflated
>> pages that should not be touched, not even read, otherwise your
>> hypervisor might get very angry. That case we could likely handle by
>> checking whether the source page actually exists and doesn't have
>> PageOffline() set, before accessing it. A bit nasty.
>>
>> A more obscure cases would probably be reading a page that was poisoned
>> by hardware and is not expected to be used anymore. Could also be
>> checked by checking the page.
>>
>> Essentially all cases where we try to avoid reading ordinary memory
>> already when creating memory dumps that might have a direct map.
>>
>>
>> Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.
> 
> Looking into this, I'd assume the exception handler will take care of it.
> 
> load_unaligned_zeropad() is interesting if there is a direct map but the
> memory should not be touched (especially regarding PageOffline and
> memory errors).
> 
> I read drivers/firmware/efi/unaccepted_memory.c where we there is a
> lengthy discussion about guard pages and how that works for unaccepted
> memory.
> 
> While it works for unaccepted memory, it wouldn't work for other random

Sorry I meant here "while that works for load_unaligned_zeropad()".

-- 
Cheers

David / dhildenb


