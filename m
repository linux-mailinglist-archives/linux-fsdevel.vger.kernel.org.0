Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D3146CD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFNXWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 19:22:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46284 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFNXWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:22:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so1574509pls.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2019 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UldVqdZ9D7hgJVdDeCXgBnGyHE7wD3aOYhsVNPjQpDw=;
        b=HHBH0YpOxZFV9lHpttKQ3HfN/1oER3nBUQGphZ90oXPdDn2KZbJ2MQ41X1Xc16GXe7
         FmIdhPNKlSBvDi4DZocJ7oWj+wCKAcAE7Tj/n6rwkGr4WvjvEjKWNN1ZQ7LPvvVssd49
         pC3H6lUCEueSArd8ZNEhFii+7+rgcthyxP7QVl6AGl/huF16b5b84U5+zU3R25tnRjnJ
         yz54Dy9ywc9HGpYGA+iyIlXcOCS2nJYVRWpku/vG7fpxW8iCu4L2vDMQrdJI7t97+ZA2
         B0MkEs/3/saU4gLpjce7QscqCFbJa3JdBLPuSmyu5jRObskEqFhao2y/azQKyZoKomI2
         iX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UldVqdZ9D7hgJVdDeCXgBnGyHE7wD3aOYhsVNPjQpDw=;
        b=rAJQIqAJyqukz0PAvaPgf1fU5Nqzqc86JMm77Ee6v+sPDGlomShoMi+tqiNpoiLD0C
         i7YHhDyE5g89Zw9EFwH3Nv58y4Z9sA+zNcLqxWvdSUWV83BBf1UFm0P0NLtQqoBSbG6V
         46u+35BjBj5de/fuvwwL32Hq2ddG5ug07v5FNzNs+I55CL4lpHYv9sZ6JjBDjEu1eNp3
         MdxCBYeafmF/NXvyUpv4jVmGNik7SQbSf2gwscuS3153d4zpOyhBS+24uvf47iNThsM/
         Uv/M2IVws8wggT49lHI3aOxIIIoIgXf5J8fNrxbTmj1AnQEsNl3bDFukU05SgeunSXpv
         qzQA==
X-Gm-Message-State: APjAAAW+s9f2+nHCbwUEjnybfFITNvIbIMSoUo6SoYuGaGFgodbnWFRw
        H48UzhHTwiro0wEavpapPvYruYzMxKl5KOgT5/mhJw==
X-Google-Smtp-Source: APXvYqxlUzSZlpmZAhfWujncoeY8eP2McvCAGNGuLdo6uZc7M5yKHyP/mexl4yajuCPTw3IZ+IfXUvYA5H/nHX/FZy8=
X-Received: by 2002:a17:902:102c:: with SMTP id b41mr45686628pla.204.1560554568603;
 Fri, 14 Jun 2019 16:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-2-brendanhiggins@google.com> <20190517185304.24EBE20848@mail.kernel.org>
In-Reply-To: <20190517185304.24EBE20848@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 14 Jun 2019 16:22:36 -0700
Message-ID: <CAFd5g44D8mySkp3ch=MaD3HZ_AuqnM6zfPbBUnNQDD-K4yBc4A@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] kunit: test: add KUnit test runner core
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

On Fri, May 17, 2019 at 11:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:16:54)
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > new file mode 100644
> > index 0000000000000..e682ea0e1f9a5
> > --- /dev/null
> > +++ b/include/kunit/test.h
> > @@ -0,0 +1,162 @@
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
> > +#include <linux/slab.h>
>
> Is this include used here?

