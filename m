Return-Path: <linux-fsdevel+bounces-22927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE27923BFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA911C225B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5C15956E;
	Tue,  2 Jul 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+8f6GaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39804CDF9
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918156; cv=none; b=r9U+fHZELwWCQvqb5tDWLR0yMo1+oTFIYde1Atr86wM1s4pbyGqqbFQ7P+YYgT5rGXPxHUw0tfE+CzrkncGS4DgJoviAjDZvwS7/CaQ9kfFmRfNjKlB7u8eATytlfG/kQsX9Y3Gb+xO7Gb1FyNau6hKl9cpyH3I1tN3ssoBOEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918156; c=relaxed/simple;
	bh=IseBVDjYuwUKlSUQ9ZgGvkyGSjcotNNvohYzP5og/Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvRSJJsCEBlsz3TdwC0HPuzs0p28R7lvG89QoxiLcerZNPH68nvO7ObcDEg5wIwQxfDJVfKuCZhFJRbVyQgTzC1djwp+XwHWFUd+vA0QQrGC1HiKsbP8SNNAGo6LOt1WbNLtHAwU+G5L26zJesU0VI2RcY6pdJFEF2CNSBA09QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+8f6GaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UL8IHyEAzzEhuqWUqFBrX1hYRvB3a6Us/wF14KpIMm8=;
	b=b+8f6GaBhvQCddKCMP024XS2ZcNu4+fVRkXtgJQEvNTEWOq9j8CymBApimemN0TlDaNGag
	zXZiRlgTDIAaqLKS4hCYJXoWOyUU5mgcF1bhhA+1qNoiN/05vazA3A2j7RNXeWSWHs8WEv
	8HyForu6xy5Gl63d3y+qVMbNt6+rv28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-MrbWC2-SPvy1KYW8Suo24g-1; Tue, 02 Jul 2024 07:02:32 -0400
X-MC-Unique: MrbWC2-SPvy1KYW8Suo24g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36279cf642cso2049290f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 04:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918151; x=1720522951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UL8IHyEAzzEhuqWUqFBrX1hYRvB3a6Us/wF14KpIMm8=;
        b=Njcp0aOAr4gspHGrUFyGIE3Yzy2GGzKVr9mLVh1omxOFrt7pt7Oeb72C+Yc06cJMp6
         9DaX33rO9oqqm6p7k09sQpccSSR3WgNnIR8K/EkRBAZ1Fw1q5f6ilnpx/dnMUSiejohW
         QQfJHFEyd6Fk3O3zzNZOdpnmi4TeW10vqAeCw6UyIsSTbcmhr1ufepbBd96XAJKKAvvY
         o4Yuy5n7gvIEqOq22fJCDakb/e3JQrg987TiQz1QCw8LS7GSVqIkkVHEfYc5lfGZ+2jW
         CoQzt+5egujIXgB/PhfJoB8HRj5dz6TAg+Gxp+o6CJC+hEgJdspJj8VmdJl1RcQF2FjU
         3oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVumoVPN6iF9uHBLgra1xFBQWKTZrRi2bj3G32btUwhQO6fSwbAjc11SoM2D8Z3ntOCLevuZmCm9Uz40Sk/k+N4r5zQO5PJ6VKNnx9g==
X-Gm-Message-State: AOJu0Yz0plaT3A0JD/RFPhDr0bTFZYUQhLwk27N5kQBBDyqkD0BiHwlO
	Onhmn0lwhSO4bpouV2jcoBQHK5hCVmMSbgOeYr+OMXgjmcwy4KgXEpuBESvZPbNZN2v9lavE4xO
	+03aIAyceBaCMRZgN5IwdKX7fjjWvmcdEvujUcXOyk/+AyJ1L3boGuRZFmTNRorA=
X-Received: by 2002:a05:6000:1bd1:b0:367:4383:d9b4 with SMTP id ffacd0b85a97d-36775725c29mr5279889f8f.56.1719918151531;
        Tue, 02 Jul 2024 04:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWBU7bpbDTnWN0KIwHats8EvGUXSpFzRTluYA8doiuhAlqNN/TYVapDq2HAfSv1xUm1Jzhg==
X-Received: by 2002:a05:6000:1bd1:b0:367:4383:d9b4 with SMTP id ffacd0b85a97d-36775725c29mr5279833f8f.56.1719918150932;
        Tue, 02 Jul 2024 04:02:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678aa3caccsm676393f8f.35.2024.07.02.04.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 04:02:30 -0700 (PDT)
