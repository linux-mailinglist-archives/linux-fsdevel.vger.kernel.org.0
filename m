Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797A6145B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVRtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:49:14 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45596 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:49:14 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so49379iln.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ax0jdzS3yv65T0/5cDvrLsbUmZQIJbN7ZtKGhGW0j6A=;
        b=GlcKuzS9fgzaII5dhRNL+C0pt5mdA3f0fPdlP+J0ieR1YB2uRzrMmyk9sGqpmwsnBI
         jZbtO+wtpAMXsOdqpzSbjsyV/EbemzSqPHNMXtQhfHHRnJUV4iXNv5545Jm8PNRKj8OL
         5CqbBpCivWgOdetqZOhRG81sj5zIVxFHJBntTNIJrPzeWgpbwHYM0bP0eet/+wyhTHRL
         jHWPnKwmlf62fqbfuNULnXhC8u16njiSV8+bxFvUXuxfijTEFclsUslKbqTxV4jqoV+G
         3iJW+I3oCkT35DZNj7/g+84JPBay3TAROO8Hmu8jE6kHfw1Foj25LFD47xLfy0hOsIvw
         csXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ax0jdzS3yv65T0/5cDvrLsbUmZQIJbN7ZtKGhGW0j6A=;
        b=Mv8opKmFedwE6A55ZpiBmm7ds+IJto0T0Ln6ObEOcrSYU3XZSLvdTcLUtyiIPm1t0s
         BSY3xv2opbD9D+MC9dg852cUQLxeY8YZZ1HkIyZO4r2Aid28phyfrQ6yXBDZksrK2SIp
         iNDxH8+FrOaPtSWdhHyA4vtEmIcJ20euSIaEdS3lKimSrNjc6Hv1ca2iAzK9R7dNCCIT
         tqFdS1sftgNY0ZRlGkGpPFB8vs6axJLcMfZ0x26QFgRUbwDPfdTxjouT0eG3tnbCbLcV
         njXrOEkWOmckRDwBJ2vQNGv8nqQCIY1XI7JZ+m5GybJFYbiqD6ayIP79WxFVg4ysnOo1
         vtUw==
X-Gm-Message-State: APjAAAXRtfzyDywY4ItTWKGmDqmgoM+G43+81nOt3+fiIrqRvDSI2BKM
        tcPRDtxjiO2H8WM3dFWIfc5RaQ==
X-Google-Smtp-Source: APXvYqw9U4ggrZoHMOpQMj19wQXi/wH22fXuerlFlxpyhATQGhw0kJo/6SQDBWdmanESvrHTITjMkA==
X-Received: by 2002:a92:d151:: with SMTP id t17mr9221313ilg.175.1579715353190;
        Wed, 22 Jan 2020 09:49:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x10sm11006698ioh.11.2020.01.22.09.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:49:12 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
 <20200122045723.GC76712@redhat.com> <20200122115926.GW29276@dhcp22.suse.cz>
 <015647b0-360c-c9ac-ac20-405ae0ec4512@kernel.dk>
 <20200122165427.GA6009@redhat.com>
 <66027259-81c3-0bc4-a70b-74069e746058@kernel.dk>
 <20200122172842.GC6009@redhat.com>
 <00864312-13cc-daac-36e8-5f3f5b6dbeb8@kernel.dk>
 <20200122174059.GA7033@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0976dc63-dcb8-815b-7b2a-a0a5313f71ef@kernel.dk>
