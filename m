Return-Path: <linux-fsdevel+bounces-68509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C544C5D9D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523573B2381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30927F017;
	Fri, 14 Nov 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJL5IbLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B5280CE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130620; cv=none; b=O4fwYNGuWqBRDhU8f+LFSc96cGgrNRlMn004m3Yi4fLF9Q7ZD189Ef0/de5L+TqhF1e+mILQ3qUoLV2dUfvIO5nDKF9CCcLQ/w91msAtvq/tbK2z81wzF4aFPiqBqEySxwB0CaBWtMsdXI6wZGFRe9fqWU3A8XUDpKibUldxOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130620; c=relaxed/simple;
	bh=NrQSe+YHFaILSt1usG1OxuD7n2r3JrDVsMAGZ4fX7jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9EckuIvaeQtbVH+8k5lz4XPNcXbRzENh36lx3rJH4T2jZbZmN4Ro5BGdhSMccqFOta6wsK0cYO1uva4TH/TZudbQXhdEzH1zK3XPFpRZCTVRRqdeLIDZlfa2DrN/4PHdJHoduBwpmxCXRSjw5tkZyp8EyCrcN+cGgNSLWxvSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJL5IbLS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64369269721so57411a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763130616; x=1763735416; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yz+WMFiipaC01O8j9YcIXObvaHmKlfTk+YmXdGTqyks=;
        b=kJL5IbLSMM9C0rEzD2yRMrItCK7Owwn1J9Y5R9WbnDOMKSDjTeX8S2rG+XNXRa+umi
         6gZHroIR5lBVIAe8JjIYk/i2jpZMYtGykUYSJWQqqT8IG8ABvw8SbKEOEIP6hLrA0r2a
         CYMK+WLEj6AnPv6p1+lCxObM7roGwdVaEcNyaNZguDffDZtMgy96p2udprAvmpT3p8xC
         lRjWaFkoA6Gm4csPwQp5YFZFRI2nNy6PEfWzzCt59otn85EKAGX4CEkCQ0yB3u+hHvcP
         FLE8AxACg8s+BUI2uFE/dLuLe3gYQeQ2wBJY3mUnRM8OlA9/nrxPXb7YpfsMM8+AuZcC
         9iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130616; x=1763735416;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz+WMFiipaC01O8j9YcIXObvaHmKlfTk+YmXdGTqyks=;
        b=nDKQOvzqfwTvlUuPAeL44r24DvJgTDKGn+cD1gwwy5fNw9WLF1K7dBTZv3l70ByFZH
         oW2xwLra44ADfh9UaKOFXbmdOITElUVHZpOJwEILvZd7VCFO5Ie2e9FTY2jqpQ3JIIRe
         +FJK6bJ0jEQalAuMIWiGW56H9Ccve+jx9szbTo+u9I5U0iNDymOgGQjqFXV5AkDaD+PT
         GH1989DbePsCh71uuw1VLR7sq7HxRQ+XEkl8gpnfnm6adLl5Tpr0sUzcv2hMK0xHZzLl
         Cn4K+zmoQpbljG6vipJ4deY6ERsuG8LKH5QhnLTYTql/2sQ9+cAMMNTWQ8891K70YRUy
         Wwuw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Kla5DOU62oAc6P/jfifBlhVQElOB3bN6HKzzLvwdxvt8O8Y3uGHTPfUF+Nbvk63u83J3x1lpFMe6HHcr@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjzGegW3EtvF0g+PyHi7S7bogSVH0cBm3b3ImSn97AU+Q7YyR
	wkX4j3XqR4634GDlu7vbDJ2yEgyN9w2+o7f8zLignxvWZysAJFk1x6zY
X-Gm-Gg: ASbGnctCtEyRy+5IQ/Pamf9pUKrZgWQP30aZQZl5RrwdcmZnSAzMpSlNCWFBnDWl1sO
	K7KcMg7hzedUybMuqBzYGlylDLXRtVdhAKpUKeU48EASU1iq9x4/9Vu+4nP7YafRXnp8Kxrwh6a
	OXMXVM9N4O7Pa5E2mdnPnn9u1+Z1uQV6m8CyUtzrkX00ljMe6FUj2v/5TOcTyQ/Z0d4GayBweMW
	Z2MVw0d5ye0FWgaCrB/JtdSNJDccD2f+BsGa3Uyu/kPE7wZIQnIhqtAiY7pD3JB4+z+1SwWCzTC
	PFWmn5it+M7hF48yosadS3hg4FPbGNCOGf69rBXFbWzTKuyZmRvq6/J8S5ntkT1ae//FOj//Szh
	7iaBK9/m34MfOqe+lqMCV7JAJAz30ZUsRuaSnegw5k+JGAIX8L/1+B/KhFouf0XLGjpBErl1aSt
	Vvv65zOEtP/bI6jw==
X-Google-Smtp-Source: AGHT+IGT/RfUNWsmHcB+r3CpNno/n/LlNeIgAZSoXZJT6aGDOVeKyT4BXR9FJnFcsKJHu+C8w1pVdg==
X-Received: by 2002:a17:907:849:b0:b72:598:2f32 with SMTP id a640c23a62f3a-b73678ed1d0mr308312666b.42.1763130616034;
        Fri, 14 Nov 2025 06:30:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd809fasm399704366b.45.2025.11.14.06.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Nov 2025 06:30:15 -0800 (PST)
