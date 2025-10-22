Return-Path: <linux-fsdevel+bounces-65214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB8BFE2E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4420D3A4CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E132F549F;
	Wed, 22 Oct 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ord2jXGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0F2EC0B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165263; cv=none; b=J6GnaCCC6lLzRrLaC0FBfVxLJ0dCbT11rfWxFh0vDI9lrowwQAIiJIwBXstPx804jp84p4ktbSo29fr8iQire59qVtE8G1WN2ax9NiuDLQW8ALLd+znC0tQnFfO77TfytWmT6qpSO04a1T33cke+YGNRnyCP+PJYoyQyG+LE+DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165263; c=relaxed/simple;
	bh=U/vDlQHXlM7yc6N12nvzWfUUTKAdNQyEHv1avd2LZJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLklsmaoUOaFQxUYN6O7UyG5ef613zJOap5VJfzVZ4WItTdzOTn03c7MJ1v2jyNbo/BDOaSI3K99JSaj2x/hkzbZY8fbjDn7kod7jA6eHjEydwxFMq0xk+0iMnF4Uayc2TRfSMDRtlGHD5iJYtSh9ZV8zPIIn2kT5E2bDL8gmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ord2jXGY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761165260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MCpIcRCuoZ+NFrE8wED3wBMc5noEyqWsY1apOXEuFwM=;
	b=Ord2jXGYLVSy7uah8Beh0CBT+LUe/1tUqT/docnZCV/XrBtXC+1pHze+YoIwZ1KH89DCM7
	rCrC3dYZqPq0GLhPBtWCWecGGoEwsmxID5fdq1Y5Kf8IeBumdEFW3Je6O9nkpHNvveFeAw
	r2n6CUbaOD+F0BjxBscaQMNYgxAIRSs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-a4XDFXJ7NUqgT779Duty2Q-1; Wed, 22 Oct 2025 16:34:19 -0400
X-MC-Unique: a4XDFXJ7NUqgT779Duty2Q-1
X-Mimecast-MFC-AGG-ID: a4XDFXJ7NUqgT779Duty2Q_1761165258
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-427015f63faso20272f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 13:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165258; x=1761770058;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCpIcRCuoZ+NFrE8wED3wBMc5noEyqWsY1apOXEuFwM=;
        b=Vxny4O3fJhObVv26uLBsuavReKcUHXkWrV5x+j8FPbC26YyqLwGXFFL1p9RynNg8X9
         5fx8gTQkhWj97XWSBzwb1G492m/xLDu1aMwlqXFppVWQN7FtprdlgqZAkvmp1b04fp+A
         TKBeCZJ2t1edrlpYNnBHmhgwpE5mr8R4ubmDM6dchZRCBJolPGUBJCeIY+7KnvcQLeK8
         iOXTNO3y+mfpw4c3tgVIZYtOmtjJWtJgmN6jvwJHWsY4ivZhHdfeBNz/CR/pHWWFXfy6
         q7yCijIlPsEYM7KxvYw3IWeHIQHEoXKJkeDKPfUH9bmARgkCj7qVOBvVlnlfTpFyUGcR
         7ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ8DVoxHbxleoSVkASyAmMzrW28YYcw5YmfM0GKb5noCByXt3fdgUiki5VcaIRUxVVpLgF4ttTAwqU80x/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6ld2QZWUf75umtq3Jq7eVmFDW+JB/cSmNm18LBRY/+4/nxvP
	JBph7tDqh7S7Gv/LJEsz03Jr8YZvhm2VdFSADZCyRbfNyAiSSza5IKzc1AiPMoT6cjdW6KfjISU
	yFrZ2kvFvT+XmdP0wUxOKZb4442JMiwxehpZUgamtwGDi1+/V80HmIpGG9woTMYocNgs=
