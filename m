Return-Path: <linux-fsdevel+bounces-53796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A0AF745F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0924E232C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D312E6D35;
	Thu,  3 Jul 2025 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRi0kTtP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957A2E4256
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546379; cv=none; b=NkHDPzj6DU0GQ53PFH/h85VA6AOxDYkMaS+Xgc31XQ7abRTCvZHpH6miF/Y6oo+Tz3vO6K2ZmR5AifYaqFDjIefJdTmqAfInR3s9JsK6ThRbcyYF/PHxQUs7kW0RLT0jiBpq6FNUshiUhuv3UuEy6vey7Tjx6/aDjyU4vGECwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546379; c=relaxed/simple;
	bh=jZQnj2z/DOc1XgDzZQWNW56cMJAgY58Qfkyd+rsZzYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjHi7EZbbdvi4I8ZG6Z2ctN80aoTwvwNPnUG4cWotqC4qghuI8CaDMBQY7ApTJZZ7M68t03h+wpD1aQWRzIb0fVh4p/6BIVQgFAvF5xH/S65sAxL9uqWeMCIJ5FYj6dY0Hd3n4RNJAnJjpA1XhA66C2E+IT8R2LqKWf65qa8Kn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRi0kTtP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751546377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Oi7wV4GKMcMHM1v/VB7INbDIKNe9eVceq3H9f21UYs0=;
	b=BRi0kTtPBvLVhkDeCxTepU7O2/GIAVFZ1bBcJgOuvpEHmr/2MCTM1wfByg33MAZ7oiI1o+
	U/HX4XExWT6KBV6KakzEyRZbYFnBv17ejLyvIOoMgdWIViLbA/O8ktYUsB+fZ/3zhiYAq7
	/ts6kwxJP84w96kZkiNornH8wwprO4g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-1F4p1KRjMo-yh3RmctPbgw-1; Thu, 03 Jul 2025 08:39:35 -0400
X-MC-Unique: 1F4p1KRjMo-yh3RmctPbgw-1
X-Mimecast-MFC-AGG-ID: 1F4p1KRjMo-yh3RmctPbgw_1751546375
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ade81d27cddso775408666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546374; x=1752151174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oi7wV4GKMcMHM1v/VB7INbDIKNe9eVceq3H9f21UYs0=;
        b=F3i/N7GA90aZzzW4rvqnxkPLXYx9zi65cOYmR0ZHvK0f1VORbyfJ64XmeR40nUe94I
         RZtlWIMOviro3nm8AkEugoxhpWuFZym7g7IoxSBfjJEQIo2FcugkKGZrlH4+Si2wMr78
         32tWNQMwVi8Z0UORvLAIponDH+BsVeZAiZzmNFvfneXbSqXzNCOyActosHsyxTceMJXl
         wHzFnpv+HD+Qbrkctcm/dj+9fPlHdNje/Zb+g0OXGdM03T7ut8mttevQyceU9DQN4MJh
         0J5ezE/GTvqrHJVWdNzOscw9GgN7oeXDC5vVLZIMsYeLNoBQEhRywX/2aLXfWId04Ku+
         KrhA==
X-Forwarded-Encrypted: i=1; AJvYcCU2L8D1qzrsxc7O5kSCu6/r0RHwDxHng4q4XElRuwPajaW02uxHaK4tItmSVSJIzmuEphauTCA5FcSiVxeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfEVVwQBIPV/jqQkJ2LsgxnuhQTUaZZlfq+BFyr25IQMTyODO
	XpkV4MhchTZ7/Rx4g2tipe99ZjAtfxIBAAGM7eXIGBR64FnalNF4J/QNjUxABYmCBxpYGxeWc3B
	/dLmLFCXzqC5S12odOFsDo5s5CwhWsTam0YBjgdlWZP28zzxUhg4tTln3hY/AhgJn4HI=
