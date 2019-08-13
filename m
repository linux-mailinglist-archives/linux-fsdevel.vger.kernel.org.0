Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFCB8B16E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfHMHwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 03:52:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfHMHwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:52:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so2835392pfc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRTz9Xji1GnKtiBfvHtH9s0qQk1TmYlPxSNoKQScUSU=;
        b=d9yKr6zAnRu5DLLhnVYGTN713jhVE7qQb/8wlQF/PDbGT/kyDXdm8ubBG3qPavV6nZ
         u8/FB1rvN8wMU0yFPzjHRFBN1hKKU7wA/8PY9ud7efhPQJtWF8cp3djkdljM/WA8V8gm
         bqlhiw6x+7V27woDkusatGNHK7XmvCHrSVdLLnEw0A9+0fZm3mPG7SlHF0PJ/Lupaifz
         L71DVEtMYTgQuS82s2biq6SM/r1tk7PeT+IKYJss0dEuDaiJyvwR70N87LLGLnE/iHvq
         az6JJK9ulszSFJIw00Tx/0ArednhKrhXSaivVF1sQb8YUpZB4etPZYKA7SF43FRjwDOA
         SQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRTz9Xji1GnKtiBfvHtH9s0qQk1TmYlPxSNoKQScUSU=;
        b=aG/BK3UIbuBcI3Lt/c3o9pa5LzZkgx/yCmw/bnIMIVB3pz45nCraSLtsOQ+oMip6cy
         H44i8GBNsbZNUtzX2DGsCfWTwnu7IAMZ6pei8nnjap9wdyZ09JVBiJZa74aXqp9TrOis
         MapoGmktZ8PQ/aFQuJUhPTkqlxJs6XXLO2zbSZ0v4ErIyhk6bndIgCaeJq4WX4LeYbg1
         /SCaR3d7cmxrgehhI8nWh5IVx1OOjOBj0aREtZUryMsxgIP3kguDXaiE3r/SdqxMaTl7
         eu/cU4IRLBDPJEYGps9/lkmp/8MqWZHkjqoga0TO8zgU0Hb57zpuZcRE6DA5muXzRC2Y
         bZXQ==
X-Gm-Message-State: APjAAAWmkILlRP5PkfooZAxlAjR9WvMXaletF2+JlLUNtVgxsrT04zwl
        VWlBBOcDsbQ9o3dITbryjHVlyfAOT5V2qyC+mYpn0w==
X-Google-Smtp-Source: APXvYqyGp5FRBIbLsTLczd2XTjqdRRlw2nloNXwwo2pdocKRPV3RlOKTfDT9Lww7NrP1xso9VQHgOv3E8oAazxyso+4=
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr10342747pfr.113.1565682734344;
 Tue, 13 Aug 2019 00:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-10-brendanhiggins@google.com> <20190813042159.46814206C2@mail.kernel.org>
 <CAFd5g44XyQi-oprPcdgx-EPboQYaHY6Ocz8Te6NX2SxV=mVhQA@mail.gmail.com> <20190813055615.CA787206C2@mail.kernel.org>
In-Reply-To: <20190813055615.CA787206C2@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Aug 2019 00:52:03 -0700
Message-ID: <CAFd5g4415URtJBKPhsEw98GxiExJr-fstW6SQ6nmV9ts9ggK-g@mail.gmail.com>
Subject: Re: [PATCH v12 09/18] kunit: test: add support for test abort
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
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

On Mon, Aug 12, 2019 at 10:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 21:57:55)
> > On Mon, Aug 12, 2019 at 9:22 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-08-12 11:24:12)
> > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > index 2625bcfeb19ac..93381f841e09f 100644
> > > > --- a/include/kunit/test.h
> > > > +++ b/include/kunit/test.h
> > > > @@ -176,6 +178,11 @@ struct kunit {
> > > >          */
> > > >         bool success; /* Read only after test_case finishes! */
> > > >         spinlock_t lock; /* Gaurds all mutable test state. */
> > > > +       /*
> > > > +        * death_test may be both set and unset from multiple threads in a test
> > > > +        * case.
> > > > +        */
> > > > +       bool death_test; /* Protected by lock. */
> > > >         /*
> > > >          * Because resources is a list that may be updated multiple times (with
> > > >          * new resources) from any thread associated with a test case, we must
> > > > @@ -184,6 +191,13 @@ struct kunit {
> > > >         struct list_head resources; /* Protected by lock. */
> > > >  };
> > > >
> > > > +static inline void kunit_set_death_test(struct kunit *test, bool death_test)
> > > > +{
> > > > +       spin_lock(&test->lock);
> > > > +       test->death_test = death_test;
> > > > +       spin_unlock(&test->lock);
> > > > +}
> > >
> > > These getters and setters are using spinlocks again. It doesn't make any
> > > sense. It probably needs a rework like was done for the other bool
> > > member, success.
> >
> > No, this is intentional. death_test can transition from false to true
> > and then back to false within the same test. Maybe that deserves a
> > comment?
>
> Yes. How does it transition from true to false again?

The purpose is to tell try_catch that it was expected for the test to
bail out. Given the default implementation there is no way for this to
happen aside from abort() being called, but in some implementations it
is possible to implement a fault catcher which allows a test suite to
recover from an unexpected failure.

