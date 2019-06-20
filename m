Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30294C462
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 02:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfFTAP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 20:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfFTAP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:15:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93426218BE;
        Thu, 20 Jun 2019 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560989726;
        bh=Cyw3CS4Us7cHDynulRLePwpLSsuY8ho08g4vXgTjDFM=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=uxkDxyYpF7laGQMQdbheNapqj0FQjS0o/hFsG69mDV7yMnicTh9sX+q1GYO8mfbwg
         E1z69sHUGBcQdsi2WlYDYbSc4B2+s17Nz6qJQoCAMJgUsjAbryk7FV2ai2kP081uXc
         0hRlrWl2NbES9/L1UjKNP/E97FgjeS8RMgUcodoM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190617082613.109131-2-brendanhiggins@google.com>
References: <20190617082613.109131-1-brendanhiggins@google.com> <20190617082613.109131-2-brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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
User-Agent: alot/0.8.1
Date:   Wed, 19 Jun 2019 17:15:25 -0700
Message-Id: <20190620001526.93426218BE@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-06-17 01:25:56)
> diff --git a/kunit/test.c b/kunit/test.c
> new file mode 100644
> index 0000000000000..d05d254f1521f
> --- /dev/null
> +++ b/kunit/test.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
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

I still don't understand the locking scheme in this code. Is the
intention to make getter and setter APIs that are "safe" by adding in a
spinlock that is held around getting and setting various members in the
kunit structure?

In what situation is there more than one thread reading or writing the
kunit struct? Isn't it only a single process that is going to be
operating on this structure? And why do we need to disable irqs? Are we
expecting to be modifying the unit tests from irq contexts?

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

Can you please move this into function local scope in the function
below?

> +
> +static void kunit_print_tap_version(void)
> +{
> +       if (!kunit_has_printed_tap_version) {
> +               kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");
> +               kunit_has_printed_tap_version =3D true;
> +       }
> +}
> +
[...]
> +
> +static bool kunit_module_has_succeeded(struct kunit_module *module)
> +{
> +       const struct kunit_case *test_case;
> +       bool success =3D true;
> +
> +       for (test_case =3D module->test_cases; test_case->run_case; test_=
case++)
> +               if (!test_case->success) {
> +                       success =3D false;
> +                       break;

Why not 'return false'?

> +               }
> +
> +       return success;

And 'return true'?

> +}
> +
> +static size_t kunit_module_counter =3D 1;
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
> +       test->success =3D true;
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_module *module,
> +                          struct kunit_case *test_case)
> +{
> +       struct kunit test;
> +       int ret =3D 0;
> +
> +       kunit_init_test(&test, test_case->name);
> +
> +       if (module->init) {
> +               ret =3D module->init(&test);
> +               if (ret) {
> +                       kunit_err(&test, "failed to initialize: %d\n", re=
t);
> +                       kunit_set_success(&test, false);
> +                       return;
> +               }
> +       }
> +
> +       if (!ret)
> +               test_case->run_case(&test);

Do we need this if condition? ret can only be set to non-zero above but
then we'll exit the function early so it seems unnecessary. Given that,
ret should probably be moved into the module->init path.

> +
> +       if (module->exit)
> +               module->exit(&test);
> +
> +       test_case->success =3D kunit_get_success(&test);
> +}
> +