X-Gm-Gg: ASbGncvPiqNQXEoB4foqvDoAKpDahhZDIioWi+wuvAulcFt46f85LzegB6xtBlPr/iJ
	yJjY9UQng+aceP4GWGDQ2oFJVC75o7oKxMOjmavw7P0tVGAlU9clERpdMXqB+VwVfYPEwm1rLOp
	ecu9DCyDkdCJHH83WV3L+ONGDq2ali86sm8mr1hF+z+u5GbUX5puxd97j5Nq2EnufyDbadD5hxf
	zlG48i7ecV7E33KAcYgn0MgelOPSg4j3ZHGQEyBXZzcFHPu2XxjQkAze6E6Mm0mzq3Du5pId0SQ
	OeSQIBwPxzR6EjBy6KPFT7q9nhccPUzgrcyqqGXGiPDf
X-Received: by 2002:a17:906:eecd:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3d8c9dcb1mr329383366b.29.1751546374402;
        Thu, 03 Jul 2025 05:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvAzLYe4u7bVgIF4rIZO0Kh3Dh5wNxg2vLubpdGWNR3UdIrBCXy0Ue3tb6YegI5ciU5tlGPQ==
X-Received: by 2002:a17:906:eecd:b0:ad8:9b5d:2c1e with SMTP id a640c23a62f3a-ae3d8c9dcb1mr329377766b.29.1751546373856;
        Thu, 03 Jul 2025 05:39:33 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c0136asm1283943666b.90.2025.07.03.05.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 05:39:33 -0700 (PDT)
Message-ID: <5e5e8d79-61b1-465d-ab5a-4fa82d401215@redhat.com>
Date: Thu, 3 Jul 2025 14:39:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity check
 in vm_normal_page()
To: Lance Yang <ioworker0@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-2-david@redhat.com>
 <aFVZCvOpIpBGAf9w@localhost.localdomain>
 <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
 <CABzRoyZtxBgJUZK4p0V1sPAqbNr=6S-aE1S68u8tKo=cZ2ELSw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABzRoyZtxBgJUZK4p0V1sPAqbNr=6S-aE1S68u8tKo=cZ2ELSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.07.25 14:34, Lance Yang wrote:
> On Mon, Jun 23, 2025 at 10:04 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.06.25 14:50, Oscar Salvador wrote:
>>> On Tue, Jun 17, 2025 at 05:43:32PM +0200, David Hildenbrand wrote:
>>>> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
>>>> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
>>>> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
>>>> readily available.
>>>>
>>>> Nowadays, this is the last remaining highest_memmap_pfn user, and this
>>>> sanity check is not really triggering ... frequently.
>>>>
>>>> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
>>>> simplify and get rid of highest_memmap_pfn. Checking for
>>>> pfn_to_online_page() might be even better, but it would not handle
>>>> ZONE_DEVICE properly.
>>>>
>>>> Do the same in vm_normal_page_pmd(), where we don't even report a
>>>> problem at all ...
>>>>
>>>> What might be better in the future is having a runtime option like
>>>> page-table-check to enable such checks dynamically on-demand. Something
>>>> for the future.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>
>> Hi Oscar,
>>
>>> I'm confused, I'm missing something here.
>>> Before this change we would return NULL if e.g: pfn > highest_memmap_pfn, but
>>> now we just print the warning and call pfn_to_page() anyway.
>>> AFAIK, pfn_to_page() doesn't return NULL?
>>
>> You're missing that vm_normal_page_pmd() was created as a copy from
>> vm_normal_page() [history of the sanity check above], but as we don't
>> have (and shouldn't have ...) print_bad_pmd(), we made the code look
>> like this would be something that can just happen.
>>
>> "
>> Do the same in vm_normal_page_pmd(), where we don't even report a
>> problem at all ...
>> "
>>
>> So we made something that should never happen a runtime sanity check
>> without ever reporting a problem ...
> 
> IIUC, the reasoning is that because this case should never happen, we can
> change the behavior from returning NULL to a "warn and continue" model?

Well, yes. Point is, that check should have never been copy-pasted that 
way, while dropping the actual warning :)

It's a sanity check for something that should never happen, turned into 
something that looks like it must be handled and would be valid to 
encounter.

-- 
Cheers,

David / dhildenb


