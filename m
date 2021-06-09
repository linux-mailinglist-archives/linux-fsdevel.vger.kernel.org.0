Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599313A1E28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFIUfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFIUfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:35:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E489C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jun 2021 13:33:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so1492936ljn.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKOE8BadJeo+YL8tRU0iYJhaHWhLziwYQepJorZ98hY=;
        b=UBP8J6oYchq2ROBkKb/OBl2yhXz9+41fIVP2jys4OwQsSgcG7GA3wC9CyITc1BANel
         6pUPf1o7H/jAprU3hJI9Orap/rRnTmgpIpJfaXDu+lmLVs+eno55vuWfJKvk061XOrqM
         lIKlhsHcRIejWytT4LUfn+BysOlyh7R4deQ6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKOE8BadJeo+YL8tRU0iYJhaHWhLziwYQepJorZ98hY=;
        b=TgFaNryAQNk8HY0cFzqoRerFVhqpOuCgaSCHT55uk3PH8CGo6wcYaKd0AC8ce0oILv
         6CQ4n+jKTWXmzMxl+qQxyE3MseoYhp3bQXvB021jdYR5bmegHyRaVMLi87M23hGRXWtu
         dZl1Dm9+rnemCP+Gt3Jl13wfPrcHt9Yf0XbeuwCCVEf4ITAuoWoTZJUhcxOBu7KcwMoR
         C4djBRTL/t5nYjI7Zzi1UKqnYmldYO8F4T8C5iUDZKLq7oElEuVX2O86yHBoycUVgsMZ
         HNK4O+GB2rNtyfBhk2q8VnTaNcJBfvdPQPAFAvnd2GWS2bGTHvy94ovCxDm/nRjGv2aD
         nIYA==
X-Gm-Message-State: AOAM532UMUaXwtoARWWhIcph7wz3l9nyNfuQ+26+yhlRCTInVpV9erhO
        YZSEFG8wHn7oANoJYD/0SQOJpwx0QUEBMaKZZ5Q=
X-Google-Smtp-Source: ABdhPJwevt/IJ5mPwAWhalthT5xoKoiZ5y8tE4BMNI1gBO7zpb62vBqFggM7/64itXXe76WRmTq68Q==
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr1161174ljm.302.1623270835247;
        Wed, 09 Jun 2021 13:33:55 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id p11sm86370lfr.91.2021.06.09.13.33.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:33:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r16so1530045ljk.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 13:33:52 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr1178053ljh.507.1623270832349;
 Wed, 09 Jun 2021 13:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com> <87h7i694ij.fsf_-_@disp2133>
In-Reply-To: <87h7i694ij.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 13:33:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
Message-ID: <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Olivier Langlois <olivier@trillion01.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 9, 2021 at 1:17 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
> In short the coredump code deliberately supports being interrupted by
> SIGKILL, and depends upon prepare_signal to filter out all other
> signals.

Hmm.

I have to say, that looks like the core reason for the bug: if you
want to be interrupted by a fatal signal, you shouldn't use
signal_pending(), you should use fatal_signal_pending().

Now, the fact that we haven't cleared TIF_NOTIFY_SIGNAL for the first
signal is clearly the immediate cause of this, but at the same time I
really get the feeling that that coredump aborting code should always
had used fatal_signal_pending().

We do want to be able to abort core-dumps (stuck network filesystems
is the traditional reason), but the fact that it used signal_pending()
looks buggy.

In fact, the very comment in that dump_interrupted() function seems to
acknowledge that signal_pending() is all kinds of silly.

So regardless of the fact that io_uring does seem to have messed up
this part of signals, I think the fix is not to change
signal_pending() to task_sigpending(), but to just do what the comment
suggests we should do.

But also:

> With the io_uring code comes an extra test in signal_pending
> for TIF_NOTIFY_SIGNAL (which is something about asking a task to run
> task_work_run).

Jens, is this still relevant? Maybe we can revert that whole series
now, and make the confusing difference between signal_pending() and
task_sigpending() go away again?

               Linus
