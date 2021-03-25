Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBD348848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 06:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCYFSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 01:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCYFST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:18:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343CBC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 22:18:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u19so628074pgh.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 22:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+FWj6Hf+dd6h4E3BP2IBzagIqQQDvwZ4ToIMDO5/Z8=;
        b=HK/gIPDVvBDJhFuyEmwfS35eTr6KF6wDJvNgHK1+iG61S3NFxBtyZti28W0tSkjPUk
         E6NiID7Ry+S235L4XryGcMzfF8sF0U208+/OruC7DhenX6HWurVqsxShYrvTVxVWBM29
         6UFQOncwFs2WD/kXLzVtwRnQ6SYElYB3+fprE78+Yf8GaXPRjHCOW+aj2RCKUdmx6HI+
         z4naA1S+k/4xNXgU0KDEYzMNuo4nWF8K1Atz8DGWjOkAdCTgG7zd7904sHW83gfcjXjg
         NW+UKcxWXn0fzPi7MfwabywBNC3z7gSTjPDdaDh5F7tOLZzF2jd9TVIe5FRGxGQ2N5IQ
         dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+FWj6Hf+dd6h4E3BP2IBzagIqQQDvwZ4ToIMDO5/Z8=;
        b=RCsfzhjUc9v+iLMZxLIuV7J32eG+j+9qoeED48tB9ZLZQH2zbqklcLsyaebMWvIzwO
         mLVnoASzyeJTjKB9hzLaXW1Gh07N8fuVsDHhBwTII4s0McTdO0WCKH7MZq/fM8GKUTh8
         uqzeWv/oPuOoi49YDm33Zp2zXqjxnsOen4eRNS3MFJXNxxkjW9YbVwRlg7JUn9155PXy
         AMYqDAW3NgyoRgmuQQzpPafUvmI9wNb2aPt58XeRqDfoMC+AtZhoFKQWN9mUBHV2EUKH
         tnL78wAEhoyEHq0yfB9HBoVNPJ8KG7V09MDpj/B2s4oJTInr9hypdmPFekmcHdFXEYqi
         +iHQ==
X-Gm-Message-State: AOAM532679nXep9AdDlmWS5iw2D4gr7ouV7oV/y1xRjmSulRltB2OcZG
        sEOtE+JTAhA/NySWQbHh65ZjBObTSUAoHS3ix9JTOfYnQ8FSz4kW
X-Google-Smtp-Source: ABdhPJzURfHQIbEBC2BERiZzIrhBy6J7YK+04JNLB6WYh45GG+YG1q+NNJu/oz0vcQW+i1pyhaVn5AM96gOKZJGDFPg=
X-Received: by 2002:a63:1562:: with SMTP id 34mr5814651pgv.71.1616649498504;
 Wed, 24 Mar 2021 22:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210302034928.3761098-1-varmam@google.com> <87pmzw7gvy.fsf@nanos.tec.linutronix.de>
 <CAMyCerL7UkcU1YgZ=dUTZadv-YPHGccO3PR-DCt2nX7nz0afgA@mail.gmail.com> <87zgyurhoe.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zgyurhoe.fsf@nanos.tec.linutronix.de>
From:   Manish Varma <varmam@google.com>
Date:   Wed, 24 Mar 2021 22:18:07 -0700
Message-ID: <CAMyCerKf4MfsjAcVhXi7DVuP9mvt0X6VamwMiHa3KgRvnr7p9Q@mail.gmail.com>
Subject: Re: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,

