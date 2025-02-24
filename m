Return-Path: <linux-fsdevel+bounces-42508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0EA42E96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038423B3513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2593F19885F;
	Mon, 24 Feb 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hdnyjn5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D61F5FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431100; cv=none; b=S0k5ESGQoDJaEbp+3oXApj9oJQEOgDalqZ//gwPKW36k2f6LWKLqEw9WFtjL11Z+WEyxLfes5+I/8LjhJH++ZttzR6uSNKNzjXNZkJ26/XDt4syWNiWysdyEXz0vfQ9/2uItGEFk+zARbZ4i/uhpndNPvT8RGzFmGXfRapu8nPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431100; c=relaxed/simple;
	bh=ZYasGQtwKy5aDtcUtprn27uwmTlRPZr7Nec7kiJLWzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0H3R0Ce1hivCVLW88s7O5kSqtmTiUozKHMvYfzaqxOFHS2scmgP+DusrERfKGyKVWAlunVffrtVTkLTAMOL6EhU4+W06+Kz7IUbu59IzlDfih2BPYdexJ845BeY/u63M5WFnSvidRnsbmUGeEm84D81Q5758w78g7TRXpYoPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hdnyjn5K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G9uYUL0lJEpfTP/jqrCc2TxiFlGEyB8SF3wTaZs7RW8=;
	b=Hdnyjn5KAh3dDnrKhYhelTFWcGEl0aYHavqGt55GGk104qmZSTEy09nqREZTPpmsOHg8+M
	W6tw+M5zMi7WGHaOrKCEu1uF2y5b8O/Se8skuILm0z7q+rITHNpds35EbjHn4SjJWplLtw
	QkIyLCnUhGgWXGWRB+7mNbYFEPwmvE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bTT9NpIKNAK54M4NUA47ig-1; Mon, 24 Feb 2025 16:04:56 -0500
X-MC-Unique: bTT9NpIKNAK54M4NUA47ig-1
X-Mimecast-MFC-AGG-ID: bTT9NpIKNAK54M4NUA47ig_1740431095
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f45a86efdso2520511f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431095; x=1741035895;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G9uYUL0lJEpfTP/jqrCc2TxiFlGEyB8SF3wTaZs7RW8=;
        b=ux4MRqJJ0ibZ5n1IrFEOh1Ayh3PnX35gKeNxOxLL/j2ZCdRD/hKrBV4Yaqie9BL3EF
         nBl7qqjRlvl3FEOPh5m7PDXEZieQw/xn1bMj3KPUwnAD5kHYf2fkpskqzkEzOvS2Z97x
         p2Ok8gvLT+zFZG/XQoLTAfQy/ufPSGVErdxBJt/5PgGm6S3clAOCtqfVFtVVlDnmYiCs
         EdEMZ62qy1R8Of9fGm+F1xha0qb8+zS30Z20g8pYzLVkTkvw2+b3e4TJcDF8S5dT4G43
         SuBNj2UgfmrMew328mCcdnFZEaVu6MXmh8/paPgbIIaDP1SELLVqzG+3LfS7Ecgxahuc
         fqjw==
X-Forwarded-Encrypted: i=1; AJvYcCU87QTBi9SC13RwfvFqhY4CGSdsJWt4TjgNzkmHu724t555X7NZS1SLyNCayCAzir3zF1+V/gTgUqJMjdYq@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcZMeQtMwYEejKMdbnsQLaBLhQBh1b/NVWe+fiYPWqYrQnuIc
	s9WyVrspySAf7sw1GcE4Ttfe+YizgzWXtBFo46osc74FK3DGrPz/1yC43wfOkAfWWd0RpPhBoJ3
	z4svE5FhBfCxy2/a2Cndvw5pM0jt7UBawvhHPKa6ZzkU68+VDBaia4Ho5m4VSXeA=
