Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A44858AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiAESu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiAESux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:50:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CEC061245
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 10:50:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q14so238293edi.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfHNQGe03MWFiDjULzVbgtf6gbGg6JH50kN5fzPFHfA=;
        b=ewSSp59OgURps0hS/LbW55Aq+2LDBhNRyITlsFPwMv1qN0xdjkSe8cJKmF/NCk/WBt
         R58wzWpaldO8LqJhB/qpMqjiN9D3/kGtQKNirCRALgXZp5BNYKxw1hgUKICOPRv6gKDu
         Ljv/jlukGMuGKpoZcZe1iXxy98uqcnQ97Dx4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfHNQGe03MWFiDjULzVbgtf6gbGg6JH50kN5fzPFHfA=;
        b=mHClh15UijeIkSkILMQJgY6ened3CPWPfzAEsga9fBLsNq4SpzYNCDxzpeKQuqhftQ
         wTARWohxbLs2v10dELlmH2MkKLKWIlhRjJnYifMF3fMXsyQd1Mss5eF/V0wixZq0PJWv
         CrfDcY8Iw57ErdbwXTn0FtkGOij77+iC4iRmts2KGVoayJNnDBwdJSm6rEEs8jfuf0i+
         WXIQCGrdoEF3k7zP2guBFQlcefF9sD8kcrqLzu7XOzqOQ2uU3OmUe5vlVY+SNqT7kbJC
         tOSBQCP4I8/8gnOrQz2cT0pzJKGpNnMYIDzJaqDsZK8Brjuoi1JwJ81K2Bra68exZLLi
         4QaA==
X-Gm-Message-State: AOAM532TPHtIMeTNlj5BK19CJrn4H7hg/Hq98uiAYvEkOSjBT3GipBvr
        fZPss3S+wgoN3bbZKR8VzDCfXnm6mpAm7KgATl0=
X-Google-Smtp-Source: ABdhPJyZiiMZWKblXSKOz4IkDsGgwaMkWz+qRvwHJ5wCMrVsknJD15qWGeKZIsMYwrYR4T6rRZx02g==
X-Received: by 2002:a17:906:3e4b:: with SMTP id t11mr598726eji.744.1641408650925;
        Wed, 05 Jan 2022 10:50:50 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id u9sm9449563ejh.193.2022.01.05.10.50.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:50:50 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso2492549wml.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 10:50:49 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr4008893wmj.144.1641408649511;
 Wed, 05 Jan 2022 10:50:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
In-Reply-To: <YdW3WfHURBXRmn/6@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 10:50:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
Message-ID: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 5, 2022 at 7:21 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> [changed subject line to hopefully get people to stop ignoring this]
>
> Please see my message below where I explained the problem in detail.  Any
> response from the maintainers of kernel/sched/psi.c?  There are a lot of you:

Ok, this one is clearly a kernel/sched/psi.c bug, since the lifetime
isn't even maintained by the fiel reference.

I think the proper thing to do is to move the whole "get kref to
trigger pointer" in the open/close code, and keep the ref around that
way.

The natural thing to do would be to look up the trigger at open time,
save the pointer in seq->private, and release it at close time.

Sadly, right now the code actually uses that 'seq->private' as an
indirect rcu-pointer to the trigger data, instead of as the trigger
data itself. And that seems very much on purpose and inherent to that
'psi_write()' model, where it changes the trigger pointer very much on
purpose.

So I agree 100% - the PSI code is fundamentally broken. psi_write()
seems to be literally _designed_ to do the wrong thing.

I don't know who - if anybody - uses this. My preference would be to
just disable the completely broken poll support.

Another alternative is to just make 'psi_write()' return -EBUSY if
there are existing poll waiters (ie t->event_wait not being empty.  At
least then the open file would keep the kref to the trigger.

That would require that 'psi_trigger_replace()' serialize with the
waitqueue lock (easy), but all callers would also have to check the
return value of it

The cgroup code does

        psi_trigger_replace(&of->priv, NULL);

in the release function, but I guess that might work since at release
time there shouldn't be any pending polls anyway.

But it would also mean that anybody who can open the file for reading
(so that they can poll it) would be able to keep people from changing
it.

But yes, I think that unless we get some reply from the PSI
maintainers, we will have to just disable polling entirely.

I hope there are no users that would break, but considering that the
current code is clearly too broken to live, this may be one of those
"we have no choice" cases.

                         Linus
