Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B043E21DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfEQSxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQSxF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:53:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EBE20848;
        Fri, 17 May 2019 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558119184;
        bh=ELb3H7Nos3RRCsfBagjPT0/HEf9aP8K/iidFcHGUGi0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hPXuHS3Yw2jkx/z7WQLHy5z+aUTNwq7IjL1NEH+Hh7zueqD+rMjsmUgjLj86VY/bE
         CzAMtP82elmXLyv+VraCAMD5oYw2gArSEnPNMUm8OIaWzUg8I87XaMFnPuCNF9Nx8z
         ZGRdmtLmWk6JbdNAba4LSdxoYMSU5LAxRfvF3Usw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190514221711.248228-2-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-2-brendanhiggins@google.com>
Subject: Re: [PATCH v4 01/18] kunit: test: add KUnit test runner core
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Fri, 17 May 2019 11:53:03 -0700
Message-Id: <20190517185304.24EBE20848@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-05-14 15:16:54)
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> new file mode 100644
> index 0000000000000..e682ea0e1f9a5
> --- /dev/null
> +++ b/include/kunit/test.h
> @@ -0,0 +1,162 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_H
> +#define _KUNIT_TEST_H
> +
> +#include <linux/types.h>
> +#include <linux/slab.h>

Is this include used here?

