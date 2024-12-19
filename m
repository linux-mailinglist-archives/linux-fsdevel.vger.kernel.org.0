Return-Path: <linux-fsdevel+bounces-37808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE819F7E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D967A2D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50761226881;
	Thu, 19 Dec 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVuiGjVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA15FDA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623417; cv=none; b=GFi5yL9Jpyipv/XVp/om94zhd3oh/EU3euLghlDQk1XyXomqxQaiP0+MQRoyX42UaiSq0s+zjbw7hhxxYqgWCO4JnDinzI9KS0tkPXS0nv1tvEzmbwCticPxJCR7uHzOC+ogROJi+bsmxSsLaOlzL4Z8+aBxs7f4hnUYm+sKoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623417; c=relaxed/simple;
	bh=6BmfJ8/dUxwhxdsy8ZmMtNnvYWgVzYiFNR4yApjTh7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZwcpQzeEZ+aunTpgRAx+vpEPB/6dgs8oVZOCpT9dRuyprnScPpJMactW8xUZbD93tqRxA2u5ZFLIgsZ63CishyNKRGq9PbDNKIooQPVkqgToEscqa6E22n7dZU8uR0uuRZHC1v/zAirK4nuPrnBlWi8yTCjznOPLdY3MC0CvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVuiGjVb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734623415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3fE3M+asuk4ehrGOcmv5cXLOHvJiWY6eF+Pas/6OjQ8=;
	b=dVuiGjVbrUKSBA7UtstgWLrSba4XpNKjLmtQb+cTTWLPDszfY8B7AeZhcR0WbQOioR+FLK
	YXwqoVW0QIrnF/nbExfOx2CjQt167dQn4Q7AywefZ9IYLWa+UYQzPBa6qiYF6r41doiC6h
	yo8RT0B2FwOMkrnaly2s+BcGsKx5baM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-oPWoh45-PEKCnzVIt87B3Q-1; Thu, 19 Dec 2024 10:50:13 -0500
X-MC-Unique: oPWoh45-PEKCnzVIt87B3Q-1
X-Mimecast-MFC-AGG-ID: oPWoh45-PEKCnzVIt87B3Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so5824145e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 07:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623412; x=1735228212;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3fE3M+asuk4ehrGOcmv5cXLOHvJiWY6eF+Pas/6OjQ8=;
        b=FBH4kUEo5yF0upMnlPpfrV8HHNIs+tr+M145nT1xCZFIVTTEp7+rZdBquzLaI0GC4c
         cMVLVDckb4KYSax+maWeTWI5CSiEQuUTwEfGw10VT7bRhlUhLWt8Qi7/b7XCBfMXT6oK
         YzSGwr4E5j4aATVcj6dAoYV7V3y0l7Y/UaPKk3H5DoYtPvXxt3MWuAAtWfCNJWcLhOhT
         yt5h9JiaP4X63x0zA3n0lBRoLCyyy3Vnw/lBUeTA2p0z1GVRpftu1e3z20k63PZa9s//
         fmB7lIrFk/HWPKD9M4ZajFsoqpbJlUrKl2GnachNYRMU3mp7xjf2MzxKjscbd+5Al3ww
         tk7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIWtodg0ODpSbsyiE7brguQsHtRXHMfzFh2OenBjmbJt3mJCoq/AQBUdKFqCaHn9XrTtY0QeoF8V67Mmq0@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEdF/fHkLVzT2Do3U8Nex+jBmpazBxjQ4ns1dKsOeMwRS0Lky
	tSk5LYU1g6V5glbQlPzOkcghQQm47URFMDMhCvKD0MQfU48NZ0qkAxTByCOw/9GxX7r0blVo1JV
	gg+lF8gxXKLwOzZw9bYqG7ua8lrxF2NsgyECVQoBLhr7qjd6I78V2/MP2yAJarMw=
