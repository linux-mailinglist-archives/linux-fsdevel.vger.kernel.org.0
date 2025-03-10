Return-Path: <linux-fsdevel+bounces-43648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E377A59E3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CC7A85AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3646232786;
	Mon, 10 Mar 2025 17:29:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8922FF40;
	Mon, 10 Mar 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627750; cv=none; b=ofPRqBPekRDHvP1u6fL/jfetTQDnqAqsPRY0cOp6Go6ozLRFpGW0Pn3runetuBaHmyMpayW2dxuNQK4yOAPaPNd+TKN3GarVmUe/kub0b4PKSFEWr6Wc33PnEbdELa25w4Hc8+BSPrjBGyTXduRcDJMPAnM0nNNLQq+Z/DDQWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627750; c=relaxed/simple;
	bh=5xnuI1TveaclJB5R/6loAt6lIQ6vPPgbqwh7vS1MAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXXg/GPhcsN94ixGi079Fu3dPsIHjOI8WmTFyM3AKQbwWRh16aWsKrRJ2oD+sqmDhOfa2FLAzxZXGVOwSSJnrSpvbRiubDXJeSekN5/qKg9JABGeC6D0iMimIyLhnMHx80BSQwG3uDCaxwb0pBCQXanSULAUh2+q3CUf3vjj3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61A4C4CEE5;
	Mon, 10 Mar 2025 17:29:07 +0000 (UTC)
Date: Mon, 10 Mar 2025 17:29:05 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
Message-ID: <Z88hYdTAe6ok4_WT@arm.com>
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
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> Cc: stable@vger.kernel.org

Some time ago Vincenzo had an attempt at fixing this but neither of us
got around to posting it. It's on top of 6.2 and not sure how cleanly it
would rebase:

git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/mte-strscpy

Feel free to cherry-pick patches from above, rewrite them etc.

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

Assuming that no-one wants to ever use KASAN_HW_TAGS=y in production,
this patch would do. Otherwise I'd rather use TCO around the access as
per the last patch from Vincenzo above.

Yet another option - use load_unaligned_zeropad() instead of
read_word_at_a_time(), not sure how it changes the semantics of
strscpy() in any way. This can be done in the arch code

-- 
Catalin

