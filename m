Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098B31C36A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 22:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBOVKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 16:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBOVKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:10:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCACC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 13:09:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl8so4424725pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Feb 2021 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/lCUWFFPBiG6xDU/VlsxBfehqYtCoeUEsftRxJfTUHk=;
        b=Ai5RPdGwa95HuvW4aTu4uj8jkn1V1sMXh9ygW5zhGWa3Q/ErDayfYh6G5lcOq4/Xov
         MCzm3e9Euh+5gBRRZxqyliifnlWessuCtxvD47JahqmDFMGlyd+n8Zr+F7FRp47BYcRW
         x5PAjj/hROaZAA03C37hI/o5U6ANgxZEe+zrfwmSJit/z5nR5Rpkp5Jr+Gn+yQxIjCKy
         UO7EwxXYhgJVAQDgulXGteI613iBn17vQB80THXdNeory4rqZntlk31keeAkBJj2l0Kb
         YI3Wa4No1/zRws7sZovaCo2F5pYnmJBRmV3Upwl0SWdyg9FRnuKBwXCSlH7/TlIUuzXX
         ov5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/lCUWFFPBiG6xDU/VlsxBfehqYtCoeUEsftRxJfTUHk=;
        b=BUCUD3sDJLy0/YWs4RY5PmBU2iQDRFyuJyBCuozxKzRYTU3OPdol93uWtCsFhxhatX
         3uz4m78bzmjB/eCZLDrB7B43ToLfFs80OfLWBfRP2r3dJMhsPwOFwz3QlJF93R01MSpk
         pGVBMpfwXom4WTiMeUE9Q1uoRnoiQ1+TubMaWbQfJp6kQmFYwKQv7sOByYgRBUu4Cp3/
         W7BiHSCMo+t7jytKqaMq6zKK0L2KASkYL8Oe2VWaBi8htI/HqueSoLBI0y1OhQnHfFWK
         LN19lYbB+86IPQTVqe8lUq0eehyJC1jxxUDove4tjZDFJaDB3jKen6PsNZd7cv3Vq+A0
         PtTg==
X-Gm-Message-State: AOAM532HO2/Rl2q2JrCDFy1Wjdo0IC4B39YpOq+zYob73/jxybAxxcUQ
        UF/x4sY0In9joaOxD7dKaAWvGw==
X-Google-Smtp-Source: ABdhPJwpGwRJOatMojd+A/NjRMrIZsqjWAvu5Pn170CTUI2TR5puqx0Ek274ry4sz5NKG+l9ZYU0zg==
X-Received: by 2002:a17:90a:f2d8:: with SMTP id gt24mr643048pjb.167.1613423360827;
        Mon, 15 Feb 2021 13:09:20 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d12sm18954643pgm.83.2021.02.15.13.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 13:09:20 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
From:   Jens Axboe <axboe@kernel.dk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
 <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
 <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
 <m11rdhurvp.fsf@fess.ebiederm.org>
 <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
Message-ID: <e3335211-83f2-5305-9601-663cc2a73427@kernel.dk>
Date:   Mon, 15 Feb 2021 14:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/15/21 11:24 AM, Jens Axboe wrote:
> On 2/15/21 11:07 AM, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>> Similarly it looks like opening of "/dev/tty" fails to
>>>>> return the tty of the caller but instead fails because
>>>>> io-wq threads don't have a tty.
>>>>
>>>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>>>> thread if not explicitly inherited, and I'm working on similarly
>>>> proactively catching these cases that could potentially be problematic.
>>>
>>> Well, the /dev/tty case still needs fixing somehow.
>>>
>>> Opening /dev/tty actually depends on current->signal, and if it is
>>> NULL it will fall back on the first VT console instead (I think).
>>>
>>> I wonder if it should do the same thing /proc/self does..
>>
>> Would there be any downside of making the io-wq kernel threads be per
>> process instead of per user?
>>
>> I can see a lower probability of a thread already existing.  Are there
>> other downsides I am missing?
>>
>> The upside would be that all of the issues of have we copied enough
>> should go away, as the io-wq thread would then behave like another user
>> space thread.  To handle posix setresuid() and friends it looks like
>> current_cred would need to be copied but I can't think of anything else.
> 
> I really like that idea. Do we currently have a way of creating a thread
> internally, akin to what would happen if the same task did pthread_create?
> That'd ensure that we have everything we need, without actively needing to
> map the request types, or find future issues of "we also need this bit".
> It'd work fine for the 'need new worker' case too, if one goes to sleep.
> We'd just 'fork' off that child.
> 
> Would require some restructuring of io-wq, but at the end of it, it'd
> be a simpler solution.

I was intrigued enough that I tried to wire this up. If we can pull this
off, then it would take a great weight off my shoulders as there would
be no more worries on identity.

Here's a branch that's got a set of patches that actually work, though
it's a bit of a hack in spots. Notes:

- Forked worker initially crashed, since it's an actual user thread and
  bombed on deref of kernel structures. Expectedly. That's what the
  horrible kernel_clone_args->io_wq hack is working around for now.
  Obviously not the final solution, but helped move things along so
  I could actually test this.

- Shared io-wq helpers need indexing for task, right now this isn't
  done. But that's not hard to do.

- Idle thread reaping isn't done yet, so they persist until the
  context goes away.

- task_work fallback needs a bit of love. Currently we fallback to
  the io-wq manager thread for handling that, but a) manager is gone,
  and b) the new workers are now threads and go away as well when
  the original task goes away. None of the three fallback sites need
  task context, so likely solution here is just punt it to system_wq.
  Not the hot path, obviously, we're exiting.

- Personality registration is broken, it's just Good Enough to compile.

Probably a few more items that escape me right now. As long as you
don't hit the fallback cases, it appears to work fine for me. And
the diffstat is pretty good to:

 fs/io-wq.c                 | 418 +++++++++++--------------------------
 fs/io-wq.h                 |  10 +-
 fs/io_uring.c              | 314 +++-------------------------
 fs/proc/self.c             |   7 -
 fs/proc/thread_self.c      |   7 -
 include/linux/io_uring.h   |  19 --
 include/linux/sched.h      |   3 +
 include/linux/sched/task.h |   1 +
 kernel/fork.c              |   2 +
 9 files changed, 161 insertions(+), 620 deletions(-)

as it gets rid of _all_ the 'grab this or that piece' that we're
tracking.

WIP series here:

https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-worker

-- 
Jens Axboe

