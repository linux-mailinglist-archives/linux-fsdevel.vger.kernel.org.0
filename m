Return-Path: <linux-fsdevel+bounces-37825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54C9F7FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9F27A1B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5778226182;
	Thu, 19 Dec 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt4a3jDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49A86345
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625884; cv=none; b=cdBFquYdPL13sB7Ro+xi19ymZ08QraGEPvGZYlnJa9ivLdf55gqMw9aJaq/4PPUH+2O/TN2vfddQHkTG5h4N2NWsuDa83lU8VKzYRIoy7e7rc2QUN2PnPeGk3Y08VTCkYjqTJ43DNconcgSO4o8f4597DLl366NMkiKLQAvczgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625884; c=relaxed/simple;
	bh=TKLXk2QQJwrzpinDm9R+0cvl7/fSdaH8utwfFibJ0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH183+4XpzQKCtOG3IUmTTVodHJWSv5gEtJLdj6TbiTrkYJvUmFyCG9Ol07fRRZR+Lvq/ggbjPCRiaf3X2C0jRX4ArYyYp7ASBBOrrWqDyB1mG8D4/TYLxVaY3bxFQgwuEvXlGPKJkFVDvzWQ7JbhA3OWLXJSoeiw6oGvqLERPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kt4a3jDm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734625881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=17ik6LxZEcy8+yRyouwf1xyDz+INnAX0PQox0iBV/TQ=;
	b=Kt4a3jDmiOoII/aZ9OdfLsZHAcujHiV0sn410V2mzPkDe00vJIHfC1DITDpG3ez+vNEcdk
	iE9LzQFpNHBNnBPsxtjZDqD5DrBeEKG91BHU4hQSQByfEBvRnK5WzC/58zEcZVcolqfAzQ
	l7/fPo8ZvYMEsCoCMQsxIW3VQkamlpU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-dOnrKRnjMb6_KCeXrwDgOw-1; Thu, 19 Dec 2024 11:31:20 -0500
X-MC-Unique: dOnrKRnjMb6_KCeXrwDgOw-1
X-Mimecast-MFC-AGG-ID: dOnrKRnjMb6_KCeXrwDgOw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43626224274so6211225e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 08:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734625879; x=1735230679;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=17ik6LxZEcy8+yRyouwf1xyDz+INnAX0PQox0iBV/TQ=;
        b=rmek/vMV8UXZxyRs1yBSAWvHdTb+0cXBew2n+HKq5xN4Fqx81W64Z/EPV132A0uJen
         hIrgWGW1DH8462zW7dFjp9z6t2c1J/IvENih38XlFEHzccPSKThKENULDk1dxUs+B3bd
         vM0sdgvCwzNIq+HOib8Sb7OFsqIC5IsK8vIITtm5es5lnae33WjNOpLZ5AMQs/+QvkyJ
         TVzXwfQBLskCZKGFdc/154RZXd9prZLEpiFqCi+BfM/fcPu0SaYbgn6XSwbJaquAZJnd
         +s8+dsDmBPt2/wxt9F3o0H2Pg20ukC9cWgfZbPRl1L7tvZUfq1rew6iLaf+U2g7TC8uo
         ft7A==
X-Forwarded-Encrypted: i=1; AJvYcCXVbg9nqtsKORyWKBX5BbQGviQiQrRSkRnZWRWuYVpu2VQLfQDAUKl2m8YgQUCcikKJ9DTt/l4VseIrZvpD@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDJZRWgEoTLdjYnXDzWPyUlyeQBvk9doSGDHZ611/l6gI1TEw
	f0GgvQZJFkIYxWTGGO5bXITW9xnBpSeYqnZds1IBJy4+f8qEZCOhEG2dohoz7rkowI2MecKRZic
	waz56m3XzotDtKgjfYfCcB7H7rNZ21q1vCJ6SJd0pDzPWXbxmOjcoP4OJ+Vf4tmw=
X-Gm-Gg: ASbGncvYy3ZRLyk44ZoHooVbVushvCmpHVSRWSVBKi9Z1zVeygUDd2mTyQgXdHqlf1h
	aSNrU39UgVl7tTB6qa/0XY1dWabghAPxdcBgJQZ3LKpF6qsyCjLv87Q5+d2wZCAyLn8QEHhKpR0
	QdrqsVmqbmwfkkJhD0poST7vmsxeGdtd5l8lhZm3c5rp5g2ss7vq43UE/Ndl7FKm3es08FTp5nc
	8WZK94K3IKv689gA1tefzmb4oHGlxGsMo2B4fnCFDRTUxWYMO/4sQ0mtGdLspbQFgWQ8Km9g3Nb
	A7AMNI0he6lqzrUoO+d1ooUqtANTdf3oO3ekE8K2z6HR3wuX2cYaF4YTWyDQxu2f9qj+3kbq+hI
	6QjgDLg==
X-Received: by 2002:a05:600c:4fd3:b0:436:346a:fa9b with SMTP id 5b1f17b1804b1-4365c7c9707mr29422775e9.20.1734625877363;
        Thu, 19 Dec 2024 08:31:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOfobzoUqE0Vv76Zk/1ThRAAU7lh3RNnu0e3gi7JMTQX1+xmBaSbMvv+ihIXkK6c9WtKbfSg==
