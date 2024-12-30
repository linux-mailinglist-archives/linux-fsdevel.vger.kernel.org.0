Return-Path: <linux-fsdevel+bounces-38278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C327B9FEA7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F1A3A2581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C98199238;
	Mon, 30 Dec 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XD6aQRrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9422339
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735588333; cv=none; b=d04nYcSi414iHS9WcPqdg3hRF64zPGjoIPnWgkvBb6THEpL1hXcl5vS3L/vz8KQ/rQxlPfwa4H3b2iRMvgfDLr1bpOzAs8xTr0/XZlL5nERY7NhxLKDjlVxkGBMAx16W9WfV7M7BfMZUS7vWVfM5wfs9mjga79U4VKli8uWauwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735588333; c=relaxed/simple;
	bh=EI2+11dzGhv+/KVTZd69aNiIjOF/+MPYEQroPTyNSc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjBqSmY6QPdMCvSLH/3BuFK0dV8pEzJ3EJP+4Wn5WWigDEda7ybXnAyZuWjQfsGaIEIi/c9oRd76lpM0cLE1/KS0f6Z9i1qbCRHmEayBb5BV4OsEkDFUD9PABmbfCWkVhinRJgn1MQ7lgtsQCgjNyWpVvIy2p9HmOLyJrggAOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XD6aQRrC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735588330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FMNDW99s41EelbmyuRNIhiw1B6HcvlNy1zjoDEXzZN4=;
	b=XD6aQRrClitr6rERGXYuO8f0zwval4IHoTIV/sqTndPvY451rIhlE6BH7dLJhuTZFCxtEh
	s83Mmwf4E0IZylNwsFbebeUlW9/P2chGIuvXu8iI+0x1SFCurX0Tal0hfTAg2BrTRgNzUv
	vBNLhhCJgAp2w/I1BbksvpGUOwhOdv0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-q7mRtG5SPG-T_5X9W69mYg-1; Mon, 30 Dec 2024 14:52:08 -0500
X-MC-Unique: q7mRtG5SPG-T_5X9W69mYg-1
X-Mimecast-MFC-AGG-ID: q7mRtG5SPG-T_5X9W69mYg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so69839515e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 11:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735588327; x=1736193127;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FMNDW99s41EelbmyuRNIhiw1B6HcvlNy1zjoDEXzZN4=;
        b=Xt2W0smU5a2Mh8XIt4QKXqsMMLogWz4AuBEW1y4R/SrfJmwDlOWKzBo+/vJczF9KTN
         NDfRrBOZD2bU2IErcuE+lqFElhL2A6Zsb/yuqnie+apG4JuvJ+TXIDpXLaoIf2lh9rnC
         saZWcecrTFMXF8X3PCE3vgtcIfBdvAEYwA781m+E5PRiYYVBBs80I7xoJUFxkElUwtAC
         s8ppHYqHImLSiOgtoUdggBBScjpRJ+9QjF2/ecF+Mvw2GvkWcxsMkxlvt/lVNEXwoqCF
         X7w+/O+Y0Dd4f34TIMc/XVLPdJLcLH3ZQNQpE/ytpSHF7WLUfwNixJQkeblnoW3dRBqS
         +s+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs4N4fbUcSJobZz6fSQ4o6L3EAcVz8wwCFjYuMn2a17/GShecypL4P8eH8wxPIgmUfwTD3w1NeIutkACV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxyoasYbppLY3bOKFY7J5PbJq/YsGJtINEHG/Z0yUUyUPg1YGN2
	33LRssCl0nkJ1j4acflSZwrc6wtwFJ5Ff6Zq53A3ywQfaGKThi1HgdWD1nzvFhy1gMCC4HDImK8
	aeD/MItx2Xr2kuzqINBvjv1A+pYHAMM1BRvIfVKOy8IlRx1tnXZMP8S6BwqcQQLY=
X-Gm-Gg: ASbGncumwMqoiFzkkOstWDPdvtt+OkxbQohZnGBGwqEa7ko6eMaqIOnYiU1RO14eO5d
	b/u/Os/2ssq6Rhamb9Rvvec6BgAQ5YDSHNWKVECrHluBLnj0rw/nH0M8PrMIhn1gb4lQRScX6FW
	Mid9575j8gBzTMCKHZQBkvh9ZBahObiKPIHWxLmARpyRZWDXvuqXo6mB0NdvZN9YPyO0wKxgbvy
	140AuGJyI5T/9HTzAed+rR8gKWbm4WnEoeviu2XoqCac7JMPrP9sDeW82I+/JXqSLJBgXiv9vaG
	j4h9xUWk0zUKvoA7a1+B7WV7wCedT6ZUdmkAmhJNFmp5cGwUMEq+gYLz7XQGvj33wvnD137EL98
	7Q5RX3TMm
