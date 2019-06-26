Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8D55CD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 02:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZAHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 20:07:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZAHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:07:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so241218pgc.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CKSZbZdZTCXDsFevmx6xy0jVDdxhx+j1rEEB3vl63s=;
        b=Udp0DSI1eicbAQ93CL5kbvi8Xp/6zCCrOWD+4my5+Z2KobfpntEZptXwNDN+m1HYdl
         aWzrSvRzjBSRt+1Ke5gfgolTpuldTSDWCwjjFSm2u0fallCYK2AWnGnpndlL89sFN0Zl
         GTwNluZIxE+q2xxZzY/SPhBF2gsVikHJ199bU9KJdjOqqrHUctG5Or1EMQYsJztcsOoC
         DiYGphxIA91H14nI8J5aNbvthpK6V9fOCpd2OHMJOcinqK81dIeXjiZaAKjLmKAP2Jwx
         0nEa6ArcVSNjpUjZHNws6GQlmspmdwUJ/ZxXDeWnV3qF6zllsbtRDaXwGrbAJh9mZIai
         k2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CKSZbZdZTCXDsFevmx6xy0jVDdxhx+j1rEEB3vl63s=;
        b=tn1X1OlaiOkqKmDjxyJOcmBx8bh/f0V0o9FJ7rrvtDqoBMSoMVG5VYvnXiiPTGzQ6e
         Wzj6p8P5Q8pHD6s21czh47O+L1LuCkqIDLvveygCitSZ/l6vo4mXBzMs4AYMjEYMHn8D
         fDk0K2+Y/BrthAGWh3ayepfFbSEp1LljyZga3Ybjoy8Sl+c160H3e0HG8DkO2TXuGCN8
         b3kvBG7QVJF9xbIStTd/Rs+rEmqJ1MRENpm19hG+sWw8O60WnT7m1v477yVWQRvlzFa5
         hVk+isdUa7uDoLqItsTcFemG9dQibtbdpW0fqFRswf+zmZQwMODHFdvp3lguaHdEbfIS
         7QTw==
X-Gm-Message-State: APjAAAWSa2ydN5L7JFmlN3hKj1lxPUv+eZxV/6i7m6cI9V84wdEchnZn
        eADHgK59rLlDON5kZnJ01c2XFv98snvDTA8QedYl4A==
X-Google-Smtp-Source: APXvYqwFUlf+fXcTuEW4suwRhf8sO2Hw8q7BLLIj3tSrVcwKVl/cK8K/AXXabwkRnwCip/wX7DtGYsxR83H1S/Y9Z64=
X-Received: by 2002:a17:90a:be0d:: with SMTP id a13mr657604pjs.84.1561507663974;
 Tue, 25 Jun 2019 17:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190625223312.GP19023@42.do-not-panic.com>
In-Reply-To: <20190625223312.GP19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Jun 2019 17:07:32 -0700
Message-ID: <CAFd5g46TLAONgXiZkFM98BPd-sariMTwhmYG9hSJ+M9=r-ixeg@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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

On Tue, Jun 25, 2019 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> > +/**
> > + * module_test() - used to register a &struct kunit_module with KUnit.
> > + * @module: a statically allocated &struct kunit_module.
> > + *
> > + * Registers @module with the test framework. See &struct kunit_module for more
> > + * information.
> > + */
> > +#define module_test(module) \
> > +             static int module_kunit_init##module(void) \
> > +             { \
> > +                     return kunit_run_tests(&module); \
> > +             } \
> > +             late_initcall(module_kunit_init##module)
>
> Becuase late_initcall() is used, if these modules are built-in, this
> would preclude the ability to test things prior to this part of the
> kernel under UML or whatever architecture runs the tests. So, this
> limits the scope of testing. Small detail but the scope whould be
> documented.

You aren't the first person to complain about this (and I am not sure
it is the first time you have complained about it). Anyway, I have
some follow on patches that will improve the late_initcall thing, and
people seemed okay with discussing the follow on patches as part of a
subsequent patchset after this gets merged.

I will nevertheless document the restriction until then.

> > +static void kunit_print_tap_version(void)
> > +{
> > +     if (!kunit_has_printed_tap_version) {
> > +             kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
>
> What is this TAP thing? Why should we care what version it is on?
> Why are we printing this?

It's part of the TAP specification[1]. Greg and Frank asked me to make
the intermediate format conform to TAP. Seems like something else I
should probable document...

> > +             kunit_has_printed_tap_version = true;
> > +     }
> > +}
> > +
> > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > +{
> > +     struct kunit_case *test_case;
> > +     size_t len = 0;
> > +
> > +     for (test_case = test_cases; test_case->run_case; test_case++)
>
> If we make the last test case NULL, we'd just check for test_case here,
> and save ourselves an extra few bytes per test module. Any reason why
> the last test case cannot be NULL?

Is there anyway to make that work with a statically defined array?

Basically, I want to be able to do something like:

static struct kunit_case example_test_cases[] = {
        KUNIT_CASE(example_simple_test),
        KUNIT_CASE(example_mock_test),
        {}
};

FYI,
#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }

In order to do what you are proposing, I think I need an array of
pointers to test cases, which is not ideal.

> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +     spin_lock_init(&test->lock);
> > +     test->name = name;
> > +     test->success = true;
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                        struct kunit_case *test_case)
> > +{
> > +     struct kunit test;
> > +     int ret = 0;
> > +
> > +     kunit_init_test(&test, test_case->name);
> > +
> > +     if (module->init) {
> > +             ret = module->init(&test);
>
> I believe if we used struct kunit_module *kmodule it would be much
> clearer who's init this is.

That's reasonable. I will fix in next revision.

Cheers!

[1] https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md
