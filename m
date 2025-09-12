Return-Path: <linux-fsdevel+bounces-61087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626DB54F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1693B91F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E330E849;
	Fri, 12 Sep 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnG/1Jwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3180030DEB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683972; cv=none; b=Z1aUJIzNcITPm/96NVg6Jhm80crBrEbUETihJTbB48jrNFUInM7LoGWwIqVwAFD7QmHg/X0ZFSMa32EJ0VMn0FX/4prsAyIGA7VIGP4mayBchB8rNRkowIL3T22iqkByyhclMA5z52fhS0Grruj6eJ21PFEWKmDmD41JbA39KOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683972; c=relaxed/simple;
	bh=7iYpSjnNZlF584j4SaaGW7J0wzvD9uJDKsgiq1vHdl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6bERR3aeRa3HpmY8L7Iy9ARk6GWtTz81JxFTy2kQ6gDyu7rWanRptV9AhRiof3lCooNy93wpGOGQHnD7JrnF3EojUYn3YswffewFuB9fD5wh6ebkpEl7hxEZxwS0N2G/+f7pDe+8rr7CO+unWNXf+6Aq844o51jlr0qBHFh3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnG/1Jwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757683969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d3WySasVKe/ME+w6oNrrZ2gd9OipXbQaPkCZGsmbrHU=;
	b=HnG/1JwnQeb/Kvs5hB+WJA0Ygi/64zz+jQyRp9v0jFoYxZh5umO3n1ff7qZSWFd07Fq613
	+OQcybDk5NT9UjG0/aVqVN3RQMKasCW221UgHzk/NpwdM9vzMl2KSzr4EyoGmMCMTnbRXD
	9OAk9SBA4taDLsNwjvP8DhBLwAzxA5o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-vZk2dHhnOhKRcG5WhwYSMQ-1; Fri, 12 Sep 2025 09:32:46 -0400
X-MC-Unique: vZk2dHhnOhKRcG5WhwYSMQ-1
X-Mimecast-MFC-AGG-ID: vZk2dHhnOhKRcG5WhwYSMQ_1757683965
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e403b84456so1265285f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683965; x=1758288765;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3WySasVKe/ME+w6oNrrZ2gd9OipXbQaPkCZGsmbrHU=;
        b=Wv/FnnfkH4XYEAVppWf9bP3fXfgS9Xhv+eTAIj8HPYLEZnxXdBg84PBjy3Ui+Ss0db
         nbJFM0uBwrgvNIj0q4+trHPosrr5PksopZ2Cv1dvb7lFBR9fzz2M85UkF6ZW3TrzGtFO
         tojPyx6aUUmVxjIB33emkcjdMIVPu7NcNdBqkackQm/s2okG/qR9qv7mQ+rJCpQjqZAt
         d2vMNXkO7zX/CF2FWtCzJ9PVNI3JiApcyjIW0TQFnnsyVvgIbTgdHIaQEkWRiYX/0koX
         35/M6VWpwjiqssb8YAfeYQQIoJKIIHXfSLTuwnAoWSCVansj9aFtl/toq5BZAIzXHRfx
         pmzw==
X-Forwarded-Encrypted: i=1; AJvYcCV+0xEduC9ejQpxl+wOmr0WJBk0YVMSjE75g5Q8E8bIbXpInf6kDbaqPrELiJ8IEG1QH84mF+n/Lw/QtK1h@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvLuGkXjm/cM1DlyxerTudirXIC4gPFad66MA/9PxikKoU46m
	TA1AC0sV5q5tbb3HC2eGrBMQ57Mql6iDM8WKGpf0lulnGjIomcn3kScpoCRMwMSimQaxxJncna/
	IPfwfBn9qPbR6ZsgLGFy/O/lsxyT5mk9ranDXC4gJaxnEw5uo0K5TL9yqCG+DNPeDAFQ=
X-Gm-Gg: ASbGncsolMuQLYLH+t0X4f91i7eRkfHjYHinMNtM971gGh+Pv7Wktwmh1wcMUxkYPgi
	xD/Eak9tTcXeM9ATb93/4lc1b2qW2XIBudPjae+o+6oSiSE9i2V5WjfSKGr7/UtWLyLa/5LB+L3
	B4HKebXqFsicynZhHl03SJ+qliIBSWUidlb5Y1elhDrg2Hft0zvjEbmA6Dr7nBL/JEcpkKgtCcR
	PwTUi2uTapjwwq6xZ4s8hwIpJwb1u8CO4j36ESZctPmEqRjHzIscrsb/bZ6rP/3gx+zP16MZcx4
	WX2oxaeZkit6ZVPZbfaH/nXjfPZiFHGIiHRo1gSiNYnjYnRqDZQYws5pgwCp9Zp6RKOlxo7rCuK
	xU00ePrzU/5VvJLWNyX2tnapJdUQf2MHKmW3Z/XSt82ySIu+7phMtGuwYp6d8Vh8BgdQ=