Err, it is used in the very next commit in the sequence. Sorry, I will
add it in the commit that actually uses it in the next revision.

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
> > + * test case is associated with a &struct kunit_module and will be run after the
> > + * module's init function and followed by the module's exit function.
> > + *
> > + * A test case should be static and should only be created with the KUNIT_CASE()
> > + * macro; additionally, every array of test cases should be terminated with an
> > + * empty test case.
> > + *
> > + * Example:
> > + *
> > + * .. code-block:: c
> > + *
> > + *     void add_test_basic(struct kunit *test)
> > + *     {
> > + *             KUNIT_EXPECT_EQ(test, 1, add(1, 0));
> > + *             KUNIT_EXPECT_EQ(test, 2, add(1, 1));
> > + *             KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
> > + *             KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> > + *             KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> > + *     }
> > + *
> > + *     static struct kunit_case example_test_cases[] = {
> > + *             KUNIT_CASE(add_test_basic),
> > + *             {},
>
> Nitpick: Please drop the comma on the sentinel so nobody gets ideas to
> add another entry after it.

Good idea. Will fix here and elsewhere.

> > + *     };
> > + *
> > + */
> > +struct kunit_case {
> > +       void (*run_case)(struct kunit *test);
> > +       const char name[256];
>
> Maybe 256 can be a #define KUNIT_NAME_MAX_LEN? Or it could just be a
> const char pointer to a literal pool? Are unit tests making up names at
> runtime?

Yeah, sorry, I forgot why I did it this way in the first place. Will
fix in next revision.

> > +
> > +       /* private: internal use only. */
> > +       bool success;
> > +};
> > +
> > +/**
> > + * KUNIT_CASE - A helper for creating a &struct kunit_case
> > + * @test_name: a reference to a test case function.
> > + *
> > + * Takes a symbol for a function representing a test case and creates a
> > + * &struct kunit_case object from it. See the documentation for
> > + * &struct kunit_case for an example on how to use it.
> > + */
> > +#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> > +
> > +/**
> > + * struct kunit_module - describes a related collection of &struct kunit_case s.
> > + * @name: the name of the test. Purely informational.
> > + * @init: called before every test case.
> > + * @exit: called after every test case.
> > + * @test_cases: a null terminated array of test cases.
> > + *
> > + * A kunit_module is a collection of related &struct kunit_case s, such that
> > + * @init is called before every test case and @exit is called after every test
> > + * case, similar to the notion of a *test fixture* or a *test class* in other
> > + * unit testing frameworks like JUnit or Googletest.
> > + *
> > + * Every &struct kunit_case must be associated with a kunit_module for KUnit to
> > + * run it.
> > + */
> > +struct kunit_module {
> > +       const char name[256];
> > +       int (*init)(struct kunit *test);
> > +       void (*exit)(struct kunit *test);
> > +       struct kunit_case *test_cases;
>
> Can this variable be const? Or we expect test modules to adjust test_cases after
> the fact?

I understand why it would be nice to do it that way, but we store the
failed result on test cases; I don't think it really makes sense to
have another parallel data structure just for the results on each test
case.

> > +};
> > +
> > +/**
> > + * struct kunit - represents a running instance of a test.
> > + * @priv: for user to store arbitrary data. Commonly used to pass data created
> > + * in the init function (see &struct kunit_module).
> > + *
> > + * Used to store information about the current context under which the test is
> > + * running. Most of this data is private and should only be accessed indirectly
> > + * via public functions; the one exception is @priv which can be used by the
> > + * test writer to store arbitrary data.
> > + */
> > +struct kunit {
> > +       void *priv;
> > +
> > +       /* private: internal use only. */
> > +       const char *name; /* Read only after initialization! */
> > +       spinlock_t lock; /* Gaurds all mutable test state. */
> > +       bool success; /* Protected by lock. */
> > +};
> > +
> > +void kunit_init_test(struct kunit *test, const char *name);
> > +
> > +int kunit_run_tests(struct kunit_module *module);
> > +
> > +/**
> > + * module_test() - used to register a &struct kunit_module with KUnit.
> > + * @module: a statically allocated &struct kunit_module.
> > + *
> > + * Registers @module with the test framework. See &struct kunit_module for more
> > + * information.
> > + */
> > +#define module_test(module) \
> > +               static int module_kunit_init##module(void) \
> > +               { \
> > +                       return kunit_run_tests(&module); \
> > +               } \
> > +               late_initcall(module_kunit_init##module)
>
> Maybe we need to introduce another initcall level after
> late_initcall_sync() for tests? I wonder if there will be tests that
> need to run after all other initcalls have run, including late sync
> initcalls.

Yeah, I have another patch ready to go to do that. I guess I just
figured that was something that could lead to a lot of bikeshedding
that I wanted to avoid in the initial patchset.

Nevertheless, I can add it in if you feel it is better to discuss now.

> > +
> > +void __printf(3, 4) kunit_printk(const char *level,
> > +                                const struct kunit *test,
> > +                                const char *fmt, ...);
> > +
> > +/**
> > + * kunit_info() - Prints an INFO level message associated with the current test.
> > + * @test: The test context object.
> > + * @fmt: A printk() style format string.
> > + *
> > + * Prints an info level message associated with the test module being run. Takes
> > + * a variable number of format parameters just like printk().
> > + */
> > +#define kunit_info(test, fmt, ...) \
> > +               kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
> > +
> > +/**
> > + * kunit_warn() - Prints a WARN level message associated with the current test.
> > + * @test: The test context object.
> > + * @fmt: A printk() style format string.
> > + *
> > + * See kunit_info().
>
> Why? Just write out that it "Prints a warning level message".
>
> > + */
> > +#define kunit_warn(test, fmt, ...) \
> > +               kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
> > +
> > +/**
> > + * kunit_err() - Prints an ERROR level message associated with the current test.
> > + * @test: The test context object.
> > + * @fmt: A printk() style format string.
> > + *
> > + * See kunit_info().
>
> Same comment.
>
> > + */
> > +#define kunit_err(test, fmt, ...) \
> > +               kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> > +
> > +#endif /* _KUNIT_TEST_H */
> > diff --git a/kunit/Kconfig b/kunit/Kconfig
> > new file mode 100644
> > index 0000000000000..64480092b2c24
> > --- /dev/null
> > +++ b/kunit/Kconfig
> > @@ -0,0 +1,16 @@
> > +#
> > +# KUnit base configuration
> > +#
> > +
> > +menu "KUnit support"
> > +
> > +config KUNIT
> > +       bool "Enable support for unit tests (KUnit)"
> > +       help
> > +         Enables support for kernel unit tests (KUnit), a lightweight unit
> > +         testing and mocking framework for the Linux kernel. These tests are
> > +         able to be run locally on a developer's workstation without a VM or
> > +         special hardware. For more information, please see
> > +         Documentation/kunit/
>
> This moved and needs an update.
>
> > +
> > +endmenu
> > diff --git a/kunit/Makefile b/kunit/Makefile
> > new file mode 100644
> > index 0000000000000..5efdc4dea2c08
> > --- /dev/null
> > +++ b/kunit/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_KUNIT) +=                 test.o
> > diff --git a/kunit/test.c b/kunit/test.c
> > new file mode 100644
> > index 0000000000000..86f65ba2bcf92
> > --- /dev/null
> > +++ b/kunit/test.c
> > @@ -0,0 +1,229 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Base unit test (KUnit) API.
> > + *
> > + * Copyright (C) 2019, Google LLC.
> > + * Author: Brendan Higgins <brendanhiggins@google.com>
> > + */
> > +
> > +#include <linux/sched.h>
>
> This include gets removed later in the series, was it ever needed?

