Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0163AF9F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 01:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKMAZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 19:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKMAZy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:25:54 -0500
Received: from paulmck-ThinkPad-P72.home (mobile-166-170-41-44.mycingular.net [166.170.41.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 511E8206BB;
        Wed, 13 Nov 2019 00:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573604753;
        bh=mLoRc7xrMdQw+ffhUJg6Sb6nBeDmV1R+gXAnFi4PYOQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Qc7ANhhF0Q56Mvvb7FTBCe5m32hrRAqrgGZH8nUAiTUkP2Uos/8QMH9dWGu4cKiVc
         W4HNcWNZNAdIbI4n1M+m9gBmTfcagZx4VeNFf8UkK8GZzWJFTjAI37Ut35W6szBKe2
         QP74ZjQqV+vGcQg072MVSntLtt2JX0g6nNTRM7HM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B618335227E6; Tue, 12 Nov 2019 16:25:52 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:25:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
Message-ID: <20191113002552.GY2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
 <20191110204442.GA2865@paulmck-ThinkPad-P72>
 <CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com>
 <20191111143130.GO2865@paulmck-ThinkPad-P72>
 <CANpmjNP4qj7XcYcdrEEb+0_qeg-ii77qy0=-b9k07VRyNjqixA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP4qj7XcYcdrEEb+0_qeg-ii77qy0=-b9k07VRyNjqixA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:10:20PM +0100, Marco Elver wrote:
> On Mon, 11 Nov 2019 at 15:31, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 11, 2019 at 03:17:51PM +0100, Marco Elver wrote:
> > > On Sun, 10 Nov 2019 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, Nov 10, 2019 at 11:20:53AM -0800, Linus Torvalds wrote:
> > > > > On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
> > > > > <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > And this is where WRITE_IDEMPOTENT would make a possible difference.
> > > > > > In particular, if we make the optimization to do the "read and only
> > > > > > write if changed"
> > > > >
> > > > > It might be useful for checking too. IOW, something like KCSAN could
> > > > > actually check that if a field has an idempotent write to it, all
> > > > > writes always have the same value.
> > > > >
> > > > > Again, there's the issue with lifetime.
> > > > >
> > > > > Part of that is "initialization is different". Those writes would not
> > > > > be marked idempotent, of course, and they'd write another value.
> > > > >
> > > > > There's also the issue of lifetime at the _end_ of the use, of course.
> > > > > There _are_ interesting data races at the end of the lifetime, both
> > > > > reads and writes.
> > > > >
> > > > > In particular, if it's a sticky flag, in order for there to not be any
> > > > > races, all the writes have to happen with a refcount held, and the
> > > > > final read has to happen after the final refcount is dropped (and the
> > > > > refcounts have to have atomicity and ordering, of course). I'm not
> > > > > sure how easy something like that is model in KSAN. Maybe it already
> > > > > does things like that for all the other refcount stuff we do.
> > > > >
> > > > > But the lifetime can be problematic for other reasons too - in this
> > > > > particular case we have a union for that sticky flag (which is used
> > > > > under the refcount), and then when the final refcount is released we
> > > > > read that value (thus no data race) but because of the union we will
> > > > > now start using that field with *different* data. It becomes that RCU
> > > > > list head instead.
> > > > >
> > > > > That kind of "it used to be a sticky flag, but now the lifetime of the
> > > > > flag is over, and it's something entirely different" might be a
> > > > > nightmare for something like KCSAN. It sounds complicated to check
> > > > > for, but I have no idea what KCSAN really considers complicated or
> > > > > not.
> > > >
> > > > But will "one size fits all" be practical and useful?
> > > >
> > > > For my code, I would be happy to accept a significant "false positive"
> > > > rate to get even a probabilistic warning of other-task accesses to some
> > > > of RCU's fields.  Even if the accesses were perfect from a functional
> > > > viewpoint, they could be problematic from a performance and scalability
> > > > viewpoint.  And for something like RCU, real bugs, even those that are
> > > > very improbable, need to be fixed.
> > > >
> > > > But other code (and thus other developers and maintainers) are going to
> > > > have different needs.  For all I know, some might have good reasons to
> > > > exclude their code from KCSAN analysis entirely.
> > > >
> > > > Would it make sense for KCSAN to have per-file/subsystem/whatever flags
> > > > specifying the depth of the analysis?
> > >
> > > Just to answer this: we already have this, and disable certain files
> > > already. So it's an option if required. Just need maintainers to add
> > > KCSAN_SANITIZE := n, or KCSAN_SANITIZE_file.o := n to Makefiles, and
> > > KCSAN will simply ignore those.
> > >
> > > FWIW we now also have a config option to "ignore repeated writes with
> > > the same value". It may be a little overaggressive/imprecise in
> > > filtering data races, but anything else like the super precise
> > > analysis involving tracking lifetimes and values (and whatever else
> > > the rules would require) is simply too complex. So, the current
> > > solution will avoid reporting cases like the original report here
> > > (__alloc_file), but at the cost of maybe being a little imprecise.
> > > It's probably a reasonable trade-off, given that we have too many data
> > > races to deal with on syzbot anyway.
> >
> > Nice!
> >
> > Is this added repeated-writes analysis something that can be disabled?
> > I would prefer that the analysis of RCU complain in this case as a
> > probabilistic cache-locality warning.  If it can be disabled, please
> > let me know if there is anything that I need to do to make this happen.
> 
> It's hidden behind a Kconfig config option, and actually disabled by
> default. We can't enable/disable this on a per-file basis.
> 
> Right now, we'll just enable it on the public syzbot instance, which
> will use the most conservative config.  Of course you can still run
> your own fuzzer/stress test of choice with KCSAN and the option
> disabled. Is that enough?
> 
> Otherwise I could also just say if the symbolized top stack frame
> contains "rcu_", don't ignore -- which would be a little hacky and
> imprecise though. What do you prefer?

Tough question.  ;-)

We could try the "rcu_" trick, and if it doesn't cause problems for
others, why not?

						Thanx, Paul
