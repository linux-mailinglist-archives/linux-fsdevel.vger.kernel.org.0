Return-Path: <linux-fsdevel+bounces-6608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58381A856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 22:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E9F286F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5244A9B2;
	Wed, 20 Dec 2023 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hAMfVIdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6494A98A
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Dec 2023 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Dec 2023 16:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703108402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MKJBECd4R8njoEhQpBoXguZPfsz8RJrc1vVZeI2+VE=;
	b=hAMfVIdAcvKAqpVeEmLbf794s30T+d2XRrj0W3ZmVnnDFQOyAgAcVKoz2+E8Bri27NJT3i
	R6rqYna2x1MEHOkr1ifi42C0N61Fj7ic4zkL//pKIN20NgjeEVzs69DE1aUNcG+xJpKm6J
	PwTTmScxncX2W0xDyH03mhGmmhCdHXQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 50/50] Kill sched.h dependency on rcupdate.h
Message-ID: <20231220213957.zbslehrx4zkkbabq@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-7-kent.overstreet@linux.dev>
 <CAMuHMdW29dAQh+j3s4Af1kMAFKSr2yz7M2L-fWd1uZfL7mEY1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW29dAQh+j3s4Af1kMAFKSr2yz7M2L-fWd1uZfL7mEY1Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 20, 2023 at 12:59:44PM +0100, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Sat, Dec 16, 2023 at 4:39 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > by moving cond_resched_rcu() to rcupdate.h, we can kill another big
> > sched.h dependency.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Thanks for your patch, which is now commit dc00f26faea81dc0 ("Kill
> sched.h dependency on rcupdate.h") in next-20231220.
> 
> Reported-by: noreply@ellerman.id.au
> 
> $ make ARCH=m68k defconfig arch/m68k/kernel/asm-offsets.i
> *** Default configuration is based on 'multi_defconfig'
> #
> # No change to .config
> #
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   CC      arch/m68k/kernel/asm-offsets.s
> In file included from ./include/asm-generic/bug.h:7,
>                  from ./arch/m68k/include/asm/bug.h:32,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:13,
>                  from ./arch/m68k/include/asm/processor.h:11,
>                  from ./include/linux/sched.h:13,
>                  from arch/m68k/kernel/asm-offsets.c:15:
> ./arch/m68k/include/asm/processor.h: In function ‘set_fc’:
> ./arch/m68k/include/asm/processor.h:91:15: error: implicit declaration
> of function ‘in_interrupt’ [-Werror=implicit-function-declaration]
>    91 |  WARN_ON_ONCE(in_interrupt());
>       |               ^~~~~~~~~~~~
> ./include/linux/once_lite.h:28:27: note: in definition of macro
> ‘DO_ONCE_LITE_IF’
>    28 |   bool __ret_do_once = !!(condition);   \
>       |                           ^~~~~~~~~
> ./arch/m68k/include/asm/processor.h:91:2: note: in expansion of macro
> ‘WARN_ON_ONCE’
>    91 |  WARN_ON_ONCE(in_interrupt());
>       |  ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:116:
> arch/m68k/kernel/asm-offsets.s] Error 1
> make[2]: *** [Makefile:1191: prepare0] Error 2
> make[1]: *** [Makefile:350: __build_one_by_one] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Applying this fix:

commit 0d7bdfe9726b275c7e9398047763a144c790b575
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Dec 20 16:39:21 2023 -0500

    m68k: Fix missing include
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/arch/m68k/include/asm/processor.h b/arch/m68k/include/asm/processor.h
index 7a2da780830b..8f2676c3a988 100644
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_M68K_PROCESSOR_H
 #define __ASM_M68K_PROCESSOR_H
 
+#include <linux/preempt.h>
 #include <linux/thread_info.h>
 #include <asm/fpu.h>
 #include <asm/ptrace.h>

