Return-Path: <linux-fsdevel+bounces-49457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE913ABC7D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ECE18842C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95B2116FE;
	Mon, 19 May 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpqzgYJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC020E328
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682952; cv=none; b=KIPz8T7elcSRr2DYXgABL+D40YTL3hk2Xat5c/KnDlzYfH5f7Q7ySkEG2u7inUIQX0SUJRtfjyJMEOg7oV4TlDzFZmUeCHdbswIfVft6JOtu3UcuWGPl4Moa/q+ou6MnJXz79skyArwGcdlOnOFhrBDYlceeDYBwQ3wxVOyrsY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682952; c=relaxed/simple;
	bh=xBK45x3TEPNypTTHawIHs2KLj1Ypp9sh1kxLAgDZEtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEvnKFGGwj8PIrvIgdKKyUlLbpvYNfLgenS7Hi08QbQtEu3uUHENTYIbsQ551HzDgylnC5b0SahbpNxWRIB46leP0q6TPRMtOOVNwV3h1C2lfVHACIqfjdMnD8ZXLiieqSKaE/ga4PeFU701U13pU7QlOE5687ZPgsVHt9Gq70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpqzgYJ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747682949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n/A5udE0xFsUfjluCthGJRT0KVJ/nbPqupKt9mvOjwI=;
	b=EpqzgYJ4fSJ7Qjjj0hupcsTEaUV7e2TZxWHQYOHq1SUnIyoTGtOQnfO2l3VWDjCe12v4p/
	DebWeIPUVBJLyE0I6NXdvAcBaNy7zt7vNPNw2Fk1h/i/eZcFuJXrKcEO21bW/cCRsB+wXu
	9rc1ntsS/GLZipMAUS1GceaMciikkEQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-D2Xd8CsePBqi6awN2d53HA-1; Mon, 19 May 2025 15:29:08 -0400
X-MC-Unique: D2Xd8CsePBqi6awN2d53HA-1
X-Mimecast-MFC-AGG-ID: D2Xd8CsePBqi6awN2d53HA_1747682947
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so27948475e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 12:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747682947; x=1748287747;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/A5udE0xFsUfjluCthGJRT0KVJ/nbPqupKt9mvOjwI=;
        b=MU5eNbK64NbJTeNlO7AQv2AcDLRoPFsXl/D4T2bk2Gl/R/v4sYQSwf98XNEwSrHUca
         RH4cMCXEIHMg9MDuBKh1ZQd1RlfrQ0LMYwMftf2JIDMyNyZK5JPnz0lAPc7dsnqOuxkZ
         oNz5zO0gfDJmMZ5HuwmkLIMdQDy7TDRBjlLOvCXABq2jQoDBAAyqGO++UdEDDH2mt+R8
         PHxSzejJNqXfexJ65amLuaj3gn7IZufzuwF48ctwauKojva85Q/zCFgVaYZA57P8ymHp
         PEdUA78uayZKifNk3nHwCZShVeihH4kyk95/hVQdPKn76te2otq0O90KjQdhgGp4FtS9
         Ws9A==
X-Forwarded-Encrypted: i=1; AJvYcCWKKia2ybjLLehpwOjLBk0ar346wDaYpct6HqTibLqn0RrSU7Wt0LiHciXHsLqbtvBoz7kl3ZGzw+A5sSWV@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGhMAFGr3sHUt7Rp9J8TxQJiYIxB2T9G0NmlmsKDt0HhXsCqk
	q+F209XD/NUIP18x9/8SC28YzXl7erB0+CGeM29PeR76k/zey67kKbFBnJiBaCDkltbTmiHrJbY
	UsZNkjWnUTEw02+y9VypfKVfcdkCgSlQEPbFl/sPbQ6EMRLU3UD5X3NaoA75K2VTW3rs=
X-Gm-Gg: ASbGncuSzEAItF6EkdtKJv4Hy0/VRf+rkzsbSDNxqMhTOuv19A/D73qCjfWS56rEawf
	tGBRHegCefx52iVjp5/OBpbBTMI/V09taZYmLBcKQ/u4HzaHebfnbrno2Wl3sauJ7BOKnH3NxlC
	0NXZRtbLcSLpzrvQUSfUJHkra1ha+n++EGc9eKRdNR1FeHdht/MWwpyGczIdTWh3iow2SoywchX
	Dndfr/yfgn3KUsmurs1DY00Tse8TF+v7AiccQrOyFc7dgcy2ZsuK7WRsZsI2nsR6MiL4ezMmrLu
	b+YdqbYGTwhTBWOCEO3GqhaIfP7eQ6SAaDdwcKSDLoRcR8ZirQwUqP47inImr61um8j4gE1cLko
	+1tzKYW+cSf5/c7wLPIRSAcx3+olarO6ArkYA3tU=
