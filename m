Return-Path: <linux-fsdevel+bounces-37824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C989F7FC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A9F1888120
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94626227574;
	Thu, 19 Dec 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyDK9Z5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26208226529
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625756; cv=none; b=mwXCfqsc1/kkUca2TiTWYv9UUZ+RCqnkjCFdbRJCvmfYWAsasdODwhNWnQvEkLXw2UZlaUCvqzJsoqKpPfN21cdw88VBDCWybip5LjivVA9f2tvDaA4IOmhFFKRSLqB+c7pJmgQ0yzsXt3uadXK3RiLkaxGjwL780YqHseaWvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625756; c=relaxed/simple;
	bh=BoH6UOqoxWV2Rvcz/7Jf4FN23hYTNn2jm9CUCXsa0rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuB4oH6Loz0slTYgzqkP3zTNnH+hnHJG01c64a5GZN5Y4CH36UlOHPH+BY4FHlX1aoomPtu7AQIyNWjgg9JZM+5rD1KVERV7PMuUcoK8e+Du2XEe0pXEOmZNyYFFnqRKR58sNF0WY2gPl6XxYvyG7b5n0+dwbRrmsappLiwJ0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyDK9Z5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734625753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wIHtTS4O0/SVjEnSdIzpMljXeiY8pPykNqCcAJo4M8U=;
	b=UyDK9Z5kg5He8/rPU9CQzt2k4/reUdcSQNOAXLoWmXEnR5+svq0YNYJxdsuEUtEWF45xyK
	v+I39gFuihMQrQ0byWbXtt1fhBPNa0939JrUJg0uw7ZLLUC+53ZIeOU7gudCGzas/MYZw0
	XXCK9RKiF4Ge7F2XmRw1QoudA46Hu4c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-LrQMSgMYP_qbPTIj3yuL2Q-1; Thu, 19 Dec 2024 11:29:12 -0500
X-MC-Unique: LrQMSgMYP_qbPTIj3yuL2Q-1
X-Mimecast-MFC-AGG-ID: LrQMSgMYP_qbPTIj3yuL2Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcae001fso496081f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 08:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734625751; x=1735230551;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIHtTS4O0/SVjEnSdIzpMljXeiY8pPykNqCcAJo4M8U=;
        b=qB3Ib/8M+NWxF7j97gbMZL+kmNnrkVPygVJSuBKo39j7VC9B377aYq6nR/MlBUOTMd
         2lu4sKha/Sys6k2UoqxzgBSlscLkx7uIYXOxulpZjNmXYJGrBEzDpOcAHwuEw6LflJEP
         wWez3EqwC/4c5y80FW5+0gSQPZib4XSyIqwoU+fTUPtqwX6HaHMoLD0/MFwlL37Q4hA0
         5Txv/NE2W3MvTDqin4JS1bDtOGf9PUqrpYEUAAsaU96OXgeb2wDtOYPZeiMZstg0d/Ui
         9OdFtc45IxxeGn4eRCOCkJSv0g91ITWjph+v5ooaNe/VD2P/DFC81BLGVJp4Wb7n4c5Q
         ShBw==
X-Forwarded-Encrypted: i=1; AJvYcCWYQSLpvxS2copCtG1mqZdXYg7yhRg1GYjrpWgOPGdNetF2XkJIBjtKiYUtllzF8btIyeboY000X6H54BQV@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAV95GreWA0egb/U3m+DaR6vEFY6cxBnniqqY6XzaLqWXqOmr
	IU1mNymbmkuMIGSsCK1sQZFprzp51U7wZFnyWskt8is/cMD20n3oNBuQyRQSSv66s1BTRS/oVaC
	nwgeTCk+UvYnThtsiwc7h9Ohu9QFFZCWvgSfyy/hNFOPbkaA/+NUstsOIbg8tsW4=
