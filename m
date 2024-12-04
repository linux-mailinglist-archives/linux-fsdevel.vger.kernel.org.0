Return-Path: <linux-fsdevel+bounces-36467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453349E3CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4EC162C86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6EE20A5E5;
	Wed,  4 Dec 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUC8MqXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D331B4157
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323050; cv=none; b=pcixP5Y3YXt0kpZ/EUKVF5YR6POzfDhkvxcSpXKR1yQeaAJh5RwadbIfKPF2XwJYhWS0ea6ETlVCOaugn9iLEIlbxPb6g7Iov8lO3DAOqavbn94qhZ/CLIlWKnDXPCXXZ+C6f8kt8bfC4aT8HIkO2Ztmb0qpPevvA67lpNMGL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323050; c=relaxed/simple;
	bh=3SqyHg7daZ2YQMBuoZ8coMXvUpftWz6rqs4g8R1PtoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=owfdAvvzsIjty+UPf3QF40iDk/GkH08JzXVC2uKZn2hoDXJynMYQJJqcxO0ChLmMzJ1PxMOGsxJoJ9UIPSnilKxmNoAKej8klpt+66hegO+46Qz5mWCT5JDk4hFbmUmAq1rAaK6GPQAwFqjC6FEl2doR0JcCQsMwPR00JtlWvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUC8MqXF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733323047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jL++m5MaC4zIhLb+2vKPATuiMZo5IqqEvKZaEX1Tzro=;
	b=WUC8MqXFuPeVy9un6KCtc//El4zXrwXCEHV29asC7BXPyMf9QMdHHGJziZrvEQrkb6L6/j
	ltIiK35l8FrXf88+ke/XMjUIHbTye3ZbmvbTEeZfmV+sDvUr8vN1VSO0VNR50V6NrVCa7E
	MJnxHbGmHeKVFHP8tw2oZpbV8O2J2M4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-9tZ1Q2rOOPyrgrKmZhOGMg-1; Wed, 04 Dec 2024 09:37:26 -0500
X-MC-Unique: 9tZ1Q2rOOPyrgrKmZhOGMg-1
X-Mimecast-MFC-AGG-ID: 9tZ1Q2rOOPyrgrKmZhOGMg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so442785f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323045; x=1733927845;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL++m5MaC4zIhLb+2vKPATuiMZo5IqqEvKZaEX1Tzro=;
        b=BHfOENa46qm6aYVqnRa+zofTE2ns77wfJr6EHoAOv8+7Bl6ZW7FIbJnyOljmgdXokW
         woVoWi0xw6oJVihhCMelf4isVCVH164n451un797uZIZvDOouYqUPPCQsWl1uUZr8wvg
         FOHNQdcCASB2X7p8DmwQnGQ98jL4CEo1g911xk4583Rm0bry2QOLDHHyW6/RLy/eDr2u
         DjsjfYBBI9MFo2fh/1q9zz6/sAQDjJquVKJmwpioGDsy0qpOSrU9y3/U4eJ7yojDVhkb
         rvuQUZbv6sD+h4ZhPrnWx36uVvv9WzGhmYiJRCDYQb3Nies0bLnlWgk3I1ZD4X3FBsBf
         jjag==
X-Forwarded-Encrypted: i=1; AJvYcCWPoUiIt4WgWM82yf/QEAzVwW7R/P+w0kBNEgNlGIfVOWUcToy4TtfteOZFvqfd+Phakimt65LeBYMmm852@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOrt8oriDE46C1V6bBo/EPMjhdC6nf4SvOLS0ftceljsBtio7
	13NQhjgKq2+l+fWgcB/NbMXu8ihfRwWATcDP6ac6wsq/gtVjCA/ysblQEDGXAPLW6UcfDfUO+rR
	YuUsS+qy0oimRK1YNkAFjEWm4H44hETlMK3L7vg9BSXDXGeP11rXh6XHXuV0fg/Q=
