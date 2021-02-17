Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1DA31D42E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 04:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBQDMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 22:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBQDMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 22:12:17 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D5C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 19:11:37 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b21so7606758pgk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 19:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4utzFdmE/sMU637scLRb8aqgr5WIQGeIEUnlpvA+fVE=;
        b=jL6kr8T2tsLR6aeTV0vFYQxgfGXHXK90qWnRdXxZLpW1pFSReTUNy9k+Vq1kZ3a2ha
         uHWvU15buxx2IM+ZtPmfuSuclmmz6ldalSJn/OTETdENh9QUW8a7KpwbdjWPFesqV/7M
         A1Pe9W4fbYXFktA3oOW+CfQ0BMonMp6FwDfFd25BHSn+ey+x0upBjC3ghughCupD83nL
         sjfPKIlXOhr9eAm6lNGBDx9+57wzt5xXhp7uAsKROmLcSURAIAYR8mMTnSK6voRUC7gQ
         Jy6X/YZQoOSi7YeVuQnHCCdXx+fzdVEwuXFnOlk34fupnBvLZscqQ1g2EIzMUqXmLTkp
         cIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4utzFdmE/sMU637scLRb8aqgr5WIQGeIEUnlpvA+fVE=;
        b=X5nlumH7YXja9zivhhnrLjSZ6Yt/oua7lP0XtAso/QAxceNG6rGg/t+6pkWAFWcJw3
         sLcP+prfvIXc7os1ukQ0EJuao6NUlzzvRSWuexYAU8dM99/xGKJFded8g7Nr21vpTVxD
         dVvWNVxXMmaK7nfirUUQ7aB+2fYmZV3FxUm/y/TeQ2xj1ZoNa/Bd0x9g8PrxQ5l+JwZS
         rAwavxT9+/ff5N+ZoHOTBwl83q4un4t24iytksr0xq5tI3Rl9YRQrXLISVd3484fVoXr
         LLKmD3WoITR8qNGnOsYXzWZ8dy3AoCc74DYZE5+nRpp3Fd4tUHPx9pnYlh4mF6rCwahD
         G3jQ==
X-Gm-Message-State: AOAM532AZKc6OeRDFP7HnMPYhCXYoUVGcnF24mOmPFJDqB6VXfmsTAXP
        4MNMfm6o7+ojUQpYDWAPg6IoHw==
X-Google-Smtp-Source: ABdhPJylKlCWkV/cu5S0sYm4Ggwi9yf7QBAqq5SWw+GKJ+8vdzzfvtApALWCs4FBTlnekWEszNYPwA==
X-Received: by 2002:a63:343:: with SMTP id 64mr22238705pgd.232.1613531496808;
        Tue, 16 Feb 2021 19:11:36 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j1sm319300pjf.26.2021.02.16.19.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 19:11:36 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
From:   Jens Axboe <axboe@kernel.dk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
 <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
 <m11rdhurvp.fsf@fess.ebiederm.org>
 <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
 <e3335211-83f2-5305-9601-663cc2a73427@kernel.dk>
 <m1r1lht0lo.fsf@fess.ebiederm.org>
 <99b642d3-6a38-af68-b99d-44efcf0b13a5@kernel.dk>
 <9d9b5143-6b26-49d4-a11a-b21c020d5886@kernel.dk>
 <86cd3801-dfb4-833a-b7e6-e643186030e7@kernel.dk>
