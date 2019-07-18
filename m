Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125CE6D4AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbfGRTWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 15:22:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35970 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391376AbfGRTWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:22:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so13060162pfl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBFy7EH0mw2SK7uI8qKF1fHgdf6f9ZNwoqzuqnBlZ8E=;
        b=oGY8omtQvGoYcD+e34Yt9qr3X14EjkzXByvA7RTwGiQJZnWtAqL1Qgc9RC1Ce18u1a
         RbnrZ+mwJ+Bd8LTzYPwSiYFHCs8WowxKvwQUvizOSSbKQR7rkEx4fLIQ3xMzqPziBnTB
         BOlPaD8daje4roDr7mPrXuRrfUOUe3Qy+FoHEEHzHmWCQHlcCWyX/ktBi+iFcu6AWcMO
         6n009uLLGTzTGqdQJGOllwp42KObteDH+Y426amI5Qk8U7+eGVut6T5jhIZ7z0uwcv+G
         HL84r54w1Ns/ePAwAPEKi53cTkoAYcjquhAlYy4zKce3KZYEU04o3BUwIDhQJF9RtK/h
         UZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBFy7EH0mw2SK7uI8qKF1fHgdf6f9ZNwoqzuqnBlZ8E=;
        b=aO7E7AWCOVQx2+6BDMv1vbBqALhcgq+sab9e88njVHVcHAXWpbsNX6hxqF9wDKf/6U
         Gqb9OzPTvLBfd7SkpG7mFNkB61STlPBLnyzaG+MUajbrU6Il+urQU3LdrbUS9Y7Oe/hw
         Mnc0/BN8h+acrY58tFQgLh5iGw7R6jv5+L33jwDG14SzNEUlnMXQ02nVLCFa9IqV4Yn6
         JkLejCC7T9orLjVD1i0fL6nhOegy3CUSihCQTyjyL1hvBsE8DBJt5EkD6f4PfmjpS4P3
         TN+SAWxilIbc3SdVNrUXqnLdz+VIGkP8R46YBF+rlj1UGu3J3Z9E4huOkKLGfrt3zf+o
         +SMQ==
X-Gm-Message-State: APjAAAV6gpPTpvJRhEOPlU9QFoqs9+viQi/Hhkifn6BQy5HmHioXlAa6
        kxwCy1QUe9hvSsBXSU5NlhMMOYvu/zJNwKiyVKfs7w==
X-Google-Smtp-Source: APXvYqwEX6bf+N7IshMHyf6Ka9VvTGGohf11maoUS2kqSaEKH7rjYoGxlweVxaB2rT0fUBlD3BQp3PamQk99u/yqGyM=
X-Received: by 2002:a17:90a:ab0d:: with SMTP id m13mr50453432pjq.84.1563477765258;
 Thu, 18 Jul 2019 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-5-brendanhiggins@google.com> <20190715221554.8417320665@mail.kernel.org>
 <CAFd5g47ikJmA0uGoavAFsh+hQvDmgsOi26tyii0612R=rt7iiw@mail.gmail.com>
 <CAFd5g44_axVHNMBzxSURQB_-R+Rif7cZcg7PyZ_SS+5hcy5jZA@mail.gmail.com>
 <20190716175021.9CA412173C@mail.kernel.org> <CAFd5g453vXeSUCZenCk_CzJ-8a1ym9RaPo0NVF=FujF9ac-5Ag@mail.gmail.com>
 <20190718175024.C3EC421019@mail.kernel.org>
