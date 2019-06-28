Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8DE595C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 10:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfF1IJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 04:09:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37617 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfF1IJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:09:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so2585704pfa.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2019 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
        b=e5kLlPi61UOlg3aWbm3hyHJ6zEvPrbJg4WaMTgr5J7N6beCFHbvMVMWvXm34zFIMK6
         sy+TCthgNvl6QKdGAvF199JWgLSzY0riL7Qema9Z8eQSMrEVD7QmDgObmKA9VnGm6jQk
         Qk9Vw4tG1NS/Rsaor+MwqJJtzbW9NLCCg64qdKIwo/lqdLjqjD0HoEJZR2UkGwIQNQU7
         B8LVi8olEdiEG1gQQPAGB3QH7tntl/R65/A9R5rItsLpolqg+IRJEp1Du/WH5LqoOfL3
         I3l8I0kuDspWHSG/V5vI+q5UJh9nND3VlxUlk753w0GhWsuvm1nMSIm2VqKl1wq8mbGo
         9uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
        b=jSVVvys1LEyLmpDtOmjRmh+FYXijEc0RDXYVa4qSJfeAVENyK4O/aLirn2+KEkgYpa
         70VprtL/ebedL3pdxTIZbXu0fp1lljFdC/CFspvRNrq+PcF3N1sqGDHgCbWLJJVvSBD7
         hgU58NvCQiUAe+bCGMQtEY8QWdiBPQRyXy9CsxR8Drz3M6EebsGkC/kJtYqaXTwXbh1F
         Oj95PHpCBM9d+SxFGPZ360LxjBEIqzD1rF0xPqDOYP2oHailSYHuc1IyH6c3DTelxScW
         ZI0EtL+XCv0O091bDH8RPk8AXbtwdhI2u3p7AtcEsC770gO0SXuvR4XBImscd5/0zFSD
         1xUg==
X-Gm-Message-State: APjAAAVBoxkYljC15j8tPj8re+LwcsXSrYHS77ooqFkvcMwB3iFGs5GX
        8w5Xm5aFstykcYGbO2L1epHTYNDgGKFuw5ny3l74Kw==
X-Google-Smtp-Source: APXvYqwa5Gi43WdeQYYulM3cScojWTt0/MI+kDN9NbNdt1CeW4jxKTFR3Algm98Jmh+XvwAADJqdAi9a1c1dDVA05Ew=
X-Received: by 2002:a17:90a:be0d:: with SMTP id a13mr11033056pjs.84.1561709395368;
 Fri, 28 Jun 2019 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190626034100.B238520883@mail.kernel.org> <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
 <20190627181636.5EA752064A@mail.kernel.org>
In-Reply-To: <20190627181636.5EA752064A@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jun 2019 01:09:44 -0700
Message-ID: <CAFd5g44V3ZLNazUOgOo2sFR3zzbNnTkH4e9uxGX4iHi7G73Mzw@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 11:16 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-26 16:00:40)
> > On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > scenario like below, but where it is a problem. There could be three
> > > CPUs, or even one CPU and three threads if you want to describe the
> > > extra thread scenario.
> > >
> > > Here's my scenario where it isn't needed:
> > >
> > >     CPU0                                      CPU1
> > >     ----                                      ----
> > >     kunit_run_test(&test)
> > >                                               test_case_func()
> > >                                                 ....
> > >                                               [mock hardirq]
> > >                                                 kunit_set_success(&test)
> > >                                               [hardirq ends]
> > >                                                 ...
> > >                                                 complete(&test_done)
> > >       wait_for_completion(&test_done)
> > >       kunit_get_success(&test)
> > >
> > > We don't need to care about having locking here because success or
> > > failure only happens in one place and it's synchronized with the
> > > completion.
> >
> > Here is the scenario I am concerned about:
> >
> > CPU0                      CPU1                       CPU2
> > ----                      ----                       ----
> > kunit_run_test(&test)
> >                           test_case_func()
> >                             ....
> >                             schedule_work(foo_func)
> >                           [mock hardirq]             foo_func()
> >                             ...                        ...
> >                             kunit_set_success(false)   kunit_set_success(false)
> >                           [hardirq ends]               ...
> >                             ...
> >                             complete(&test_done)
> >   wait_for_completion(...)
> >   kunit_get_success(&test)
> >
> > In my scenario, since both CPU1 and CPU2 update the success status of
> > the test simultaneously, even though they are setting it to the same
> > value. If my understanding is correct, this could result in a
> > write-tear on some architectures in some circumstances. I suppose we
> > could just make it an atomic boolean, but I figured locking is also
> > fine, and generally preferred.
>
> This is what we have WRITE_ONCE() and READ_ONCE() for. Maybe you could
> just use that in the getter and setters and remove the lock if it isn't
> used for anything else.
>
> It may also be a good idea to have a kunit_fail_test() API that fails
> the test passed in with a WRITE_ONCE(false). Otherwise, the test is
> assumed successful and it isn't even possible for a test to change the
> state from failure to success due to a logical error because the API
> isn't available. Then we don't really need to have a generic
> kunit_set_success() function at all. We could have a kunit_test_failed()
> function too that replaces the kunit_get_success() function. That would
> read better in an if condition.

You know what, I think you are right.

Sorry, for not realizing this earlier, I think you mentioned something
along these lines a long time ago.

Thanks for your patience!

> >
> > Also, to be clear, I am onboard with dropping then IRQ stuff for now.
> > I am fine moving to a mutex for the time being.
> >
>
> Ok.

Thanks!