> +
> +struct kunit;
> +
> +/**
> + * struct kunit_case - represents an individual test case.
> + * @run_case: the function representing the actual test case.
> + * @name: the name of the test case.
> + *
> + * A test case is a function with the signature, ``void (*)(struct kunit=
 *)``
> + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under te=
st. Each
> + * test case is associated with a &struct kunit_module and will be run a=
fter the
> + * module's init function and followed by the module's exit function.
> + *
> + * A test case should be static and should only be created with the KUNI=
T_CASE()
> + * macro; additionally, every array of test cases should be terminated w=
ith an
> + * empty test case.
> + *
> + * Example:
> + *
> + * .. code-block:: c
> + *
> + *     void add_test_basic(struct kunit *test)
> + *     {
> + *             KUNIT_EXPECT_EQ(test, 1, add(1, 0));
> + *             KUNIT_EXPECT_EQ(test, 2, add(1, 1));
> + *             KUNIT_EXPECT_EQ(test, 0, add(-1, 1));
> + *             KUNIT_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> + *             KUNIT_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> + *     }
> + *
> + *     static struct kunit_case example_test_cases[] =3D {
> + *             KUNIT_CASE(add_test_basic),
> + *             {},

Nitpick: Please drop the comma on the sentinel so nobody gets ideas to
add another entry after it.

> + *     };
> + *
> + */
> +struct kunit_case {
> +       void (*run_case)(struct kunit *test);
> +       const char name[256];

Maybe 256 can be a #define KUNIT_NAME_MAX_LEN? Or it could just be a
const char pointer to a literal pool? Are unit tests making up names at
runtime?

> +
> +       /* private: internal use only. */
> +       bool success;
> +};
> +
> +/**
> + * KUNIT_CASE - A helper for creating a &struct kunit_case
> + * @test_name: a reference to a test case function.
> + *
> + * Takes a symbol for a function representing a test case and creates a
> + * &struct kunit_case object from it. See the documentation for
> + * &struct kunit_case for an example on how to use it.
> + */
> +#define KUNIT_CASE(test_name) { .run_case =3D test_name, .name =3D #test=
_name }
> +
> +/**
> + * struct kunit_module - describes a related collection of &struct kunit=
_case s.
> + * @name: the name of the test. Purely informational.
> + * @init: called before every test case.
> + * @exit: called after every test case.
> + * @test_cases: a null terminated array of test cases.
> + *
> + * A kunit_module is a collection of related &struct kunit_case s, such =
that
> + * @init is called before every test case and @exit is called after ever=
y test
> + * case, similar to the notion of a *test fixture* or a *test class* in =
other
> + * unit testing frameworks like JUnit or Googletest.
> + *
> + * Every &struct kunit_case must be associated with a kunit_module for K=
Unit to
> + * run it.
> + */
> +struct kunit_module {
> +       const char name[256];
> +       int (*init)(struct kunit *test);
> +       void (*exit)(struct kunit *test);
> +       struct kunit_case *test_cases;

Can this variable be const? Or we expect test modules to adjust test_cases =
after
the fact?

> +};
> +
> +/**
> + * struct kunit - represents a running instance of a test.
> + * @priv: for user to store arbitrary data. Commonly used to pass data c=
reated
> + * in the init function (see &struct kunit_module).
> + *
> + * Used to store information about the current context under which the t=
est is
> + * running. Most of this data is private and should only be accessed ind=
irectly
> + * via public functions; the one exception is @priv which can be used by=
 the
> + * test writer to store arbitrary data.
> + */
> +struct kunit {
> +       void *priv;
> +
> +       /* private: internal use only. */
> +       const char *name; /* Read only after initialization! */
> +       spinlock_t lock; /* Gaurds all mutable test state. */
> +       bool success; /* Protected by lock. */
> +};
> +
> +void kunit_init_test(struct kunit *test, const char *name);
> +
> +int kunit_run_tests(struct kunit_module *module);
> +
> +/**
> + * module_test() - used to register a &struct kunit_module with KUnit.
> + * @module: a statically allocated &struct kunit_module.
> + *
> + * Registers @module with the test framework. See &struct kunit_module f=
or more
> + * information.
> + */
> +#define module_test(module) \
> +               static int module_kunit_init##module(void) \
> +               { \
> +                       return kunit_run_tests(&module); \
> +               } \
> +               late_initcall(module_kunit_init##module)

Maybe we need to introduce another initcall level after
late_initcall_sync() for tests? I wonder if there will be tests that
need to run after all other initcalls have run, including late sync
initcalls.

> +
> +void __printf(3, 4) kunit_printk(const char *level,
> +                                const struct kunit *test,
> +                                const char *fmt, ...);
> +
> +/**
> + * kunit_info() - Prints an INFO level message associated with the curre=
nt test.
> + * @test: The test context object.
> + * @fmt: A printk() style format string.
> + *
> + * Prints an info level message associated with the test module being ru=
n. Takes
> + * a variable number of format parameters just like printk().
> + */
> +#define kunit_info(test, fmt, ...) \
> +               kunit_printk(KERN_INFO, test, fmt, ##__VA_ARGS__)
> +
> +/**
> + * kunit_warn() - Prints a WARN level message associated with the curren=
t test.
> + * @test: The test context object.
> + * @fmt: A printk() style format string.
> + *
> + * See kunit_info().

Why? Just write out that it "Prints a warning level message".

> + */
> +#define kunit_warn(test, fmt, ...) \
> +               kunit_printk(KERN_WARNING, test, fmt, ##__VA_ARGS__)
> +
> +/**
> + * kunit_err() - Prints an ERROR level message associated with the curre=
nt test.
> + * @test: The test context object.
> + * @fmt: A printk() style format string.
> + *
> + * See kunit_info().

Same comment.

> + */
> +#define kunit_err(test, fmt, ...) \
> +               kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> +
> +#endif /* _KUNIT_TEST_H */
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> new file mode 100644
> index 0000000000000..64480092b2c24
> --- /dev/null
> +++ b/kunit/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# KUnit base configuration
> +#
> +
> +menu "KUnit support"
> +
> +config KUNIT
> +       bool "Enable support for unit tests (KUnit)"
> +       help
> +         Enables support for kernel unit tests (KUnit), a lightweight un=
it
> +         testing and mocking framework for the Linux kernel. These tests=
 are
> +         able to be run locally on a developer's workstation without a V=
M or
> +         special hardware. For more information, please see
> +         Documentation/kunit/

This moved and needs an update.

> +
> +endmenu
> diff --git a/kunit/Makefile b/kunit/Makefile
> new file mode 100644
> index 0000000000000..5efdc4dea2c08
> --- /dev/null
> +++ b/kunit/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_KUNIT) +=3D                 test.o
> diff --git a/kunit/test.c b/kunit/test.c
> new file mode 100644
> index 0000000000000..86f65ba2bcf92
> --- /dev/null
> +++ b/kunit/test.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/sched.h>

This include gets removed later in the series, was it ever needed?

> +#include <linux/sched/debug.h>
> +#include <kunit/test.h>
> +
> +static bool kunit_get_success(struct kunit *test)
> +{
> +       unsigned long flags;
> +       bool success;
> +
> +       spin_lock_irqsave(&test->lock, flags);
> +       success =3D test->success;
> +       spin_unlock_irqrestore(&test->lock, flags);
> +
> +       return success;
> +}
> +
> +static void kunit_set_success(struct kunit *test, bool success)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&test->lock, flags);
> +       test->success =3D success;
> +       spin_unlock_irqrestore(&test->lock, flags);
> +}
> +
> +static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> +{
> +       return vprintk_emit(0, level, NULL, 0, fmt, args);
> +}
> +
> +static int kunit_printk_emit(int level, const char *fmt, ...)
> +{
> +       va_list args;
> +       int ret;
> +
> +       va_start(args, fmt);
> +       ret =3D kunit_vprintk_emit(level, fmt, args);
> +       va_end(args);
> +
> +       return ret;
> +}
> +
> +static void kunit_vprintk(const struct kunit *test,
> +                         const char *level,
> +                         struct va_format *vaf)
> +{
> +       kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> +}
> +
> +static bool kunit_has_printed_tap_version;
> +
> +static void kunit_print_tap_version(void)
> +{
> +       if (!kunit_has_printed_tap_version) {
> +               kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> +               kunit_has_printed_tap_version =3D true;
> +       }
> +}
> +
> +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> +{
> +       struct kunit_case *test_case;
> +       size_t len =3D 0;
> +
> +       for (test_case =3D test_cases; test_case->run_case; test_case++)
> +               len++;
> +
> +       return len;
> +}
> +
> +static void kunit_print_subtest_start(struct kunit_module *module)
> +{
> +       kunit_print_tap_version();
> +       kunit_printk_emit(LOGLEVEL_INFO, "\t# Subtest: %s\n", module->nam=
e);
> +       kunit_printk_emit(LOGLEVEL_INFO,
> +                         "\t1..%zd\n",
> +                         kunit_test_cases_len(module->test_cases));
> +}
> +
> +static void kunit_print_ok_not_ok(bool should_indent,
> +                                 bool is_ok,
> +                                 size_t test_number,
> +                                 const char *description)
> +{
> +       const char *indent, *ok_not_ok;
> +
> +       if (should_indent)
> +               indent =3D "\t";
> +       else
> +               indent =3D "";
> +
> +       if (is_ok)
> +               ok_not_ok =3D "ok";
> +       else
> +               ok_not_ok =3D "not ok";
> +
> +       kunit_printk_emit(LOGLEVEL_INFO,
> +                         "%s%s %zd - %s\n",
> +                         indent, ok_not_ok, test_number, description);
> +}
> +
> +static bool kunit_module_has_succeeded(struct kunit_module *module)
> +{
> +       struct kunit_case *test_case;

This can be const?

> +       bool success =3D true;
> +
> +       for (test_case =3D module->test_cases; test_case->run_case; test_=
case++)
> +               if (!test_case->success)
> +                       success =3D false;

Bail out early here on first "fail" with return false?

> +
> +       return success;
> +}
> +
> +size_t kunit_module_counter =3D 1;
> +
> +static void kunit_print_subtest_end(struct kunit_module *module)
> +{
> +       kunit_print_ok_not_ok(false,
> +                             kunit_module_has_succeeded(module),
> +                             kunit_module_counter++,
> +                             module->name);
> +}
> +
> +static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
> +                                           size_t test_number)
> +{
> +       kunit_print_ok_not_ok(true,
> +                             test_case->success,
> +                             test_number,
> +                             test_case->name);
> +}
> +
> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +       spin_lock_init(&test->lock);
> +       test->name =3D name;
> +}
> +
> +/*
> + * Initializes and runs test case. Does not clean up or do post validati=
ons.
> + */
> +static void kunit_run_case_internal(struct kunit *test,
> +                                   struct kunit_module *module,
> +                                   struct kunit_case *test_case)
> +{
> +       int ret;
> +
> +       if (module->init) {
> +               ret =3D module->init(test);
> +               if (ret) {
> +                       kunit_err(test, "failed to initialize: %d\n", ret=
);
> +                       kunit_set_success(test, false);
> +                       return;
> +               }
> +       }
> +
> +       test_case->run_case(test);
> +}
> +
> +/*
> + * Performs post validations and cleanup after a test case was run.
> + * XXX: Should ONLY BE CALLED AFTER kunit_run_case_internal!
> + */
> +static void kunit_run_case_cleanup(struct kunit *test,
> +                                  struct kunit_module *module,
> +                                  struct kunit_case *test_case)

