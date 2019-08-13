Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B48AE43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 06:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfHME5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 00:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHME5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:57:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF0A206C2;
        Tue, 13 Aug 2019 04:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565672267;
        bh=DYjr3iNqzIZZG76leV1s359ko+TvTUQm8spLagGHMHw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BTwdTrkEp8drYKqfL8D9Ky5nkPDptSWvvGIAlm2zBb2UDU+0TVgv2y5RV+T+uAhfY
         tWPKzKIXLNFpV9AmAXD2trHaopP6q/JkL76VTk8Nk5HLsR0pl5LlSlCExSkq+YZ59Z
         pYb/52F6++Rtk7YAqglHez91WgCEV0yvDG9bHKxs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-5-brendanhiggins@google.com> <20190812234644.E054D20679@mail.kernel.org> <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com> <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
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
To:     Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date:   Mon, 12 Aug 2019 21:57:46 -0700
Message-Id: <20190813045747.3AF0A206C2@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-12 21:27:05)
> On Mon, Aug 12, 2019 at 4:56 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-08-12 11:24:07)
> > > > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {               =
            \
> > > > +               .assert =3D KUNIT_INIT_ASSERT_STRUCT(test,         =
              \
> > > > +                                                  type,           =
            \
> > > > +                                                  kunit_fail_asser=
t_format)   \
> > >
> > > This one got indented one too many times?
> >
> > Not unless I have been using the wrong formatting for multiline
> > macros. You can see this commit applied here:
> > https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef=
408e52df/include/kunit/assert.h#59
> >
> > I have test, type, and kunit_fail_assert_format all column aligned (it
> > just doesn't render nicely in the patch format).
>=20
> Disregard that last comment. I just looked at the line immediately
> above your comment and thought it looked correct. Sorry about that
> (you were pointing out that the .assert line looked wrong, correct?).

Yes. .assert is double tabbed?

