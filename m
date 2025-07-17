Return-Path: <linux-fsdevel+bounces-55216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A4DB0880A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139964A5460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904C27FD6E;
	Thu, 17 Jul 2025 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdGwb/2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B721CA00
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741585; cv=none; b=M5yWlvGNNROl6CcqVY4exeAd/mdJG4sYxfC+e1oC6dnUeLNjPDiJg2XeAdybdneZlVpW6XO11pYwPcySZpKsrJdBEObk3GB0g1sLzjSv0Kp50PLNXeOswtRx8WNsqZRs/bo8pnk6b7/FtbM22NhcGBeUutsBdymU4aHuyOxfOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741585; c=relaxed/simple;
	bh=vq7VTjNpvChS3YYqpzO5Fxpj7OOAkBxodFyKY042U+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3Um6zeGDe2BzSnvlq3u/sRIJikFnpJ4gqzp2Z868dw9fPCD+tFNIICxCQHRSx0WnEazoa58ugJ1fUCQg0ykxcQJrRM9UhqdPf8cBcjcQuIe9z4Pm1M39KT2BHMVdzH/BZwg2oglohD9RgNqV/+CUHtiiy9itJnpODgSEWhIV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdGwb/2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752741582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lj6lTZwQRiYuMovgfeEEcoQjPhNrRremaT5OpC4sqYE=;
	b=LdGwb/2RqiVWmCCeYjT4pypagODUdaWd9rZiv9Hoq5ph7o/ewaETgQK9TBdERJUnBACWHU
	I1+YsxMH9UCZ869zJTtU3tummRyqbBHv070BrneG3oNaeu5qH43t4z67mQ22cP5AMTHng/
	wx90fOWGYZHGSrmIXo2tevyOOgwBJmU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-LCTlyjLLNvCeCncxJBu5oA-1; Thu, 17 Jul 2025 04:39:41 -0400
X-MC-Unique: LCTlyjLLNvCeCncxJBu5oA-1
X-Mimecast-MFC-AGG-ID: LCTlyjLLNvCeCncxJBu5oA_1752741580
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so3363165e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 01:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752741580; x=1753346380;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lj6lTZwQRiYuMovgfeEEcoQjPhNrRremaT5OpC4sqYE=;
        b=r9sqFOKxVItoC+IUZJTQ+niFAOx6yZVj7OxNKAQYcizALSUReAho0OHpEQqaOE4iby
         WmDpSEry2SEQkRnOepkiigf8nz2feiQRY9EVrIJsWoqizE1dfaYWjm+pOBfwnT61FLEQ
         GnKDoOYcEDhUSA55O6LBF0DFmjsidm24ETK8V7EZlJFVYIMafNntCK0fyGxzBU9HqsA0
         QFHOf9Eg588ndwuI10FlIYxcBVb+51vhxZxi2bWa96mepT3LDtyIzGCFI0wzBay5qlCg
         gkUfkEaZ9VQB8wIjlG9I5AAnYBEaf2NYrCojDMnD36yEtYAwtPaTkBSr1OsQPLCfXzW/
         pSQw==
X-Forwarded-Encrypted: i=1; AJvYcCXK5mKHfTkFizTR/vtG815rvDJFvrsFytVMzjxYLMJxi0sy5JIg+stzaIIA7bKKO+re5yNWddoLgJlrkfbI@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAZ6dwdaYya6nTApKVSFxMLvG4btvHPL+88hoPG7YOoHZn9un
	EDO51pKxDRIRcQJ5HZ1d9ew7DL7lL3/9toHv10sM3G9N76baS/MJeAmk6IwfSjSXpLFazjcTAvJ
	q7iyxjbbDDGt2y1GDxnRpbGnYGGaq6FaQ074tfpDBJb3Lf+bEuRwqRJ02CLbKBYVGn6s=
