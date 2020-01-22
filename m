Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282AA145A89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAVREr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:04:47 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41995 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVREr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:04:47 -0500
Received: by mail-il1-f195.google.com with SMTP id t2so5668725ilq.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 09:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWTQKsARJ+uzj6OBD4b66jlpFw8cyx0abxQgN3Kvgv4=;
        b=dHkKEGgH54CBLZcJKvkkdgLaX01WGN/ZkqqVq/hZ+7IW8DzAblc0STtyXBWwiXD3re
         ir+Y3SK4pmMtj4lXy+HYCLfETcVl5XG5H39kbu+tQg/ZmqNzhhA5K6QOXUkY5N8SwJNf
         RqEHAPiBkazaRBkEOHjp5RuoIae2CwZfsQy20mQ9OyJ2kNyRH9zUHiH5YuRVT0QAso7w
         ci3MPZx0ieZpFehxt02qM5jX+YrT9AQL617YjVdlNna060vWuSajOrq9rVkNM8/wMu4D
         WZBHeiLRMrf5XM3QPKG7vRRvHz8ybnJGHs9T45NlL8ThyzvQGV41ikLhiLCBkS30zHE6
         1eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWTQKsARJ+uzj6OBD4b66jlpFw8cyx0abxQgN3Kvgv4=;
        b=OUT7SuhQkiIw6ZheOsaFtRNd9+0s/vgou5QspU3lg0j5TPrFEJHYwJ4CXIGIZwhXJ9
         kPkCZ9BhR6JscS7004MvD0TfcQf2uuD3iI/SyEssOU5Y0sDLGFy8ZHeWSyG7bxmRt6xl
         arXYk7GxiY09y7qfTN+u/qWpXSSDDGNo2BlNB8NMU0w01fWKr5XOtnowgvUaqbvJA6y5
         KHoYP82c5mI/r4m+aeXwGqtxzVz5XHorUFJcGdKQ4zhs6I2wJPAblaZuCCClcjAqIRW6
         eHV/PQlCracAl3Bk4ELSRDWooLnctctywt6+4wJj5EWoY1DhwXTgtvoOMCLbQ97FmryO
         ytOw==
X-Gm-Message-State: APjAAAVeGVddRu9BX/MSwDyERJbRRKXTomoYjsNmPwHYrJEPA8UNsamL
        qyQwHWIC8ETnoWjdZajFpgh1LafHwYI=
X-Google-Smtp-Source: APXvYqypbMgNnhw5DUBINcLHTOLuL/DfhR+ZyDBtkYwX3VNVbXnCvUAZDLZCrkPuGPkzGVNHJrTKLg==
X-Received: by 2002:a92:d642:: with SMTP id x2mr8909980ilp.169.1579712686373;
        Wed, 22 Jan 2020 09:04:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q1sm10959011iog.8.2020.01.22.09.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:04:45 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66027259-81c3-0bc4-a70b-74069e746058@kernel.dk>
Date:   Wed, 22 Jan 2020 10:04:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122165427.GA6009@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/20 9:54 AM, Jerome Glisse wrote:
> On Wed, Jan 22, 2020 at 08:12:51AM -0700, Jens Axboe wrote:
>> On 1/22/20 4:59 AM, Michal Hocko wrote:
>>> On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
>>>> We can also discuss what kind of knobs we want to expose so that
>>>> people can decide to choose the tradeof themself (ie from i want low
>>>> latency io-uring and i don't care wether mm can not do its business; to
>>>> i want mm to never be impeded in its business and i accept the extra
>>>> latency burst i might face in io operations).
>>>
>>> I do not think it is a good idea to make this configurable. How can
>>> people sensibly choose between the two without deep understanding of
>>> internals?
>>
>> Fully agree, we can't just punt this to a knob and call it good, that's
>> a typical fallacy of core changes. And there is only one mode for
>> io_uring, and that's consistent low latency. If this change introduces
>> weird reclaim, compaction or migration latencies, then that's a
>> non-starter as far as I'm concerned.
>>
>> And what do those two settings even mean? I don't even know, and a user
>> sure as hell doesn't either.
>>
>> io_uring pins two types of pages - registered buffers, these are used
>> for actual IO, and the rings themselves. The rings are not used for IO,
>> just used to communicate between the application and the kernel.
> 
> So, do we still want to solve file back pages write back if page in
> ubuffer are from a file ?

That's not currently a concern for io_uring, as it disallows file backed
pages for the IO buffers that are being registered.

> Also we can introduce a flag when registering buffer that allows to
> register buffer without pining and thus avoid the RLIMIT_MEMLOCK at
> the cost of possible latency spike. Then user registering the buffer
> knows what he gets.

That may be fine for others users, but I don't think it'll apply
to io_uring. I can't see anyone selecting that flag, unless you're
doing something funky where you're registering a substantial amount
of the system memory for IO buffers. And I don't think that's going
to be a super valid use case...

> Maybe it would be good to test, it might stay in the noise, then it
> might be a good thing to do. Also they are strategy to avoid latency
> spike for instance we can block/force skip mm invalidation if buffer
> has pending/running io in the ring ie only have buffer invalidation
> happens when there is no pending/running submission entry.

Would that really work? The buffer could very well be idle right when
you check, but wanting to do IO the instant you decide you can do
background work on it. Additionally, that would require accounting
on when the buffers are inflight, which is exactly the kind of
overhead we're trying to avoid to begin with.

> We can also pick what kind of invalidation we allow (compaction,
> migration, ...) and thus limit the scope and likelyhood of
> invalidation.

I think it'd be useful to try and understand the use case first.
If we're pinning a small percentage of the system memory, do we
really care at all? Isn't it completely fine to just ignore?

-- 
Jens Axboe

