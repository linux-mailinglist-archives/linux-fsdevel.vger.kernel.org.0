Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981F526638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382109AbiEMPgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382165AbiEMPgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 11:36:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE620101C4;
        Fri, 13 May 2022 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IzQ9owkt8YiZe1369EAKIafa5obLJ/EHaGRPb2JnnbM=; b=W2k6pVD2XZSvc+QSfttXCU/bUD
        OZCk9dzOVnxPbkF5YIhtpIhTheDdhQUleH6hDnDLx9Ig0n6tIwR3KOXNS3eLATawiWFy+mnSZJABk
        gBjQDYDw+zLRY1ZDBj5Dfck9IA37sYMald2vTwgkjYJ+C4smFN5ixIUT08bXygbb+oXOWROBQYrV5
        zYIuXn/hjLqPR7x1rMm5x4aFhrlNkkewDUsE7XciDZx2jZW5FzIJngcsRNChagJLibuWAgIWzbtKo
        Vx4YYrtA19tWfw0zJtsZsEU1tIOmp91enosDVjJcCHW8SFRiNc0Go+WQBd7vCJ18DykDvYplLiaQO
        2xW34pKQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npXKY-00Giv4-Jd; Fri, 13 May 2022 15:35:50 +0000
Date:   Fri, 13 May 2022 08:35:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/3] panic: Taint kernel if tests are run
Message-ID: <Yn561lzWDuiVdTHT@bombadil.infradead.org>
References: <20220429043913.626647-1-davidgow@google.com>
 <20220513083212.3537869-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513083212.3537869-1-davidgow@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 04:32:11PM +0800, David Gow wrote:
> Most in-kernel tests (such as KUnit tests) are not supposed to run on
> production systems: they may do deliberately illegal things to trigger
> errors, and have security implications (for example, KUnit assertions
> will often deliberately leak kernel addresses).
> 
> Add a new taint type, TAINT_TEST to signal that a test has been run.
> This will be printed as 'N' (originally for kuNit, as every other
> sensible letter was taken.)
> 
> This should discourage people from running these tests on production
> systems, and to make it easier to tell if tests have been run
> accidentally (by loading the wrong configuration, etc.)
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Updated this to handle the most common case of selftest modules, in
> addition to KUnit tests. There's room for other tests or test frameworks
> to use this as well, either with a call to add_taint() from within the
> kernel, or by writing to /proc/sys/kernel/tainted.
> 
> The 'N' character for the taint is even less useful now that it's no
> longer short for kuNit, but all the letters in TEST are taken. :-(
> 
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20220430030019.803481-1-davidgow@google.com/
> - Rename TAINT_KUNIT -> TAINT_TEST.
> - Split into separate patches for adding the taint, and triggering it.
> - Taint on a kselftest_module being loaded (patch 3/3)
> 
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
> - Make the taint per-module, to handle the case when tests are in
>   (longer lasting) modules. (Thanks Greg KH).
> 
> Note that this still has checkpatch.pl warnings around bracket
> placement, which are intentional as part of matching the surrounding
> code.
> 
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 1 +
>  include/linux/panic.h                         | 3 ++-
>  kernel/panic.c                                | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index ceeed7b0798d..546f3071940d 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>   15  _/K   32768  kernel has been live patched
>   16  _/X   65536  auxiliary taint, defined for and used by distros
>   17  _/T  131072  kernel was built with the struct randomization plugin
> + 18  _/N  262144  an in-kernel test (such as a KUnit test) has been run

I think mentioning just kunit fuzzes its interpretation here.
Best to keep that out.

Other than that:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