X-Received: by 2002:a05:600c:4fd3:b0:436:346a:fa9b with SMTP id 5b1f17b1804b1-4365c7c9707mr29422405e9.20.1734625876944;
        Thu, 19 Dec 2024 08:31:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119ccsm56313895e9.24.2024.12.19.08.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:31:15 -0800 (PST)
Message-ID: <4104f64a-09c3-4f20-8e1a-5f4547fdcb25@redhat.com>
Date: Thu, 19 Dec 2024 17:31:14 +0100
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
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
 <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
 <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
 <6FBDD501-25A0-4A21-8051-F8EE74AD177B@nvidia.com>
 <7qyun2waznrduxpf2i5eebqdvpigrd5ycu4rlpawu336kqkyvh@xmfmlsmr43gw>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7qyun2waznrduxpf2i5eebqdvpigrd5ycu4rlpawu336kqkyvh@xmfmlsmr43gw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:26, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 11:14:49AM -0500, Zi Yan wrote:
>> On 19 Dec 2024, at 11:09, Bernd Schubert wrote:
>>
>>> On 12/19/24 17:02, Zi Yan wrote:
>>>> On 19 Dec 2024, at 11:00, Zi Yan wrote:
>>>>> On 19 Dec 2024, at 10:56, Bernd Schubert wrote:
>>>>>
>>>>>> On 12/19/24 16:55, Zi Yan wrote:
>>>>>>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>>>>>>
>>>>>>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>>>>>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>>>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>>>>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>>>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>>>>>>>> waits may get stuck.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     mm/migrate.c | 5 ++++-
>>>>>>>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>>>>>     		 */
>>>>>>>>>>>>     		switch (mode) {
>>>>>>>>>>>>     		case MIGRATE_SYNC:
>>>>>>>>>>>> -			break;
>>>>>>>>>>>> +			if (!src->mapping ||
>>>>>>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>>>>>>> +				break;
>>>>>>>>>>>> +			fallthrough;
>>>>>>>>>>>>     		default:
>>>>>>>>>>>>     			rc = -EBUSY;
>>>>>>>>>>>>     			goto out;
>>>>>>>>>>>
>>>>>>>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
>>>>>>>>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>>>>>>>>
>>>>>>>>>>> That sounds very bad.
>>>>>>>>>>
>>>>>>>>>> The page under writeback are already unmovable while they are under
>>>>>>>>>> writeback. This patch is only making potentially unrelated tasks to
>>>>>>>>>> synchronously wait on writeback completion for such pages which in worst
>>>>>>>>>> case can be indefinite. This actually is solving an isolation issue on a
>>>>>>>>>> multi-tenant machine.
>>>>>>>>>>
>>>>>>>>> Are you sure, because I read in the cover letter:
>>>>>>>>>
>>>>>>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
>>>>>>>>> support writable mmap"))), a temp page is allocated for every dirty
>>>>>>>>> page to be written back, the contents of the dirty page are copied over to
>>>>>>>>> the temp page, and the temp page gets handed to the server to write back.
>>>>>>>>> This is done so that writeback may be immediately cleared on the dirty
>>>>>>>>> page,"
>>>>>>>>>
>>>>>>>>> Which to me means that they are immediately movable again?
>>>>>>>>
>>>>>>>> Oh sorry, my mistake, yes this will become an isolation issue with the
>>>>>>>> removal of the temp page in-between which this series is doing. I think
>>>>>>>> the tradeoff is between extra memory plus slow write performance versus
>>>>>>>> temporary unmovable memory.
>>>>>>>
>>>>>>> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
>>>>>>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
>>>>>>> temporary.
>>>>>>
>>>>>> Is there is a difference between FUSE TMP page being unmovable and
>>>>>> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?
>>>>
>>>> (Fix my response location)
>>>>
>>>> Both are unmovable, but you can control where FUSE TMP page
>>>> can come from to avoid spread across the entire memory space. For example,
>>>> allocate a contiguous region as a TMP page pool.
>>>
>>> Wouldn't it make sense to have that for fuse writeback pages as well?
>>> Fuse tries to limit dirty pages anyway.
>>
>> Can fuse constraint the location of writeback pages? Something like what
>> I proposed[1], migrating pages to a location before their writeback? Will
>> that be a performance concern?
>>
>> In terms of the number of dirty pages, you only need one page out of 512
>> pages to prevent 2MB THP from allocation. For CMA allocation, one unmovable
>> page can kill one contiguous range. What is the limit of fuse dirty pages?
>>
>> [1] https://lore.kernel.org/linux-mm/90C41581-179F-40B6-9801-9C9DBBEB1AF4@nvidia.com/
> 
> I think this whole concern of fuse making system memory unmovable
> forever is overblown. Fuse is already using a temp (unmovable) page 

Right, and we allocated in a way that we expect it to not be movable 
(e.g., not on ZONE_MOVABLE, usually in a UNMOVABLE pageblock etc).

As another question, which effect does this change here have on 
folio_wait_writeback() users like arch/s390/kernel/uv.c or 
shrink_folio_list()?


-- 
Cheers,

David / dhildenb


