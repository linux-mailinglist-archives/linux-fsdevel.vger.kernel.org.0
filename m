Return-Path: <linux-fsdevel+bounces-58386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF97AB2DD00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB53C1BA7530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4233176EB;
	Wed, 20 Aug 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OE5BZSAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC726E175
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693935; cv=none; b=XIvOl8pQcN7Eq+B0AWoCqZk/D0bzPxKPqvX39t9MbSEQ21kuBgu1E/XLfqme1D5vZeVyXMIY0yW56laQ6VxgUc0v5/VZa04g9FojGSjK6VfQpGVQRJt3YP3XSRR4+jpDHs5J1SrBPJNTuh9fKL9eBfyvEo0PassEoWqhREYCHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693935; c=relaxed/simple;
	bh=XGZNUyGClMBZ53/9M+WiiYZ3hnA8W8MXcf7Y6tflI0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgSt1CQFjx/74bfRdDG3M9R6wNfWaEdppHZlNERej858Io7Ix5BBg8FtphHWyUHdftTTllgOWQpH3nVjaSQdo/c5OdHShhS/GtMbVNhoDW5ewaHforvMnjwE6v2iEZ5+2t3ib/de+8+WU55BRYWftq/wqur90dmUGw5sNw14xdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OE5BZSAX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458194d83so47989795ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755693931; x=1756298731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gRhe9SO61ZZX3zSeOGc3YYqkcNZ6w6+wJsLaFnopq8=;
        b=OE5BZSAX++GGBYdUglCKCN9aiZTz/BOimihiEiz6UqZxqXIpP3P0iPTNXkcCGPtecN
         fD0YnTMq1IfRCNY1koLNdTmOR9rOVispxsotIX5llgnihL+yG4fRu5Z4uA9fp2LROz/J
         zODym8rqWAY0HvWueQlfDSYqlGrJSa1N51GHwF1k9GK+4vE6ZSzpmIBLqr6PQWkrSC/J
         DMuSOD8xhMcOQVnOIDsTmhjID7h4OURd9erX+S50qxJiy9oWjXFIJ49U9rroOoanQKoy
         iCc2B2uaouXBcceMkWIaZd4q+kOzwwNU200drxKaXONhd2YgaUbW8pzA1NLdqwBdCK9t
         3TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693931; x=1756298731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gRhe9SO61ZZX3zSeOGc3YYqkcNZ6w6+wJsLaFnopq8=;
        b=f6W5X1ig6aN4h8Jpcv0Vp+SrIPpUcCQOoue33w/TkrsSehJHm11aJPnsT+JG4dOAfB
         HTGSSnudBNGND8eF+I6WfxgH9nwBP9ToCJobg9BNtviAYyhbbxho9x12P7cXQpje1L6Z
         tsIriXvlx4Jc5JcnlnKPQn+TEVbQsI0eArcl7fIrkVZxrXvHSSfU+GhF6zb75O0BBxph
         iMv9B61hYKNVKwhxAKKOU6BQGgy3vZ92phjGYKD1FruMmEOVUmB+B641mprJjKDJr/F6
         lnagMP0YRH0Wx8ZyoUquC/NdPEb1jMWQphfnwtE0DYV4j7UblWeUSqc3aOB4resgXerV
         8toA==
X-Forwarded-Encrypted: i=1; AJvYcCWmeLrXOcflXLR2f8AVAlSd48+7M6d+MtWbqybiG16LP6yBHw8wiUgS1jqWO+IZ2ymh9g0j3Hswuvz0ihtA@vger.kernel.org
X-Gm-Message-State: AOJu0YyluDqDDWZpGCGcD1/OUn7lpt0uSwMwx1MsjLsDnbiVwqVaHlbc
	Js/iWPMmKzubA+0mYd5MbFIx7ruELVpc6JDVKEH7eN+ybszRKNkuGMvkH3iGNKvqlRCdPlhqp9o
	i9wGMZxdOAMWbMz1nrKqLHbl3QDOrcKL0C93gPEOZEg==
X-Gm-Gg: ASbGncv/5gZ5Pkrb32wRDWmVvUnBTBl/q+U3ScX/WdhW+ANiZX/kLkth3fs97JuAg8r
	F+/VKUEAdN9LTXaS1bhcrMZZEEIKyUeX1KshpxEvCD0gbbaSWiuCS5Wyoa8DjLxQ200qYPxy9VQ
	PhWZiXdg0hWm623y5B8je2TEmofI3GL5VXOZxxV3h7md89FT79Ae0ZwXA4VPmS+oSSnkjTqNlkK
	Fe7nLA3j0uLJ6tDmEAnYGX1Y/kWqteaFPJVEvVm/aI9WNclzW0=
X-Google-Smtp-Source: AGHT+IEo6AZMHBNfNm+wGuts2E1fjpomh+rCZIxZABpTnRUGW4TVydP8e55fzi6K1vdQKBnAE9C73PQOIe+rJ5ddIZo=
X-Received: by 2002:a17:902:ebd1:b0:234:9375:e07c with SMTP id
 d9443c01a7336-245ef2716c0mr38415775ad.46.1755693931471; Wed, 20 Aug 2025
 05:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122820.553053307@linuxfoundation.org>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 18:15:19 +0530
X-Gm-Features: Ac12FXzNj44omXAfHJgi9bZ51uoRtB8H1kwROfJrlwowrwNPU6U7fIeg-6nxe0Q
Message-ID: <CA+G9fYuQ_eHhoWsVdQpbmOSS-e_5BQzpar8Sjvtps41fUbknzA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, LTP List <ltp@lists.linux.it>, 
	Jan Kara <jack@suse.cz>, linux-ext4 <linux-ext4@vger.kernel.org>, Jann Horn <jannh@google.com>, 
	Jan Stancek <jstancek@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As we discussed from the last time LTP syscalls epoll_ctl04 is a known issue
on the Linus master and Linux next.

* ltp-syscalls
  - epoll_ctl04

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1)
The bisection results pointing to

First bad commit,
eventpoll: Fix semi-unbounded recursion
commit f2e467a48287c868818085aa35389a224d226732 upstream.

2)
A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
- https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/
- https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.41-808-ge80021fb2304/ltp-syscalls/epoll_ctl04/

## Build
* kernel: 6.12.43-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: e80021fb2304b3e1f96e7b9a132e69d2c1d022f1
* git describe: v6.12.41-808-ge80021fb2304
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.41-808-ge80021fb2304

## Test Regressions (compared to v6.12.41-370-g3566c7a6291d)
* ltp-syscalls
  - epoll_ctl04

## Metric Regressions (compared to v6.12.41-370-g3566c7a6291d)

## Test Fixes (compared to v6.12.41-370-g3566c7a6291d)

## Metric Fixes (compared to v6.12.41-370-g3566c7a6291d)

## Test result summary
total: 284700, pass: 268768, fail: 4803, skip: 10936, xfail: 193

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 40 passed, 0 failed
* riscv: 25 total, 22 passed, 3 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-fpu
* kselftest-futex
* kselftest-intel_pstate
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* lava
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* modules
* perf
* rcutorture
* rt-tests-cyclicdeadline
* rt-tests-pi-stress
* rt-tests-pmqtest
* rt-tests-rt-migrate-test
* rt-tests-signaltest

--
Linaro LKFT
https://lkft.linaro.org

