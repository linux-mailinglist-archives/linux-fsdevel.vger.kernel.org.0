Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2173DBD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406496AbfFKU3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 16:29:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41949 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406271AbfFKU3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:29:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so7585037pgg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2019 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhnwSrdCPnvzoEVfuuVGqE83p7TnkQ5Modn2BNCoQD0=;
        b=Pp0Hq+hd8QA6syECahlCWtYv82jhOxBm0sr+fZ9Dkk8nXtHe7nrSiSj+V8u0FaITQ7
         84fXuzNXkrhzDQgkHPp26EjnsIzrDKXg48+xvOTrPv1gFdJxgRLOvcs0dwgoU2BGvzqE
         Liz3+gL3rcT7wqBUJosubNY4aHZAru2eeUFG6CtPZ2mbKIzTjquHFKUIQcWXvVk4hMLI
         7UB1amIr3aRGarnBUHse/35CwxBlRRF3qifo7BnhaOJV61RWbVqr0wA4GIowlDaA6gfT
         pWINRb5VwbD/mtNfms9GrZfwha/4G8tSCCTtYnHFhjTrLaOGAdTroClIT1QeFCWuqloy
         NJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhnwSrdCPnvzoEVfuuVGqE83p7TnkQ5Modn2BNCoQD0=;
        b=klri8P0n5+Ao0+2XkKiRL4uN4/yGjNSA8IwlMiURpEe7Fm1Uw6LIGYNXBIHE309ceh
         ASeqyiuB1zwBNgiSKYVcqV72Fz3weLfrV7dN7zhFFz2KAMBtmXbQcQZCZJIC++sjemDk
         Da/OZrLDhilqwQBHf53oC4FrTLneTYs2XIJF5FbUG8MQiQ8EiIAQPy4aRT8EsMoh4tSi
         S36WVBo7tR7iP95J2xq3f3ZmNuPAG9LgFt6Wg3X02S18bIz+lrp0IoB0fkQVH+ZPuSpG
         q2KojsKEyldgKdNX1Zpcw0vZCpG75mkmz6MnXVqe81CSX2CDXylfpFnk7EnZJm6JY99T
         OaTQ==
X-Gm-Message-State: APjAAAWcPQSQhKdUqF8zaLtQE/kceK0dk/Oq2lWjSg1wYiHPn61Fi2Yd
        QypVu/E1kpbQuhOiPTmF8osYdOrnnsubot0WMQy5eA==
X-Google-Smtp-Source: APXvYqycBtJ32qbIn8pTyxMIAID5Xv7JTruAR7oTyIED4r622bu9rIlLgVdk0eekxjLa2OE4wVYL1Pw8y64Cqw0kRwU=
X-Received: by 2002:a17:90a:2e89:: with SMTP id r9mr28553830pjd.117.1560284952085;
 Tue, 11 Jun 2019 13:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com> <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
 <20190607190047.C3E7A20868@mail.kernel.org> <20190611175830.GA236872@google.com>
 <20190611185018.2E1C021744@mail.kernel.org>
In-Reply-To: <20190611185018.2E1C021744@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jun 2019 13:29:01 -0700
Message-ID: <CAFd5g47dmcHOCX41cr2v9Kaj3xa_5-PoqUPX_1=AoQLUG90NkQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
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

On Tue, Jun 11, 2019 at 11:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-11 10:58:30)
> > On Fri, Jun 07, 2019 at 12:00:47PM -0700, Stephen Boyd wrote:
> > > Quoting Iurii Zaikin (2019-06-05 18:29:42)
> > > > On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > > > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > > > > new file mode 100644
> > > > > > index 0000000000000..fe0f2bae66085
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/sysctl-test.c
> > > > > > +
> > > > > > +
> > > > > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > > > > +{
> > > > > > +       struct ctl_table table = {
> > > > > > +               .procname = "foo",
> > > > > > +               .data           = &test_data.int_0001,
> > > > > > +               .maxlen         = sizeof(int),
> > > > > > +               .mode           = 0644,
> > > > > > +               .proc_handler   = proc_dointvec,
> > > > > > +               .extra1         = &i_zero,
> > > > > > +               .extra2         = &i_one_hundred,
> > > > > > +       };
> > > > > > +       char input[] = "-9";
> > > > > > +       size_t len = sizeof(input) - 1;
> > > > > > +       loff_t pos = 0;
> > > > > > +
> > > > > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > > > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> > > > >
> > > > > Is the casting necessary? Or can the macro do a type coercion of the
> > > > > second parameter based on the first type?
> > > >  Data field is defined as void* so I believe casting is necessary to
> > > > dereference it as a pointer to an array of ints. I don't think the
> > > > macro should do any type coercion that == operator wouldn't do.
> > > >  I did change the cast to make it more clear that it's a pointer to an
> > > > array of ints being dereferenced.
> > >
> > > Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
> > > both sides and cause a build warning/error if the types aren't the same.
> > > This would be similar to our min/max macros that complain about
> > > mismatched types in the comparisons. Then if a test developer needs to
> > > convert one type or the other they could do so with a
> > > KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
> > > explicitly.
> >
> > Do you think it would be better to do a phony compare similar to how
> > min/max used to work prior to 4.17, or to use the new __typecheck(...)
> > macro? This might seem like a dumb question (and maybe it is), but Iurii
> > and I thought the former created an error message that was a bit easier
> > to understand, whereas __typecheck is obviously superior in terms of
> > code reuse.
> >
> > This is what we are thinking right now; if you don't have any complaints
> > I will squash it into the relevant commits on the next revision:
>
> Can you provide the difference in error messages and describe that in
> the commit text? The commit message is where you "sell" the patch, so
> being able to compare the tradeoff of having another macro to do type
> comparisons vs. reusing the one that's there in kernel.h would be useful
> to allay concerns that we're duplicating logic for better error
> messages.

Oh sorry, I didn't think too hard about the commit message since I
figured it would get split up and squashed into the existing commits.
I just wanted to get it out sooner to discuss this before I post the
next revision (probably later this week).

> Honestly, I'd prefer we just use the macros that we've developed in
> kernel.h to do comparisons here so that we can get code reuse, but more
> importantly so that we don't trip over problems that caused those macros
> to be created in the first place. If the error message is bad, perhaps
> that can be fixed with some sort of compiler directive to make the error
> message a little more useful, i.e. compiletime_warning() thrown into
> __typecheck() or something.

That's a good point. I have no qualms sticking with __typecheck(...)
for now; if we later feel that it is causing problems, we can always
fix it later by supplying our own warning in the manner you suggest.

Iurii, do you have any additional thoughts on this?

>
> > ---
> > From: Iurii Zaikin <yzaikin@google.com>
> >
> > Adds a warning message when comparing values of different types similar
> > to what min() / max() macros do.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