In-Reply-To: <20190718175024.C3EC421019@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jul 2019 12:22:33 -0700
Message-ID: <CAFd5g46a7C1+R6ZcE_SkqaYqgrH5Rx3M=X7orFyaMgFLDbeYYA@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like logger
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-16 11:52:01)
> > On Tue, Jul 16, 2019 at 10:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> >
> > > The only hypothetical case where this can't be done is a complicated
> > > assertion or expectation that does more than one check and can't be
> > > written as a function that dumps out what went wrong. Is this a real
> > > problem? Maybe such an assertion should just open code that logic so we
> > > don't have to build up a string for all the other simple cases.
> >
> > I have some expectations in follow up patchsets for which I created a
> > set of composable matchers for matching structures and function calls
> > that by their nature cannot be written as a single function. The
> > matcher thing is a bit speculative, I know, but for any kind of
> > function call matching, you need to store a record of functions you
> > are expecting to have called and then each one needs to have a set of
> > expectations defined by the user; I don't think there is a way to do
> > that that doesn't involve having multiple separate functions each
> > having some information useful to constructing the message.
> >
> > I know the code in question isn't in this patchset; the function
> > matching code was in one of the earlier versions of the RFC, but I
> > dropped it to make this patchset smaller and more manageable. So I get
> > it if you would like me to drop it and add it back in when I try to
> > get the function and structure matching stuff in, but I would really
> > prefer to keep it as is if you don't care too much.
>
> Do you have a link to those earlier patches?

This is the first patchset:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788057.html

In particular you can see the code for matching functions here:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788073.html

And parameter matching code here:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788072.html

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1788086.html

My apologies in advance, but the code at this early stage had not
adopted the kunit_* prefix and was still using the test_* and mock_*
prefix. (Hence, struct kunit_stream was known as struct test_stream).

> > > It seems far simpler to get rid of the string stream API and just have a
> > > struct for this.
> > >
> > >         struct kunit_fail_msg {
> > >                 const char *line;
> > >                 const char *file;
> > >                 const char *func;
> > >                 const char *msg;
> > >         };
> > >
> > > Then you can have the assertion macros create this on the stack (with
> > > another macro?).
> > >
> > >         #define DEFINE_KUNIT_FAIL_MSG(name, _msg) \
> > >                 struct kunit_fail_msg name = { \
> > >                         .line =  __LINE__, \
> > >                         .file = __FILE__, \
> > >                         .func = __func__, \
> > >                         .msg = _msg, \
> > >                 }
> > >
> > > I don't want to derail this whole series on this topic, but it seems
> > > like a bunch of code is there to construct this same set of information
> > > over and over again into a buffer a little bit at a time and then throw
> > > it away when nothing fails just because we may want to support the case
> > > where we have some unstructured data to inform the user about.
> >
> > Yeah, that's fair. I think there are a number of improvements to be
> > made with how the expectations are defined other than that, but I was
> > hoping I could do that after this patchset is merged. I just figured
> > with the kinds of things I would like to do, it would lead to a whole
> > new round of discussion.
> >
> > In either case, I think I would still like to use the `struct
> > kunit_stream` as part of the interface to share the failure message
> > with the test case runner code in test.c, at least eventually, so that
> > I only have to have one way to receive data from expectations, but I
> > think I can do that and still do what you suggest by just constructing
> > the kunit_stream at the end of expectations where it is feasible.
> >
> > All in all I agree with what you are saying, but I would rather do it
> > as a follow up possibly once we have some more code on the table. I
> > could just see this opening up a whole new can of worms where we
> > debate about exactly how expectations and assertions work for another
> > several months, only to rip it all out shortly there after. I know
> > that's how these things go, but that's my preference.
> >
> > I can do what you suggest if you feel strongly about it, but I would
> > prefer to hold off until later. It's your call.
> >
>
> The crux of my complaint is that the string stream API is too loosely
> defined to be usable. It allows tests to build up a string of
> unstructured information, but with certain calling constraints so we
> have to tread carefully. If there was more structure to the data that's
> being recorded then the test case runner could operate on the data
> without having to do string/stream operations, allocations, etc. This
> would make the assertion logic much more concrete and specific to kunit,
> instead of this small kunit wrapper that's been placed on top of string
> stream.

Yeah, I can see the point of wanting something that provides more
structure than the raw `struct kunit_stream` interface. In fact, it is
something I had already started working on, when I had determined it
would be a large effort to capture all the variations. I was further
put off from the idea when I had been asked to convert the KUnit
intermediate format from what I was using to TAP, because, as it is,
the current data printed out by KUnit doesn't contain all the data I
would like to put in it in a way that best takes advantage of the TAP
specification. One problematic area in particular: TAP already
provides a way to present a lot of the data I would like to export,
but it involves JSON serialization which was an idea that some of the
other reviewers understandably weren't too keen on. TAP also wants to
report data some time after it is available, which is generally not a
good idea for test debug information; you want to make it available as
soon as you can or you risk crashing with the data still inside.

