Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0918AE22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 06:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHMEzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 00:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfHMEzM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:55:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D6E206C2;
        Tue, 13 Aug 2019 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565672110;
        bh=sNs8Jd2xkQEsuQp9rhkHGchWAQJXpnxX1ZLCePCDf18=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r6BR1VpnUPJtcLpxSN6MzduXH/yQRPwo8roQ2PhzFBwrjyUmuDeet29A/zAYIKzoB
         rXSL+H7vMbDJlLtVTxK+pxHOYx2XBv7vlL5PTxOzCH7sywF+WyBUoRmzmArBuhPF9v
         rnjMiiYeiR/EOunpx0iR0Cc/RMwL2jKukJ0nIsg4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-12-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-12-brendanhiggins@google.com>
Subject: Re: [PATCH v12 11/18] kunit: test: add the concept of assertions
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
Date:   Mon, 12 Aug 2019 21:55:09 -0700
Message-Id: <20190813045510.C1D6E206C2@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:14)
> Add support for assertions which are like expectations except the test
> terminates if the assertion is not satisfied.
>=20
> The idea with assertions is that you use them to state all the
> preconditions for your test. Logically speaking, these are the premises
> of the test case, so if a premise isn't true, there is no point in
> continuing the test case because there are no conclusions that can be
> drawn without the premises. Whereas, the expectation is the thing you
> are trying to prove. It is not used universally in x-unit style test
> frameworks, but I really like it as a convention.  You could still
> express the idea of a premise using the above idiom, but I think
> KUNIT_ASSERT_* states the intended idea perfectly.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> + * Sets an expectation that the values that @left and @right evaluate to=
 are
> + * not equal. This is semantically equivalent to
> + * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT=
_TRUE()
> + * for more information.
> + */
> +#define KUNIT_ASSERT_STRNEQ(test, left, right)                          =
      \
> +               KUNIT_BINARY_STR_NE_ASSERTION(test,                      =
      \
> +                                             KUNIT_ASSERTION,           =
      \
> +                                             left,                      =
      \
> +                                             right)
> +
> +#define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)            =
      \
> +               KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,                  =
      \
> +                                                 KUNIT_ASSERTION,       =
      \
> +                                                 left,                  =
      \
> +                                                 right,                 =
      \
> +                                                 fmt,                   =
      \

Same question about tabbing too.

> diff --git a/kunit/test-test.c b/kunit/test-test.c
> index 88f4cdf03db2a..058f3fb37458a 100644
> --- a/kunit/test-test.c
> +++ b/kunit/test-test.c
> @@ -78,11 +78,13 @@ static int kunit_try_catch_test_init(struct kunit *te=
st)
>         struct kunit_try_catch_test_context *ctx;
> =20
>         ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);

Ah ok. Question still stands if kunit_kzalloc() should just have the
assertion on failure.

>         test->priv =3D ctx;
> =20
>         ctx->try_catch =3D kunit_kmalloc(test,
>                                        sizeof(*ctx->try_catch),
>                                        GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->try_catch);
> =20
