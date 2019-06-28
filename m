Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106135957C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF1ICH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 04:02:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfF1ICG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:02:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id 9so2022668ple.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2019 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZq6BCzx2oAYKBXZwpH6LRexuDJ0/444+0e0Mc/hDbY=;
        b=Rd9lRP9zAd/kbl3ZE7qYqE71uAPpqI08y9O8Z8POPjewUXfV5BkcxB5GlkY7Lz2EvR
         L0vi5OB036U4FKFCgIDZv8F3y6lztLOxmk0kwy/NUBPaZkq+ECaVF1Jt2lfubLgAj49H
         Uk6C/xmHOoJyYfOl2AD99Cc4Ji0bJcI5iEK/IOzTvY7wn8alGsOUKlv4FIhRP3sRGF55
         fIMKwrwTaQtuY+hOsydah24wbl/mQVSW6sltZZBybHwghcYUR14MnHCnTHXmgdqPSQtw
         agAI8RdzSUB0Onytip3sOEuouLaTLd1x4D+UiNdsy+ktLsNeIwWlm9Q+91kPa3V5g02W
         Z4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZq6BCzx2oAYKBXZwpH6LRexuDJ0/444+0e0Mc/hDbY=;
        b=gQmi98nwohxx5cpa9liCGddfKbcx2yt0kphhCuJgB/piyqPB7rNCqqcz7aO4H0h0lU
         pqVbNVxPTKGkdH4rqo9GZyt1Z24e5zq6f5bssQ//Fq9vo0l9b2DV7kE1UXWHUMq0P3cW
         OHi/II4wD3cRp3DIXmTUnF1M4sgwoog/iZ25CSxX7yFzyuWypcqQAwM/qIj7erlz88/v
         aU1epW9HzhPvj5UXdAbq7mjiLwRWfP1mAtvOBmOFNc/zr6+xy/aQjdCr4soj2mjW3Z9h
         Di5Obij7K1yl4a5kLd4Lex2RqwWy51RzrS7bA86TQawJ0k+qhjIjbtHzLTFgZwSQM1DT
         /n2w==
X-Gm-Message-State: APjAAAW3DRNDKPcyetTZIbfyRrWRJXSTg/ptbjuZTYCdb8IGnM2tuBQr
        X3MpMLyqTYQkMLtm7CQgCXbrmZ2wbt/9w+YY8IVhUg==
X-Google-Smtp-Source: APXvYqwmEZtlGKAjiLJWvizo9Zwmik6FWTQ62cPvtwGWDViEZL1wVsPAEfk8YLKeNB7mUaMkZVTde4hFd59dR/Vcw90=
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr10173684pla.232.1561708925220;
 Fri, 28 Jun 2019 01:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-18-brendanhiggins@google.com> <20190626021744.GU19023@42.do-not-panic.com>
 <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com> <20190627061021.GE19023@42.do-not-panic.com>
In-Reply-To: <20190627061021.GE19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jun 2019 01:01:54 -0700
Message-ID: <CAFd5g45VJ9yfuESUc=E0ydJyN+mk1b1kyHSCYvO2x9KPC7+3GQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Iurii Zaikin <yzaikin@google.com>, linux-api@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
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

On Wed, Jun 26, 2019 at 11:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jun 26, 2019 at 09:07:43PM -0700, Iurii Zaikin wrote:
> > On Tue, Jun 25, 2019 at 7:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > +static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
> > > > +{
> > > > +     struct ctl_table table = {
> > > > +             .procname = "foo",
> > > > +             .data           = &test_data.int_0001,
> > > > +             .maxlen         = 0,
> > > > +             .mode           = 0644,
> > > > +             .proc_handler   = proc_dointvec,
> > > > +             .extra1         = &i_zero,
> > > > +             .extra2         = &i_one_hundred,
> > > > +     };
> > > > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +     size_t len;
> > > > +     loff_t pos;
> > > > +
> > > > +     len = 1234;
> > > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > > +     len = 1234;
> > > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > > +}
> > >
> > > In a way this is also testing for general kernel API changes. This is and the
> > > last one were good examples. So this is not just testing functionality
> > > here. There is no wrong or write answer if 0 or -EINVAL was returned
> > > other than the fact that we have been doing this for years.
> > >
> > > Its a perhaps small but important difference for some of these tests.  I
> > > *do* think its worth clarifying through documentation which ones are
> > > testing for API consistency Vs proper correctness.
> >
> > You make a good point that the test codifies the existing behavior of
> > the function in lieu of formal documentation.  However, the test cases
> > were derived from examining the source code of the function under test
> > and attempting to cover all branches. The assertions were added only
> > for the values that appeared to be set deliberately in the
> > implementation. And it makes sense to me to test that the code does
> > exactly what the implementation author intended.
>
> I'm not arguing against adding them. I'm suggesting that it is different
> to test for API than for correctness of intended functionality, and
> it would be wise to make it clear which test cases are for API and which
> for correctness.

I see later on that some of the API stuff you are talking about is
public APIs from the standpoint of user (outside of LInux) visible. To
be clear, is that what you mean by public APIs throughout, or would
you distinguish between correctness tests, internal API tests, and
external API tests?

