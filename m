Return-Path: <linux-fsdevel+bounces-65378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B6C03290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 21:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FF4C4EEBBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9034CFC6;
	Thu, 23 Oct 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7Xf6P6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154E34BA2A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247222; cv=none; b=LJQdeQgqLaXy5Cix1O47/QWRNYidHxCzGHCFmTrq6lBiXDukJoUoW381BXeBtdoucRfqk4WUqlwZrA8fhQF1ygJd7hJxoiopc2PbY346fL+em6MM+MdAdUc7VKXlOwDzG8PEAa9Js3G364NMrEAy58sHHrZkQExkKa//JH1EhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247222; c=relaxed/simple;
	bh=SpBV0oAtNIOIUcUxfTe6GOHXwqQoTjBsdOw0X372+0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPUjSykFEVm7Q6A2FRQ/PJ0ksqmbViq+33E7UFslBZsXmr435NAr/H+TaurIlVAboYWGTHNVXtgyR2o0BAzW4XkQiOM9X5OIv13oFh1l5hMc2UJ4fISBDWZ2592vkApwJZOcq9xoP+8TGNKsrNmRxCTMb3xMRrTvcqLgqM9XrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7Xf6P6d; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c2b5ccd95so1917936d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761247219; x=1761852019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
        b=X7Xf6P6dP0Byre5wcouvB+FsXlRFa1pYYuzRZ8DZm2Ixle7Da8KRHFGmsuJQab2MML
         9NCFD61It4E11upuMIFEwxr6eeF9T+VVyOZw8h0twTVgsUd5HNzZWYPfF6Me/wTvv82U
         TpQ9tdKBEiCUoLyqPKRuSLSHr2cAfQIkXzgHDxGLaqGkuVFnYEZKcTm1dfqqv5KQ3uuN
         w/P/C3h18Xo5rJJsmWsogCdMsa1OdLfnLGWRWs4WVfOf2h+rGG6SfNNjIyfIvTwNg4QH
         16BE/HCk/0Oya74IvXr++1JP1vQZo7ujzdDpw7rC5WBZsIhCcCK/HzlzB4wyRnEVwsfe
         gtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247219; x=1761852019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
        b=XC98JrW+2wm4pxQjNjRq4IxYeZoCcw9m9Nr6qsW2JIwHfiXU+WG89PS/XHpjAN6oSr
         YZ5veo2pbnutSWwmHMbBbSTcVz8w8/5sjKiS9XC2JbHmBUyqEag5DaHhSYSJbnrxKPtq
         WlH4GJGRxzowaSWZoxpB93CQcjEa2GHbTay+NwUtmNE7sHTR00gyjJKgNOfmWRkYaazH
         /JvuooiWuKlLxM4T+NypCtFqi1BFI66+pgA7u7DikHmPjEEMFy5tzcccb80YBXFQGJnz
         Gp7syuoWzP7S3XJ4Lz0I/PLSkoiYi02Iks9NQ0z0iOwouwhwGOMEwJT4YKXNhm38NvY1
         2sDg==
X-Forwarded-Encrypted: i=1; AJvYcCXq+3pgVVzdWW/Z7JcumhNxViEBzl0lsHVICQRs80aLmdEmKmtbz9rvceJoiLnaI6VNWaLYZlE48Aog6mau@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3X5tQUDs+3sFrPmQSx9+PtzURsC/lqG/Xl7eqqvPbILzjMfb
	lBgqUO8rbhtpYuBnOXB87lwoE7ktET13OMmgSdOBJzf7x5im8aOfGOZbpfTQ8UDjjNSfRbk6eCX
	FVnIfbX7e2Mc/XtBMz5SnmCOIJxkPHySSaZwgCHp2SA==
X-Gm-Gg: ASbGnctSNj1lyKJUDwEKj4IJMuq1RJXyFDuhldxwyXoCjaN3vRFve2sdprgzGcnduWB
	5PJKO8zll+ewrodAfWxNsB2F+bk1ra3SLzP8Lkjyuz+x2N/8t0SOd+UEykIdA9XxR+9X8FK9AHG
	bzf/cja3JOlOpm/DrgIavkRKnsDlbGQxrO5JQC+qGSxVki5Z5LsmgiYciX1xTMLc7R26MUpf+uk
	XQwtdKJtTV3POVHuFl3gnWYSEDM63Yo1mtffXmq4Gw3t8b1+ZZtV1ZkpOO2Ruw+sGy6hw==
X-Google-Smtp-Source: AGHT+IGkQvnw+P4oceXyA5t5qG3cgWb0laXxzyqv1FiNzsffgaXuAVfp39vbfz48HT80gEehZCMHTKqYfeFUsV9baTU=
X-Received: by 2002:ad4:5b87:0:b0:87c:21db:cbbf with SMTP id
 6a1803df08f44-87de714bf08mr100164216d6.4.1761247219089; Thu, 23 Oct 2025
 12:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
In-Reply-To: <20251023164401.302967-1-naresh.kamboju@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 23 Oct 2025 21:20:06 +0200
X-Gm-Features: AWmQ_bm15EalXbAnjLs4CmLjdIsxVVIbblnMfG02uQMZQ8ouizbiUwGmA3HVblI
Message-ID: <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
Subject: Re: [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp@lists.linux.it, lkft@linaro.org, arnd@kernel.org, 
	dan.carpenter@linaro.org, pvorel@suse.cz, jack@suse.cz, brauner@kernel.org, 
	chrubis@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev, aalbersh@kernel.org, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, benjamin.copeland@linaro.org, 
	andrea.cervesato@suse.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 18:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> test to accept both EINVAL and ENOTTY as valid errors to ensure
> compatibility across different kernel versions.
>
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Verified this on arm64, and the test passed now.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index d20c6f074..744f7def4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,8 +4,8 @@
>   */
>
>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> - * happens when:
> + * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
> + * PIDFD_GET_INFO is used. This happens when:
>   *
>   * - info parameter is NULL
>   * - info parameter is providing the wrong size
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"
>
>  struct pidfd_info_invalid {
> @@ -43,7 +44,12 @@ static void run(void)
>                 exit(0);
>
>         TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -       TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +
> +       /* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
> +       int exp_errnos[] = {EINVAL, ENOTTY};
> +
> +       TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
> +                       exp_errnos, ARRAY_SIZE(exp_errnos));
>
>         SAFE_CLOSE(pidfd);
>  }
> --
> 2.43.0
>

