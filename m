Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404DA69C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 22:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfGOUK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 16:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfGOUKz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:10:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69AA2086C;
        Mon, 15 Jul 2019 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563221454;
        bh=VRTZWx/5sKJHdH3qQkzEYYxjC5JMv+S2b65daQVUdGU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=JQmD4doZtzPy2RsxVJTfXU4+HVaWbuij6HH8oF8RC7zWY3b+zfLb6BjosM4nFE8Zv
         mrb4jXugiyvntNyKdYloWJPzuahddLnXpqJKuYJRQSRO/Vb9WmX1qLLp99cO9XQ/uR
         gs7n762HrytDofL3ccz7u/kjKohqqEh0qv06XoyM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190712081744.87097-2-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com> <20190712081744.87097-2-brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
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
Subject: Re: [PATCH v9 01/18] kunit: test: add KUnit test runner core
User-Agent: alot/0.8.1
Date:   Mon, 15 Jul 2019 13:10:53 -0700
Message-Id: <20190715201054.C69AA2086C@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-07-12 01:17:27)
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
>=20
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Minor nits below.

> diff --git a/kunit/test.c b/kunit/test.c
> new file mode 100644
> index 0000000000000..571e4c65deb5c
> --- /dev/null
> +++ b/kunit/test.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <kunit/test.h>
> +
> +static void kunit_set_failure(struct kunit *test)
> +{
> +       WRITE_ONCE(test->success, false);
> +}
> +
[...]
> +
> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +       test->name =3D name;
> +       test->success =3D true;
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_suite *suite,
> +                          struct kunit_case *test_case)
> +{
> +       struct kunit test;
> +       int ret =3D 0;
> +
> +       kunit_init_test(&test, test_case->name);
> +
> +       if (suite->init) {
> +               ret =3D suite->init(&test);

Can you push the ret definition into this if scope? That way we can
avoid default initialize to 0 for it.

> +               if (ret) {
> +                       kunit_err(&test, "failed to initialize: %d\n", re=
t);
> +                       kunit_set_failure(&test);

Do we need to 'test_case->success =3D test.success' here too? Or is the
test failure extracted somewhere else?

> +                       return;
> +               }
> +       }
> +
> +       test_case->run_case(&test);
> +
> +       if (suite->exit)
> +               suite->exit(&test);
> +
> +       test_case->success =3D test.success;
