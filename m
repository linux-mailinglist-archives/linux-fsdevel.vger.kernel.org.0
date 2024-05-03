Return-Path: <linux-fsdevel+bounces-18602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68198BAACF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 12:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78B01C209C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B461514D0;
	Fri,  3 May 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N8I4+Cwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05CF14BF85;
	Fri,  3 May 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732598; cv=none; b=cHA1nP9IAgF0+Xn+gP67TBpC+rAAvw014bbKFUKVVPAYz3kaqfixgkofOjJQ/fVonTAE1L7t+OEQ6HPUTx7FBj7QVI9IYgE1/0AM5kqU4RitLaRbxj5biGHEqrSimvok7iwfgu+teuvUKKCUAgqI3m184yVLoODSIGPFHBN4Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732598; c=relaxed/simple;
	bh=E1HUFQRNQQzIWGVLLr1YxlSskv3v0oqQToBpRizAc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf5TR56DawSoIjN0FXYOZTcINarNT1QM6mlebQdV/KLRrSNimQD9Oo1eMLW3cStoPiKMO1pNZCwnfO3rtJ4sx8M//pYemIOYI/Nr9qNgfpmyI1WuigMdsbkrpFuSRkt0slImZd/BMqWItkMWEkIRNcFfiDD4zyftxAPCUacGVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N8I4+Cwi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qh5Wc3QqXgam82TMaOdVdy+cfP6ZNoEKs7ddCVe4jPY=; b=N8I4+CwiBUkzZYIyGzOqQsvzoP
	cCulMNJhaL2ygzPgYmNxiIytFGF+IHAZTJlW+4byTl+H1wU91wfyhXytPSpMyruKM0qH5KSX0/zb3
	M0q8Xbygslb8bYQIpKyIjcsZNaQg/QlWYyn52lYXcksuWoDoJPjWtlzs918/ctl5xS4pp+70AejpZ
	OhT/9b+OOu90NRC9JXP0qfZxYlcy+pcNpDPFbgfrnHw1FTRS23pxj0DUFeYKUk3VnYsJropW0Di81
	TbrsNflYBNuzXjCwiY53z3m6L9fTjcAMDy3NRSeShDj/z2uaw7qLx2j5fikTkkfH5hfv1oFxw5CPT
	fv3XU5Zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2qH0-00000000W9c-2SYt;
	Fri, 03 May 2024 10:36:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 402B93001FD; Fri,  3 May 2024 12:36:14 +0200 (CEST)
Date: Fri, 3 May 2024 12:36:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: Convert struct file::f_count to refcount_long_t
Message-ID: <20240503103614.GF30852@noisy.programming.kicks-ass.net>
References: <20240502223341.1835070-5-keescook@chromium.org>
 <20240502224250.GM2118490@ZenIV>
 <202405021548.040579B1C@keescook>
 <20240502231228.GN2118490@ZenIV>
 <202405021620.C8115568@keescook>
 <20240502234152.GP2118490@ZenIV>
 <202405021708.267B02842@keescook>
 <20240503001445.GR2118490@ZenIV>
 <202405021736.574A688@keescook>
 <20240503-inventar-braut-c82e15e56a32@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-inventar-braut-c82e15e56a32@brauner>

On Fri, May 03, 2024 at 11:37:25AM +0200, Christian Brauner wrote:
> On Thu, May 02, 2024 at 05:41:23PM -0700, Kees Cook wrote:
> > On Fri, May 03, 2024 at 01:14:45AM +0100, Al Viro wrote:
> > > On Thu, May 02, 2024 at 05:10:18PM -0700, Kees Cook wrote:
> > > 
> > > > But anyway, there needs to be a general "oops I hit 0"-aware form of
> > > > get_file(), and it seems like it should just be get_file() itself...
> > > 
> > > ... which brings back the question of what's the sane damage mitigation
> > > for that.  Adding arseloads of never-exercised failure exits is generally
> > > a bad idea - it's asking for bitrot and making the thing harder to review
> > > in future.
> > 
> > Linus seems to prefer best-effort error recovery to sprinkling BUG()s
> > around.  But if that's really the solution, then how about get_file()
> > switching to to use inc_not_zero and BUG on 0?
> 
> Making get_file() return an error is not an option. For all current
> callers that's pointless churn for a condition that's not supposed to
> happen at all.
> 
> Additionally, iirc *_inc_not_zero() variants are implemented with
> try_cmpxchg() which scales poorly under contention for a condition
> that's not supposed to happen.

	unsigned long old = atomic_long_fetch_inc_relaxed(&f->f_count);
	WARN_ON(!old);

Or somesuch might be an option?

