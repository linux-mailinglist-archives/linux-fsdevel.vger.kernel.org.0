Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC52805AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgJARll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:41:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612F3C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 10:41:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so3419948qvb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZofCg13yLWp9YkcfWHeM2EVyf7huzbOKlDUFq+SgIvU=;
        b=rl/zS8brBtaLxquA3OagcFiCh6dyqCzWuD0VZe+C4VKXQKSd9SSo/wdg8iShVQgJNm
         BEnvV0jz5r8JDnOW41ip91uz6SXnYFH4GeU/8vAkmFmBH3N4kF9yzstg4qS8Fl4SNeW4
         OFMwNzTqI74jAA5nGzRTdalNjAFdj+Prl+JwlrESaVQ91glsOTzlvhiRYlTQCNt3EJvp
         9xRVCHqdHynxq5vrm1OuxCttKHzcD0vUP+r8p2ih+FY5++0Ri7gHUGDD5LktohhYXKDc
         kXWdYS1kb/GIdD2aoTnXvfbj2yriDz8Z16EFMaojNGddwBh2uxLxI5nrC1AmeWUTWSSn
         Gnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZofCg13yLWp9YkcfWHeM2EVyf7huzbOKlDUFq+SgIvU=;
        b=cLS88e32rSVPcuqbAKL3vsZMov5IDqv8sZH3SF9gGVpF8CAoHMI7LJHFj3TV7Wi+Xt
         ainrGQVmNUOFmsSY6t1bcEful2UKQ5JFi9yk/xvhd01FbDoX9FtD8qVvjn8/yqCvN1z8
         xTM1tu2oishYNxsK/OweZNQSmGP8Qp7HIuY23F+zMzlSvlabeKLh+13ciu55Y3E+mgfE
         pk+itVEDS48P852jI4Xc5qGAl8Ibt5usyKKfRzk7QUc0503In2a3PpFSrIVRPpNnn5BS
         nKsuwMjjacPRTaKPwoO5uOnYnxG75sEVBNT7yanrluaYWJHPuyCAllYjgPeGTeM4tqiJ
         uRJQ==
X-Gm-Message-State: AOAM532YUw/UAcZQEpt3XYkhsEoWpMTnq+bpeJIRirAkuytQlDfxx+By
        tJ6LLQIjQzuaMVaCP6I7pIRUrda8Sdiy106l
X-Google-Smtp-Source: ABdhPJxG9jG/hjuPTkJQweujWDIHKaGaXaAPTPimOzSK5fCbO3QkoPuvu+jd1IAPlZbE6xyC2WB5Ow==
X-Received: by 2002:a0c:9d03:: with SMTP id m3mr8773452qvf.54.1601574095215;
        Thu, 01 Oct 2020 10:41:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a77sm6790034qkg.15.2020.10.01.10.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 10:41:34 -0700 (PDT)
Subject: Re: [PATCH] pipe: fix hang when racing with a wakeup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <bfa88b5ad6f069b2b679316b9e495a970130416c.1601567868.git.josef@toxicpanda.com>
 <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <eb829164-8035-92ee-e7ba-8e6b062ab1d8@toxicpanda.com>
Date:   Thu, 1 Oct 2020 13:41:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj9-Cc-qZUrTZ=V=LrHj-wK++kuOrxbiFQCkbu9THycEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/20 1:28 PM, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 8:58 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> The problem is we're doing the prepare_to_wait, which sets our state
>> each time, however we can be woken up either with reads or writes.  In
>> the case above we race with the WRITER waking us up, and re-set our
>> state to INTERRUPTIBLE, and thus never break out of schedule.
> 
> Good catch of an interesting problem.
> 
> That said, the real problem here is that "pipe_wait()" is some nasty
> garbage. I really wanted to convert all users to do a proper
> wait-queue usage, but left the old structure alone.
> 
> Any normal "prepare_to_wait()" user should always check for the
> condition that it's waiting for _after_ the prepare-to-wait call, but
> the pipe code was traditionally all run under the pipe mutex, so it
> should have no races at all, because it's completely invalid to use
> "pipe_wait()" with anything that doesn't hold the mutex (both on the
> sleeping and waking side).
> 
> So pipe_wait() is kind of legacy and meant for all the silly and
> complex UNIX domain connection things that nobody wants to touch.
> 
> The IO code was supposed to have been converted away from that pipe
> mutex model, but it looks like I punted on splice, without thinking
> about this issue.
> 
> So I think the *real* fix would be to convert the splice waiting code
> to work even without holding the pipe mutex. Because honestly, I think
> your patch fixes the problem, but not completely.
> 
> In particular, the pipe wakeup can happen from somebody that doesn't
> hold the pipe mutex at all (see pipe_read(), and notice how it's doing
> the __pipe_unlock() before it does the "if it was full, wake things
> up), so this whole sequence is racy:
> 
>     check if pipe is full
>     pipe_wait() if it is
> 
> because the wakeup can happen in between those things, and
> "pipe_wait()" has no way to know what it's waiting for, and the wakeup
> event has already happened by the time it's called.

Yes, sorry that's what I meant to convey in my changelog, the wakeup has to 
occur outside the pipe_lock for this to occur.

Generally I think this is the only real problem we have, because as you said we 
only modify the tail/head under the pipe_lock, so it's not going to change while 
we do our pipe_wait().  The problem happens where we get removed for a case that 
no longer applies to us.  My fix "fixes" the problem in that we'll get a 
spurious wakeup, see that our condition isn't met, and go back to sleep, and 
then the next writer will wake us up for real.

Obviously not ideal, but I figured the simpler fix was better for stable, and 
then we could work out something better.

> 
> Let me think about this, but I think the right solution is to just get
> rid of the splice use of pipe_wait.
> 

Yeah we could just have the callers wait on the waitqueue they actually care 
about, that would be a simple solution that would also be cleaner.

> Do you have some half-way reliable way to trigger the issue for testing?
>
I do not, but I also didn't try.  We basically just have to break out of the 
pipe_write() loop before waking anything up.  I'll rig up something that just 
writes one page at a time, and the other side splices into /dev/null, and just 
run that in a loop for a few minutes and see if I can trigger it more reliably 
than my btrfs send thing.  Thanks,

Joesf
