Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B816C39526
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfFGTAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 15:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGTAs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:00:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E7A20868;
        Fri,  7 Jun 2019 19:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559934047;
        bh=SaF9wNj2glMXJrUlhGfPV51XspfvGCl4GV+n5wOltIk=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=pOa773KinCbWZNwUdN0H2jdZol+fGp2XY6GywMUyTl3QZS5pW9hFAAcg/RQpuePFb
         6lPWUUf3AvmyqHdMay0eDupbNJ7WbuBfNXwJ4jnDfqEl3Pw+6YKFdZVlrZIY2LFVvc
         bfbI2V1LcTAYX/HU3jn8XFwP21qj/1NllQ+0AO60=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-18-brendanhiggins@google.com> <20190517182254.548EA20815@mail.kernel.org> <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
To:     Iurii Zaikin <yzaikin@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
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
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 12:00:47 -0700
Message-Id: <20190607190047.C3E7A20868@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Iurii Zaikin (2019-06-05 18:29:42)
> On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > new file mode 100644
> > > index 0000000000000..fe0f2bae66085
> > > --- /dev/null
> > > +++ b/kernel/sysctl-test.c
> > > +
> > > +
> > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit =
*test)
> > > +{
> > > +       struct ctl_table table =3D {
> > > +               .procname =3D "foo",
> > > +               .data           =3D &test_data.int_0001,
> > > +               .maxlen         =3D sizeof(int),
> > > +               .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_dointvec,
> > > +               .extra1         =3D &i_zero,
> > > +               .extra2         =3D &i_one_hundred,
> > > +       };
> > > +       char input[] =3D "-9";
> > > +       size_t len =3D sizeof(input) - 1;
> > > +       loff_t pos =3D 0;
> > > +
> > > +       table.data =3D kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len=
, &pos));
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> >
> > Is the casting necessary? Or can the macro do a type coercion of the
> > second parameter based on the first type?
>  Data field is defined as void* so I believe casting is necessary to
> dereference it as a pointer to an array of ints. I don't think the
> macro should do any type coercion that =3D=3D operator wouldn't do.
>  I did change the cast to make it more clear that it's a pointer to an
> array of ints being dereferenced.

Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
both sides and cause a build warning/error if the types aren't the same.
This would be similar to our min/max macros that complain about
mismatched types in the comparisons. Then if a test developer needs to
convert one type or the other they could do so with a
KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
explicitly.

