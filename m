Return-Path: <linux-fsdevel+bounces-62713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60001B9E9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564DB4C2211
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071312EAD0C;
	Thu, 25 Sep 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/ShVimb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC42EA730
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795943; cv=none; b=fvlFzsinH4P1lMUAEvm9+l1o/10xBPCfNVjZ9UtIwod/fpcwYrouiFvcXbWrHe6BkgIxBt9VixMdMXQh78c2N3AZcoB6AMQTYn1qn5IWbCIFgvzpi+FQpH84fDztlGbTX6eSjN6EVz3M1E0NAYnRgBA4DEgpj9XfzI3m0fL2j4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795943; c=relaxed/simple;
	bh=GYQJoM3ZAazrBQGynd1dKgzd+tbmzy64EH8nekL+uZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQz8MwYmuLAd54Lc//LFoyOhX6Q7cKB0OjaXAFw4zOCQT+fdrra0Q2hLFI/8qd4oUvCqJqi4NH4Bh6V/rWN9IeU61aSeTEBrjcMP4j0dMr8QEvrGx3eEDpZjTi30CjF1EqZ1Vf0iRuIoB7+er1HyqQRrnyuaN+F6zWK9TRwhqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/ShVimb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758795940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yn7KtJOI+OoVL/g0bXoboAmrO1BBc45RKDhcTRih648=;
	b=G/ShVimba/c52dY+NgvHeOhf8y/cIb4k+bjYOgi89SZvuAkCjDd5iCt+SFI1saYVjcLKJB
	evZ8qCkdMaIW3t0+vSv3UEB6Mr8I5uY5CAe1llTYKv2wZMgiO7TX3T5UoQHf3GNnF/x6DS
	4LLPMgOG1D949AGGILnTQemjkFzAhaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-m8emvx7ZMgmTpkCyw0cuGA-1; Thu, 25 Sep 2025 06:25:38 -0400
X-MC-Unique: m8emvx7ZMgmTpkCyw0cuGA-1
X-Mimecast-MFC-AGG-ID: m8emvx7ZMgmTpkCyw0cuGA_1758795937
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee1317b132so493766f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 03:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795937; x=1759400737;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn7KtJOI+OoVL/g0bXoboAmrO1BBc45RKDhcTRih648=;
        b=L9rHzj1aQTDkg9UyAWkU2/Cr7X2Q0iT6irIKOr7MwfHlN7idZmGArSS9Sn6H/4My3L
         eu1eWnB6ZHz3RNq1PvnQSY2q6i5hPoYcjMnkJeThp0Wm5hk7XoKDqf0oa86Kd0l0G1Tf
         1VwVXs2sBcSrBILoQO1+TytXDLxi1vAQaWqiJZwe3Yh6mgxkAQPSfUYsDmL3g57ds3/4
         mG8Jsgpmc3RpfkWUta1uOUNezstG7ZmE11eP065HmNO5H9XjFzil9IVDs6plvXkosf+2
         Fu7gLUEC/1Clf2XyM+mmVF8mtmRWMpX2rdxgh93wLg7Nde1gomai+O0Vij9jJSrHfS8f
         m2rw==
X-Forwarded-Encrypted: i=1; AJvYcCUEyMpv3gfFAqwWSfaCvsMAeZiqwvZh8FjYJ2ysNAu0MjJSvY75s64kZraz0FkuPp7vI8NGS9AEy5Ssmps8@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhDFXUNTYxFXY6aBdNmgnIRdptNBM9hoKL6TWRoEv+BlsLdFb
	T5fknhF5aEybxLfsYpDPJZIehdNECIgYiFtQnXOu0f/aAkdSPW8Q3Rm1JEnH6gUvxZSXiOpW/78
	qTlTHF3oCFH4IGPuv1bn+sFA9j60y5NAW18i+59zsgQEUZzw/IQ4nC5O9EVH3gx2TZv0=
