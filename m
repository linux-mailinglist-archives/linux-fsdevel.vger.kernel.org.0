Return-Path: <linux-fsdevel+bounces-44399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1AA6836B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424D97A46B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCDF24E4C4;
	Wed, 19 Mar 2025 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUs5+gRN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E2524F;
	Wed, 19 Mar 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742353593; cv=none; b=jCDzxbdOaaQ/UUNqPlbq/ftWy/bFv6qj37NvPnFuYxuwMWXAfWqFgzWLm/lWb2qq95XDzmNKjB00ku4D9fzhlXTMCvXbfaTa8+B2V0FvKqqUv5h7Yx8DMRdbwzQkDp00XguOZUXLTD8TbAOi+dJZXP2rV3BVJRCs+/NPu8tJyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742353593; c=relaxed/simple;
	bh=bSt/O7czoSNWFRcsE3rQTY00tKWSZJC7M7fXZe1tBRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNy7r/jKZNSmRXVRBAdaY6Ki+R8V3M7mJvKL473pLaEg/8rvsiURetXnaXpuV0638zcVSO1wM+aVhWrGgbPPnPzIqBek2YvXPPDLqF6fmKo8/0nh98VShBh84veLjiwUdsXDPBTkTYu+5YhQor82bJTMWubX3lyhVJB0dAylsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUs5+gRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC99C4CEE3;
	Wed, 19 Mar 2025 03:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742353592;
	bh=bSt/O7czoSNWFRcsE3rQTY00tKWSZJC7M7fXZe1tBRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUs5+gRN7F3D9wjM00iR5qUYJ+zg+KhgaBhp3hIjBKS7MmOnFRi5z4uyKZMByuzpT
	 aRnLHnPrRFmw8TJD3EQ9k+RW4h8RwxCa62cAsI/eHS2et+ABobxSUuR51AjK8Qkkmx
	 aTXLesTsTLkqQ0TyHDI6ckPdzTz7db3ZvW/Nbv9lOSP+4w+eqg/pLJD5mMykQEWnh2
	 +g/1KVNEsR5ZjYg+2/frXjJkI7gO9Zr/97dD3MApFTAzH2nEFs6eoQtXFJbJIxt3kR
	 GrWHMXbljMz8EcObP0y6RWAQ0vYec8y7uKu9SlDUyWi8TEW2Ilp4CmqKbnh1Zx6SnC
	 ZePzyIlyjLcTA==
Date: Tue, 18 Mar 2025 20:06:28 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] string: Add load_unaligned_zeropad() code path to
 sized_strscpy()
Message-ID: <202503181957.55A0E0A@keescook>
References: <20250318214035.481950-1-pcc@google.com>
 <20250318214035.481950-2-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318214035.481950-2-pcc@google.com>

On Tue, Mar 18, 2025 at 02:40:32PM -0700, Peter Collingbourne wrote:
> The call to read_word_at_a_time() in sized_strscpy() is problematic
> with MTE because it may trigger a tag check fault when reading
> across a tag granule (16 bytes) boundary. To make this code
> MTE compatible, let's start using load_unaligned_zeropad()
> on architectures where it is available (i.e. architectures that
> define CONFIG_DCACHE_WORD_ACCESS). Because load_unaligned_zeropad()
> takes care of page boundaries as well as tag granule boundaries,
> also disable the code preventing crossing page boundaries when using
> load_unaligned_zeropad().
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> Cc: stable@vger.kernel.org
> ---
> v2:
> - new approach
> 
>  lib/string.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
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

I would prefer this were written as:

#if !defined(CONFIG_DCACHE_WORD_ACCESS) && \
    defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)

Having 2 #ifs makes me think there is some reason for having them
separable. But the logic here is for a single check.

>  	/*
>  	 * If src is unaligned, don't cross a page boundary,
> @@ -133,12 +134,14 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  	/* If src or dest is unaligned, don't do word-at-a-time. */
>  	if (((long) dest | (long) src) & (sizeof(long) - 1))
>  		max = 0;
> +#endif
>  #endif

(Then no second #endif needed)

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

The rest seems good. Though I do wonder: what happens on a page boundary
for read_word_at_a_time(), then? We get back zero-filled remainder? Will
that hide a missing NUL terminator? As in, it's not actually there
because of the end of the page/granule, but a zero was put in, so now
it looks like it's been terminated and the exception got eaten? And
doesn't this hide MTE faults since we can't differentiate "overran MTE
tag" from "overran granule while over-reading"?

-- 
Kees Cook