Maybe it would be best to drop this until I add one of those
alternative implementations.

> Either way, having a spinlock around a read/write API doesn't make sense
> because it just makes sure that two writes don't overlap, but otherwise
> does nothing to keep things synchronized. For example a set to true
> after a set to false when the two calls to set true or false aren't
> synchronized means they can happen in any order. So I don't see how it
> needs a spinlock. The lock needs to be one level higher.

There shouldn't be any cases where one thread is trying to set it
while another is trying to unset it. The thing I am worried about here
is making sure all the cores see the write, and making sure no reads
or writes get reordered before it. So I guess I just want a fence. So
I take it I should probably have is a WRITE_ONCE here and READ_ONCE in
the getter?

> >
> > > > +
> > > >  void kunit_init_test(struct kunit *test, const char *name);
> > > >
> > > >  int kunit_run_tests(struct kunit_suite *suite);
> > > > diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
> > > > new file mode 100644
> > > > index 0000000000000..8a414a9af0b64
> > > > --- /dev/null
> > > > +++ b/include/kunit/try-catch.h
> [...]
> > > > +
> > > > +/*
> > > > + * struct kunit_try_catch - provides a generic way to run code which might fail.
> > > > + * @context: used to pass user data to the try and catch functions.
> > > > + *
> > > > + * kunit_try_catch provides a generic, architecture independent way to execute
> > > > + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
> > > > + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
> > > > + * is stopped at the site of invocation and @catch is catch is called.
> > > > + *
> > > > + * struct kunit_try_catch provides a generic interface for the functionality
> > > > + * needed to implement kunit->abort() which in turn is needed for implementing
> > > > + * assertions. Assertions allow stating a precondition for a test simplifying
> > > > + * how test cases are written and presented.
> > > > + *
> > > > + * Assertions are like expectations, except they abort (call
> > > > + * kunit_try_catch_throw()) when the specified condition is not met. This is
> > > > + * useful when you look at a test case as a logical statement about some piece
> > > > + * of code, where assertions are the premises for the test case, and the
> > > > + * conclusion is a set of predicates, rather expectations, that must all be
> > > > + * true. If your premises are violated, it does not makes sense to continue.
> > > > + */
> > > > +struct kunit_try_catch {
> > > > +       /* private: internal use only. */
> > > > +       struct kunit *test;
> > > > +       struct completion *try_completion;
> > > > +       int try_result;
> > > > +       kunit_try_catch_func_t try;
> > > > +       kunit_try_catch_func_t catch;
> > >
> > > Can these other variables be documented in the kernel doc? And should
> > > context be marked as 'public'?
> >
> > Sure, I can document them.
> >
> > But I don't think context should be public; it should only be accessed
> > by kunit_try_catch_* functions. context should only be populated by
> > *_init, and will be passed into *try and *catch when they are called
> > internally.
>
> Ok. Then I guess just document them all but keep them all marked as
> private.

Will do.

> >
> > > > + */
> > > > +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
> > > > +
> > > > +#endif /* _KUNIT_TRY_CATCH_H */
> > > > diff --git a/kunit/test.c b/kunit/test.c
> > > > index e5080a2c6b29c..995cb53fe4ee9 100644
> > > > --- a/kunit/test.c
> > > > +++ b/kunit/test.c
> > > > @@ -158,6 +171,21 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> > > >         kunit_print_string_stream(test, stream);
> > > >  }
> > > >
> > > > +void __noreturn kunit_abort(struct kunit *test)
> > > > +{
> > > > +       kunit_set_death_test(test, true);
> > > > +
> > > > +       kunit_try_catch_throw(&test->try_catch);
> > > > +
> > > > +       /*
> > > > +        * Throw could not abort from test.
> > > > +        *
> > > > +        * XXX: we should never reach this line! As kunit_try_catch_throw is
> > > > +        * marked __noreturn.
> > > > +        */
> > > > +       WARN_ONCE(true, "Throw could not abort from test!\n");
> > >
> > > Should this just be a BUG_ON? It's supposedly impossible.
> >
> > It should be impossible; it will only reach this line if there is a
> > bug in kunit_try_catch_throw. The reason I didn't use BUG_ON was
> > because I previously got yelled at for having BUG_ON in this code
> > path.
> >
> > Nevertheless, I think BUG_ON is more correct, so if you will stand by
> > it, then that's what I will do.
>
> Yeah BUG_ON is appropriate here and self documenting so please use it.

Cool, will do.

> >
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       if (kunit_get_death_test(test)) {
> > > > +               /*
> > > > +                * EXPECTED DEATH: kunit_run_case_internal encountered
> > > > +                * anticipated fatal error. Everything should be in a safe
> > > > +                * state.
> > > > +                */
> > > > +               kunit_run_case_cleanup(test, suite);
> > > > +       } else {
> > > > +               /*
> > > > +                * UNEXPECTED DEATH: kunit_run_case_internal encountered an
> > > > +                * unanticipated fatal error. We have no idea what the state of
> > > > +                * the test case is in.
> > > > +                */
> > > > +               kunit_handle_test_crash(test, suite, test_case);
> > > > +               kunit_set_failure(test);
> > >
> > > Like was done here.
> >
> > Sorry, like what?
>
> Just saying this has braces for the if-else.

Ah, gotcha.
