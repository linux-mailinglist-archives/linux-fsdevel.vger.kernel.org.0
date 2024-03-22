Return-Path: <linux-fsdevel+bounces-15129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8082D887478
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43AA1C21F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13680606;
	Fri, 22 Mar 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af4gOK8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87E5820D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143232; cv=none; b=daWAuf8paGzYQbIYTA9RICgxk8qb7FnJBxmrB2OsQf67Gz8WBlVcT/Hm2DfMMBjeCjZD19c6haoDF83j0Fagi2nd4kh74rij2wYQdYyxbK+8PvaxFdZqoxfC5KqDoMvexQX7kUoNkHilBthuVPRcMounUw6e8sTVYQ9MSB+YMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143232; c=relaxed/simple;
	bh=PqzwJRGeA0m4c/OUT2r2CD8DOxmQIwZ0ypehS4LmR30=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KPD1LN3uoel1CXb0JYm0W0pLKO79nkN8R7AMnclBu9kCC000kUY1/1m7qX4VC/0gNYbL07Fx+c0m4vFDV73agCKO3M091Hefno8ac2yCWlphtVSBkCwX/dAzKFfHtOI6bO5uq0nHnRG+k3bsXlCKJCEpNbvy6eUhYnvR/yEXn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af4gOK8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711143229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N0U+z4zSBh2A2zjh96RNC4QUW0B+ry8dBKnISC/lxOM=;
	b=Af4gOK8Wl6DhTF3i7GWpRdkHW8gUVWkwxMlivx9IY9SuRUA6q4ynGXcJvGz0fL3qAQ2u4a
	ksARwJFCClsCUGqeFmqyABLHZAKc7uaRd1bfINei3CCPH85VMAlVHcWb0uZscl+j8m98SS
	5QNucTF4ChcFuoVMB9QU+LxPBXhSPOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-J0KrVojRMJ2RhibapjgMTQ-1; Fri, 22 Mar 2024 17:33:48 -0400
X-MC-Unique: J0KrVojRMJ2RhibapjgMTQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e53200380so12297995e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143227; x=1711748027;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N0U+z4zSBh2A2zjh96RNC4QUW0B+ry8dBKnISC/lxOM=;
        b=V96UCvIc14Xq28TlzkJD/3C7BtYRej6+to5VXM/6I29OYJAQPAfEHg/nEnBS8aFh2D
         rD4aKWLWvtOOpnSMqscyXfYDobbRhR2B32SHAe2a7zXUuH5Huh4zVA9jduUzrqT8j1K0
         BkmXiqSQjAcuhlFjbM+yojS9kh5h3xO0x+eoYPA+gB4ENeqJPbmpJFz5VeIiKQiLrtZe
         LqMuH/dBGPeAvR0rNzRB95N52H09RDWXurcARdye6myq7xm6tJ8/4PpoOIt3CJqnq0Fe
         h0UfqR0vND7nae/yCU7QVmDQ8lbHL0cdkXBtciGhiwmJCLjvZkHuPeXCeicSDpmWUNLS
         685g==
X-Forwarded-Encrypted: i=1; AJvYcCXURDVllm1kI3c38BpTZqz1Y5s85ENpcQRh+heE3K2PfNq3mlue7poD7h2/+7JoevtUTqH+DuhpWI3kzjbMla7rCUU7dDPYaJFzSmqsgA==
X-Gm-Message-State: AOJu0YyFQpYb0puzox4Q1YijBwE5gvjm+iNAdJEJhngwsAuG8Nm/JB0C
	HlV8i4dHmcCvZPXNhSB0ZIeB2AOjjrMOCKyjs7CVB3ck/qzUP+qM7CCK0QbOK8fWb2wKCtIhJym
	F1rwZJcP2RN8VOcnf2Kc5LWvzLWOk2wk/B0XsVOtDJucjglQngjIzFJy9RzUGeqg=
