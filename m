Return-Path: <linux-fsdevel+bounces-25102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3309491DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABBB1F21A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9F1D47A2;
	Tue,  6 Aug 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjTJC2nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B31D2F59
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951815; cv=none; b=U7EvNBeMjnDlubAUmjNSVW2j/1X4UplBLS/K+140nFu/ECqlSe1CPWOWqqZ3iY6/oBxNjHkGhnaiMNSoUV4QejaLINFzaVDArDlehX41GIyUpwZINZPgwRCCAikrhZrzpRoun8onY4KnH82LnzpKvGX2R3YknzB5MZbbRGA5zZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951815; c=relaxed/simple;
	bh=M8zXtgPGl3GmVlDT8c1//FMDG6JpU+brduXIeU/y23Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kROVnOweJs/g5m/qFUhGmd9U2C3j+95aEuUV80gKCOKGbKbcan/vz7KFyycgy7HFjC8DSYIsjJTS7pwTEghMlnXjvtayic8eR1Bb5TELTh4ruT7481mC99RXzfiVj/ZLvtPPp/xtO767kP6opRvI6qJw6yAaNZHyTRcD0QrE+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjTJC2nv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722951812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i65iOJUqoj+kS1IUzfkGG2qrh7z3NVtE513m6YvoExI=;
	b=EjTJC2nvINOtmJBvqH5dJABXE4RjIZFErECrfZnSswBjhsML0flrpd+3syhPhb4T5w3R4t
	5/lUYvSSdCDaIss+4x4I34SQizfs6FeqC4QCHxeSF0zZRFwjLJ1x/oXZe6RRZcvnzK3DdP
	nBG+lKTe7vUu6QzIHeCvZyUpWXIhmk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-HoguraYCOp-mYtH3_XCIGw-1; Tue, 06 Aug 2024 09:43:31 -0400
X-MC-Unique: HoguraYCOp-mYtH3_XCIGw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42671a6fb9dso3935335e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 06:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951810; x=1723556610;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i65iOJUqoj+kS1IUzfkGG2qrh7z3NVtE513m6YvoExI=;
        b=UG7ugVE0y+yA4mojfzvA3p7Qp213Z2l/KvNlOsKYxIHz/VV7Qj35blN8Qk0rz6YIXQ
         JvBjYUBSM0j5L2J06b/k2w5q9e4yKRDIk2IWDJtQkUAjBh7Bq926UQb/z0JmkIujd8nl
         xG2fPz/HgvxYwmdP4UzEDvhJrbeHlAJgGwTMu5qp4HvnTxKksWZE+ymxzgkWL6EegJai
         q03qkk1Sdo+lBFUp0/mWC+ul5qI4GL1mTAbQQFcZ9wqyovs9onlzFAbySXdTjm7yCut+
         NcRts3TMXkYaREHQ12TR6DbhxyhAOilmf8UZrOMjxsXLf4UeO+db/i1bIOr6KjtfLQgZ
         k2PA==
X-Forwarded-Encrypted: i=1; AJvYcCUySHF5ljEfGFJTz7u8KtPLmFx0uHFYsWnIkq7ONGorpzvmiH0WQoOtuAx3HzGUvyR/UuNSyPgt+x+Hi+ZB@vger.kernel.org
X-Gm-Message-State: AOJu0YxSZJtmHT7p9vmLBEEmMjUNbsL7KDQsIQd3YCzD+1beqHLMSkyD
	YDuZJzphkA3WUoSQiYdcKIke6WDrqM9bG6EZ41jEY20+pl4brOEbZ50XV0SpiPWiHqwousnA7B2
	/Ix12DDYOD8OqsUGTj+zItuIh4FBX7Z/SrKx5chz0Kx7L4T1VUMf9gG0sFls+odw=
X-Received: by 2002:a05:600c:3ba9:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-428e6b037fcmr98323395e9.16.1722951809892;
        Tue, 06 Aug 2024 06:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/s1//lA1u4Wc1rgWG/YcdlvCfb4QgZvbrdHSXct6MeS9TCApHhXZa6xl1kW4kwHKMV90s1A==
X-Received: by 2002:a05:600c:3ba9:b0:426:554a:e0bf with SMTP id 5b1f17b1804b1-428e6b037fcmr98323225e9.16.1722951809422;
        Tue, 06 Aug 2024 06:43:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm246406305e9.35.2024.08.06.06.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:43:29 -0700 (PDT)
