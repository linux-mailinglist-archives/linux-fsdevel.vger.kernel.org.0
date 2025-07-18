Return-Path: <linux-fsdevel+bounces-55420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BB1B0A14B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F231C80FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85D2C08AB;
	Fri, 18 Jul 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsxZeLdO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4C2BDC19
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836086; cv=none; b=ixUS0vM4B+XZ8dKvDItKjO8XRUyRetlYlsu5uqalWRcykhwomAmHkmkZ949xedWeEO/QUtBjBjCxIIRNEVnWWS3tjX+Zzix5+pSnCcOdAE6h/KEHQi8OK3mrbtfGBFuydfxPNVAp2NTT6mSEONq56Ge5/NW031CkIHxv25gRhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836086; c=relaxed/simple;
	bh=ZltwojAv5GzbN5YtxsdTjQIwBJAYp6Aq3EjSTXkL9Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF4uVQvo2R68a5UlEwqM4ZS/gDxgBWjUD7ZuwjZ+ZWYPiqarO+6bS3Qqq6Ti2GeT2woKvykymSqOGvSAycPa6Mbv6wLTPskPudqfYHnjRawGDgAy5a++2SoJvsJPIYe9kiI5YxeTMt4d6xjorx/9YijQlgzPK6zfW7ahTywxoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsxZeLdO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752836083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9x+6SNZ1rUKJhJRi0vlqrQwvBIRb+ESC1w/j4s3Egps=;
	b=UsxZeLdO9oSjDAlxPuDdH8yl32QLLuebbx9TRpKTZE0uGxmSG85wDv1ehjQpil4req4kkM
	+tXPJkCvTFSChy3pV678zS5tGD/K3IEHLPG4AwmKRd5Jp+0VmKlKqp3DIBh12KeP07Nh07
	xsjCRuTKARwoHI1Vm5alTGctdWQqXi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-vz_IspmLP12i75azc4G-kA-1; Fri, 18 Jul 2025 06:54:42 -0400
X-MC-Unique: vz_IspmLP12i75azc4G-kA-1
X-Mimecast-MFC-AGG-ID: vz_IspmLP12i75azc4G-kA_1752836081
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so9992415e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 03:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836081; x=1753440881;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9x+6SNZ1rUKJhJRi0vlqrQwvBIRb+ESC1w/j4s3Egps=;
        b=qW1ITcSy99WgU0iGcRiSS+/araZiF0x6W+tyxHwYKT8cCgBfFI+/vF8yU/4GZ3uKTu
         o1lo3R3Zw6c6E4k62fAvtUzIR1pk6cvDPYwVV+LnAetP4i+NstKk413wplRyV/ElWlrR
         RNgJYQqXdGAkBl++Mr3bAFrm/wgwV7ztf/J/p+/VoHop1KR+4pQh/RSQ7LlIbX/CIC1u
         AX6vD7N/5aecjrAnhHasSTjj8vZOZffO+LWWS5/OKRoQ1xdF3ThfUPPuYFECQnNLUaUx
         JDLfwyz/+zkqYh7Iwun0eifjNRG6BO+LrZ5kC5ivJQ+glQaBm6DoYglRbNNxXlsRNuG1
         xTGw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2ScWiTHgrcGV9VBFF4FoyZiNIb7A/UufkD7jYVL7Ov8mpNoYkV8ZuetseKi+bXuSd+FuFwf4SviU6rJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sza+avG408jp1IOmkWghepZXmWXkY9xNplKlF1nQUEUjcyvi
	HvQFUB7zwURiTra3GRRioOIxp+L1pSHlO51J2U2rse48UdgqmLwHD9Eyk4WG8K0+cwtaGAsO/gC
	oJ8NnVhvCyFP2PMf8G4VAd76HvuaNc7oCrjAVHKBKkQq1ZsI51kZ6oQClvn/yj7jC9L4=
X-Gm-Gg: ASbGncvLkSz5vELmqbmmIva+A97H0ffCdLGVYlVDQFbRuBaXaFx7dM2eoJHP/6Rm0bG
	wVeXBMk6XHEsrQVfGSFRj+btBbzcQU0tMsG1zLt64YMpTHc7vFYU3d23ZHRjer2T3ZW+8us/Onf
	0dKq7jPPgbE/x0dqiPkog0BAOqSMi3xdoxKG3pK78OJaEF7dq0PxE56ERlg/rqnruKmbGQGQHJv
	gG6KW1tALCVM5crKdyqwcevSMiMoriS5OoYF4aEZKL0w+Syz8a96YYjmb/3ThSaSaDGpjmfjLD0
	aebAS1SQbJ3GKSiJPGejvD7AIjuG0KUrZCixiObprvCiX+CuSOxkHCD6LK1lME6F7wj/B2oab6e
	kWQ6zwULf0ffwOfZmBWtpRPV+Q56PA3/l15la6n8OFnOTVRmpHT9Jp28Ks6uxZ7TeuuU=
