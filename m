Return-Path: <linux-fsdevel+bounces-37999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065899FA199
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B1118841E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE68152196;
	Sat, 21 Dec 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1RZTZvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042D1C32
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734797910; cv=none; b=jC9OAcvUSlm1KXZ/+81RBh2fim6wOi3wiECqC4udtZCvkKxnvU3ESiRuBuZcn5bETmfT/ZmPjbV7Bnd29Dq+If1Bjq3e+4S3S5Glys8jhD2/TK8OYuZh+ZKqXGC5U5ZoEZ6bs/+vkGQdAqN5RrBLQuZ0OvlW9eyUjfiKNU/ERhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734797910; c=relaxed/simple;
	bh=6yB+vvn5oa8lo2esyYbktpfAyCoJwJ7mBWLJBZboVXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDV1uEOZbDZeXlFHJsQ6/+sNk93sJTJdKOxQQi4g6MhSqe7M4wwCP5PCqxog/dzHjgarzRbnRPMhAhX1Z2Do70LxWkK42SPTuAdqTiIhsHyuAloWjzNEsrzD3/vWCNE5K7HlbAeEat8A5gxbjd74uBLwR72mEhn9QETM7lvnRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1RZTZvl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734797907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9zbL9DzfI/m+SVuvQfuz5ThQUFsMGBqPX/Gf47k6fXo=;
	b=e1RZTZvlqTSQXsayoMUjX8cY4awHY71BhuQ1aSIv5TvcRS2KBh5KFNBNEvqArgigPtC2fH
	I70bnU8x7Q/A4ZohqXUT9Ix/YJPcx7zL9z9+KY2dMfCo3X9RFPi7J8BnGnag9hTnWcyt0C
	daUCzR9PDBabO44YbuwvVAPcpyWCm6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-JYO-_tPqNVSgUQArH3ctSQ-1; Sat, 21 Dec 2024 11:18:25 -0500
X-MC-Unique: JYO-_tPqNVSgUQArH3ctSQ-1
X-Mimecast-MFC-AGG-ID: JYO-_tPqNVSgUQArH3ctSQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436248d1240so14993825e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 08:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734797904; x=1735402704;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9zbL9DzfI/m+SVuvQfuz5ThQUFsMGBqPX/Gf47k6fXo=;
        b=rU0qpRJTB/yZieWfcgb+IPaPMamhYc1t9Iq+UL55W+C0w4IGT/C3QJ5Z8z9nLbJc3Y
         G1GyssRymsSKWP+WW4LupgFerpT7c4WNl1pVJbIQIP603nZuZpYuDAsEm0hHTU9P8Txk
         MVfEnO9k+zVQNo4GTpGaPw3w1qxfODLPDq5Hec3L5cGGFhpEvMDYR4MllONeF8gMhOMU
         aDVlp/0+vZJGC8og/HO58cUnmglI1h7MGl6fQvvW3kuZGXfKdi7eH/sux4L0kD9FegM+
         rTyADwhGzs+aoDUAVq8Dzydo8kTHmGdGYFQUBcNmxQQZNNTYdERK+Xz1dhEQCliAj2tq
         Bqvg==
X-Forwarded-Encrypted: i=1; AJvYcCXFmFKqZqZQA67IRb37tci3Y+B6AuuECg+7+IrbVuZ0ZfiQ47oLt+X8Si3OlKmZ6xt9h4a7CowMlUw0ziJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsdH7lezvUn4XGBVCKOcU0unC9bjTBIuqYQO0W1kBblPEGG/j
	hyrzGbjo7IsNR4oUD40fTX8NTTWtAKGUFFW6Rw1Fe7qBNKhzOG+Fq9ZCaRc9U9NBBjaj++mgEIY
	Ue5OaeumUQb30J0i5Gq4ze5YVvib/PJ2XCFkU5kI7Q1rTaOW7ehLgptWEhRCSRXg=