> This will come up later for other kunit tests and it would be great
> to set precendent so that other kunit tests can follow similar
> practices to ensure its clear what is API realted Vs correctness of
> intended functionality.
>
> In fact, I'm not yet sure if its possible to test public kernel API to
> userspace with kunit, but if it is possible... well, that could make
> linux-api folks happy as they could enable us to codify interpreation of
> what is expected into kunit test cases, and we'd ensure that the
> codified interpretation is not only documented in man pages but also
> through formal kunit test cases.
>
> A regression in linux-api then could be formalized through a proper
> kunit tests case. And if an API evolves, it would force developers to
> update the respective kunit which codifies that contract.

Yep, I think that is long term hope. Some of the file system interface
stuff that requires a filesystem to be mounted somewhere might get a
little weird/difficult, but I suspect we should be able to do it
eventually. I mean it's all just C code right? Should mostly boil down
to someone figuring out how to do it the first time.

> > > > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > > > +{
> > > > +     struct ctl_table table = {
> > > > +             .procname = "foo",
> > > > +             .data           = &test_data.int_0001,
> > > > +             .maxlen         = sizeof(int),
> > > > +             .mode           = 0644,
> > > > +             .proc_handler   = proc_dointvec,
> > > > +             .extra1         = &i_zero,
> > > > +             .extra2         = &i_one_hundred,
> > > > +     };
> > > > +     char input[32];
> > > > +     size_t len = sizeof(input) - 1;
> > > > +     loff_t pos = 0;
> > > > +     unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > > > +                                          - (INT_MAX + INT_MIN) + 1;
> > > > +
> > > > +     KUNIT_EXPECT_LT(test,
> > > > +                     (size_t)snprintf(input, sizeof(input), "-%lu",
> > > > +                                      abs_of_less_than_min),
> > > > +                     sizeof(input));
> > > > +
> > > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > > +}
> > >
> > > API test.
> > >
> > Not sure why.
>
> Because you are codifying that we *definitely* return -EINVAL on
> overlow. Some parts of the kernel return -ERANGE for overflows for
> instance.
>
> It would be a generic test for overflow if it would just test
> for any error.
>
> It is a fine and good test to keep. All these tests are good to keep.
>
> > I believe there has been a real bug with int overflow in
> > proc_dointvec.
> > Covering it with test seems like a good idea.
>
> Oh definitely.
>
> > > > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > > > +{
> > > > +     struct ctl_table table = {
> > > > +             .procname = "foo",
> > > > +             .data           = &test_data.int_0001,
> > > > +             .maxlen         = sizeof(int),
> > > > +             .mode           = 0644,
> > > > +             .proc_handler   = proc_dointvec,
> > > > +             .extra1         = &i_zero,
> > > > +             .extra2         = &i_one_hundred,
> > > > +     };
> > > > +     char input[32];
> > > > +     size_t len = sizeof(input) - 1;
> > > > +     loff_t pos = 0;
> > > > +     unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > > > +
> > > > +     KUNIT_EXPECT_GT(test, greater_than_max, (unsigned long)INT_MAX);
> > > > +     KUNIT_EXPECT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
> > > > +                                            greater_than_max),
> > > > +                     sizeof(input));
> > > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > > +}
> > > > +
> > >
> > > API test.
> > >
> > > > +static struct kunit_case sysctl_test_cases[] = {
> > > > +     KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > > > +     KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > > > +     {}
> > > > +};
> > >
> > > Oh all are API tests.. perhaps then just rename then
> > > sysctl_test_cases to sysctl_api_test_cases.
> > >
> > > Would be good to add at least *two* other tests cases for this
> > > example, one which does a valid read and one which does a valid write.
> > Added valid reads. There already are 2 valid writes.
>
> Thanks.
>
> > > If that is done either we add another kunit test module for correctness
> > > or just extend the above and use prefix / postfixes on the functions
> > > to distinguish between API / correctness somehow.
> > >
> > > > +
> > > > +static struct kunit_module sysctl_test_module = {
> > > > +     .name = "sysctl_test",
> > > > +     .test_cases = sysctl_test_cases,
> > > > +};
> > > > +
> > > > +module_test(sysctl_test_module);
> > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > index cbdfae3798965..389b8986f5b77 100644
> > > > --- a/lib/Kconfig.debug
> > > > +++ b/lib/Kconfig.debug
> > > > @@ -1939,6 +1939,16 @@ config TEST_SYSCTL
> > > >
> > > >         If unsure, say N.
> > > >
> > > > +config SYSCTL_KUNIT_TEST
> > > > +     bool "KUnit test for sysctl"
> > > > +     depends on KUNIT
> > > > +     help
> > > > +       This builds the proc sysctl unit test, which runs on boot. For more
> > > > +       information on KUnit and unit tests in general please refer to the
> > > > +       KUnit documentation in Documentation/dev-tools/kunit/.
> > >
> > > A little more description here would help. It is testing for API and
> > > hopefully also correctness (if extended with those two examples I
> > > mentioned).
> > >
> > Added "Tests the API contract and implementation correctness of sysctl."
>
> Yes, much clearer, thanks!

Cheers!
