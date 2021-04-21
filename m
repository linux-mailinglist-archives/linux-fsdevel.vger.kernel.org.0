Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61F36701C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhDUQ2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhDUQ22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:28:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D48C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 09:27:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n127so10740013wmb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SmfHH6hIJqwyK5X8i5q3Sks3m+nCGH0WqXp+KsNmUL8=;
        b=DXNQF6+X23W/5T4j3zpPuPMt02MDsg03lPN+3HSFpoY2UlMTCml7AhmoyozG0E2Q39
         qk4NKcw6Mkbji1CoIrq497pJKaqywM/s/l0rqIZr+LR2Ec3BQIYPhHmgyPt1x9kQtKIg
         JV/RQ+1kCUHhV5WmXHyA0TQYDDBelvBNectYOsf8uCeauDfYl+EOu+xu6qLuh+dCmx6J
         xVOMVqOOu0T09Zh/akTZDXfT3iuYRkCZhFRBgHZnvQkd2HyWEnbCX99Pji/MzbFswFFj
         k63kG+iYhk8Fqo8XMDKsLmlKFxAXe4pOmXzDIUAqRHaa7nIBfRgSGDwzBmtreIbzqn4r
         y0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SmfHH6hIJqwyK5X8i5q3Sks3m+nCGH0WqXp+KsNmUL8=;
        b=I1anqbudRtbPVJTN9Hlc7Mio2dcNldxUsjbh3p9v7TGYlirz29scdNx/exVcbLDjZ+
         lLdfTuJmmBI2xbtiRdc1FGnUNAqwTmha0U/4BkOXOiqIpBgO/V6tS5z5T8x7/Ys+IBXC
         LpGb0fgDP0BHZlI/OQbmHSURXd2Fvfb43d/GYDttNt/8+BdzL6ko3wsUKGLdMLGP+mu0
         6L/V4JdqbaTcNrKSkFrDzllPa5kWw0zldhx0F/qxvcIDT30mKllVhY7oMu3LrGj8OW+t
         uaGbLZ6dZNYxyAB9sa62R2r0xFodPTFAlMqCL+/MKBnQN4xC/noSAvcIpnnbNYFaGlaQ
         1zzA==
X-Gm-Message-State: AOAM533y0dH/gyP42DbmqdbhAcLOpb80gw5XxPIpo47We7bhQDsG4r8i
        YVm0H2L8zbGhaAsOi9ZIpSmm7Q==
X-Google-Smtp-Source: ABdhPJws9ys5bphkU3GPm/kXkaoFkOzDHxBDE6IlGGSz8bHo2vzb71zyUPD73s4ZA5mj9uvFsZMMCA==
X-Received: by 2002:a1c:7f16:: with SMTP id a22mr10182034wmd.17.1619022473891;
        Wed, 21 Apr 2021 09:27:53 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
        by smtp.gmail.com with ESMTPSA id f23sm2803158wmf.37.2021.04.21.09.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:27:52 -0700 (PDT)
Date:   Wed, 21 Apr 2021 18:27:47 +0200
From:   Marco Elver <elver@google.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
Message-ID: <YIBSg7Vi+U383dT7@elver.google.com>
References: <1fbf3429-42e5-0959-9a5c-91de80f02b6a@samsung.com>
 <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
 <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
 <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
 <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com>
 <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
 <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com>
 <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
 <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:11PM +0200, Marco Elver wrote:
> +Cc linux-arm-kernel
> 
[...]
> >
> > I've managed to reproduce this issue with a public Raspberry Pi OS Lite
> > rootfs image, even without deploying kernel modules:
> >
> > https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip
> >
> > # qemu-system-arm -M virt -smp 2 -m 512 -kernel zImage -append "earlycon
> > console=ttyAMA0 root=/dev/vda2 rw rootwait" -serial stdio -display none
> > -monitor null -device virtio-blk-device,drive=virtio-blk -drive
> > file=/tmp/2021-03-04-raspios-buster-armhf-lite.img,id=virtio-blk,if=none,format=raw
> > -netdev user,id=user -device virtio-net-device,netdev=user
> >
> > The above one doesn't boot if zImage z compiled from commit fb6cc127e0b6
> > and boots if compiled from 2e498d0a74e5. In both cases I've used default
> > arm/multi_v7_defconfig and
> > gcc-linaro-6.4.1-2017.11-x86_64_arm-linux-gnueabi toolchain.
> 
> Yup, I've narrowed it down to the addition of "__u64 _perf" to
> siginfo_t. My guess is the __u64 causes a different alignment for a
> bunch of adjacent fields. It seems that x86 and m68k are the only ones
> that have compile-time tests for the offsets. Arm should probably add
> those -- I have added a bucket of static_assert() in
> arch/arm/kernel/signal.c and see that something's off.
> 
> I'll hopefully have a fix in a day or so.

Arm and compiler folks: are there some special alignment requirement for
__u64 on arm 32-bit? (And if there is for arm64, please shout as well.)

With the static-asserts below, the only thing that I can do to fix it is
to completely remove the __u64. Padding it before or after with __u32
just does not work. It seems that the use of __u64 shifts everything
in __sifields by 4 bytes.

diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d0bb9125c853..b02a4ac55938 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -92,7 +92,10 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			__u64 _perf;
+			struct {
+				__u32 _perf1;
+				__u32 _perf2;
+			} _perf;
 		};
 	} _sigfault;

^^ works, but I'd hate to have to split this into 2 __u32 because it
makes the whole design worse.

What alignment trick do we have to do here to fix it for __u64?


------ >8 ------

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..6c558dc314c3 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -725,3 +725,41 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
 	rseq_syscall(regs);
 }
 #endif
+
+/*
+ * Compile-time tests for siginfo_t offsets. Changes to NSIG* likely come with
+ * new fields; new fields should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(siginfo_t, si_pid)	== 0x0c);
+#if 0
+static_assert(offsetof(siginfo_t, si_uid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_tid)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_overrun)	== 0x10);
+static_assert(offsetof(siginfo_t, si_status)	== 0x14);
+static_assert(offsetof(siginfo_t, si_utime)	== 0x18);
+static_assert(offsetof(siginfo_t, si_stime)	== 0x1c);
+static_assert(offsetof(siginfo_t, si_value)	== 0x14);
+static_assert(offsetof(siginfo_t, si_int)	== 0x14);
+static_assert(offsetof(siginfo_t, si_ptr)	== 0x14);
+static_assert(offsetof(siginfo_t, si_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
+static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_syscall)	== 0x10);
+static_assert(offsetof(siginfo_t, si_arch)	== 0x14);
+#endif