X-Gm-Gg: ASbGncvB4bvujJ0TT8pOZixDMcLhtd+b3AYbiZ6mvUSi/nvqJc8fRkKRh6YJFQoVlke
	Zety+u2Y1akyFeTBG+opuJgxvHQ588Bpnzxd0x3nD7ZfsplaTYmfQS/EKKz3IHOM9mBWV9emoN0
	c4lERBzRZJANQ1iRU+T3+qRie9lGT4dtuUIEsPF8BtrZRinGhyNMNw9ihnCEFxVqTTR5OmiQks5
	yPSc6avVvcaugOVAWdULajfYM1Su1A//iYlIxHAj0ZsS4+nu7iYQP7lTdiYeVLLgm7ZX4NvtTbV
	FkiIa9cPwB4+vZ+mhgsgt7lF/pH4I6CdCDoukw8/dNi3ld7dvpVuDdTcuOIXCNnMdbv8Gg9mzd3
	c1MHPJHhIn4rYYLn3HAmzotycrJQUmsJIlDN4HrESRALgEtuPoPQMOY9ae5U0cLWWnQBkIK5ENn
	LrKx6u+dv/Wi91aLoXmwGC0OjuRhQ=
X-Received: by 2002:a5d:59af:0:b0:427:60d:c50d with SMTP id ffacd0b85a97d-427060dc758mr14291323f8f.51.1761165258045;
        Wed, 22 Oct 2025 13:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFp/PzvHA2ojeVgZuHJ7PIytIU8hDkikqIVC3bIAAJDppHWer8LxxL625PQtTJr0DIUqs+g==
X-Received: by 2002:a5d:59af:0:b0:427:60d:c50d with SMTP id ffacd0b85a97d-427060dc758mr14291305f8f.51.1761165257634;
        Wed, 22 Oct 2025 13:34:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e75absm322783f8f.7.2025.10.22.13.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:34:16 -0700 (PDT)
Message-ID: <3dfb5722-f81f-4712-af9a-9ea074fb792d@redhat.com>
Date: Wed, 22 Oct 2025 22:34:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm/huge_memory: preserve PG_has_hwpoisoned if a
 folio is split to >0 order
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, kernel@pankajraghav.com,
 akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-2-ziy@nvidia.com>
 <d3d05898-5530-4990-9d61-8268bd483765@redhat.com>
 <5BB612B6-3A9C-4CC4-AAAC-107E4DC6670E@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5BB612B6-3A9C-4CC4-AAAC-107E4DC6670E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 22:27, Zi Yan wrote:
> On 22 Oct 2025, at 16:09, David Hildenbrand wrote:
> 
>> On 22.10.25 05:35, Zi Yan wrote:
>>> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
>>> after-split folios containing pages with PG_hwpoisoned flag if the folio is
>>> split to >0 order folios. Scan all pages in a to-be-split folio to
>>> determine which after-split folios need the flag.
>>>
>>> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
>>> avoid the scan and set it on all after-split folios, but resulting false
>>> positive has undesirable negative impact. To remove false positive, caller
>>> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
>>> do the scan. That might be causing a hassle for current and future callers
>>> and more costly than doing the scan in the split code. More details are
>>> discussed in [1].
>>>
>>> It is OK that current implementation does not do this, because memory
>>> failure code always tries to split to order-0 folios and if a folio cannot
>>> be split to order-0, memory failure code either gives warnings or the split
>>> is not performed.
>>>
>>
>> We're losing PG_has_hwpoisoned for large folios, so likely this should be
>> a stable fix for splitting anything to an order > 0 ?
> 
> I was the borderline on this, because:
> 
> 1. before the hotfix, which prevents silently bumping target split order,
>     memory failure would give a warning when a folio is split to >0 order
>     folios. The warning is masking this issue.
> 2. after the hotfix, folios with PG_has_hwpoisoned will not be split
>     to >0 order folios since memory failure always wants to split a folio
>     to order 0 and a folio containing LBS folios will not be split, thus
>     without losing PG_has_hwpoisoned.
> 

I was rather wondering about something like

a) memory failure wants to split to some order (order-0?) but fails the 
split (e.g., raised reference). hwpoison is set.

b) Later, something else (truncation?) wants to split to order > 0 and 
loses the hwpoison bit.

Would that be possible?

> 
> I will add
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> and cc stable in the next version.

That would be better I think. But then you have to pull this patch out 
as well from this series, gah :)

-- 
Cheers

David / dhildenb


