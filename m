Return-Path: <linux-fsdevel+bounces-38268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C669FE536
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544F31881F58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50951A3A80;
	Mon, 30 Dec 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P50L7KoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F659198E6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553799; cv=none; b=Px3qRZHtPAQyKvjG9EXsQAimzM4maRuodrDAiBZWW4Iedpk3rB9/z9E29+kg9b2KRozxVIFPb4cLConVnkBPB4J85neKFlIizDWhzuEc9EPI1RrzEs8udtHMKvMhCMa8ZrtwEjCOxM9qJ5hFMU81JqPP5z+aTXN9XM8txxhJuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553799; c=relaxed/simple;
	bh=BokepQ40IbBOQkXYMkA/X1yCUkWARvE4w0qoW7aejbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iyo/WXJq4zGe/bdOquE8tXHdubEn7g6CyAwMZC0vXX4Voe2gDzz0SV4TpzIiz8iOLYPMK+TlirkIgr5K6GFOAnX4Zl9VEaOk2/QHw2iULanh4lrTs6ULUJ2cJxd6RHt7f1vMsAH7M7fJ2d0MveDmgMvndL6Uy6bV8oXKnPJUcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P50L7KoY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735553795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wfPhj+GsTVBoLadkr2oEBzb5MpKJh5g9F2hLfDLIhAE=;
	b=P50L7KoYi7Sx8UtDwVAsqhBJV9d4ZmJF/NX0UAz2eLNYnZmv15DQ0HeFeo8ZY1aFCawyxR
	b3Fxlmfw07D1S0zvfCF8YqOsZiOGEk+l0RTJcxaFL9FvVUY0bMXcOL6k/aGrtkxQdBAP6c
	9l6CrCv+YXGTDgLJNdaiwGSmGmxb3X0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-HCDEoXDsNlC1zy6tZaF6zQ-1; Mon, 30 Dec 2024 05:16:27 -0500
X-MC-Unique: HCDEoXDsNlC1zy6tZaF6zQ-1
X-Mimecast-MFC-AGG-ID: HCDEoXDsNlC1zy6tZaF6zQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38639b4f19cso5923304f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 02:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735553781; x=1736158581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wfPhj+GsTVBoLadkr2oEBzb5MpKJh5g9F2hLfDLIhAE=;
        b=cijWb+3YA1x3+ZlRdTP/3WD7HXxX6aSvrEU7J6UmRo1prMRrM6qFW1qISIvX+AE0kL
         zXXCovQkbssxwjgaayZaR2RPtvUxGCn0vBFHxwZNEbXdneOobKjFUNgopMDThhHTEMCE
         528hU19tEUSgs0AmNdrFGaJB7Xn3tqi6ehBas9u9qQ/B8t3QjXT5B72x3ZhE5sv+abfZ
         sdLJhBzUvScDvH2Rel3M4JTlQiKVvjxNES+Gxp9Nz+jgEwftdPwmX149LTwtFF3+KJkw
         7j0XrfvMFU0LTXoFHPnwV2jQMKYwmjosQMq0Jf12fFTSgdxQlKXOZuUcd6r7B2nj4/YQ
         tBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJehMRSVmkSQxLwzIjz5r3npjkp31UEWXvNJWTCGysvygpXL8b4i/xiVRMt4GxEbnfVLXjmS5WUi10qP8@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGqXp97wEnuvg7z8nj67uwZwh0PZxscEidPSAL1R+m1mje7tR
	+ENN24Hv7mThx9P5ioOzb8q47Yn0rrSF0sTMdwUUTyG5rDetbX6IhuyWqn4LgolaSs+pok8VhFl
	m2hqrbxGHy83ZxQkdtOvbhXAJwUZgFd5Yx/89Ik6ULbv/4vfbfPhOxZsG2oSof5c=
X-Gm-Gg: ASbGncuy6gbECN0OqmngHqCFwSOzl3BHMzxTHtT6grRM2AEiZJn96iM+Re8Q9db1Dyh
	v26QRaIVF0GDkSi5HysLYmmC+VsBXp96j6ezp6s4w0IVLInBTphtVbr/re5sVG1u+AbycTixl8u
	fZm8h+L9D7fOfNuAsn7Lp0cMJaFFBKIXVcGuLhHceLaCUQsENJbKkRXV0Tnskj5R2dt15qKlr/3
	MBNK+5m248LALhTcAnodsHwFtiB/WItmXExcVwzWYWUP7jdIwtHrllikNyItLuConYyGwMdgkcb
	PbQmesrd2/4sSa751L2Vd6wvKPbO6a7tskca82tDqX2hwFf9572zX6BVsfVfVyfM0Km1Pwqe+By
	BpmFWFO9T
X-Received: by 2002:a5d:47ab:0:b0:386:1ab5:f0e1 with SMTP id ffacd0b85a97d-38a221ea67fmr33687876f8f.14.1735553781503;
        Mon, 30 Dec 2024 02:16:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0iVyi3Ka5o1ghQOFECyWau7dB/SLiwvV5HEpWiwGLxJiUR3UMPbGjgX5SGFe1rWyUA2+Pbw==
