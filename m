Return-Path: <linux-fsdevel+bounces-38915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537CA09CC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C97167CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3087206F35;
	Fri, 10 Jan 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZa5mvtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3154F208990
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542822; cv=none; b=AqmcimKBIl63PSugOM+O7UiaCZRWYr0px3FNDkkuDAynPTmPUR3rsgNZb/5PD1NBW4FGd/LxuxgMk1kp1u/u35D33QNKIGhYUWmBox+TxeOiFOCQXsT4QwY39SVzYQo/stsO6+WpWR8GMo/X3JHrZ8yTIhsKtvI/svGTg73gWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542822; c=relaxed/simple;
	bh=iXcBNUQplOdS5V8j+WIxxhPrEmSz5NmOXxLUByjjWq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psObLJYU4bS54Hplfx6QMNc0UAmyOHVezOgPbIqCoALipYgMQRSASLQFLyExO1XYzi2SJvg+aL0p1d1eb+L+Sdv3vr3SJs0mZDnwLx4KSL2kBzHykjrbnsH260EUj2mvMYpV0uXb3MoDECsLks2ukCT2Y9j1vRRPV7Eclqccum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZa5mvtR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736542816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J8959kPUFfZLBQMBHdBv1fGZ4buFB3gN6EGpnvIiwRQ=;
	b=YZa5mvtRngUmGAcq7XO9Fqh8GnO9S8etIpiznhg4rhjWKdY2P3lbL6oAwThXl/9Z4IgEYv
	G/g0dZ/x9wwCN0n7NbWpx7WlXdQgdJrP79NHuy0Ic8K9sowFSwem1LaDZXssYvQOkq+Eez
	QcvDU+GzUNAN89DoEJzUkanqkUqo8pE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-1GExNJbYPoKwFrW5mbpnkg-1; Fri, 10 Jan 2025 16:00:12 -0500
X-MC-Unique: 1GExNJbYPoKwFrW5mbpnkg-1
X-Mimecast-MFC-AGG-ID: 1GExNJbYPoKwFrW5mbpnkg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so20985355e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 13:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736542811; x=1737147611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J8959kPUFfZLBQMBHdBv1fGZ4buFB3gN6EGpnvIiwRQ=;
        b=voESM/tM8THn9HSS0mF3k0QxErNSL3RjA3mtXixz6HWD7MESuWhfsBYeLIm3Z/kpNv
         G0F+9eqBEgpuVMp69dVYRmzYHRvl5DquJaGeTZvw4fiK9/3Zr8ZC6z3PupzIhOeV7fYi
         PDupiYvfk2VOzRD48SOF9CoppiYBn6k0jhBmk6z9FSzkitYSzeaKlLW+3Bg6ba4EJEnL
         aXOM6pVuwI/DP+lsAMp0GqNY2oVRxL8HMw+EtBkk9JdS3WzdPZdoqi5eDapRCxpvRjdj
         o/IcivXiNNG0I8lJXw9bgmotGVlCsj1yImqALBGpxNlSnhEC6ELYDprUmDDHF6an62g4
         iMWw==
X-Forwarded-Encrypted: i=1; AJvYcCXl6OzfQOfii5XQvhogP9OsQENudIHnPhuYL/9qUMUWi7jxwaOmrAw8fFIuWGhhG4kGapA2CJ+2DBz/UiWk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6z7PuR+tZUDZq+Q7rjyzOlr8YY5AH/z+aG9D1LIjF+CSLMR/e
	hxSgUKfXgwMQrNhN12nvEjDd9RHpCjEJasAyuG7W3qGYq4S2Y58PuRIduntMaPevJfvQ70bts5f
	zi2QchvUgjkecZAIUtAa1r0XYXqblpGXgzk0GK6SpNi7j2+I/fOyefpWv93INjdc=
X-Gm-Gg: ASbGnctkki7t1+ObcMCDDf2sGG0v8FYgDeolAMRS2LbsuNplWCO+gBeb/hKVLIBu/KQ
	EFi4zT4/8jojOUNQ9xPJK4oB/JtxUaNlRg32V7zEJeuGSIG5b4oKxTD+gArmG7Vy7fxAeLsWCqe
	4SxJMXVBFNJ3csJ4eCxJf//1Y/OeymMqFpsD+PiAdmlypNQZ8AorOPhIPj0Y1EvWiZ+zzs4/pbQ
	LyeYc0pYP7U+zdCCC+4029FrL7DY8nHxevRSsYPiT6s4YQNezsH1UM7B9BKvipgdl/EspOMLILZ
	VzNePFIQczV/QvKr+Xr3TLxlakDGW/vO9k0gxmtuXeQUDKfAhwO9RjgTzv6UpiRKiXAzP2JZ0F7
	/kERFIEvR