But test_case isn't used?

> +{
> +       if (module->exit)

Aha, so we don't need empty functions in the sysctl test.

> +               module->exit(test);
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_module *module,
> +                          struct kunit_case *test_case)
> +{
> +       struct kunit test;
> +
> +       kunit_init_test(&test, test_case->name);
> +       kunit_set_success(&test, true);

Can kunit_init_test() also kunit_set_success() to true or false,
depending on what is desired as the initial state?

> +
> +       kunit_run_case_internal(&test, module, test_case);
> +       kunit_run_case_cleanup(&test, module, test_case);

I find this odd, we have run_case_internal() that does two things, init
and run_case, while case_cleanup() does one thing, call module->exit().

Can we just inline all those functions in here so that it looks like
this:

       int ret =3D 0;

       if (module->init) {
              ret =3D module->init(test);
               if (ret) {
                       kunit_err(test, "failed to initialize: %d\n", ret);
                       kunit_set_success(&test, false);
               }
       }

       if (!ret)
               test_case->run_case(&test);

       if (module->exit)
               module->exit(&test);

       return kunit_get_success(&test);

Then I don't have to read two more functions to figure out the flow of
running a test case.

> +
> +       test_case->success =3D kunit_get_success(&test);
> +}
> +
> +int kunit_run_tests(struct kunit_module *module)
> +{
> +       struct kunit_case *test_case;
> +       size_t test_case_count =3D 1;

Might make sense to assign this to 0 first and then pre-increment so
that test_case_count can't be 1 when there aren't any tests?

> +
> +       kunit_print_subtest_start(module);
> +
> +       for (test_case =3D module->test_cases; test_case->run_case; test_=
case++) {
> +               kunit_run_case(module, test_case);
> +               kunit_print_test_case_ok_not_ok(test_case, test_case_coun=
t++);

Can this be pushed into kunit_run_case() and have that function take a
test_case_count number? Maybe that would allow us to avoid storing
test_case->success entirely? Assuming that kunit_run_case() returned a
value like success or failure, then yes it would work.

       unsigned int failed =3D 0;

       for (test_case =3D module->test_cases; test_case->run_case; test_cas=
e++) {
               failed |=3D kunit_run_case(module, test_case, ++test_case_co=
unt);

       kunit_print_ok_not_ok(false,
                             !failed,
                             kunit_module_counter++,
                             module->name);

> +       kunit_print_subtest_end(module);
> +
> +       return 0;
> +}
