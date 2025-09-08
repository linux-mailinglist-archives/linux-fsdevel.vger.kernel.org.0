Return-Path: <linux-fsdevel+bounces-60576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88899B496F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 19:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CB7E4E0258
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD730C341;
	Mon,  8 Sep 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUCh30Qz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968A35947
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352644; cv=none; b=mkpajmTsZ08PVJnjDEjLRZr5RyLUqhiKJdZjziBdIfd2W0YnVuKkleqzk4NmSMU8Hyb5RTbCaLq88Mei2Fl4CJI/6cYEaNxM05AsF8gSWj9lv95DjoK6gQIUJRWr4XGBdbrf3WoCDqxjMOUVbV/ABgwJH0EaeS4vKfXZ40qQz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352644; c=relaxed/simple;
	bh=JyPkBfczRRzXpM98VuI8SgsMu1wrAKH/fI6gRLdmGRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8+knreiPkcaAo70BRDfaQZ6pbgUaLiJFHVAZd7cYvkoHh8LygcV8VbJfHWyZRTxS+Rg2J3f2/LoEQ+zhUYpSCRonEbOzrVF/kBfvB6SiGse/Fkn9/57lo0pOZjqJf8lU56gcMY8Rwlo04WFSwUXOmQtCh3KBa46beE+nNMRGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUCh30Qz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757352641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RAwcm1nPLLX4X92euXLnYeRyvAbGSoqBmBe5SHTlwFM=;
	b=iUCh30QzDe6moFHw0/yLThmI3oQOrS5qkZz3DVQVsPe9qsheilXGruX8wEme9o88BymbOi
	bnw0sKpC87dJlxOxmMUKH+xheOf2yVJcUYSoipAemxq+SHZxSC5IBk4OCu+O/RUBZJWS4Y
	TSTo4c08Hw8ePsbMOEUCivxCNF5ikng=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-UzRuxjgONM6Y8mpm-J9kPg-1; Mon, 08 Sep 2025 13:30:40 -0400
X-MC-Unique: UzRuxjgONM6Y8mpm-J9kPg-1
X-Mimecast-MFC-AGG-ID: UzRuxjgONM6Y8mpm-J9kPg_1757352639
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dbf3054ac4so2739057f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 10:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352639; x=1757957439;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAwcm1nPLLX4X92euXLnYeRyvAbGSoqBmBe5SHTlwFM=;
        b=j0UpfZa9KwitxjafOGjCEJZ/WoWKvcAHFpQ+Pvrs2uBtU4lQPYw6I0A3aVXTi1WPyQ
         MkvcXYA4wkvGRCQYkfAZt04f63JlmzWqmODc3xVq7GwyPBcrPojIvRiLf33JYgza5u9V
         c/bW+bPKnqdWYV5UVukq4kUOjtrl9kL09bpewtD3h5wOHH4AP+wtI89HxzeRI/ze4kv2
         00xS1dG4OltbRKpigOL78FXtgM31/oW0VxMdk/pVq5ZvstIRc8RfdTJaCtruj7GQm/EX
         HOYQn+1incmgXGzSCbtu0y5Dw2l9MlDAJ6MPPVk/MJSBdPYhO0xP6IX4Km7QMJGSdBk9
         XNKw==
X-Forwarded-Encrypted: i=1; AJvYcCUftTVvk5x2jqaBcnAdEnsiYnSy3aN7KB+ERSHqsMzwP8n0Kv/gc0TWWBglc3q/yi7my0mLvK7kfIqu39lu@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqOQpkPQR8ndLtFAHd6ATWFH6gXTbSssGqTp0vTq43FLEVMTt
	qyyvlN31kO7ZSQDV/QXlxUu4ElyN1MEmPvLC3Jq9uMIkK4Nma1iE1hq0m7rI8IULn8Od5pXm1lZ
	nKAwKTobyyrZVcuzpVyCC3h3jRV9Z2IQSucTsBsVN/n9hQFmfnkOh62KYcMDj72zQVPA=
