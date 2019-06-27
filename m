Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323E657536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF0AF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 20:05:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF0AF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:05:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id y72so125535pgd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKZ1R9QgEMrkGcZ9YLvKRKzkpMRTcKXcwCOxP+teR7M=;
        b=L8/gCEeRIbIoy4dFbDu3aEhSPRF7rPfAvmRCx3ItHECNXHr8HCgKjM5mXTC9wUyNb+
         nrwS1zeX/UJfOPKYmEwGKVHcruUS1znp6TN5vQdfI6b+Y9H9BFcsfEseAINmMZxhStlc
         TWZydfC6tN4zj88A97CBxhrzFDd0ti0kMTr/cu0YxAbGMXlEHBEdlOAi6SMiewszVXs4
         tjHCgRLCojzI+WbS+S1y0aA/Xq96zu61RfJ8CIwkL7VdAC9ftOckX4/U6suQeLl1pxPk
         S14J2HjbLRLV7EnZm9hwujt2kW8WGbocpgogTslAlxCeXfFnyXJuzl1ibcVD4NJR7iWw
         Fh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKZ1R9QgEMrkGcZ9YLvKRKzkpMRTcKXcwCOxP+teR7M=;
        b=WQT+7o74i1ROOfkESVHGnmIyAPt22VYB4CF7pb6o/L7DhCpa/2+6R0itfolbbG1EBM
         iIUsVJHuuHGAziLmZw6I5NfLGRS30L2EkR9js7RKdzL/MPLSCKfGO3qRxHwc/H9Omoom
         odDuyjw7AV1Hrmv6iKsMYSuA592XZxjtD5dmdtfNK4Z/siwiGFPbAVMR+423UQSwKdQI
         gMh0wGeQHQnuceBSFFVKU/ck6VSebUZrBfk8PjMFuQEe+Fn0aGSbBdbtQ/akplzBSN86
         S82rFBhuzMI1PF2XLFgx0PG5VD1ASk2wkWGTtnKIL72+CnBh2kuyhoUkPJXcw9y05prD
         gRFg==
X-Gm-Message-State: APjAAAXdTCxUjTsn0BtAPvDslzGEfoZlud8eEpnTtiwYPa5AklUZUEh/
        BMdiSn2Z/WinwXMQpHIi84nmgEr3Ze0fD5fHCUltbw==
X-Google-Smtp-Source: APXvYqw0luNcANHXyMUiFoyyUu0AVErgnzQun0+KNERaAUHA3h78Phk03thaTOrgTG//zK4/DgIcpxo61LJZY0ft9FY=
X-Received: by 2002:a63:b919:: with SMTP id z25mr654931pge.201.1561593925659;
 Wed, 26 Jun 2019 17:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190625214427.GN19023@42.do-not-panic.com> <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
 <20190625230253.GQ19023@42.do-not-panic.com> <CAFd5g45fSdpytudDyD3Yo1ti=kU_JJ6S9yz53_L=pnZTjQFU9A@mail.gmail.com>
 <20190626220204.GZ19023@42.do-not-panic.com>
In-Reply-To: <20190626220204.GZ19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 17:05:13 -0700
Message-ID: <CAFd5g46yp3B6SB9OZRoum8-CDA-BW_En7BGz5WH8qFRx1d=8iA@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
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

On Wed, Jun 26, 2019 at 3:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 11:41:47PM -0700, Brendan Higgins wrote:
> > On Tue, Jun 25, 2019 at 4:02 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Tue, Jun 25, 2019 at 03:14:45PM -0700, Brendan Higgins wrote:
> > > > On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > > Since its a new architecture and since you seem to imply most tests
> > > > > don't require locking or even IRQs disabled, I think its worth to
> > > > > consider the impact of adding such extreme locking requirements for
> > > > > an initial ramp up.
> > > >
> > > > Fair enough, I can see the point of not wanting to use irq disabled
> > > > until we get someone complaining about it, but I think making it
> > > > thread safe is reasonable. It means there is one less thing to confuse
> > > > a KUnit user and the only penalty paid is some very minor performance.
> > >
> > > One reason I'm really excited about kunit is speed... so by all means I
> > > think we're at a good point to analyze performance optimizationsm if
> > > they do make sense.
> >
> > Yeah, but I think there are much lower hanging fruit than this (as you
> > point out below). I am all for making/keeping KUnit super fast, but I
> > also don't want to waste time with premature optimizations and I think
> > having thread safe expectations and non-thread safe expectations hurts
> > usability.
> >
> > Still, I am on board with making this a mutex instead of a spinlock for now.
> >
> > > While on the topic of parallization, what about support for running
> > > different test cases in parallel? Or at the very least different kunit
> > > modules in parallel.  Few questions come up based on this prospect:
> > >
> > >   * Why not support parallelism from the start?
> >
> > Just because it is more work and there isn't much to gain from it right now.
> >
> > Some numbers:
> > I currently have a collection of 86 test cases in the branch that this
> > patchset is from.
>
> Impressive, imagine 86 tests and kunit is not even *merged yet*.

Full disclaimer, about half of them are KUnit tests for KUnit - to
make sure KUnit works, so I don't know if you consider that cheating.

> > I turned on PRINTK_TIME and looked at the first
> > KUnit output and the last. On UML, start time was 0.090000, and end
> > time was 0.090000. Looks like sched_clock is not very good on UML.
>
> Since you have a python thing that kicks tests, what if you just run
> time on it?