X-Gm-Gg: ASbGncuB5w2ijgtkCa1rO7ENUx3lEq3Fy6sjNwDctt3+VeD1S5H0JdgvaNnJV+QHThs
	ydytqlv0OqyNuNdm+rkaYOJkuqzQfWK8NkxnsBrNHijbH/QReaotNnBMKHKf13otame/9eRhxBB
	VBphO6+orZi3q+Co3poZ8zkjrelP/copR5KzpgAvwGH+vqQL2DnIlJaWFGKFdUkOqgQLpbV4VIM
	BWI4syEjvGZR2jH8UDzOtTv7a6NXeE1OiQR9v7D92qIGBWG42Q7b5CaOlR0TDCsaRHpvN0CLqbR
	JeXTlC4V+md8mGelUz8tHL/CPaIWPyefH+kf03LmNnfrZ0Qg7w7rT4i+k4lHj9/PNJ0VI/sqFNf
	uPK7EnvdZIF6QPfTpwdS0ffiqbMO0oJrSkmuGFxdjkMiEOdqz3bPDmp6gacZqhcPn
X-Received: by 2002:a05:600c:a08c:b0:44b:eb56:1d48 with SMTP id 5b1f17b1804b1-4562e0320ddmr54640125e9.4.1752741579816;
        Thu, 17 Jul 2025 01:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7/rwYshbHQ4mXCqXe0VfAWZwFMFiHguIbQQ20+5zBL9J/LJ0Z7d+RZpnAtH09KGdgkC3Klg==
X-Received: by 2002:a05:600c:a08c:b0:44b:eb56:1d48 with SMTP id 5b1f17b1804b1-4562e0320ddmr54639715e9.4.1752741579349;
        Thu, 17 Jul 2025 01:39:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7? (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c313sm44617495e9.28.2025.07.17.01.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:39:38 -0700 (PDT)
Message-ID: <705fa84f-7a4a-4f74-82bf-5dff51149d94@redhat.com>
Date: Thu, 17 Jul 2025 10:39:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] fs/dax: use vmf_insert_folio_pmd() to insert the
 huge zero folio
To: Alistair Popple <apopple@nvidia.com>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250715132350.2448901-1-david@redhat.com>
 <20250715132350.2448901-5-david@redhat.com>
 <x32buctb6cdgr7kfwd54blmcqs6d3ixpsujx2qlde2cf6ziayu@mrltytvzg54p>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <x32buctb6cdgr7kfwd54blmcqs6d3ixpsujx2qlde2cf6ziayu@mrltytvzg54p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 10:38, Alistair Popple wrote:
> On Tue, Jul 15, 2025 at 03:23:45PM +0200, David Hildenbrand wrote:
>> Let's convert to vmf_insert_folio_pmd().
>>
>> There is a theoretical change in behavior: in the unlikely case there is
>> already something mapped, we'll now still call trace_dax_pmd_load_hole()
>> and return VM_FAULT_NOPAGE.
>>
>> Previously, we would have returned VM_FAULT_FALLBACK, and the caller
>> would have zapped the PMD to try a PTE fault.
>>
>> However, that behavior was different to other PTE+PMD faults, when there
>> would already be something mapped, and it's not even clear if it could
>> be triggered.
>>
>> Assuming the huge zero folio is already mapped, all good, no need to
>> fallback to PTEs.
>>
>> Assuming there is already a leaf page table ... the behavior would be
>> just like when trying to insert a PMD mapping a folio through
>> dax_fault_iter()->vmf_insert_folio_pmd().
>>
>> Assuming there is already something else mapped as PMD? It sounds like
>> a BUG, and the behavior would be just like when trying to insert a PMD
>> mapping a folio through dax_fault_iter()->vmf_insert_folio_pmd().
>>
>> So, it sounds reasonable to not handle huge zero folios differently
>> to inserting PMDs mapping folios when there already is something mapped.
> 
> Yeah, this all sounds reasonable and I was never able to hit this path with the
> RFC version of this series anyway. So I suspect it really is impossible to hit
> and therefore any change is theoretical.

Thanks for the review and test, Alistair!

-- 
Cheers,

David / dhildenb


