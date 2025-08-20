Return-Path: <linux-fsdevel+bounces-58375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889CFB2DAAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F376188CEC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B42E3AF0;
	Wed, 20 Aug 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOvYr5aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEE2E3398
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688493; cv=none; b=fM7tkLpicosV2OyWIU+j7b4ucsjbpSpFopj+eOt2gn+acqkSyGNFOBeU+Gl/0cLhFb3drccAs2h3vnLjj1iTvTCL2p6pNoSRrirCbsh6XNKVQ7rYxmIjGTUPl74fFKsxAIja9/dowFDvjAfYCsJvF633vX/UAhjnctVyG9aJSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688493; c=relaxed/simple;
	bh=JSFKobTmz1wlX0LBVxD/GtDDLAOdc5A1YFhf79D2av4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgHn3NPTt5xvBJntg25fP7qVMhBZAOuiQJA6NHTzbnzNSHVVHUBkQ5M1j739XBLLpSfs7TNVP4YbdXlAnUFsu3AV5s8nEkb7y0Bv3y2rjEqiwHBWyb0Ypv9OyS/QBvZXeMvHDjwwG9yh0NSMUiC5yJOJThVnte9UB0YqVEZ8JLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aOvYr5aq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47174c8e45so5635181a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755688491; x=1756293291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muBzYbQwxrYcHt2ZzYNW1McoBEsmE8ndMXrCYhBaxoI=;
        b=aOvYr5aqIujtfmQMkNSj6c9Dz6wMD0kXT2KtgAwcNtD1+HPfVo08Ce/BxZtDsAw2Po
         PcfR4x6kBqzZc39v5NRsx5YkjUOlbqGT99MguhRMnkDNhQ1lAKTMirFZb0NxphcyrepZ
         QLDIQyvYAV7dGo49V7skUv78f+HkXe/TR+BBdMvwbwSvWMyOk5n63lB2AkEBjFsepp+w
         riKP62q/J3MFKdHfxMYDNHNh3oYyG817pg242VcPWb5cRHkgsqdnqMLQcVeDkhp7dUuA
         4V4esyEbU/hJvIPBmLPEssY6MKFPGz8kW1+BtyFJFLJpiiaOKFGcz3HEDKOowCStppvf
         KDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688491; x=1756293291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muBzYbQwxrYcHt2ZzYNW1McoBEsmE8ndMXrCYhBaxoI=;
        b=xAg0OX/Z1fSgJZHqImXYD8W8RmxJ2J3t+2bVwWoKP+D7gCQdNcNgMt6YWX3/eg2FEW
         +Df59ZkDSVoj6iEdykM05aOzj/wJpMAl/nLrq6hytgcJ2uewhdvp70WFL+8oLC1FHtAO
         IQ6DuAAd0NA9JDPNUebizpzm7mlvA6+YXsB8K3lzD5dD/Nrb/Y6HLIgMfKpFZLC8p2NI
         ZTKF+a7O3SlNsLH8WNmXcbn2RLiUZ1wThzSIHXx1fqviEv6esFE57LuW6R5o4/n2Qfi1
         8nN7zX/BF2jdaAD97D+pmCuny1gUbDD/Rmp3Z8uOw2a8nGnRmMWtIyQEKRbMj4SYViHI
         7IAw==
X-Forwarded-Encrypted: i=1; AJvYcCVU7kHj8yG4YJlmqqJBz8Snd/Mc2rf2t1BbTtBu5fGjRSutqljOw7+C+TXRkim/IiMJhrVKk7u9PIOPf8xy@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpjMZY4Rq0OziHiMmZ7b5Fq8UbRBxOYagkYI4C5AhErZ7Jxv+
	Q8piLAk2fd3XEs0arvognzGhErgeK/v8abvpX10AivG4iE+2cQJivnp3gAtC+RRWoiUd8UNRaLM
	ABS0OtWMtBzIjCbq6bXW4jd7/+mxRsbt0mvothb1eQA==
X-Gm-Gg: ASbGncs6g7sA9DSFaFWP8Eb5MZynkjNrxPJlMbhHZcJZrO/q/IKpll+PTi/uVFLtK2Q
	gbKUku48o9Q4lE74HaI+tK/AsF7pfz/SoMAK/1PDaZVnsMSPPVvm7jTnB5rlvRFMw1gret5gN+1
	nwV7gIDEKNKLN2tbgqfk7LuG+j5deNasDWe1B6UlAEbF+xpJSp1+pRw6p/9rFKSJtzeIC8ycREy
	gl+ulJPApvcuoVPrAc9FjmvxkY6liJXbwqkbs9IZ+LWVy8qUxNJQsp3/AqSpA==
X-Google-Smtp-Source: AGHT+IG2rFRwhQibaBR6aAuao3jI7K3VUg5l8QmVj2/VN7gYQHbUXOtPenTQq/0/FJwW3Jci4oXLWJuLEGGEEC67RlQ=
X-Received: by 2002:a17:902:c40f:b0:245:f88a:704d with SMTP id
 d9443c01a7336-245f88a713emr4555415ad.34.1755688490626; Wed, 20 Aug 2025
 04:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122834.836683687@linuxfoundation.org>
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Aug 2025 16:44:37 +0530
X-Gm-Features: Ac12FXwHvZKUbm7j9QcsajfSa1g8XXDxhc8LwavjUmCAPCSQWY0oLDxVXkRXAVM
Message-ID: <CA+G9fYvdck=4i9EkdxJH7O1nTJu8NzeHbu-Q6_pn3bg0cV12KA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	LTP List <ltp@lists.linux.it>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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
- https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.9-987-gcf068471031d/ltp-syscalls/epoll_ctl04/

## Build
* kernel: 6.15.11-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: cf068471031d89c4d7ce04f477ba69a043736a58
* git describe: v6.15.9-987-gcf068471031d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.15.y/build/v6.15.9-987-gcf068471031d

## Test Regressions (compared to v6.15.9-481-g2510f67e2e34)

* ltp-syscalls
  - epoll_ctl04

## Metric Regressions (compared to v6.15.9-481-g2510f67e2e34)

## Test Fixes (compared to v6.15.9-481-g2510f67e2e34)

## Metric Fixes (compared to v6.15.9-481-g2510f67e2e34)

## Test result summary
total: 335595, pass: 313546, fail: 6512, skip: 15537, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 27 passed, 7 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 25 total, 24 passed, 1 failed
* s390: 22 total, 22 passed, 0 failed
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
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mm
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
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

