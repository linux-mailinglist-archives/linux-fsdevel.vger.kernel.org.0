Return-Path: <linux-fsdevel+bounces-43502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE4A577E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 04:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D1D18986CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC12F158DAC;
	Sat,  8 Mar 2025 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2gEW4Qe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE23839F4;
	Sat,  8 Mar 2025 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404995; cv=none; b=eMx5GlZ0xkC1qYGFN74SG+iPQe9KPHkUjJfz2reIzgqpRYpr6LyoHHM0Jhkw1qDmiCmEHKNs9XmfiKyUTANRpA5QjNhdPnSn+KCKyz4R7OFAkV0GSllISuYvipQFw2rlxQ/SNF2IUwPeLIikKNxUuaTYZ5QnR+fyDDBecD0HnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404995; c=relaxed/simple;
	bh=wLEqT0IC9gJ1SaLEGeSi2Lgq48p3Sz8pFixWAnU6Gj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsfwfunSxMxvV3cgkTeX0HCMXhA5IRDhBbRWNGd8XrmN1bJNWLX+ok4TSDF8lfbcqOCwfDKHpaFAfgF44whSCuNOtApVriU6DIJzA+v7UtFOFogiFOHt5IdbuAvQ/YM9k/o1pqLuCEuESxiXFS/dI4Z7ATwYwLs2Rq76GqV0WaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2gEW4Qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824E2C4CED1;
	Sat,  8 Mar 2025 03:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741404994;
	bh=wLEqT0IC9gJ1SaLEGeSi2Lgq48p3Sz8pFixWAnU6Gj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2gEW4QeX38oiBqCP1qkGaua8cdgDgvAnVgZrCCL8gdBNvYqvK+u0Ru4MnaP0B3nU
	 nG4UJK+irKKH3fr8JqFNeIfavwXOXHEez7xR8gfQ2EywxIyKmiGDI9p69+auzLW308
	 94lClOOtc+06LFdXpuCtGEGl86LiIxTYNAXZ721T8t71QSU29lB1h/AS0TizRnpXdr
	 PvWAU4zREeLaQjzNf9VI2Ovfghe70nqWP570vRzDTHGwJhHJEJpJUsy5zOPmKB0e5i
	 zaTefESg7PDwrAk2G3CMdKBDPFAM6BP6njtX4mI9st8gARwjmqHIPxuxxNiT1m5KOt
	 hhKJZymnSu8LA==
Date: Fri, 7 Mar 2025 19:36:31 -0800
From: Kees Cook <kees@kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
Message-ID: <202503071927.1A795821A@keescook>
References: <20250308023314.3981455-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308023314.3981455-1-pcc@google.com>

On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> The optimized strscpy() and dentry_string_cmp() routines will read 8
> unaligned bytes at a time via the function read_word_at_a_time(), but
> this is incompatible with MTE which will fault on a partially invalid
> read. The attributes on read_word_at_a_time() that disable KASAN are
> invisible to the CPU so they have no effect on MTE. Let's fix the
> bug for now by disabling the optimizations if the kernel is built
> with HW tag-based KASAN and consider improvements for followup changes.

Why is faulting on a partially invalid read a problem? It's still
invalid, so ... it should fault, yes? What am I missing?

> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> Cc: stable@vger.kernel.org
> ---
>  fs/dcache.c  | 2 +-
>  lib/string.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Why are DCACHE_WORD_ACCESS and HAVE_EFFICIENT_UNALIGNED_ACCESS separate
things? I can see at least one place where it's directly tied:

arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS

Would it make sense to sort this out so that KASAN_HW_TAGS can be taken
into account at the Kconfig level instead?

> diff --git a/fs/dcache.c b/fs/dcache.c
> index e3634916ffb93..71f0830ac5e69 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -223,7 +223,7 @@ fs_initcall(init_fs_dcache_sysctls);
>   * Compare 2 name strings, return 0 if they match, otherwise non-zero.
>   * The strings are both count bytes long, and count is non-zero.
>   */
> -#ifdef CONFIG_DCACHE_WORD_ACCESS
> +#if defined(CONFIG_DCACHE_WORD_ACCESS) && !defined(CONFIG_KASAN_HW_TAGS)

Why not also the word_at_a_time use in fs/namei.c and lib/siphash.c?

For reference, here are the DCACHE_WORD_ACCESS places:

arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/arm64/Kconfig:137: select DCACHE_WORD_ACCESS
arch/powerpc/Kconfig:192:       select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
arch/riscv/Kconfig:934: select DCACHE_WORD_ACCESS if MMU
arch/s390/Kconfig:154:  select DCACHE_WORD_ACCESS if !KMSAN
arch/x86/Kconfig:160:   select DCACHE_WORD_ACCESS if !KMSAN
arch/x86/um/Kconfig:12: select DCACHE_WORD_ACCESS

>  
>  #include <asm/word-at-a-time.h>
>  /*
> diff --git a/lib/string.c b/lib/string.c
> index eb4486ed40d25..9a43a3824d0d7 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -119,7 +119,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
>  		return -E2BIG;
>  
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
> +	!defined(CONFIG_KASAN_HW_TAGS)

There are lots more places checking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS...
Why only here?

And the Kconfigs since I was comparing these against DCACHE_WORD_ACCESS

arch/arc/Kconfig:352:   select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/arm/Kconfig:107:   select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
arch/arm64/Kconfig:222: select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/loongarch/Kconfig:140:     select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
arch/m68k/Kconfig:33:   select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
arch/powerpc/Kconfig:246:       select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/riscv/Kconfig:935: select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/s390/Kconfig:197:  select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/x86/Kconfig:238:   select HAVE_EFFICIENT_UNALIGNED_ACCESS
arch/x86/um/Kconfig:13: select HAVE_EFFICIENT_UNALIGNED_ACCESS

>  	/*
>  	 * If src is unaligned, don't cross a page boundary,
>  	 * since we don't know if the next page is mapped.
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 

-Kees

-- 
Kees Cook

