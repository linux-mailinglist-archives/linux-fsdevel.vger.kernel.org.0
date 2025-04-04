Return-Path: <linux-fsdevel+bounces-45713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A267A7B6CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88FF178E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 04:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFC149E00;
	Fri,  4 Apr 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FRo7Yr8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144012E62B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740142; cv=none; b=DZS32NCNQ+46w/BgKf+DFPtz48YTqS+apLFgwMOPfcJjRFFS0qJi3eQZMYd+jLhV7BFx5XnFJom7ooeLM8jgawwK3Ud1kRrM2A4SVa4yfNn5pAljklz6MR4CNeE9yXC1S6vmgTsG/8Elx4tm0j5UchbEyQwk/cKboCGaSk2fOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740142; c=relaxed/simple;
	bh=rem28ueMjIYFo/KFIOhnA7Jg70Bn1mUvrfoP48UTum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHJFpp+RoqYclHu8+/lalb1BXc1cOgw4FJQAHIKrtyCnbEfGgWk232Nmd0ucw+R/yqudZLFH0KgE37zSJnXCE1Aob555dCqjuB6jH///NqXnUbwCc1Lvgun9F1waYiatYz+vHTFmMVUygzk06u29M0eyzNoTAWWrWbHQPS8CJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FRo7Yr8n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1683002f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 21:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743740138; x=1744344938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3n5AiVvOUUkMjG/cgjmZt7WKb4qY8zTDshKKmJlFos=;
        b=FRo7Yr8nbc3j1JnFBgGYZBM7AsnIbcZO7BR/k4Mj00seclxt991O0344ifkvglPPIM
         zjUIEpQM7enqEXJTG4hSVZpB6igbYrFAZrgpJHd4pcE0VzqDJXPQ51dHgHMWzh9KazOa
         3Gg1JCrVZ91fpTYdq//huKJ/kazfh6LDU+KPhChb0c8NvChrIxw3o3p3qZzAbI+B1tg3
         Dh9KxDrp99MgWk1LTYOpZEjlTzOTqP4dx7msDvvc9gXbQaOz2HJfDIo/VB0oA+mjoxKA
         666bcpRc2sDI1P/VjriWLEEX10BoYBa32EPSRT3csrx42jGacnuNi/5t4a22Pe+haV/9
         1tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743740138; x=1744344938;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3n5AiVvOUUkMjG/cgjmZt7WKb4qY8zTDshKKmJlFos=;
        b=Coad5taucHDUP+A9SEh2ag4t4gsL/R4mRYsL8ZxXphB4yqsn0uawwzH1YpgMMRFw25
         KZZyuIs7ylyFBt9r10cWqO89O/a3ZUF5Uz8sHcdxRSX+WUH36CJbqqFtAUBic8W11mOK
         qRhk2Q9N+tlShBEzPi3mSbyweJswxY8MFtVXDQR6SsCMGva0hShHEmarq9H8AZgAkF33
         qNZ1e5NuzvnDWM+jO98GCYBCSYhK9hYLpnPiQReeoWqu7FyAVYITM3KzBR6lpVYzUu/n
         T10+GVP21TmZHq3BRvbfyfRGmIa7FlVwgJ8zrnW84PrKz3ygqFJD+RLbWjL/oMAf0BEt
         83IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxklHS7uyw9uM+7sp+41pm5sSSgJK4bhduHQif5QhAS+SvltJhqrR0MLf8VFZl31aZk9wG3V2MOlFTRl78@vger.kernel.org
X-Gm-Message-State: AOJu0YwYT6bX2tuzUBMPv4RzcMbBzIYnw1TtCMx+6ArtbIf5y3mIQRcJ
	R+kgZumTpSYLAs4ULjvIFFBENHxGPuk99z+OWLYd4U/UHn7ynGyZakSaaSdqnp8=
X-Gm-Gg: ASbGncvLqmOJislKpPNrOh7n+UADNE5/Y3YVpiEwxG8/CzFjFghV5RP/+3PfdMTiFxD
	KK1K6kITjlhcNYV1OnUF98h6I4GqHW+A3QVFfe/libesdxnJThcpKi/y562MXSqrwX0heQ/UbDX
	3r5wYeVQPcfR4hKnjrLxDqyQwshGqD4xOqT7t6Wml2EiCmhnmpz8pLCALECvtSL3EnG9QzUmrgL
	llrvgaFb8eChSQFB4NB8y53ckD6/wh7bovr3wFt4jSeGFKkPahJ+2cf39a6ml9sPZvaIcaDeSMS
	8a0eFraNqMcQCT4LfyAJvM2lbZJYxu6ftcIuFUmVeHt2qSeB4V9de2FEzusykRnhs1N3o5i7
X-Google-Smtp-Source: AGHT+IE7U2iAkNipH9A2jU55/5LO2X+FYLeN7GAyPLKHn9jLmMXYLc9cXnz/fYJ/8UlGlZyVhJnl/g==
X-Received: by 2002:a05:6000:2211:b0:391:952:c74a with SMTP id ffacd0b85a97d-39c2e610f88mr5174550f8f.8.1743740138059;
        Thu, 03 Apr 2025 21:15:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978662508sm22702955ad.139.2025.04.03.21.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 21:15:37 -0700 (PDT)
Message-ID: <c4d317ed-859c-4ee0-bdbe-e92f4cd7fb95@suse.com>
Date: Fri, 4 Apr 2025 14:45:32 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Large folios and filemap_get_folios_contig()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, vivek.kasireddy@intel.com,
 Andrew Morton <akpm@linux-foundation.org>
References: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>
 <Z-6ApNtjw9yvAGc4@casper.infradead.org>
 <59539c02-d353-4811-bcbe-080b408f445e@suse.com> <Z-8s1-kiIDkzgRbc@fedora>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <Z-8s1-kiIDkzgRbc@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 11:20, Vishal Moola (Oracle) 写道:
> On Fri, Apr 04, 2025 at 07:46:59AM +1030, Qu Wenruo wrote:
>>
[...]
>>>> Then I looked into the caller of filemap_get_folios_contig() inside
>>>> mm/gup, and it indeed does the correct skip.
>>>
>>> ... that code looks wrong to me.
>>
>> It looks like it's xas_find() is doing the correct skip by calling
>> xas_next_offset() -> xas_move_index() to skip the next one.
>>
>> But the filemap_get_folios_contig() only calls xas_next() by increasing the
>> index, not really skip to the next folio.
>>
>> Although I can be totally wrong as I'm not familiar with the xarray
>> internals at all.
> 
> Thanks for bringing this to my attention, it looks like this is due to a
> mistake during my folio conversion for this function. The xas_next()
> call tries to go to the next index, but if that index is part of a
> multi-index entry things get awkward if we don't manually account for the
> index shift of a large folio (which I missed).
> 
> Can you please try out this attached patch and see if it gets rid of
> the duplicate problem?

My reproducer no longer hang and the trace events indeed shows only one 
folio returned.

Thanks for the quick fix,
Qu

> 
>> However I totally agree the duplicated behavior (and the extra handling of
>> duplicated entries) looks very wrong.
>>
>> Thanks,
>> Qu


