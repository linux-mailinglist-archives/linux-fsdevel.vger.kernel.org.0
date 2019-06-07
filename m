Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B593988C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfFGWXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 18:23:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44277 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbfFGWXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:23:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so1321298pll.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2019 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OscIWC1H8BYVUTSTRMLtHcpa3RbQBWs93JhulNsk+jk=;
        b=kdR49OFNsFx7GSx/8YCa4OAXnuGm9wR3mA3FGM2j9z9kYOvNzqrt6gDMUmNTCF4V83
         UuY0GuaC7cU7suXulXpVOn5N4HicehNGLM2Gv1N1iXUCkOIxaL4tP0q7CFg3Zr0ELRoH
         c1K2fAfx/OZnoqY6EocLtP4K2Gyk7fJHcbAd5+nbSwsumoNC9uZdy1ZbqRPl2ZGb2KR0
         5790YANxN6yo4XDpToutn8HtDWJ9qc4x2RtxrkIe4yf2ys4A7CKPGFlNlR6vaeXcDbDI
         eCRkI67w15jEuFPGTFzQI8EIXARxKyvN1+GR9F9Qoev+vDDjbBqEj+ZoKNPmKxLF0J5U
         DgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OscIWC1H8BYVUTSTRMLtHcpa3RbQBWs93JhulNsk+jk=;
        b=NE/reW4zMT6zLK2yElP1iZV9+dxye8chP4TPWHftTsriXbzqeyTpuwq7YqMY5PRrBD
         RM3HsibZb2GmFc/4cKPl/fuajzF5zVGDGR2NUoqRtC6NbpIdSKsyNmHcS1jPIxOjiklo
         LaSXJOmRACg/DwajlBgzQEOWQFPhTx1xaOHHpGwh5nza2Wua8EJUKQJorcZ1vik0bprt
         hFtWIjyxJMREsrou3oAl+uKsxWU3VDiikmBYMVfJvWpfpijL3rAGZCpJ2B4huHjIo+AK
         ehB4U8yk+uz4EX4VgDnzBJiqxqvofGTDmFw2h16+NHA9XYAJJNt5NIC6khtgXxMd4vlp
         niDw==
X-Gm-Message-State: APjAAAXIqU2BKfV2IfnN04cHTeIexN5UhJdiVRTYdMttbIskv4qQnn5N
        pzcTFH1K8NxupkR9RIN8/C0fVzttRY4ANEI0T0PBGg==
X-Google-Smtp-Source: APXvYqxqRVfuyQEdyfJNNkPVX/y1rXYgnEMZVKj/CtJa0Fm8bihW1BebEYmymKIH0C8/tAoxb6DpKUorgA1wvW4QAXM=
X-Received: by 2002:a17:902:624:: with SMTP id 33mr59045206plg.325.1559946184199;
 Fri, 07 Jun 2019 15:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com> <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com> <20190607190047.C3E7A20868@mail.kernel.org>
In-Reply-To: <20190607190047.C3E7A20868@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 Jun 2019 15:22:53 -0700
Message-ID: <CAFd5g475eUKnpNM3kDe_9PboCyZ=aanPeV2gTuzuJXRp-xbsWg@mail.gmail.com>
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

On Fri, Jun 7, 2019 at 12:00 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Iurii Zaikin (2019-06-05 18:29:42)
> > On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > > new file mode 100644
> > > > index 0000000000000..fe0f2bae66085
> > > > --- /dev/null
> > > > +++ b/kernel/sysctl-test.c
> > > > +
> > > > +
> > > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > > +{
> > > > +       struct ctl_table table = {
> > > > +               .procname = "foo",
> > > > +               .data           = &test_data.int_0001,
> > > > +               .maxlen         = sizeof(int),
> > > > +               .mode           = 0644,
> > > > +               .proc_handler   = proc_dointvec,
> > > > +               .extra1         = &i_zero,
> > > > +               .extra2         = &i_one_hundred,
> > > > +       };
> > > > +       char input[] = "-9";
> > > > +       size_t len = sizeof(input) - 1;
> > > > +       loff_t pos = 0;
> > > > +
> > > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> > >
> > > Is the casting necessary? Or can the macro do a type coercion of the
> > > second parameter based on the first type?
> >  Data field is defined as void* so I believe casting is necessary to
> > dereference it as a pointer to an array of ints. I don't think the
> > macro should do any type coercion that == operator wouldn't do.
> >  I did change the cast to make it more clear that it's a pointer to an
> > array of ints being dereferenced.
>
> Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
> both sides and cause a build warning/error if the types aren't the same.
> This would be similar to our min/max macros that complain about
> mismatched types in the comparisons. Then if a test developer needs to
> convert one type or the other they could do so with a
> KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
> explicitly.

Good point. I would definitely like to do this, for me it is only a
question of how difficult it would be to make all that happen.

We will investigate and report back on it.

Thanks for the suggestion! It's a really good idea!

Cheers
