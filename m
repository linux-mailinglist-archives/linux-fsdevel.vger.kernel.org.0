Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E1B9BEFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHXR3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 13:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfHXR3V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 13:29:21 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9F020870;
        Sat, 24 Aug 2019 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566667760;
        bh=D3nLnnNPLuL/zFk4MNDUmFGzPOfuIQGc/sSLWQeMJCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qQvJssVcUppRZfxWiCWZqD4orXYOwW51Do+MjiJOlXvIE1EasomxA6H/BjQg/l+0v
         fa5vfHkA/8e+t+mj1UEi7/X+/xak2vcoK3eKYd2CcRnPgYkX6N9X5nDioWKtJGCcNl
         sMf76jjgFYGDYB4WceIHBLhFl/0T9P84t2fquPsY=
Subject: Re: [PATCH v15 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        tytso@mit.edu, yamada.masahiro@socionext.com
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
        wfg@linux.intel.com, shuah <shuah@kernel.org>
References: <20190824013425.175645-1-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a657b995-32b3-3352-bc10-834547e44dd4@kernel.org>
Date:   Sat, 24 Aug 2019 11:29:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/19 7:34 PM, Brendan Higgins wrote:
> ## TL;DR
> 
> This revision addresses comments from Shuah by fixing a couple
> checkpatch warnings and fixing some comment readability issues. No API
> or major structual changes have been made since v13.
> 
> ## Background
> 
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> (however, KUnit still allows you to run tests on test machines or in VMs
> if you want[1]) and does not require tests to be written in userspace
> running on a host kernel. Additionally, KUnit is fast: From invocation
> to completion KUnit can run several dozen tests in about a second.
> Currently, the entire KUnit test suite for KUnit runs in under a second
> from the initial invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.
> 
> ### What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.
> 
> ### Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.
> 
> ### More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here[2].
> 
> Additionally for convenience, I have applied these patches to a
> branch[3]. The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/v5.3/v15 branch.
> 
> ## Changes Since Last Version
> 
> - Moved comment from inline in macro to kernel-doc to address checkpatch
>    warning.
> - Demoted BUG() to WARN_ON.
> - Formatted some kernel-doc comments to make them more readible.
> 
> [1] https://google.github.io/kunit-docs/third_party/kernel/docs/usage.html#kunit-on-non-uml-architectures
> [2] https://google.github.io/kunit-docs/third_party/kernel/docs/
> [3] https://kunit.googlesource.com/linux/+/kunit/rfc/v5.3/v15
> 

Hi Brendan,

Thanks for doing this work.

Thanks for accommodating my request to improve the document/comment
blocks in patch 01 and removing BUG() from patch 09. The comment block
reads well now.

Applied the series to linux-kselftest next for 5.4-rc1.

thanks,
-- Shuah
