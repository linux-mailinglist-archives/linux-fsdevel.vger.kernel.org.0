Return-Path: <linux-fsdevel+bounces-29897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75D97F128
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D60E1C21782
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B319F438;
	Mon, 23 Sep 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVJMmGbd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394C15E86
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119090; cv=none; b=asnJr7QSIWL6ZNH7CCW9k+T7xqb1FjtjY1nzO0fO4kxgPrqlxAzbaI5dFLbweQlmEd4YwHD+O0kiK74KoK3KfdLEkryZ1G5Je3hqsTQ2+Ms6qJLN32LrQ63wlxuudHWimlq0ht+9xzaqQKM1rqVjml9NAWKrMG/3BC0AhNQ52pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119090; c=relaxed/simple;
	bh=12UraXgOhO1+DKxjW3Y41QHOUND95cJavo13ywtBn1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMlCGhE7c2NUwJK/FlJ+dJ6IzyaZeTQIw4o+qxrNVMYoUJLxA1EFvzT+KMzsMOBV2WZsvlF2LjVysAAr3bLZrJMfl8Zv80ODyXs9fi1VwVpSXQ0teUQiMgZCoQGEU3cxs3J7aPGlnpItm0kfaq6n+ivQ8XkMwiEzMdhkRm3cMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVJMmGbd; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-711009878e2so2018947a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727119088; x=1727723888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQOZDxeBiZ4/EBMkqJytOAhzCR3WJTa2BWTB+lJpGfs=;
        b=cVJMmGbdHgoL0GEb6mIPhYaWkBgjelkk1KfqlMGP+eG+qSbEJlTc88PxBUr6x6PBgs
         cPw6L1aGr3dk9hjQbC5Ac2/R+d1hwY4L+npXvBygiJRt2lhfEd/OIgI4FF5+zIm2Gvyz
         dBDs/5x/F8mWs+CIQnhpIVsrNRXtl/xBdq8Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727119088; x=1727723888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQOZDxeBiZ4/EBMkqJytOAhzCR3WJTa2BWTB+lJpGfs=;
        b=MBcnUEz6rlrIZWV1fdSzkEQEmJlj9ziscJcKL65EVN7Eib6+DpYcAFX+3/7SmhMHdT
         FyoIVrTYfEIek+96pSDMQ5Py+PftvWMaH9Zs+Hoz6cqVdKWJiCDbH4vhnO+y1YteEGEK
         ddh/k8PtNGHxPQKRI73gVD/4leHcgrC7ePhknGpnK6LsQH+9Xs9fRfwmKzWS41T3ITFg
         3JRwExAiBXZqsExC7Y1SdFy71G0O36OBO27BFXqh9LYfCvOo0ax7pMtiY9oypo/HPIy+
         uuvnti98pCTJcUCSSbhqAC5Dxs09zACf+e3sqYqjEZAfNKAGctmv8N41xUums9caajax
         29TA==
X-Forwarded-Encrypted: i=1; AJvYcCXKm5IALIm90VxoZbG2Qyzv9h2ZUZPPLM/m3QHjLn5Gz/3mOLshThwxi21s7QhDgHHPZyDBVdXDtiRVBlPC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RwU8Ks9jO3+az5E8G4mqIMS+1mTjaZPubJVbZXPjRdWIS00L
	qSHESjki2IjCRed024lf2r8RLkvZGA6Q/0jss+BDK8iCHFkUW8qIPwlb/A0rNyc=
X-Google-Smtp-Source: AGHT+IEB7oD+JNpFtZW52HqiwhT6S97TksasAQppSj4aFmR20g6Bc2YLWC2AtEk9zu9i/0uK0NSsTw==
X-Received: by 2002:a05:6830:6016:b0:710:f543:e39b with SMTP id 46e09a7af769-713934b2dcamr8660583a34.18.1727119088270;
        Mon, 23 Sep 2024 12:18:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71389bb30d3sm2386062a34.49.2024.09.23.12.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:18:06 -0700 (PDT)
Message-ID: <06f56247-d2fb-4038-9593-7717a4e7796b@linuxfoundation.org>
Date: Mon, 23 Sep 2024 13:18:05 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, David Gow
 <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 porlando@lkcamp.dev, dpereira@lkcamp.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev>
 <20240923173454.264852-2-gbittencourt@lkcamp.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240923173454.264852-2-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 11:34, Gabriela Bittencourt wrote:
> Instead of creating 'test' functions, use kunit functions to test
> utf-8 support in unicode subsystem.

Can you elaborate on the reefactoring changes. This will help
others who would want to take on such refactoring in the future.

> 
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> ---
>   fs/unicode/.kunitconfig    |   3 +
>   fs/unicode/Kconfig         |   5 +-
>   fs/unicode/Makefile        |   2 +-
>   fs/unicode/utf8-selftest.c | 152 +++++++++++++++++--------------------
>   4 files changed, 76 insertions(+), 86 deletions(-)
>   create mode 100644 fs/unicode/.kunitconfig
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
>   	  be a separate loadable module that gets requested only when a file
>   	  system actually use it.
>   
> -config UNICODE_NORMALIZATION_SELFTEST
> +config UNICODE_NORMALIZATION_KUNIT_TEST
>   	tristate "Test UTF-8 normalization support"
> -	depends on UNICODE
> +	depends on UNICODE && KUNIT
> +	default KUNIT_ALL_TESTS
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index e309afe2b2bb..37bbcbc628a1 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
>   obj-y			+= unicode.o
>   endif
>   obj-$(CONFIG_UNICODE)	+= utf8data.o
> -obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
> +obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
>   
>   unicode-y := utf8-norm.o utf8-core.o
>   
> diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
> index 600e15efe9ed..54ded8db6b1c 100644
> --- a/fs/unicode/utf8-selftest.c
> +++ b/fs/unicode/utf8-selftest.c
> @@ -1,38 +1,18 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Kernel module for testing utf-8 support.
> + * KUnit tests for utf-8 support
>    *
>    * Copyright 2017 Collabora Ltd.
>    */
>   
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
> -#include <linux/module.h>
> -#include <linux/printk.h>
>   #include <linux/unicode.h>
> -#include <linux/dcache.h>
> +#include <kunit/test.h>
>   
>   #include "utf8n.h"
>   
> -static unsigned int failed_tests;
> -static unsigned int total_tests;
> -
>   /* Tests will be based on this version. */
>   #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
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
>   static const struct {
>   	/* UTF-8 strings in this vector _must_ be NULL-terminated. */
>   	unsigned char str[10];
> @@ -158,22 +138,22 @@ static const struct {
>   	}
>   };
>   
> -static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n,
> -		const char *s)
> +static ssize_t utf8len(const struct unicode_map *um, enum utf8_normalization n, const char *s)

Keep "const char *s" on the second line.

>   {
>   	return utf8nlen(um, n, s, (size_t)-1);
>   }
>   

Rest looks good to me.

thanks,
-- Shuah


