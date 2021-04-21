Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5E136727B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbhDUSYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhDUSY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:24:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2CC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 11:23:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so3066398wma.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJ7/2ImOqgNsMlFTe/U5S+rQQA/z5wDSOJMIaWnIOgo=;
        b=LlgaznfbO9/ZSbTPeEQB5h2fYiuEy/UXnZz4dMzIoZw7XZw5B0iSASvQ9RiESglTm8
         yfop1QiYJ3v3KQAjSMr/S1H4YOSJRxRCK0YGLCQU00R8wAY3qp0536OxpzbV/VJ1LS68
         FVLQeGTQ+eDY5zFb9jbA5K0XiyOihaFcbt720mp5lMULdPuMEBqblG8DpaSALBTeXrjv
         scdfotKNRYeTQiULehH5gPQvE7ubOSXCKVIIkZBzIYySCXbGLKjZKCgyeECkL7IJsEul
         THUCFR1MTDC0Mn3jwcNMLOByaj6M+6pAxmp8fWY6p3kcdYQxP9g3megC3f3YUlPYf2jp
         P0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJ7/2ImOqgNsMlFTe/U5S+rQQA/z5wDSOJMIaWnIOgo=;
        b=NhUTDt14wWcfwNL1qtyxPk5f6HKLekuW/hDT4f/FsVlPT4FL+SpfhutT4yMMr0Ol6w
         AS7otmLD9QlxeRiQNsKq6iutH0I/fDEPFTOYB3bTFGYGaDHFLDei8h9u19vYCzS/4Ki0
         6ABcOGyGCiJxUTta69/r16Nv8MCbA9lgoxe6kijHNrcc8bhX4kUdewE2TgWtKYOAbDNP
         PQHIotv+a+5hhMIHtNfI3AA/BVzPZvwKUMiHBZeMGQGzWNeHJYRDKPYSYQ5ftwCVTmzt
         DwYJQNqimc76hpaxs8umJEpDXmeAscxVM0JIFPXkI1JnWNsHGqj3bb9i+DfohKx93ffu
         dc8A==
X-Gm-Message-State: AOAM531unbp8KwimfFGz2cGJmCxl7hpWCxqH3NsPNLb0/NhaCsC4el4f
        NE55z8IullAwYl08xkkJMB+KCw==
X-Google-Smtp-Source: ABdhPJz4oJRSYRSLilmTZi/+V+8VJ8VJiSw4FBXvscnpE0PMQuvmwXn9sxvIod8vYtqC6Jaz4xsTiA==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr11054836wmi.29.1619029430262;
        Wed, 21 Apr 2021 11:23:50 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:6273:c89a:6562:e1ba])
        by smtp.gmail.com with ESMTPSA id m11sm232602wri.44.2021.04.21.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:23:49 -0700 (PDT)
Date:   Wed, 21 Apr 2021 20:23:43 +0200
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
Message-ID: <YIBtr2w/8KhOoiUA@elver.google.com>
References: <CANpmjNM8wEJngK=J8Lt9npkZgrSWoRsqkdajErWEoY_=M1GW5A@mail.gmail.com>
 <43f8a3bf-34c5-0fc9-c335-7f92eaf23022@samsung.com>
 <dccaa337-f3e5-08e4-fe40-a603811bb13e@samsung.com>
 <CANpmjNP6-yKpxHqYFiA8Up-ujBQaeP7xyq1BrsV-NqMjJ-uHAQ@mail.gmail.com>
 <740077ce-efe1-b171-f807-bc5fd95a32ba@samsung.com>
 <f114ff4a-6612-0935-12ac-0e2ac18d896c@samsung.com>
 <CANpmjNM6bQpc49teN-9qQhCXoJXaek5stFGR2kPwDroSFBc0fw@mail.gmail.com>
 <cf6ed5cd-3202-65ce-86bc-6f1eba1b7d17@samsung.com>
 <CANpmjNPr_JtRC762ap8PQVmsFNY5YhHvOk0wNcPHq=ZQt-qxYg@mail.gmail.com>
 <YIBSg7Vi+U383dT7@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIBSg7Vi+U383dT7@elver.google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:27PM +0200, Marco Elver wrote:
