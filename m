Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE38BF43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHMRGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 13:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfHMRGa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:06:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B0912067D;
        Tue, 13 Aug 2019 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565715988;
        bh=mXleQo1BfGDF4Gvt8gwvemAiKY2B7AKwDPdsZQzGEig=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2YP/hufKMPeHV9Iqtm97Hg+EE9Q7yk3dpGfTYo+YIFuTd+znybtuf6QsdhYKGv2OL
         bffgiZjbx8+MzDPbg9zNDOCLOmmjE13s1gxUgB6nndEdwsA+9gYRAddFBIlqnsF3wh
         t+HdplopKKhd7nK05G6fCJXNmNCfRN1TXzWpMoO0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g4415URtJBKPhsEw98GxiExJr-fstW6SQ6nmV9ts9ggK-g@mail.gmail.com>
References: <20190812182421.141150-1-brendanhiggins@google.com> <20190812182421.141150-10-brendanhiggins@google.com> <20190813042159.46814206C2@mail.kernel.org> <CAFd5g44XyQi-oprPcdgx-EPboQYaHY6Ocz8Te6NX2SxV=mVhQA@mail.gmail.com> <20190813055615.CA787206C2@mail.kernel.org> <CAFd5g4415URtJBKPhsEw98GxiExJr-fstW6SQ6nmV9ts9ggK-g@mail.gmail.com>
Subject: Re: [PATCH v12 09/18] kunit: test: add support for test abort
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
Date:   Tue, 13 Aug 2019 10:06:27 -0700
Message-Id: <20190813170628.9B0912067D@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-08-13 00:52:03)
> On Mon, Aug 12, 2019 at 10:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-08-12 21:57:55)
> > > On Mon, Aug 12, 2019 at 9:22 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-08-12 11:24:12)
> > > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > > index 2625bcfeb19ac..93381f841e09f 100644
> > > > > --- a/include/kunit/test.h
> > > > > +++ b/include/kunit/test.h
> > > > > @@ -184,6 +191,13 @@ struct kunit {
> > > > >         struct list_head resources; /* Protected by lock. */
> > > > >  };
> > > > >
> > > > > +static inline void kunit_set_death_test(struct kunit *test, bool=
 death_test)
> > > > > +{
> > > > > +       spin_lock(&test->lock);
> > > > > +       test->death_test =3D death_test;
> > > > > +       spin_unlock(&test->lock);
> > > > > +}
> > > >
> > > > These getters and setters are using spinlocks again. It doesn't mak=
e any
> > > > sense. It probably needs a rework like was done for the other bool
> > > > member, success.
> > >
> > > No, this is intentional. death_test can transition from false to true
> > > and then back to false within the same test. Maybe that deserves a
> > > comment?
> >
> > Yes. How does it transition from true to false again?
>=20
> The purpose is to tell try_catch that it was expected for the test to
> bail out. Given the default implementation there is no way for this to
> happen aside from abort() being called, but in some implementations it
> is possible to implement a fault catcher which allows a test suite to
> recover from an unexpected failure.
>=20
> Maybe it would be best to drop this until I add one of those
> alternative implementations.

Ok.

>=20
> > Either way, having a spinlock around a read/write API doesn't make sense
> > because it just makes sure that two writes don't overlap, but otherwise
> > does nothing to keep things synchronized. For example a set to true
> > after a set to false when the two calls to set true or false aren't
> > synchronized means they can happen in any order. So I don't see how it
> > needs a spinlock. The lock needs to be one level higher.
>=20
> There shouldn't be any cases where one thread is trying to set it
> while another is trying to unset it. The thing I am worried about here
> is making sure all the cores see the write, and making sure no reads
> or writes get reordered before it. So I guess I just want a fence. So
> I take it I should probably have is a WRITE_ONCE here and READ_ONCE in
> the getter?
>=20

Are the gets and sets in program order? If so, WRITE_ONCE and READ_ONCE
aren't required. Otherwise, if it's possible for one thread to write it
and another to read it but the threads are ordered with some other
barrier like a completion or lock, then again the macros aren't needed.
It would be good to read memory-barriers.txt to understand when to use
the read/write macros.

