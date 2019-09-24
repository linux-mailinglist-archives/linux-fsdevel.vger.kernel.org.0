Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62411BBF7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 02:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503246AbfIXAwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 20:52:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392180AbfIXAwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jh2HpGC5bGaRmxvM2gOqp+wVb3QEYlE1PNWZkFQUHFE=; b=oEYDBQJd0G/4BY0pCNUO+Lv9r
        SqJaqivdZfguVcMkF6Y2uZ9VZXSqFwWxAS1hwrPFws9ouIBwFs5XWJmHMhgeyw6W/4vZ/ql81m4jh
        nT+Wk4ZCGSEEbxJ8okLALAofdkVzWZZ+tRRh2oumeDlAPhpYYo8GD0r6X4ouXOWR6iHqDbaP0bGtE
        L5GfQXZmvOdaB9HbMgRdH18QAKRnVfBVyyqUW/FSrT0L/cN0HN2iJbX8MzV+j3CIFl9EyeT2m6PlN
        peTnf4da6+6XPCugTap6mPKGe6caLFDpbjnaUxgSlpo6zp4aakMicOtwx41xxvl2ITgiQaFASk5qs
        dSlYgx8qg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCZ3R-00047x-0N; Tue, 24 Sep 2019 00:51:45 +0000
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com,
        torvalds@linux-foundation.org,
        Felix Guo <felixguoxiuping@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9cd80aa2-fc8d-1fed-838b-cf4951692b6d@infradead.org>
Date:   Mon, 23 Sep 2019 17:51:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923090249.127984-16-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/19 2:02 AM, Brendan Higgins wrote:

> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> new file mode 100644
> index 000000000000..c6e69634e274
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -0,0 +1,576 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========
> +Using KUnit
> +===========
> +
> +The purpose of this document is to describe what KUnit is, how it works, how it
> +is intended to be used, and all the concepts and terminology that are needed to
> +understand it. This guide assumes a working knowledge of the Linux kernel and
> +some basic knowledge of testing.
> +
> +For a high level introduction to KUnit, including setting up KUnit for your
> +project, see :doc:`start`.
> +
> +Organization of this document
> +=============================
> +
> +This document is organized into two main sections: Testing and Isolating
> +Behavior. The first covers what a unit test is and how to use KUnit to write

                              what unit tests are
would agree with the following "them."

> +them. The second covers how to use KUnit to isolate code and make it possible
> +to unit test code that was otherwise un-unit-testable.
> +
> +Testing
> +=======
> +

[snip]


> +
> +Test Suites
> +~~~~~~~~~~~
> +
> +Now obviously one unit test isn't very helpful; the power comes from having
> +many test cases covering all of your behaviors. Consequently it is common to

                   covering all of a unit's behaviors.

> +have many *similar* tests; in order to reduce duplication in these closely
> +related tests most unit testing frameworks provide the concept of a *test
> +suite*, in KUnit we call it a *test suite*; all it is is just a collection of

                                             . This is just a collection of

> +test cases for a unit of code with a set up function that gets invoked before
> +every test cases and then a tear down function that gets invoked after every

   every test case

> +test case completes.
> +
> +Example:
> +
> +.. code-block:: c
> +
> +	static struct kunit_case example_test_cases[] = {
> +		KUNIT_CASE(example_test_foo),
> +		KUNIT_CASE(example_test_bar),
> +		KUNIT_CASE(example_test_baz),
> +		{}
> +	};
> +
> +	static struct kunit_suite example_test_suite = {
> +		.name = "example",
> +		.init = example_test_init,
> +		.exit = example_test_exit,
> +		.test_cases = example_test_cases,
> +	};
> +	kunit_test_suite(example_test_suite);
> +
> +In the above example the test suite, ``example_test_suite``, would run the test
> +cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``,
> +each would have ``example_test_init`` called immediately before it and would
> +have ``example_test_exit`` called immediately after it.
> +``kunit_test_suite(example_test_suite)`` registers the test suite with the
> +KUnit test framework.
> +
> +.. note::
> +   A test case will only be run if it is associated with a test suite.
> +
> +For a more information on these types of things see the :doc:`api/test`.

   For more

> +
> +Isolating Behavior
> +==================
> +

[snip]

> +
> +.. _kunit-on-non-uml:
> +
> +KUnit on non-UML architectures
> +==============================
> +
> +By default KUnit uses UML as a way to provide dependencies for code under test.
> +Under most circumstances KUnit's usage of UML should be treated as an
> +implementation detail of how KUnit works under the hood. Nevertheless, there
> +are instances where being able to run architecture specific code, or test

                           I would drop the comma above.

> +against real hardware is desirable. For these reasons KUnit supports running on
> +other architectures.
> +
> +Running existing KUnit tests on non-UML architectures
> +-----------------------------------------------------
> +

[snip]

> +Writing new tests for other architectures
> +-----------------------------------------
> +
> +The first thing you must do is ask yourself whether it is necessary to write a
> +KUnit test for a specific architecture, and then whether it is necessary to
> +write that test for a particular piece of hardware. In general, writing a test
> +that depends on having access to a particular piece of hardware or software (not
> +included in the Linux source repo) should be avoided at all costs.
> +
> +Even if you only ever plan on running your KUnit test on your hardware
> +configuration, other people may want to run your tests and may not have access
> +to your hardware. If you write your test to run on UML, then anyone can run your
> +tests without knowing anything about your particular setup, and you can still
> +run your tests on your hardware setup just by compiling for your architecture.
> +
> +.. important::
> +   Always prefer tests that run on UML to tests that only run under a particular
> +   architecture, and always prefer tests that run under QEMU or another easy
> +   (and monitarily free) to obtain software environment to a specific piece of

           monetarily

> +   hardware.
> +
> +Nevertheless, there are still valid reasons to write an architecture or hardware
> +specific test: for example, you might want to test some code that really belongs
> +in ``arch/some-arch/*``. Even so, try your best to write the test so that it
> +does not depend on physical hardware: if some of your test cases don't need the
> +hardware, only require the hardware for tests that actually need it.
> +
> +Now that you have narrowed down exactly what bits are hardware specific, the
> +actual procedure for writing and running the tests is pretty much the same as
> +writing normal KUnit tests. One special caveat is that you have to reset
> +hardware state in between test cases; if this is not possible, you may only be
> +able to run one test case per invocation.
> +
> +.. TODO(brendanhiggins@google.com): Add an actual example of an architecture
> +   dependent KUnit test.


-- 
~Randy
