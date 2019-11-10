Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55DF6B11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2019 20:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKJTKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Nov 2019 14:10:20 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:33812 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfKJTKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Nov 2019 14:10:19 -0500
Received: by mail-oi1-f180.google.com with SMTP id l202so9681603oig.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2019 11:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtANkV35F2JXgqRyYaqnd8apA5ZKbg0CsqX6f/wW7G0=;
        b=kjaZ60yx1U8QwWJ5AdH1KL3JLfOSG0oZmA/VyGX+A5FPB6Upc5KtothrJXt4ppFlnC
         tKwd6mlOJ7rDzrYA06u7YLuTKKbanB7IqFM8v61c9aDB94/GLEEoVhE6u6//Hgl2Ugm9
         WP2q2xFw21K7e1mCyU6p8HvW6Sjn6NN5iMjs6DI9zy5hqQJ5sOEU4vJe5lxF6dGqRjWw
         LSvQaNC88OJl7hkgBvyL1dkMNRfdm/0MytwEmwbyl0BaySWBbK5wWGzF3UKOUBkO+xOT
         FTuhOFAEpyo/fBVb1UJSVauL65p5NWJxUDj+SZ9k6alOmw9Oz3Hcdeg/c7/jF4o0PyQ0
         ZJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtANkV35F2JXgqRyYaqnd8apA5ZKbg0CsqX6f/wW7G0=;
        b=K+IEUR6RTO5VmMLon22iyzb4kQMplioDvla+f5Vr5LV3Cukt3SCDAJ7498RImUXEQD
         uF0lZHr3+urTKmSQJLJpvd0A5prY0Yi1AhgM9t5hnOD6VVMAsbGPWIVpdr7F1P/i/J39
         jO4x3LQfWi4ADg4IwwNg2Yzvj5NqnrmURTMAXFaJVGSiw1K1Nz6qY0k/MLnOp9HAQED9
         OeeSxwQY3NwM68WJNNIJQHnw0/gwjX6xjkGIH+c9iSIdr+7Zs3GeZTrenTChYDJs1Pp5
         HRBjVX+JaFT+8eLVHBI30j0hoDH1Ozd6t1uG6Uiq+SqgQrioGZl1PtuVwaN/71VF3W+S
         PJ8A==
X-Gm-Message-State: APjAAAW8RLdKdk8ChaUenarPwkfeLuwAJvP757MnMQarKSg4XVMvfOdY
        tgLk8+EomZ+8KQTsMWioe/Izfi78y1RrxCIk5oZ8Zg==
X-Google-Smtp-Source: APXvYqwfrFdDnkCEcNdO1DQUFeM2s0tDxzH8nYCw+xKb/U+TiqTqLRoxEZIuKyGJqfJRPVtQjPz0FxU8yjhJpVWTXi8=
X-Received: by 2002:aca:f046:: with SMTP id o67mr19655355oih.155.1573413017750;
 Sun, 10 Nov 2019 11:10:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
From:   Marco Elver <elver@google.com>
Date:   Sun, 10 Nov 2019 20:10:05 +0100
Message-ID: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 10 Nov 2019 at 17:09, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 9 Nov 2019, Linus Torvalds wrote:
>
> > On Sat, Nov 9, 2019, 15:08 Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > > On Fri, 8 Nov 2019, Linus Torvalds wrote:
> > > >
> > > > Two writes to normal memory are *not* idempotent if they write
> > > > different values. The ordering very much matters, and it's racy and a
> > > > tool should complain.
> > >
> > > What you have written strongly indicates that either you think the word
> > > "idempotent" means something different from its actual meaning or else
> > > you are misusing the word in a very confusing way.
> > >
> >
> > "Idempotence is the property of certain operations in mathematics and
> > computer science whereby they can be applied multiple times without
> > changing the result beyond the initial application. "
> >
> > This is (for example) commonly used when talking about nfs operations,
> > where you can re-send the same nfs operation, and it's ok (even if it has
> > side effects) because the server remembers that it already did the
> > operation. If it's already been done, nothing changes.
> >
> > It may not match your definition in some other area, but this is very much
> > the accepted meaning of the word in computer science and operating systems.
>
> Agreed.  My point was that you were using the word in a way which did
> not match this definition.
>
> Never mind that.  You did not respond to the question at the end of my
> previous email: Should the LKMM be changed so that two writes are not
> considered to race with each other if they store the same value?
>
> That change would take care of the original issue of this email thread,
> wouldn't it?  And it would render WRITE_IDEMPOTENT unnecessary.
>
> Making that change would amount to formalizing your requirement that
> the compiler should not invent stores to shared variables.  In C11 such
> invented stores are allowed.  Given something like this:
>
>         <A complex computation which does not involve x but does
>          require a register spill>
>         x = 1234;
>
> C11 allows the compiler to store an intermediate value in x rather than
> allocating a slot on the stack for the register spill.  After all, x is
> going to be overwritten anyway, and if any other thread accessed x
> during the complex computation then it would race with the final store
> and so the behavior would be undefined in any case.
>
> If you want to specifically forbid the compiler from doing this, it
> makes sense to change the memory model accordingly.
>
> For those used to thinking in terms of litmus tests, consider this one:
>
> C equivalent-writes
>
> {}
>
> P0(int *x)
> {
>         *x = 1;
> }
>
> P1(int *x)
> {
>         *x = 1;
> }
>
> exists (~x=1)
>
> Should the LKMM say that this litmus test contains a race?
>
> This suggests that we might also want to relax the notion of a write
> racing with a read, although in that case I'm not at all sure what the
> appropriate change to the memory model would be.  Something along the
> lines of: If a write W races with a read R, but W stores the same value
> that R would have read if W were not present, then it's not really a
> race.  But of course this is far too vague to be useful.

What if you introduce to the above litmus test:

P2(int *x) { *x = 2; }

How can a developer, using the LKMM as a reference, hope to prove
their code is free from data races without having to enumerate all
possible values a variable could contain (in addition to all possible
interleavings)?

I view introducing data value dependencies, for the sake of allowing
more programs, to a language memory model as a slippery slope, and am
not aware of any precedent where this worked out. The additional
complexity in the memory model would put a burden on developers and
the compiler that is unlikely to be a real benefit (as you pointed
out, the compiler may even need to disable some transformations). From
a practical point of view, if the LKMM departs further and further
from C11's memory model, how do we ensure all compilers do the right
thing?

My vote would go to explicit annotation, not only because it reduces
hidden complexity, but also because it makes the code more
understandable, for developers and tooling. As an additional point, I
find the original suggestion to add WRITE_ONCE to be the least bad (or
some other better named WRITE_). Consider somebody changing the code,
changing the semantics and the values written to "non_rcu". With a
WRITE_ONCE, the developer would be clear about the fact that the write
can happen concurrently, and ensure new code is written with the
assumption that concurrent writes can happen.

Thanks,
-- Marco
