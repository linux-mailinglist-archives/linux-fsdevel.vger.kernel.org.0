Return-Path: <linux-fsdevel+bounces-30831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3198E9DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 08:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D046281696
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD781741;
	Thu,  3 Oct 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbQYJPkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F4824BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938395; cv=none; b=KxZz8axppkKG8KKdaUmjqhIRtsR/bv0QUTZYhNM28Y93ulH+eLE/AfcKSzdpvhTHJ61hwyJNutsyhWCLdkD30tAtsNdTm4wV9yKhMrtuszHMEyX3nb5GA/3tLX84p6sNsX3vBwwXsN+j89ikfVG8X7gDIMAcIFNFk0KtZraWMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938395; c=relaxed/simple;
	bh=xyjJDxdVFMrT7qmBfDm0cwpeoH8OayVV6VBrqy9Bvdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMqe7nU60D6+ZDQ5wq+ii1ZBnI+6dSmE8tITJOzKsIatHEU6yq30xSQpBqMxYlRay2F1uN4N09iTAYDAs2TGg/aqwTVDELc7NYmW7NKQiv6igh8iOvo9BpwfMRgBFKsp7dFpfY+UNFOaiHeMaEey5+c1+BomacdX3Yrj9io5BP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbQYJPkW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb2824ddc2so5658486d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938392; x=1728543192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcO68hJyZXYmoKFauZ5Zdf0s8v9/lkgqmvNCZVeE8pw=;
        b=dbQYJPkW5Ul0OE6q0V5NH7BdGmUv0bWXtg1gz92gKb0I5iDRy4MnXcNYGbRZyHBPyK
         tOi0ZOXHOlMBjSyje1fBGPwVGjQIFhGUm/DrxPcF54XlHC5pK+RjGy59hcHRg+Ab3Lqq
         h20y7+yIcC0pQxKJs82gwVvgZNfl4hidRdFUHNVeC76jL+G0btkTkMpAqdE7NLbPHnj4
         07PjLxarejRqPTlfXaMRKxKrOH+UiwnfBblsfQVAtAvYKPsJR1UKeddlaItdooGzvUZh
         GKyAhKyWnqqeNL/A+W8qai70MoeSl9Xy2MiMXBlItYS5PMcArAvfV28aMm7h/hpoQS8e
         tkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938392; x=1728543192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcO68hJyZXYmoKFauZ5Zdf0s8v9/lkgqmvNCZVeE8pw=;
        b=GTRBKI7yCICU374j/+C5+NiwKI4lQOeggdN+rwISwMpDppMfXjZhFlYytLTJSSmN7q
         7181WokDOCQKsYNjfKVTTvIq1GbrwZvWyMwvL/J9UM3aK3BG1bL5TBAqjwa7GJpLU7FL
         tMO29RHiX2YBUEp2wd9NlrJzna5ilBWyCOAgGQXsJ3EZ3uNZWsiGIYShJm5iZNNAOt08
         3nyYLZGI/G2mCzdQ0Z5n+6UHlX5xULU/D3JibNG5LZF5sUb6iwLjwEt7iya9dzUIzGI6
         oZKDThCraoe135do+AFOndnXuJQxdNOcMGi1nyMhoP95gNCawToaos4heMRPI/M5PXKv
         hvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBO1H/msGiakAqSS39OL2/Pe9wwUTY+Dq4PCi+UXIykwCuxYGR6jNQHITjfAf2cwTdOpsBhqmIDaw7CPXR@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlLBWkTgytbSCzbmm/VELkp7PN2zEWgd64slnZxNZocAiAmNu
	b2/pQkr60LU3MzqeDmlbkPWnkmeaBWGQHt/Ma/DngBRS1jfkWb8T/8e2tYFjIL4bdUtkGXxTXb8
	g7QPHbSyrabM6vekzGtvcZq3WQyN1aTewwEyj
X-Google-Smtp-Source: AGHT+IFnOGmIZf9sce+yT3E5ll3GRIzCCr5f9XCTMypPPXy1nXXxK8+bz2Ow4KhLTWSVonhb8H1Ci4xHfzVEIn+qIeg=
X-Received: by 2002:a05:6214:3381:b0:6c7:c79c:f55 with SMTP id
 6a1803df08f44-6cb81a0b163mr66254846d6.14.1727938391950; Wed, 02 Oct 2024
 23:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928235825.96961-1-porlando@lkcamp.dev> <20240928235825.96961-2-porlando@lkcamp.dev>