X-Received: by 2002:a05:600c:364a:b0:413:f4d0:c233 with SMTP id y10-20020a05600c364a00b00413f4d0c233mr387737wmq.35.1711143227178;
        Fri, 22 Mar 2024 14:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8o03NYFlUyKSvgiFG7FIlhqUJeGho6F16MyvDU0RetUKhLAowP2mrdM2c8abvBrdDtYjOTg==
X-Received: by 2002:a05:600c:364a:b0:413:f4d0:c233 with SMTP id y10-20020a05600c364a00b00413f4d0c233mr387727wmq.35.1711143226775;
        Fri, 22 Mar 2024 14:33:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id f10-20020a05600c4e8a00b00412e5f32591sm622002wmq.28.2024.03.22.14.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 14:33:46 -0700 (PDT)
Message-ID: <a6632384-c186-4640-8b48-f40d6c4f7d1d@redhat.com>
Date: Fri, 22 Mar 2024 22:33:45 +0100
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
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <463612f2-5590-4fb3-8273-0d64c3fd3684@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 22:18, David Hildenbrand wrote:
> On 22.03.24 22:13, Miklos Szeredi wrote:
>> On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 22.03.24 20:46, Miklos Szeredi wrote:
>>>> On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> But at least the vmsplice() just seems to work. Which is weird, because
>>>>> GUP-fast should not apply (page not faulted in?)
>>>>
>>>> But it is faulted in, and that indeed seems to be the root cause.
>>>
>>> secretmem mmap() won't populate the page tables. So it's not faulted in yet.
>>>
>>> When we GUP via vmsplice, GUP-fast should not find it in the page tables
>>> and fallback to slow GUP.
>>>
>>> There, we seem to pass check_vma_flags(), trigger faultin_page() to
>>> fault it in, and then find it via follow_page_mask().
>>>
>>> ... and I wonder how we manage to skip check_vma_flags(), or otherwise
>>> managed to GUP it.
>>>
>>> vmsplice() should, in theory, never succeed here.
>>>
>>> Weird :/
>>>
>>>> Improved repro:
>>>>
>>>> #define _GNU_SOURCE
>>>>
>>>> #include <fcntl.h>
>>>> #include <unistd.h>
>>>> #include <stdio.h>
>>>> #include <errno.h>
>>>> #include <sys/mman.h>
>>>> #include <sys/syscall.h>
>>>>
>>>> int main(void)
>>>> {
>>>>            int fd1, fd2;
>>>>            int pip[2];
>>>>            struct iovec iov;
>>>>            char *addr;
>>>>            int ret;
>>>>
>>>>            fd1 = syscall(__NR_memfd_secret, 0);
>>>>            addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
>>>>            ftruncate(fd1, 7);
>>>>            addr[0] = 1; /* fault in page */
>>
>> Here the page is faulted in and GUP-fast will find it.  It's not in
>> the kernel page table, but it is in the user page table, which is what
>> matter for GUP.
> 
> Trust me, I know the GUP code very well :P
> 
> gup_pte_range -- GUP fast -- contains:
> 
> if (unlikely(folio_is_secretmem(folio))) {
> 	gup_put_folio(folio, 1, flags);
> 	goto pte_unmap;
> }
> 
> So we "should" be rejecting any secretmem folios and fallback to GUP slow.
> 
> 
> ... we don't check the same in gup_huge_pmd(), but we shouldn't ever see
> THP in secretmem code.
> 

Ehm:

[   29.441405] Secretmem fault: PFN: 1096177
[   29.442092] GUP-fast: PFN: 1096177


... is folio_is_secretmem() broken?

... is it something "obvious" like:

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 35f3a4a8ceb1e..6996f1f53f147 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(struct folio *folio)
          * We know that secretmem pages are not compound and LRU so we can
          * save a couple of cycles here.
          */
-       if (folio_test_large(folio) || !folio_test_lru(folio))
+       if (folio_test_large(folio) || folio_test_lru(folio))
                 return false;
  
         mapping = (struct address_space *)


-- 
Cheers,

David / dhildenb