X-Gm-Gg: ASbGncsFRvKSwOFYrRln2m/Q3Il3G/ZkGh2ZO2+ARgSYJ4b6NABVdIphq9dYVYuNdaO
	2uaKzxCNl+Q49hSgUu1NZmWw/awJJRrj9F1S33+Sre3HB1Xe3zq6JfRCPp674fYGMBf7UlMvUOO
	3jeMkeeufWYb+4hsaSCM8KKpd9BIp07Utue++n+yesH2asGCaLb89NEkYDn/wwgSLGiWkFheG5O
	6JNh5D9BZfDw6nCK2T3nxd5HybR61Lphmht4uQTTXaBgwDhY/N+lVejj874zSM66uSaLoRsVmMC
	rTW1g2sXxPnhjn6TcmbZACymKh0VKV7v/r3TSIwX3I2T1Mj/Ky6BVEh6h7fQCrHmDtLxQ4Ju3Ig
	ue/gpRQ==
X-Received: by 2002:a5d:47cf:0:b0:385:dd10:215d with SMTP id ffacd0b85a97d-388e4d8e695mr7966471f8f.44.1734625750807;
        Thu, 19 Dec 2024 08:29:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiBd6jY3xIZYSbuHrrqWNL0IPXpXDuh8jP+ZSaLMd2VzEVygCtANIr/7QBGXmrLnUPl5ELlA==
X-Received: by 2002:a5d:47cf:0:b0:385:dd10:215d with SMTP id ffacd0b85a97d-388e4d8e695mr7966431f8f.44.1734625750394;
        Thu, 19 Dec 2024 08:29:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm55513135e9.41.2024.12.19.08.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:29:09 -0800 (PST)
Message-ID: <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
Date: Thu, 19 Dec 2024 17:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:22, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 10:55:10AM -0500, Zi Yan wrote:
>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>
>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>>> waits may get stuck.
>>>>>>>
>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>> ---
>>>>>>>     mm/migrate.c | 5 ++++-
>>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>> --- a/mm/migrate.c
>>>>>>> +++ b/mm/migrate.c
>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>     		 */
>>>>>>>     		switch (mode) {
>>>>>>>     		case MIGRATE_SYNC:
>>>>>>> -			break;
>>>>>>> +			if (!src->mapping ||
>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>> +				break;
>>>>>>> +			fallthrough;
>>>>>>>     		default:
>>>>>>>     			rc = -EBUSY;
>>>>>>>     			goto out;
>>>>>>
>>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
>>>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>>>
>>>>>> That sounds very bad.
>>>>>
>>>>> The page under writeback are already unmovable while they are under
>>>>> writeback. This patch is only making potentially unrelated tasks to
>>>>> synchronously wait on writeback completion for such pages which in worst
>>>>> case can be indefinite. This actually is solving an isolation issue on a
>>>>> multi-tenant machine.
>>>>>
>>>> Are you sure, because I read in the cover letter:
>>>>
>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
>>>> support writable mmap"))), a temp page is allocated for every dirty
>>>> page to be written back, the contents of the dirty page are copied over to
>>>> the temp page, and the temp page gets handed to the server to write back.
>>>> This is done so that writeback may be immediately cleared on the dirty
>>>> page,"
>>>>
>>>> Which to me means that they are immediately movable again?
>>>
>>> Oh sorry, my mistake, yes this will become an isolation issue with the
>>> removal of the temp page in-between which this series is doing. I think
>>> the tradeoff is between extra memory plus slow write performance versus
>>> temporary unmovable memory.
>>
>> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
>> temporary.
> 
> If you check the code just above this patch, this
> mapping_writeback_indeterminate() check only happen for pages under
> writeback which is a temp state. Anyways, fuse folios should not be
> unmovable for their lifetime but only while under writeback which is
> same for all fs.

But there, writeback is expected to be a temporary thing, not possibly: 
"AS_WRITEBACK_INDETERMINATE", that is a BIG difference.

I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA 
guarantees, and unfortunately, it sounds like this is the case here, 
unless I am missing something important.

-- 
Cheers,

David / dhildenb


