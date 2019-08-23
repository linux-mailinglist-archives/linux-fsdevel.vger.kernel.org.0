Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2639B4DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391675AbfHWQsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 12:48:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35418 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391510AbfHWQsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:48:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn20so5875319plb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shB6SKOCWrivD7S412WveV0DXQGCOHDXUApJqsM/wlA=;
        b=Ompr7qYsU3e4pxkTUvcGDfd4ML8vgFjnLheqC9j82bJxX2WMtGNPBrUA1tpfZZ7kkl
         2MlcYLnijPbPInvIsR6zoBG80ArVaqo/qH8Nz2C1fLluKeQqMKpdn1Isx73kDPRrmtfA
         uzlQbv8SAmt8wmBgLzDRa1pCbkLXVUC7pw3IzF7X6tCUWtvjtpbvC0Rxd012AHX4+phE
         8vFfpItPxvkt5HF2AluYoxPT8xW+p0eqWdqhZxhn3iXjphBqdQMERaOSG3vodu0lrJ5X
         dliaDAtQHPNKh2+Qm2AedTz/hBlaONpPrX2iSmH0iODNpBCdBlLEBbRkV7kNpmjj1hL+
         ogpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shB6SKOCWrivD7S412WveV0DXQGCOHDXUApJqsM/wlA=;
        b=KlXUh7xtIDNHjHQwJ+nJCcmkqeowL4jvIXwyTJI5+DSEJXS9Cs6W+W/gHS6PwV9Tig
         SofkXxQO0RmZtUugxtl5Y/N/VeOtthW1FnQprSqD4CKx3YFQ0Y7He9qMdGUGxEUVoK2+
         lSZZGa01J+ba+I2pL/1I2ss/NaCPGJ+dHyuj3kgMkgDrrZMhJTcuRx2YO7Aw3wrkmtBT
         2FpDTgviv+OABIOS5LgouFW0kANIDoM0xDAkYNGrl7tvCmXPU+9un0dLsFt1QN4zlDgs
         AT9GlAiqRtQtZmgEsAmfebn4RdWNqFrKOfBNIPy/+7BGa8M9Hq1hx/3zuMkGI9sx/1+Q
         ADOQ==
X-Gm-Message-State: APjAAAXypYklfAVsKdIAFJ7hU3Ci3p74lZGuFGga0+oD7Th2mq0U53vN
        pJp7XIgTZZ8IPGGwBPHWtpS6V4nMV2VKIQAe+qJRgg==
X-Google-Smtp-Source: APXvYqyVqeK74/JWJUZ7pW5UAwhfOe02PTG6GeE5ufM2yWENnaiC/3vIkdv/0Gau1b+w32MpN7Tbr1pv4cTuRxiXwSc=
X-Received: by 2002:a17:902:169:: with SMTP id 96mr5617305plb.297.1566578900191;
 Fri, 23 Aug 2019 09:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com> <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
In-Reply-To: <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Aug 2019 09:48:08 -0700
Message-ID: <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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

On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
>
> Hi Brendan,
>
> On 8/20/19 5:20 PM, Brendan Higgins wrote:
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >   include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
> >   kunit/Kconfig        |  17 ++++
> >   kunit/Makefile       |   1 +
> >   kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 388 insertions(+)
> >   create mode 100644 include/kunit/test.h
> >   create mode 100644 kunit/Kconfig
> >   create mode 100644 kunit/Makefile
> >   create mode 100644 kunit/test.c
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > new file mode 100644
> > index 0000000000000..e0b34acb9ee4e
> > --- /dev/null
> > +++ b/include/kunit/test.h
> > @@ -0,0 +1,179 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TEST_H
> > +#define _KUNIT_TEST_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct kunit;
> > +
> > +/**
> > + * struct kunit_case - represents an individual test case.
> > + * @run_case: the function representing the actual test case.
> > + * @name: the name of the test case.
> > + *
> > + * A test case is a function with the signature, ``void (*)(struct kunit *)``
> > + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
> > + * test case is associated with a &struct kunit_suite and will be run after the
> > + * suite's init function and followed by the suite's exit function.
> > + *
> > + * A test case should be static and should only be created with the KUNIT_CASE()
> > + * macro; additionally, every array of test cases should be terminated with an
> > + * empty test case.
> > + *
> > + * Example:
>
> Can you fix these line continuations. It makes it very hard to read.
> Sorry for this late comment. These comments lines are longer than 80
> and wrap.

None of the lines in this commit are over 80 characters in column
width. Some are exactly 80 characters (like above).

My guess is that you are seeing the diff added text (+ ), which when
you add that to a line which is exactly 80 char in length ends up
being over 80 char in email. If you apply the patch you will see that
they are only 80 chars.

>
> There are several comment lines in the file that are way too long.

Note that checkpatch also does not complain about any over 80 char
lines in this file.

Sorry if I am misunderstanding what you are trying to tell me. Please
confirm either way.

Thanks