X-Received: by 2002:a05:6000:402a:b0:38a:418e:1171 with SMTP id ffacd0b85a97d-38a8733063dmr10695843f8f.37.1736542811254;
        Fri, 10 Jan 2025 13:00:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM4OmO1WZ/aPg6xuVDjy8ByYrrVozhZ9CL4TDkPULchrT1u3C/ZMp/IAZjkr1ST3cgAQkPRQ==
X-Received: by 2002:a05:6000:402a:b0:38a:418e:1171 with SMTP id ffacd0b85a97d-38a8733063dmr10695827f8f.37.1736542810888;
        Fri, 10 Jan 2025 13:00:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0b1sm5492880f8f.12.2025.01.10.13.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 13:00:10 -0800 (PST)
Message-ID: <c9e4017a-9883-4052-9ca0-774b3745f439@redhat.com>
Date: Fri, 10 Jan 2025 22:00:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <153c5a4f08daf60e1bbbdde02975392dc608cfdf.camel@kernel.org>
 <e4150b98-99ed-45fc-8485-5ad044f10d84@redhat.com>
 <47fff939fc1fb3153af5b129be600a018c8485e9.camel@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <47fff939fc1fb3153af5b129be600a018c8485e9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 21:43, Jeff Layton wrote:
> On Fri, 2025-01-10 at 21:20 +0100, David Hildenbrand wrote:
>> On 10.01.25 21:16, Jeff Layton wrote:
>>> On Tue, 2025-01-07 at 09:34 +0100, David Hildenbrand wrote:
>>>> On 06.01.25 19:17, Shakeel Butt wrote:
>>>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>>>> good topic for LSF/MM.
>>>>>>
>>>>>> Yes, this seems a good cross fs-mm topic.
>>>>>>
>>>>>> So the issue discussed here is that movable pages used for fuse
>>>>>> page-cache cause a problems when memory needs to be compacted. The
>>>>>> problem is either that
>>>>>>
>>>>>>     - the page is skipped, leaving the physical memory block unmovable
>>>>>>
>>>>>>     - the compaction is blocked for an unbounded time
>>>>>>
>>>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>>>> worse, the same thing happens on readahead, since the new page can be
>>>>>> locked for an indeterminate amount of time, which can also block
>>>>>> compaction, right?
>>>>
>>>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is
>>>> these pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there
>>>> *must not be unmovable pages ever*. Not triggered by an untrusted
>>>> source, not triggered by an trusted source.
>>>>
>>>> It's a violation of core-mm principles.
>>>>
>>>> Even if we have a timeout of 60s, making things like alloc_contig_page()
>>>> wait for that long on writeback is broken and needs to be fixed.
>>>>
>>>> And the fix is not to skip these pages, that's a workaround.
>>>>
>>>> I'm hoping I can find an easy way to trigger this also with NFS.
>>>>
>>>
>>> I imagine that you can just open a file and start writing to it, pull
>>> the plug on the NFS server, and then issue a fsync or something to
>>> ensure some writeback occurs.
>>
>> Yes, that's the plan, thanks!
>>
>>>
>>> Any dirty pagecache folios should be stuck in writeback at that point.
>>> The NFS client is also very patient about waiting for the server to
>>> come back, so it should stay that way indefinitely.
>>
>> Yes, however the default timeout for UDP is fairly small (for TCP
>> certainly much longer). So one thing I'd like to understand what that
>> "cancel writeback -> redirty folio" on timeout does, and when it
>> actually triggers with TCP vs UDP timeouts.
>>
> 
> 
> The lifetime of the pagecache pages is not at all related to the socket
> lifetimes. IOW, the client can completely lose the connection to the
> server and the page will just stay dirty until the connection can be
> reestablished and the server responds.

Right. It cannot get reclaimed while that is the case.

> 
> The exception here is if you mount with "-o soft" in which case, an RPC
> request will time out with an error after a major RPC timeout (usually
> after a minute or so). See nfs(5) for the gory details of timeouts and
> retransmission. The default is "-o hard" since that's necessary for
> data-integrity in the face of spotty network connections.
> 
> Once a soft mount has a writeback RPC time out, the folio is marked
> clean and a writeback error is set on the mapping, so that fsync() will
> return an error.

I assume that's the code I stumbled over in nfs_page_async_flush(), 
where we end up calling folio_redirty_for_writepage() + 
nfs_redirty_request(), unless we run into a fatal error; in that case, 
we end up in nfs_write_error() where we set the mapping error and stop 
writeback using nfs_page_end_writeback().

-- 
Cheers,

David / dhildenb


