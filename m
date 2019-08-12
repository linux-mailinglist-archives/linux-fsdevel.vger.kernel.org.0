Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19C58AB63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 01:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfHLXqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 19:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfHLXqq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:46:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E054D20679;
        Mon, 12 Aug 2019 23:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565653605;
        bh=B5M35uPs7D5CLgV2WuA3jEwtQw8IijPFRqyXw/4bWMU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AGOwiTgbdj+2ifl0a7Xbp5/lsMWfdJc7+aAllnZ0hjKfSs/gNRN2411MBEaSKQzNW
         jmCAe62dNE3Eo33h9i7ShysYfWASja+7gi/ROqRCoY/PPSVzU5+gcDFa0QwS9wu2/G
         09nGYZB8GjciLbmMfntmYaBwKJxcaqwUc60bVJjM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812182421.141150-5-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-5-brendanhiggins@google.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
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
Date:   Mon, 12 Aug 2019 16:46:44 -0700
Message-Id: <20190812234644.E054D20679@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 11:24:07)
> Add `struct kunit_assert` and friends which provide a structured way to
> capture data from an expectation or an assertion (introduced later in
> the series) so that it may be printed out in the event of a failure.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Just some minor nits below

> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> new file mode 100644
> index 0000000000000..55f1b88b0cb4d
> --- /dev/null
> +++ b/include/kunit/assert.h
> @@ -0,0 +1,183 @@
[...]
> +                           struct string_stream *stream);
> +
> +struct kunit_fail_assert {
> +       struct kunit_assert assert;
> +};
> +
> +void kunit_fail_assert_format(const struct kunit_assert *assert,
> +                             struct string_stream *stream);
> +
> +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                     =
      \
> +               .assert =3D KUNIT_INIT_ASSERT_STRUCT(test,               =
        \
> +                                                  type,                 =
      \
> +                                                  kunit_fail_assert_form=
at)   \

This one got indented one too many times?

> +}
> +
> +struct kunit_unary_assert {
> +       struct kunit_assert assert;
> +       const char *condition;
> +       bool expected_true;
> +};
> +
> +void kunit_unary_assert_format(const struct kunit_assert *assert,
> +                              struct string_stream *stream);
> +
[...]
> +#define KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,                       =
      \
> +                                           type,                        =
      \
> +                                           op_str,                      =
      \
> +                                           left_str,                    =
      \
> +                                           left_val,                    =
      \
> +                                           right_str,                   =
      \
> +                                           right_val) {                 =
      \
> +       .assert =3D KUNIT_INIT_ASSERT_STRUCT(test,                       =
        \
> +                                          type,                         =
      \
> +                                          kunit_binary_str_assert_format=
),    \
> +       .operation =3D op_str,                                           =
        \
> +       .left_text =3D left_str,                                         =
        \
> +       .left_value =3D left_val,                                        =
        \
> +       .right_text =3D right_str,                                       =
        \
> +       .right_value =3D right_val                                       =
        \
> +}

It would be nice to have kernel doc on these macros so we know how to
use them.

