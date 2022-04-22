Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEE50C2C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 01:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiDVWYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiDVWWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:22:40 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BA33B1F4;
        Fri, 22 Apr 2022 14:13:54 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh4so6401749qtb.10;
        Fri, 22 Apr 2022 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ltspd1kAoltrAR3Ypvc7DnB31QkIxC9beOae11A7xas=;
        b=cBoQK7Aohj7+n/NK7JwkbS4mxpCkGlDJBuwBKCrqz38KJgD1gLLxJWKGHurFTxey9J
         Y4bBGcnSngp7dIVhhCelE/oi9hQHeRusSG0y/LlXxX7QoCcyNBUK3Dz1vGBwbImTjWEI
         29yOfJoVbXqhZuVaWPUHMuo7LLlov9D6E90031zIIVLV+gMxrOY9Uv3L8bA6DJPtbupy
         ya6bPFn2avHsM/8Z6aXU81DYXidFUTpIBo1+mY43JolZmkKOh/FYIVdxsnb7jXLz47P+
         PpAp/jVq0F8C8gszIjpqlVnLFgm+1c1FAuvZQMGwN5vEfgD/5cB/ahRezsHPRiv6r9cb
         zezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ltspd1kAoltrAR3Ypvc7DnB31QkIxC9beOae11A7xas=;
        b=aY58zWXTj2YhQcEu3dhHLqPAC8Ozx27cpOqjzKKCvIiIasLZGgQjckCFohYiDK5GCG
         QKSwmcfjwLmNA5XpqlxT8ZhuVs5RKUseKBA6e/abRjaz6itqMPwZeBziKVzVE7uSEEfq
         Eugfk2Mlu65pJfLFoHUgl8RvrzJXUMo9kEeTogQNPzFYRL91DuHXvr3TukfjSTuc1Qzd
         NlYzjQaD/IW3fVhizpECa8ln/00s6ibP6DLLe5PNCG4CcCu7iKjuvuB3o1/Yd2qi1Rsl
         BnJ34FM0wKSYYaHxq5ds5s2ESomc2+eGjFwxiPHpOfrx9LGAKLAsPSLWNDtnT0O7dQso
         n0UQ==
X-Gm-Message-State: AOAM5313yNHPGoOZ8O3r4J/G+J0hPlmcv5ynrMGzn5eUcd0hHdsijzbO
        1F8yb00zTrhXu4YdpBhStw==
X-Google-Smtp-Source: ABdhPJw6GBCy6uTiz2fdlqXH8AUzPjizUNgatYtGRfTokh4LrmnuuNUPHbtrAj2uI5Y9ggtDK0MHQQ==
X-Received: by 2002:a05:622a:3cd:b0:2f3:4af5:f2bb with SMTP id k13-20020a05622a03cd00b002f34af5f2bbmr4713041qtx.363.1650662033240;
        Fri, 22 Apr 2022 14:13:53 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1422717qkd.4.2022.04.22.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:13:52 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:13:50 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422211350.qn2brzkfwsulwbiq@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <20220422042017.GA9946@lst.de>
 <YmI5yA1LrYrTg8pB@moria.home.lan>
 <20220422052208.GA10745@lst.de>
 <YmI/v35IvxhOZpXJ@moria.home.lan>
 <20220422113736.460058cc@gandalf.local.home>
 <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
 <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:03:12PM -0400, James Bottomley wrote:
> Hey, I didn't say that at all.  I said vendoring the facebook reference
> implementation wouldn't work (it being 74k lines and us using 300) but
> that facebook was doing the right thing for us with zstd because they
> were maintaining the core code we needed, even if we couldn't vendor it
> from their code base:
> 
> https://lore.kernel.org/rust-for-linux/ea85b3bce5f172dc73e2be8eb4dbd21fae826fa1.camel@HansenPartnership.com/
> 
> You were the one who said all that about facebook, while incorrectly
> implying I said it first (which is an interesting variation on the
> strawman fallacy):

Hey, sorry for picking on you James - I didn't mean to single you out.

Let me explain where I'm coming from - actually, this email I received puts it
better than I could:

From: "John Ericson" <mail@johnericson.me>
To: "Kent Overstreet" <kent.overstreet@gmail.com>
Subject: Nice email on cargo crates in Linux

Hi. I saw your email linked from https://lwn.net/Articles/889924/. Nicely put!

I was involved in some of the allocating try_* function work to avoid nasty
panics, and thus make sure Rust in Linux didn't have to reinvent the wheel
redoing the alloc library. I very much share your goals but suspect this will
happen in a sort of boil-the-frog way over time. The basic portability method of
"incentivize users to write code that's *more* portable than what they currently
need" is a culture shock for user space and kernel space alike. But if we get
all our ducks in a row on the Rust side, eventually it should just be "too
tempting", and the code sharing will happen for economic reasons (rather than
ideological ones about trying to smash down the arbitrary dichotomies :) going
it alone).

