Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7065D1AB138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411770AbgDOTIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416840AbgDOSka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:40:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14026C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 11:40:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DC23B2A1823
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] Implement utf8 unit tests as a kunit test suite.
Organization: Collabora
References: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
Date:   Wed, 15 Apr 2020 14:40:23 -0400
In-Reply-To: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
 ("Ricardo
        =?utf-8?Q?Ca=C3=B1uelo=22's?= message of "Wed, 15 Apr 2020 10:28:26 +0200")
Message-ID: <851rood23s.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ricardo Cañuelo <ricardo.canuelo@collabora.com> writes:

> This translates the existing utf8 unit test module into a kunit-compliant
> test suite. No functionality has been added or removed.
>
> Some names changed to make the file name, the Kconfig option and test
> suite name less specific, since this source file might hold more utf8
> tests in the future.
>
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---
> Tested with kunit_tool and at boot time on qemu-system-x86_64
>
>  fs/unicode/Kconfig                          |  18 +-
>  fs/unicode/Makefile                         |   2 +-
>  fs/unicode/{utf8-selftest.c => utf8-test.c} | 207 ++++++++++----------
>  3 files changed, 115 insertions(+), 112 deletions(-)
>  rename fs/unicode/{utf8-selftest.c => utf8-test.c} (59%)
>
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..734c25920750 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -8,7 +8,19 @@ config UNICODE
>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>  	  support.
>  
> -config UNICODE_NORMALIZATION_SELFTEST
> -	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +config UNICODE_KUNIT_TESTS
> +	bool "Kunit tests for UTF-8 support"

Kunit tests for Unicode normalization and casefolding support

> +	depends on UNICODE && KUNIT
>  	default n
> +	help
> +	  This builds the ext4 KUnit tests.

Unicode KUinit tests.

> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a production
> +	  build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index b88aecc86550..0e8e2192a715 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_UNICODE) += unicode.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_KUNIT_TESTS) += utf8-test.o
>  
>  unicode-y := utf8-norm.o utf8-core.o
>  
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-test.c
> similarity index 59%
> rename from fs/unicode/utf8-selftest.c
> rename to fs/unicode/utf8-test.c
> index 6fe8af7edccb..20d12b1efc42 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-test.c
> @@ -1,39 +1,25 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Kernel module for testing utf-8 support.
> + * Kunit tests for utf-8 support.
>   *
> - * Copyright 2017 Collabora Ltd.
> + * Copyright 2020 Collabora Ltd.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/printk.h>
> +#include <kunit/test.h>
>  #include <linux/unicode.h>
> -#include <linux/dcache.h>
> -
>  #include "utf8n.h"
>  
> -unsigned int failed_tests;
> -unsigned int total_tests;
> +#define VERSION_STR_LEN 16

Instead of this random len and the snprintf to generate the string at
runtime, why not just:

#define LATEST_VERSION_STR "12.1.0"

And use it directly, since it is constant.

>  /* Tests will be based on this version. */
>  #define latest_maj 12
>  #define latest_min 1
>  #define latest_rev 0
>  
> -#define _test(cond, func, line, fmt, ...) do {				\
> -		total_tests++;						\
> -		if (!cond) {						\
> -			failed_tests++;					\
> -			pr_err("test %s:%d Failed: %s%s",		\
> -			       func, line, #cond, (fmt?":":"."));	\
> -			if (fmt)					\
> -				pr_err(fmt, ##__VA_ARGS__);		\
> -		}							\
> -	} while (0)
> -#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
> -#define test(cond) _test(cond, __func__, __LINE__, "")
> +
> +/************************************************************
> + * Test data                                                *
> + ************************************************************/

Please, keep the comment style used in the rest of the file.

>  
>  static const struct {
>  	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
> @@ -86,9 +72,9 @@ static const struct {
>  
>  		.dec = {0x61, 0xCC, 0xA8, 0xcc, 0x88, 0x00},
>  	},
> -
>  };
>  
> +

Some noise here

Thanks,

-- 
Gabriel Krisman Bertazi