X-Received: by 2002:a05:600c:3e0a:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-442fd5a2c09mr163645425e9.0.1747682947188;
        Mon, 19 May 2025 12:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElwndSxsvYGiPSfmwEdluQQgF5em0NgqI0FO0EfTofaeJHmVDskBJCeT6akaFpuN6ZVrpCIA==
X-Received: by 2002:a05:600c:3e0a:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-442fd5a2c09mr163645205e9.0.1747682946811;
        Mon, 19 May 2025 12:29:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7d975cfsm730805e9.38.2025.05.19.12.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 12:29:06 -0700 (PDT)
Message-ID: <0ba29e21-22f1-446f-a9fd-863c99904ce2@redhat.com>
Date: Mon, 19 May 2025 21:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
 <3e2d3bbb-8610-41d3-9aee-5a7bba3f2ce8@redhat.com>
 <d8e20b76-1eed-459f-8860-a902d46bc444@lucifer.local>
 <e5085602-e97a-4b30-b640-e1e4f2e77cf1@redhat.com>
 <36ea1ee7-bb6c-47ff-a6cf-18f43fb23493@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <36ea1ee7-bb6c-47ff-a6cf-18f43fb23493@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 21:26, Lorenzo Stoakes wrote:
> On Mon, May 19, 2025 at 09:11:10PM +0200, David Hildenbrand wrote:
>> On 19.05.25 21:02, Lorenzo Stoakes wrote:
>>> On Mon, May 19, 2025 at 08:04:22PM +0200, David Hildenbrand wrote:
>>>>
>>>>>> +/*
>>>>>> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
>>>>>> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
>>>>>> + *
>>>>>> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
>>>>>> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
>>>>>> + *
>>>>>> + * If this is not the case, then we set the flag after considering mergeability,
>>>>>> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
>>>>>> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
>>>>>> + * preventing any merge.
>>>>>
>>>>> Hmmm, so an ordinary MAP_PRIVATE of any file (executable etc.) will get
>>>>> VM_MERGEABLE set but not be able to merge?
>>>>>
>>>>> Probably these are not often expected to be merged ...
>>>>>
>>>>> Preventing merging should really only happen because of VMA flags that
>>>>> are getting set: VM_PFNMAP, VM_MIXEDMAP, VM_DONTEXPAND, VM_IO.
>>>>>
>>>>>
>>>>> I am not 100% sure why we bail out on special mappings: all we have to
>>>>> do is reliably identify anon pages, and we should be able to do that.
>>>>>
>>>>> GUP does currently refuses any VM_PFNMAP | VM_IO, and KSM uses GUP,
>>>>> which might need a tweak then (maybe the solution could be to ... not
>>>>> use GUP but a folio_walk).
>>>>
>>>> Oh, someone called "David" already did that. Nice :)
>>>>
>>>> So we *should* be able to drop
>>>>
>>>> * VM_PFNMAP: we correctly identify CoWed pages
>>>> * VM_MIXEDMAP: we correctly identify CoWed pages
>>>> * VM_IO: should not affect CoWed pages
>>>> * VM_DONTEXPAND: no idea why that should even matter here
>>>
>>> I objected in the other thread but now realise I forgot we're talking about
>>> MAP_PRIVATE... So we can do the CoW etc. Right.
>>>
>>> Then we just need to be able to copy the thing on CoW... but what about
>>> write-through etc. cache settings? I suppose we don't care once CoW'd...
>>
>> Yes. It's ordinary kernel-managed memory.
> 
> Yeah, it's the CoW'd bit right? So it's fine.
> 
>>
>>>
>>> But is this common enough of a use case to be worth the hassle of checking this
>>> is all ok?
>>
>> The reason I bring it up is because
>>
>> 1) Just because some drivers do weird mmap() things, we cannot merge any
>> MAP_PRIVATE file mappings (except shmem ;) and mmap_prepare).
>>
>> 2) The whole "early_ksm" checks/handling would go away, making this patch
>> significantly simpler :)
> 
> OK you're starting to convince me...
> 
> Maybe this isn't such a big deal if the KSM code handles it already anwyay.
> 
> If you're sure GUP isn't relying on this... it could be an additional patch
> like:
> 
> 'remove VM_SPECIAL limitation, KSM can already handle this'
> 
> And probably we _should_ let any insane driver blow up if they change stupid
> things they must not change.

That is exactly my thinking.

But I'm also fine with doing that later, if you want to be careful.

-- 
Cheers,

David / dhildenb