On Mon, Mar 22, 2021 at 2:40 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Manish,
>
> On Mon, Mar 22 2021 at 10:15, Manish Varma wrote:
> > On Thu, Mar 18, 2021 at 6:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > +static atomic_t instance_count = ATOMIC_INIT(0);
> >>
> >> instance_count is misleading as it does not do any accounting of
> >> instances as the name suggests.
> >>
> >
> > Not sure if I am missing a broader point here, but the objective of this
> > patch is to:
> > A. To help find the process a given timerfd associated with, and
> > B. one step further, if there are multiple fds created by a single
> > process then label each instance using monotonically increasing integer
> > i.e. "instance_count" to help identify each of them separately.
> >
> > So, instance_count in my mind helps with "B", i.e. to keep track and
> > identify each instance of timerfd individually.
>
> I know what you want to do. The point is that instance_count is the
> wrong name as it suggests that it counts instances, and that in most
> cases implies active instances.
>
> It's not a counter, it's a token generator which allows you to create
> unique ids. The fact that it is just incrementing once per created file
> descriptor does not matter. That's just an implementation detail.
>
> Name it something like timerfd_create_id or timerfd_session_id which
> clearly tells that this is not counting any thing. It immediately tells
> the purpose of generating an id.
>
> Naming matters when reading code, really.
>

Noted, and thanks for the clarification!

> >> > +     snprintf(file_name_buf, sizeof(file_name_buf), "[timerfd%d:%s]",
> >> > +              instance, task_comm_buf);
> >> > +     ufd = anon_inode_getfd(file_name_buf, &timerfd_fops, ctx,
> >> >                              O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
> >> >       if (ufd < 0)
> >> >               kfree(ctx);
> >>
> >> I actually wonder, whether this should be part of anon_inode_get*().
> >>
> >
> > I am curious (and open at the same time) if that will be helpful..
> > In the case of timerfd, I could see it adds up value by stuffing more
> > context to the file descriptor name as eventpoll is using the same file
> > descriptor names as wakesource name, and hence the cost of slightly
> > longer file descriptor name justifies. But I don't have a solid reason
> > if this additional cost (of longer file descriptor names) will be
> > helpful in general with other file descriptors.
>
> Obviously you want to make that depend on a flag handed to anon_...().

Unfortunately, changing file descriptor names does not seem to be a viable
option here (more details in my answer in the next section), and
hence changes in anon_...() does not seem to be required.

>
> The point is that there will be the next anonfd usecase which needs
> unique identification at some point. That is going to copy&pasta that
> timerfd code and then make it slightly different just because and then
> userspace needs to parse yet another format.
>
> >> Aside of that this is a user space visible change both for eventpoll and
> >> timerfd.
>
> Not when done right.
>
> >> Have you carefully investigated whether there is existing user space
> >> which might depend on the existing naming conventions?
> >>
> > I am not sure how I can confirm that for all userspace, but open for
> > suggestions if you can share some ideas.
> >
> > However, I have verified and can confirm for Android userspace that
> > there is no dependency on existing naming conventions for timerfd and
> > eventpoll wakesource names, if that helps.
>
> Well, there is a world outside Android and you're working for a company
> which should have tools to search for '[timerfd]' usage in a gazillion of
> projects. The obvious primary targets are distros of all sorts. I'm sure
> there are ways to figure this out without doing it manually.
>
> Not that I expect any real dependencies on it, but as always the devil
> is in the details.
>

Right, there are some userspace which depends on "[timerfd]" string
https://codesearch.debian.net/search?q=%22%5Btimerfd%5D%22&literal=1

So, modifying file descriptor names at-least for timerfd will definitely
break those.

With that said, I am now thinking about leaving alone the file descriptor
names as is, and instead, adding those extra information about the
associated processes (i.e. process name or rather PID of the
process) along with token ID directly into wakesource name, at the
time of creating new wakesource i.e. in ep_create_wakeup_source().

So, the wakesource names, that currently named as "[timerfd]", will be
named something like:
"epollitem<N>:<PID>.[timerfd]"

Where N is the number of wakesource created since boot.

This way we can still associate the process with the wakesource
name and also distinguish multiple instances of wakesources using
the integer identifier.

Please share your thoughts!

> Thanks,
>
>         tglx

Thanks,
Manish
--
Manish Varma | Software Engineer | varmam@google.com | 650-686-0858
