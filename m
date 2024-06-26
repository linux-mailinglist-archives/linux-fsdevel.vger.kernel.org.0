Return-Path: <linux-fsdevel+bounces-22461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84068917554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 02:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A001C217CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 00:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E60610C;
	Wed, 26 Jun 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcSvhmoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D88BEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362945; cv=none; b=FepM/111DZo4OZiCOQL4zVcRXCw/MophgRA1i4+aieMvxQxVJu34l4SFaaoemqTIA2JRhRPJ3RuWECycMjbWL4uQOsiltxpxWgRA/7863M8ln48WPs9UthD8Xi2sAuECAHXRUKe8BXA2CEGLy2JQxuZKGytBO583r/qhVvaP9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362945; c=relaxed/simple;
	bh=pdE+Pqyrk8O1N5KZQqCuSltwFfrXjzVvGuOfV6XKBb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYqoYfEXaRhYk+pqNXTOfElZh2tC/7ZpNjweG5H8uuTUkU7urp+0BHDfUSZECTq1nLmwCZaPbbI+s+oPsXGhG7qdWz5H37ItPGdCik99uB8en3vAyNIL5lRwd1vUQoC7utmGy3kIrJpF2O/vumoOm+Rg5fitBrWfsuibMzuGms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcSvhmoQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719362942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGPSlA7WTVcLRiVfQ9BUqSjtD+lQaK58jEJVntu2EIE=;
	b=BcSvhmoQaHIZmLybUejgEwVgwJG1t+DhKEiWw27/bwb7VZOEMTgNTKdCrCxtd1fx9PGVKQ
	76ZX/kfmbFGty0+0582bLvpf9K9lbsrppGekN9WzsYzyvp2jdQAeuiodPi3MCwIhcLcNVb
	6Qd9sesuAMaro8PN67Bu7GKsJAvovmk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-4i_rwwV3NJ-rP7Knr2UWCg-1; Tue, 25 Jun 2024 20:49:00 -0400
X-MC-Unique: 4i_rwwV3NJ-rP7Knr2UWCg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f70b2475e7so62170095ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 17:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719362939; x=1719967739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGPSlA7WTVcLRiVfQ9BUqSjtD+lQaK58jEJVntu2EIE=;
        b=JxeTG9sptaI4ELZgM+uhr4WM0ZhM8BH2Q2rX8Kxhon4t21Xj05tg0EWo/1Axrm0weQ
         lfeCeWMVS7i8za0CyY/220IGssmlcd5gEJ5ePyUEx2Dl985j+9TjNxeuzrnzuFbYvRU9
         Wd7L3hPhdakNU6g/AHs80Xr4Sk1WsBQdboaXFUSiy72rPSTbZElP+lKm1hIXXY+Rx/2Q
         AUSQos64DrVL28Cr2ydxvesDgF0PeZI/8dbTaMtPwlL0ft8osS9Dnfr4pbg/oD5xaNpR
         /Qwal72XBCMIfvuv/GoS3gEfoz3NxrXD8km8rACRC8FCgx5gaghG6strE4mlURwK01yP
         NjqA==
X-Gm-Message-State: AOJu0YztmD+KJJeB+w90hCs5H69G3/3S7/m/DKdKlHhc6H55VWMU+pI5
	ntCFm+jqmByfHCNmrgmBs54eo5/jvQG4VIF1omfO6CvcZ/ereerNEjYX/uqaTMbm7RzIMlMncyo
	e0JOJZwYmBuxfo7sQgCTBm7fiXc8TEy0r748mrcpO9ZaX+avIW1kDL3aCGXPbL+s=
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr101197295ad.64.1719362939553;
        Tue, 25 Jun 2024 17:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdg8L1rPqETXUNyvWsHJ8NhP8lyoUTGeklOMi0XsgVFGiLooDy8aAoPg4Ip478gQazWq2s7A==
X-Received: by 2002:a17:903:234f:b0:1fa:3428:53ba with SMTP id d9443c01a7336-1fa34285bb8mr101197015ad.64.1719362939087;
        Tue, 25 Jun 2024 17:48:59 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebabc62bsm87382095ad.253.2024.06.25.17.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:48:58 -0700 (PDT)
Message-ID: <d2e3e73f-16c1-4bc0-9e7c-52fcade1c2e1@redhat.com>
Date: Wed, 26 Jun 2024 10:48:52 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/readahead: Limit page cache size in
 page_cache_ra_order()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625090646.1194644-4-gshan@redhat.com>
 <6a8fa8aa-fb6f-485b-92b6-868a522bd7fc@redhat.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <6a8fa8aa-fb6f-485b-92b6-868a522bd7fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 4:45 AM, David Hildenbrand wrote:
> On 25.06.24 11:06, Gavin Shan wrote:
>> In page_cache_ra_order(), the maximal order of the page cache to be
>> allocated shouldn't be larger than MAX_PAGECACHE_ORDER. Otherwise,
>> it's possible the large page cache can't be supported by xarray when
>> the corresponding xarray entry is split.
>>
>> For example, HPAGE_PMD_ORDER is 13 on ARM64 when the base page size
>> is 64KB. The PMD-sized page cache can't be supported by xarray.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> Heh, you came up with this yourself concurrently :) so feel free to drop that.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

David, thanks for your follow-up and reviews. I will drop that tag in next respin :)

Thanks,
Gavin

>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/readahead.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/readahead.c b/mm/readahead.c
>> index c1b23989d9ca..817b2a352d78 100644
>> --- a/mm/readahead.c
>> +++ b/mm/readahead.c
>> @@ -503,11 +503,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
>>       limit = min(limit, index + ra->size - 1);
>> -    if (new_order < MAX_PAGECACHE_ORDER) {
>> +    if (new_order < MAX_PAGECACHE_ORDER)
>>           new_order += 2;
>> -        new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>> -        new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>> -    }
>> +
>> +    new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
>> +    new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>>       /* See comment in page_cache_ra_unbounded() */
>>       nofs = memalloc_nofs_save();
> 


