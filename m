Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6C2EF4A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 16:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhAHPOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 10:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHPOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:14:07 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79926C061380
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 07:13:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h3so2873898ils.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X+2UtfkBPnnuQuIwW1zRXENi1oQh+qwawjQ4qNtMfuA=;
        b=YoMmu5ev7dY1osTbWUw3P2STybQtJuUNz9f5bum2KnZ3dX6xr+5f5PanyCEqDINf+g
         m5EIp1ZSPhs2DmDz2qrXxe1ZYj3spBmUAAoMRgsrTvb14Ttp9H6EZMvfTH6ryhcVlrtd
         LyqlTflbomlsSbwsgVlCp53cIVSegkj/iPPFHecE5oS+GHNGNZfm+l4j7wOdon47JsW3
         DjIs1azSBt65lXIVePXAqBgjeB3/j5gsmchqe4McP2qxRASAEC2JJUDo04eVApq9O6zJ
         v1jY7X2hW50grC/S2+vMZ+hDsSzNQBIVQhU2PVDOz0S2bInPI5KNS4mRUlKmnHPhVo4p
         qiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+2UtfkBPnnuQuIwW1zRXENi1oQh+qwawjQ4qNtMfuA=;
        b=dJxewOQE+Fw9sKGMKeJtIGyPeqS7Lpceci9fDEHSDwO/dDh0k+fLnaaWTmoValWlvx
         xd3tuio7uWaU34p2gsTtmwTcxCTAz8dAZaIFNrf+lNmjk4uwn5sWr6gvcLl1oZAZFYu8
         jY+8YVq+QuyeHr2gqEF57Fy4KcuIk/xVkq2mx9I+jinpxCasCOc0123d2CCB6deSxJle
         c3fiIabWYgJTZuu6ZMpJelOGazW9i4CeH6Wqf2qqHrsLZMSYz02GVyDEGIUqfHhllTNj
         l5IigcUYGHFw78Ch1TrVZuQBPRV3DOBJiAK8MHMXWrKAqBnYwuTq/dNT8KPS/AABj1nN
         YEow==
X-Gm-Message-State: AOAM533Jwe5OMZVk3xwm+fujc0JlXG1OyhOr7Y84azkLUEndg1H0PwiN
        ItkPoE76c9cR0ZM2KbSTjki84g==
X-Google-Smtp-Source: ABdhPJznjNEDEk/j9wuKv0NcVeLmbsz0AfL8f6cqokNM9vGPJOSwga4qJijjuay4NFFsEAgmfmQKSA==
X-Received: by 2002:a92:b6c7:: with SMTP id m68mr4177599ill.95.1610118806707;
        Fri, 08 Jan 2021 07:13:26 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t2sm8305022ili.31.2021.01.08.07.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 07:13:26 -0800 (PST)
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <20210108064639.GN3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
Date:   Fri, 8 Jan 2021 08:13:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108064639.GN3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/21 11:46 PM, Al Viro wrote:
> On Fri, Jan 08, 2021 at 05:26:51AM +0000, Al Viro wrote:
>> On Tue, Jan 05, 2021 at 11:29:11AM -0700, Jens Axboe wrote:
>>> Song reported a boot regression in a kvm image with 5.11-rc, and bisected
>>> it down to the below patch. Debugging this issue, turns out that the boot
>>> stalled when a task is waiting on a pipe being released. As we no longer
>>> run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
>>> task goes idle without running the task_work. This prevents ->release()
>>> from being called on the pipe, which another boot task is waiting on.
>>>
>>> Use TWA_SIGNAL for the file fput work to ensure it's run before the task
>>> goes idle.
>>>
>>> Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
>>> Reported-by: Song Liu <songliubraving@fb.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> The other alternative here is obviously to re-instate the:
>>>
>>> if (unlikely(current->task_works))
>>> 	task_work_run();
>>>
>>> in get_signal() that we had before this change. Might be safer in case
>>> there are other cases that need to ensure the work is run in a timely
>>> fashion, though I do think it's cleaner to long term to correctly mark
>>> task_work with the needed notification type. Comments welcome...
>>
>> Interesting...  I think I've missed the discussion of that thing; could
>> you forward the relevant thread my way or give an archive link to it?

The initial report from Song was off list, and I just worked from that
to get to understanding the issue. Most of it is in the commit message,
but the debugging basically involved figuring out what the stuck task
was doing (it was in idle), and that it still had pending task_work. The
task_work was 5 entries of ____fput, with 4 being ext4 files, and 1
being a pipe. So that lead to the theory of the pipe not being released,
and hence why we were stuck.

> Actually, why do we need TWA_RESUME at all?  OK, a while ago you've added
> a way for task_work_add() to do wake_up_signal().  Fine, so if the sucker
> had been asleep in get_signal(), it gets woken up and the work gets run
> fast.  Irrelevant for those who did task_work_add() for themselves.
> With that commit, though, you've suddenly changed the default behaviour -
> now if you do that task_work_add() for current *and* get asleep in
> get_signal(), task_work_add() gets delayed - potentially for a very
> long time.

Right, this is why I brought up that we can re-instate the get_signal()
running task_work unconditionally as another way of fixing it, because
that change was inadvertently done as part of the commit that killed off
JOBCTL_TASK_WORK.

> Now the default (TWA_RESUME) has changed semantics; matter of fact,
> TWA_SIGNAL seems to be a lot closer than what we used to have.  I'm
> too sleepy right now to check if there are valid usecases for your new
> TWA_RESUME behaviour, but I very much doubt that old callers (before
> the TWA_RESUME/TWA_SIGNAL split) want that.
> 
> In particular, for mntput_no_expire() we definitely do *not* want
> that, same as with fput().  Same, AFAICS, for YAMA report_access().
> And for binder_deferred_fd_close().  And task_tick_numa() looks that
> way as well...
> 
> Anyway, bedtime for me; right now it looks like at least for task ==
> current we always want TWA_SIGNAL.  I'll look into that more tomorrow
> when I get up, but so far it smells like switching everything to
> TWA_SIGNAL would be the right thing to do, if not going back to bool
> notify for task_work_add()...

Before the change, the fact that we ran task_work off get_signal() and
thus processed even non-notify work in that path was a bit of a mess,
imho. If you have work that needs processing now, in the same manner as
signals, then you really should be using TWA_SIGNAL. For this pipe case,
and I'd need to setup and reproduce it again, the task must have a
signal pending and that would have previously caused the task_work to
run, and now it does not. TWA_RESUME technically didn't change its
behavior, it's still the same notification type, we just don't run
task_work unconditionally (regardless of notification type) from
get_signal().

I think the main question here is if we want to re-instate the behavior
of running task_work off get_signal(). I'm leaning towards not doing
that and ensuring that callers that DO need that are using TWA_SIGNAL.

-- 
Jens Axboe