Nope, that was a mistake. Sorry.

> > +#include <linux/sched/debug.h>
> > +#include <kunit/test.h>
> > +
> > +static bool kunit_get_success(struct kunit *test)
> > +{
> > +       unsigned long flags;
> > +       bool success;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       success = test->success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
> > +
> > +       return success;
> > +}
> > +
> > +static void kunit_set_success(struct kunit *test, bool success)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&test->lock, flags);
> > +       test->success = success;
> > +       spin_unlock_irqrestore(&test->lock, flags);
> > +}
> > +
> > +static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > +{
> > +       return vprintk_emit(0, level, NULL, 0, fmt, args);
> > +}
> > +
> > +static int kunit_printk_emit(int level, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       int ret;
> > +
> > +       va_start(args, fmt);
> > +       ret = kunit_vprintk_emit(level, fmt, args);
> > +       va_end(args);
> > +
> > +       return ret;
> > +}
> > +
> > +static void kunit_vprintk(const struct kunit *test,
> > +                         const char *level,
> > +                         struct va_format *vaf)
> > +{
> > +       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > +}
> > +
> > +static bool kunit_has_printed_tap_version;
> > +
> > +static void kunit_print_tap_version(void)
> > +{
> > +       if (!kunit_has_printed_tap_version) {
> > +               kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> > +               kunit_has_printed_tap_version = true;
> > +       }
> > +}
> > +
> > +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > +{
> > +       struct kunit_case *test_case;
> > +       size_t len = 0;
> > +
> > +       for (test_case = test_cases; test_case->run_case; test_case++)
> > +               len++;
> > +
> > +       return len;
> > +}
> > +
> > +static void kunit_print_subtest_start(struct kunit_module *module)
> > +{
> > +       kunit_print_tap_version();
> > +       kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", module->name);
> > +       kunit_printk_emit(LOGLEVEL_INFO,
> > +                         "\t1..%zd\n",
> > +                         kunit_test_cases_len(module->test_cases));
> > +}
> > +
> > +static void kunit_print_ok_not_ok(bool should_indent,
> > +                                 bool is_ok,
> > +                                 size_t test_number,
> > +                                 const char *description)
> > +{
> > +       const char *indent, *ok_not_ok;
> > +
> > +       if (should_indent)
> > +               indent = "\t";
> > +       else
> > +               indent = "";
> > +
> > +       if (is_ok)
> > +               ok_not_ok = "ok";
> > +       else
> > +               ok_not_ok = "not ok";
> > +
> > +       kunit_printk_emit(LOGLEVEL_INFO,
> > +                         "%s%s %zd - %s\n",
> > +                         indent, ok_not_ok, test_number, description);
> > +}
> > +
> > +static bool kunit_module_has_succeeded(struct kunit_module *module)
> > +{
> > +       struct kunit_case *test_case;
>
> This can be const?

Yep, nice catch.

> > +       bool success = true;
> > +
> > +       for (test_case = module->test_cases; test_case->run_case; test_case++)
> > +               if (!test_case->success)
> > +                       success = false;
>
> Bail out early here on first "fail" with return false?

Will fix on next revision.

> > +
> > +       return success;
> > +}
> > +
> > +size_t kunit_module_counter = 1;
> > +
> > +static void kunit_print_subtest_end(struct kunit_module *module)
> > +{
> > +       kunit_print_ok_not_ok(false,
> > +                             kunit_module_has_succeeded(module),
> > +                             kunit_module_counter++,
> > +                             module->name);
> > +}
> > +
> > +static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> > +                                           size_t test_number)
> > +{
> > +       kunit_print_ok_not_ok(true,
> > +                             test_case->success,
> > +                             test_number,
> > +                             test_case->name);
> > +}
> > +
> > +void kunit_init_test(struct kunit *test, const char *name)
> > +{
> > +       spin_lock_init(&test->lock);
> > +       test->name = name;
> > +}
> > +
> > +/*
> > + * Initializes and runs test case. Does not clean up or do post validations.
> > + */
> > +static void kunit_run_case_internal(struct kunit *test,
> > +                                   struct kunit_module *module,
> > +                                   struct kunit_case *test_case)
> > +{
> > +       int ret;
> > +
> > +       if (module->init) {
> > +               ret = module->init(test);
> > +               if (ret) {
> > +                       kunit_err(test, "failed to initialize: %d\n", ret);
> > +                       kunit_set_success(test, false);
> > +                       return;
> > +               }
> > +       }
> > +
> > +       test_case->run_case(test);
> > +}
> > +
> > +/*
> > + * Performs post validations and cleanup after a test case was run.
> > + * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
> > + */
> > +static void kunit_run_case_cleanup(struct kunit *test,
> > +                                  struct kunit_module *module,
> > +                                  struct kunit_case *test_case)
>
> But test_case isn't used?