X-Received: by 2002:a05:6000:2584:b0:3d2:208c:45aa with SMTP id ffacd0b85a97d-3e7659eb4damr2923132f8f.29.1757683965378;
        Fri, 12 Sep 2025 06:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQvIA7aWaWPgRmM3ibF4CzK7cagNHsOvK16zCwCwknz8tuIMHPgwLUmt6YVpOJeww1hCUbMg==
X-Received: by 2002:a05:6000:2584:b0:3d2:208c:45aa with SMTP id ffacd0b85a97d-3e7659eb4damr2923086f8f.29.1757683964875;
        Fri, 12 Sep 2025 06:32:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm6793014f8f.16.2025.09.12.06.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:32:44 -0700 (PDT)
Message-ID: <b2334e92-9d04-4d27-aac1-fec91d5ee464@redhat.com>
Date: Fri, 12 Sep 2025 15:32:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/5] mm: softdirty: Add pgtable_soft_dirty_supported()
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
 <20250911095602.1130290-2-zhangchunyan@iscas.ac.cn>
 <9bcaf3ec-c0a1-4ca5-87aa-f84e297d1e42@redhat.com>
 <CAAfSe-sAru+FuhVWRa+i5_sj6m4318pLFrgP0Gsd0DVWzjE-hg@mail.gmail.com>
 <04d2d781-fd5e-4778-b042-d4dbeb8c5d49@redhat.com>
 <CAAfSe-tQgmBm=RS2gCi7VaRW1XZhS_sJ9rHbvqJ0w=KwTf+m3g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAfSe-tQgmBm=RS2gCi7VaRW1XZhS_sJ9rHbvqJ0w=KwTf+m3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 11:21, Chunyan Zhang wrote:
> On Fri, 12 Sept 2025 at 16:41, David Hildenbrand <david@redhat.com> wrote:
>>
>> [...]
>>
>>>>> +/*
>>>>> + * We should remove the VM_SOFTDIRTY flag if the soft-dirty bit is
>>>>> + * unavailable on which the kernel is running, even if the architecture
>>>>> + * provides the resource and soft-dirty is compiled in.
>>>>> + */
>>>>> +#ifdef CONFIG_MEM_SOFT_DIRTY
>>>>> +     if (!pgtable_soft_dirty_supported())
>>>>> +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
>>>>> +#endif
>>>>
>>>> You can now drop the ifdef.
>>>
>>> Ok, you mean define VM_SOFTDIRTY 0x08000000 no matter if
>>> MEM_SOFT_DIRTY is compiled in, right?
>>>
>>> Then I need memcpy() to set mnemonics[ilog2(VM_SOFTDIRTY)] here.
>>
>> The whole hunk will not be required when we make sure VM_SOFTDIRTY never
>> gets set, correct?
> 
> Oh no, this hunk code does not set vmflag.
> The mnemonics[ilog2(VM_SOFTDIRTY)] is for show_smap_vma_flags(),
> something like below:
> # cat /proc/1/smaps
> 5555605c7000-555560680000 r-xp 00000000 fe:00 19
>    /bin/busybox
> ...
> VmFlags: rd ex mr mw me sd
> 
> 'sd' is for soft-dirty
> 
> I think this is still needed, right?

If nobody sets VM_SOFTDIRTY in vma->vm_flags, then we will never print it.

So you can just leave the "#ifdef CONFIG_MEM_SOFT_DIRTY" as is to handle 
the VM_SOFTDIRTY=0 case.

So you should not have to change anything in show_smap_vma_flags().

[...]

>>>> That should be handled with the above never-set-VM_SOFTDIRTY.
>>>
>>> We don't need to check if (!pgtable_soft_dirty_supported()) if I
>>> understand correctly.
>> Hm, let me think about that. No, I think this has to stay as the comment
>> says, so this case here is special.
> 
> I will cook a new version and then we can discuss further based on the
> new patch.


Sounds good!


-- 
Cheers

David / dhildenb


