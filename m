Return-Path: <linux-fsdevel+bounces-45291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564EA75977
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 12:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DF17A4B97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7A1A9B3F;
	Sun, 30 Mar 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAakoS4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C536182D7;
	Sun, 30 Mar 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743329594; cv=none; b=SitFuszHLqOp496OH/b01uy39zNHsEYVC6xxHukEcJ8LtcuYydSeepw4TN+PF98slRWG7e9yda9NqRB3vYaZ36NRijWMVS2r/Zl4hiE1WPXHyRScctNcbM01JGbfUz5aDgL57ZBd06690gIkFyHlh/p63ObpMJPFEbyNqqhtZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743329594; c=relaxed/simple;
	bh=nrSbd1Y0/JNmHa7lLqKKSOfC0KJtyzcdY7kzB1BTCw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lByb6Cfw+Wkv3n+U21lhhuvIgbdKqkKKjmSjl8QT9bCJSrNh2UjSbdOisp4jOdzoNQ8OH2XrfrmtZNz6CnPztnJ9tdiZXpE1PDmChofP8h3gpCmgR/I0+zACthUmAPwxmpzlV0HUEILxmUGS05/zuSutjbBpIkg0E1ci1gaYVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAakoS4u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso16299665e9.3;
        Sun, 30 Mar 2025 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743329591; x=1743934391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iY7yrrdvISazNlShWIODoM0MaB96GvKwZG5MmcHKFQs=;
        b=PAakoS4ud0qAPI1ITD4ukWjbwD2nLNh8ejEplTZxYxsipPf+XC/8cDkeksifJNk+qo
         8dUeJoUZOxRFKQ0ZG92H2X4HUsZFZpAvR4A1zq6TSoM2JMtTOC0WLm7BFHEYLinhCeQ8
         J6IoOJVms6hZTUe0EFKy9ldWapomtqWGyVRH/dJG842fpp1XGhocvSMkaOYj/J3Wk5oZ
         fRuJ6DPr0s+ESaUmiZwoUndDYMpKHVwkldRMT+SP8cilkeMnko/fqDSAs/emv4bZFWyB
         tgcJiyuEXFI1amH5Z5zVkMmWZq7YWEnqjA6lUV/ZGMHItEQPK1Y6mUKgan+L35Rz/6Pe
         jiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743329591; x=1743934391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY7yrrdvISazNlShWIODoM0MaB96GvKwZG5MmcHKFQs=;
        b=wnfL/Huu0bUySzOo2+zGl2gHpx6aiQ4Dlu3SkDkPJyLBFfFY8k6cVoAFX04p47Ufak
         p02FkR1Rxee2tCB5bDBn5b/VFqFmdB1P/nbFqUTn25bdyR52rFKv0k2JzjsrEKahSn6O
         6YRVQT5HuEXyCjU4KhY758EQK+EjZ5A4zE+XXjw5iDlmcvh+KwXo66C+lE7Ycq4y/W6P
         p87zQ30zwEK6mzJ4NKPulDel2fzF3PFwAE5vIW6dnC6yZW4cbqznvLmKlDAp8D8irI+H
         w4zKpZRVZqlx8KII00pZYlo4Wko1PWgDZdU2cMqwW+RukPYLMANBnIZQD4exETnanxdz
         UycA==
