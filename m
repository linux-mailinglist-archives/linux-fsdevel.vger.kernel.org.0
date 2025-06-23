Return-Path: <linux-fsdevel+bounces-52578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226FAE45E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6FB1883FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8615665C;
	Mon, 23 Jun 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPAKZYjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8876410
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687450; cv=none; b=WakhbmGTgsC8IG3S/6BHSsB3gUWtjy0/3aRX/Jko5GQQFRBn3RshJuFW17gVyaE2lSt4Lms6WgPh9IQ8WY0qz7rDedkt7wqD92IJgXGULbeKxp8/1ndcY/G61VC2rEQGjRbwFmeIUKNRmd3vmrm3cgceJdNdjMrHwAHCrqOogt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687450; c=relaxed/simple;
	bh=X4Hd5ZWrXPSq1/1WLrzOgIiIZXd5j48jrptWBaZiW1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfUMM1jTw+AVazC9VVab328uU8CogwUYIvlNL4HkOnUgEMfWmobdZd9qhbtI/NOUkK2XFtFeg70MAxh4meVSiS+InZrjiUv0YIWInx+L8dyVR6CYjXLXOzu1bCdYYYpkFGe4k6ZurR94q2oMUqS9egH1u20kaD+9UDiFmjAr8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPAKZYjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750687447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KrBCINyJrvJ9eCzCevXV0ad1ST03SBH5k2o0Hivm01s=;
	b=RPAKZYjOLx/Vh4WZCsoHzhCpYOsRjJvuJ89NtXxIPVJMRS8rL1jjIiTGLBZP8Fqm5zCg5X
	SrwEUrHI2BNqocTzqx1OLLtzW+DTUBgShOrV9p/zMydlKsjkqLepzsR7VCoJRH09NPvAmA
	ezbU9yvUQDbHU0DgqCdT3jz6fF1CDtw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-L5kjrVixMtqTuTcKV5Lryg-1; Mon, 23 Jun 2025 10:04:06 -0400
X-MC-Unique: L5kjrVixMtqTuTcKV5Lryg-1
X-Mimecast-MFC-AGG-ID: L5kjrVixMtqTuTcKV5Lryg_1750687445
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so23353035e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 07:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687445; x=1751292245;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KrBCINyJrvJ9eCzCevXV0ad1ST03SBH5k2o0Hivm01s=;
        b=ruMsDHmoMJ7hTWpK+Zlln7k8OCoAhmCmBwbtxDwB8snVbnCTKvSY8UVruZ8yNcVQol
         L6AuhuWsFfuM47EMImPlYboqnzAO0eJk2dxZhIMgUqbYpSv9HVElwHzDqUkD/4jlgybE
         2WOZTUEXNKgD3o/xQpsD+k+n5sj1oRLtlqAiR7sSfs2+ZEz8NXLXbRwVJGGw2cKL3dEI
         cx3Ll1XAUBcsBFr0odhRwKsiEl8dKAqkFmB2pkXP+Inv2geffDGOTqqudIYzqBJNXnKR
         hAxwkBfKehn63G/NW5PyBDWjT37d0m6Hb2BgJTCGiBPQU89Fd/pAP/fZZyGB7LH5T9Gh
         Gqtg==
X-Forwarded-Encrypted: i=1; AJvYcCXZlhq7gwQz1ujCcAwaTNs6KC80nztihHymDCeKusFssXABI1JT/TfXgQvgoSWgYVXgdNhE6v98LPI+A2R0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/o4+9t0EFPya1FqzFZ0L898J4yYWzRn/riTm5xMHuJOVTVGRZ
	N9+WO7gtQMsTl/SqojadVlKNai+cJOyYuy7/gfzIk3HCyg39zE0BOqC86yUdfPjWzT76PaWOR2J
	0JEMg9ZaQ8irTytPJYrAMDIhYeY3AD3nP7swOXsyQKIqWM9HLVBIqFOFRsq9tMj3vVUs=
X-Gm-Gg: ASbGncu5dWZroiayvXl7qt9fMeX1B6TlOVESIGU+yD3dURq8WJmcJ4SiJWpw1vzpyHO
	OVrZkaDWiObT84fNvDeF0W68F2aWJbaTlfdhZbY2vEqqd6pqZQcQtYVYlsnE+UAAzQE2r0H/jSL
	JkpKS38Hf3i5x09SfFwG6cQUrALuJgmyrkMC2JbQL7y10Vm+Ub4r5U21MOe4uBK3dnjCgYfAoJR
	xn9s5Dbvonr9pdlZP+Cd5TZ0KgEKozHhiK0ljuindKVu1KONzQVfEzFSaTBpT/4Auc9IUd97GZX
	RW2fEcJ4R+h31+mQUwTotlzoUWZvvm7N07Zm8EWW4dYOIdvqDkUwUNFYOeUa/r0nsQG5sIKVm2E
	42G03g7qqg3eTcENdELVsVzHqvnsp3DlfZxfwcMzK2WdQSfbDXw==
X-Received: by 2002:a05:600c:4ec6:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-453659c5990mr113651085e9.13.1750687444796;
        Mon, 23 Jun 2025 07:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE95nNZ86PnFHeg7VNuUAm+n3H3UxcLPVNTcJDICuroThLIfwHolxnqvCNMi52XcHJ4LMneaQ==
X-Received: by 2002:a05:600c:4ec6:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-453659c5990mr113650125e9.13.1750687444093;
        Mon, 23 Jun 2025 07:04:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453755e7d1dsm29688075e9.10.2025.06.23.07.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:04:03 -0700 (PDT)
Message-ID: <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
Date: Mon, 23 Jun 2025 16:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity check
 in vm_normal_page()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFVZCvOpIpBGAf9w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 14:50, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:32PM +0200, David Hildenbrand wrote:
>> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
>> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
>> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
>> readily available.
>>
>> Nowadays, this is the last remaining highest_memmap_pfn user, and this
>> sanity check is not really triggering ... frequently.
>>
>> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
>> simplify and get rid of highest_memmap_pfn. Checking for
>> pfn_to_online_page() might be even better, but it would not handle
>> ZONE_DEVICE properly.
>>
>> Do the same in vm_normal_page_pmd(), where we don't even report a
>> problem at all ...
>>
>> What might be better in the future is having a runtime option like
>> page-table-check to enable such checks dynamically on-demand. Something
>> for the future.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 

Hi Oscar,

> I'm confused, I'm missing something here.
> Before this change we would return NULL if e.g: pfn > highest_memmap_pfn, but
> now we just print the warning and call pfn_to_page() anyway.
> AFAIK, pfn_to_page() doesn't return NULL?

You're missing that vm_normal_page_pmd() was created as a copy from 
vm_normal_page() [history of the sanity check above], but as we don't 
have (and shouldn't have ...) print_bad_pmd(), we made the code look 
like this would be something that can just happen.

"
Do the same in vm_normal_page_pmd(), where we don't even report a
problem at all ...
"

So we made something that should never happen a runtime sanity check 
without ever reporting a problem ...

-- 
Cheers,

David / dhildenb