Hence, I decided we could probably spend a good long while debating
how I present the information. So the idea of having a loose
definition seemed attractive to me in its own right since it would
likely conform to whatever we ended up deciding in the long run. Also,
all the better that it was what I already had and no one seemed to
mind too much.

The only constant I expect is that `struct kunit` will likely need to
take an abstract object with a `commit` method, or a `format` method
or whatever so it could control when data was going to be printed out
to the user. We will probably also use a string builder in there
somewhere.

> TL;DR: If we can get rid of the string stream API I'd view that as an
> improvement because building arbitrary strings in the kernel is complex,
> error prone and has calling context concerns.

True. No argument there.

> Is the intention that other code besides unit tests will use this string
> stream API to build up strings? Any targets in mind? This would be a
> good way to get the API merged upstream given that its 2019 and we
> haven't had such an API in the kernel so far.

Someone, (was it you?) asked about code sharing with a string builder
thingy that was used for creating structured human readable files, but
that seemed like a pretty massive undertaking.

Aside from that, no. I would kind of prefered that nobody used it for
anything else because I the issues you described.

Nevertheless, I think the debate over the usefulness of the
string_stream and kunit_stream are separate topics. Even if we made
kunit_stream more structured, I am pretty sure I would want to use
string_stream or some variation for constructing the message.

> An "object oriented" (strong quotes!) approach where kunit_fail_msg is
> the innermost struct in some assertion specific structure might work
> nicely and allow the test runner to call a generic 'format' function to
> print out the message based on the type of assertion/expectation it is.
> It probably would mean less code size too because the strings that are
> common will be in the common printing function instead of created twice,
> in the macros/code and then copied to the heap for the string stream.
>
>         struct kunit_assert {
>                 const char *line;
>                 const char *file;
>                 const char *func;
>                 void (*format)(struct kunit_assert *assert);
>         };
>
>         struct kunit_comparison_assert {
>                 enum operator operator;
>                 const char *left;
>                 const char *right;
>                 struct kunit_assert assert;
>         };
>
>         struct kunit_bool_assert {
>                 const char *truth;
>                 const char *statement;
>                 struct kunit_assert assert;
>         };
>
>         void kunit_format_comparison(struct kunit_assert *assert)
>         {
>                 struct kunit_comparison_assert *comp = container_of(assert, ...)
>
>                 kunit_printk(...)
>         }

I started working on something similarish, but by the time I ended up
coming up with a parent object whose definition was loose enough to
satisfy all the properties required by the child classes it ended up
basically being the same as what I have now just with a more complex
hierarchy of message manipulation logic.

On the other hand, I didn't have the idea of doing the parent object
quite the way you did and that would clean up a lot of the duplicated
first line logic.

I would like to give it a try, but I am afraid I am going to get
sucked down a really deep rabbit hole.

> Maybe other people have opinions here on if you should do it now or
> later. Future coding is not a great argument because it's hard to
> predict the future. On the other hand, this patchset is in good shape to

Yeah, that's kind of why I am afraid to go down this road when I have
something that works now and I know works with the mocking stuff I
want to do.

I would like to try your suggestion, but I want to try to make it work
with my mocking patches before I commit to it because otherwise I am
just going to have to back it out in a follow up patchset.

> merge and I'd like to use it to write unit tests for code I maintain so
> I don't want to see this stall out. Sorry if I'm opening the can of
> worms you're talking about.

Don't be sorry. I agree with you that the kunit_stream stuff is not very pretty.

Shuah, have we missed the merge window for 5.3?

I saw you only sent one PR out so far for this release, and there
wasn't much in it; I imagine you are going to send at least one more?

I figure, if we still got time to try out your suggestion, Stephen, no
harm in trying.

Also if we missed it, then I have another couple months to play around with it.

What do you think?