X-Forwarded-Encrypted: i=1; AJvYcCUbRSRngVnAKp7MHkpHjiArBAea/jrQCDoyOz1JmYmTFTTJ5r9rcULkBockxaI0q2lnT7Was1Yw33ato7pA@vger.kernel.org, AJvYcCV7V8yeCGtjKmTL5QEJ0IX35IPjqE7ruhnWwKGe4NB5pAkoYtmQcqLMJn23uV/sd71sUO5bp3DRmQg/NSry@vger.kernel.org, AJvYcCVc/u0pS6fKe6s/IOAKL2VUof57mvBebse7+qNXjVYBUjPETmawr+SPY5qfRWggIIED9OVRddVgwFNJm/DNlzonug779+uL@vger.kernel.org, AJvYcCVyzAChXpJT/9oIoMZCZsKuiqoqemPtymL9pRCJO3DWF5kcKCFdAVnKeVjkA+Wul21BXYsZGroE@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMXsNwr05CZnPG77fclBg1LJMes/9Ls0xNFYvS+Ec3dRtXjn8
	B3fbOZsFHOjq6jZ8coiykkR1tbH8cN5lsOyEkzyETQbris3qRjgO
X-Gm-Gg: ASbGncvtKawakvRQnpG/fd1rtN+YcAunPlc1+3DwtsyT8jilu5wHbjCnm3nXdpJB3fw
	vWJCPvIHTSEIaAT7+Xse/iwYhYnqaW/2VPviKXEGlAEBvdBauZfB0qaTA8MrawKrPfkSX9Kfmia
	DZBZay+rUBMgNVa/40glsalP4KAMiqZ8rkbGItTLDsG56fR/Phuk2Wt93dX5fwcA4FiozI4cW1f
	LSjVTvR7A6ijNTbKWa8j1VId5Ud0xv291CnfCxPmWIqNvrTPt7o9nlhLHLJujV0Wtk877kkkbmJ
	Mt6Ybh+lTVtfNEaujFkdqpBtKkLPsRgnR2e4It8fzoXh8uLj7wGKSk2VurOLjf2AyTIyssv12a0
	cv1GLlQ==
X-Google-Smtp-Source: AGHT+IE1wxmQc25mNUu4Jcxhad18fpgq/crHJcuOcr58vtmB4+AR/Me1e1L60qK+zcO4NsDK/wxr7Q==
X-Received: by 2002:a05:600c:34ce:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-43dabe23634mr53152255e9.0.1743329590399;
        Sun, 30 Mar 2025 03:13:10 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d82efdff2sm130839155e9.17.2025.03.30.03.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 03:13:09 -0700 (PDT)
Date: Sun, 30 Mar 2025 12:13:08 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] landlock: Add the errata interface
Message-ID: <20250330.de9cd57f3cd0@gnoack.org>
References: <20250318161443.279194-1-mic@digikod.net>
 <20250318161443.279194-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318161443.279194-3-mic@digikod.net>

Hello!

Thanks for these patches!  An explicit errata versioning is a good
idea.  With that, I could change the Go-Landlock library to only use
the "V6" level ABI on kernels where the signal erratum is present, so
that the libpsx(3)/nptl(7) hacks continue to work.

The userspace API for this looks good to me as well (except for that I
wonder whether we should not expose errata numbers as constants in the
uapi header)?