> On Wed, Apr 21, 2021 at 05:11PM +0200, Marco Elver wrote:
> > +Cc linux-arm-kernel
> > 
> [...]
> > >
> > > I've managed to reproduce this issue with a public Raspberry Pi OS Lite
> > > rootfs image, even without deploying kernel modules:
> > >
> > > https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2021-03-25/2021-03-04-raspios-buster-armhf-lite.zip
> > >
> > > # qemu-system-arm -M virt -smp 2 -m 512 -kernel zImage -append "earlycon
> > > console=ttyAMA0 root=/dev/vda2 rw rootwait" -serial stdio -display none
> > > -monitor null -device virtio-blk-device,drive=virtio-blk -drive
> > > file=/tmp/2021-03-04-raspios-buster-armhf-lite.img,id=virtio-blk,if=none,format=raw
> > > -netdev user,id=user -device virtio-net-device,netdev=user
> > >
> > > The above one doesn't boot if zImage z compiled from commit fb6cc127e0b6
> > > and boots if compiled from 2e498d0a74e5. In both cases I've used default
> > > arm/multi_v7_defconfig and
> > > gcc-linaro-6.4.1-2017.11-x86_64_arm-linux-gnueabi toolchain.
> > 
> > Yup, I've narrowed it down to the addition of "__u64 _perf" to
> > siginfo_t. My guess is the __u64 causes a different alignment for a
> > bunch of adjacent fields. It seems that x86 and m68k are the only ones
> > that have compile-time tests for the offsets. Arm should probably add
> > those -- I have added a bucket of static_assert() in
> > arch/arm/kernel/signal.c and see that something's off.
> > 
> > I'll hopefully have a fix in a day or so.
> 
> Arm and compiler folks: are there some special alignment requirement for
> __u64 on arm 32-bit? (And if there is for arm64, please shout as well.)
> 
> With the static-asserts below, the only thing that I can do to fix it is
> to completely remove the __u64. Padding it before or after with __u32
> just does not work. It seems that the use of __u64 shifts everything
> in __sifields by 4 bytes.
> 
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index d0bb9125c853..b02a4ac55938 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -92,7 +92,10 @@ union __sifields {
>  				__u32 _pkey;
>  			} _addr_pkey;
>  			/* used when si_code=TRAP_PERF */
> -			__u64 _perf;
> +			struct {
> +				__u32 _perf1;
> +				__u32 _perf2;
> +			} _perf;
>  		};
>  	} _sigfault;
> 
> ^^ works, but I'd hate to have to split this into 2 __u32 because it
> makes the whole design worse.
> 
> What alignment trick do we have to do here to fix it for __u64?

So I think we just have to settle on 'unsigned long' here. On many
architectures, like 32-bit Arm, the alignment of a structure is that of
its largest member. This means that there is no portable way to add
64-bit integers to siginfo_t on 32-bit architectures.

In the case of the si_perf field, word size is sufficient since the data
it contains is user-defined. On 32-bit architectures, any excess bits of
perf_event_attr::sig_data will therefore be truncated when copying into
si_perf.

Feel free to test the below if you have time, but the below lets me boot
32-bit arm which previously timed out. It also passes all the
static_asserts() I added (will send those as separate patches).

Once I'm convinced this passes all others tests too, I'll send a patch.

Thanks,
-- Marco


diff --git a/include/linux/compat.h b/include/linux/compat.h
index c8821d966812..f0d2dd35d408 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -237,7 +237,7 @@ typedef struct compat_siginfo {
 					u32 _pkey;
 				} _addr_pkey;
 				/* used when si_code=TRAP_PERF */
-				compat_u64 _perf;
+				compat_ulong_t _perf;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index d0bb9125c853..03d6f6d2c1fe 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -92,7 +92,7 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			__u64 _perf;
+			unsigned long _perf;
 		};
 	} _sigfault;
 