The larger issue is major projects closed off unto themselves such as Linux,
PostgreSQL, or even the Glasgow Haskell Compiler (something I am currently
writing a plan to untangle) have fallen too deep in Conway's law's embrace, and
thus are full of bad habits like
https://johno.com/composition-over-configuration is arguing against. Over time,
I hope using external libraries will not only result in less duplicated work,
but also "pry open" their architecture a bit, tamping down on crazy
configurability and replacing it with more principled composition.

I fear this is all way too spicy to bring up on the LKML in 2022, at least
coming from someone like me without any landed kernel patches under his belt,
but I wanted to let you know other people have similar thoughts.

Cheers,

John

-------

Re: Rust in Linux, I get frustrated when I see senior people tell the new Rust
people "don't do that" to things that are standard practice in the outside
world.

I think Linus said recently that Rust in the kernel is something that could
fail, and he's right - but if it fails, it won't just be the failure of the Rust
people to do the required work, it'll be _our_ failure too, a failure to work
with them.

And I think the kernel needs Rust, in the long term. Rust is the biggest advance
towards programming languages with embedded correctness proofs in the systems
space since ever, and that's huge. It's only a first step, it doesn't solve
everything - the next step will probably be dependent types (as in Idris); after
that it's hard to say. But maybe 50, 100 years out, systems programming is going
to look very different.

And that excites me! What I love about programming is being able to sink into
something new, difficult and unsolved, and let my mind wander and explore and
play with ideas until I come across a simple and elegant way of solving it.

What I hate about programming is starting to do that, and then an hour in
getting interrupted by a bug report in an area of the code that I should have
been done with. And then again. And then again.

But that's just the nature of the beast in C, with the current state of the art
of the tools we have. Proving C programs correct can be done (I understand Paul
McKenney is on the bleeding edge of that), but it's too expensive and time
consuming to be practical for most things. We need better languages.

And we've got people trying to work with us, so I hope we work with them and
make it happen. That's going to require us to update our thinking in some areas
- like with cargo.

C people are used to projects being monoliths, but in the modern world things
that in prior days would have required hacking the compiler are now done as
libraries - and we're going to want that code! We don't need to be
reimplementing rust bitvecs, or string parsing, or - I could make up a long,
long list. That code is all going to just work in kernel land, and if we adopt
it it'll lead to a lot less duplication of effort.

Also, what John said in that email about "large projects closed off unto
themselves" - he's spot on about that. When I was at Google, their was this deep
unspoken assumption that anything done at Google was better than anything in the
outside world, and it _rankled_. It was a major reason I departed.

The kernel community has a lot of that going on here. Again, sorry to pick on
you James, but I wanted to make the argument that - maybe the kernel _should_ be
adopting a more structured way of using code from outside repositories, like
cargo, or git submodules (except I've never had a positive experience with git
submodules, so ignore that suggestion, unless I've just been using them wrong,
in which case someone please teach me). To read you and Greg saying "nah, just
copy code from other repos, it's fine" - it felt like being back in the old days
when we were still trying to get people to use source control, and having that
one older colleague who _insisted_ on not using source control of any kind, and
that's a bit disheartening.

I just want to make both the kernel and the wider world of open source software
a better place, and the thing I'm itching to see get better is that currently
it's a massive hassle to share code between kernel space and user space. This is
understandable, because before git we definitely didn't have the tooling, and in
C this kind of code sharing has historically been questionable.

But:
 - We've got a new language coming that makes this sort of thing a lot saner,
   both from a source code management perspective (cargo) and with much stronger
   language guarantees that code won't do something surprising on you

 - Even in C, we're gaining a better appreciation for why someone would want to
   do such a thing.

   Another random case in point: liblwipv6, a userspace TCP/IP library, lets you
   do really cool things with building/simulating networks entirely in userspace
   without root access, just over unix domain sockets. But it's a completely new
   implementation, and thus buggy and incomplete. Imagine if, in some far away
   future, we could someday just reuse the whole Linux network stack in
   userspace, for purposes undreamed of by the likes of us...

And also, personally I find that code gets better when you have to spend the
effort to clean it up, make it more modular, and separate it from the wider
project - that's when you find out what it's really about. There's a ton of
_really effing cool code_ in the kernel that could be seeing wider use in
userspace, too (workqueues!). And, like with pretty printers, once you start
down a good path it often begets more of itself - modularity will lead to more
modularity. If we start making thinks like workqueues more modular and also
usable as a userspace library, that's going to make it easier to port more
kernel code, and more... which will make writing C in userspace a nicer
experience, and maybe even lead to more code sharing in the reverse direction..

Anyways, just one man's dream :)
