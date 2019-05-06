Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900D6146B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 10:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFIs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 04:48:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37731 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFIsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 04:48:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id 143so8964758oii.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeIMthOxRJANSArvv5AObvGzpm/HBsUqmQ+gWt5K6h4=;
        b=EnO7STvybywxQ2wAHAyVtfRt84WqWHo207o6kKVYZqrOG/ThSPPoSiv9GKUUU6krNY
         ZPKR5EsUOem3trEr0yMncM+DcCpGDrZ0FDCeazMNQyv2Pd5e5dQ6QhqISngWLdNZe7mc
         eawHIqLnKoEL5GaC7a/wL78gStXrV93eaNw5LiiwdvjwLuumdactPs7Xo+O1nOLBrCoI
         q7RNn20cdCpK2RkkKmjieZ4bqnI6tlUECZmK1Q2Q7GxKkiiHbNI+h1D6YkpszJ0eKle6
         VcM9pzRThTNiXpbPMDpK9Er1S78DZpzSLNHj1u5T0r9XUmsbM0Jw6UaKS//SSn1+WQji
         72ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeIMthOxRJANSArvv5AObvGzpm/HBsUqmQ+gWt5K6h4=;
        b=jHSA4do2uAdMPois8L/AbXOoKx1m/qy46/yhOa+2pfnPJ009D2pm0Z9tBwUQ/1j3zO
         JMtLS3+7mjrS6ROTDaVTiTwKPA0Z1LQ6Zqh3Rlm4aEO4EL4aU5VBvJuPyfUzlafnkz2s
         KvxMvRmqh/jDESkz1aOsbhF/M56QOV5DJSpVU3pJ5om9/nVUtVAVhFNH8wHWf6UG3B5g
         FMwDMzC+a8C5gpdfsrCd4Yw81fJxRYJ6G1vWhSqRYDvKKlHsReVpMqRo95p7T1frK8kd
         Mjs6SaMVLR41JtlAnJRnYzKNe14ljNv7rJbZCwYSTaxv2PZ6AKHIc0rPBDC2pCwCpISq
         zMsQ==
X-Gm-Message-State: APjAAAVsg7Rcmi51cahfLtNnPQN3ioLCCSYfV0UDzhlRfJDbwJAkYpQ3
        9Tihj4nEGnHnQctzubOHQ3eZUEjq8qp+cMux3k1+Rg==
X-Google-Smtp-Source: APXvYqwzZvfW7/3beZRJaVyn8GceHPah5zWKYDYxiPS3rsvYlVs7eDDRovZxwZa4HjwEUc1S/sOaEWJ7E7OBNja8JRU=
X-Received: by 2002:aca:a84d:: with SMTP id r74mr402573oie.44.1557132501212;
 Mon, 06 May 2019 01:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-9-brendanhiggins@google.com> <0a605543-477a-1854-eb35-6e586606889b@deltatee.com>
 <CAFd5g47hxAd=+72xbPJbWPdZCXRXmtLpsGhUh=zc7MSwfcaGJQ@mail.gmail.com> <b2379db6-634a-001e-6f67-37427d8a2666@deltatee.com>
