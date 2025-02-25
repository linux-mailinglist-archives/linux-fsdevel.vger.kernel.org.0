Return-Path: <linux-fsdevel+bounces-42589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1AA4473A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A67880D0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA784195808;
	Tue, 25 Feb 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYErTKnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1919048D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502506; cv=none; b=tWYLg0v5+rPGYNZ8weL0OwoCbGHMdqli8UTubAgZW+VPBV1eN0jOE/+vvUzN6kBuoAs8aXoW0eVuCP0tUTB3JfM2Hd2tNYbQqd5wLUyJr2ADD/DgygdljDMjKWLaq0O45wzIpNeJfJY0354gK4QlsaFfGs7lSvfLl7umpfH6XHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502506; c=relaxed/simple;
	bh=x4rVCQ/NGKY3lY+wOYrwPqaoT+vCb2bZCJg7lvJQpkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEvzmA1iaPKt2pGTtVSpuZxH8sxUUVHsUmMGkgCKUg0m0MBY0pqgff8N23J2I/I5YwCK16bkIyfrp6PCSTDDxToryfGUV4msRb0sV4zaeBJoNxiG4K+UrkeVRoREx1yxrcc4y1P8dozFb3rdnwV5dRMQ5iEOagneAAsX9iP/wME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYErTKnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S5yJPGVdx65L5scmtHTZpd1NndI/d9z8+AShgb9e8MI=;
	b=BYErTKnmrbs0OLVBmXyO3kilFuVPi3i0kCqCN5nBTaCnOvXBV7Nycz/VJ4FWHTSn2810ZF
	wkKn4a5EsO0mh6KDStfEFpzpcHOI077lcfNDynZ430wa9lN5kuXtCeNC4yVsTZnAo0rX0x
	ac1NtevtA2mJ9rOv0fvHWptwJ3GbGtg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-sQCSTuGqMQS141DFNrnglQ-1; Tue, 25 Feb 2025 11:55:01 -0500
X-MC-Unique: sQCSTuGqMQS141DFNrnglQ-1
X-Mimecast-MFC-AGG-ID: sQCSTuGqMQS141DFNrnglQ_1740502501
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4c0c1738so4667404f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 08:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502500; x=1741107300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5yJPGVdx65L5scmtHTZpd1NndI/d9z8+AShgb9e8MI=;
        b=IaLjLJ/Y4NehAcANB9T0HOJb6CzvtfThpIyfhkgTEBb2Wwo0eYBCmESPXUDGJYih6B
         YwRxoos1wgSdNpLX7922XlNycZomTcJT2ixechB534PGL9whesM+5wJ8c6MMhkH4KpO8
         MCfxwDYGI2jIrKuACEN8+ELT9nqhXoywnJ+bc+AjFPm8/YrAwc3odwmL/v/ASKPyO/u1
         jOJ6WTck6jBoLVc8ZiLfFsl1hCs0bFLEwRLJFSv7TBHDTlBU1wa81DYcTGKPnbOPo26v
         WK33Ui+RK1qXr0KXl/EbTlXgSm5F/aqzlSXbL3473zmtA2ZCojeO0s1K8EeLKgVTNsub
         CCzg==
X-Forwarded-Encrypted: i=1; AJvYcCWKXQDPLDunw0MTIdsB6fukvUz+oRQ4I5FKAsO0kNBuOf7b5HKhKmMea4JYVhzfo3LzzMzMwG7ZpToSQej0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/j0sH0lCByvRoXxYNrxJFH/Ne1vJnASgJDKcZ/82lZYQ0pR6t
	/BtYnocvJN0mOfMG8TI0m6W5Y/YHeQ+dU4zOgOyMMAuhEEEWIzqXBRQjq3oM+Bn2H28lp4aIwTw
	ZHpKJ9dNPEMG61qKU9p3/SEvoVuwxse85/1lMUajPGS1BZ7qvOpgG4MX5nU01GQw=
X-Gm-Gg: ASbGncuWrpqISGzvhmJex+dy7M2sdvO28WryZZ+n8tIGDjWovd3v4Nym5bV0gN3RE7S
	oNZyb+sNjg1nEigcio1mxxQjP+H2pqCZB2rnQYbXn/+NQYPa0HznhcjUXtztIX1CRQYh391bNcL
	AJpfKpNYWSxTt+3V2lIEvYEwMQwXUgjmJmz7t9zs+ycEID6dU23ItfVdTOHePujvR90QTaFBteG
	6Rwdmqaz1Vvj/fWvEDt2PvA29r5SHtlvXeRVqSuXvH41kI32wI+xKk95VbEvPBJmts3AbPsoYa5
	68j1AwH1gJxV3Piei0KYoCzjN3JKZh51aZ63BIa3NLPwZ8cPO0F+HX6uBPBW//5RUZSx9YLBKu0
	ZBp3l/D5/vgAjYpXwEXuCZSX4W0orcmC6gNmCHhBdPrs=