X-Gm-Gg: ASbGncsugbkccGslfXDKmcyVctbN/swuRmCZiLNu2T7Ch/MN4uXTlcXY2IjOma3ySSX
	tpXkQ1GrAYKsK8U9KHb6KgPUvVrbmje380Xcq/C+xQdZGYEGWRAtk+5WHLS+Dh+kHNeibv6N1A3
	VRxwEfwOqJWdoJPCJoEDUSq6VnW1slyr8/F4qdqD1lGiHQa8ovvvynD01m2UUOGmJv6G9171HYk
	VrMWwzwfbJLXKg6/Vspey2+rgpwgIJIKlBVZ26PEUN3EiM5cJENaKnyCkXUrRFg4/cqdw0vJqrl
	9zgYHJVejtts+Exauy1x21uwagWKwxhRojkEsi+hSWw/tYdcniqsLEe/vtE4pHe7DwgBBV+Jope
	MZEU3XDRAZ8yo/9/FTH7BiMmycFZJK4TBfVIuBLId8sNGQwRI2BbWdwyFVUIsupmuvkv1
X-Received: by 2002:a05:6000:22c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-40e4b85109emr2653257f8f.39.1758795937452;
        Thu, 25 Sep 2025 03:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMY43SbBeTDqux7xNDlX/ZIG3DX+wQZ2EsWj+CndB3u6o8VAseXEawq3c7JdiIGuveFjJLZA==
X-Received: by 2002:a05:6000:22c2:b0:3d0:b3cc:c1ff with SMTP id ffacd0b85a97d-40e4b85109emr2653200f8f.39.1758795936721;
        Thu, 25 Sep 2025 03:25:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e330d1d2fsm14556705e9.3.2025.09.25.03.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:25:36 -0700 (PDT)
Message-ID: <c8259ec7-e31d-4771-96f9-e2fb6b573e85@redhat.com>
Date: Thu, 25 Sep 2025 12:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/12] mm: introduce AS_NO_DIRECT_MAP
To: Patrick Roy <patrick.roy@campus.lmu.de>
Cc: Patrick Roy <roypat@amazon.co.uk>, pbonzini@redhat.com, corbet@lwn.net,
 maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, willy@infradead.org, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, song@kernel.org,
 jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 jannh@google.com, pfalcato@suse.de, shuah@kernel.org, seanjc@google.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, xmarcalx@amazon.co.uk,
 kalyazin@amazon.co.uk, jackabt@amazon.co.uk, derekmn@amazon.co.uk,
 tabba@google.com, ackerleytng@google.com
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
 <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 17:10, Patrick Roy wrote:
> From: Patrick Roy <roypat@amazon.co.uk>
> 
> Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
> set to not present . Currently, mappings that match this description are
> secretmem mappings (memfd_secret()). Later, some guest_memfd
> configurations will also fall into this category.
> 
> Reject this new type of mappings in all locations that currently reject
> secretmem mappings, on the assumption that if secretmem mappings are
> rejected somewhere, it is precisely because of an inability to deal with
> folios without direct map entries, and then make memfd_secret() use
> AS_NO_DIRECT_MAP on its address_space to drop its special
> vma_is_secretmem()/secretmem_mapping() checks.
> 
> This drops a optimization in gup_fast_folio_allowed() where
> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
> by default"), so the secretmem check did not actually end up elided in
> most cases anymore anyway.
> 
> Use a new flag instead of overloading AS_INACCESSIBLE (which is already
> set by guest_memfd) because not all guest_memfd mappings will end up
> being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
> can be mapped to userspace should also be GUP-able, and generally not
> have restrictions on who can access it).
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---

I enjoy seeing secretmem special-casing in common code go away.

[...]

>   
>   	/*
> @@ -2763,18 +2761,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>   		reject_file_backed = true;
>   
>   	/* We hold a folio reference, so we can safely access folio fields. */
> -
> -	/* secretmem folios are always order-0 folios. */
> -	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
> -		check_secretmem = true;
> -
> -	if (!reject_file_backed && !check_secretmem)
> -		return true;
> -

Losing that optimization is not too bad I guess.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