Message-ID: <0cdf16a5-3efb-dea0-303c-bbfbe880ca7a@kernel.dk>
Date:   Tue, 16 Feb 2021 20:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86cd3801-dfb4-833a-b7e6-e643186030e7@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 6:26 PM, Jens Axboe wrote:
> On 2/16/21 6:18 PM, Jens Axboe wrote:
>> On 2/15/21 7:41 PM, Jens Axboe wrote:
>>> On 2/15/21 3:41 PM, Eric W. Biederman wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> On 2/15/21 11:24 AM, Jens Axboe wrote:
>>>>>> On 2/15/21 11:07 AM, Eric W. Biederman wrote:
>>>>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>>>>>
>>>>>>>> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>>
>>>>>>>>>> Similarly it looks like opening of "/dev/tty" fails to
>>>>>>>>>> return the tty of the caller but instead fails because
>>>>>>>>>> io-wq threads don't have a tty.
>>>>>>>>>
>>>>>>>>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>>>>>>>>> thread if not explicitly inherited, and I'm working on similarly
>>>>>>>>> proactively catching these cases that could potentially be problematic.
>>>>>>>>
>>>>>>>> Well, the /dev/tty case still needs fixing somehow.
>>>>>>>>
>>>>>>>> Opening /dev/tty actually depends on current->signal, and if it is
>>>>>>>> NULL it will fall back on the first VT console instead (I think).
>>>>>>>>
>>>>>>>> I wonder if it should do the same thing /proc/self does..
>>>>>>>
>>>>>>> Would there be any downside of making the io-wq kernel threads be per
>>>>>>> process instead of per user?
>>>>>>>
>>>>>>> I can see a lower probability of a thread already existing.  Are there
>>>>>>> other downsides I am missing?
>>>>>>>
>>>>>>> The upside would be that all of the issues of have we copied enough
>>>>>>> should go away, as the io-wq thread would then behave like another user
>>>>>>> space thread.  To handle posix setresuid() and friends it looks like
>>>>>>> current_cred would need to be copied but I can't think of anything else.
>>>>>>
>>>>>> I really like that idea. Do we currently have a way of creating a thread
>>>>>> internally, akin to what would happen if the same task did pthread_create?
>>>>>> That'd ensure that we have everything we need, without actively needing to
>>>>>> map the request types, or find future issues of "we also need this bit".
>>>>>> It'd work fine for the 'need new worker' case too, if one goes to sleep.
>>>>>> We'd just 'fork' off that child.
>>>>>>
>>>>>> Would require some restructuring of io-wq, but at the end of it, it'd
>>>>>> be a simpler solution.
>>>>>
>>>>> I was intrigued enough that I tried to wire this up. If we can pull this
>>>>> off, then it would take a great weight off my shoulders as there would
>>>>> be no more worries on identity.
>>>>>
>>>>> Here's a branch that's got a set of patches that actually work, though
>>>>> it's a bit of a hack in spots. Notes:
>>>>>
>>>>> - Forked worker initially crashed, since it's an actual user thread and
>>>>>   bombed on deref of kernel structures. Expectedly. That's what the
>>>>>   horrible kernel_clone_args->io_wq hack is working around for now.
>>>>>   Obviously not the final solution, but helped move things along so
>>>>>   I could actually test this.
>>>>>
>>>>> - Shared io-wq helpers need indexing for task, right now this isn't
>>>>>   done. But that's not hard to do.
>>>>>
>>>>> - Idle thread reaping isn't done yet, so they persist until the
>>>>>   context goes away.
>>>>>
>>>>> - task_work fallback needs a bit of love. Currently we fallback to
>>>>>   the io-wq manager thread for handling that, but a) manager is gone,
>>>>>   and b) the new workers are now threads and go away as well when
>>>>>   the original task goes away. None of the three fallback sites need
>>>>>   task context, so likely solution here is just punt it to system_wq.
>>>>>   Not the hot path, obviously, we're exiting.
>>>>>
>>>>> - Personality registration is broken, it's just Good Enough to compile.
>>>>>
>>>>> Probably a few more items that escape me right now. As long as you
>>>>> don't hit the fallback cases, it appears to work fine for me. And
>>>>> the diffstat is pretty good to:
>>>>>
>>>>>  fs/io-wq.c                 | 418 +++++++++++--------------------------
>>>>>  fs/io-wq.h                 |  10 +-
>>>>>  fs/io_uring.c              | 314 +++-------------------------
>>>>>  fs/proc/self.c             |   7 -
>>>>>  fs/proc/thread_self.c      |   7 -
>>>>>  include/linux/io_uring.h   |  19 --
>>>>>  include/linux/sched.h      |   3 +
>>>>>  include/linux/sched/task.h |   1 +
>>>>>  kernel/fork.c              |   2 +
>>>>>  9 files changed, 161 insertions(+), 620 deletions(-)
>>>>>
>>>>> as it gets rid of _all_ the 'grab this or that piece' that we're
>>>>> tracking.
>>>>>
>>>>> WIP series here:
>>>>>
>>>>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-worker
>>>>
>>>> I took a quick look through the code and in general it seems reasonable.
>>>
>>> Great, thanks for checking.
>>
>> Cleaner series here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-worker.v2
>>
>> One question, since I'm a bit stumped. The very top most debug patch:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-worker.v2&id=8a422f030b9630d16d5ec1ff97842a265f88485e
>>
>> any idea what is going on here? For some reason, it only happens for
>> the 'manager' thread. That one doesn't do any work by itself, it's just
>> tasked with forking a new worker, if we need one.
> 
> Seems to trigger for all cases with a pthread in the app. This reproduces
> it:

Nevermind, it was me being an idiot. I had a case in the manager thread
that did return 0 instead of do_exit()...

-- 
Jens Axboe

