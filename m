Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A122230B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 14:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgGPM4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgGPM4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449CC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:22 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so4052744oty.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KhEuTQ/sONMxFPvCk9XIn2quNPqfByU8Bi6tyB3MW0I=;
        b=Aj5U3tTA8XB998P5G/hlb/7gXSO4+soc+jXfZ8krPUepoQAScE3soEMvFJtBjfhPQA
         KndY2wOR32Ty64a/PjsBKh49KQV2sanfyzBBpX3pn00V2eh0buglz0kRVDdOekNJSOll
         3KygUJSpnfDj6b82AQJrSfagfDmqszTmVYhiimjE0CvLpZ92RNjax7k3sxg7Wmesq1Ke
         7N59cimJaNhIPOpltH0fatFhLIbfrJmJPavPUmpcuDK7p2ndgFa6rqOr9AnnEy6/FIPx
         9e/3RFfbi9fATqFp3JhPzDiI6GBfQYEI2ck9nRNcZMtCPLlmExjSJ76uYaJLIhb915un
         eCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KhEuTQ/sONMxFPvCk9XIn2quNPqfByU8Bi6tyB3MW0I=;
        b=RN/OtvGGEdhYbEoDSxGSpcSw9Y/a0oOr1/vD+qjAZcGaLlItQHWm/g2ADS3FcHl9Nc
         kHyZVp8aMkFfOxXp2pDdVWI1p4B8IrtkPPfHqe0k2f5hWh+u4J3Mdh2vLIaQytS+E0lg
         qrFFJW99fXT7YZ13OTHXSQJLW2BXIj0AVJs8RaIjKqdxrAuMBxOeA3fx4hHGlLnlrjGQ
         RtFm3fIenPhaVaYzTa+WiTsPINMrOJHO4FRB47iHNJpJHsjkw9N1wV6zDvSbfaEnPGmv
         QR0a3zcwOaNmE4aMlsaGgwc7MFO28Lt9326j6AbxmcOP8NL6Yf8R9r7N9U3xkyzt29Hh
         FrXA==
X-Gm-Message-State: AOAM533rLVggqldlMGjF9bq6oabd4RiM58n64im+AS0/PN2X7PjOXdLg
        h9uSr+i+LL9+glvmZV3FFLFhuX8Qj2Agnre6ZUxW3A==
X-Google-Smtp-Source: ABdhPJw+/+tCsMYB5w5xFwiO0JTOVGqH6ErP0pK+M8iDt3vfii/EqqtEHXHCwTEYaqvOeUhoFWdmmsD2NmnDERM6oeQ=
X-Received: by 2002:a9d:2788:: with SMTP id c8mr3954004otb.251.1594904181121;
 Thu, 16 Jul 2020 05:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004a4d6505aa7c688a@google.com> <20200715152912.GA2209203@elver.google.com>
 <20200715163256.GB1167@sol.localdomain> <20200715234203.GK5369@dread.disaster.area>
 <20200716030357.GE1167@sol.localdomain> <1594880070.49b50i0a1p.astroid@bobo.none>
 <20200716065454.GI1167@sol.localdomain> <1594884557.u5rf1h2p6r.astroid@bobo.none>
In-Reply-To: <1594884557.u5rf1h2p6r.astroid@bobo.none>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Jul 2020 14:56:09 +0200
Message-ID: <CANpmjNP+ZAGoj9Bfbh2a2t+GatrxpOF67bNCgjGNbctvo4mDtw@mail.gmail.com>
Subject: Re: KCSAN: data-race in generic_file_buffered_read / generic_file_buffered_read
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Jul 2020 at 09:52, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Eric Biggers's message of July 16, 2020 4:54 pm:
> > On Thu, Jul 16, 2020 at 04:24:01PM +1000, Nicholas Piggin wrote:
> >> Excerpts from Eric Biggers's message of July 16, 2020 1:03 pm:
> >> > On Thu, Jul 16, 2020 at 09:42:03AM +1000, Dave Chinner wrote:
> >> >> On Wed, Jul 15, 2020 at 09:32:56AM -0700, Eric Biggers wrote:
[...]
> >> >> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> > > > BUG: KCSAN: data-race in generic_file_buffered_read / generic=
_file_buffered_read
[...]
> >> >> > Concurrent reads on the same file descriptor are allowed.  Not wi=
th sys_read(),
> >> >> > as that implicitly uses the file position.  But it's allowed with=
 sys_pread(),
