Return-Path: <linux-fsdevel+bounces-12078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EB85B0C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECE21F245DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 02:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F8374EE;
	Tue, 20 Feb 2024 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yckeErJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790A44376
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395364; cv=none; b=ilY+8S7wYawYhUdgxmvL9WIPeZpcZn6zIeH2pKKWpKLJ8W0SOUgCIxzYIDh/QAK8KJhmsWN+9Bg+50oEn0FELW7j5uoySNEfwkDW55QORMZJAnQoC42tth0jkHtdPBdMsHpRoPAqz/BALqRRKNesCPxI/pyBKcVy9uzfCs5yOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395364; c=relaxed/simple;
	bh=+7g6xZPa4MQeBNdj24ssUkgA+nZTA9KzvinQD9Fnew4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=Emr5HNliMtpEuIUQeoS7Uo1svlRwLG36T8Xblm38opiOn6CHsNGkLf1PrGRNhnZFCF+Loj3ZqEQCEGEI/zjHyjnJoU1idVrzEujdZWxD0EMtIMMb50RtpgIlsIPj2dP2eE5hh6UTQciN/tE5gaavUXnDUeFmFfl1hfIxTcaf1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yckeErJc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so6855005ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 18:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708395360; x=1709000160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OAN0Lt5ZKU5YCY2zjENEtHOA9Ppd3OvNfkI0wLPm9E=;
        b=yckeErJcH5dfA3i7ebhfsFRK6lZEltNb8u7msAhQoEAxnUvBj+MZFesc7ZLC6uDPd/
         Vl2FwqJs3VSvaVGfgnJfxpyXFel5VOryJCxH5lNaK+Rm4cc3IOr384sUWpXsHipEAsuU
         K4S4EFV0e/Jz42nMG2SUIpaUXaxYh8E4gY7sMrNGuw+zBpxNVrEHwxj/dOr1smpg06fA
         jlPEjzl9SixTVctot5Mx8vDo9aY0MqYqZWcuJYIEl/KPKmPLw7y6aJo6fybiiFCL+vMz
         0sydS86asqL9WdrNMK/TkGd4nzpsjQu56bPgg5wxb6pcqySzxWQ87jwdMPM40vpgg9qf
         yrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708395360; x=1709000160;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OAN0Lt5ZKU5YCY2zjENEtHOA9Ppd3OvNfkI0wLPm9E=;
        b=Z6iWEr9fcg3qKPNwp4tBBWUSYlJHcABJEAtc6aFVK0oKpuJxWDsn7mVfg9LCjmT4Hz
         P4npWoDnM1726kawu1WVc2q6oNsTSjOhl9Pvo/EHZVfdZFB0xi9LcoVumQM+znLpZEEB
         V8TNvLaW3bkVb0zPd++y+XMLpgFHclk2S17CkWsRuI9pvfxnZVlPLeIWKs4ua/OLnQa0
         /JkS2zAnELTMlWBU1Dlue08Jaiv/Ip96qvdGUxh+M7OAlNzL1KIlQpJyA3ozNCmwo4tb
         jYm+8KB3qZIkZovowZywMcYTKzJ11IyH/lyMiGtmifhzHDBUgW7KZGsyDSMjrlthD5LY
         mt5g==
X-Forwarded-Encrypted: i=1; AJvYcCWFh0wBFC4TN54sQ1vFZAhrGrz12cJ+pKF6acRNFY8OVYQ8GEiTzzoq/Ig+vIwgaz+dJIH0mosmHO8JdefDt/YwwHLEQgcI0wGFgB60Dw==
X-Gm-Message-State: AOJu0YwAjNGUcQL3fvKueToz9HMA7hlkMN9C2YLWjl7cM/VZDAzbfytF
	DRlrvVI2gxBVlxJ/9m+bVkDTeMERPIXazwNFulXFndBdchN2Tt+Uw7TuevdTgLo=
