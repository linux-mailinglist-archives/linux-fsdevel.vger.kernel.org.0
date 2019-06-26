Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91997574A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfFZXAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 19:00:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35447 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFZXAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:00:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so157974plp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=turlNrZcH8tuujf37Q7HEe8hyhwhiMkMAGSNncSmJd0=;
        b=tPbLhI6p7V77PIMP2Ixa9TxEo7roY6MVHPMR6jgk7ZuALrFWvqeemx+Wplsc+xCraa
         pdqaYu92o/6BUX2InP+i1EHq6YxT7QAYYWFgD1MBvytI5KSVDogEPNSSYbdTqT2lCSQ0
         Fn3GAaSQ9CIrxWUpqqCpg+X3DttzdAEUoMp1XrupALh+W8vxcCBtUuzpQXYzG6c3iMf7
         UhPmfILyu8sJnTsr66nAy/yDGC9ePdyx7iIS/nUONAHd9nJ8GTtoBAj4b7HYxRUEhl1e
         BHevIfb/hk6Fobzekl76hHs0k5V4Gu3QLYcO3BnbTSkfvMzcisvJPBxENYWRxYw+rWCH
         v0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=turlNrZcH8tuujf37Q7HEe8hyhwhiMkMAGSNncSmJd0=;
        b=cIeHM+Hw0ZFfwBAOEXYjo/OVNU1Xean55PbKCyEx/CYeCW4+6XfPrVdvbSSU/+humh
         N/0gx1XPGR603wpSUVcmlo4gf1bwM/Rj1IiE7kY1KGTpWqC/n8JM3jIhJKlUam4q3T2L
         4zfVV2tKDLckxAEjinuYi3nuMaY3dgWvTgFLJHgwfYrOHAdmfuGd9E82X0jjOHsvrL65
         0ogrGuDGr4Nk4xOIzcim0Ptw5SJXLrVVNTRqhpcXex8/bRqYC/etgzMTaQLfjZh8HNiB
         IqvVZXo8AKimWogSSe9KhFfBPr2e5NeAEIN0wXFj2/qEnd61ENgNiodrqZC8R3YNCoSi
         0rLQ==
X-Gm-Message-State: APjAAAXnmWOdumTdN3u3FZgfZPlV+aWsXaG8Yh1QhpBhLfcDcLn2j0qU
        kuG1sKAjF4D58eQDn13VrWn0F0g65/GNFCJWUpoH8g==
X-Google-Smtp-Source: APXvYqyVbS9SuPoqv6WFyOjCnMYrySBcHNuv6jq0PUoe5f5yqgIDv1bI73Ejus2aEdQ4kXu4W/T/wMpAMZdGpDkQTLk=
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr669016pla.232.1561590052378;
 Wed, 26 Jun 2019 16:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com> <20190626034100.B238520883@mail.kernel.org>
In-Reply-To: <20190626034100.B238520883@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 16:00:40 -0700
Message-ID: <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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

On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-25 13:28:25)
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
>
> No, I think the locking should be removed.
>
> >
> > > In what situation is there more than one thread reading or writing the
> > > kunit struct? Isn't it only a single process that is going to be
> >
> > As I said above, it is possible that the code under test may spawn a
> > new thread that may make an expectation or an assertion. It is not a
> > super common use case, but it is possible.
>
> Sure, sounds super possible and OK.
>
> >
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
> Can you please describe the scenario in which grabbing the lock here,
> updating a single variable, and then releasing the lock right after
> does anything useful vs. not having the lock? I'm looking for a two CPU

Sure.

> scenario like below, but where it is a problem. There could be three
> CPUs, or even one CPU and three threads if you want to describe the
> extra thread scenario.
>
> Here's my scenario where it isn't needed:
>
>     CPU0                                      CPU1
>     ----                                      ----
>     kunit_run_test(&test)
>                                               test_case_func()
>                                                 ....
>                                               [mock hardirq]
>                                                 kunit_set_success(&test)
>                                               [hardirq ends]
>                                                 ...
>                                                 complete(&test_done)
>       wait_for_completion(&test_done)
>       kunit_get_success(&test)
>
> We don't need to care about having locking here because success or
> failure only happens in one place and it's synchronized with the
> completion.

Here is the scenario I am concerned about:

CPU0                      CPU1                       CPU2
----                      ----                       ----
kunit_run_test(&test)
                          test_case_func()
                            ....
                            schedule_work(foo_func)
                          [mock hardirq]             foo_func()
                            ...                        ...
                            kunit_set_success(false)   kunit_set_success(false)
                          [hardirq ends]               ...
                            ...
                            complete(&test_done)
  wait_for_completion(...)
  kunit_get_success(&test)

In my scenario, since both CPU1 and CPU2 update the success status of
the test simultaneously, even though they are setting it to the same
value. If my understanding is correct, this could result in a
write-tear on some architectures in some circumstances. I suppose we
could just make it an atomic boolean, but I figured locking is also
fine, and generally preferred.

Also, to be clear, I am onboard with dropping then IRQ stuff for now.
I am fine moving to a mutex for the time being.

>
> >
> > > > +
> > > > +       return success;
> > > > +}
> > > > +
> > > > +static void kunit_set_success(struct kunit *test, bool success)
> > > > +{
> > > > +       unsigned long flags;
> > > > +
> > > > +       spin_lock_irqsave(&test->lock, flags);
> > > > +       test->success = success;
> > > > +       spin_unlock_irqrestore(&test->lock, flags);
> > > > +}
