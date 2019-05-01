Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E332C107F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEAMlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 08:41:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAMlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 08:41:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so8253473pgh.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d7xrkUfJOvuEcy/MxrLHTxsIlMzizmM/IKOsgVzHrss=;
        b=2D6ufJKpjQs/C8AEiwpSbiA3m8Ey1zqeO2YTOGzalxj66UrmGjyo5LkL+iea0V0uj1
         rXqh2PCCr93pBAoDQk3UQoUV1u7E1uxJDxuX8fRYSGAh9AsRB/LD1Q6xMmIe9Kc4SsUW
         LPlnVFPB3EM/itW0PbBSPiyYFZhhC279Y4qOmGvJnP+l7KIeafILcW2KUM+0Rmk56SWy
         3lDw1GlRHQGOxkRRFfeIQkjZ1nfK6FBeTPQwSxJPChk66u3e5N2EnyW7r8YdZmHg/Zoo
         GuEHS8pKxD2o8tMKXr/zHOCuYnBrHgDjRRTnJvBQvDVKfAs5ULXfq88R8MeIDTzSPZZa
         AYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d7xrkUfJOvuEcy/MxrLHTxsIlMzizmM/IKOsgVzHrss=;
        b=qRhn9clE0h9V4W7c5SZE/o/bX7cjzNJx7PhUzU+WvAYGIpeg0qu+0Eha5/e+SAJ0IZ
         CbMNLuG7c431oEsO21mmNX+IOFlMatOjDEcL/6Wx52yQaAjlMOYA5slZ8NzluRaPV1VN
         2Xfv4IEMwKrsen0RJ1kQiAhR+OajzVQjtlMQpKCHmY2463+fv4f/hVa4uqOWzg0mRCXd
         HgSHhZ6dLqWtdcUzdDS/NbO5SOUmRlXl9lYB6MpkuAZi1i+7CJWgqqYev6X+yxWJfuYr
         TWjY5qA2o1rqpfVKBCppkDc39HrSGSUxjx2PEX+hLiVoaN8iqkrrZxnHA36g2YXbhLrO
         FWZg==
X-Gm-Message-State: APjAAAUk3j/f1xDztGWRzLjgLIq/PI/1D6WamZLxBZfB1AVUc5atZmgI
        FwywwvCysFJOSTwfNezHWrRbgXZVRT5OQw==
X-Google-Smtp-Source: APXvYqxiVh/AS1A6oCylujU5bu05ckHS24lp5QIeAn+fda0wU+Co39UgF4zixKjC7SC2pxOJHAvKGA==
X-Received: by 2002:a63:8a4a:: with SMTP id y71mr30200038pgd.270.1556714506557;
        Wed, 01 May 2019 05:41:46 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m131sm577985pfc.25.2019.05.01.05.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:41:45 -0700 (PDT)
Subject: Re: [PATCH] io_uring: avoid page allocation warnings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190430132405.8268-1-mark.rutland@arm.com>
 <20190430141810.GF13796@bombadil.infradead.org>
 <20190430145938.GA8314@lakrids.cambridge.arm.com>
 <a1af3017-6572-e828-dc8a-a5c8458e6b5a@kernel.dk>
 <20190430170302.GD8314@lakrids.cambridge.arm.com>
 <0bd395a0-e0d3-16a5-e29f-557e97782a48@kernel.dk>
 <20190501103026.GA11740@lakrids.cambridge.arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <710a3048-ccab-260d-d8b7-1d51ff6d589d@kernel.dk>
Date:   Wed, 1 May 2019 06:41:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501103026.GA11740@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 4:30 AM, Mark Rutland wrote:
> On Tue, Apr 30, 2019 at 12:11:59PM -0600, Jens Axboe wrote:
>> On 4/30/19 11:03 AM, Mark Rutland wrote:
>>> On Tue, Apr 30, 2019 at 10:21:03AM -0600, Jens Axboe wrote:
>>>> On 4/30/19 8:59 AM, Mark Rutland wrote:
>>>>> On Tue, Apr 30, 2019 at 07:18:10AM -0700, Matthew Wilcox wrote:
>>>>>> On Tue, Apr 30, 2019 at 02:24:05PM +0100, Mark Rutland wrote:
>>>>>>> In io_sqe_buffer_register() we allocate a number of arrays based on the
>>>>>>> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
>>>>>>> we can still attempt to allocate arrays exceeding MAX_ORDER.
>>>>>>>
>>>>>>> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
>>>>>>> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
>>>>>>> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
>>>>>>> bytes, which is greater than 4MiB. This results in SLUB warning that
>>>>>>> we're trying to allocate greater than MAX_ORDER, and failing the
>>>>>>> allocation.
>>>>>>>
>>>>>>> Avoid this by passing __GFP_NOWARN when allocating arrays for the
>>>>>>> user-provided iov_len. We'll gracefully handle the failed allocation,
>>>>>>> returning -ENOMEM to userspace.
>>>>>>>
>>>>>>> We should probably consider lowering the limit below SZ_1G, or reworking
>>>>>>> the array allocations.
>>>>>>
>>>>>> I'd suggest that kvmalloc is probably our friend here ... we don't really
>>>>>> want to return -ENOMEM to userspace for this case, I don't think.
>>>>>
>>>>> Sure. I'll go verify that the uring code doesn't assume this memory is
>>>>> physically contiguous.
>>>>>
>>>>> I also guess we should be passing GFP_KERNEL_ACCOUNT rateh than a plain
>>>>> GFP_KERNEL.
>>>>
>>>> kvmalloc() is fine, the io_uring code doesn't care about the layout of
>>>> the memory, it just uses it as an index.
>>>
>>> I've just had a go at that, but when using kvmalloc() with or without
>>> GFP_KERNEL_ACCOUNT I hit OOM and my system hangs within a few seconds with the
>>> syzkaller prog below:
>>>
>>> ----
>>> Syzkaller reproducer:
>>> # {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 EnableTun:false EnableNetDev:false EnableNetReset:false EnableCgroups:false EnableBinfmtMisc:false EnableCloseFds:false UseTmpDir:false HandleSegv:false Repro:false Trace:false}
>>> r0 = io_uring_setup(0x378, &(0x7f00000000c0))
>>> sendmsg$SEG6_CMD_SET_TUNSRC(0xffffffffffffffff, &(0x7f0000000240)={&(0x7f0000000000)={0x10, 0x0, 0x0, 0x40000000}, 0xc, 0x0, 0x1, 0x0, 0x0, 0x10}, 0x800)
>>> io_uring_register$IORING_REGISTER_BUFFERS(r0, 0x0, &(0x7f0000000000), 0x1)
>>> ----
>>>
>>> ... I'm a bit worried that opens up a trivial DoS.
>>>
>>> Thoughts?
>>
>> Can you post the patch you used?
> 
> Diff below.

And the reproducer, that was never posted. Patch looks fine to me. Note
that buffer registration is under the protection of RLIMIT_MEMLOCK.
That's usually very limited for non-root, as root you can of course
consume as much as you want and OOM the system.

-- 
Jens Axboe