X-Google-Smtp-Source: AGHT+IE/HK82k8jF0QyDP8MRiJTDcRIUH+5Nn34RcteS7Lvc7xDUJSIleyKlVy8K/rQ9hjc5E9YxbQ==
X-Received: by 2002:a17:902:ea0d:b0:1db:e7a4:90a8 with SMTP id s13-20020a170902ea0d00b001dbe7a490a8mr6006330plg.10.1708395359755;
        Mon, 19 Feb 2024 18:15:59 -0800 (PST)
Received: from localhost ([2804:14d:7e39:8470:a328:9cae:8aed:4821])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001db3efca159sm5042143plg.132.2024.02.19.18.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:15:59 -0800 (PST)
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
In-reply-to: <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
Date: Mon, 19 Feb 2024 23:15:57 -0300
Message-ID: <87sf1n7uea.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Mark Brown <broonie@kernel.org> writes:

> There are things like threads which nolibc struggles with which we want
> to add coverage for, and the ABI allows us to test most of these even if
> libc itself does not understand GCS so add a test application built
> using the system libc.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/gcs/.gitignore |   1 +
>  tools/testing/selftests/arm64/gcs/Makefile   |   4 +-
>  tools/testing/selftests/arm64/gcs/gcs-util.h |  10 +
>  tools/testing/selftests/arm64/gcs/libc-gcs.c | 736 +++++++++++++++++++++=
++++++
>  4 files changed, 750 insertions(+), 1 deletion(-)

In v7, several tests weren't running in my FVT VM for some reason.
This time they do:

$ ./run_kselftest.sh -t arm64:libc-gcs
TAP version 13
1..1
# timeout set to 45
# selftests: arm64: libc-gcs
# TAP version 13
# 1..118
# # Starting 118 tests from 32 test cases.
# #  RUN           global.can_call_function ...
# # can_call_function: Test terminated unexpectedly by signal 11
# #          FAIL  global.can_call_function
# not ok 1 global.can_call_function
# #  RUN           global.gcs_enabled_thread ...
# #            OK  global.gcs_enabled_thread
# ok 2 global.gcs_enabled_thread
   =E2=8B=AE
# #  RUN           invalid_mprotect.exec_bti.do_map_read ...
# # Allocated stack from 0xffffb3aa9000-0xffffb3aaa000
# #            OK  invalid_mprotect.exec_bti.do_map_read
# ok 118 invalid_mprotect.exec_bti.do_map_read
# # FAILED: 117 / 118 tests passed.
# # Totals: pass:117 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: arm64: libc-gcs # exit=3D1

The only issue as can be seen above is that the can_call_function test
is failing. The child is getting a GCS Segmentation fault when returning
from fork().

I tried debugging it with GDB, but I don't see what's wrong since the
address in LR matches the first entry in GCSPR. Here is the
debug session:

(gdb) break libc-gcs.c:58
Breakpoint 1 at 0x3894: file libc-gcs.c, line 58.
(gdb) set follow-fork-mode child
(gdb) r
Starting program: /var/tmp/selftests/arm64/libc-gcs
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
TAP version 13
1..118
# Starting 118 tests from 32 test cases.
#  RUN           global.can_call_function ...
[Attaching after Thread 0xfffff7ff7e80 (LWP 9164) fork to child process 916=
8]
[New inferior 2 (process 9168)]
[Detaching after fork from parent process 9164]
[Inferior 1 (process 9164) detached]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".

Thread 2.1 "libc-gcs" received signal SIGSEGV, Segmentation fault
Guarded Control Stack error.
[Switching to Thread 0xfffff7ff7e80 (LWP 9168)]
0x0000fffff7ec6fc0 [GCS error] in __GI__Fork () at ../sysdeps/nptl/_Fork.c:=
50
warning: 50     ../sysdeps/nptl/_Fork.c: No such file or directory
(gdb) bt
#0  0x0000fffff7ec6fc0 [GCS error] in __GI__Fork () at ../sysdeps/nptl/_For=
k.c:50
#1  0x0000fffff7ec6be0 in __libc_fork () at ./posix/fork.c:73
#2  0x0000aaaaaaaa49b8 in __run_test (f=3Df@entry=3D0xaaaaaaab98c8 <_fixtur=
e_global>,
    variant=3Dvariant@entry=3D0xffffffffefb8, t=3Dt@entry=3D0xaaaaaaab81b0 =