X-Received: by 2002:a05:6000:1448:b0:38d:da11:df19 with SMTP id ffacd0b85a97d-38f6f0b0c1cmr14635692f8f.41.1740502500578;
        Tue, 25 Feb 2025 08:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlmp7luRAOfWO8ZbFTMmYO9AWAJKLijTHwIR0d02WtfI3388fc2maD1UF8IAM7tzFvSQS1WQ==
X-Received: by 2002:a05:6000:1448:b0:38d:da11:df19 with SMTP id ffacd0b85a97d-38f6f0b0c1cmr14635636f8f.41.1740502500067;
        Tue, 25 Feb 2025 08:55:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce685sm146345305e9.2.2025.02.25.08.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:54:59 -0800 (PST)
Message-ID: <a3178c50-2e76-4743-8008-9a33bd0af93f@redhat.com>
Date: Tue, 25 Feb 2025 17:54:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] KVM: guest_memfd: Add flag to remove from direct
 map
To: Patrick Roy <roypat@amazon.co.uk>, rppt@kernel.org, seanjc@google.com
Cc: pbonzini@redhat.com, corbet@lwn.net, willy@infradead.org,
 akpm@linux-foundation.org, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tabba@google.com, jgowans@amazon.com,
 graf@amazon.com, kalyazin@amazon.com, xmarcalx@amazon.com,
 derekmn@amazon.com, jthoughton@google.com
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-4-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250221160728.1584559-4-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 17:07, Patrick Roy wrote:
> Add KVM_GMEM_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD() ioctl. When
> set, guest_memfd folios will be removed from the direct map after
> preparation, with direct map entries only restored when the folios are
> freed.
> 
> To ensure these folios do not end up in places where the kernel cannot
> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
> address_space if KVM_GMEM_NO_DIRECT_MAP is requested.
> 
> Note that this flag causes removal of direct map entries for all
> guest_memfd folios independent of whether they are "shared" or "private"
> (although current guest_memfd only supports either all folios in the
> "shared" state, or all folios in the "private" state if
> !IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM)). The usecase for removing
> direct map entries of also the shared parts of guest_memfd are a special
> type of non-CoCo VM where, host userspace is trusted to have access to
> all of guest memory, but where Spectre-style transient execution attacks
> through the host kernel's direct map should still be mitigated.
> 
> Note that KVM retains access to guest memory via userspace
> mappings of guest_memfd, which are reflected back into KVM's memslots
> via userspace_addr. This is needed for things like MMIO emulation on
> x86_64 to work. Previous iterations attempted to instead have KVM
> temporarily restore direct map entries whenever such an access to guest
> memory was needed, but this turned out to have a significant performance
> impact, as well as additional complexity due to needing to refcount
> direct map reinsertion operations and making them play nicely with gmem
> truncations.
> 
> This iteration also doesn't have KVM perform TLB flushes after direct
> map manipulations. This is because TLB flushes resulted in a up to 40x
> elongation of page faults in guest_memfd (scaling with the number of CPU
> cores), or a 5x elongation of memory population. On the one hand, TLB
> flushes are not needed for functional correctness (the virt->phys
> mapping technically stays "correct",  the kernel should simply to not it
> for a while), so this is a correct optimization to make. On the other
> hand, it means that the desired protection from Spectre-style attacks is
> not perfect, as an attacker could try to prevent a stale TLB entry from
> getting evicted, keeping it alive until the page it refers to is used by
> the guest for some sensitive data, and then targeting it using a
> spectre-gadget.
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>

...

>   
> +static bool kvm_gmem_test_no_direct_map(struct inode *inode)
> +{
> +	return ((unsigned long) inode->i_private) & KVM_GMEM_NO_DIRECT_MAP;
> +}
> +
>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>   {
> +	struct inode *inode = folio_inode(folio);
> +
> +	if (kvm_gmem_test_no_direct_map(inode)) {
> +		int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
> +						     false);

Will this work if KVM is built as a module, or is this another good 
reason why we might want guest_memfd core part of core-mm?

-- 
Cheers,

David / dhildenb