Date: Fri, 14 Nov 2025 14:30:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>, willy@infradead.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251114143015.k46icn247a4azp7s@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <01FABE3A-AD4E-4A09-B971-C89503A848DF@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01FABE3A-AD4E-4A09-B971-C89503A848DF@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 14, 2025 at 07:43:38AM -0500, Zi Yan wrote:
>On 14 Nov 2025, at 3:49, David Hildenbrand (Red Hat) wrote:
>
[...]
>>> +
>>> +	if (new_order >= old_order)
>>> +		return -EINVAL;
>>> +
>>>   	if (folio_test_anon(folio)) {
>>>   		/* order-1 is not supported for anonymous THP. */
>>>   		VM_WARN_ONCE(warns && new_order == 1,
>>>   				"Cannot split to order-1 folio");
>>>   		if (new_order == 1)
>>>   			return false;
>>> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>> -		    !mapping_large_folio_support(folio->mapping)) {
>>> -			/*
>>> -			 * We can always split a folio down to a single page
>>> -			 * (new_order == 0) uniformly.
>>> -			 *
>>> -			 * For any other scenario
>>> -			 *   a) uniform split targeting a large folio
>>> -			 *      (new_order > 0)
>>> -			 *   b) any non-uniform split
>>> -			 * we must confirm that the file system supports large
>>> -			 * folios.
>>> -			 *
>>> -			 * Note that we might still have THPs in such
>>> -			 * mappings, which is created from khugepaged when
>>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>>> -			 * case, the mapping does not actually support large
>>> -			 * folios properly.
>>> -			 */
>>> +	} else {
>>> +		const struct address_space *mapping = NULL;
>>> +
>>> +		mapping = folio->mapping;
>>
>> const struct address_space *mapping = folio->mapping;
>>
>>> +
>>> +		/* Truncated ? */
>>> +		/*
>>> +		 * TODO: add support for large shmem folio in swap cache.
>>> +		 * When shmem is in swap cache, mapping is NULL and
>>> +		 * folio_test_swapcache() is true.
>>> +		 */
>>> +		if (!mapping)
>>> +			return false;
>>> +
>>> +		/*
>>> +		 * We have two types of split:
>>> +		 *
>>> +		 *   a) uniform split: split folio directly to new_order.
>>> +		 *   b) non-uniform split: create after-split folios with
>>> +		 *      orders from (old_order - 1) to new_order.
>>> +		 *
>>> +		 * For file system, we encodes it supported folio order in
>>> +		 * mapping->flags, which could be checked by
>>> +		 * mapping_folio_order_supported().
>>> +		 *
>>> +		 * With these knowledge, we can know whether folio support
>>> +		 * split to new_order by:
>>> +		 *
>>> +		 *   1. check new_order is supported first
>>> +		 *   2. check (old_order - 1) is supported if
>>> +		 *      SPLIT_TYPE_NON_UNIFORM
>>> +		 */
>>> +		if (!mapping_folio_order_supported(mapping, new_order)) {
>>> +			VM_WARN_ONCE(warns,
>>> +				"Cannot split file folio to unsupported order: %d", new_order);
>>
>> Is that really worth a VM_WARN_ONCE? We didn't have that previously IIUC, we would only return
>> -EINVAL.
>

Sorry for introducing this unpleasant affair.

Hope I can explain what I have done.

>No, and it causes undesired warning when LBS folio is enabled. I explicitly
>removed this warning one month ago in the LBS related patch[1].
>

Yes, I see you removal of a warning in [1].

While in the discussion in [2], you mentioned:

  Then, you might want to add a helper function mapping_folio_order_supported()
  instead and change the warning message below to "Cannot split file folio to
  unsupported order [%d, %d]", min_order, max_order (showing min/max order
  is optional since it kinda defeat the purpose of having the helper function).
  Of course, the comment needs to be changed.

I thought you agree to print a warning message here. So I am confused.

>It is so frustrating to see this part of patch. Wei has RB in the aforementioned
>patch and still add this warning blindly. I am not sure if Wei understands
>what he is doing, since he threw the idea to me and I told him to just
>move the code without changing the logic, but he insisted doing it in his
>own way and failed[2]. This retry is still wrong.
>

I think we are still discussing the problem and a patch maybe more convenient
to proceed. I didn't insist anything and actually I am looking forward your
option and always respect your insight. Never thought to offend you.

In discussion [2], you pointed out two concerns:

  1) new_order < min_order is meaning less if min_order is 0
  2) how to do the check if new_order is 0 for non-uniform split

For 1), you suggested to add mapping_folio_order_supported().
For 2), I come up an idea to check (old_order - 1) <= max_order. Originally,
we just check !max_order. I think this could cover it.

So I gather them together here to see whether it is suitable.

If I missed some part, hope you could let me know.

>Wei, please make sure you understand the code before sending any patch.
>
>[1] https://lore.kernel.org/linux-mm/20251017013630.139907-1-ziy@nvidia.com/
>[2] https://lore.kernel.org/linux-mm/20251114030301.hkestzrk534ik7q4@master/
>
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