X-Received: by 2002:a5d:47ab:0:b0:386:1ab5:f0e1 with SMTP id ffacd0b85a97d-38a221ea67fmr33687833f8f.14.1735553781038;
        Mon, 30 Dec 2024 02:16:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:5800:c745:7e74:aa59:8dbe? (p200300cbc7185800c7457e74aa598dbe.dip0.t-ipconnect.de. [2003:cb:c718:5800:c745:7e74:aa59:8dbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm30149795f8f.71.2024.12.30.02.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 02:16:19 -0800 (PST)
Message-ID: <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
Date: Mon, 30 Dec 2024 11:16:17 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> BTW, I just looked at NFS out of interest, in particular
>> nfs_page_async_flush(), and I spot some logic about re-dirtying pages +
>> canceling writeback. IIUC, there are default timeouts for UDP and TCP,
>> whereby the TCP default one seems to be around 60s (* retrans?), and the
>> privileged user that mounts it can set higher ones. I guess one could run
>> into similar writeback issues?
> 

Hi,

sorry for the late reply.

> Yes, I think so.
> 
>>
>> So I wonder why we never required AS_WRITEBACK_INDETERMINATE for nfs?
> 
> I feel like INDETERMINATE in the name is the main cause of confusion.

We are adding logic that says "unconditionally, never wait on writeback 
for these folios, not even any sync migration". That's the main problem 
I have.

Your explanation below is helpful. Because ...

> So, let me explain why it is required (but later I will tell you how it
> can be avoided). The FUSE thread which is actively handling writeback of
> a given folio can cause memory allocation either through syscall or page
> fault. That memory allocation can trigger global reclaim synchronously
> and in cgroup-v1, that FUSE thread can wait on the writeback on the same
> folio whose writeback it is supposed to end and cauing a deadlock. So,
> AS_WRITEBACK_INDETERMINATE is used to just avoid this deadlock.
 > > The in-kernel fs avoid this situation through the use of GFP_NOFS
> allocations. The userspace fs can also use a similar approach which is
> prctl(PR_SET_IO_FLUSHER, 1) to avoid this situation. However I have been
> told that it is hard to use as it is per-thread flag and has to be set
> for all the threads handling writeback which can be error prone if the
> threadpool is dynamic. Second it is very coarse such that all the
> allocations from those threads (e.g. page faults) become NOFS which
> makes userspace very unreliable on highly utilized machine as NOFS can
> not reclaim potentially a lot of memory and can not trigger oom-kill.
> 

... now I understand that we want to prevent a deadlock in one specific 
scenario only?

What sounds plausible for me is:

a) Make this only affect the actual deadlock path: sync migration
    during compaction. Communicate it either using some "context"
    information or with a new MIGRATE_SYNC_COMPACTION.
b) Call it sth. like AS_WRITEBACK_MIGHT_DEADLOCK_ON_RECLAIM to express
     that very deadlock problem.
c) Leave all others sync migration users alone for now

Would that prevent the deadlock? Even *better* would be to to be able to 
ask the fs if starting writeback on a specific folio could deadlock. 
Because in most cases, as I understand, we'll  not actually run into the 
deadlock and would just want to wait for writeback to just complete 
(esp. compaction).

(I still think having folios under writeback for a long time might be a 
problem, but that's indeed something to sort out separately in the 
future, because I suspect NFS has similar issues. We'd want to "wait 
with timeout" and e.g., cancel writeback during memory 
offlining/alloc_cma ...)

>> Not
>> sure if I grasped all details about NFS and writeback and when it would
>> redirty+end writeback, and if there is some other handling in there.
>>
> [...]
>>>
>>> Please note that such filesystems are mostly used in environments like
>>> data center or hyperscalar and usually have more advanced mechanisms to
>>> handle and avoid situations like long delays. For such environment
>>> network unavailability is a larger issue than some cma allocation
>>> failure. My point is: let's not assume the disastrous situaion is normal
>>> and overcomplicate the solution.
>>
>> Let me summarize my main point: ZONE_MOVABLE/MIGRATE_CMA must only be used
>> for movable allocations.
>>
>> Mechanisms that possible turn these folios unmovable for a
>> long/indeterminate time must either fail or migrate these folios out of
>> these regions, otherwise we start violating the very semantics why
>> ZONE_MOVABLE/MIGRATE_CMA was added in the first place.
>>
>> Yes, there are corner cases where we cannot guarantee movability (e.g., OOM
>> when allocating a migration destination), but these are not cases that can
>> be triggered by (unprivileged) user space easily.
>>
>> That's why FOLL_LONGTERM pinning does exactly that: even if user space would
>> promise that this is really only "short-term", we will treat it as "possibly
>> forever", because it's under user-space control.
>>
>>
>> Instead of having more subsystems violate these semantics because
>> "performance" ... I would hope we would do better. Maybe it's an issue for
>> NFS as well ("at least" only for privileged user space)? In which case,
>> again, I would hope we would do better.
>>
>>
>> Anyhow, I'm hoping there will be more feedback from other MM folks, but
>> likely right now a lot of people are out (just like I should ;) ).
>>
>> If I end up being the only one with these concerns, then likely people can
>> feel free to ignore them. ;)
> 
> I agree we should do better but IMHO it should be an iterative process.
 > I think your concerns are valid, so let's push the discussion 
towards> resolving those concerns. I think the concerns can be resolved 
by better
> handling of lifetime of folios under writeback. The amount of such
> folios is already handled through existing dirty throttling mechanism.
> 
> We should start with a baseline i.e. distribution of lifetime of folios
> under writeback for traditional storage devices (spinning disk and SSDs)
> as we don't want an unrealistic goal for ourself. I think this data will
> drive the appropriate timeout values (if we decide timeout based
> approach is the right one).
> 
> At the moment we have timeout based approach to limit the lifetime of
> folios under writeback. Any other ideas?

See above, maybe we could limit the deadlock avoidance to the actual 
deadlock path and sort out the "infinite writeback in some corner cases" 
problem separately.

-- 
Cheers,

David / dhildenb


