Return-Path: <linux-fsdevel+bounces-18585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BF8BA9F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8487BB20D29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44414F9CC;
	Fri,  3 May 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbvW7QrS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2E42078;
	Fri,  3 May 2024 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714729057; cv=none; b=VUZVEGwxUNTWFQ5fxp/3uGigSObcOItlbo8iEkfwkgvuA5GJlwVBGQuvpMre4O5NiM6oxlX0Gk5NO01OLMZJF3Q61tHCScujcGwkk+XLdWsw/4XpcoJw/1iWF0KwPyr3krJjlqn0NlHFnZdbmCuTt0cAnAYw3Sv17IMxMWoENSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714729057; c=relaxed/simple;
	bh=EY1m386ze5p5efmGezaRioeyr4xQQNVljq2tWo0fXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdiwK+fdeT2SjE/BFBGkMcVFdVuGXDRb/QZtVSapnT/9PDKZXB6ujR+Qv4MovHDxrFoJHI5I6IrSbyFEt4W1FPuYFt2aEc/DjKVrm65TKyRuPNPmzyltd4j6IWynZbqRjTOMtcJyhtCrJKAuJ1YvRFvxorx6W3IQG+OOwkMqgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbvW7QrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E47C116B1;
	Fri,  3 May 2024 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714729056;
	bh=EY1m386ze5p5efmGezaRioeyr4xQQNVljq2tWo0fXlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbvW7QrSUYaP7ll/nGqB8pNM3bYN8sV9MkSKBUePESxJ5x8/Vn3Y+PwKBz/X+x19y
	 2v9TnIRi6ivEtcarof8Y685DmLp3CJlXXRGXdMdiwLqyZr4o5yM2aLqSRa9Nj4+59K
	 REDZ7vgd6608hUHudlZ/ac9mJUabY8+yduLtuNKbgWn2X9VYbzEplRFVv64ePQExSt
	 0AatHid8re8GR7Rofi9O+SJql98nf+mvKZwcX0rW10J6LFM7g+ZifZQ9PfKVL6TLCO
	 KWOixJUGNN5Lgl6iDEJ3WHBgZ+Y7vSVu6PLRZ4olHsDGeO+Cysql0pUbhEl3HXE1mf
	 5crSWWJpt/jrQ==
Date: Fri, 3 May 2024 11:37:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Matt Atwood <matthew.s.atwood@intel.com>, Matthew Auld <matthew.auld@intel.com>, 
	Nirmoy Das <nirmoy.das@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <20240503-inventar-braut-c82e15e56a32@brauner>
References: <20240502222252.work.690-kees@kernel.org>
 <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
 <202405021620.C8115568@keescook>
 <20240502234152.GP2118490@ZenIV>
 <202405021708.267B02842@keescook>
 <20240503001445.GR2118490@ZenIV>
 <202405021736.574A688@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405021736.574A688@keescook>

On Thu, May 02, 2024 at 05:41:23PM -0700, Kees Cook wrote:
> On Fri, May 03, 2024 at 01:14:45AM +0100, Al Viro wrote:
> > On Thu, May 02, 2024 at 05:10:18PM -0700, Kees Cook wrote:
> > 
> > > But anyway, there needs to be a general "oops I hit 0"-aware form of
> > > get_file(), and it seems like it should just be get_file() itself...
> > 
> > ... which brings back the question of what's the sane damage mitigation
> > for that.  Adding arseloads of never-exercised failure exits is generally
> > a bad idea - it's asking for bitrot and making the thing harder to review
> > in future.
> 
> Linus seems to prefer best-effort error recovery to sprinkling BUG()s
> around.  But if that's really the solution, then how about get_file()
> switching to to use inc_not_zero and BUG on 0?

Making get_file() return an error is not an option. For all current
callers that's pointless churn for a condition that's not supposed to
happen at all.

Additionally, iirc *_inc_not_zero() variants are implemented with
try_cmpxchg() which scales poorly under contention for a condition
that's not supposed to happen.