X-Gm-Gg: ASbGnctrJPhXPJVDlJJ2IHYRK8am5Qd6pnV83Vkm9JZOxNBbo3i/K26+mwbcUswhBEi
	3jLEHN9073g8CmI6+ZNCzbCGrnRQjRudpJnmHET/NPg3tEx7mlMfxKhiy/In7h64W3YyBY/fqZr
	PTwAfcgcsrSG7vqJX6OH9hUkpykJ7SCywGnV/0k2Gy9dF7dDDSgs84OdNpo7wm6DSit24t9fypV
	XetJXPj6Pfl7fUGTWhjKAHmN7lW/I/V7SBxmGX7Y8K/bjB/oXgJX4JnmlkvM7BfvDlR8gp2+13J
	kqz8GwHa8YiJtBwr84R10ilAxP4vN96k7UicvTHmpU5Bur727tQ259cKk23DYzNJPkR6ofTHDD5
	6yFo30kktBDr54WUxy4jWR4736Qxu7leHA9JH/VR+6T4=
X-Received: by 2002:a05:6000:4026:b0:38f:277a:4ecb with SMTP id ffacd0b85a97d-38f6e74f4b7mr12727160f8f.2.1740431095342;
        Mon, 24 Feb 2025 13:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe06nX7iFsBC61rd58f1qQXgBlzAj+Cm5rmfwjdF2Zq8d7qwhUsqzdKqy2LGpxicuLB9NP9w==
X-Received: by 2002:a05:6000:4026:b0:38f:277a:4ecb with SMTP id ffacd0b85a97d-38f6e74f4b7mr12727146f8f.2.1740431094951;
        Mon, 24 Feb 2025 13:04:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd91093dsm100642f8f.101.2025.02.24.13.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:04:54 -0800 (PST)
Message-ID: <a84a78bc-2446-4678-b8fb-fa9b37695355@redhat.com>
Date: Mon, 24 Feb 2025 22:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] fs/proc/task_mmu: remove per-page mapcount
 dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
To: Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 owner-linux-mm@kvack.org
References: <20250224165603.1434404-1-david@redhat.com>
 <20250224165603.1434404-19-david@redhat.com>
 <D80YXDU2A6IE.S4PQYSOT0PYI@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D80YXDU2A6IE.S4PQYSOT0PYI@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 21:45, Zi Yan wrote:
> On Mon Feb 24, 2025 at 11:56 AM EST, David Hildenbrand wrote:
>> Let's implement an alternative when per-page mapcounts in large folios are
>> no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.
>>
>> For calculating "mapmax", we now use the average per-page mapcount in
>> a large folio instead of the per-page mapcount.
>>
>> For hugetlb folios and folios that are not partially mapped into MMs,
>> there is no change.
>>
>> Likely, this change will not matter much in practice, and an alternative
>> might be to simple remove this stat with CONFIG_NO_PAGE_MAPCOUNT.
>> However, there might be value to it, so let's keep it like that and
>> document the behavior.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/filesystems/proc.rst | 5 +++++
>>   fs/proc/task_mmu.c                 | 7 ++++++-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>> index 09f0aed5a08ba..1aa190017f796 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -686,6 +686,11 @@ Where:
>>   node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
>>   size, in KB, that is backing the mapping up.
>>   
>> +Note that some kernel configurations do not track the precise number of times
>> +a page part of a larger allocation (e.g., THP) is mapped. In these
>> +configurations, "mapmax" might corresponds to the average number of mappings
>> +per page in such a larger allocation instead.
>> +
>>   1.2 Kernel data
>>   ---------------
>>   
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 80839bbf9657f..d7ee842367f0f 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -2862,7 +2862,12 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
>>   			unsigned long nr_pages)
>>   {
>>   	struct folio *folio = page_folio(page);
>> -	int count = folio_precise_page_mapcount(folio, page);
>> +	int count;
>> +
>> +	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
>> +		count = folio_precise_page_mapcount(folio, page);
>> +	else
>> +		count = min_t(int, folio_average_page_mapcount(folio), 1);
> 
> s/min/max ?

Indeed, thanks!

> 
> Otherwise, count is at most 1. Anyway, if you change
> folio_average_page_mapcount() as I indicated in patch 16, this
> will become count = folio_average_page_mapcount(folio).

No, the average should not be 1 just because a single subpage is mapped.

-- 
Cheers,

David / dhildenb