X-Received: by 2002:a05:600c:3507:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-43668b5e090mr275550405e9.21.1735588326899;
        Mon, 30 Dec 2024 11:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGodv7uYIQitXvNfGr/YSKUWSViIzuVIVcfXqyQaqMKyFGQasRUq7guc82PNrQQjx10fwoILw==
X-Received: by 2002:a05:600c:3507:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-43668b5e090mr275550295e9.21.1735588326499;
        Mon, 30 Dec 2024 11:52:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:5800:c745:7e74:aa59:8dbe? (p200300cbc7185800c7457e74aa598dbe.dip0.t-ipconnect.de. [2003:cb:c718:5800:c745:7e74:aa59:8dbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119b6sm402438725e9.22.2024.12.30.11.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 11:52:06 -0800 (PST)
Message-ID: <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
Date: Mon, 30 Dec 2024 20:52:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> What sounds plausible for me is:
>>
>> a) Make this only affect the actual deadlock path: sync migration
>>      during compaction. Communicate it either using some "context"
>>      information or with a new MIGRATE_SYNC_COMPACTION.
>> b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
>>       that very deadlock problem.
>> c) Leave all others sync migration users alone for now
> 
> The deadlock path is separate from sync migration. The deadlock arises
> from a corner case where cgroupv1 reclaim waits on a folio under
> writeback where that writeback itself is blocked on reclaim.

Okay, so compaction (IOW this patch) is not relevant at all to resolve 
the deadlock in any way, correct?

For a second I thought I understood how this patch here relates to the 
deadlock :)

> 
>>
>> Would that prevent the deadlock? Even *better* would be to to be able to
>> ask the fs if starting writeback on a specific folio could deadlock.
>> Because in most cases, as I understand, we'll  not actually run into the
>> deadlock and would just want to wait for writeback to just complete
>> (esp. compaction).
>>
>> (I still think having folios under writeback for a long time might be a
>> problem, but that's indeed something to sort out separately in the
>> future, because I suspect NFS has similar issues. We'd want to "wait
>> with timeout" and e.g., cancel writeback during memory
>> offlining/alloc_cma ...)
> 
> I'm looking back at some of the discussions in v2 [1] and I'm still
> not clear on how memory fragmentation for non-movable pages differs
> from memory fragmentation from movable pages and whether one is worse
> than the other. Currently fuse uses movable temp pages (allocated with
> gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same

Why are they movable? Do you also specify __GFP_MOVABLE?

If not, they are unmovable and are never allocated from 
ZONE_MOVABLE/MIGRATE_CMA -- and usually only from MIGRATE_UNMOVBALE, to 
group these unmovable pages.

> issue where a buggy/malicious server may never complete writeback.

If the temp pages are not allocated using __GFP_MOVABLE, they are just 
like any other kernel allocation -- unmovable. Nobody would even try 
migrating them, ever. And they are allocated from memory regions where 
that is expected.


> This has the same effect of fragmenting memory and has a worse memory
> cost to the system in terms of memory used. With not having temp pages
> though, now in this scenario, pages allocated in a movable page block
> can't be compacted and that memory is fragmented. 

Yes. With temp pages, they simply grouped naturally "where they belong".

After all, pagecache pages are allocated using __GFP_MOVABLE, which 
implies "this thing is movable" -- so the buddy can place them in 
physical memory regions that allow only for movable allocations or 
minimize fragmentation.

> My (basic and maybe
> incorrect) understanding is that memory gets allocated through a buddy
> allocator and moveable vs nonmovable pages get allocated to
> corresponding blocks that match their type, but there's no other
> difference otherwise. Is this understanding correct? Or is there some
> substantial difference between fragmentation for movable vs nonmovable
> blocks?

I assume not regarding fragmentation.


In general, I see two main issues:

A) We are no longer waiting on writeback, even though we expect in sane 
environments that writeback will happen and we it might be worthwhile to 
just wait for writeback so we can migrate these folios.

B) We allow turning movable pages to be unmovable, possibly forever/long 
time, and there is no way to make them movable again (e.g., cancel 
writeback).


I'm wondering if A) is actually a new issue introduced by this change. 
Can folios with busy temp pages (writeback cleared on folio, but temp 
pages are still around) be migrated? I will look into some details once 
I'm back from vacation.

-- 
Cheers,

David / dhildenb