That's what I did on the this following paragraph (I just couldn't
time the tests by themselves in this case):

> > Still it seems quite likely that all of these tests run around 0.01
> > seconds or less on UML: I ran KUnit with only 2 test cases enabled
> > three times and got an average runtime of 1.55867 seconds with a
> > standard deviation of 0.0346747. I then ran it another three times
> > with all test cases enabled and got an average runtime of 1.535
> > seconds with a standard deviation of 0.0150997. The second average is
> > less, but that doesn't really mean anything because it is well within
> > one standard deviation with a very small sample size. Nevertheless, we
> > can conclude that the actual runtime of those 84 test cases is most
> > likely within one standard deviation, so on the order of 0.01 seconds.
> >
> > On x86 running on QEMU, first message from KUnit was printed at
> > 0.194251 and the last KUnit message was printed at 0.340915, meaning
> > that all 86 test cases ran in about 0.146664 seconds.
>
> Pretty impressive numbers. But can you blame me for expressing the
> desire to possibly being able to do better? I am not saying -- let's
> definitely have parallelism in place *now*. Just wanted to hear out
> tangibles of why we *don't* want it now.

I agree, faster is almost always better in these types of things, and
certainly is in this case.

In fairness to you, I also short sold the speed of KUnit in the cover
letter. I was too lazy to do this complete of an analysis back when I
wrote it (even if I did a complete timing like this, I would have to
put a bunch of asterisks since it wouldn't include the time to "boot"
the kernel or to build it, which vastly outstrip the speed of
individual test cases). And given the original numbers, I think
speeding things up would probably seem more urgent. So no, I really
cannot blame you.

Sorry if it came across that I was frustrated or impatient, but I am
actually glad you asked because I now have this public email where I
did the full analysis of how fast KUnit really is which I can refer to
in the future.

> And.. also, since we are reviewing now, try to target so that the code
> can later likely get a face lift to support parallelism without
> requiring much changes.

Also fair.

> > In any case, running KUnit tests in parallel is definitely something I
> > plan on adding it eventually, but it just doesn't really seem worth it
> > right now.
>
> Makes sense!
>
> > I find the incremental build time of the kernel to
> > typically be between 3 and 30 seconds, and a clean build to be between
> > 30 seconds to several minutes, depending on the number of available
> > cores, so I don't think most users would even notice the amount of
> > runtime contributed by the actual unit tests until we start getting
> > into the 1000s of test cases. I don't suspect it will become an issue
> > until we get into the 10,000s of test cases. I think we are a pretty
> > long way off from that.
>
> All makes sense, and agreed based on the numbers you are providing.
> Thanks for the details!
>
> > >   * Are you opposed to eventually having this added? For instance, there is
> > >     enough code on lib/test_kmod.c for batching tons of kthreads each
> > >     one running its own thing for testing purposes which could be used
> > >     as template.
> >
> > I am not opposed to adding it eventually at all. I actually plan on
> > doing so, just not in this patchset. There are a lot of additional
> > features, improvements, and sugar that I really want to add, so much
> > so that most of it doesn't belong in this patchset; I just think this
> > is one of those things that belongs in a follow up. I tried to boil
> > down this patchset to as small as I could while still being useful;
> > this is basically an MVP. Maybe after this patchset gets merged I
> > should post a list of things I have ready for review, or would like to
> > work on, and people can comment on what things they want to see next.
>
> Groovy.

Cool, I will do that then!

> > >   * If we eventually *did* support it:
> > >     - Would logs be skewed?
> >
> > Probably, before I went with the TAP approach, I was tagging each
> > message with the test case it came from and I could have parsed it and
> > assembled a coherent view of the logs using that; now that I am using
> > TAP conforming output, that won't work. I haven't really thought too
> > hard about how to address it, but there are ways. For the UML users, I
> > am planning on adding a feature to guarantee hermeticity between tests
> > running in different modules by adding a feature that allows a single
> > kernel to be built with all tests included, and then determine which
> > tests get run by passing in command line arguments or something. This
> > way you can get the isolation from running tests in separate
> > environments without increasing the build cost. We could also use this
> > method to achieve parallelism by dispatching multiple kernels at once.
>
> Indeed. Or... wait for it... containers... There tools for these sorts
> of things already. And I'm evaluating such prospects now for some other
> tests I care for.

Containers could definitely be useful in the long run. I have a long
term goal to build and run just parts of the kernel as I have
mentioned to you, and doing so in a totally hermetic environment could
provide a lot of value; in this case I would probably only want a
chroot, but if I want to deploy tests to run on different machines
containers could be very useful.

Actually, on the topic of containers for running tests, the presubmit
system I have set up for KUnit uses containers for deploying KUnit on
servers for testing[1]. Actually, I have some experimental patches to
make it work with LKML instead of Gerrit, but I am not sure whether it
makes more sense to go that route, with one of the many patchworks
clones that support presubmit, or something else.

> > That only works for UML, but I imagine you could do something similar
> > for users running tests under qemu.
>
> Or containers.
>
> > >     - Could we have a way to query: give me log for only kunit module
> > >       named "foo"?
> >
> > Yeah, I think that would make sense as part of the hermeticity thing I
> > mentioned above.
> >
> > Hope that seems reasonable!
>
> All groovy. Thanks for the details!

[1] https://kunit-review.googlesource.com/c/linux/+/1809/2#message-c243e1c9086d9432d2dcabc67a42a977b8a020ff
