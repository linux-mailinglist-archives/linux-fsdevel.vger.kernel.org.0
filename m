Return-Path: <linux-fsdevel+bounces-27119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5040C95EB6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAABB22E5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB913B593;
	Mon, 26 Aug 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="StHVCOh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37514EB51;
	Mon, 26 Aug 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659665; cv=none; b=ArulI7VhmgDN3otL9XdqE+iQXWA71QZmZ3Ry7278MfyFDv45/d1I18QX+RVoDdHkFao4pvGQNG6eSmIhTLLuvquR9SCMnRKDBEZV78m+5xnh2Xu+78Bk9UBwjg2pV16SvBq8IfWf7v9X4wNlMIHpXdP7MM+wtVEK7KDrGJnFcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659665; c=relaxed/simple;
	bh=2zXfAK81LnBk/mOEZ9lvbbgXSwT+8B3Bi2M4zPLnMko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeO0cBFvBUJlw/cxyxTZDv6LBxV8FRel0h/zcDZh6AdmTxeV5ccsxepH/otRhN+agrBaz9rmGl/M/YdeUucrbEgl15763TJHy3sKKiRoFqYpBllIhq5KEC5pRw9YreKOQJQzzT+Yykv3JjBEh41XE8JeQYVw1bdqHkU4N+nVmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=StHVCOh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E8C8CDD6;
	Mon, 26 Aug 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="StHVCOh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724659661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaxHDzyeQARFqyBuo6p6nbdr7RFX49mOAxwSudvJyzo=;
	b=StHVCOh4KNNCyFXRLYUoNCdTcNxSS6Z3asRmnJ9ATPyiIOC/xbFWmEWaSFpaObsfsoO+X3
	qqjWV+mwTMIgJyMwkuMkqXw1CrHepM96JxAR4p2UKjZOsZsDhunIzVT2qZzKIWCwWJ7sje
	lqmadHbYXdoCfy5fWd5XhoCzWQm9vhQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6c12a3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 08:07:41 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:07:32 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
Message-ID: <Zsw3xMoX2EI5UUs1@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
> diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
> index 0c92db84469d..6e4f8fae3ce9 100644
> --- a/arch/x86/include/asm/pvclock.h
> +++ b/arch/x86/include/asm/pvclock.h
> @@ -5,6 +5,7 @@
>  #include <asm/clocksource.h>
>  #include <asm/pvclock-abi.h>
>  
> +struct timespec64;
>  /* some helper functions for xen and kvm pv clock sources */
>  u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
>  u64 pvclock_clocksource_read_nowd(struct pvclock_vcpu_time_info *src);

This change isn't mentioned in the commit message and could probably
benefit from doing so.

> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index b230f0b10832..cab153c5f9be 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -3,15 +3,13 @@
>   * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   */
>  
> -#include <linux/cache.h>
> -#include <linux/kernel.h>
> -#include <linux/time64.h>
> +#include <linux/minmax.h>
>  #include <vdso/datapage.h>
>  #include <vdso/getrandom.h>
> +#include <vdso/unaligned.h>

Ah, that's where you do it. Ignore my comment on the previous commit,
then.

>  #include <asm/vdso/getrandom.h>
> -#include <asm/vdso/vsyscall.h>
> -#include <asm/unaligned.h>
>  #include <uapi/linux/mman.h>
> +#include <uapi/linux/random.h>
>  
>  #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
>  	while (len >= sizeof(type)) {						\
> @@ -23,6 +21,9 @@
>  	}									\
>  } while (0)
>  
> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))

If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SIZE
instead of _PAGE_SIZE? But if that's the case, why not put the vdso
definition of PAGE_SIZE into some vdso header included by this file?

