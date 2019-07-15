Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE969E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfGOVZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 17:25:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33588 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfGOVZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:25:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so8029191pfq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1iVnKb9KyH2VdRaa+1X1AxuS2MqitxfIlVlkn/kOv8=;
        b=OKadg9adfR8FnEoQT6HdGl96SBZxASHai1a3d6JJ7kS2KeuZ1gp/Sww0dZ4FNnRfmX
         dsWE9zqYktoShjIU+eYZsCRcFIJfFws6QoK2qlbR+qOq4rr/hOZP2M3LcnN2q482/I73
         uk9eNSjzCb/KkfhP4BJ2nmSyKV5xwGPcSeH7IrIsnT+SSVepNWQYB1x9JIyW2ECp5yWy
         v4jcSyoBZJSrmeWQFBgJn1mNjyDuuQcjVCEz7vy2pTS+5CwXEpnaX+c+7wd+NdqiTuWs
         jLfiDc8e4oMqUtNtGi1qAx20ReiWP9Qgxngtq/5EbA2D41xPwKDuHWOLS0EUq/G9lFRU
         uKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1iVnKb9KyH2VdRaa+1X1AxuS2MqitxfIlVlkn/kOv8=;
        b=g2zEzfxe24VuNvhBufT0ThYtVgM4BlS6XQ4X3Rr4Y7Cs2CAnVx/hZLKXChq9o0zRA3
         5mVGkAS1D955afeAukUtn1/chQEhIu0eDTFPs45yTQtDUrEbyiQdRDvKqyrhx5lRM5Y1
         2eyup8HSnmP+JFqE7WLgfqx/FbQFtZctgNxOvy6dNX6F8+aOSRx86aYzpBTc9nVP6KUZ
         5BCo8MQwuHxUxzibNTYBqdgpRAWKKtGUSTLI69PiOlLSH9rPvkH9270r52wNbasIIyQj
         0iL8qUhX8lJD5A2IL6u8PXK6S/+SCwX3ulIXs35x3cDhAakSm3oyQovBeiu72ixxV8Vu
         FQ1Q==
X-Gm-Message-State: APjAAAWb7uhWWEHZjoXXwyCSAe+0YsASiFOiqZFgdXcukk+MZapYAzZk
        i6l5XlIDeZ4ZzvCYllyI+KnCAdsOofnAZqD1MGYPLg==
X-Google-Smtp-Source: APXvYqxYpwH7M9Tn69WNYt23pvYEmwOFSLt2yT+zRsvwVW6B093wD7DIpVEsyGIo3whwBHoCVELofo1GZGIk7QmjTys=
X-Received: by 2002:a63:205f:: with SMTP id r31mr29138784pgm.159.1563225956600;
 Mon, 15 Jul 2019 14:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-2-brendanhiggins@google.com> <20190715201054.C69AA2086C@mail.kernel.org>
In-Reply-To: <20190715201054.C69AA2086C@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 14:25:45 -0700
Message-ID: <CAFd5g44kWHYceo85qxL98JKH2FYBwVLFuLzqNR+APpMC1aKWUQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/18] kunit: test: add KUnit test runner core
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

On Mon, Jul 15, 2019 at 1:10 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:27)
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
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> Minor nits below.
>
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..571e4c65deb5c
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <kunit/test.h>
> > +
> > +static void kunit_set_failure(struct kunit *test)
> > +{
> > +       WRITE_ONCE(test->success, false);
> > +}
> > +
> [...]
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       test->name = name;
> > +       test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_suite *suite,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +       int ret = 0;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +
> > +       if (suite->init) {
> > +               ret = suite->init(&test);
>
> Can you push the ret definition into this if scope? That way we can
> avoid default initialize to 0 for it.

Sure! I would actually prefer that from a cosmetic standpoint. I just
thought that mixing declarations and code was against the style guide.

> > +               if (ret) {
> > +                       kunit_err(&test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_failure(&test);
>
> Do we need to 'test_case->success = test.success' here too? Or is the
> test failure extracted somewhere else?

Er, yes. That's kind of embarrassing. Good catch.

> > +                       return;
> > +               }
> > +       }
> > +
> > +       test_case->run_case(&test);
> > +
> > +       if (suite->exit)
> > +               suite->exit(&test);
> > +
> > +       test_case->success = test.success;

Thanks!
