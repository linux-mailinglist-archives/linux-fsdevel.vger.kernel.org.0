Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B394A4CE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380839AbiAaRP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbiAaRPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:15:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDE5C061758
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 09:14:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p27so28300533lfa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 09:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyPS3Szlv9qh4gjOhtDn0yktNtrjffm5++UyP/rn3f4=;
        b=IGrlP+yBf6s4abW3h/cJFVuo4oT6B/rCIdFAATcNHSETF4LFNBRGHRQs5xKe0zeKvo
         OTDgTiAvO1hcP64cT6bGl/o/InpN6yki/Q09yOh48jad3z5kgvyM+g2XkwDoGy+eUwN5
         eJS1HTB/9ONSUcIHEvpuGA4ZZH+VXrDCXnEnR/1kGiclbHgu1nz28DhGjRgkT7ZKUucT
         Tj5h7gMC94Lu9uAomUqxhJqGFG+JhwECDdChE/WeuOe8/g/fdCSU2hYWBcNGIKc3RfnN
         +hYN/OUYtpgZKNwvwLQQKwfMQMSXgPtpYn9sD0KyNPB3WE2innFHqvsSG4XF7hHfGfwK
         dJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyPS3Szlv9qh4gjOhtDn0yktNtrjffm5++UyP/rn3f4=;
        b=ay7knP2qWjr/9l2lbL/YYsZiK35CMGudA0Jlwx5HMsc99ybrIC4hV5GjDx3jF47kro
         o4Dl7XzlZLrreX1E/3vaQpHAuYDQ4utpkuUkdugSV7lqKBHd/ENT5vQAIm23lCwxlsmC
         IbbLM3B82SBN1CL1TnjHpmmUtEyRKSBeLa+J1ISN9pmBdyXHyUkXYODpMmyvjlssZn2S
         vNlk1Yqn6iggQ3gS2+YlVWwmiHMVGEudbM/5jVSTvqEUfjVMZsFjnlN57MrqacaYm9cd
         H6oJF6Wjd5+wDQqgwa0kH/U273EhuPi5LHGVY+lSsDgtMSgjaRzYBmUs5wyPOeZH89Yz
         i/qw==
X-Gm-Message-State: AOAM530M8zvotXObkKwNK8qCxiC+lrsEBIPYW00wcekm8vIEQ0OA/u1r
        SvZ4qRwGvE6FU+nf3IxrCzF0CLHP1enSr/w4pa1j5A==
X-Google-Smtp-Source: ABdhPJxweuySzWpnHG0bnPZw7yNmwgLjQXGJ1V54SkKRiPJ42RiOvY0GQO0vziXQ3O+oZQfZdQKYNMY89gobBQr0vB4=
X-Received: by 2002:a19:ee04:: with SMTP id g4mr15639705lfb.157.1643649248869;
 Mon, 31 Jan 2022 09:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org>
In-Reply-To: <YfgPwPvopO1aqcVC@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Jan 2022 18:13:42 +0100
Message-ID: <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:35 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 31, 2022 at 10:26:11AM -0600, Eric W. Biederman wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> >
> > > On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
> > >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
> > >>
> > >> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
> > >> > is very careful to take the mmap_lock in write mode.  We only need to
> > >> > take it in read mode here as we do not care if the size of the stack
> > >> > VMA changes underneath us.
> > >> >
> > >> > If it can be changed underneath us, this is a potential use-after-free
> > >> > for a multithreaded process which is dumping core.
> > >>
> > >> The problem is not multi-threaded process so much as processes that
> > >> share their mm.
> > >
> > > I don't understand the difference.  I appreciate that another process can
> > > get read access to an mm through, eg, /proc, but how can another process
> > > (that isn't a thread of this process) modify the VMAs?
> >
> > There are a couple of ways.
> >
> > A classic way is a multi-threads process can call vfork, and the
> > mm_struct is shared with the child until exec is called.
>
> While true, I thought the semantics of vfork() were that the parent
> was suspended.  Given that, it can't core dump until the child execs
> ... right?
>
> > A process can do this more deliberately by forking a child using
> > clone(CLONE_VM) and not including CLONE_THREAD.   Supporting this case
> > is a hold over from before CLONE_THREAD was supported in the kernel and
> > such processes were used to simulate threads.

The syscall clone() is kind of the generalized version of fork() and
vfork(), and it lets you create fun combinations of these things (some
of which might be useful, others which make little sense), and e.g.
vfork() is basically just clone() with CLONE_VM (for sharing address
space) plus CLONE_VFORK (block until child exits or execs) plus
SIGCHLD (child should send SIGCHLD to parent when it terminates).

(Some combinations are disallowed, but you can IIRC make things like
threads with separate FD tables, or processes that share virtual
memory and signal handler tables but aren't actual threads.)


Note that until commit 0258b5fd7c71 ("coredump: Limit coredumps to a
single thread group", first in 5.16), coredumps would always tear down
every process that shares the MM before dumping, and the coredumping
code was trying to rely on that to protect against concurrency. (Which
at some point didn't actually work anymore, see below...)

> That is a multithreaded process then!  Maybe not in the strict POSIX
> compliance sense, but the intent is to be a multithreaded process.
> ie multiple threads of execution, sharing an address space.

current_is_single_threaded() agrees with you. :P

> > It also happens that there are subsystems in the kernel that do things
> > like kthread_use_mm that can also be modifying the mm during a coredump.
>
> Yikes.  That's terrifying.  It's really legitimate for a kthread to
> attach to a process and start tearing down VMAs?

I don't know anything about kthreads doing this, but a fun way to
remotely mess with VMAs is userfaultfd. See
https://bugs.chromium.org/p/project-zero/issues/detail?id=1790 ("Issue
1790: Linux: missing locking between ELF coredump code and userfaultfd
VMA modification") for the long version - but the gist is that
userfaultfd can set/clear flags on virtual address ranges (implemented
as flags on VMAs), and that may involve splitting VMAs (when the
boundaries of the specified range don't correspond to existing VMA
boundaries) or merging VMAs (when the flags of adjacent VMAs become
equal). And userfaultfd can by design be used remotely on another
process (so long as that process first created the userfaultfd and
then handed it over).

That's why I added that locking in the coredumping code.

> > > Uhh .. that seems like it needs a lot more understanding of binfmt_elf
> > > than I currently possess.  I'd rather spend my time working on folios
> > > than learning much more about binfmt_elf.  I was just trying to fix an
> > > assertion failure with the maple tree patches (we now assert that you're
> > > holding a lock when walking the list of VMAs).
> >
> > Fair enough.  I will put it on my list of things to address.
>
> Thanks.  Now that I've disclosed it's a UAF, I hope you're able to
> get to it soon.  Otherwise we should put this band-aid in for now
> and you can address it properly in the fullness of time.