Message-ID: <883a0f0d-7342-479e-aa3c-13deb7e99338@redhat.com>
Date: Tue, 6 Aug 2024 15:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory
 filesystem
To: "Gowans, James" <jgowans@amazon.com>, "jack@suse.cz" <jack@suse.cz>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "brauner@kernel.org"
 <brauner@kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Durrant, Paul" <pdurrant@amazon.co.uk>,
 "seanjc@google.com" <seanjc@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "nh-open-source@amazon.com" <nh-open-source@amazon.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805200151.oja474ju4i32y5bj@quack3>
 <9802ddc299c72b189487fd56668de65a84f7d94b.camel@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9802ddc299c72b189487fd56668de65a84f7d94b.camel@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 1. Secret hiding: with guestmemfs all of the memory is out of the kernel
> direct map as an additional defence mechanism. This means no
> read()/write() syscalls to guestmemfs files, and no IO to it. The only
> way to access it is to mmap the file.

There are people interested into similar things for guest_memfd.

> 
> 2. No struct page overhead: the intended use case is for systems whose
> sole job is to be a hypervisor, typically for large (multi-GiB) VMs, so
> the majority of system RAM would be donated to this fs. We definitely
> don't want 4 KiB struct pages here as it would be a significant
> overhead. That's why guestmemfs carves the memory out in early boot and
> sets memblock flags to avoid struct page allocation. I don't know if
> hugetlbfs does anything fancy to avoid allocating PTE-level struct pages
> for its memory?

Sure, it's called HVO and can optimize out a significant portion of the 
vmemmap.

> 
> 3. guest_memfd interface: For confidential computing use-cases we need
> to provide a guest_memfd style interface so that these FDs can be used
> as a guest_memfd file in KVM memslots. Would there be interest in
> extending hugetlbfs to also support a guest_memfd style interface?
> 

"Extending hugetlbfs" sounds wrong; hugetlbfs is a blast from the past 
and not something people are particularly keen to extend for such use 
cases. :)

Instead, as Jason said, we're looking into letting guest_memfd own and 
manage large chunks of contiguous memory.

> 4. Metadata designed for persistence: guestmemfs will need to keep
> simple internal metadata data structures (limited allocations, limited
> fragmentation) so that pages can easily and efficiently be marked as
> persistent via KHO. Something like slab allocations would probably be a
> no-go as then we'd need to persist and reconstruct the slab allocator. I
> don't know how hugetlbfs structures its fs metadata but I'm guessing it
> uses the slab and does lots of small allocations so trying to retrofit
> persistence via KHO to it may be challenging.
> 
> 5. Integration with persistent IOMMU mappings: to keep DMA running
> across kexec, iommufd needs to know that the backing memory for an IOAS
> is persistent too. The idea is to do some DMA pinning of persistent
> files, which would require iommufd/guestmemfs integration - would we
> want to add this to hugetlbfs?
> 
> 6. Virtualisation-specific APIs: starting to get a bit esoteric here,
> but use-cases like being able to carve out specific chunks of memory
> from a running VM and turn it into memory for another side car VM, or
> doing post-copy LM via DMA by mapping memory into the IOMMU but taking
> page faults on the CPU. This may require virtualisation-specific ioctls
> on the files which wouldn't be generally applicable to hugetlbfs.
> 
> 7. NUMA control: a requirement is to always have correct NUMA affinity.
> While currently not implemented the idea is to extend the guestmemfs
> allocation to support specifying allocation sizes from each NUMA node at
> early boot, and then having multiple mount points, one per NUMA node (or
> something like that...). Unclear if this is something hugetlbfs would
> want.
> 
> There are probably more potential issues, but those are the ones that
> come to mind... That being said, if hugetlbfs maintainers are interested
> in going in this direction then we can definitely look at enhancing
> hugetlbfs.
> 
> I think there are two types of problems: "Would hugetlbfs want this
> functionality?" - that's the majority. An a few are "This would be hard
> with hugetlbfs!" - persistence probably falls into this category.

I'm much rather asking myself if you should instead teach/extend the 
guest_memfd concept by some of what you propose here.

At least "guest_memfd" sounds a lot like the "anonymous fd" based 
variant of guestmemfs ;)

Like we have hugetlbfs and memfd with hugetlb pages.

-- 
Cheers,

David / dhildenb