In-Reply-To: <20240928235825.96961-2-porlando@lkcamp.dev>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:53:00 +0800
Message-ID: <CABVgOSmDNgcwfVO46MQBs8zfBYW6amXuuDCPDPq+4ziw4RPfyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] unicode: kunit: refactor selftest to kunit tests
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, Danilo Pereira <dpereira@lkcamp.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000014ea2806238d028d"

--00000000000014ea2806238d028d
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 08:00, Pedro Orlando <porlando@lkcamp.dev> wrote:
>
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


This looks good to me, and runs fine here. Thanks!

I do like the idea of keeping these as KUnit tests, even if fstests
has some unicode tests itself and the code is pretty battle-hardened,
as these are a good, quick way to sanity-check any changes during
development, and to catch regressions early.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


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
>           be a separate loadable module that gets requested only when a file
>           system actually use it.
>
> -config UNICODE_NORMALIZATION_SELFTEST
> +config UNICODE_NORMALIZATION_KUNIT_TEST
>         tristate "Test UTF-8 normalization support"
> -       depends on UNICODE
> +       depends on UNICODE && KUNIT
> +       default KUNIT_ALL_TESTS
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index e309afe2b2bb..37bbcbc628a1 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>  obj-y                  += unicode.o
>  endif
>  obj-$(CONFIG_UNICODE)  += utf8data.o
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
>  #define UTF8_LATEST    UNICODE_AGE(12, 1, 0)
>
> -#define _test(cond, func, line, fmt, ...) do {                         \
> -               total_tests++;                                          \
> -               if (!cond) {                                            \
> -                       failed_tests++;                                 \
> -                       pr_err("test %s:%d Failed: %s%s",               \
> -                              func, line, #cond, (fmt?":":"."));       \
> -                       if (fmt)                                        \
> -                               pr_err(fmt, ##__VA_ARGS__);             \
> -               }                                                       \
> -       } while (0)
> -#define test_f(cond, fmt, ...) _test(cond, __func__, __LINE__, fmt, ##__VA_ARGS__)
> -#define test(cond) _test(cond, __func__, __LINE__, "")
> -
>  static const struct {
>         /* UTF-8 strings in this vector _must_ be NULL-terminated. */
>         unsigned char str[10];
> @@ -170,69 +150,74 @@ static int utf8cursor(struct utf8cursor *u8c, const struct unicode_map *um,
>         return utf8ncursor(u8c, um, n, s, (unsigned int)-1);
>  }
>
> -static void check_utf8_nfdi(struct unicode_map *um)
> +static void check_utf8_nfdi(struct kunit *test)
>  {
>         int i;
>         struct utf8cursor u8c;
> +       struct unicode_map *um = test->priv;
>
>         for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>                 int len = strlen(nfdi_test_data[i].str);
>                 int nlen = strlen(nfdi_test_data[i].dec);
>                 int j = 0;
>                 unsigned char c;
> +               int ret;
>
> -               test((utf8len(um, UTF8_NFDI, nfdi_test_data[i].str) == nlen));
> -               test((utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len) ==
> -                       nlen));
> +               KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDI, nfdi_test_data[i].str), nlen);
> +               KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDI, nfdi_test_data[i].str, len),
> +                               nlen);
>
> -               if (utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str) < 0)
> -                       pr_err("can't create cursor\n");
> +
> +               ret = utf8cursor(&u8c, um, UTF8_NFDI, nfdi_test_data[i].str);
> +               KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
>
>                 while ((c = utf8byte(&u8c)) > 0) {
> -                       test_f((c == nfdi_test_data[i].dec[j]),
> -                              "Unexpected byte 0x%x should be 0x%x\n",
> -                              c, nfdi_test_data[i].dec[j]);
> +                       KUNIT_EXPECT_EQ_MSG(test, c, nfdi_test_data[i].dec[j],
> +                                           "Unexpected byte 0x%x should be 0x%x\n",
> +                                           c, nfdi_test_data[i].dec[j]);
>                         j++;
>                 }
>
> -               test((j == nlen));
> +               KUNIT_EXPECT_EQ(test, j, nlen);
>         }
>  }
>
> -static void check_utf8_nfdicf(struct unicode_map *um)
> +static void check_utf8_nfdicf(struct kunit *test)
>  {
>         int i;
>         struct utf8cursor u8c;
> +       struct unicode_map *um = test->priv;
>
>         for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
>                 int len = strlen(nfdicf_test_data[i].str);
>                 int nlen = strlen(nfdicf_test_data[i].ncf);
>                 int j = 0;
> +               int ret;
>                 unsigned char c;
>
> -               test((utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str) ==
> -                               nlen));
> -               test((utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len) ==
> -                               nlen));
> +               KUNIT_EXPECT_EQ(test, utf8len(um, UTF8_NFDICF, nfdicf_test_data[i].str),
> +                               nlen);
> +               KUNIT_EXPECT_EQ(test, utf8nlen(um, UTF8_NFDICF, nfdicf_test_data[i].str, len),
> +                               nlen);
>
> -               if (utf8cursor(&u8c, um, UTF8_NFDICF,
> -                               nfdicf_test_data[i].str) < 0)
> -                       pr_err("can't create cursor\n");
> +               ret = utf8cursor(&u8c, um, UTF8_NFDICF, nfdicf_test_data[i].str);
> +               KUNIT_EXPECT_TRUE_MSG(test, ret >= 0, "Can't create cursor\n");
>
>                 while ((c = utf8byte(&u8c)) > 0) {
> -                       test_f((c == nfdicf_test_data[i].ncf[j]),
> -                              "Unexpected byte 0x%x should be 0x%x\n",
> -                              c, nfdicf_test_data[i].ncf[j]);
> +                       KUNIT_EXPECT_EQ_MSG(test, c, nfdicf_test_data[i].ncf[j],
> +                                           "Unexpected byte 0x%x should be 0x%x\n",
> +                                           c, nfdicf_test_data[i].ncf[j]);
>                         j++;
>                 }
>
> -               test((j == nlen));
> +               KUNIT_EXPECT_EQ(test, j, nlen);
>         }
>  }
>
> -static void check_utf8_comparisons(struct unicode_map *table)
> +static void check_utf8_comparisons(struct kunit *test)
>  {
>         int i;
> +       struct unicode_map *um = test->priv;
>
>         for (i = 0; i < ARRAY_SIZE(nfdi_test_data); i++) {
>                 const struct qstr s1 = {.name = nfdi_test_data[i].str,
> @@ -240,8 +225,9 @@ static void check_utf8_comparisons(struct unicode_map *table)
>                 const struct qstr s2 = {.name = nfdi_test_data[i].dec,
>                                         .len = sizeof(nfdi_test_data[i].dec)};
>
> -               test_f(!utf8_strncmp(table, &s1, &s2),
> -                      "%s %s comparison mismatch\n", s1.name, s2.name);
> +               /* strncmp returns 0 when strings are equal */
> +               KUNIT_EXPECT_TRUE_MSG(test, utf8_strncmp(um, &s1, &s2) == 0,
> +                                   "%s %s comparison mismatch\n", s1.name, s2.name);
>         }
>
>         for (i = 0; i < ARRAY_SIZE(nfdicf_test_data); i++) {
> @@ -250,62 +236,65 @@ static void check_utf8_comparisons(struct unicode_map *table)
>                 const struct qstr s2 = {.name = nfdicf_test_data[i].ncf,
>                                         .len = sizeof(nfdicf_test_data[i].ncf)};
>
> -               test_f(!utf8_strncasecmp(table, &s1, &s2),
> -                      "%s %s comparison mismatch\n", s1.name, s2.name);
> +               /* strncasecmp returns 0 when strings are equal */
> +               KUNIT_EXPECT_TRUE_MSG(test, utf8_strncasecmp(um, &s1, &s2) == 0,
> +                                   "%s %s comparison mismatch\n", s1.name, s2.name);
>         }
>  }
>
> -static void check_supported_versions(struct unicode_map *um)
> +static void check_supported_versions(struct kunit *test)
>  {
> +       struct unicode_map *um = test->priv;
>         /* Unicode 7.0.0 should be supported. */
> -       test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
> +       KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
>
>         /* Unicode 9.0.0 should be supported. */
> -       test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
> +       KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
>
>         /* Unicode 1x.0.0 (the latest version) should be supported. */
> -       test(utf8version_is_supported(um, UTF8_LATEST));
> +       KUNIT_EXPECT_TRUE(test, utf8version_is_supported(um, UTF8_LATEST));
>
>         /* Next versions don't exist. */
> -       test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> -       test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> -       test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
> +       KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
> +       KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
> +       KUNIT_EXPECT_FALSE(test, utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
>  }
>
> -static int __init init_test_ucd(void)
> +static struct kunit_case unicode_normalization_test_cases[] = {
> +       KUNIT_CASE(check_supported_versions),
> +       KUNIT_CASE(check_utf8_comparisons),
> +       KUNIT_CASE(check_utf8_nfdicf),
> +       KUNIT_CASE(check_utf8_nfdi),
> +       {}
> +};
> +
> +static int init_test_ucd(struct kunit *test)
>  {
> -       struct unicode_map *um;
> +       struct unicode_map *um = utf8_load(UTF8_LATEST);
>
> -       failed_tests = 0;
> -       total_tests = 0;
> +       test->priv = um;
>
> -       um = utf8_load(UTF8_LATEST);
> -       if (IS_ERR(um)) {
> -               pr_err("%s: Unable to load utf8 table.\n", __func__);
> -               return PTR_ERR(um);
> -       }
> +       KUNIT_EXPECT_EQ_MSG(test, IS_ERR(um), 0,
> +                           "%s: Unable to load utf8 table.\n", __func__);
>
> -       check_supported_versions(um);
> -       check_utf8_nfdi(um);
> -       check_utf8_nfdicf(um);
> -       check_utf8_comparisons(um);
> -
> -       if (!failed_tests)
> -               pr_info("All %u tests passed\n", total_tests);
> -       else
> -               pr_err("%u out of %u tests failed\n", failed_tests,
> -                      total_tests);
> -       utf8_unload(um);
>         return 0;
>  }
>
> -static void __exit exit_test_ucd(void)
> +static void exit_test_ucd(struct kunit *test)
>  {
> +       utf8_unload(test->priv);
>  }
>
> -module_init(init_test_ucd);
> -module_exit(exit_test_ucd);
> +static struct kunit_suite unicode_normalization_test_suite = {
> +       .name = "unicode_normalization",
> +       .test_cases = unicode_normalization_test_cases,
> +       .init = init_test_ucd,
> +       .exit = exit_test_ucd,
> +};
> +
> +kunit_test_suite(unicode_normalization_test_suite);
> +
>
>  MODULE_AUTHOR("Gabriel Krisman Bertazi <krisman@collabora.co.uk>");
> -MODULE_DESCRIPTION("Kernel module for testing utf-8 support");
> +MODULE_DESCRIPTION("KUnit tests for utf-8 support.");
>  MODULE_LICENSE("GPL");
> --
> 2.34.1
>

--00000000000014ea2806238d028d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgpycgYr+nTjv/kZ9eyLKEscFLhYcP
hGgvQENzDbKNPo4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDAzMDY1MzEyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJ/9DMcME58Uila6VI+IigRvVn+9vS8yn1a2nferWq//MzrI
uJCsEo6Ix99fItyN4DJPK1R9lIzqNMKBkLMzYvWFNyuNVBYKPKxo6zRca4t3ikickYCydJPiVX/+
y5gIHCJ7xeYCdjKhmTSjDhW1wjWSXCjYco2kmRdicRb+y9Zq1jO4wuREIykh3sL0cSIoTkQmHkcx
dVhupgwxAZ+lZk7zt00N+SSd1bEtbGJamrDqDtAXRiRqDyHdq3N9JwMsg+Dag8t0zcHNzzgML47U
Q5Ue6aU44N/SeGxLn1CMJ8gFxMHddMv2UHBIF6IvL1KbAw3Sdad/muIUcsAq42BetDU=
--00000000000014ea2806238d028d--

