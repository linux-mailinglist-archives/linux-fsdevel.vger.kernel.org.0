Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A718D3451EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 22:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCVVkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 17:40:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCVVkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:40:19 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616449218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YD2wgp7SpXGUp/G8MdiJrAMp0JW8uovt7TJMeyjYpjg=;
        b=d+Erj1BfcZZFsCHcogE8hsxroo9kRQgSDd1F4LzOGLNo63jeHh73Fk4kzHvUnMHcOVqwEZ
        UB6h+6k0OHFTpDT/lb1UYCcC7GeGnL/QV4mdVFR2YScfz15xGDHKBebGq8fj5mBA1NfH8W
        UPd5nir0oStZuV0V9Cgmri6nj93RARgE9dkQE9YWHChAqDmT7h3kR+6uarUMdc0dvtHF5S
        VDzn3N+h0htCviUR2+VMETLK8g3H4ryJK1PJqklkzKPRUj34lA1UzCBkv3lBbS80lFXXRE
        D4zwk/ARJS4KZ13lkyqikBjl2xajg5GpHGXYk+CLF8knuxtC5RoPOjIemmETVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616449218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YD2wgp7SpXGUp/G8MdiJrAMp0JW8uovt7TJMeyjYpjg=;
        b=s+nMsR5Wjestvb52A17GUi8LAfU3iflgcHBYmVi50LHsuScRVrR/sj4jBVuVg/R/6FEqk0
        owIFRz6SoellVbCg==
To:     Manish Varma <varmam@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com
Subject: Re: [PATCH] fs: Improve eventpoll logging to stop indicting timerfd
In-Reply-To: <CAMyCerL7UkcU1YgZ=dUTZadv-YPHGccO3PR-DCt2nX7nz0afgA@mail.gmail.com>
References: <20210302034928.3761098-1-varmam@google.com> <87pmzw7gvy.fsf@nanos.tec.linutronix.de> <CAMyCerL7UkcU1YgZ=dUTZadv-YPHGccO3PR-DCt2nX7nz0afgA@mail.gmail.com>
Date:   Mon, 22 Mar 2021 22:40:17 +0100
Message-ID: <87zgyurhoe.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Manish,

On Mon, Mar 22 2021 at 10:15, Manish Varma wrote:
> On Thu, Mar 18, 2021 at 6:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > +static atomic_t instance_count = ATOMIC_INIT(0);
>>
>> instance_count is misleading as it does not do any accounting of
>> instances as the name suggests.
>>
>
> Not sure if I am missing a broader point here, but the objective of this
> patch is to:
> A. To help find the process a given timerfd associated with, and
> B. one step further, if there are multiple fds created by a single
> process then label each instance using monotonically increasing integer
> i.e. "instance_count" to help identify each of them separately.
>
> So, instance_count in my mind helps with "B", i.e. to keep track and
> identify each instance of timerfd individually.

I know what you want to do. The point is that instance_count is the
wrong name as it suggests that it counts instances, and that in most
cases implies active instances.

It's not a counter, it's a token generator which allows you to create
unique ids. The fact that it is just incrementing once per created file
descriptor does not matter. That's just an implementation detail.

Name it something like timerfd_create_id or timerfd_session_id which
clearly tells that this is not counting any thing. It immediately tells
the purpose of generating an id.

Naming matters when reading code, really.

>> > +     snprintf(file_name_buf, sizeof(file_name_buf), "[timerfd%d:%s]",
>> > +              instance, task_comm_buf);
>> > +     ufd = anon_inode_getfd(file_name_buf, &timerfd_fops, ctx,
>> >                              O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
>> >       if (ufd < 0)
>> >               kfree(ctx);
>>
>> I actually wonder, whether this should be part of anon_inode_get*().
>>
>
> I am curious (and open at the same time) if that will be helpful..
> In the case of timerfd, I could see it adds up value by stuffing more
> context to the file descriptor name as eventpoll is using the same file
> descriptor names as wakesource name, and hence the cost of slightly
> longer file descriptor name justifies. But I don't have a solid reason
> if this additional cost (of longer file descriptor names) will be
> helpful in general with other file descriptors.

Obviously you want to make that depend on a flag handed to anon_...().

The point is that there will be the next anonfd usecase which needs
unique identification at some point. That is going to copy&pasta that
timerfd code and then make it slightly different just because and then
userspace needs to parse yet another format.

>> Aside of that this is a user space visible change both for eventpoll and
>> timerfd.

Not when done right.

>> Have you carefully investigated whether there is existing user space
>> which might depend on the existing naming conventions?
>>
> I am not sure how I can confirm that for all userspace, but open for
> suggestions if you can share some ideas.
>
> However, I have verified and can confirm for Android userspace that
> there is no dependency on existing naming conventions for timerfd and
> eventpoll wakesource names, if that helps.

Well, there is a world outside Android and you're working for a company
which should have tools to search for '[timerfd]' usage in a gazillion of
projects. The obvious primary targets are distros of all sorts. I'm sure
there are ways to figure this out without doing it manually.

Not that I expect any real dependencies on it, but as always the devil
is in the details.

Thanks,

        tglx
