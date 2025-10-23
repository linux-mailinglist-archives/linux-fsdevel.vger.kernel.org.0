Return-Path: <linux-fsdevel+bounces-65305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8CC00E76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4553A1FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5B30E82E;
	Thu, 23 Oct 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHotVQQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F36301703
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220170; cv=none; b=Fr9+eHJmXMTcAP3vV5AmwtkMXMgqoyu0xuDYUZ9Ba4AgX44iWjU2IWmXTkjf8ZP9+uhC/r0Tu19K/4hDNo/oLllXnvoZCGBoVUgsWY4/a7TkGIcqJcC90ylhiCq6AZpmJKne3oI9h9um3Uh2iI+xkr5xQgd/9ilxuG77Rm/kQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220170; c=relaxed/simple;
	bh=ggm7K33F2Lvf8aetxoMCpPifvf34MtktdbfMQDbo63U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfMglM+GkiYBgsGOMuaf4X+udGdOYisQHzJLn598zTKx9Y5jgZEg1wLh7AKPZzfiYhODsT79NybGLQVkEq29XY4oODqZfybrHkQ0RXxjqB+kjKSiYV6cowCI5/zJ0cBoSkp/lePUeGe2f5hjKVLXXwHK8wq0oR8KGaAoPCTT64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHotVQQM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761220167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JCBxlSGX2oKy9c5VZTiKe/QSwX2dngLFxql68g6Ybmk=;
	b=fHotVQQM3lGcyz8M1P9QqiHgv2+eM2eIUXqpFIWnZe9EfdEUGo68fytjUCFzHGqwzHDP0M
	OMZYZKrwQge3uwqieZwFnG/LM7lgUK85TY1Oz1i3SXzZ2mRy/J9oefs9wwYHQ+73Y8Guzm
	yNjPAeAq6XDqs2a6ALrbNMdwxqfZ5rc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-M-Vnsc-lMHq1vuX-WFqrPA-1; Thu, 23 Oct 2025 07:49:25 -0400
X-MC-Unique: M-Vnsc-lMHq1vuX-WFqrPA-1
X-Mimecast-MFC-AGG-ID: M-Vnsc-lMHq1vuX-WFqrPA_1761220164
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429893e2905so522273f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 04:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220164; x=1761824964;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCBxlSGX2oKy9c5VZTiKe/QSwX2dngLFxql68g6Ybmk=;
        b=nAQQEa1PexlG1nL08GxK0IjkLJrqV8xazw7WX91gj9tdrq6dw8jXAp3C1i4k9O4e1l
         pMxU6HYowUqqW1wGIwKqOI9bkmsquDqDr6dM5CmRCqGq15DHSGqIXx3L7JxeDgPzvOWQ
         FTZbECcWlMeD9mZWBU92B3CmFDiEdtl7NNGuLIcndhuYEYu+9vySq50/kUs+gwsJQ8tX
         sm3178J8Ibg2TbsqJ8vX9eW0xrCN+fHlmoRQetV4vJy1Rv0m+fGUz0/iljzBzpRd4PyE
         LXWIyq3bv8rAas71g3wBBBMvh2Gt0cmYd6XtrGZm8mdz/f4ybax/N437Xp8UB1NzH7Jx
         HHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMLSfTTM/+eYGzXDLLaPheKbDsGjDAhG1h2fmBDr3hBihalygSvyrQzyYi51LM3Z9MI0d9bIGkMh6PwJNy@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwQ1K62iQ9ywGcN7hqMCjrW9j64rWUrdYxI3KblcfNBUeoJdb
	5UprtjSuq1KNFk+EmLWPtN3xd4axZ6S0yHKhgHoICjuFN1jsS3haeIE4t2fJsMVakdUw45UimeM
	7monhX5ui42/Fh/mGtsDStTbptsNzPlKXh6/h6MAvkQ2JRqtiBemy0xnUqxSCv/U8e5g=
X-Gm-Gg: ASbGncu0BbwgEPQTelK0ofiQYKLvy/jL9Z5KYrmWTIB+h2O7jXCG570qrlsEOiKD2iQ
	M5OxaW82jCbzZ98Cnr1ud9324m7nfVcHFbNx3QWiBHASay4a8Gn7AN8oIM6DPs25l97qxgPeC7y
	GOevgk2NRV/giySoGja9tlMJvf477eW6wKwIuIR+P5YVNYlpkA5HZuU7G5uBnrsbq+v9y66baeN
	+14nP7z3JoQXvUgbbkXaJdoHb6Wkvk2wmhVGgy/ya9XWl2eLsXlyiwU7R72V+JyLivP7U5+6BnH
	O2CDUP7G2b5fXg5QqLcrYdd+6uTfoOiNg1vUdvdZJxk0TFT8243PFck2uICTkYu7gmcwgGoadQH
	m8a6vYGjCtGlT45RYNp3f8OOxjDdhN3vts7AwZiPdQ+dGZASTxjDhuk84vr98hmqiGQnCRR8tM/
	je2X9rP+P7NbkB3jtwkxjH02BCCZo=
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id ffacd0b85a97d-42704da9e16mr15577038f8f.36.1761220164343;
        Thu, 23 Oct 2025 04:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJfOXZJEHV2NsbUj6aOO2PBD6VL5w9K1QsDgEyX5FiTcCiFyrw8Szd74pXh3vMEb+fyU8utQ==
