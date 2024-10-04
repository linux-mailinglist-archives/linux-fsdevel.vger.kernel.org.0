Return-Path: <linux-fsdevel+bounces-31016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A8990F75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1FF2823B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815651F8920;
	Fri,  4 Oct 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="k+0KvPzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0121F8908;
	Fri,  4 Oct 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068548; cv=none; b=dRAdaR+hhkBsWQaIA+dINzAZwyyqjvUVXInlvo9lelq/8Ykbo4zz87Um6ojAiRrlzETWa0Or6PMRxH5P57waTTNpZhHbWIem11JsO7O9KYrFbsQf0egwiV1I82S7x8JRxq5W/XACip6foFCK7RccXQWLuD/Mew4aD/8VdYnNpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068548; c=relaxed/simple;
	bh=l6JvoKpRdgfvV0dCjxUMZg3nh0Y6K15RX3qpNJjSzoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYcgLYw1aBMHjn1KZaGt0DhvQxYx1gEgBqtXIawPU8OQXfjdsxmTVMqXm8P0J3928C4cQXLs8RyaV05x6/kEA3zu9RFNfF04EK/HPjmCVoV2KIlnMc6FjuC4IxbLrBTFotN/xKmfOubJcC91dN7KR/f3PDX7RnC0QhVnRWxF2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=k+0KvPzq; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 812DD240002;
	Fri,  4 Oct 2024 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1728068544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rATiV63PFZNca7MyjtMbfytVApwd1ZCe6rS5EGReR74=;
	b=k+0KvPzq57+bhscakMinHuVrMgIRGG4FXykFWFeP1CVtXamKX5ltrMJHcch4UKTAhzbgRV
	kxRL5dd5SZjfR69WvpZPYm/N47F1VyVWAZZSFl7xshNaMo8CPkrczJBzTaBsiWS/2k4SP4
	Uaxv1gKhuXGwvtQoIxNkJAkJuVUi/jgwLin5kFMQj27s0H3M4+/3CdiE4UA3DkRpm2CgQj
	jKKgaCxQL7mT4fZllEj5xL5sW0+7eVC3DfplzdgqP/MLPuL7j8JhA3j82/obKpxwjrDpQ6
	hhklpFZ4K20GCirYgg3Egxlq1/tE+Kk3dlVYTWBO1tAzV/9FQcodxsGHIm80MQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,  David Gow
 <davidgow@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  linux-fsdevel@vger.kernel.org,  ~lkcamp/patches@lists.sr.ht,
  linux-kselftest@vger.kernel.org,  kunit-dev@googlegroups.com,  Gabriela
 Bittencourt <gbittencourt@lkcamp.dev>,  Danilo Pereira
 <dpereira@lkcamp.dev>
Subject: Re: [PATCH v2 1/2] unicode: kunit: refactor selftest to kunit tests
In-Reply-To: <20240928235825.96961-2-porlando@lkcamp.dev> (Pedro Orlando's
	message of "Sat, 28 Sep 2024 20:58:26 -0300")
References: <20240928235825.96961-1-porlando@lkcamp.dev>
	<20240928235825.96961-2-porlando@lkcamp.dev>
Date: Fri, 04 Oct 2024 15:02:21 -0400
Message-ID: <87ed4vu1xe.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

Pedro Orlando <porlando@lkcamp.dev> writes:

> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>
> Refactoring 'test' functions into kunit tests, to test utf-8 support in
> unicode subsystem.
>
> This allows the utf8 tests to be run alongside the KUnit test suite
> using kunit-tool, quickly compiling and running all desired tests as
> part of the KUnit test suite, instead of compiling the selftest module
> and loading it.
>
> The refactoring kept the original testing logic intact, while adopting a
> testing pattern across different kernel modules and leveraging KUnit's
> benefits.
>
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---
>
> About the KUNIT readability, there are two ways of obtaing the results:
> 1- using `_TRUE(test, func == ret)` which may make the code more
> readable, but the error message less informative. For example:
> `false, but expect true`; unless we use _TRUE_MSG(test, cond, msg) to
> customize the error message (which is what we've done here).
> 2- using `_EQ(test, func, ret)` which may be a little less readable, but the
> default error message will carry more information. For example:
> `64, but expected 0`
>
> ---
>  fs/unicode/.kunitconfig    |   3 +
>  fs/unicode/Kconfig         |   5 +-
>  fs/unicode/Makefile        |   2 +-
>  fs/unicode/utf8-selftest.c | 149 +++++++++++++++++--------------------
>  4 files changed, 76 insertions(+), 83 deletions(-)
>  create mode 100644 fs/unicode/.kunitconfig
>
> diff --git a/fs/unicode/.kunitconfig b/fs/unicode/.kunitconfig
> new file mode 100644
> index 000000000000..62dd5c171f9c
> --- /dev/null
> +++ b/fs/unicode/.kunitconfig
> @@ -0,0 +1,3 @@
> +CONFIG_KUNIT=y
> +CONFIG_UNICODE=y
> +CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST=y
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index da786a687fdc..4ad2c36550f1 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -10,6 +10,7 @@ config UNICODE
>  	  be a separate loadable module that gets requested only when a file
>  	  system actually use it.
>  
> -config UNICODE_NORMALIZATION_SELFTEST
> +config UNICODE_NORMALIZATION_KUNIT_TEST

This rename is missing a spot at the bottom of utf8norm.c:

#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
EXPORT_SYMBOL_GPL(utf8version_is_supported);
EXPORT_SYMBOL_GPL(utf8nlen);
EXPORT_SYMBOL_GPL(utf8ncursor);
EXPORT_SYMBOL_GPL(utf8byte);
#endif

Which is needed when UNICODE_NORMALIZATION_KUNIT_TEST=m.

>  	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +	depends on UNICODE && KUNIT
> +	default KUNIT_ALL_TESTS
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index e309afe2b2bb..37bbcbc628a1 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>  obj-y			+= unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
>  
>  unicode-y := utf8-norm.o utf8-core.o
>  
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
> index 600e15efe9ed..52ab68ef2bbc 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-selftest.c
> @@ -1,38 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Kernel module for testing utf-8 support.
> + * KUnit tests for utf-8 support.
>   *
>   * Copyright 2017 Collabora Ltd.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/printk.h>
>  #include <linux/unicode.h>
> -#include <linux/dcache.h>
> +#include <kunit/test.h>
>  
>  #include "utf8n.h"
>  
> -static unsigned int failed_tests;
> -static unsigned int total_tests;
> -
>  /* Tests will be based on this version. */
>  #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
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
> -
>  static const struct {
>  	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
>  	unsigned char str[10];
> @@ -170,69 +150,74 @@ static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
>  	return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
>  }
>  
> -static void check_utf8_nfdi(struct unicode_map *um)
> +static void check_utf8_nfdi(struct kunit *test)
>  {
>  	int i;
>  	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>  		int len = strlen(nfdi_test_data[i].str);
>  		int nlen = strlen(nfdi_test_data[i].dec);
>  		int j = 0;
>  		unsigned char c;
> +		int ret;
>  
> -		test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
> -		test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
> -			nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
> +				nlen);
>  
> -		if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +
> +		ret = utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
> +		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
>  
>  		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdi_test_data[i].dec[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdi_test_data[i].dec[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdi_test_data[i].dec[j]);
>  			j++;
>  		}
>  
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>  	}
>  }
>  
> -static void check_utf8_nfdicf(struct unicode_map *um)
> +static void check_utf8_nfdicf(struct kunit *test)
>  {
>  	int i;
>  	struct utf8cursor u8c;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
>  		int len = strlen(nfdicf_test_data[i].str);
>  		int nlen = strlen(nfdicf_test_data[i].ncf);
>  		int j = 0;
> +		int ret;
>  		unsigned char c;
>  
> -		test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
> -				nlen));
> -		test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
> -				nlen));
> +		KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +				nlen);
> +		KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
> +				nlen);
>  
> -		if (utf8cursor(&u8c, um, UTF8_NFDICF,
> -				nfdicf_test_data[i].str) < 0)
> -			pr_err("can't create cursor\n");
> +		ret = utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
> +		KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
>  
>  		while ((c = utf8byte(&u8c)) > 0) {
> -			test_f((c == nfdicf_test_data[i].ncf[j]),
> -			       "Unexpected byte 0x%x should be 0x%x\n",
> -			       c, nfdicf_test_data[i].ncf[j]);
> +			KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
> +					    "Unexpected byte 0x%x should be 0x%x\n",
> +					    c, nfdicf_test_data[i].ncf[j]);
>  			j++;
>  		}
>  
> -		test((j == nlen));
> +		KUNIT_EXPECT_EQ(test, j, nlen);
>  	}
>  }
>  
> -static void check_utf8_comparisons(struct unicode_map *table)
> +static void check_utf8_comparisons(struct kunit *test)
>  {
>  	int i;
> +	struct unicode_map *um = test->priv;
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>  		const struct qstr s1 = {.name = nfdi_test_data[i].str,
> @@ -240,8 +225,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
>  		const struct qstr s2 = {.name = nfdi_test_data[i].dec,
>  					.len = sizeof(nfdi_test_data[i].dec)};
>  
> -		test_f(!utf8_strncmp(table, &s1, &s2),
> -		       "%s %s comparison mismatch\n", s1.name, s2.name);
> +		/* strncmp returns 0 when strings are equal */
> +		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) == 0,
> +				    "%s %s comparison mismatch\n", s1.name, s2.name);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
> @@ -250,62 +236,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
>  		const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
>  					.len = sizeof(nfdicf_test_data[i].ncf)};
>  
> -		test_f(!utf8_strncasecmp(table, &s1, &s2),
> -		       "%s %s comparison mismatch\n", s1.name, s2.name);
> +		/* strncasecmp returns 0 when strings are equal */
> +		KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) == 0,
> +				    "%s %s comparison mismatch\n", s1.name, s2.name);
>  	}
>  }
>  
> -static void check_supported_versions(struct unicode_map *um)
> +static void check_supported_versions(struct kunit *test)
>  {
> +	struct unicode_map *um = test->priv;
>  	/* Unicode 7.0.0 should be supported. */
> -	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
>  
>  	/* Unicode 9.0.0 should be supported. */
> -	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
>  
>  	/* Unicode 1x.0.0 (the latest version) should be supported. */
> -	test(utf8version_is_supported(um, UTF8_LATEST));
> +	KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
>  
>  	/* Next versions don't exist. */
> -	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> -	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> -	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> +	KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
>  }
>  
> -static int __init init_test_ucd(void)
> +static struct kunit_case unicode_normalization_test_cases[] = {
> +	KUNIT_CASE(check_supported_versions),
> +	KUNIT_CASE(check_utf8_comparisons),
> +	KUNIT_CASE(check_utf8_nfdicf),
> +	KUNIT_CASE(check_utf8_nfdi),
> +	{}
> +};
> +
> +static int init_test_ucd(struct kunit *test)
>  {
> -	struct unicode_map *um;
> +	struct unicode_map *um = utf8_load(UTF8_LATEST);
>  
> -	failed_tests = 0;
> -	total_tests = 0;
> +	test->priv = um;
>  
> -	um = utf8_load(UTF8_LATEST);
> -	if (IS_ERR(um)) {
> -		pr_err("%s: Unable to load utf8 table.\n", __func__);
> -		return PTR_ERR(um);
> -	}
> +	KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
> +			    "%s: Unable to load utf8 table.\n", __func__);
>  
> -	check_supported_versions(um);
> -	check_utf8_nfdi(um);
> -	check_utf8_nfdicf(um);
> -	check_utf8_comparisons(um);
> -
> -	if (!failed_tests)
> -		pr_info("All %u tests passed\n", total_tests);
> -	else
> -		pr_err("%u out of %u tests failed\n", failed_tests,
> -		       total_tests);
> -	utf8_unload(um);
>  	return 0;
>  }
>  
> -static void __exit exit_test_ucd(void)
> +static void exit_test_ucd(struct kunit *test)
>  {
> +	utf8_unload(test->priv);
>  }
>  
> -module_init(init_test_ucd);
> -module_exit(exit_test_ucd);
> +static struct kunit_suite unicode_normalization_test_suite = {
> +	.name = "unicode_normalization",
> +	.test_cases = unicode_normalization_test_cases,
> +	.init = init_test_ucd,
> +	.exit = exit_test_ucd,
> +};
> +
> +kunit_test_suite(unicode_normalization_test_suite);
> +
>  
>  MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
> -MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
> +MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
>  MODULE_LICENSE("GPL");

-- 
Gabriel Krisman Bertazi

