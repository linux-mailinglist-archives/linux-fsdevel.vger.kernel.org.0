Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97603145AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVRi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:38:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35307 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:38:59 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so124761iob.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lP2CiE/Dv9A81bCmQ9A7d4Ky3RGHEzsgYjmIMGQQjyM=;
        b=TeVaIzJo8wgHeIHA0VcuSTzyZJrvlOY1ugfTi2vHttyOSLa0W4FEpBMRUgY6ZUQ/Pm
         nsGLpC3J4g0bVQL/K4LxQ48eYvXWFWd3CSUTG524OcsHvs1r8HMoUluhzYRQlX+/KXYu
         JRDOrKm+/Dx18AWheGJ7IvmPlKpvkGJt4IQtC0WjI1vrUrycyY+3llLXWxlQEH0f1h6M
         Ct2YPkfFhiYowl8NOFvdmRMYo/d/mo01cj1O15Q7iIzFdv1B/I8q+zUGLqoHa+8dfbMK
         QB0gNSMykNrTFEbZqEYl0ka+c0yWTvk+iNrGvi/RgGMtlIduXD1ccE463y4LV3k4/m+K
         u2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lP2CiE/Dv9A81bCmQ9A7d4Ky3RGHEzsgYjmIMGQQjyM=;
        b=lWPCXdSKkIWqyejmqG+0d0GiUK7CNxZZWgZk0vEgDm8+IRLEwsvA+Pqg4dpEfcDobb
         j1T/sGlKwjQIFJSDhVLOK9Ta4ZsnH2enr73xX0v4/gLli8Xjnx4ofYAs4LjbMJLyJwPp
         9mj/0U7DlUBKt9JY56X2st1dDGe48IcOrsd5h/nzHeHW7hqVuRgO14vEDsYYvoxeLIE6
         nBUwNBWk/hIZl+iwa7Vdx885I/QIaAybRQG1E9ysTh/O3dhR+PUniuw2AhdF77OCZt2A
         JlK3vQWo0pUokSLz5Vt9mXpO+AqwK5cN3HuxsOhOfFaKbzLGci+MsbU/cwg+xvYFicrO
         drtg==
X-Gm-Message-State: APjAAAXO9En23pw8ijmVSjF+EJZByv7L4xKszgApkiH2kVjLMaVtW7nA
        c+VMQBXUVr2ACgwERJriMQuNdQ==
X-Google-Smtp-Source: APXvYqz/kL/ghy3fY4RSOXWZ+rEpBJLRNX6G/0RImBDoQRPIGsPAg169Td2FmB7qvx4CfBli/E2kiA==
X-Received: by 2002:a6b:4407:: with SMTP id r7mr7076484ioa.160.1579714738247;
        Wed, 22 Jan 2020 09:38:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m24sm10982139ioc.37.2020.01.22.09.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:38:57 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00864312-13cc-daac-36e8-5f3f5b6dbeb8@kernel.dk>
Date:   Wed, 22 Jan 2020 10:38:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122172842.GC6009@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/20 10:28 AM, Jerome Glisse wrote:
> On Wed, Jan 22, 2020 at 10:04:44AM -0700, Jens Axboe wrote:
>> On 1/22/20 9:54 AM, Jerome Glisse wrote:
>>> On Wed, Jan 22, 2020 at 08:12:51AM -0700, Jens Axboe wrote:
>>>> On 1/22/20 4:59 AM, Michal Hocko wrote:
>>>>> On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
>>>>>> We can also discuss what kind of knobs we want to expose so that
>>>>>> people can decide to choose the tradeof themself (ie from i want low
>>>>>> latency io-uring and i don't care wether mm can not do its business; to
>>>>>> i want mm to never be impeded in its business and i accept the extra
>>>>>> latency burst i might face in io operations).
>>>>>
>>>>> I do not think it is a good idea to make this configurable. How can
>>>>> people sensibly choose between the two without deep understanding of
>>>>> internals?
>>>>
>>>> Fully agree, we can't just punt this to a knob and call it good, that's
>>>> a typical fallacy of core changes. And there is only one mode for
>>>> io_uring, and that's consistent low latency. If this change introduces
>>>> weird reclaim, compaction or migration latencies, then that's a
>>>> non-starter as far as I'm concerned.
>>>>
>>>> And what do those two settings even mean? I don't even know, and a user
>>>> sure as hell doesn't either.
>>>>
>>>> io_uring pins two types of pages - registered buffers, these are used
>>>> for actual IO, and the rings themselves. The rings are not used for IO,
>>>> just used to communicate between the application and the kernel.
>>>
>>> So, do we still want to solve file back pages write back if page in
>>> ubuffer are from a file ?
>>
>> That's not currently a concern for io_uring, as it disallows file backed
>> pages for the IO buffers that are being registered.
>>
>>> Also we can introduce a flag when registering buffer that allows to
>>> register buffer without pining and thus avoid the RLIMIT_MEMLOCK at
>>> the cost of possible latency spike. Then user registering the buffer
>>> knows what he gets.
>>
>> That may be fine for others users, but I don't think it'll apply
>> to io_uring. I can't see anyone selecting that flag, unless you're
>> doing something funky where you're registering a substantial amount
>> of the system memory for IO buffers. And I don't think that's going
>> to be a super valid use case...
> 
> Given dataset are getting bigger and bigger i would assume that we
> will have people who want to use io-uring with large buffer.
> 
>>
>>> Maybe it would be good to test, it might stay in the noise, then it
>>> might be a good thing to do. Also they are strategy to avoid latency
>>> spike for instance we can block/force skip mm invalidation if buffer
>>> has pending/running io in the ring ie only have buffer invalidation
>>> happens when there is no pending/running submission entry.
>>
>> Would that really work? The buffer could very well be idle right when
>> you check, but wanting to do IO the instant you decide you can do
>> background work on it. Additionally, that would require accounting
>> on when the buffers are inflight, which is exactly the kind of
>> overhead we're trying to avoid to begin with.
>>
>>> We can also pick what kind of invalidation we allow (compaction,
>>> migration, ...) and thus limit the scope and likelyhood of
>>> invalidation.
>>
>> I think it'd be useful to try and understand the use case first.
>> If we're pinning a small percentage of the system memory, do we
>> really care at all? Isn't it completely fine to just ignore?
> 
> My main motivation is migration in NUMA system, if the process that
> did register buffer get migrated to a different node then it might
> actualy end up with bad performance because its io buffer are still
> on hold node. I am not sure we want to tell application developer to
> constantly monitor which node they are on and to re-register buffer
> after process migration to allow for memory migration.

If the process truly cares, would it not have pinned itself to that
node?

-- 
Jens Axboe