Message-ID: <0b549ff0-b0b6-4fc8-aa6f-0d76157575b3@redhat.com>
Date: Tue, 2 Jul 2024 13:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com,
 peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
 <cf572c69-a754-4d41-b9c4-7a079b25b3c3@redhat.com>
 <874j98gjfg.fsf@nvdebian.thelocal>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <874j98gjfg.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 12:19, Alistair Popple wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 27.06.24 02:54, Alistair Popple wrote:
>>> Currently DAX folio/page reference counts are managed differently to
>>> normal pages. To allow these to be managed the same as normal pages
>>> introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
>>> and take references as it would for a normally mapped page.
>>> This is distinct from the current mechanism, vmf_insert_pfn_pud,
>>> which
>>> simply inserts a special devmap PUD entry into the page table without
>>> holding a reference to the page for the mapping.
>>
>> Do we really have to involve mapcounts/rmap for daxfs pages at this
>> point? Or is this only "to make it look more like other pages" ?
> 
> The aim of the series is make FS DAX and other ZONE_DEVICE pages look
> like other pages, at least with regards to the way they are refcounted.
> 
> At the moment they are not refcounted - instead their refcounts are
> basically statically initialised to one and there are all these special
> cases and functions requiring magic PTE bits (pXX_devmap) to do the
> special DAX reference counting. This then adds some cruft to manage
> pgmap references and to catch the 2->1 page refcount transition. All
> this just goes away if we manage the page references the same as other
> pages (and indeed we already manage DEVICE_PRIVATE and COHERENT pages
> the same as normal pages).
> 
> So I think to make this work we at least need the mapcounts.
> 

We only really need the mapcounts if we intend to do something like 
folio_mapcount() == folio_ref_count() to detect unexpected folio 
references, and if we have to have things like folio_mapped() working. 
For now that was not required, that's why I am asking.

Background also being that in a distant future folios will be decoupled 
more from other compound pages, and only folios (or "struct anon_folio" 
/ "struct file_folio") would even have mapcounts.

For example, most stuff we map (and refcount!) via vm_insert_page() 
really must stop involving mapcounts. These won't be "ordinary" 
mapcount-tracked folios in the future, they are simply some refcounted 
pages some ordinary driver allocated.

For FS-DAX, if we'll be using the same "struct file_folio" approach as 
for ordinary pageache memory, then this is the right thing to do here.


>> I'm asking this because:
>>
>> (A) We don't support mixing PUD+PMD mappings yet. I have plans to change
>>      that in the future, but for now you can only map using a single PUD
>>      or by PTEs. I suspect that's good enoug for now for dax fs?
> 
> Yep, that's all we support.
> 
>> (B) As long as we have subpage mapcounts, this prevents vmemmap
>>      optimizations [1]. Is that only used for device-dax for now and are
>>      there no plans to make use of that for fs-dax?
> 
> I don't have any plans to. This is purely focussed on refcounting pages
> "like normal" so we can get rid of all the DAX special casing.
> 
>> (C) We managed without so far :)
> 
> Indeed, although Christoph has asked repeatedly ([1], [2] and likely
> others) that this gets fixed and I finally got sick of it coming up
> everytime I need to touch something with ZONE_DEVICE pages :)
> 
> Also it removes the need for people to understand the special DAX page
> recounting scheme and ends up removing a bunch of cruft as a bonus:
> 
>   59 files changed, 485 insertions(+), 869 deletions(-)

I'm not challenging the refcounting scheme. I'm purely asking about 
mapcount handling, which is something related but different.

> 
> And that's before I clean up all the pgmap reference handling. It also
> removes the pXX_trans_huge and pXX_leaf distinction. So we managed, but
> things could be better IMHO.
> 

Again, all nice things.

>> Having that said, with folio->_large_mapcount things like
>> folio_mapcount() are no longer terribly slow once we weould PTE-map a
>> PUD-sized folio.
>>
>> Also, all ZONE_DEVICE pages should currently be marked PG_reserved,
>> translating to "don't touch the memmap". I think we might want to
>> tackle that first.

Missed to add a pointer to [2].

> 
> Ok. I'm keen to get this series finished and I don't quite get the
> connection here, what needs to change there?

include/linux/page-flags.h

"PG_reserved is set for special pages. The "struct page" of such a page 
should in general not be touched (e.g. set dirty) except by its owner. 
Pages marked as PG_reserved include:

...

- Device memory (e.g. PMEM, DAX, HMM)
"

I think we already entered that domain with other ZONE_DEVICE pages 
being returned from vm_normal_folio(), unfortunately. But that really 
must be cleaned up for these pages to not look special anymore.

Agreed that it likely is something that is not blocking this series.

-- 
Cheers,

David / dhildenb


