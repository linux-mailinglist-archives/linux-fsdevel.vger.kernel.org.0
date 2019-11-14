Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED778FC815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNNq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 08:46:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46727 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfKNNq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:46:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id n23so4838395otr.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI8XwCq8heWQgz9mOCei/A4zlcNK1RwWtVyxWKPoyCY=;
        b=UahwqbSqvtof4ApznsHyp0AlKHLFzHrxsamAv0VQY+oZJtqKA78BYD2h5x/M/+1WNB
         MO+4SiP6gjREXogK6tfVKyF/jAFocNey9Op4uCU+L2U2AmZDLu9J8JbOrwV6nBqwTo6z
         xL039E7/kDRBfwveQp/13PSOuzm6DCMWu0J2Y0FxiXNGrvatHAppgJNfrbPWjw/mHj+l
         SDnr1+6056C4QCRQid8YH9FasMJzNfCDPQj5oclNE2IqPhngj4fHqu4jKRWY6YTvxxn3
         xvv671DVE21gaGobdem64IJEZNue8NNMRiWDl7H8OOrPVf4eRwu5iApOcrrLwVTGG+pa
         GiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI8XwCq8heWQgz9mOCei/A4zlcNK1RwWtVyxWKPoyCY=;
        b=c1MoVYMjcnvd6i85Xs18S9yBLk2daaUtRc9b4xPIymgqcEZq1RcpOEhCEyVsXty54B
         XQwRsI6O6n/Tkvc2lW87j1Y6Gt8ZYGzIRfAo/pWtM40rOTbSJF4KIy8x8toNjBztO/VM
         ZddtWRi4bZ1nZqqvUjII09o+mgCeOtZ44S87v8nWR/OvtNnc9EfTmGlvkr5EFym410K8
         imsT+cYyZnl/nUpMsZaQT0rT5cd486wZxu2RE0EtY3UHRclLpHhAPIyoJnEqEHhs0wQy
         5DudZ64ZcQPckyRHnlnDA9PbY5g/vFzho7RSuQgfj4jHt8pV2Gpm+Q+jsv6a/mXGuhqZ
         abog==
X-Gm-Message-State: APjAAAXTaOHVKZ0ht394HF8/7a7UurfoK7Jb1NtSJool0uQOVuthPnxI
        hO7OTb6SbikIxTWz/16DXLsIswSYzU0Nt6whzozr1A==
X-Google-Smtp-Source: APXvYqwDZBkC3ZCnLaE6JyJHavd4O4J7fjyTaIFp+mvp+beXg9Dgi+Sa3lj0dJf2RuzfQII2ljxRH9p+6FWYUlXZ01Y=
X-Received: by 2002:a9d:328:: with SMTP id 37mr6858344otv.228.1573739215541;
 Thu, 14 Nov 2019 05:46:55 -0800 (PST)
MIME-Version: 1.0
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk> <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
In-Reply-To: <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Nov 2019 14:46:29 +0100
Message-ID: <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio) POLL
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:20 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 14/11/2019 05.49, Jens Axboe wrote:
> > On 11/13/19 9:31 PM, Jens Axboe wrote:
> >> This is a case of "I don't really know what I'm doing, but this works
> >> for me". Caveat emptor, but I'd love some input on this.
> >>
> >> I got a bug report that using the poll command with signalfd doesn't
> >> work for io_uring. The reporter also noted that it doesn't work with the
> >> aio poll implementation either. So I took a look at it.
> >>
> >> What happens is that the original task issues the poll request, we call
> >> ->poll() (which ends up with signalfd for this fd), and find that
> >> nothing is pending. Then we wait, and the poll is passed to async
> >> context. When the requested signal comes in, that worker is woken up,
> >> and proceeds to call ->poll() again, and signalfd unsurprisingly finds
> >> no signals pending, since it's the async worker calling it.
> >>
> >> That's obviously no good. The below allows you to pass in the task in
> >> the poll_table, and it does the right thing for me, signal is delivered
> >> and the correct mask is checked in signalfd_poll().
> >>
> >> Similar patch for aio would be trivial, of course.
> >
> > From the probably-less-nasty category, Jann Horn helpfully pointed out
> > that it'd be easier if signalfd just looked at the task that originally
> > created the fd instead. That looks like the below, and works equally
> > well for the test case at hand.
>
> Eh, how should that work? If I create a signalfd() and fork(), the
> child's signalfd should only be concerned with signals sent to the
> child. Not to mention what happens after the parent dies and the child
> polls its fd.
>
> Or am I completely confused?

I think the child should not be getting signals for the child when
it's reading from the parent's signalfd. read() and write() aren't
supposed to look at properties of `current`. If I send an fd to some
daemon via SCM_RIGHTS, and the daemon does a read() on it, that should
never cause signals to disappear from the daemon's signal queue.

Of course, if someone does rely on the current (silly) semantics, this
might break stuff.

And we probably also don't want to just let the signalfd keep a
reference to a task, because then if the task later goes through a
setuid transition, you'd still be able to dequeue its signals. So it'd
have to also check against ->self_exec_id or something like that.