X-Gm-Gg: ASbGnctJr8sje1assV7s90DKecyHb73fZhUbOuR+N43gjgj+Ely6f7PsR1X0btEw1S8
	cUiQxPOUG4KHlxHqj0uthoVH/k8g09R8XpMcoMmLPJ/dRVeMI6ZRq2aHkHCRzrMMjG45J30qcIa
	+A1zXDVOvjtvPKHAB13ScAvfe9dC67X/goCV87xLM/FU+jkzozeX0y5UF6UxHw/RYOTwqMI39Au
	BaHG2ieC6IJvLwGiWGhuFfZXkag84sQrZtjB6a+UkyOmpLBMBdItrxnK/fcbJ9ocv3oW+v3R92G
	weKI3wi3UY34LFzXQw9PDoU9PFjSZx0Bg5eBo6+HePZVxacbGOscYLd66dxX4hq2M7E8j+2sx/3
	zd9W1pg==
X-Received: by 2002:a05:600c:314a:b0:434:fdaf:af2d with SMTP id 5b1f17b1804b1-4365c9ca4c9mr38342635e9.30.1734623412445;
        Thu, 19 Dec 2024 07:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7Foe7CxMJRcEUl//p+aYMCxZbhHxB2OFtrmCjQuB3z/SEYjBCEaxGdcwkFtdox5Ynq2GgCw==
X-Received: by 2002:a05:600c:314a:b0:434:fdaf:af2d with SMTP id 5b1f17b1804b1-4365c9ca4c9mr38342355e9.30.1734623412070;
        Thu, 19 Dec 2024 07:50:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b0145csm55403945e9.15.2024.12.19.07.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:50:11 -0800 (PST)
Message-ID: <49dc2ccc-888f-4e40-bad9-ba014381554e@redhat.com>
Date: Thu, 19 Dec 2024 16:50:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Zi Yan <ziy@nvidia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <485BC133-98F3-4E57-B459-A5C424428C0F@nvidia.com>
 <90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com>
 <b3df8b0a-fa19-425a-b703-cbe70b6abeda@redhat.com>
 <96EA65A5-EA67-4245-95DA-D0DAD7BE2E47@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <96EA65A5-EA67-4245-95DA-D0DAD7BE2E47@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 16:47, Zi Yan wrote:
> On 19 Dec 2024, at 10:39, David Hildenbrand wrote:
> 
>> On 19.12.24 16:08, Zi Yan wrote:
>>> On 19 Dec 2024, at 9:19, Zi Yan wrote:
>>>
>>>> On 19 Dec 2024, at 8:05, David Hildenbrand wrote:
>>>>
>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>> waits may get stuck.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>> ---
>>>>>>     mm/migrate.c | 5 ++++-
>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>     		 */
>>>>>>     		switch (mode) {
>>>>>>     		case MIGRATE_SYNC:
>>>>>> -			break;
>>>>>> +			if (!src->mapping ||
>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>> +				break;
>>>>>> +			fallthrough;
>>>>>>     		default:
>>>>>>     			rc = -EBUSY;
>>>>>>     			goto out;
>>>>>
>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>>
>>>>> That sounds very bad.
>>>>
>>>> Yeah, these writeback folios become unmovable. It makes memory fragmentation
>>>> unrecoverable. I do not know why AS_WRITEBACK_INDETERMINATE is allowed, since
>>>> it is essentially a forever pin to writeback folios. Why not introduce a
>>>> retry and timeout mechanism instead of waiting for the writeback forever?
>>>
>>> If there is no way around such indeterminate writebacks, to avoid fragment memory,
>>> these to-be-written-back folios should be migrated to a physically contiguous region. Either you have a preallocated region or get free pages from MIGRATE_UNMOVABLE.
>>
>> But at what point?
> 
> Before each writeback. And there should be a limit on the amount of unmovable
> pages they can allocate.

The question is if that is than still a performance win :) But yes, we 
can avoid another migration if we are already on allows-movable memory.

> 
>>
>> We surely don't want to make fuse consume only effectively-unmovable memory.
> 
> Yes, that is undesirable, but the folio under writeback cannot be migrated,
> since migration needs to wait until its finish.
Right, and currently that works by immediately marking the folio clean 
again (IIUC after reading the cover letter).

-- 
Cheers,

David / dhildenb


