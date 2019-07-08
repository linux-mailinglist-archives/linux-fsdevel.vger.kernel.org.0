Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DC627F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfGHSIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 14:08:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37953 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbfGHSIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:08:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so7981386pfn.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl4l3gaXCZ0Civm5i1pNfvFYe/9qjH5f6pxejgr6AT8=;
        b=SmOjZWgQtja4PiBSvkc/DsaRuuY8KuEdsMMIKFu//v+ppa1NV5GwqJ4JU08u4uuqXU
         KBGOdoVwwU+z3nPB5Yc7Nj2ei2N1Y2sszCQi7aydqX+v1bs0R5WVY9VfrLuAxD0X22yO
         et4/wVXqTEuA8XKb8I+GG2Cy0aB5wgbYiiI9zkmmG0P1bXmqCbs0GEYAywdf8m69uDNv
         i3LNyALK0qO5EHrEqLLK7h1Y4PRr0CfVpj56uFuOU19A9ib63eiTFseAJoBv3geF+XdI
         Ex1jzjCOgerKv5XAy3Zhbk2qyoHk/ecWgRcxMQ7auZjG3EZDzZIqKZ+9SL7kyLXtMMIf
         MRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl4l3gaXCZ0Civm5i1pNfvFYe/9qjH5f6pxejgr6AT8=;
        b=G4W96/pJwHOpRTAUMuYUxnzKzrOsNEEB7KoigQb97fL8tYU4/WJEJWIDSPr+R+jW5K
         tvO1+QpVg7zkQjxJ3sj1ozsQyq3AIoIuMskuf1Z9GOm5/sVewKFTl9qLxNRXXR1SwnOB
         NBn63sOlfC/0ShM+6FPYPG5Ydocvd8f5o9sHR8gDvoBR9BFjrEKuyU2dzKdC+hkDGbWH
         yMr1PbngaA5rUCzaoVOYyEQMWmZaG6o1nyYwgXdOv/90BSdXcvmF0kzYo07uPE+i1lE0
         +9q3yf7WFPBsbuqyr9lqcsRSTpLvd7J0rtzbkqqzhXob/eUnDnYC/XDZJgd2/XAHpAGO
         st4g==
X-Gm-Message-State: APjAAAV658kEz14+SIc/EGzQEtOfGM/QszNX+YHZVr5GUjkNPTT+uPwN
        n9tq8R2OJMbcFMzFp/NRXXjFt25fspSPl2dPrPDZfA==
X-Google-Smtp-Source: APXvYqwoLoh11AGLeVf5uSZhLWgN1V0Lf0IPFYJElvqds2Mjg+FKGEtSZZdm1FCZKhiAeE2kYC6jZBxFraVmnG074HI=
X-Received: by 2002:a63:b919:: with SMTP id z25mr25337810pge.201.1562609318390;
 Mon, 08 Jul 2019 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com> <20190705201505.GA19023@42.do-not-panic.com>
In-Reply-To: <20190705201505.GA19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 8 Jul 2019 11:08:27 -0700
Message-ID: <CAFd5g45cF9rYc8YupnCgd=7xz_yW+_TMp_L+cSFUBW7d9njnVQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 5, 2019 at 1:15 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> > Add core facilities for defining unit tests; this provides a common way
> > to define test cases, functions that execute code which is under test
> > and determine whether the code under test behaves as expected; this also
> > provides a way to group together related test cases in test suites (here
> > we call them test_modules).
> >
> > Just define test cases and how to execute them for now; setting
> > expectations on code will be defined later.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
> But a nitpick below, I think that can be fixed later with a follow up
> patch.
>
> > +/**
> > + * struct kunit - represents a running instance of a test.
> > + * @priv: for user to store arbitrary data. Commonly used to pass data created
> > + * in the init function (see &struct kunit_suite).
> > + *
> > + * Used to store information about the current context under which the test is
> > + * running. Most of this data is private and should only be accessed indirectly
> > + * via public functions; the one exception is @priv which can be used by the
> > + * test writer to store arbitrary data.
> > + *
> > + * A brief note on locking:
> > + *
> > + * First off, we need to lock because in certain cases a user may want to use an
> > + * expectation in a thread other than the thread that the test case is running
> > + * in.
>
> This as a prefix to the struct without a lock seems odd. It would be
> clearer I think if you'd explain here what locking mechanism we decided
> to use and why it suffices today.

Whoops, sorry this should have been in the next patch. Will fix.

> > +/**
> > + * suite_test() - used to register a &struct kunit_suite with KUnit.
>
> You mean kunit_test_suite()?

Yep, sorry about that. Will fix.

> > + * @suite: a statically allocated &struct kunit_suite.
> > + *
> > + * Registers @suite with the test framework. See &struct kunit_suite for more
> > + * information.
> > + *
> > + * NOTE: Currently KUnit tests are all run as late_initcalls; this means that
> > + * they cannot test anything where tests must run at a different init phase. One
> > + * significant restriction resulting from this is that KUnit cannot reliably
> > + * test anything that is initialize in the late_init phase.
>                             initialize prior to the late init phase.
>
>
> That is, this is useless to test things running early.

Yeah, I can add that phrasing in.

> > + *
> > + * TODO(brendanhiggins@google.com): Don't run all KUnit tests as late_initcalls.
> > + * I have some future work planned to dispatch all KUnit tests from the same
> > + * place, and at the very least to do so after everything else is definitely
> > + * initialized.
>
> TODOs are odd to be adding to documentation, this is just not common
> place practice. The NOTE should suffice for you.

Because it is a kernel doc? Would you usually make a separate
non-kernel doc comment for a TODO? I guess that makes sense.

Thanks!