X-Gm-Gg: ASbGncuG3Zj42Frzmq9xj/oqVz/dvsqc1kPB6Ka/i9wdOGwjCl/fHCJXWh9Zi3PGv+M
	kOTGmF82qvrU81nUN6WO0jaRpGHYuYqERFEhi8KMALTFoKewzhTQ1bFYrh7rKtbgS+YOzgX9yGm
	sOC0FYY16/8wjXfv8Skqmz6MDgWFK1icACwr9G0ZGn2xlfcT4bUcFZ5S+WkUlaDT58XjoURV9AO
	2kJx/Wm0J7tuGt1Pl8C4pApNWQOJyYhzC9uDhwm9VyLRRWXRhgU9MUoWkLOlMDR6eMgf/pbwCgi
	JEUy402h/QgsRdkFTu4bGzG6cnjo0cCi9S2+uGvfnhPiRlpGXtCOYz2UfMztiH8k97DIulwNPTM
	4MA==
X-Received: by 2002:a5d:47a7:0:b0:382:4cc3:7def with SMTP id ffacd0b85a97d-385fd3c6740mr5604652f8f.7.1733323044997;
        Wed, 04 Dec 2024 06:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGZXGb0N9tF5tvibwhgEyE3HFKN2tjTYhTm/BNNt7auljLzlIocUwY+WOu1m1yGrQRroW4Qg==
X-Received: by 2002:a5d:47a7:0:b0:382:4cc3:7def with SMTP id ffacd0b85a97d-385fd3c6740mr5604620f8f.7.1733323044652;
        Wed, 04 Dec 2024 06:37:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df63255bsm15732775f8f.86.2024.12.04.06.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:37:23 -0800 (PST)
Message-ID: <f002188e-8990-4c72-ad84-966518279dce@redhat.com>
Date: Wed, 4 Dec 2024 15:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Wenchao Hao <haowenchao22@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
 <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
 <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e6199ca4-1f87-4ec5-b886-11482b082931@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.12.24 15:30, Wenchao Hao wrote:
> On 2024/12/3 22:17, David Hildenbrand wrote:
>> On 03.12.24 14:49, Wenchao Hao wrote:
>>> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
>>> each VMA, but it does not include large pages smaller than PMD size.
>>>
>>> This patch adds the statistics of anonymous huge pages allocated by
>>> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
>>> ---
>>>    fs/proc/task_mmu.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 38a5a3e9cba2..b655011627d8 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/vim 
>>> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>>            if (!folio_test_swapbacked(folio) && !dirty &&
>>>                !folio_test_dirty(folio))
>>>                mss->lazyfree += size;
>>> +
>>> +        /*
>>> +         * Count large pages smaller than PMD size to anonymous_thp
>>> +         */
>>> +        if (!compound && PageHead(page) && folio_order(folio))
>>> +            mss->anonymous_thp += folio_size(folio);
>>>        }
>>>          if (folio_test_ksm(folio))
>>
>>
>> I think we decided to leave this (and /proc/meminfo) be one of the last
>> interfaces where this is only concerned with PMD-sized ones:
>>
> 
> Could you explain why?
> 
> When analyzing the impact of mTHP on performance, we need to understand
> how many pages in the process are actually present as large pages.
> By comparing this value with the actual memory usage of the process,
> we can analyze the large page allocation success rate of the process,
> and further investigate the situation of khugepaged. If the actual
> proportion of large pages is low, the performance of the process may
> be affected, which could be directly reflected in the high number of
> TLB misses and page faults.
> 
> However, currently, only PMD-sized large pages are being counted,
> which is insufficient.

As Ryan said, we have scripts to analyze that. We did not come to a 
conclusion yet how to handle smaps stats differently -- and whether we 
want to at all.

> 
>> Documentation/admin-guide/mm/transhuge.rst:
>>
>> The number of PMD-sized anonymous transparent huge pages currently used by the
>> system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>> To identify what applications are using PMD-sized anonymous transparent huge
>> pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
>> fields for each mapping. (Note that AnonHugePages only applies to traditional
>> PMD-sized THP for historical reasons and should have been called
>> AnonHugePmdMapped).
>>
> 
> Maybe rename this field, then AnonHugePages contains huge page of mTHP?

It has the potential of breaking existing user space, which is why we 
didn't look into that yet.

AnonHugePmdMapped would be a lot cleaner, and could be added 
independently. It would be required as a first step.

-- 
Cheers,

David / dhildenb


