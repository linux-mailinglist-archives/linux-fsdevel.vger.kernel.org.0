Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6016A55AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFYWO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 18:14:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45750 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:14:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so114583pfq.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T/u7V091HbAklhSEBy2pvLlCGAKMdVNlTSclQyRnpc=;
        b=ZoosysAkLc7RgErWxK5FnvM9RfcOs6mWm5WOqtPjUqxIqHpReyhsVFvslRzLoV3q6k
         miAcaLs/6/zELponnm9xpGa9FZgG6JHCtwbwwbsHrYPAVLPTXKnsAGZekzo/1E+v3r7q
         MAyz+XT8oIYL+RBKU6gcMfBPkx0i9G9kx5C+icFSHWtjKBEQssSIkQPmyDMJkhDb/APn
         rRRqx5pehUt6wHDwbMbahfsOf2X1S8Q3jv4bjOdkgKsJGdYPvje9VOWjIuTF7Q/SCVfF
         wDn/9hiMVLqSYlkj9TG58JxRLAwgxPn7xvEpgJy0gDIbJSP6wZCqkWFGLqYmeLIB06YQ
         qR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T/u7V091HbAklhSEBy2pvLlCGAKMdVNlTSclQyRnpc=;
        b=igeq5iUXgWc/o+eWXn5PCAmbDMK8piAC7fdJZxTh9wZgzUqVSD5YUu/SVxCM3Egx1e
         bgrSNZdaApj5h4h77QVjwuatf+rLNKa+ZFKHRfoIWL/KwbM2geHLYt8bqsXlBCC9HIhH
         KNECI/xiTfrbJtdVLK6HDzx9PCnleDh7oIKVOtV3SoSJMFcVeHwF4cteueR9P5PDY2d4
         EuXGQi1b/UO9GxcAHwyZoFJazhsoww3QGNioCigCB6FerFMUP+IcYXT4Vz3/1Oy0BOrs
         UjOco/HOyTHUXAaw23VRvEsaa16TNRunQAPco9UsGLJvZLmzSqavvbndob7D2FdK6Huf
         wY1w==
X-Gm-Message-State: APjAAAXmbBYYTIX5MQA3ZvSg9jrNdCckGg6M/EFIfbo4g4g4MYZirX+W
        3WBEnm9mmeqeTxQ0qQ+Gb+l4lJIHkVcGFwV75BKkzg==
X-Google-Smtp-Source: APXvYqzlEoDZX+cOnuipK7PjmAMWm3uFqbtUZEXyCZSNz1gEBa4cWncDmW9O+QuwSqz4K1dG1pGT/q+vccTvIeTjlVo=
X-Received: by 2002:a63:1459:: with SMTP id 25mr40704314pgu.201.1561500896729;
 Tue, 25 Jun 2019 15:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com> <20190625214427.GN19023@42.do-not-panic.com>
In-Reply-To: <20190625214427.GN19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Jun 2019 15:14:45 -0700
Message-ID: <CAFd5g47OABqN127cPKqoCOA_Wr9w=LFh_0XkF7LXu2iY9sFkSw@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 2:44 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 01:28:25PM -0700, Brendan Higgins wrote:
> > On Wed, Jun 19, 2019 at 5:15 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-06-17 01:25:56)
> > > > diff --git a/kunit/test.c b/kunit/test.c
> > > > new file mode 100644
> > > > index 0000000000000..d05d254f1521f
> > > > --- /dev/null
> > > > +++ b/kunit/test.c
> > > > @@ -0,0 +1,210 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Base unit test (KUnit) API.
> > > > + *
> > > > + * Copyright (C) 2019, Google LLC.
> > > > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > > > + */
> > > > +
> > > > +#include <linux/sched/debug.h>
> > > > +#include <kunit/test.h>
> > > > +
> > > > +static bool kunit_get_success(struct kunit *test)
> > > > +{
> > > > +       unsigned long flags;
> > > > +       bool success;
> > > > +
> > > > +       spin_lock_irqsave(&test->lock, flags);
> > > > +       success = test->success;
> > > > +       spin_unlock_irqrestore(&test->lock, flags);
> > >
> > > I still don't understand the locking scheme in this code. Is the
> > > intention to make getter and setter APIs that are "safe" by adding in a
> > > spinlock that is held around getting and setting various members in the
> > > kunit structure?
> >
> > Yes, your understanding is correct. It is possible for a user to write
> > a test such that certain elements may be updated in different threads;
> > this would most likely happen in the case where someone wants to make
> > an assertion or an expectation in a thread created by a piece of code
> > under test. Although this should generally be avoided, it is possible,
> > and there are occasionally good reasons to do so, so it is
> > functionality that we should support.
> >
> > Do you think I should add a comment to this effect?
> >
> > > In what situation is there more than one thread reading or writing the
> > > kunit struct? Isn't it only a single process that is going to be
> >
> > As I said above, it is possible that the code under test may spawn a
> > new thread that may make an expectation or an assertion. It is not a
> > super common use case, but it is possible.
>
> I wonder if it is worth to have then different types of tests based on
> locking requirements. One with no locking, since it seems you imply
> most tests would fall under this category, then locking, and another
> with IRQ context.
>
> If no locking is done at all for all tests which do not require locking,
> is there any gains at run time? I'm sure it might be minimum but
> curious.

Yeah, I don't think it is worth it.

I don't think we need to be squeezing every ounce of performance out
of unit tests, since they are inherently a cost and are not intended
to be run in a production deployed kernel as part of normal production
usage.

> > > operating on this structure? And why do we need to disable irqs? Are we
> > > expecting to be modifying the unit tests from irq contexts?
> >
> > There are instances where someone may want to test a driver which has
> > an interrupt handler in it. I actually have (not the greatest) example
> > here. Now in these cases, I expect someone to use a mock irqchip or
> > some other fake mechanism to trigger the interrupt handler and not
> > actual hardware; technically speaking in this case, it is not going to
> > be accessed from a "real" irq context; however, the code under test
> > should think that it is in an irq context; given that, I figured it is
> > best to just treat it as a real irq context. Does that make sense?
>
> Since its a new architecture and since you seem to imply most tests
> don't require locking or even IRQs disabled, I think its worth to
> consider the impact of adding such extreme locking requirements for
> an initial ramp up.

Fair enough, I can see the point of not wanting to use irq disabled
until we get someone complaining about it, but I think making it
thread safe is reasonable. It means there is one less thing to confuse
a KUnit user and the only penalty paid is some very minor performance.
