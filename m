Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AAA8AB99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 01:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfHLX5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 19:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfHLX5C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:57:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533E82063F;
        Mon, 12 Aug 2019 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565654221;
        bh=Bqdkmnp6mwn7+uGtiuDRkW/S4L7BPoXk0yV/X+vBL54=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xH5Jr1y+zA4g2T4Lqz5yO5pV+3YI+m+g1R3ck6bSJoBiMnDkJSdrB5821koEnOM1x
         ozemBUqGL2ni/PA36r1U7ZN9xHwvK3C4GSABt23yhMwa/Dx7vomqnds0asZ6RIkXYl
         YOqHX4j25oAAbX9XJcyROx5ez17nbuRYexkCgIEQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-6-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-6-brendanhiggins@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
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
Date:   Mon, 12 Aug 2019 16:57:00 -0700
Message-Id: <20190812235701.533E82063F@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:08)
> Add support for expectations, which allow properties to be specified and
> then verified in tests.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Just some minor nits again.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d0bf112910caf..2625bcfeb19ac 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -9,8 +9,10 @@
>  #ifndef _KUNIT_TEST_H
>  #define _KUNIT_TEST_H
> =20
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <kunit/assert.h>

Can you alphabet sort these?

> =20
>  struct kunit_resource;
> =20
> @@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
>  #define kunit_err(test, fmt, ...) \
>                 kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> =20
> +/*
> + * Generates a compile-time warning in case of comparing incompatible ty=
pes.
> + */
> +#define __kunit_typecheck(lhs, rhs) \
> +       ((void) __typecheck(lhs, rhs))

Is there a reason why this can't be inlined and the __kunit_typecheck()
macro can't be removed?

> +
> +/**
> + * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> + * @test: The test context object.
[...]
> + * @condition: an arbitrary boolean expression. The test fails when this=
 does
> + * not evaluate to true.
> + *
> + * This and expectations of the form `KUNIT_EXPECT_*` will cause the tes=
t case
> + * to fail when the specified condition is not met; however, it will not=
 prevent
> + * the test case from continuing to run; this is otherwise known as an
> + * *expectation failure*.
> + */
> +#define KUNIT_EXPECT_TRUE(test, condition) \
> +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)

A lot of these macros seem double indented.

> +
> +#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                =
      \
> +               KUNIT_TRUE_MSG_ASSERTION(test,                           =
      \
> +                                        KUNIT_EXPECTATION,              =
      \
> +                                        condition,                      =
      \
> +                                        fmt,                            =
      \
> +                                        ##__VA_ARGS__)
> +