> >> >> > and also with sys_sendfile() which is the case syzbot is reportin=
g here.
> >> >>
> >> >> Concurrent read()s are fine, they'll just read from the same offset=
.
> >> >
> >> > Actually the VFS serializes concurrent read()'s on the same fd, at l=
east for
> >> > regular files.
> >>
> >> Hmm, where?
> >
> > It's serialized by file->f_pos_lock.  See fdget_pos().
>
> Ah thanks! Missed that.
>
> >> >> > > > write to 0xffff8880968747b0 of 8 bytes by task 6336 on cpu 0:
> >> >> > > >  generic_file_buffered_read+0x18be/0x19e0 mm/filemap.c:2246
> >> >> > >
> >> >> > >       ...
> >> >> > >       would_block:
> >> >> > >               error =3D -EAGAIN;
> >> >> > >       out:
> >> >> > >               ra->prev_pos =3D prev_index;
> >> >> > >               ra->prev_pos <<=3D PAGE_SHIFT;
> >> >> > > 2246)         ra->prev_pos |=3D prev_offset;
> >> >> > >
> >> >> > >               *ppos =3D ((loff_t)index << PAGE_SHIFT) + offset;
> >> >> > >               file_accessed(filp);
> >> >> > >               return written ? written : error;
> >> >> > >       }
> >> >> > >       EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> >> >> > >       ...
> >> >> >
> >> >> > Well, it's a data race.  Each open file descriptor has just one r=
eadahead state
> >> >> > (struct file_ra_state), and concurrent reads of the same file des=
criptor
> >> >> > use/change that readahead state without any locking.
> >> >> >
> >> >> > Presumably this has traditionally been considered okay, since rea=
dahead is
> >> >> > "only" for performance and doesn't affect correctness.  And for p=
erformance
> >> >> > reasons, we want to avoid locking during file reads.
> >> >> >
> >> >> > So we may just need to annotate all access to file_ra_state with
> >> >> > READ_ONCE() and WRITE_ONCE()...
> >> >>
> >> >> Please, no. Can we stop making the code hard to read, more difficul=
t
> >> >> to maintain and preventing the compiler from optimising it by doing
> >> >> stupid "turn off naive static checker warnings" stuff like this?
> >> >>
> >> >> If the code is fine with races, then -leave it alone-. If it's not
> >> >> fine with a data race, then please go and work out the correct
> >> >> ordering and place well documented barriers and/or release/acquire
> >> >> ordering semantics in the code so that we do not need to hide data
> >> >> races behind a compiler optimisation defeating macro....
> >> >>
> >> >> Yes, I know data_race() exists to tell the tooling that it should
> >> >> ignore data races in the expression, but that makes just as much
> >> >> mess of the code as READ_ONCE/WRITE_ONCE being spewed everywhere
> >> >> indiscriminately because <some tool said we need to do that>.
> >> >>
> >> >
> >> > Data races are undefined behavior, so it's never guaranteed "fine".
> >>
> >> Is this a new requirement for the kernel? Even code which is purely an
> >> optimisation (e.g. a readahead heuristic) can never be guaranteed to
> >> be fine for a data race? As in, the compiler might be free to start
> >> scribbling on memory because of undefined behaviour?
> >>
> >> What we used to be able to do is assume that the variable might take o=
n
> >> one or other value at any time its used (or even see split between the
> >> two if the thing wasn't naturally aligned for example), but that was
> >> quite well "defined". So we could in fact guarantee that it would be
> >> fine.
> >
> > Not really, it's always been undefined behavior.
> >
> > AFAICT, there's tribal knowledge among some kernel developers about wha=
t types
> > of undefined behavior are "okay" because they're thought to be unlikely=
 to cause
> > problems in practice.  However except in certain cases (e.g., the kerne=
l uses
> > -fwrapv to make signed integer overflow well-defined, and -fno-strict-a=
liasing
> > to make type aliasing well-defined) these cases have never been formall=
y
> > defined, and people disagree about them.  If they have actually been fo=
rmally
> > defined, please point me to the documentation or compiler options.
>
> Well we did traditionally say stores to natural aligned word types and
> smaller were atomic (although being loff_t may not be true for 32-bit).
> Kernel behaviour, rather than C (which as you say is not kernel
> semantics).

This is one assumption that KCSAN is definitely aware of and is
included in its default config. I'd still prefer a WRITE_ONCE(), as
I'm a little more paranoid of things breaking on some arch with some
compiler, and as it documents the fact there is concurrency. In the
end nobody is forcing anything yet.

> > Data races in particular are tricky because there are a lot of ways for=
 things
> > to go wrong that people fail to think of; for some examples see:
> > https://www.usenix.org/legacy/event/hotpar11/tech/final_files/Boehm.pdf
> > https://software.intel.com/content/www/us/en/develop/blogs/benign-data-=
races-what-could-possibly-go-wrong.html

I'll add to this, our recent kernel-specific summary,
  https://lwn.net/Articles/816850/#Why%20should%20we%20care%20about%20data%=
20races?
and
  https://lwn.net/Articles/793253/

In short, the kernel makes its own rules and are meant to be captured
in the LKMM.

Data races in the kernel are tolerable in certain codes, but due to
the subtleness in which things can break, we ought to try and document
intentional data races with 'data_race(..)'. Because otherwise, there
is no telling if it was intentional or not.

> If we abandon that and go with always explicit accessors okay. But none
> of those are things that surprise the kernel model except this one
>
> "So if a program stores to a variable X, the compiler can legally reuse
> X=E2=80=99s storage for any temporal data inside of some region of code b=
efore
> the store (e.g. to reduce stack frame size)."
>
> Which is wrong and we'd never tolerate it in the kernel. We don't just
> race with other threads but also our interrupts. preempt_enable()
> called somewhere can't allow the compiler to enable preemption by
> spilling zero to preempt_count in code before the call, for example.
>
> So that would be disabled exactly the same as other insanity.

Indeed, the LKMM tries to capture some of the kernel's rules, in
effect we do roll our own standard. However, because of the disconnect
between what the compiler is aware of and what we merely assume, we
need to be extra careful. Some things can be enforced with more
compiler flags (but not everything).

> The only argument really is for race checkers.

The race checker, in this case KCSAN, does follow as closely as
possible to the kernel's written rules (i.e. LKMM), but also some
unwritten rules ("assume aligned writes up to word size are atomic")
by default. What other unwritten rules are we missing?

> >> > We can only
> >> > attempt to conclude that it's fine "in practice" and is too difficul=
t to fix,
> >> > and therefore doesn't meet the bar to be fixed (for now).
> >> >
> >> > Of course, in most cases the preferred solution for data races is to=
 introduce
> >> > proper synchronization.  As I said, I'm not sure that's feasible her=
e.  Memory
> >> > barriers aren't the issue here; we'd need *locking*, which would mea=
n concurrent
> >> > readers would start contending for the lock.  Other suggestions appr=
eciated...
> >>
> >>
> >>              ra->prev_pos =3D prev_index;
> >>              ra->prev_pos <<=3D PAGE_SHIFT;
> >>  2246)               ra->prev_pos |=3D prev_offset;
> >>
> >>
> >> In this case we can do better I guess, in case some compiler decides t=
o
> >> store a half-done calculation there because it ran out of registers.
> >>
> >> WRITE_ONCE(ra->prev_pos, ((loff_t)prev_index << PAGE_SHIFT) | prev_off=
set);
> >>
> >> As Dave said, adding WRITE_ONCE to the individual accesses would be
> >> stupid because it does nothing to solve the actual race and makes it
> >> harder to read in more than one way.
> >
> > Yes, obviously if we were to add READ/WRITE_ONCE we'd want to avoid sto=
ring
> > intermediate results like that, in order to avoid some obvious race con=
ditions.
>
> Well the suggestion was to just simply add READ/WRITE once to all
> accesses, not to fix them up. That would actually add more race
> conditions.
>
> > However, the overall use of file_ra_state is still racy.  And it's pass=
ed to the
> > functions in mm/readahead.c like page_cache_async_readahead() too, so a=
ll the
> > accesses to it in those functions are data races too.
> >
> > I'm not really suggesting any specific solution; locking isn't really f=
easible
> > here, and there would be an annoyingly large number of places that woul=
d need
> > READ/WRITE_ONCE.
>
> If you put behind some accessor functions it might become easier,
> but...
>
> > I just wish we had a better plan than "let's write some code with
> > undefined behavior and hope it's okay".
>
> It really isn't so undefined as you think. Again, we enforce against
> insane compilers de facto if not written anywhere with our interrupt
> races. So we really can guarantee it'll be okay.

Agreed that we make our own rules, for better or worse. But I think
even within these rules and assumptions, the case around the
'prev_pos' accesses just isn't safe. In particular, these plain
compound ops / read-modify-writes just aren't guaranteed to be atomic,
even with tons of compiler flags.

Thanks,
-- Marco
