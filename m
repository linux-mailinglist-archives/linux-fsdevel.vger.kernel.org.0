Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAC21D42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfEQSW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEQSW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:22:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 548EA20815;
        Fri, 17 May 2019 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558117374;
        bh=KK9QKyeHXGNZS14JEvoS56XPdr9dX51Q2wnzy9zhzdw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cFxMk9+pv8gbeXxX98UnM9NZlslsE37dec0L6/dd6ESCHIfh2/n5NwmR4frW+1Ldi
         L533sROPmjbe4JZK53rnXRHbfG4VAZSkK4NvHlBa84pxKlXjoDa8zo/LSKIOOfi+AG
         +c1M6CBnPpDCrODbxfe8K/TVPbtYLqh+vrEYEL18=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190514221711.248228-18-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com> <20190514221711.248228-18-brendanhiggins@google.com>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
        wfg@linux.intel.com, Iurii Zaikin <yzaikin@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, shuah@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date:   Fri, 17 May 2019 11:22:53 -0700
Message-Id: <20190517182254.548EA20815@mail.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Brendan Higgins (2019-05-14 15:17:10)
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> new file mode 100644
> index 0000000000000..fe0f2bae66085
> --- /dev/null
> +++ b/kernel/sysctl-test.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test of proc sysctl.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/printk.h>

Is this include used?

> +#include <linux/sysctl.h>
> +#include <linux/uaccess.h>

Is this include used?

> +
> +
> +static void sysctl_test_dointvec_happy_single_negative(struct kunit *tes=
t)
> +{
> +       struct ctl_table table =3D {
> +               .procname =3D "foo",
> +               .data           =3D &test_data.int_0001,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec,
> +               .extra1         =3D &i_zero,
> +               .extra2         =3D &i_one_hundred,
> +       };
> +       char input[] =3D "-9";
> +       size_t len =3D sizeof(input) - 1;
> +       loff_t pos =3D 0;
> +
> +       table.data =3D kunit_kzalloc(test, sizeof(int), GFP_USER);
> +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &p=
os));
> +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);

Is the casting necessary? Or can the macro do a type coercion of the
second parameter based on the first type?

> +}
> +
> +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> +{
> +       struct ctl_table table =3D {
> +               .procname =3D "foo",
> +               .data           =3D &test_data.int_0001,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec,
> +               .extra1         =3D &i_zero,
> +               .extra2         =3D &i_one_hundred,
> +       };
> +       char input[32];
> +       size_t len =3D sizeof(input) - 1;
> +       loff_t pos =3D 0;
> +       unsigned long abs_of_less_than_min =3D (unsigned long)INT_MAX
> +                                            - (INT_MAX + INT_MIN) + 1;
> +
> +       KUNIT_EXPECT_LT(test,
> +                       snprintf(input, sizeof(input), "-%lu",
> +                                abs_of_less_than_min),
> +                       sizeof(input));
> +
> +       table.data =3D kunit_kzalloc(test, sizeof(int), GFP_USER);
> +       KUNIT_EXPECT_EQ(test, -EINVAL,
> +                       proc_dointvec(&table, 1, input, &len, &pos));
> +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> +}
> +
> +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *te=
st)
> +{
> +       struct ctl_table table =3D {
> +               .procname =3D "foo",
> +               .data           =3D &test_data.int_0001,
> +               .maxlen         =3D sizeof(int),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec,
> +               .extra1         =3D &i_zero,
> +               .extra2         =3D &i_one_hundred,
> +       };
> +       char input[32];
> +       size_t len =3D sizeof(input) - 1;
> +       loff_t pos =3D 0;
> +       unsigned long greater_than_max =3D (unsigned long)INT_MAX + 1;
> +
> +       KUNIT_EXPECT_GT(test, greater_than_max, INT_MAX);
> +       KUNIT_EXPECT_LT(test, snprintf(input, sizeof(input), "%lu",
> +                                      greater_than_max),
> +                       sizeof(input));
> +       table.data =3D kunit_kzalloc(test, sizeof(int), GFP_USER);
> +       KUNIT_EXPECT_EQ(test, -EINVAL,
> +                       proc_dointvec(&table, 1, input, &len, &pos));
> +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> +}
> +
> +static int sysctl_test_init(struct kunit *test)
> +{
> +       return 0;
> +}
> +
> +/*
> + * This is run once after each test case, see the comment on example_tes=
t_module
> + * for more information.
> + */
> +static void sysctl_test_exit(struct kunit *test)
> +{
> +}

Can the above two be omitted? If they can be empty sometimes it would be
nice to avoid the extra symbols and code by letting them be assigned to
NULL in the kunit_module.

> +
> +/*
> + * Here we make a list of all the test cases we want to add to the test =
module
> + * below.
> + */
> +static struct kunit_case sysctl_test_cases[] =3D {
> +       /*
> +        * This is a helper to create a test case object from a test case
> +        * function; its exact function is not important to understand ho=
w to
> +        * use KUnit, just know that this is how you associate test cases=
 with a
> +        * test module.
> +        */
> +       KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> +       KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> +       KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> +       KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> +       KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> +       KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> +       KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> +       KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> +       {},
> +};
> +
> +/*
> + * This defines a suite or grouping of tests.
> + *
> + * Test cases are defined as belonging to the suite by adding them to
> + * `test_cases`.
> + *
> + * Often it is desirable to run some function which will set up things w=
hich
> + * will be used by every test; this is accomplished with an `init` funct=
ion
> + * which runs before each test case is invoked. Similarly, an `exit` fun=
ction
> + * may be specified which runs after every test case and can be used to =
for
> + * cleanup. For clarity, running tests in a test module would behave as =
follows:
> + *
> + * module.init(test);
> + * module.test_case[0](test);
> + * module.exit(test);
> + * module.init(test);
> + * module.test_case[1](test);
> + * module.exit(test);
> + * ...;

This comment (and the one above for "this is a helper") looks generic
and should probably only be in some documentation somewhere and not for
a sysctl test?

> + */
> +static struct kunit_module sysctl_test_module =3D {
> +       .name =3D "sysctl_test",
> +       .init =3D sysctl_test_init,
> +       .exit =3D sysctl_test_exit,
> +       .test_cases =3D sysctl_test_cases,
> +};
> +
> +/*
> + * This registers the above test module telling KUnit that this is a sui=
te of
> + * tests that need to be run.
> + */

Same comment about generic comment.

> +module_test(sysctl_test_module);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d5a4a4036d2f8..772af4ec70111 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1908,6 +1908,12 @@ config TEST_SYSCTL
> =20
>           If unsure, say N.
> =20
> +config SYSCTL_KUNIT_TEST
> +       bool "KUnit test for sysctl"

Why not tristate?

> +       depends on KUNIT
> +       help
> +         Enables KUnit sysctl test.
> +