X-Gm-Gg: ASbGncvFYEXPJ6ZQtlmsqTgq+ehBekW48RpVYlUwyWeJFg3GpSx4yJSnPOUwQbO8B1B
	XIe6Cb7TTesO0CyiMBz9KccDd2/JBDDOT3VcKFUcFE6McXDpgT7yZvwut7K+dcGJo+PWy6FqlrH
	rU1gV+Xday9xjSPWbDG3TcySthNgABk+6yLJGgBdTs7phYlZqSeptfufpqBGIwkNeZM78qIyUz0
	LSbEGnIiVxKYYzf78K7tN32jB5+4Xh32gY9TeOmqdVggzzQPzAI5hiUblNsbAqAAixuwZX59bSs
	fBKT78WzwGC9x4oaQWkObQxJ6UtPngFFqM+4P091T15lslWMBj2iWqXjNKHA2FmyXn56aUpBw1/
	sWmeAL++IKZ7RAVZaW3RWNwcU9tFUIJsELAo8fdC8LNLqPhwqZK0PxYnWP1mCw9Ms
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d581 with SMTP id ffacd0b85a97d-3e636d8ff6dmr7012148f8f.7.1757352639300;
        Mon, 08 Sep 2025 10:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj6Fx/oJ/i3mGb5tdhsyoUu3a7TRpHUY03SW3dQRjVAjsi0xq639ZH0YB5uZksW3RpOLFefg==
X-Received: by 2002:a5d:5d05:0:b0:3ce:f0a5:d581 with SMTP id ffacd0b85a97d-3e636d8ff6dmr7012120f8f.7.1757352638837;
        Mon, 08 Sep 2025 10:30:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm197762845e9.3.2025.09.08.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:30:38 -0700 (PDT)
Message-ID: <92def589-a76f-4360-8861-6bc9f94c1987@redhat.com>
Date: Mon, 8 Sep 2025 19:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
 <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 17:35, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:07:57PM +0200, David Hildenbrand wrote:
>> On 08.09.25 16:47, Lorenzo Stoakes wrote:
>>> On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
>>>> On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
>>>>>> Perhaps
>>>>>>
>>>>>> !vma_desc_cowable()
>>>>>>
>>>>>> Is what many drivers are really trying to assert.
>>>>>
>>>>> Well no, because:
>>>>>
>>>>> static inline bool is_cow_mapping(vm_flags_t flags)
>>>>> {
>>>>> 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
>>>>> }
>>>>>
>>>>> Read-only means !CoW.
>>>>
>>>> What drivers want when they check SHARED is to prevent COW. It is COW
>>>> that causes problems for whatever the driver is doing, so calling the
>>>> helper cowable and making the test actually right for is a good thing.
>>>>
>>>> COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
>>>> something that is COW in future.
>>>
>>> But you can't do that if !VM_MAYWRITE.
>>>
>>> I mean probably the driver's just wrong and should use is_cow_mapping() tbh.
>>>
>>>>
>>>> Drivers have commonly various things with VM_SHARED to establish !COW,
>>>> but if that isn't actually right then lets fix it to be clear and
>>>> correct.
>>>
>>> I think we need to be cautious of scope here :) I don't want to accidentally
>>> break things this way.
>>>
>>> OK I think a sensible way forward - How about I add desc_is_cowable() or
>>> vma_desc_cowable() and only set this if I'm confident it's correct?
>>
>> I'll note that the naming is bad.
>>
>> Why?
>>
>> Because the vma_desc is not cowable. The underlying mapping maybe is.
> 
> Right, but the vma_desc desribes a VMA being set up.
> 
> I mean is_cow_mapping(desc->vm_flags) isn't too egregious anyway, so maybe
> just use that for that case?

Yes, I don't think we would need another wrapper.

-- 
Cheers

David / dhildenb


