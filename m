Return-Path: <linux-fsdevel+bounces-43651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89325A5A1B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0934318919E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99C2343C9;
	Mon, 10 Mar 2025 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXzR4HdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B96233737;
	Mon, 10 Mar 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630192; cv=none; b=nB9e872vrIVwu1w/Q5t+tEs1SvpQv+LQ3dfPzAx1KkW9s5VOb4ybVarlWmBDJ/63rSHC2w/mDmvElMAMcHD9IOreYjYwjqinWFehUVf192Poq3PtOHa0WM8W9y3wGqzUkKujKY3ywBx1QfQymQid8sVuQUubdC6w3B+HzcgF6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630192; c=relaxed/simple;
	bh=NqjlWBV34qNah3nFVeImdNVUTYXHJApCOBgfG6qXSxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjOeEPSWbrDsvyK6LnKBWOD+JPwIF/lp56NMWKne5spUtXH7i/yz+bE2meeAxZawOYR7uqDwEqAd3h/GBEx9JjdYjfRuYrjG8BUS/M+swZcIPuhWJ/g0ZuFEW25cQgZqAyEa/xbB2oOXaPCzcKiGPNKU7ixQD4OMbiDK361Xkv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXzR4HdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C3C4CEE5;
	Mon, 10 Mar 2025 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630192;
	bh=NqjlWBV34qNah3nFVeImdNVUTYXHJApCOBgfG6qXSxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXzR4HdHNm0lCsWhMS7Qh2ZjVOzf793rCeaBCvEbLwZeZieX3JWFlq4gZvAAmPjyz
	 +IXxKcH2D1GD2eTMbbrioyLSrC46Ufngk3DzORjpFG6zL1zigudZ/E9IyxzG3d3Irx
	 /gJYrBxcr4PtoBIItjeKpMldJ7F88T0Nxlomw/giWIVZaEQB4FqY+tBsKeviBkfhfG
	 +A/HtZ2+76YRzJt/V9IFIe8hoyZEIeoeAN+O+T0O4FmSfeSITfxFX2JO+XaxOs+tkj
	 qAZye9TjbuNu62QFmZC3adnFt5aWSAz+JNmg0SlenJTRG3g1cSSc/ovdo9KAdyR9c6
	 SpHxFa+1X7K0w==
Date: Mon, 10 Mar 2025 11:09:48 -0700
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <pcc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
Message-ID: <202503101107.995ECFA@keescook>
References: <20250308023314.3981455-1-pcc@google.com>
 <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88jbhobIz2yWBbJ@arm.com>

On Mon, Mar 10, 2025 at 05:37:50PM +0000, Catalin Marinas wrote:
> On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > this is incompatible with MTE which will fault on a partially invalid
> > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > bug for now by disabling the optimizations if the kernel is built
> > > with HW tag-based KASAN and consider improvements for followup changes.
> > 
> > Why is faulting on a partially invalid read a problem? It's still
> > invalid, so ... it should fault, yes? What am I missing?
> 
> read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> beyond the end of string. The has_zero() function is then used to check
> where the string ends. For this uses, I think we can go with
> load_unaligned_zeropad() which handles a potential fault and pads the
> rest with zeroes.

Agh, right, I keep forgetting that this can read past the end of the
actual allocation. I'd agree, load_unaligned_zeropad() makes sense
there.

> 
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4bf98ada827fdf755548
> > > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  fs/dcache.c  | 2 +-
> > >  lib/string.c | 3 ++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > Why are DCACHE_WORD_ACCESS and HAVE_EFFICIENT_UNALIGNED_ACCESS separate
> > things? I can see at least one place where it's directly tied:
> > 
> > arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> DCACHE_WORD_ACCESS requires load_unaligned_zeropad() which handles the
> faults. For some reason, read_word_at_a_time() doesn't expect to fault
> and it is only used with HAVE_EFFICIENT_UNALIGNED_ACCESS. I guess arm32
> only enabled load_unaligned_zeropad() on hardware that supports
> efficient unaligned accesses (v6 onwards), hence the dependency.
> 
> > Would it make sense to sort this out so that KASAN_HW_TAGS can be taken
> > into account at the Kconfig level instead?
> 
> I don't think we should play with config options but rather sort out the
> fault path (load_unaligned_zeropad) or disable MTE temporarily. I'd go
> with the former as long as read_word_at_a_time() is only used for
> strings in conjunction with has_zero(). I haven't checked.

Okay, sounds good. (And with a mild thread-merge: yes, folks want to use
KASAN_HW_TAGS=y in production.)

-- 
Kees Cook

