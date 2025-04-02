Return-Path: <linux-fsdevel+bounces-45553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BACEA7964A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236943B1002
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8A1EFFA7;
	Wed,  2 Apr 2025 20:10:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A919CCEC;
	Wed,  2 Apr 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624646; cv=none; b=erN32zZHcOcgYPNHV4QAfDEeebNEJrktQ8bV3WtEIWz/Ojngv9VdaWKTUstH4psEzbw/AosDPnjQXuYiR2LgSFPj0yA8EuR0zqsYBtBvpPHBAaOxgDFSzoPIWQbpx4oL0OssjYENaQPJ1DJucXuOwg5prx1lL9infG5IVppAs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624646; c=relaxed/simple;
	bh=8zW6/RMnhtv8yr1yURreD6JKFTv60EVXaB39y2/XfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiiEfW2inKvroxdxCddJLWr29Lo0LDHRHlV/VpmUPSc99FGsVxR3S3OESGvdzMIfMl9rADkP2sZm8vpWsNIrWEgqosKwo+OFS/6YL7mHQQmSvWzU2dji6NDCv7uOek3u6az1qi3BCMInf0+8MHrpSguPUdvtbUvP/dsiMaGbwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC11FC4CEDD;
	Wed,  2 Apr 2025 20:10:43 +0000 (UTC)
Date: Wed, 2 Apr 2025 21:10:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path to
 sized_strscpy()
Message-ID: <Z-2ZwThH-7rkQW86@arm.com>
References: <20250329000338.1031289-1-pcc@google.com>
 <20250329000338.1031289-2-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329000338.1031289-2-pcc@google.com>

On Fri, Mar 28, 2025 at 05:03:36PM -0700, Peter Collingbourne wrote:
> diff --git a/lib/string.c b/lib/string.c
> index eb4486ed40d25..b632c71df1a50 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -119,6 +119,7 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
>  		return -E2BIG;
>  
> +#ifndef CONFIG_DCACHE_WORD_ACCESS
>  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	/*
>  	 * If src is unaligned, don't cross a page boundary,
> @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	/* If src or dest is unaligned, don't do word-at-a-time. */
>  	if (((long) dest | (long) src) & (sizeof(long) - 1))
>  		max = 0;
> +#endif
>  #endif
>  
>  	/*
> -	 * read_word_at_a_time() below may read uninitialized bytes after the
> -	 * trailing zero and use them in comparisons. Disable this optimization
> -	 * under KMSAN to prevent false positive reports.
> +	 * load_unaligned_zeropad() or read_word_at_a_time() below may read
> +	 * uninitialized bytes after the trailing zero and use them in
> +	 * comparisons. Disable this optimization under KMSAN to prevent
> +	 * false positive reports.
>  	 */
>  	if (IS_ENABLED(CONFIG_KMSAN))
>  		max = 0;
> @@ -146,7 +149,11 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	while (max >= sizeof(unsigned long)) {
>  		unsigned long c, data;
>  
> +#ifdef CONFIG_DCACHE_WORD_ACCESS
> +		c = load_unaligned_zeropad(src+res);
> +#else
>  		c = read_word_at_a_time(src+res);
> +#endif
>  		if (has_zero(c, &data, &constants)) {
>  			data = prep_zero_mask(c, data, &constants);
>  			data = create_zero_mask(data);

Kees mentioned the scenario where this crosses the page boundary and we
pad the source with zeros. It's probably fine but there are 70+ cases
where the strscpy() return value is checked, I only looked at a couple.

Could we at least preserve the behaviour with regards to page boundaries
and keep the existing 'max' limiting logic? If I read the code
correctly, a fall back to reading one byte at a time from an unmapped
page would panic. We also get this behaviour if src[0] is reading from
an invalid address, though for arm64 the panic would be in
ex_handler_load_unaligned_zeropad() when count >= 8.

Reading across tag granule (but not across page boundary) and causing a
tag check fault would result in padding but we can live with this and
only architectures that do MTE-style tag checking would get the new
behaviour.

What I haven't checked is whether a tag check fault in
ex_handler_load_unaligned_zeropad() would confuse the KASAN logic for
MTE (it would be a second tag check fault while processing the first).
At a quick look, it seems ok but it might be worth checking.

-- 
Catalin

