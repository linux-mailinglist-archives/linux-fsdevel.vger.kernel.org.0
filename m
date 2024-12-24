Return-Path: <linux-fsdevel+bounces-38096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760BE9FBD74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95D47A20DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F51B87F5;
	Tue, 24 Dec 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2S4s2pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046914D2BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043880; cv=none; b=bWVETpiZYBV7UIj81fwyF6xCgzIw+cqoVrAotAyTFWWTqKFCxZGWIsmZpjnVxoCiYmXprcfT7pAQt1PJF4tW4NoLIBla2Ws8U0V8sYZf5hJzRUR/CwdHrEjIUQrVEGFHg/C9oI45160g9OJzFNZdjYDUiTP1Q9r22xRwzT4CpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043880; c=relaxed/simple;
	bh=+ZI837Mep5kkGVexPqEp6/KPNQ+/9F2Nc8fRuhyfEts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVxoPgXMFGNGqV9hZHFRszlsBdGAiN2yfi3xoGwyCZLjdq4yMtuUzgQ36+e83HqBXvCLy/f7dMtWphub2Pgd+MFzK9Uv82AA2WNgr989tQZiQa+L+aqHZqJZL+yQ5gv2YB7R/c/PHHmfUxZ7uxlREnNHbWHbyuSiiVyHhYobb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2S4s2pe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735043877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NSG4ayEYm3Kz9Nh0mNnanQ0akRiWq82T1wa6YfP8Ei8=;
	b=S2S4s2pex6PFD4Yy3b2Nh0krXVuLTOBb9V9SqlEQgPVQrkdnKB/vARHfNBKMXeJmL5iFs3
	Xn+eM+hg3DP02KEF1dUVyIRS0UlMcsIyM9nOvP+lMQzh0nZg4FRYKyquGt7/kICDEiOtw4
	UDnOD0TlUCHELZax8ixL+cSVCC9bGGQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-2mO-x_NON-O55VQ0LEksqA-1; Tue, 24 Dec 2024 07:37:53 -0500
X-MC-Unique: 2mO-x_NON-O55VQ0LEksqA-1
X-Mimecast-MFC-AGG-ID: 2mO-x_NON-O55VQ0LEksqA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so38258675e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 04:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735043873; x=1735648673;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NSG4ayEYm3Kz9Nh0mNnanQ0akRiWq82T1wa6YfP8Ei8=;
        b=SH8M8BzaIqXOSDEXFS5M7EIqKYeL7G7sIP7+A6bQph6hVev6CJ6Y2lmuXyplmeZ89v
         93s5zxPKuzatzM4mU9WA7yXGeHoMjT/rd51+HPVqAy+l/BULsd0AhfXHHqTJ2bPZtUgo
         JPYCJdyNoC11V+QsshgLC8Dw4du9XGi2e2bloTYhMbrhOcPdv9GH7GI3FD5opcCvxDog
         OthHivcc5iitGs3rBKlaLuPM0/7S7BT5RhZgO3GS4hH3r9ICOqYtuKWwrfe8HU8a7qfy
         FxV/vOFyMtyauwd2xdpD+esYmCxf/+ADJ/oA0QLSA+B2lYqWxStdN73qi8L0XS9Za3gG
         A4uA==
X-Forwarded-Encrypted: i=1; AJvYcCW1jAdOvUPPTpZ6jS6RnG5MUnFx2Qtw0K4T8WOxLB/X6lEtPZUP5mbNm6UXo/+eBau5shY7ARVMMai68BRd@vger.kernel.org
X-Gm-Message-State: AOJu0YxcISW/q66lXrVygmx8btzbLu5EiNvuBPPCW8tJ+uJGsaePbjKd
	9Y07BvUwyN6FzsWDMZzmLYOeTxSaFzKKgBLtlup6/5g0KFkXNObdTIIIcI3/jMc+xhfJo80foxW
	67ov52gwmxfl4gYHnUggapoZzPakpD8xTC2rrR5oTEjkbN+IDr9W11zv/y7e2Ruw=
X-Gm-Gg: ASbGncvRp49HkFR+gS7b1tG1lKl807hONZE/7wOfV+UYOoabUhsoD5BDbmUszfKRfLS
	aWCReXLWmIWBdQYpRpef+e/B+0q80TXme7Llu7x1p6mmPi73LlFH8EkWBANHvxs2MQM7gyD0kCo
	s+4ZAFbSox2sZV9zTRAfYTTdbVODIiRmC7YOkuUi09KNQNMcVkFU1aL+f/5KqyhbR1wksKAXri0
	vpOXbWo4NdhuV5j+FJWRo+1rbqen8E7/1gNaRlbhVdCdjZnNjmsWt9Raw3U3x6/2TWPy5DCMacA
	sDDIay5EUKjzCOSZubOzH1BXpWJOzwVoGgSTgsxsE8EdoklbXvtIIXMqLH0D4Z6Ovg5n8lSx/3Q
	3E/UvT3bb
