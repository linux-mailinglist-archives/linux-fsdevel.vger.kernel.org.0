Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013711B7D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgDXSC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXSC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:02:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF3C09B048
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so8434463lfg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z13IEYz83XdBeUibWdG7wclkW3og2+VosmLRfwAtAdA=;
        b=WsMshc2mIdVUt3yh9Dd3vA9NAUPuyxr+K526tt3N6H9SWCUwoLVukf7frGTwCg48QE
         DZUzz3sWj1a8QHzrAGEPyboToxOGmPzCgGA1IDa8Ud0ufbf5qTjMtiFJwutkwG32h2SQ
         ovIx45Wunn4iKR1DL6i7Xis6NIaAz1s2wwEGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z13IEYz83XdBeUibWdG7wclkW3og2+VosmLRfwAtAdA=;
        b=Tsv93eZmKQG6+wTuDCvbDgb8OZHxNKKy4uih9c+/PgFMwJoor20BK7PQn5dDVBAokA
         +HiRudS9Am7RDmoprS8GwuzrrYGcKmftx0QaxPz45cC3aXO4BdL/k8fq79mSFkRUeDf0
         B85foS86w4w6NL1OZVxJkbn+r8jj3aE6kaAoqGy9yR+fY8ExlffP8e2Qu4djD68MJd13
         4p8XSBvel7vRICH/7Vgh8y4rGBzWHESftMfzDk2H7ZXGwP78jYoPJFmsN2lVIJcex9mi
         URKvLGlYeimICO2sHS5cOOz0T4GirZjeCmUY6VATD49OFTjfWHnKagxlnins2i1O9vFz
         UY3g==
X-Gm-Message-State: AGi0PuaLerP3X+5SVBzgHF7DtNsNjc+jgD8+4qR6hlQGoQhB2uyj77Nx
        zjFp07piqBZBsOv8LPsPg0hFBt75W2U=
X-Google-Smtp-Source: APiQypLYRl27CB1UNrGnJkNu9NKaVszNpxVY/F//+h7b8mEIA1abAOQ6QzV7l9thkS20GEAiF6qwjQ==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr7235795lfe.14.1587751373601;
        Fri, 24 Apr 2020 11:02:53 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x29sm4880078lfn.64.2020.04.24.11.02.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:02:52 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a21so10882117ljb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 11:02:52 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr6506692ljg.204.1587751371830;
 Fri, 24 Apr 2020 11:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com> <87tv19tv65.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv19tv65.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 11:02:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
Message-ID: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 8:36 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> At one point my brain I had forgetten that xchg can not take two memory
> arguments and had hoped to be able to provide stronger guarnatees than I
> can.  Which is where I think the structure of exchange_pids came from.

Note that even if we were to have a "exchange two memory locations
atomically" instruction (and we don't - even a "double cmpxchg" is
actually just a double-_sized_ one, not a two different locations
one), I'm not convinced it makes sense.

There's no way to _walk_ two lists atomically. Any user will only ever
walk one or the other, so it's not sensible to try to make the two
list updates be atomic.

And if a user for some reason walks both, the walking itself will
obviously then be racy - it does one or the other first, and can see
either the old state, or the new state - or see _neither_ (ie if you
walk it twice, you might see neither task, or you might see both, just
depending on order or walk).

> I do agree the clearer we can write things, the easier it is for
> someone else to come along and follow.

Your alternate write of the function seems a bit more readable to me,
even if the main effect might be just that it was split up a bit and
added a few comments and whitespace.

So I'm more happier with that one. That said:

> We can not use a remove and reinser model because that does break rcu
> accesses, and complicates everything else.  With a swap model we have
> the struct pids pointer at either of the tasks that are swapped but
> never at nothing.

I'm not suggesting removing the pid entirely - like making task->pid
be NULL. I'm literally suggesting just doing the RCU list operations
as "remove and re-insert".

And that shouldn't break anything, for the same reason that an atomic
exchange doesn't make sense: you can only ever walk one of the lists
at a time. And regardless of how you walk it, you might not see the
new state (or the old state) reliably.

Put another way:

>         void hlist_swap_before_rcu(struct hlist_node *left, struct hlist_node *right)
>         {
>                 struct hlist_node **lpprev = left->pprev;
>                 struct hlist_node **rpprev = right->pprev;
>
>                 rcu_assign_pointer(*lpprev, right);
>                 rcu_assign_pointer(*rpprev, left);

These are the only two assignments that matter for anything that walks
the list (the pprev ones are for things that change the list, and they
have to have exclusions in place).

And those two writes cannot be atomic anyway, so you fundamentally
will always be in the situation that a walker can miss one of the
tasks.

Which is why I think it would be ok to just do the RCU list swap as a
"remove left, remove right, add left, add right" operation. It doesn't
seem fundamentally different to a walker than the "switch left/right"
operation, and it seems much simpler.

Is there something I'm missing?

But I'm *not* suggesting that we change these simple parts to be
"remove thread_pid or pid pointer, and then insert a new one":

>                 /* Swap thread_pid */
>                 rpid = left->thread_pid;
>                 lpid = right->thread_pid;
>                 rcu_assign_pointer(left->thread_pid, lpid);
>                 rcu_assign_pointer(right->thread_pid, rpid);
>
>                 /* Swap the cached pid value */
>                 WRITE_ONCE(left->pid, pid_nr(lpid));
>                 WRITE_ONCE(right->pid, pid_nr(rpid));
>         }

because I agree that for things that don't _walk_ the list, but just
look up "thread_pid" vs "pid" atomically but asynchronously, we
obviously need to get one or the other, not some kind of "empty"
state.

> Does that look a little more readable?

Regardless, I find your new version at least a lot more readable, so
I'm ok with it.

It looks like Oleg found an independent issue, though.

                  Linus