X-Received: by 2002:a05:6000:470a:b0:427:491:e77d with SMTP id ffacd0b85a97d-42704da9e16mr15577028f8f.36.1761220163874;
        Thu, 23 Oct 2025 04:49:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm3522878f8f.27.2025.10.23.04.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:49:23 -0700 (PDT)
Message-ID: <f57d73e3-fb6c-4c01-9897-c9686889fec2@redhat.com>
Date: Thu, 23 Oct 2025 13:49:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
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
 <5b33b587-ffd1-4a25-95e5-5f803a935a57@redhat.com>
 <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7fmiqrcyiccff5okrs7sdz3i63mp376f2r76e4r5c2miluwk76@567sm46qop5h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.25 13:40, Kiryl Shutsemau wrote:
> On Thu, Oct 23, 2025 at 01:11:43PM +0200, David Hildenbrand wrote:
>> On 23.10.25 13:10, David Hildenbrand wrote:
>>> On 23.10.25 12:54, David Hildenbrand wrote:
>>>> On 23.10.25 12:31, Kiryl Shutsemau wrote:
>>>>> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
>>>>>> "garbage" as in pointing at something without a direct map, something that's
>>>>>> protected differently (MTE? weird CoCo protection?) or even worse MMIO with
>>>>>> undesired read-effects.
>>>>>
>>>>> Pedro already points to the problem with missing direct mapping.
>>>>> _nofault() copy should help with this.
>>>>
>>>> Yeah, we do something similar when reading the kcore for that reason.
>>>>
>>>>>
>>>>> Can direct mapping ever be converted to MMIO? It can be converted to DMA
>>>>> buffer (which is fine), but MMIO? I have not seen it even in virtualized
>>>>> environments.
>>>>
>>>> I recall discussions in the context of PAT and the adjustment of caching
>>>> attributes of the direct map for MMIO purposes: so I suspect there are
>>>> ways that can happen, but I am not 100% sure.
>>>>
>>>>
>>>> Thinking about it, in VMs we have the direct map set on balloon inflated
>>>> pages that should not be touched, not even read, otherwise your
>>>> hypervisor might get very angry. That case we could likely handle by
>>>> checking whether the source page actually exists and doesn't have
>>>> PageOffline() set, before accessing it. A bit nasty.
>>>>
>>>> A more obscure cases would probably be reading a page that was poisoned
>>>> by hardware and is not expected to be used anymore. Could also be
>>>> checked by checking the page.
>>>>
>>>> Essentially all cases where we try to avoid reading ordinary memory
>>>> already when creating memory dumps that might have a direct map.
>>>>
>>>>
>>>> Regarding MTE and load_unaligned_zeropad(): I don't know unfortunately.
>>>
>>> Looking into this, I'd assume the exception handler will take care of it.
>>>
>>> load_unaligned_zeropad() is interesting if there is a direct map but the
>>> memory should not be touched (especially regarding PageOffline and
>>> memory errors).
>>>
>>> I read drivers/firmware/efi/unaccepted_memory.c where we there is a
>>> lengthy discussion about guard pages and how that works for unaccepted
>>> memory.
>>>
>>> While it works for unaccepted memory, it wouldn't work for other random
>>
>> Sorry I meant here "while that works for load_unaligned_zeropad()".
> 
> Do we have other random reads?
> 
> For unaccepted memory, we care about touching memory that was never
> allocated because accepting memory is one way road.

Right, but I suspect if you get a random read (as the unaccepted memory 
doc states) you'd be in trouble as well.

The "nice" thing about unaccepted memory is that it's a one way road 
indeed, and at some point the system will not have unaccepted memory 
anymore.

> 
> I only know about load_unaligned_zeropad() that does reads like this. Do
> you know others?

No, I am not aware of others. Most code that could read random memory 
(kcore, vmcore) was fixed to exclude pages we know are unsafe to touch.

Code where might speculatively access the "struct page" after it might 
already have been freed (speculative pagecache lookups, GUP-fast) will 
just back off and never read page content.

We avoid such random memory reads as best we can, as it's just a pain to 
deal with (like load_unaligned_zeropad(), which i would just wish we 
could get rid of now that it's present again in my memory. :( ).

-- 
Cheers

David / dhildenb


