Return-Path: <linux-fsdevel+bounces-15131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B48874A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257EB280F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559E80C0C;
	Fri, 22 Mar 2024 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqXTrMwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7D7F7FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144577; cv=none; b=uwgVI126Rz5TycTMVYMxBxDM7WMK+bVHM7x6XIbaFnquGPam3ysxAWbUYwyqXQSClrgyGRtm0UiHwMwxClrwCNVsX/3xrIckKbgElMQKi166OyldBz5B2hzPi1l5Kj3riAIkfvBwJzluXASjSu8X1h/Owy6u2+04QAJ8fSZFVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144577; c=relaxed/simple;
	bh=mqI5C2sstfl9phrjs83gokfY9/p+7iYAYoYf3S8etno=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pnZSTAxiH+TPNyk5BORRZPz09IcYL8V3MIylREZ2jaHjpIfv2ZrALE4QeYxVuWolhdruOu+opMjvHIuq/ZdTQuALa2GA6dm6sTMN0n8CcH/BSS1o6bzIVd+q152aTuHwKyHICpxcMCm6vtGSO4gPPdec00DIjsv0w2M9m5KVp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqXTrMwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711144574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ilDRSs0Ait/XlZwDgiIlSIqrzhhZAq2BofMKP07LLMA=;
	b=GqXTrMwMhif35sGRcQMpGk11xZmCMrSTIz9HLMZ3Eor3k+imtsdgP1Oe7ZVWxb3LxMs7uo
	QQBsy/0IRKEshSXVKraiV6oKlmgjRE2c5MT3Sd7fPkfNnsjRfFoYskCMkzj9QfS+dH9Sfo
	HGbCVPfl+v0cL2d6g6Iu7GzYD4uF1U0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-sVOkumHZPqG33JlqCKbbLg-1; Fri, 22 Mar 2024 17:56:11 -0400
X-MC-Unique: sVOkumHZPqG33JlqCKbbLg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4147f17da12so2007355e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144570; x=1711749370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ilDRSs0Ait/XlZwDgiIlSIqrzhhZAq2BofMKP07LLMA=;
        b=v7LzBHWT8RqNzK5kaa8aL+Ol+4acex9koHf5yXUxq5yZmW56o0w9BpJUqxhAp1BV9H
         8UBcMCVUVEd034vCjKUo/xp+gf6BcMYrvPIR5YzelcFWawDaEoavWC6BD7xEBHo+eEGZ
         wJYDSUjqIsfb7ObVW+lBpY6YR8UDLaS5tQ+55MurodcTdtYE+94c3m58myJkmLvY/1s9
         qNaoL1fClbr+ptG1mQtfZ0mb2b9oPsrVk9Gnml1DDeIqjJ3QqC+TUDNxPEvL0tMLSUfV
         mOghN0HRclSrUEWk9Fo0L3kfFhzjoe/Ouq1TLA4UIbmcsKL8F8xPWRX+ZbI0qKdEo5Hf
         J1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm1A+GRl0XYJLvq7IP+pZLW4in0+ZhJNRBGdvICH29MAdfVXQMZ2r8M6kUvU+EMx6gCctuqHDw63f9f/CKDJXKU9KMpPPEhYMki5ZYDw==
X-Gm-Message-State: AOJu0YxASaZVWf/4A+YJF5Hbf5V/GSolak+aaLwPhlHmGdvKKK7UQzYG
	zuAoBJ5vkKYiO7H0kHwusugI27Tj7U/Cxjgbc0Hm4Nkwex/JtBTcex9K1AkPGOwv0bzPxvcHBSE
	7Nw1yXr9Mj8UJiqAyzToYzCes7AVMRvaN6AWeX5kM0iOOno2GAbQlCk6qxQCu/Sc=
X-Received: by 2002:a5d:6a44:0:b0:341:b9d2:82e7 with SMTP id t4-20020a5d6a44000000b00341b9d282e7mr426762wrw.13.1711144569921;
        Fri, 22 Mar 2024 14:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgLLEm/IdbO6RfLia7LH2DHDQxsP79ZB+YJJPkRpwqbWTlGm6fv6vpR0pcdvs7yiVfvJc/eg==
X-Received: by 2002:a5d:6a44:0:b0:341:b9d2:82e7 with SMTP id t4-20020a5d6a44000000b00341b9d282e7mr426747wrw.13.1711144569511;
        Fri, 22 Mar 2024 14:56:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b00413f25d9104sm652216wmo.40.2024.03.22.14.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 14:56:09 -0700 (PDT)
Message-ID: <b40eb0b7-7362-4d19-95b3-e06435e6e09c@redhat.com>
Date: Fri, 22 Mar 2024 22:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, samsun1006219@gmail.com,
 syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
 Mike Rapoport <rppt@kernel.org>
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
 <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
 <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
 <463612f2-5590-4fb3-8273-0d64c3fd3684@redhat.com>
 <a6632384-c186-4640-8b48-f40d6c4f7d1d@redhat.com>
 <dd3e28b3-647c-4657-9c3f-9778bb046799@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dd3e28b3-647c-4657-9c3f-9778bb046799@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 22:37, David Hildenbrand wrote:
> On 22.03.24 22:33, David Hildenbrand wrote:
>> On 22.03.24 22:18, David Hildenbrand wrote:
>>> On 22.03.24 22:13, Miklos Szeredi wrote:
>>>> On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 22.03.24 20:46, Miklos Szeredi wrote:
>>>>>> On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>>> But at least the vmsplice() just seems to work. Which is weird, because
>>>>>>> GUP-fast should not apply (page not faulted in?)
>>>>>>
>>>>>> But it is faulted in, and that indeed seems to be the root cause.
>>>>>
>>>>> secretmem mmap() won't populate the page tables. So it's not faulted in yet.
>>>>>
>>>>> When we GUP via vmsplice, GUP-fast should not find it in the page tables
>>>>> and fallback to slow GUP.
>>>>>
>>>>> There, we seem to pass check_vma_flags(), trigger faultin_page() to
>>>>> fault it in, and then find it via follow_page_mask().
>>>>>
>>>>> ... and I wonder how we manage to skip check_vma_flags(), or otherwise
>>>>> managed to GUP it.
>>>>>
>>>>> vmsplice() should, in theory, never succeed here.
>>>>>
>>>>> Weird :/
>>>>>
>>>>>> Improved repro:
>>>>>>
>>>>>> #define _GNU_SOURCE
>>>>>>
>>>>>> #include <fcntl.h>
>>>>>> #include <unistd.h>
>>>>>> #include <stdio.h>
>>>>>> #include <errno.h>
>>>>>> #include <sys/mman.h>
>>>>>> #include <sys/syscall.h>
>>>>>>
>>>>>> int main(void)
>>>>>> {
>>>>>>              int fd1, fd2;
>>>>>>              int pip[2];
>>>>>>              struct iovec iov;
>>>>>>              char *addr;
>>>>>>              int ret;
>>>>>>
>>>>>>              fd1 = syscall(__NR_memfd_secret, 0);
>>>>>>              addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
>>>>>>              ftruncate(fd1, 7);
>>>>>>              addr[0] = 1; /* fault in page */
>>>>
>>>> Here the page is faulted in and GUP-fast will find it.  It's not in
>>>> the kernel page table, but it is in the user page table, which is what
>>>> matter for GUP.
>>>
>>> Trust me, I know the GUP code very well :P
>>>
>>> gup_pte_range -- GUP fast -- contains:
>>>
>>> if (unlikely(folio_is_secretmem(folio))) {
>>> 	gup_put_folio(folio, 1, flags);
>>> 	goto pte_unmap;
>>> }
>>>
>>> So we "should" be rejecting any secretmem folios and fallback to GUP slow.
>>>
>>>
>>> ... we don't check the same in gup_huge_pmd(), but we shouldn't ever see
>>> THP in secretmem code.
>>>
>>
>> Ehm:
>>
>> [   29.441405] Secretmem fault: PFN: 1096177
>> [   29.442092] GUP-fast: PFN: 1096177
>>
>>
>> ... is folio_is_secretmem() broken?
>>
>> ... is it something "obvious" like:
>>
>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>> index 35f3a4a8ceb1e..6996f1f53f147 100644
>> --- a/include/linux/secretmem.h
>> +++ b/include/linux/secretmem.h
>> @@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
>>             * We know that secretmem pages are not compound and LRU so we can
>>             * save a couple of cycles here.
>>             */
>> -       if (folio_test_large(folio) || !folio_test_lru(folio))
>> +       if (folio_test_large(folio) || folio_test_lru(folio))
>>                    return false;
>>     
>>            mapping = (struct address_space *)
> 
> ... yes, that does the trick!
> 

Proper patch (I might send out again on Monday "officially"). There are
other improvements we want to do to folio_is_secretmem() in the light of
folio_fast_pin_allowed(), that I wanted to do a while ago. I might send
a patch for that as well now that I'm at it.


 From 85558a46d9f249f26bd77dd3b18d14f248464845 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 22 Mar 2024 22:45:36 +0100
Subject: [PATCH] mm/secretmem: fix GUP-fast succeeding on secretmem folios

folio_is_secretmem() states that secretmem folios cannot be LRU folios:
so we may only exit early if we find an LRU folio. Yet, we exit early if
we find a folio that is not a secretmem folio.

Consequently, folio_is_secretmem() fails to detect secretmem folios and,
therefore, we can succeed in grabbing a secretmem folio during GUP-fast,
crashing the kernel when we later try reading/writing to the folio, because
the folio has been unmapped from the directmap.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/secretmem.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 35f3a4a8ceb1..6996f1f53f14 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
  	 * We know that secretmem pages are not compound and LRU so we can
  	 * save a couple of cycles here.
  	 */
-	if (folio_test_large(folio) || !folio_test_lru(folio))
+	if (folio_test_large(folio) || folio_test_lru(folio))
  		return false;
  
  	mapping = (struct address_space *)
-- 
2.43.2


-- 
Cheers,

David / dhildenb


