Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4569C589A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfF0SQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 14:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfF0SQi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:16:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA752064A;
        Thu, 27 Jun 2019 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659396;
        bh=2oWUiLUFI+CqOolaOKVa4jJ21rR9UR/fuLhE4nLYjdw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=zM1PuCQOlI4msEkFixz730kc8/zFbvwJnRkqkjMyx+3IZ/8lQrJkX5bjK8+tcjTpD
         9YTsqw4mLY9MvEtPAy8WslYPIgMqfSsLuNDFSuTYyeTtiNsbbEN2c2e7JVMq1S+AoJ
         JJirWvQWTUXBy4OsdUUrOSg+eULRykDPesnCIHuI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
References: <20190617082613.109131-1-brendanhiggins@google.com> <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org> <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com> <20190626034100.B238520883@mail.kernel.org> <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
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
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:16:35 -0700
Message-Id: <20190627181636.5EA752064A@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-06-26 16:00:40)
> On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > scenario like below, but where it is a problem. There could be three
> > CPUs, or even one CPU and three threads if you want to describe the
> > extra thread scenario.
> >
> > Here's my scenario where it isn't needed:
> >
> >     CPU0                                      CPU1
> >     ----                                      ----
> >     kunit_run_test(&test)
> >                                               test_case_func()
> >                                                 ....
> >                                               [mock hardirq]
> >                                                 kunit_set_success(&test)
> >                                               [hardirq ends]
> >                                                 ...
> >                                                 complete(&test_done)
> >       wait_for_completion(&test_done)
> >       kunit_get_success(&test)
> >
> > We don't need to care about having locking here because success or
> > failure only happens in one place and it's synchronized with the
> > completion.
>=20
> Here is the scenario I am concerned about:
>=20
> CPU0                      CPU1                       CPU2
> ----                      ----                       ----
> kunit_run_test(&test)
>                           test_case_func()
>                             ....
>                             schedule_work(foo_func)
>                           [mock hardirq]             foo_func()
>                             ...                        ...
>                             kunit_set_success(false)   kunit_set_success(=
false)
>                           [hardirq ends]               ...
>                             ...
>                             complete(&test_done)
>   wait_for_completion(...)
>   kunit_get_success(&test)
>=20
> In my scenario, since both CPU1 and CPU2 update the success status of
> the test simultaneously, even though they are setting it to the same
> value. If my understanding is correct, this could result in a
> write-tear on some architectures in some circumstances. I suppose we
> could just make it an atomic boolean, but I figured locking is also
> fine, and generally preferred.

This is what we have WRITE_ONCE() and READ_ONCE() for. Maybe you could
just use that in the getter and setters and remove the lock if it isn't
used for anything else.

It may also be a good idea to have a kunit_fail_test() API that fails
the test passed in with a WRITE_ONCE(false). Otherwise, the test is
assumed successful and it isn't even possible for a test to change the
state from failure to success due to a logical error because the API
isn't available. Then we don't really need to have a generic
kunit_set_success() function at all. We could have a kunit_test_failed()
function too that replaces the kunit_get_success() function. That would
read better in an if condition.

>=20
> Also, to be clear, I am onboard with dropping then IRQ stuff for now.
> I am fine moving to a mutex for the time being.
>=20

Ok.

