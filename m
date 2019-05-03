Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15BE1260E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 03:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfECB1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 21:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfECB1G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 21:27:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 460E42087F;
        Fri,  3 May 2019 01:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556846825;
        bh=dAK2Yt3qD5zmHe8mgMxIoRaAMTlU3x5G2+ZN52E6vSA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2ZG9iWIOocrV7hcyVglaDnCJiz8k4RbmB3/LRyEHNma4V4IwEoNjKwD08ekcqRYdU
         g2GcPdNXrVGy6v3DdWBSgrkFqmYHp///VcR62QeEanyeEDG2SEbQ9/zt8M12/Pj1yF
         3Kzg8A3TvxXZgIHVppO615sf2GPaT+5qfLbHzp04=
Subject: Re: [PATCH v2 07/17] kunit: test: add initial tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com, skhan@linuxfoundation.org
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-8-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d4934565-9b41-880e-3bbe-984224b50fac@kernel.org>
Date:   Thu, 2 May 2019 19:27:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-8-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:01 PM, Brendan Higgins wrote:
> Add a test for string stream along with a simpler example.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>   kunit/Kconfig              | 12 ++++++
>   kunit/Makefile             |  4 ++
>   kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
>   kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
>   4 files changed, 165 insertions(+)
>   create mode 100644 kunit/example-test.c
>   create mode 100644 kunit/string-stream-test.c
> 
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> index 64480092b2c24..5cb500355c873 100644
> --- a/kunit/Kconfig
> +++ b/kunit/Kconfig
> @@ -13,4 +13,16 @@ config KUNIT
>   	  special hardware. For more information, please see
>   	  Documentation/kunit/
>   
> +config KUNIT_TEST
> +	bool "KUnit test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables KUnit test to test KUnit.
> +

Please add a bit more information on what this config option
does. Why should user care to enable it?

> +config KUNIT_EXAMPLE_TEST
> +	bool "Example test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables example KUnit test to demo features of KUnit.
> +

Same here.

>   endmenu
> diff --git a/kunit/Makefile b/kunit/Makefile
> index 6ddc622ee6b1c..60a9ea6cb4697 100644
> --- a/kunit/Makefile
> +++ b/kunit/Makefile
> @@ -1,3 +1,7 @@
>   obj-$(CONFIG_KUNIT) +=			test.o \
>   					string-stream.o \
>   					kunit-stream.o
> +
> +obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
> +
> +obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	example-test.o
> diff --git a/kunit/example-test.c b/kunit/example-test.c
> new file mode 100644
> index 0000000000000..3947dd7c8f922
> --- /dev/null
> +++ b/kunit/example-test.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Example KUnit test to show how to use KUnit.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <kunit/test.h>
> +
> +/*
> + * This is the most fundamental element of KUnit, the test case. A test case
> + * makes a set EXPECTATIONs and ASSERTIONs about the behavior of some code; if
> + * any expectations or assertions are not met, the test fails; otherwise, the
> + * test passes.
> + *
> + * In KUnit, a test case is just a function with the signature
> + * `void (*)(struct kunit *)`. `struct kunit` is a context object that stores
> + * information about the current test.
> + */
> +static void example_simple_test(struct kunit *test)
> +{
> +	/*
> +	 * This is an EXPECTATION; it is how KUnit tests things. When you want
> +	 * to test a piece of code, you set some expectations about what the
> +	 * code should do. KUnit then runs the test and verifies that the code's
> +	 * behavior matched what was expected.
> +	 */
> +	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> +}
> +
> +/*
> + * This is run once before each test case, see the comment on
> + * example_test_module for more information.
> + */
> +static int example_test_init(struct kunit *test)
> +{
> +	kunit_info(test, "initializing\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * Here we make a list of all the test cases we want to add to the test module
> + * below.
> + */
> +static struct kunit_case example_test_cases[] = {
> +	/*
> +	 * This is a helper to create a test case object from a test case
> +	 * function; its exact function is not important to understand how to
> +	 * use KUnit, just know that this is how you associate test cases with a
> +	 * test module.
> +	 */
> +	KUNIT_CASE(example_simple_test),
> +	{},
> +};
> +
> +/*
> + * This defines a suite or grouping of tests.
> + *
> + * Test cases are defined as belonging to the suite by adding them to
> + * `kunit_cases`.
> + *
> + * Often it is desirable to run some function which will set up things which
> + * will be used by every test; this is accomplished with an `init` function
> + * which runs before each test case is invoked. Similarly, an `exit` function
> + * may be specified which runs after every test case and can be used to for
> + * cleanup. For clarity, running tests in a test module would behave as follows:
> + *
> + * module.init(test);
> + * module.test_case[0](test);
> + * module.exit(test);
> + * module.init(test);
> + * module.test_case[1](test);
> + * module.exit(test);
> + * ...;
> + */
> +static struct kunit_module example_test_module = {
> +	.name = "example",
> +	.init = example_test_init,
> +	.test_cases = example_test_cases,
> +};
> +
> +/*
> + * This registers the above test module telling KUnit that this is a suite of
> + * tests that need to be run.
> + */
> +module_test(example_test_module);
> diff --git a/kunit/string-stream-test.c b/kunit/string-stream-test.c
> new file mode 100644
> index 0000000000000..b2a98576797c9
> --- /dev/null
> +++ b/kunit/string-stream-test.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for struct string_stream.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: Brendan Higgins <brendanhiggins@google.com>
> + */
> +
> +#include <linux/slab.h>
> +#include <kunit/test.h>
> +#include <kunit/string-stream.h>
> +
> +static void string_stream_test_get_string(struct kunit *test)
> +{
> +	struct string_stream *stream = new_string_stream();
> +	char *output;
> +
> +	string_stream_add(stream, "Foo");
> +	string_stream_add(stream, " %s", "bar");
> +
> +	output = string_stream_get_string(stream);
> +	KUNIT_EXPECT_STREQ(test, output, "Foo bar");
> +	kfree(output);
> +	destroy_string_stream(stream);
> +}
> +
> +static void string_stream_test_add_and_clear(struct kunit *test)
> +{
> +	struct string_stream *stream = new_string_stream();
> +	char *output;
> +	int i;
> +
> +	for (i = 0; i < 10; i++)
> +		string_stream_add(stream, "A");
> +
> +	output = string_stream_get_string(stream);
> +	KUNIT_EXPECT_STREQ(test, output, "AAAAAAAAAA");
> +	KUNIT_EXPECT_EQ(test, stream->length, 10);
> +	KUNIT_EXPECT_FALSE(test, string_stream_is_empty(stream));
> +	kfree(output);
> +
> +	string_stream_clear(stream);
> +
> +	output = string_stream_get_string(stream);
> +	KUNIT_EXPECT_STREQ(test, output, "");
> +	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
> +	destroy_string_stream(stream);
> +}
> +
> +static struct kunit_case string_stream_test_cases[] = {
> +	KUNIT_CASE(string_stream_test_get_string),
> +	KUNIT_CASE(string_stream_test_add_and_clear),
> +	{}
> +};
> +
> +static struct kunit_module string_stream_test_module = {
> +	.name = "string-stream-test",
> +	.test_cases = string_stream_test_cases
> +};
> +module_test(string_stream_test_module);
> +
> 

