Return-Path: <linux-fsdevel+bounces-32656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE69AC93F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C6F1F21C7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF81AB51B;
	Wed, 23 Oct 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbxoYB/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9381AAE34
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683637; cv=none; b=gkFnXDuNRaAXgZw+GavRhUVrKqKjEy81X7SOnQmsMdLsAWaMo61zoplUBjUI/1L94ZoqNyX/PQIv2Ex9UqEoJc+DRqLshlx4ytj+dJEQqcf8Fz7CAXCme3iyk7yQymcHfwzDlOecEgqFEnnTRwNCFF5m/xyGZE+DkqHE0NIh0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683637; c=relaxed/simple;
	bh=fEOnguFHygIKR/U3GecTdW1r4rOPYveB7Tw2Q+TaJC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drQLQfnsMVrlN2bBIixldaFjrn0QMY0YHWd+Hal3YNQ4naIw3hiO4H+l+Mlp++nL+sPIaqRsbV0UALvLF34j40GCHa8o5MJlwtNewcbuY/ZuJgp/j2hlNMP6SABakScrZCOQ9VRl4K3UlVizQuI/Tpa86r2Iqywtq58nyyoFOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbxoYB/j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729683634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=00UCNvVaA8//wqC/c8pBb7Q5oEvjUZfwZTPKlOZTKjk=;
	b=dbxoYB/jIsehnWfniKq2YR6EWtHxpJvMoTonkCWj0wHxDdYaBMxfKOHXO/1kxC9PQsoKHu
	uJydXzgCQmvDhEyoQoInbh1KtSR/O5wB/QTkn2qlyYBlGJYkA0gwFQkshCdZiI/FVu+yvt
	lOf77oHo3dzhrfX66Is+QRdtIEYnlfY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-0qgfwRFZPV-25_htMxl67Q-1; Wed, 23 Oct 2024 07:40:32 -0400
X-MC-Unique: 0qgfwRFZPV-25_htMxl67Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d533a484aso387481f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 04:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683631; x=1730288431;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=00UCNvVaA8//wqC/c8pBb7Q5oEvjUZfwZTPKlOZTKjk=;
        b=nbCuyZJIIhCq3VExekZDrgb7W5qfI8zVnkggvGf4uDwFAEavqNXA62cxmwM2RngMwm
         P3YSLcfK8z+dEMgu7+Fof6TpNdqeg8G85KxvT7/Q9PYD5n7kfQWlsCBk4TcYWAwGj5eN
         YBpGl+DAnm51sxRg61h5tCAiXm4v5eoZF5wIYnXjeaWWs0Auron+21FFK+05G0MfzP1T
         kX8gj9UGK5BjbnjlVRaAk+Vl1Mm7yIgcVvAFGhY5T/y0avlMCnzg184+ukYZiM65ZMPH
         +5zEHCzslPGu0F8LMNf12s3bpQ+fadBMfykz2iAI06WJkJIs7mnWahbH/AOEWvwkcJ9z
         P6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVO12yXXGaqsNl2qJn5S4jNVCwgA2YwOO+hp6VRrgxDwMTPZ1UQvcUHDr9Qm0NZ07qKPniLLjpZd5QpxCc4@vger.kernel.org
X-Gm-Message-State: AOJu0YxBu2SLYYrYOlDzhQAKXVMLH7b9KbdKEEU29XOPHWeNzyJGtuxu
	K28bBohcxqwPKCtiuETwIbB2JPL4dHxkpgbBmfwoj/2/cLdDdEGgIPoaFg1ud49XrR/mwI8NBDH
	c01ARMJ9EtXRbIpSP7VtWMJf0y8iem4NjVpC/aY/mvwqOhQqmcOmrD9TFuGr+DwE=
X-Received: by 2002:a5d:4a4d:0:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-37ef129b361mr4100770f8f.16.1729683631044;
        Wed, 23 Oct 2024 04:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW/dkEjuTqFrwhQpZgX5jH8kZSNf0J+pFAwbbQ54WdTktIpiRwr9kETKI5k036+gyFSEmZNg==
X-Received: by 2002:a5d:4a4d:0:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-37ef129b361mr4100754f8f.16.1729683630543;
        Wed, 23 Oct 2024 04:40:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a44asm13874535e9.36.2024.10.23.04.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 04:40:30 -0700 (PDT)
Message-ID: <ea19ca6b-b521-4316-a918-2a7ff5e518d3@redhat.com>
Date: Wed, 23 Oct 2024 13:40:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/17] mm: let _folio_nr_pages overlay memcg_data in
 first tail page
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
References: <20240829165627.2256514-1-david@redhat.com>
 <20240829165627.2256514-5-david@redhat.com>
 <wi53ecg3o5eemp2hwy5sjbgoroulbmnbbbz6pub2ratbwrdhg3@pnhiy45qirr3>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <wi53ecg3o5eemp2hwy5sjbgoroulbmnbbbz6pub2ratbwrdhg3@pnhiy45qirr3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 13:38, Kirill A. Shutemov wrote:
> On Thu, Aug 29, 2024 at 06:56:07PM +0200, David Hildenbrand wrote:
>> Let's free up some more of the "unconditionally available on 64BIT"
>> space in order-1 folios by letting _folio_nr_pages overlay memcg_data in
>> the first tail page (second folio page). Consequently, we have the
>> optimization now whenever we have CONFIG_MEMCG, independent of 64BIT.
>>
>> We have to make sure that page->memcg on tail pages does not return
>> "surprises". page_memcg_check() already properly refuses PageTail().
>> Let's do that earlier in print_page_owner_memcg() to avoid printing
>> wrong "Slab cache page" information. No other code should touch that
>> field on tail pages of compound pages.
>>
>> Reset the "_nr_pages" to 0 when splitting folios, or when freeing them
>> back to the buddy (to avoid false page->memcg_data "bad page" reports).
>>
>> Note that in __split_huge_page(), folio_nr_pages() would stop working
>> already as soon as we start messing with the subpages.
>>
>> Most kernel configs should have at least CONFIG_MEMCG enabled, even if
>> disabled at runtime. 64byte "struct memmap" is what we usually have
>> on 64BIT.
>>
>> While at it, rename "_folio_nr_pages" to "_nr_pages".
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> BTW, have anybody evaluated how much (if anything) do we gain we a
> separate _nr_pages field in struct folio comparing to calculating it
> based on the order in _flags_1? Mask+shift should be pretty cheap.

I recall that Willy did, and it's mostly getting rid of a single 
instruction in loads of places.

$ git grep folio_nr_pages | wc -l
254


[my first intuition was also to just remove it, but this way seems easy 
to just maintain it for now]

-- 
Cheers,

David / dhildenb