Whoops, will fix.

> > +{
> > +       if (module->exit)
>
> Aha, so we don't need empty functions in the sysctl test.

Nope, sorry about that. That will be fixed in the next revision.

> > +               module->exit(test);
> > +}
> > +
> > +/*
> > + * Performs all logic to run a test case.
> > + */
> > +static void kunit_run_case(struct kunit_module *module,
> > +                          struct kunit_case *test_case)
> > +{
> > +       struct kunit test;
> > +
> > +       kunit_init_test(&test, test_case->name);
> > +       kunit_set_success(&test, true);
>
> Can kunit_init_test() also kunit_set_success() to true or false,
> depending on what is desired as the initial state?
>
> > +
> > +       kunit_run_case_internal(&test, module, test_case);
> > +       kunit_run_case_cleanup(&test, module, test_case);
>
> I find this odd, we have run_case_internal() that does two things, init
> and run_case, while case_cleanup() does one thing, call module->exit().
>
> Can we just inline all those functions in here so that it looks like
> this:
>
>        int ret = 0;
>
>        if (module->init) {
>               ret = module->init(test);
>                if (ret) {
>                        kunit_err(test, "failed to initialize: %d\n", ret);
>                        kunit_set_success(&test, false);
>                }
>        }
>
>        if (!ret)
>                test_case->run_case(&test);
>
>        if (module->exit)
>                module->exit(&test);
>
>        return kunit_get_success(&test);
>
> Then I don't have to read two more functions to figure out the flow of
> running a test case.

Sorry about that. A lot more logic gets added to running test cases
later on in this patchset. This logic added "later" is actually older
than what's here, so I basically "unrefactored" something I had
already written to get this earlier patch.

In anycase, you are right; these little tiny functions don't make any
sense (yet); I will remove them in the next revision (and let the
later patch make these changes in a  more organic looking way).

>
> > +
> > +       test_case->success = kunit_get_success(&test);
> > +}
> > +
> > +int kunit_run_tests(struct kunit_module *module)
> > +{
> > +       struct kunit_case *test_case;
> > +       size_t test_case_count = 1;
>
> Might make sense to assign this to 0 first and then pre-increment so
> that test_case_count can't be 1 when there aren't any tests?

No, sorry, this is actually specified by the Test Anything Protocol
(TAP); it indexes it's tests starting at 1; not what I would have
done, but we (Greg, Frank, myself, and others) previously agreed that
KUnit should follow TAP[1].

Maybe the name of this variable is a bit misleading since it is the
"test number" or test index. Would `test_case_number` be better?

> > +
> > +       kunit_print_subtest_start(module);
> > +
> > +       for (test_case = module->test_cases; test_case->run_case; test_case++) {
> > +               kunit_run_case(module, test_case);
> > +               kunit_print_test_case_ok_not_ok(test_case, test_case_count++);
>
> Can this be pushed into kunit_run_case() and have that function take a
> test_case_count number? Maybe that would allow us to avoid storing
> test_case->success entirely? Assuming that kunit_run_case() returned a
> value like success or failure, then yes it would work.

Eh, I would prefer not to do that. I like keeping the
printing/reporting functions as orthogonal as possible; it kind of
mirrors the parsing logic on the test harness script side, and will
also be easier to pull out when I go back to improve the expectation
failure reporting when I get around to that later. Even if I never get
around to that, I think this will be much easier for me to maintain.

>        unsigned int failed = 0;
>
>        for (test_case = module->test_cases; test_case->run_case; test_case++) {
>                failed |= kunit_run_case(module, test_case, ++test_case_count);
>
>        kunit_print_ok_not_ok(false,
>                              !failed,
>                              kunit_module_counter++,
>                              module->name);
>
> > +       kunit_print_subtest_end(module);
> > +
> > +       return 0;
> > +}

[1] https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md#the-test-line
