Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686C88AE5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 07:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfHMFCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 01:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHMFCH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:02:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A49C206C2;
        Tue, 13 Aug 2019 05:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565672526;
        bh=VlB5crXiwSSXpj9OJzMKtvlRZYtABRaxOaHE9tvmNvQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CWjDW5KmpM1E7Bx+UYTB4tyPDejc2fEUptE5IcAkuGvU7mUfDgTAAhTueY0gTM5ZJ
         Lf7aINsUW0IO9cUIA9NGU6yHEm7BhE7QOER+LlRbYnrOJlgvwyaBWpzcuKPKNq9Pqu
         6jAUm8V4d6UWvUCRS3+itnRHBDP2BfyVmt1mXiAY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190813003352.GA235915@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-6-brendanhiggins@google.com> <20190812235701.533E82063F@mail.kernel.org> <20190813003352.GA235915@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
        wfg@linux.intel.com
To:     Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 22:02:05 -0700
Message-Id: <20190813050206.2A49C206C2@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 17:33:52)
> On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-08-12 11:24:08)
> > > + */
> > > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, conditi=
on)
> >=20
> > A lot of these macros seem double indented.
>=20
> In a case you pointed out in the preceding patch, I was just keeping the
> arguments column aligned.
>=20
> In this case I am just indenting two tabs for a line continuation. I
> thought I found other instances in the kernel that did this early on
> (and that's also what the Linux kernel vim plugin wanted me to do).
> After a couple of spot checks, it seems like one tab for this kind of
> line continuation seems more common. I personally don't feel strongly
> about any particular version. I just want to know now what the correct
> indentation is for macros before I go through and change them all.
>=20
> I think there are three cases:
>=20
> #define macro0(param0, param1) \
>                 a_really_long_macro(...)
>=20
> In this first case, I use two tabs for the first indent, I think you are
> telling me this should be one tab.

Yes. Should be one.

>=20
> #define macro1(param0, param1) {                                         =
      \
>         statement_in_a_block0;                                           =
      \
>         statement_in_a_block1;                                           =
      \
>         ...                                                              =
      \
> }
>=20
> In this case, every line is in a block and is indented as it would be in
> a function body. I think you are okay with this, and now that I am
> thinking about it, what I think you are proposing for macro0 will make
> these two cases more consistent.
>=20
> #define macro2(param0,                                                   =
      \
>                param1,                                                   =
      \
>                param2,                                                   =
      \
>                param3,                                                   =
      \
>                ...,                                                      =
      \
>                paramn) ...                                               =
      \
>=20
> In this last case, the body would be indented as in macro0, or macro1,
> but the parameters passed into the macro are column aligned, consistent
> with one of the acceptable ways of formatting function parameters that
> don't fit on a single line.
>=20
> In all cases, I put 1 space in between the closing parameter paren and
> the line continuation `\`, if only one `\` is needed. Otherwise, I align
> all the `\s` to the 80th column. Is this okay, or would you prefer that
> I align them all to the 80th column, or something else?
>=20

This all sounds fine and I'm not nitpicking this style. Just the double
tabs making lines longer than required.