Date:   Wed, 22 Jan 2020 10:49:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122174059.GA7033@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/20 10:40 AM, Jerome Glisse wrote:
> On Wed, Jan 22, 2020 at 10:38:56AM -0700, Jens Axboe wrote:
>> On 1/22/20 10:28 AM, Jerome Glisse wrote:
>>> On Wed, Jan 22, 2020 at 10:04:44AM -0700, Jens Axboe wrote:
>>>> On 1/22/20 9:54 AM, Jerome Glisse wrote:
>>>>> On Wed, Jan 22, 2020 at 08:12:51AM -0700, Jens Axboe wrote:
>>>>>> On 1/22/20 4:59 AM, Michal Hocko wrote:
>>>>>>> On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
>>>>>>>> We can also discuss what kind of knobs we want to expose so that
>>>>>>>> people can decide to choose the tradeof themself (ie from i want low
>>>>>>>> latency io-uring and i don't care wether mm can not do its business; to
>>>>>>>> i want mm to never be impeded in its business and i accept the extra
>>>>>>>> latency burst i might face in io operations).
>>>>>>>
>>>>>>> I do not think it is a good idea to make this configurable. How can
>>>>>>> people sensibly choose between the two without deep understanding of
>>>>>>> internals?
>>>>>>
>>>>>> Fully agree, we can't just punt this to a knob and call it good, that's
>>>>>> a typical fallacy of core changes. And there is only one mode for
>>>>>> io_uring, and that's consistent low latency. If this change introduces
>>>>>> weird reclaim, compaction or migration latencies, then that's a
>>>>>> non-starter as far as I'm concerned.
>>>>>>
>>>>>> And what do those two settings even mean? I don't even know, and a user
>>>>>> sure as hell doesn't either.
>>>>>>
>>>>>> io_uring pins two types of pages - registered buffers, these are used
>>>>>> for actual IO, and the rings themselves. The rings are not used for IO,
>>>>>> just used to communicate between the application and the kernel.
>>>>>
>>>>> So, do we still want to solve file back pages write back if page in
>>>>> ubuffer are from a file ?
>>>>
>>>> That's not currently a concern for io_uring, as it disallows file backed
>>>> pages for the IO buffers that are being registered.
>>>>
>>>>> Also we can introduce a flag when registering buffer that allows to
>>>>> register buffer without pining and thus avoid the RLIMIT_MEMLOCK at
>>>>> the cost of possible latency spike. Then user registering the buffer
>>>>> knows what he gets.
>>>>
>>>> That may be fine for others users, but I don't think it'll apply
>>>> to io_uring. I can't see anyone selecting that flag, unless you're
>>>> doing something funky where you're registering a substantial amount
>>>> of the system memory for IO buffers. And I don't think that's going
>>>> to be a super valid use case...
>>>
>>> Given dataset are getting bigger and bigger i would assume that we
>>> will have people who want to use io-uring with large buffer.
>>>
>>>>
>>>>> Maybe it would be good to test, it might stay in the noise, then it
>>>>> might be a good thing to do. Also they are strategy to avoid latency
>>>>> spike for instance we can block/force skip mm invalidation if buffer
>>>>> has pending/running io in the ring ie only have buffer invalidation
>>>>> happens when there is no pending/running submission entry.
>>>>
>>>> Would that really work? The buffer could very well be idle right when
>>>> you check, but wanting to do IO the instant you decide you can do
>>>> background work on it. Additionally, that would require accounting
>>>> on when the buffers are inflight, which is exactly the kind of
>>>> overhead we're trying to avoid to begin with.
>>>>
>>>>> We can also pick what kind of invalidation we allow (compaction,
>>>>> migration, ...) and thus limit the scope and likelyhood of
>>>>> invalidation.
>>>>
>>>> I think it'd be useful to try and understand the use case first.
>>>> If we're pinning a small percentage of the system memory, do we
>>>> really care at all? Isn't it completely fine to just ignore?
>>>
>>> My main motivation is migration in NUMA system, if the process that
>>> did register buffer get migrated to a different node then it might
>>> actualy end up with bad performance because its io buffer are still
>>> on hold node. I am not sure we want to tell application developer to
>>> constantly monitor which node they are on and to re-register buffer
>>> after process migration to allow for memory migration.
>>
>> If the process truly cares, would it not have pinned itself to that
>> node?
> 
> Not necesarily, programmer can not thing of everything and also process

Node placement is generally the _first_ think you think of, though. It's
not like it's some esoteric thing that application developers don't know
anything about. Particularly if you're doing intensive IO, which you
probably are if you register buffers for use with io_uring. That ties to
a hardware device of some sort, or multiple ones. You would have placed
you memory local to that device as well.

> pinning defeat load balancing. Moreover we now have to thing about deep
> memory topology ie by the time you register the buffer the page backing
> it might be from slower memory and then all your io and CPU access will
> be stuck on using that.

To me, this sounds like some sort of event the application will want to
know about. And take appropriate measures.

-- 
Jens Axboe