X-Received: by 2002:a05:600c:4e4a:b0:456:1f89:2483 with SMTP id 5b1f17b1804b1-4562e391fa5mr84761405e9.26.1752836081022;
        Fri, 18 Jul 2025 03:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjQqxYszJ86M7j2Ywj9XErK7h/2M4wutBxbbGwenrhGaPC0WvCUT5o+u11Z+VyIFbNK+nV8Q==
X-Received: by 2002:a05:600c:4e4a:b0:456:1f89:2483 with SMTP id 5b1f17b1804b1-4562e391fa5mr84760905e9.26.1752836080442;
        Fri, 18 Jul 2025 03:54:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886104sm76981725e9.25.2025.07.18.03.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 03:54:39 -0700 (PDT)
Message-ID: <8292201e-0ca2-4a2a-b2a7-02391cbf7556@redhat.com>
Date: Fri, 18 Jul 2025 12:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge zero
 folio special
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-6-david@redhat.com>
 <46c9a90c-46b8-4136-9890-b9b2b97ee1bb@lucifer.local>
 <7701f2e8-ae17-4367-b260-925d1d3cd4df@redhat.com>
 <9184274d-2ae8-4949-a864-79693308bf56@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9184274d-2ae8-4949-a864-79693308bf56@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 12:41, Lorenzo Stoakes wrote:
> On Thu, Jul 17, 2025 at 10:31:28PM +0200, David Hildenbrand wrote:
>> On 17.07.25 20:29, Lorenzo Stoakes wrote:
>>> On Thu, Jul 17, 2025 at 01:52:08PM +0200, David Hildenbrand wrote:
>>>> The huge zero folio is refcounted (+mapcounted -- is that a word?)
>>>> differently than "normal" folios, similarly (but different) to the ordinary
>>>> shared zeropage.
>>>
>>> Yeah, I sort of wonder if we shouldn't just _not_ do any of that with zero
>>> pages?
>>
>> I wish we could get rid of the weird refcounting of the huge zero folio and
>> get rid of the shrinker. But as long as the shrinker exists, I'm afraid that
>> weird per-process refcounting must stay.
> 
> Does this change of yours cause any issue with it? I mean now nothing can grab
> this page using vm_normal_page_pmd(), so it won't be able to manipulate
> refcounts.

Please look again at vm_normal_page_pmd(): we have a manual 
huge_zero_pfn() check in there! There is no change in behavior. :)

It's not obvious from the diff below. But huge zero folio was considered 
special before this change, just not marked accordingly.

>>
>>>
>>>>
>>>> For this reason, we special-case these pages in
>>>> vm_normal_page*/vm_normal_folio*, and only allow selected callers to
>>>> still use them (e.g., GUP can still take a reference on them).
>>>>
>>>> vm_normal_page_pmd() already filters out the huge zero folio. However,
>>>> so far we are not marking it as special like we do with the ordinary
>>>> shared zeropage. Let's mark it as special, so we can further refactor
>>>> vm_normal_page_pmd() and vm_normal_page().
>>>>
>>>> While at it, update the doc regarding the shared zero folios.
>>>
>>> Hmm I wonder how this will interact with the static PMD series at [0]?
>>
>> No, it shouldn't.
> 
> I'm always nervous about these kinds of things :)
> 
> I'm assuming the reference/map counting will still work properly with the static
> page?

Let me stress again: no change in behavior besides setting the special 
flag in this patch. Return value of vm_normal_page_pmd() is not changed.

>>>
>>> Also, that series was (though I reviewed against it) moving stuff that
>>> references the huge zero folio out of there, but also generally allows
>>> access and mapping of this folio via largest_zero_folio() so not only via
>>> insert_pmd().
>>>
>>> So we're going to end up with mappings of this that are not marked special
>>> that are potentially going to have refcount/mapcount manipulation that
>>> contradict what you're doing here perhaps?
>>
>> I don't think so. It's just like having the existing static (small) shared
>> zeropage where the same rules about refcounting+mapcounting apply.
> 
> It feels like all this is a mess... am I missing something that would make it
> all make sense?

Let me clarify:

The small zeropage is never refcounted+mapcounted when mapped into page 
tables.

The huge zero folio is never refcounted+mapcounted when mapped into page 
tables EXCEPT it is refcounted in a weird different when first mapped 
into a process.

The whole reason is the shrinker. I don't like it, but there was a 
reason it was added. Maybe that reason no longer exists, but that's 
nothing that this patch series is concerned with, really. :)

-- 
Cheers,

David / dhildenb