X-Received: by 2002:a05:600c:1c91:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-43668b5e085mr127426495e9.26.1735043872661;
        Tue, 24 Dec 2024 04:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsuTEaE5C3CRfktkkUHL4DfNBeyPEDuHNAm22EMav6rvDL0wDUDchnt71Z94INolH2uT9Fkg==
X-Received: by 2002:a05:600c:1c91:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-43668b5e085mr127426295e9.26.1735043872262;
        Tue, 24 Dec 2024 04:37:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:da00:e63f:f575:6b1a:df4e? (p200300cbc72ada00e63ff5756b1adf4e.dip0.t-ipconnect.de. [2003:cb:c72a:da00:e63f:f575:6b1a:df4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4471bsm200613125e9.44.2024.12.24.04.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 04:37:51 -0800 (PST)
Message-ID: <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
Date: Tue, 24 Dec 2024 13:37:49 +0100
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
References: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.12.24 23:14, Shakeel Butt wrote:
> On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
> [...]
>>
>> Yes, so I can see fuse
>>
>> (1) Breaking memory reclaim (memory cannot get freed up)
>>
>> (2) Breaking page migration (memory cannot be migrated)
>>
>> Due to (1) we might experience bigger memory pressure in the system I guess.
>> A handful of these pages don't really hurt, I have no idea how bad having
>> many of these pages can be. But yes, inherently we cannot throw away the
>> data as long as it is dirty without causing harm. (maybe we could move it to
>> some other cache, like swap/zswap; but that smells like a big and
>> complicated project)
>>
>> Due to (2) we turn pages that are supposed to be movable possibly for a long
>> time unmovable. Even a *single* such page will mean that CMA allocations /
>> memory unplug can start failing.
>>
>> We have similar situations with page pinning. With things like O_DIRECT, our
>> assumption/experience so far is that it will only take a couple of seconds
>> max, and retry loops are sufficient to handle it. That's why only long-term
>> pinning ("indeterminate", e.g., vfio) migrate these pages out of
>> ZONE_MOVABLE/MIGRATE_CMA areas in order to long-term pin them.
>>
>>
>> The biggest concern I have is that timeouts, while likely reasonable it many
>> scenarios, might not be desirable even for some sane workloads, and the
>> default in all system will be "no timeout", letting the clueless admin of
>> each and every system out there that might support fuse to make a decision.
>>
>> I might have misunderstood something, in which case I am very sorry, but we
>> also don't want CMA allocations to start failing simply because a network
>> connection is down for a couple of minutes such that a fuse daemon cannot
>> make progress.
>>
> 
> I think you have valid concerns but these are not new and not unique to
> fuse. Any filesystem with a potential arbitrary stall can have similar
> issues. The arbitrary stall can be caused due to network issues or some
> faultly local storage.

What concerns me more is that this is can be triggered by even 
unprivileged user space, and that there is no default protection as far 
as I understood, because timeouts cannot be set universally to a sane 
defaults.

Again, please correct me if I got that wrong.


BTW, I just looked at NFS out of interest, in particular 
nfs_page_async_flush(), and I spot some logic about re-dirtying pages + 
canceling writeback. IIUC, there are default timeouts for UDP and TCP, 
whereby the TCP default one seems to be around 60s (* retrans?), and the 
privileged user that mounts it can set higher ones. I guess one could 
run into similar writeback issues?

So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs? 
Not sure if I grasped all details about NFS and writeback and when it 
would redirty+end writeback, and if there is some other handling in there.

> 
> Regarding the reclaim, I wouldn't say fuse or similar filesystem are
> breaking memory reclaim as the kernel has mechanism to throttle the
> threads dirtying the file memory to reduce the chance of situations
> where most of memory becomes unreclaimable due to being dirty.

Yes, likely even cgroups can easily limit the amount.

> 
> Please note that such filesystems are mostly used in environments like
> data center or hyperscalar and usually have more advanced mechanisms to
> handle and avoid situations like long delays. For such environment
> network unavailability is a larger issue than some cma allocation
> failure. My point is: let's not assume the disastrous situaion is normal
> and overcomplicate the solution.

Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be 
used for movable allocations.

Mechanisms that possible turn these folios unmovable for a 
long/indeterminate time must either fail or migrate these folios out of 
these regions, otherwise we start violating the very semantics why 
ZONE_MOVABLE/MIGRATE_CMA was added in the first place.

Yes, there are corner cases where we cannot guarantee movability (e.g., 
OOM when allocating a migration destination), but these are not cases 
that can be triggered by (unprivileged) user space easily.

That's why FOLL_LONGTERM pinning does exactly that: even if user space 
would promise that this is really only "short-term", we will treat it as 
"possibly forever", because it's under user-space control.


Instead of having more subsystems violate these semantics because 
"performance" ... I would hope we would do better. Maybe it's an issue 
for NFS as well ("at least" only for privileged user space)? In which 
case, again, I would hope we would do better.


Anyhow, I'm hoping there will be more feedback from other MM folks, but 
likely right now a lot of people are out (just like I should ;) ).

If I end up being the only one with these concerns, then likely people 
can feel free to ignore them. ;)

-- 
Cheers,

David / dhildenb