X-Gm-Gg: ASbGncvxWBDtlqqQqjxtA7Y/j0AQ/Sh7MJLK0hOEX8jhef3UJC23HDPCUX+VTAyrTqT
	2z2cKm/qGF3PhvXv3oEv6wwBvTRz0G/eqhcQ4Ao2Ps8PdzMf1IC27DV45+5PKc8MzNz8sb2lrsC
	L9oZJYWkiurn9whg85tIdID2W2iP0ARCbKwsQCJk8jYXmXuxRcWbNCavt679xTL6vaV7l26ZvL9
	DtOAmeDuYrFVMV3FekHUsDRdi+zD8H1GVLkbnfHCwxq9rybnp/xiXSvz9XxSZln0RxUpVB8dlCv
	sVteuehVIX9e796ewBJV8YRrtMTImrmQEHtGMlImoaoOCr7XYfI4AQ3UitfruDPzZ6UQBoboHk1
	fbo3x8ARf
X-Received: by 2002:a05:600c:314a:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-43668b49929mr53681385e9.23.1734797904460;
        Sat, 21 Dec 2024 08:18:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdqCbMQ41u82OBsRy/1CcW1Fh9pEekW/Zl0oARY2fn4Zf97l2Ef5oung4fXnWxJt9AZi8inw==
X-Received: by 2002:a05:600c:314a:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-43668b49929mr53681175e9.23.1734797903973;
        Sat, 21 Dec 2024 08:18:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d? (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de. [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8332absm6718502f8f.38.2024.12.21.08.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 08:18:22 -0800 (PST)
Message-ID: <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
Date: Sat, 21 Dec 2024 17:18:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 19:01, Shakeel Butt wrote:
> On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
>>>> I'm wondering if there would be a way to just "cancel" the writeback and
>>>> mark the folio dirty again. That way it could be migrated, but not
>>>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>>>> thing.
>>>>
>>>
>>> That is what I basically meant with short timeouts. Obviously it is not
>>> that simple to cancel the request and to retry - it would add in quite
>>> some complexity, if all the issues that arise can be solved at all.
>>
>> At least it would keep that out of core-mm.
>>
>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should try to
>> improve such scenarios, not acknowledge and integrate them, then work around
>> using timeouts that must be manually configured, and ca likely no be default
>> enabled because it could hurt reasonable use cases :(
> 
> Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
> parts. First is reclaim and second is compaction/migration. For reclaim,
> it is a must have as explained by Jingbo in [1] i.e. due to potential
> self deadlock by fuse server. If I understand you correctly, the main
> concern you have is its usage in the second case.

Yes, so I can see fuse

(1) Breaking memory reclaim (memory cannot get freed up)

(2) Breaking page migration (memory cannot be migrated)

Due to (1) we might experience bigger memory pressure in the system I 
guess. A handful of these pages don't really hurt, I have no idea how 
bad having many of these pages can be. But yes, inherently we cannot 
throw away the data as long as it is dirty without causing harm. (maybe 
we could move it to some other cache, like swap/zswap; but that smells 
like a big and complicated project)

Due to (2) we turn pages that are supposed to be movable possibly for a 
long time unmovable. Even a *single* such page will mean that CMA 
allocations / memory unplug can start failing.

We have similar situations with page pinning. With things like O_DIRECT, 
our assumption/experience so far is that it will only take a couple of 
seconds max, and retry loops are sufficient to handle it. That's why 
only long-term pinning ("indeterminate", e.g., vfio) migrate these pages 
out of ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.


The biggest concern I have is that timeouts, while likely reasonable it 
many scenarios, might not be desirable even for some sane workloads, and 
the default in all system will be "no timeout", letting the clueless 
admin of each and every system out there that might support fuse to make 
a decision.

I might have misunderstood something, in which case I am very sorry, but 
we also don't want CMA allocations to start failing simply because a 
network connection is down for a couple of minutes such that a fuse 
daemon cannot make progress.


> 
> The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
> to avoid untrusted fuse server causing pain to unrelated jobs on the
> machine (fuse folks please correct me if I am wrong here). Now we are
> discussing how to better handle that scenario.
> 
> I just wanted to point out that irrespective of that discussion, the
> reclaim will have handle the potential recursive deadlock and thus will
> be using AS_WRITEBACK_INDETERMINATE or something similar.

Yes, I see no way to throw away dirty data without causing harm.

Migration was kept working for now, although in a hacky fashion I admit. 
I do enjoy that "writeback" on the folio actually matches the reality now.

I guess an alternative to "aborting writeback" would be to make fuse 
allow for migrating folios that are under writeback. I would assume that 
with fuse we have very good control over who is currently 
reading/writing that folio, and we could swap it out? Again, just an 
idea ...


-- 
Cheers,

David / dhildenb


