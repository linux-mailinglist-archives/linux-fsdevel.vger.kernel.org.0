Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABAF7639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKOSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 09:18:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40932 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKOSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:18:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id m15so11339599otq.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0W1n0b934oa9x92tev635siFZCltGl2D+xamCm39z0=;
        b=dwlafrN5wf9ZIU+8HnaHXgZxiE2WQoT2x13HIzNXh13AVC2z3WLTG/MDiHDkrI9DLI
         HtQNz8QlSzy6fLSGhikfiPTKLrcsgsN9aGBQShDYal54qTdyehcCHU2vWo/9MjyZUuad
         oj22/sOn27ZMo4QbsiE1ldiPe95t4pY5hCRyAoI3IaepW5H3a7dXwX0aolfiFAVR4M+I
         SEtyClMYBDLUyznNvnNoQDY9NQT+NXdQPZo6OB6N/UshLDbhAwwuW2zX+zZKj2C5nGbG
         bNY6gOTRehHoOIDsL8aWekzTNutrCox1p1heqVt36+Y/jUV6fXtDPfKfnhS6uSzqI/XL
         w84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0W1n0b934oa9x92tev635siFZCltGl2D+xamCm39z0=;
        b=eZEtOosQZS+wX7lgDnvzX6OC1y1sL4gdx/skGHzPTRpgpbSBb/qs15w8oNl3uz3RNp
         4vmKn3OIjbtJneL6Ct4x5DpvKyc+VRZM4V300oWflVXOi3OaV4MsQmX1clwHlxotU+U/
         397lCDtZnMrfgyGUHZ+Zd5EAUxXp6yPch7BpsxJwzoeGFKSZ28LyiWWshfa0IlfVqSwY
         cob4N2xXJrFmGffzODyoxV7LWk6AEntc7cbEI7SRYWlqPyuqUXaz5eoys+8vijEe2tYV
         5BN1guTALFDpYW+jdq/uyBegY4NvEPVfaaUhKIZBvRhb1WL+TC4jNfd9sSguMu3ApMKu
         yfQw==
X-Gm-Message-State: APjAAAW8a0wa+gpmywYch7fA5BomLJH3t1khwTCg60GsiewHmwf6JG00
        BSa08xOeXV+7Eb3Q9I8hyNZUL/Y+/pVcTb+dprQW3g==
X-Google-Smtp-Source: APXvYqwIWidb8/pbE2F77YzjZa65IUUEcN92SCyHgSszq3N6tcIFrUSDUMVJsu4ljJDPwcm5bwJQ7bnjdPykTR9d/Og=
X-Received: by 2002:a9d:7308:: with SMTP id e8mr22346700otk.17.1573481884676;
 Mon, 11 Nov 2019 06:18:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com> <20191110204442.GA2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191110204442.GA2865@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 11 Nov 2019 15:17:51 +0100
Message-ID: <CANpmjNOepvb6+zJmDePxj21n2rctM4Sp4rJ66x_J-L1UmNK54A@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 10 Nov 2019 at 21:44, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Nov 10, 2019 at 11:20:53AM -0800, Linus Torvalds wrote:
> > On Sun, Nov 10, 2019 at 11:12 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > And this is where WRITE_IDEMPOTENT would make a possible difference.
> > > In particular, if we make the optimization to do the "read and only
> > > write if changed"
> >
> > It might be useful for checking too. IOW, something like KCSAN could
> > actually check that if a field has an idempotent write to it, all
> > writes always have the same value.
> >
> > Again, there's the issue with lifetime.
> >
> > Part of that is "initialization is different". Those writes would not
> > be marked idempotent, of course, and they'd write another value.
> >
> > There's also the issue of lifetime at the _end_ of the use, of course.
> > There _are_ interesting data races at the end of the lifetime, both
> > reads and writes.
> >
> > In particular, if it's a sticky flag, in order for there to not be any
> > races, all the writes have to happen with a refcount held, and the
> > final read has to happen after the final refcount is dropped (and the
> > refcounts have to have atomicity and ordering, of course). I'm not
> > sure how easy something like that is model in KSAN. Maybe it already
> > does things like that for all the other refcount stuff we do.
> >
> > But the lifetime can be problematic for other reasons too - in this
> > particular case we have a union for that sticky flag (which is used
> > under the refcount), and then when the final refcount is released we
> > read that value (thus no data race) but because of the union we will
> > now start using that field with *different* data. It becomes that RCU
> > list head instead.
> >
> > That kind of "it used to be a sticky flag, but now the lifetime of the
> > flag is over, and it's something entirely different" might be a
> > nightmare for something like KCSAN. It sounds complicated to check
> > for, but I have no idea what KCSAN really considers complicated or
> > not.
>
> But will "one size fits all" be practical and useful?
>
> For my code, I would be happy to accept a significant "false positive"
> rate to get even a probabilistic warning of other-task accesses to some
> of RCU's fields.  Even if the accesses were perfect from a functional
> viewpoint, they could be problematic from a performance and scalability
> viewpoint.  And for something like RCU, real bugs, even those that are
> very improbable, need to be fixed.
>
> But other code (and thus other developers and maintainers) are going to
> have different needs.  For all I know, some might have good reasons to
> exclude their code from KCSAN analysis entirely.
>
> Would it make sense for KCSAN to have per-file/subsystem/whatever flags
> specifying the depth of the analysis?

Just to answer this: we already have this, and disable certain files
already. So it's an option if required. Just need maintainers to add
KCSAN_SANITIZE := n, or KCSAN_SANITIZE_file.o := n to Makefiles, and
KCSAN will simply ignore those.

FWIW we now also have a config option to "ignore repeated writes with
the same value". It may be a little overaggressive/imprecise in
filtering data races, but anything else like the super precise
analysis involving tracking lifetimes and values (and whatever else
the rules would require) is simply too complex. So, the current
solution will avoid reporting cases like the original report here
(__alloc_file), but at the cost of maybe being a little imprecise.
It's probably a reasonable trade-off, given that we have too many data
races to deal with on syzbot anyway.

Thanks,
-- Marco