<_can_call_function_object>)
    at /home/thiago.bauermann/src/linux/tools/testing/selftests/kselftest_h=
arness.h:1128
#3  0x0000aaaaaaaa2ac4 in test_harness_run (argv=3D0xfffffffff158, argc=3D1)
    at /home/thiago.bauermann/src/linux/tools/testing/selftests/kselftest_h=
arness.h:1199
#4  main (argc=3D1, argv=3D0xfffffffff158) at libc-gcs.c:735
(gdb) p $gcspr
$1 =3D (void *) 0xfffff7dfffe0
(gdb) p/x $lr
$3 =3D 0xfffff7ec6be0
(gdb) p/x *(unsigned long *)$gcspr
$5 =3D 0xfffff7ec6be0
(gdb) disassemble
Dump of assembler code for function __GI__Fork:
   0x0000fffff7ec6f70 <+0>:     mrs     x5, tpidr_el0
   0x0000fffff7ec6f74 <+4>:     mov     x0, #0x11                       // =
#17
   0x0000fffff7ec6f78 <+8>:     sub     x6, x5, #0x7c0
   0x0000fffff7ec6f7c <+12>:    sub     x4, x5, #0x6f0
   0x0000fffff7ec6f80 <+16>:    movk    x0, #0x120, lsl #16
   0x0000fffff7ec6f84 <+20>:    mov     x1, #0x0                        // =
#0
   0x0000fffff7ec6f88 <+24>:    mov     x2, #0x0                        // =
#0
   0x0000fffff7ec6f8c <+28>:    mov     x3, #0x0                        // =
#0
   0x0000fffff7ec6f90 <+32>:    mov     x8, #0xdc                       // =
#220
   0x0000fffff7ec6f94 <+36>:    svc     #0x0
   0x0000fffff7ec6f98 <+40>:    cmn     x0, #0x1, lsl #12
   0x0000fffff7ec6f9c <+44>:    b.hi    0xfffff7ec6fc4 <__GI__Fork+84>  // =
b.pmore
   0x0000fffff7ec6fa0 <+48>:    mov     w2, w0
   0x0000fffff7ec6fa4 <+52>:    cbnz    w0, 0xfffff7ec6fbc <__GI__Fork+76>
   0x0000fffff7ec6fa8 <+56>:    sub     x0, x5, #0x6e0
   0x0000fffff7ec6fac <+60>:    mov     x1, #0x18                       // =
#24
   0x0000fffff7ec6fb0 <+64>:    mov     x8, #0x63                       // =
#99
   0x0000fffff7ec6fb4 <+68>:    stp     x0, x0, [x6, #216]
   0x0000fffff7ec6fb8 <+72>:    svc     #0x0
   0x0000fffff7ec6fbc <+76>:    mov     w0, w2
=3D> 0x0000fffff7ec6fc0 <+80>:    ret
   0x0000fffff7ec6fc4 <+84>:    adrp    x1, 0xfffff7faa000 <sys_siglist+424>
   0x0000fffff7ec6fc8 <+88>:    ldr     x1, [x1, #3528]
   0x0000fffff7ec6fcc <+92>:    neg     w0, w0
   0x0000fffff7ec6fd0 <+96>:    mov     w2, #0xffffffff                 // =
#-1
   0x0000fffff7ec6fd4 <+100>:   str     w0, [x5, x1]
   0x0000fffff7ec6fd8 <+104>:   mov     w0, w2
   0x0000fffff7ec6fdc <+108>:   ret
End of assembler dump.
(gdb) p $w0
$8 =3D 0
(gdb) p $_siginfo.si_signo
$12 =3D 11
(gdb) p $_siginfo.si_code
$13 =3D 10
(gdb) p $_siginfo._sifields._sigfault.si_addr
$14 =3D (void *) 0xfffff7ec6fc0 <__GI__Fork+80>

--=20
Thiago

