Return-Path: <linux-fsdevel+bounces-64432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82402BE7C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B96018868BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA5312829;
	Fri, 17 Oct 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/q5tp5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06392D640F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692845; cv=none; b=DitMxUWxI2I3HkIqK0gQ51L3Z24n2oqILgR0FaReTQisUDlG+eTV6pXkq8vVAO5hYf+qkXfYNKvQhGsmiI7IdeyUsZBeFK1OLTg+4qSvUKOLkC8TSJBxFxu/uQiTvsMWsCBASV6wFdWktMyGzTvmHtYM6d4b0ywfVRgSibkL910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692845; c=relaxed/simple;
	bh=arpQCWK126GMa9425WGmA2NWCbIvN4MCYLjOgF9A6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT1KSTyZscJ6tlLr0vSx7zwBHuTBmKpkfRtbhOGfD3FQ65bdRqehFzS4g6ytT2/X/UcRP0af7iv6RHf7SEk+GWoHMLGZ1/y+ZMPl8Ef9sJOZ1wPJzcyv2yyx6uIUY1AvcIsKBJmuKsebhgzGph14Nz5IQVCwB+eljpxiReGE+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/q5tp5/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290d4d421f6so5775505ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760692843; x=1761297643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
        b=j/q5tp5/kRtLiFIkzt8qE92PeYtgHPsmLnUNlT/g06UQpfj3VMoKEmDiTLthbV8mNL
         KyxzXq+FgoknaGFEwrayiZ/WIA50n31v24ldR8sntyfaCSE9Sg3gS++ui+xiRHJYRE0e
         +vV83x8tNXBXNYgTzaCxV/rYH3SR8klrETwl3FVGgimkDKIln2eRAPSMsUehJ8vm9bnd
         QHDdlX1y88BvxZJmFTAMjTWSStE3kQxOgWmIa/KtOPABvnHMSmLS95cUtXErzIp8IWFN
         g+t+c8UU2tgqLjCD4dMfSCO2d8JVPcqwbN+I5LRa+MV7/VS0oOCovEpFjygrIaYti4Fe
         hcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692843; x=1761297643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhknjiEqyUugoHigEu5rPV98JBjQEuOdpnABFTzWfmA=;
        b=g8guoyz6U816K6rgwkaWbVYuG8pUZZBkGT1mln7ubJQFgJ9dqrAeRHmHlQBLhbOf97
         ThtCSVTcRkF3Wry3WSCtTDZlYWpR2xFImXb8GEQm6HriB3varitWuic5+UB812OUDSB9
         +RvnACmiJ0Tu0A6OqZ8nOrBXDNgSVopH6/zFtUGF6MrjjcPZUVF2bW7cVna1qooic+p8
         ELsbRhhQ+DHMtoIRs3iYhzZ9PenSC+O5R/HlW5CAH3I5jQy67ilfURi3aXMFbHXBeKm7
         fF3ky6MJxyFz37UYFU3U78BZz7Y2CqrMGDk1/3hCp7U0AOfclJPS+GuSZPTFZdsiNJGP
         vA3w==
X-Forwarded-Encrypted: i=1; AJvYcCW0tQg6KfH74GvRdB16zAAkPQi9eKtbQbtJYXOVcwwBnHq30HxMxtvY+AksIOqGK40E6DhGj0A+9HDqUlxR@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiPjApogDWkUmH5bCPuyiKrO1ticr4muyMl8VloAFy5WlDcDP
	E+I9qd/xMOT2lEX5WvDqUx694D1ama1HmQpDWSXIElQL0nqTpKRmQmfFTjhNS7JEXVGEO72yLQi
	06dhbCCkWgbOLwAzKA4RengUNhOamPiEPSXFv9K+wsw==
X-Gm-Gg: ASbGncuAnqGkqMZxji4sD7svC6InywxP+22BuOs9cE2Mk1Vq3jNasan1mVGmST/W8t2
	gJwCkD3h+c53sItMUx2mO04YDr87Tg4q6IrVbAnm8qPLPOEKxe6TEP0Y5oy2LD6ffu8X9wJ29IH
	MUgQ/j1LTsAIxiE/2QdC8OINdBvN4YiHm4X8nX/Muok1Xf012cEaOIbQWsMvpyatEKYCZjF+MOJ
	Oqr0YeyinJr59UDqUOQFhxzoC0Dl/cuFXBZhih57nvmr3lD0eCPn7mZVS4vWgrsrgZr8bUPMgV9
	R/kelappwmzZjP4CtHVBQeSb8a9pv/+A+8QLhdiXRbuA2KF+ww==
X-Google-Smtp-Source: AGHT+IH8McWMlP4j6h/In61PzhIcYXxJLdaulFUt4hQVbIPHKC+IElEF8O1paYDYvmL7uBRRfha5zKIJziU3JZlwoqY=
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id
 d9443c01a7336-290cb65b633mr37181575ad.47.1760692843202; Fri, 17 Oct 2025
 02:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
In-Reply-To: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Oct 2025 14:50:31 +0530
X-Gm-Features: AS18NWDlNGurivO1eFZTkxH5OkdGuvePuO7Z9_9bbaV5WCId2Ea8RDnwy82C9Ic
Message-ID: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
Subject: Re: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	LTP List <ltp@lists.linux.it>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, chrubis <chrubis@suse.cz>, 
	Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="UTF-8"

+ LTP mailing list,

On Fri, 17 Oct 2025 at 14:21, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The LTP syscalls ioctl_pidfd05 test failed due to following error on
> the Linux mainline
> kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.
>
> The Test case is expecting to fail with EINVAL but found ENOTTY.

[Not a kernel regression]

From the recent LTP upgrade we have newly added test cases,
ioctl_pidfd()

The test case is meant to test,

Add ioctl_pidfd05 test
Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
 is used.
 This happens when:
   - info parameter is NULL
   - info parameter is providing the wrong size

However, we need to investigate the reason for failure.

Test case: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c

>
> Please investigate this reported regression.
>
> First seen on v6.18-rc1-104-g7ea30958b305
> Good: 6.18.0-rc1
> Bad: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Test regressions: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL:
> ENOTTY (25)
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Test error log
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_test.c:2021: TINFO: LTP version: 20250930
> tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> @1760657272 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> which might slow the execution
> tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> info_invalid) expected EINVAL: ENOTTY (25)
> Summary:
> passed   1
> failed   1
>
> ## Source
> * Kernel version: 6.18.0-rc1
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> * Git describe: v6.18-rc1-104-g98ac9cc4b445
> * Git commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
> * Architectures: arm64, x86_64
> * Toolchains: gcc-13 clang
> * Kconfigs: defconfig+lkftconfig
>
> ## Build
> * Test log: https://lkft.validation.linaro.org/scheduler/job/8495154#L15590
> * Test details:
> https://regressions.linaro.org/lkft/linux-mainline-master/v6.18-rc1-104-g98ac9cc4b445/ltp-syscalls/ioctl_pidfd05/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/34AVGrBMrEy9qh7gqsguINdUFFt
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/config
>
> --
> Linaro LKFT

- Naresh