In-Reply-To: <b2379db6-634a-001e-6f67-37427d8a2666@deltatee.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 6 May 2019 01:48:09 -0700
Message-ID: <CAFd5g47LzBfE8J-rCgd4TU_P_=iwbctgeOMM9JZFDN8ZK6R7iw@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] kunit: test: add support for test abort
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 5:33 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-05-03 12:48 a.m., Brendan Higgins wrote:
> > On Thu, May 2, 2019 at 8:15 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >> On 2019-05-01 5:01 p.m., Brendan Higgins wrote:
> >>> +/*
> >>> + * struct kunit_try_catch - provides a generic way to run code which might fail.
> >>> + * @context: used to pass user data to the try and catch functions.
> >>> + *
> >>> + * kunit_try_catch provides a generic, architecture independent way to execute
> >>> + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
> >>> + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
> >>> + * is stopped at the site of invocation and @catch is catch is called.
> >>
> >> I found some of the C++ comparisons in this series a bit distasteful but
> >> wasn't going to say anything until I saw the try catch.... But looking
> >> into the implementation it's just a thread that can exit early which
> >> seems fine to me. Just a poor choice of name I guess...
> >
> > Guilty as charged (I have a long history with C++, sorry). Would you
> > prefer I changed the name? I just figured that try-catch is a commonly
> > understood pattern that describes exactly what I am doing.
>
> It is a commonly understood pattern, but I don't think it's what the
> code is doing. Try-catch cleans up an entire stack and allows each level
> of the stack to apply local cleanup. This implementation simply exits a
> thread and has none of that complexity. To me, it seems like an odd
> abstraction here as it's really just a test runner that can exit early
> (though I haven't seen the follow-up UML implementation).

Yeah, that is closer to what the UML specific version does, but that's
a conversation for another time.

>
> I would prefer to see this cleaned up such that the abstraction matches
> more what's going on but I don't feel that strongly about it so I'll
> leave it up to you to figure out what's best unless other reviewers have
> stronger opinions.

Cool. Let's revisit this with the follow-up patchset.

>
> >>
> >> [snip]
> >>
> >>> +static void __noreturn kunit_abort(struct kunit *test)
> >>> +{
> >>> +     kunit_set_death_test(test, true);
> >>> +
> >>> +     kunit_try_catch_throw(&test->try_catch);
> >>> +
> >>> +     /*
> >>> +      * Throw could not abort from test.
> >>> +      *
> >>> +      * XXX: we should never reach this line! As kunit_try_catch_throw is
> >>> +      * marked __noreturn.
> >>> +      */
> >>> +     WARN_ONCE(true, "Throw could not abort from test!\n");
> >>> +}
> >>> +
> >>>  int kunit_init_test(struct kunit *test, const char *name)
> >>>  {
> >>>       spin_lock_init(&test->lock);
> >>> @@ -77,6 +103,7 @@ int kunit_init_test(struct kunit *test, const char *name)
> >>>       test->name = name;
> >>>       test->vprintk = kunit_vprintk;
> >>>       test->fail = kunit_fail;
> >>> +     test->abort = kunit_abort;
> >>
> >> There are a number of these function pointers which seem to be pointless
> >> to me as you only ever set them to one function. Just call the function
> >> directly. As it is, it is an unnecessary indirection for someone reading
> >> the code. If and when you have multiple implementations of the function
> >> then add the pointer. Don't assume you're going to need it later on and
> >> add all this maintenance burden if you never use it..
> >
> > Ah, yes, Frank (and probably others) previously asked me to remove
> > unnecessary method pointers; I removed all the totally unused ones. As
> > for these, I don't use them in this patchset, but I use them in my
> > patchsets that will follow up this one. These in particular are
> > present so that they can be mocked out for testing.
>
> Adding indirection and function pointers solely for the purpose of
> mocking out while testing doesn't sit well with me and I don't think it
> should be a pattern that's encouraged. Adding extra complexity like this
> to a design to make it unit-testable doesn't seem like something that
> makes sense in kernel code. Especially given that indirect calls are
> more expensive in the age of spectre.

Indirection is a pretty common method to make something mockable or
fakeable. Nevertheless, probably an easier discussion to have once we
have some examples to discuss.

>
> Also, mocking these particular functions seems like it's an artifact of
> how you've designed the try/catch abstraction. If the abstraction was
> more around an abort-able test runner then it doesn't make sense to need
> to mock out the abort/fail functions as you will be testing overly
> generic features of something that don't seem necessary to the
> implementation.
>
> >>
> >> [snip]
> >>
> >>> +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> >>> +{
> >>> +     try_catch->run = kunit_generic_run_try_catch;
> >>> +     try_catch->throw = kunit_generic_throw;
> >>> +}
> >>
> >> Same here. There's only one implementation of try_catch and I can't
> >> really see any sensible justification for another implementation. Even
> >> if there is, add the indirection when the second implementation is
> >> added. This isn't C++ and we don't need to make everything a "method".
> >
> > These methods are for a UML specific implementation in a follow up
> > patchset, which is needed for some features like crash recovery, death
> > tests, and removes dependence on kthreads.
> >
> > I know this probably sounds like premature complexity. Arguably it is
> > in hindsight, but I wrote those features before I pulled out these
> > interfaces (they were actually both originally in this patchset, but I
> > dropped them to make this patchset easier to review). I can remove
> > these methods and add them back in when I actually use them in the
> > follow up patchsets if you prefer.
>
> Yes, remove them now and add them back when you use them in follow-up
> patches. If reviewers find problems with the follow-up patches or have a
> better suggestion on how to do what ever it is you are doing, then you
> just have this unnecessary code and there's wasted developer time and
> review bandwidth that will need to be spent cleaning it up.

Fair enough. Next patchset will have the remaining unused indirection
you pointed out removed.

Thanks!
