Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0869AF7669
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKObd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 09:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfKKObc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:31:32 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB6221783;
        Mon, 11 Nov 2019 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573482691;
        bh=GMZI2Sm1wod0W0IIImi2Ed9CAV0vya6ie3zoGPyCgog=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i+3S+9SZglmKH+6cRaKsLUmilQjXcGAmT8d/BSJO1Sq53eO3arP4NakS/tAdgRfQN
         nIMti0stiXIJOR0Vp9rL0o7T5BcgRGVSN1gyJ9fBCuAjmMjd00NdSufi4P3sBw0+jr
         tHI9+gWP/32onjGYnB444LTbFd4hBG3odbTx/2/o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DB95D35227B6; Mon, 11 Nov 2019 06:31:30 -0800 (PST)
Date:   Mon, 11 Nov 2019 06:31:30 -0800
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
Message-ID: <20191111143130.GO2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com>
 <20191110204442.GA2865@paulmck-ThinkPad-P72>
 <CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:17:51PM +0100, Marco Elver wrote:
> On Sun, 10 Nov 2019 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Nov 10, 2019 at 11:20:53AM -0800, Linus Torvalds wrote:
> > > On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > And this is where WRITE_IDEMPOTENT would make a possible difference.
> > > > In particular, if we make the optimization to do the "read and only
> > > > write if changed"
> > >
> > > It might be useful for checking too. IOW, something like KCSAN could
> > > actually check that if a field has an idempotent write to it, all
> > > writes always have the same value.
> > >
> > > Again, there's the issue with lifetime.
> > >
> > > Part of that is "initialization is different". Those writes would not
> > > be marked idempotent, of course, and they'd write another value.
> > >
> > > There's also the issue of lifetime at the _end_ of the use, of course.
> > > There _are_ interesting data races at the end of the lifetime, both
> > > reads and writes.
> > >
> > > In particular, if it's a sticky flag, in order for there to not be any
> > > races, all the writes have to happen with a refcount held, and the
> > > final read has to happen after the final refcount is dropped (and the
> > > refcounts have to have atomicity and ordering, of course). I'm not
> > > sure how easy something like that is model in KSAN. Maybe it already
> > > does things like that for all the other refcount stuff we do.
> > >
> > > But the lifetime can be problematic for other reasons too - in this
> > > particular case we have a union for that sticky flag (which is used
> > > under the refcount), and then when the final refcount is released we
> > > read that value (thus no data race) but because of the union we will
> > > now start using that field with *different* data. It becomes that RCU
> > > list head instead.
> > >
> > > That kind of "it used to be a sticky flag, but now the lifetime of the
> > > flag is over, and it's something entirely different" might be a
> > > nightmare for something like KCSAN. It sounds complicated to check
> > > for, but I have no idea what KCSAN really considers complicated or
> > > not.
> >
> > But will "one size fits all" be practical and useful?
> >
> > For my code, I would be happy to accept a significant "false positive"
> > rate to get even a probabilistic warning of other-task accesses to some
> > of RCU's fields.  Even if the accesses were perfect from a functional
> > viewpoint, they could be problematic from a performance and scalability
> > viewpoint.  And for something like RCU, real bugs, even those that are
> > very improbable, need to be fixed.
> >
> > But other code (and thus other developers and maintainers) are going to
> > have different needs.  For all I know, some might have good reasons to
> > exclude their code from KCSAN analysis entirely.
> >
> > Would it make sense for KCSAN to have per-file/subsystem/whatever flags
> > specifying the depth of the analysis?
> 
> Just to answer this: we already have this, and disable certain files
> already. So it's an option if required. Just need maintainers to add
> KCSAN_SANITIZE := n, or KCSAN_SANITIZE_file.o := n to Makefiles, and
> KCSAN will simply ignore those.
> 
> FWIW we now also have a config option to "ignore repeated writes with
> the same value". It may be a little overaggressive/imprecise in
> filtering data races, but anything else like the super precise
> analysis involving tracking lifetimes and values (and whatever else
> the rules would require) is simply too complex. So, the current
> solution will avoid reporting cases like the original report here
> (__alloc_file), but at the cost of maybe being a little imprecise.
> It's probably a reasonable trade-off, given that we have too many data
> races to deal with on syzbot anyway.

Nice!

Is this added repeated-writes analysis something that can be disabled?
I would prefer that the analysis of RCU complain in this case as a
probabilistic cache-locality warning.  If it can be disabled, please
let me know if there is anything that I need to do to make this happen.

							Thanx, Paul