Regarding internal implementation, splitting the errata definitions up
into multiple headers feels complicated compared to the naive solution
and it's not entirely clear to me what the purpose is (see below).
(Resolving merge conflicts is normally the job of the downstream
kernel maintainers when doing a cherry pick, and the merge conflicts
don't sound too complicated in this case?)


On Tue, Mar 18, 2025 at 05:14:37PM +0100, Mickaël Salaün wrote:
> Some fixes may require user space to check if they are applied on the
> running kernel before using a specific feature.  For instance, this
> applies when a restriction was previously too restrictive and is now
> getting relaxed (e.g. for compatibility reasons).  However, non-visible
> changes for legitimate use (e.g. security fixes) do not require an
> erratum.
> 
> Because fixes are backported down to a specific Landlock ABI, we need a
> way to avoid cherry-pick conflicts.  The solution is to only update a
> file related to the lower ABI impacted by this issue.  All the ABI files
> are then used to create a bitmask of fixes.

I do not fully understand the underlying purpose here.

In this commit, the errata.h header includes errata/abi-[1234].h.  If
this patch can be backported to the first version of Landlock (as the
commit message says), 4 seems like an arbitrary limit, which is
"including headers from the future", in the kernel that it gets
backported to.

If future errata patches (like the one for signals) need to extend the
list of ABIs in errata.h anyway, doesn't that create the same kinds of
potential merge conflicts which we tried to avoid by splitting up the
errata lists into errata/abi-?.h?


What problem are you addressing with the scheme of splitting up the
errata/abi-?.h files?

 (A) Reduced merge conflicts at backporting time?

 (B) Catching the case where a errata patch gets applied to a too old
     kernel for it to make sense?

 (C) Something else that I did not see?


Is there a cherry picking error scenario which can slip through if we
were to use a simpler scheme for storing errata?  The most naive way
would be:

const int landlock_errata = 0 \
	| LANDLOCK_ERRATA_TCP_SOCKET_IDENTIFICATION \
        | LANDLOCK_ERRATA_CROSS_THREAD_SIGNALING \
        ;

In scenario (A), the merge conflict in the definition of
landlock_errata would at worst be a one liner in that const
definition, which sounds doable?  (Obviously, there can still be merge
conflicts in the feature code, that is unavoidable.)

In scenario (B), it is likely to result in a merge conflict in the
feature code anyway?  (The signal code and networking code must
already be there, in order to apply a small change to them.)


> The new errata interface is similar to the one used to get the supported
> Landlock ABI version, but it returns a bitmask instead because the order
> of fixes may not match the order of versions, and not all fixes may
> apply to all versions.
> 
> The actual errata will come with dedicated commits.  The description is
> not actually used in the code but serves as documentation.
> 
> Create the landlock_abi_version symbol and use its value to check errata
> consistency.
> 
> Update test_base's create_ruleset_checks_ordering tests and add errata
> tests.
> 
> This commit is backportable down to the first version of Landlock.
> 
> Fixes: 3532b0b4352c ("landlock: Enable user space to infer supported features")
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250318161443.279194-3-mic@digikod.net
> ---
> 
> Changes since v1:
> - New patch.
> ---
>  include/uapi/linux/landlock.h                |  2 +
>  security/landlock/errata.h                   | 87 ++++++++++++++++++++
>  security/landlock/setup.c                    | 30 +++++++
>  security/landlock/setup.h                    |  3 +
>  security/landlock/syscalls.c                 | 22 ++++-
>  tools/testing/selftests/landlock/base_test.c | 38 ++++++++-
>  6 files changed, 177 insertions(+), 5 deletions(-)
>  create mode 100644 security/landlock/errata.h
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index e1d2c27533b4..8806a132d7b8 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -57,9 +57,11 @@ struct landlock_ruleset_attr {
>   *
>   * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
>   *   version.
> + * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
>   */
>  /* clang-format off */
>  #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
> +#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/errata.h b/security/landlock/errata.h
> new file mode 100644
> index 000000000000..f26b28b9873d
> --- /dev/null
> +++ b/security/landlock/errata.h
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock - Errata information
> + *
> + * Copyright © 2025 Microsoft Corporation
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_ERRATA_H
> +#define _SECURITY_LANDLOCK_ERRATA_H
> +
> +#include <linux/init.h>
> +
> +struct landlock_erratum {
> +	const int abi;
> +	const u8 number;
> +};
> +
> +/* clang-format off */
> +#define LANDLOCK_ERRATUM(NUMBER) \
> +	{ \
> +		.abi = LANDLOCK_ERRATA_ABI, \
> +		.number = NUMBER, \
> +	},
> +/* clang-format on */
> +
> +/*
> + * Some fixes may require user space to check if they are applied on the running
> + * kernel before using a specific feature.  For instance, this applies when a
> + * restriction was previously too restrictive and is now getting relaxed (for
> + * compatibility or semantic reasons).  However, non-visible changes for
> + * legitimate use (e.g. security fixes) do not require an erratum.
> + */
> +static const struct landlock_erratum landlock_errata_init[] __initconst = {
> +
> +/*
> + * Only Sparse may not implement __has_include.  If a compiler does not
> + * implement __has_include, a warning will be printed at boot time (see
> + * setup.c).
> + */
> +#ifdef __has_include
> +
> +#define LANDLOCK_ERRATA_ABI 1
> +#if __has_include("errata/abi-1.h")
> +#include "errata/abi-1.h"
> +#endif
> +#undef LANDLOCK_ERRATA_ABI
> +
> +#define LANDLOCK_ERRATA_ABI 2
> +#if __has_include("errata/abi-2.h")
> +#include "errata/abi-2.h"
> +#endif
> +#undef LANDLOCK_ERRATA_ABI
> +
> +#define LANDLOCK_ERRATA_ABI 3
> +#if __has_include("errata/abi-3.h")
> +#include "errata/abi-3.h"
> +#endif
> +#undef LANDLOCK_ERRATA_ABI
> +
> +#define LANDLOCK_ERRATA_ABI 4
> +#if __has_include("errata/abi-4.h")
> +#include "errata/abi-4.h"
> +#endif
> +#undef LANDLOCK_ERRATA_ABI


> +
> +/*
> + * For each new erratum, we need to include all the ABI files up to the impacted
> + * ABI to make all potential future intermediate errata easy to backport.
> + *
> + * If such change involves more than one ABI addition, then it must be in a
> + * dedicated commit with the same Fixes tag as used for the actual fix.
> + *
> + * Each commit creating a new security/landlock/errata/abi-*.h file must have a
> + * Depends-on tag to reference the commit that previously added the line to
> + * include this new file, except if the original Fixes tag is enough.
> + *
> + * Each erratum must be documented in its related ABI file, and a dedicated
> + * commit must update Documentation/userspace-api/landlock.rst to include this
> + * erratum.  This commit will not be backported.
> + */
> +
> +#endif
> +
> +	{}
> +};
> +
> +#endif /* _SECURITY_LANDLOCK_ERRATA_H */
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index c71832a8e369..0c85ea27e409 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -6,12 +6,14 @@
>   * Copyright © 2018-2020 ANSSI
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/init.h>
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
>  
>  #include "common.h"
>  #include "cred.h"
> +#include "errata.h"
>  #include "fs.h"
>  #include "net.h"
>  #include "setup.h"
> @@ -31,8 +33,36 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
>  	.lbs_superblock = sizeof(struct landlock_superblock_security),
>  };
>  
> +int landlock_errata __ro_after_init;
> +
> +static void __init compute_errata(void)
> +{
> +	size_t i;
> +
> +#ifndef __has_include
> +	/*
> +	 * This is a safeguard to make sure the compiler implements
> +	 * __has_include (see errata.h).
> +	 */
> +	WARN_ON_ONCE(1);
> +	return;
> +#endif
> +
> +	for (i = 0; landlock_errata_init[i].number; i++) {
> +		const int prev_errata = landlock_errata;
> +
> +		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
> +				 landlock_abi_version))
> +			continue;

IIUC, if we hit this condition, someone has tried to backport an
erratum that does not apply here?  Shouldn't this ideally be a compile
time error?  Then downstream kernel maintainers would notice it
earlier when they apply the wrong patch?

Can this scenario really happen?  It feels that this should normally
already be caught in merge conflicts at cherry picking time?


> +
> +		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
> +		WARN_ON_ONCE(prev_errata == landlock_errata);
> +	}
> +}
> +
>  static int __init landlock_init(void)
>  {
> +	compute_errata();
>  	landlock_add_cred_hooks();
>  	landlock_add_task_hooks();
>  	landlock_add_fs_hooks();
> diff --git a/security/landlock/setup.h b/security/landlock/setup.h
> index c4252d46d49d..fca307c35fee 100644
> --- a/security/landlock/setup.h
> +++ b/security/landlock/setup.h
> @@ -11,7 +11,10 @@
>  
>  #include <linux/lsm_hooks.h>
>  
> +extern const int landlock_abi_version;
> +
>  extern bool landlock_initialized;
> +extern int landlock_errata;
>  
>  extern struct lsm_blob_sizes landlock_blob_sizes;
>  extern const struct lsm_id landlock_lsmid;
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index a9760d252fc2..cf9e0483e542 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -160,7 +160,9 @@ static const struct file_operations ruleset_fops = {
>   *        the new ruleset.
>   * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
>   *        backward and forward compatibility).
> - * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
> + * @flags: Supported value:
> + *         - %LANDLOCK_CREATE_RULESET_VERSION
> + *         - %LANDLOCK_CREATE_RULESET_ERRATA
>   *
>   * This system call enables to create a new Landlock ruleset, and returns the
>   * related file descriptor on success.
> @@ -169,6 +171,10 @@ static const struct file_operations ruleset_fops = {
>   * 0, then the returned value is the highest supported Landlock ABI version
>   * (starting at 1).
>   *
> + * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
> + * 0, then the returned value is a bitmask of fixed issues for the current
> + * Landlock ABI version.

We should probably say here where that list is defined.

Should the errata numbers also be constants in the
uapi/linux/landlock.h header?

> + *
>   * Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> @@ -192,9 +198,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  		return -EOPNOTSUPP;
>  
>  	if (flags) {
> -		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
> -		    !size)
> -			return LANDLOCK_ABI_VERSION;
> +		if (attr || size)
> +			return -EINVAL;
> +
> +		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
> +			return landlock_abi_version;
> +
> +		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
> +			return landlock_errata;
> +
>  		return -EINVAL;
>  	}
>  
> @@ -235,6 +247,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	return ruleset_fd;
>  }
>  
> +const int landlock_abi_version = LANDLOCK_ABI_VERSION;
> +
>  /*
>   * Returns an owned ruleset from a FD. It is thus needed to call
>   * landlock_put_ruleset() on the return value.
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 1bc16fde2e8a..c0abadd0bbbe 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -98,10 +98,46 @@ TEST(abi_version)
>  	ASSERT_EQ(EINVAL, errno);
>  }
>  
> +TEST(errata)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> +	};
> +	int errata;
> +
> +	errata = landlock_create_ruleset(NULL, 0,
> +					 LANDLOCK_CREATE_RULESET_ERRATA);
> +	/* The errata bitmask will not be backported to tests. */
> +	ASSERT_LE(0, errata);
> +	TH_LOG("errata: 0x%x", errata);
> +
> +	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> +					      LANDLOCK_CREATE_RULESET_ERRATA));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
> +					      LANDLOCK_CREATE_RULESET_ERRATA));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(-1,
> +		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
> +					  LANDLOCK_CREATE_RULESET_ERRATA));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(-1, landlock_create_ruleset(
> +			      NULL, 0,
> +			      LANDLOCK_CREATE_RULESET_VERSION |
> +				      LANDLOCK_CREATE_RULESET_ERRATA));
> +	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
> +					      LANDLOCK_CREATE_RULESET_ERRATA |
> +						      1 << 31));
> +	ASSERT_EQ(EINVAL, errno);

There are two calls to landlock_create_ruleset() here, but only one
ASSERT_EQ(EINVAL, errno).  I do not understand why the second call to
landlock_create_ruleset() was done here (with the | 1 << 31) -- was
that left here by accident?


> +}
> +
>  /* Tests ordering of syscall argument checks. */
>  TEST(create_ruleset_checks_ordering)
>  {
> -	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
> +	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
>  	const int invalid_flag = last_flag << 1;
>  	int ruleset_fd;
>  	const struct landlock_ruleset_attr ruleset_attr = {
> -- 
> 2.48.1
> 

–Günther

