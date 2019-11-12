Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22792F9A05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 20:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKLTsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 14:48:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38204 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:48:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so13892624lfa.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgHAQu7q0hm2Jv+kZ/rgn9kx8R73GBFOOYAXZwlwBjs=;
        b=Ycf3JkS+jGUVRsZr8w99fixozLYf51BvrU3zaMhrBAR16NGapJ8VQPu8ncSdGpa2IK
         hSapVFPjSIPqZMiUTF5hiodE5GC4J7qwEURg2JPonVhonpNSsAzqypUdoKPrevU0G7NL
         J/9K8p70fU365uvj8fxUZZXUHB/YXKCut7YO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgHAQu7q0hm2Jv+kZ/rgn9kx8R73GBFOOYAXZwlwBjs=;
        b=rQ68emLtZzb237gYkGFlqiFeuIGIvlUO4xgIvw0xBfitLSL7APGW291ZXOZ113ewNx
         FeQR60n6mIpHZnDSqjriHOUaz4Xw4srmo6l8kgLFkBCeudGlpyS5r13JJXvVPkTR+e95
         LmX2CkNuDwMrp2pyrTxIK/sDzTmijVjHw2bmBW1hRLyrFQm9CpxMB0F+DKJsQHfCi6mc
         Vuh5mnBjZmOKuocaRpSPivKDhp4jSdB/DY3qDQee6cZGxH2AdY5VFgN9Kl3Ng6CZMSB5
         qoMPdsuSZXHw2bBJQ7J7SuPh5EhV0OK7xgRRX/8APev4mL8Y9zMkP45d+aC/bmy/qxS8
         V4hw==
X-Gm-Message-State: APjAAAVWJ/97ozDfG0MUKZIjsSth1Js36Cxqo8Vtoz2fXcqO315pVAD4
        H+c9mAU70uvapbh7dxIuQwF5WsbJp5M=
X-Google-Smtp-Source: APXvYqzeL2DhtiG0QZlIGzmskOwmu1aEdUa/G22d7ox565WSk4Iga9T00s5/Bx3WOpErLFFwnGapGg==
X-Received: by 2002:ac2:5193:: with SMTP id u19mr16393427lfi.83.1573588099404;
        Tue, 12 Nov 2019 11:48:19 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q16sm7689505lfm.87.2019.11.12.11.48.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:48:18 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m6so13877678lfl.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2019 11:48:17 -0800 (PST)
X-Received: by 2002:a19:c790:: with SMTP id x138mr21100386lff.61.1573588097381;
 Tue, 12 Nov 2019 11:48:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121400200.1567-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911121400200.1567-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 11:47:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
Message-ID: <CAHk-=wjGd0Ce2xadkiErPWxVBT2mhyeZ4TKyih2sJwyE3ohdHw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
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

On Tue, Nov 12, 2019 at 11:14 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> One could be the thing you brought up earlier: Suppose the compiler
> decides to use the "write only if changed" transformation, so that the
> code generated for the sticky write:
>
>         x = 1;
>
> ends up being what you would expect to see for:
>
>         if (x != 1)
>                 x = 1;

That is exactly the kind of  crap that would make me go "use the flag
to disable that invalid optimization, or don't use the compiler".

We already do -param=allow-store-data-races=0

The C standards body sadly has a very bad track record on this kind of
thing, where they have allowed absolutely insane extensions of "that's
undefined" in the name of making C a much worse language (they say "to
compete with Fortran", but it's the same thing).

I have talked to some people who have tried to change that course, but
they are fed up with the standards body too, and it's fighting
windmills.

Which is why I don't even  bother. The C standard language-lawyering
is simply not interesting to me. Yes, there are too many people who do
it, and I don't care.

For the kernel, we basically do not accept "that's undefined behavior,
I might generate odd code".

If the compiler can statitcally give an error for it, then that's one
thing, and we'd be ok with that. But the kind of mindset where people
think it's ok to have the compiler read the standard cross-eyed and
change the obvious meaning of the code "because it's undefined
behavior" is to me a sign of a cn incompetent compiler writer, and I
am not at all interested in playing that game.

Seriously.

I wish somebody on the C standard had the back-bone to say "undefined
behavior is not acceptable", and just say that the proper
optimizations are ones where you transform the code the obvious
straightforward way, and then you only do optimizations that are based
on that code and you can prove do not change semantics.

You can't add reads that weren't there.

But you can look at code that did a read, and then wrote back what you
can prove is the same value, and say "that write is redundant, just
looking at the code".

See the difference?

One approach makes up shit. The other approach looks at the code AS
WRITTEN and can prove "that's stupid, I can do it better, and I can
show why it makes no difference".

So you can change "i++; i++;" to "i +=2", even if "i" is not a private
variable. Did that remove a write? Yes it did. But it really falls
under the "I just improved on the code".

But you can *not* do the insane things that type-based aliasing do
(lack the "prove it's the same" part).

Because when we notice that in the kernel, we turn it off. It's why we have

 -fno-strict-overflow
 -fno-merge-all-constants
 -fno-strict-aliasing
 -fno-delete-null-pointer-checks
 --param=allow-store-data-races=0

and probably others. Because the standard is simply wrong when you
care about reliability.

> But what about C11 relaxed atomic reads and writes?

Again, I'm not in the least interested in the C11 standard
language-lawyering, because it has shown itself to not be useful.

Stop bringing up the "what if" cases. They aren't interesting. If a
compiler turns a single write into some kind of conditional write, or
if the compiler creates dummy writes, the compiler is garbage. No
amount of "but but but C11" is at all relevant.

What a compiler can do is:

 - generate multiple (and speculative) reads

 - combine writes to the same location (non-speciulatively)

 - take advantage of actual reads in the source code to do
transformations that are obvious (ie "oh, you read value X, you tested
by Y was set, now you write it back again, but clearly the value
didn't change so I can avoid the write").

so yes, a compiler can remove a _redundant_ write, and if the SOURCE
CODE has the read in it and the compiler decides "Oh, I already know
it has that value" then that's one thing.

But no, the compiler can not add data races that weren't there in the
source code and say "but C11". We're not compiling to the standard.
We're compiling to the real world.

So if the compiler just adds its own reads, I don't want to play with
that compiler. It may be appropriate in situations where we don't have
threads, we don't have security issues, and we don't have various
system and kernel concerns, but it's not appropriate for a kernel.

It really is that simple.

This is in no way different from other language lawyering, ie the
whole "signed arithmetic overflows are undefined, so i can do
optimization X" or "I can silently remove the NULL pointer check
because you accessed it before and that invoced undefined behavior, so
now I can do anthing".

Those optimizations may be valid in other projects. They are not valid
for the kernel.

Stop bringing them up. They are irrelevant. We will keep adding the
options to tell the compiler "no, we're not your toy benchmark, we do
real work, and that optimization is dangerous".

              Linus
