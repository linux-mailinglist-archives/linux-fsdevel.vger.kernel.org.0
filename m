Return-Path: <linux-fsdevel+bounces-18605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3988BABB1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3964C283880
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329541534E0;
	Fri,  3 May 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU+Pbgfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A0152180;
	Fri,  3 May 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736165; cv=none; b=JCr6zMqcgsmRZ0pz5j+67A9OZHeqr3ibwh49H1MALaLLQ1YcSZbe84JwGyukg/3nbFmahd7lauzOiKId0Qs1TXedY1iuuSf/hU+AIyWHO+P1DkxL+mttWhPLE1u0wYuW8kTGAr4A+g+YF+xfvsZkz+3FMSIygG5CF1SuF9moYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736165; c=relaxed/simple;
	bh=fIbetBuQVrEG023U7eI1zy1F+Dx8KclRAJyueT8XV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcs9VHaEGz8HRsx3M2aMzxXWKtIzWXPp5RT5cSotSajMnZp2kmU1YJcFjjSXd0W/9a22F+GaTZds8fMtFHGtVRks8Una2Z3VXIO2RuiYyKLieHsBCKOgx6mwtOqbqIu8FNQnbMXlThMcLDVqelOoKXG4O7cd4GD20JRHxr9AR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU+Pbgfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FEDC116B1;
	Fri,  3 May 2024 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714736165;
	bh=fIbetBuQVrEG023U7eI1zy1F+Dx8KclRAJyueT8XV4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kU+PbgfmV2WYTvcKoIKD2SagvRYfVtWIILVja2exLH0MFtfHic0+Py5SLz8ioBh2c
	 bqpbYbxJ/W9l6syTIapYfSN8oXLB4jn8f3Me0mm0uAJK/HVh9Fym6kP9MVBwSMsr3k
	 Jxor+f8RX7pVwuuRJivzQlZh7ay51U+v39/npfLfZ7SyAMSRMB4SIfamdKqeQwinVk
	 K9VNzZ0cPydBqTF+/eTYn5JPlrfdcNvCY5ixi4VD0+WIvYHt43TEYrbf91dw/oLydB
	 tffGxIoNupZL31C61JfQelalR2aYh/QVLvdIroxHiS3/lJQpV1lJ/uyXJPQRKOstnd
	 l8jmPUnOkSLrw==
Date: Fri, 3 May 2024 13:35:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	Matt Atwood <matthew.s.atwood@intel.com>, Matthew Auld <matthew.auld@intel.com>, 
	Nirmoy Das <nirmoy.das@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <20240503-kramen-punkten-848aa0cfd3d0@brauner>
References: <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
 <202405021620.C8115568@keescook>
 <20240502234152.GP2118490@ZenIV>
 <202405021708.267B02842@keescook>
 <20240503001445.GR2118490@ZenIV>
 <202405021736.574A688@keescook>
 <20240503-inventar-braut-c82e15e56a32@brauner>
 <20240503103614.GF30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503103614.GF30852@noisy.programming.kicks-ass.net>

On Fri, May 03, 2024 at 12:36:14PM +0200, Peter Zijlstra wrote:
> On Fri, May 03, 2024 at 11:37:25AM +0200, Christian Brauner wrote:
> > On Thu, May 02, 2024 at 05:41:23PM -0700, Kees Cook wrote:
> > > On Fri, May 03, 2024 at 01:14:45AM +0100, Al Viro wrote:
> > > > On Thu, May 02, 2024 at 05:10:18PM -0700, Kees Cook wrote:
> > > > 
> > > > > But anyway, there needs to be a general "oops I hit 0"-aware form of
> > > > > get_file(), and it seems like it should just be get_file() itself...
> > > > 
> > > > ... which brings back the question of what's the sane damage mitigation
> > > > for that.  Adding arseloads of never-exercised failure exits is generally
> > > > a bad idea - it's asking for bitrot and making the thing harder to review
> > > > in future.
> > > 
> > > Linus seems to prefer best-effort error recovery to sprinkling BUG()s
> > > around.  But if that's really the solution, then how about get_file()
> > > switching to to use inc_not_zero and BUG on 0?
> > 
> > Making get_file() return an error is not an option. For all current
> > callers that's pointless churn for a condition that's not supposed to
> > happen at all.
> > 
> > Additionally, iirc *_inc_not_zero() variants are implemented with
> > try_cmpxchg() which scales poorly under contention for a condition
> > that's not supposed to happen.
> 
> 	unsigned long old = atomic_long_fetch_inc_relaxed(&f->f_count);
> 	WARN_ON(!old);
> 
> Or somesuch might be an option?

Yeah, I'd be fine with that. WARN_ON() (or WARN_ON_ONCE() even?) and
then people can do their panic_on_warn stuff to get the BUG_ON()
behavior if they want to.

