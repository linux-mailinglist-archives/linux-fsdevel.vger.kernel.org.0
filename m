Return-Path: <linux-fsdevel+bounces-17727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EF8B1DB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920E9286EED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01F83CBE;
	Thu, 25 Apr 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh8fEvfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054097F486;
	Thu, 25 Apr 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036817; cv=none; b=DUD0AGdRTp1z21YiYXyYxsGNaMKycfD/WmDb2AaVZr32VWemtgFTEy2+3+cyT5hdMX40Tz9kHgkyWjip6Br5M/2CVSKBaPZfcfi37KiaKuiKt6uaelXK6o3ihQ9wIyKC2UoiQIS65S21nbae19LyonTtC801LIw+TAumP6gGewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036817; c=relaxed/simple;
	bh=scq4jbe+JsWNWHK4RGuhKPW6OdFPwBIJt/gcCKwEELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEnCmK5dYTL3BJmUoeN5LRKsvOlnjzbg1fimm395RqzHBqNPeA7DOKF4RWY0RBFdrbXMhGg8n1Bv7qtGo+6rVSFBfhxiL9Jtx0KtlIqDPD3dpHPJdX+ajtDLLIV3ydSn09fntmE0EAcYUelCG6Z4PV5SvwtNqzRSDPg5EJrhKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh8fEvfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D875FC113CC;
	Thu, 25 Apr 2024 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714036816;
	bh=scq4jbe+JsWNWHK4RGuhKPW6OdFPwBIJt/gcCKwEELE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qh8fEvfrYgQxU69d6HTI7SeE7dK1kinWQIKJrq8+RzHCuqLvK2ZRcyW3Gn8ig34vf
	 nOJnOoMryesFtgTYuzsCqmrr3qD893xVzquGrbTzX5owFdqLS2V+ByxZ2trlFVNVhw
	 BSAE5MadUJiesNHUll6WNQpJmMQaQ238AbtqZGZJDlZ4HLsiXpICGvVobpAzNyfm8k
	 L6DPbL4WJ1VKv4XtWAYikhegJrt1aggASINWXiZU+KLsdnopuAW8bt+uqNBEcFpozW
	 /X81BvRA77/2p7SU8gJXSditzwbjrnCW/0IZ9EvX3+YUF0tRmGHJVfH8ConMaRwhsK
	 jMUhvbNx67D3g==
Date: Thu, 25 Apr 2024 11:20:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
Message-ID: <20240425-nullnummer-pastinaken-c8cf2f7c41f3@brauner>
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <20240424-befund-unantastbar-9b0154bec6e7@brauner>
 <87a5liy3le.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5liy3le.fsf@intel.com>

On Wed, Apr 24, 2024 at 12:15:25PM -0700, Vinicius Costa Gomes wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Tue, Apr 02, 2024 at 07:18:05PM -0700, Vinicius Costa Gomes wrote:
> >> Hi,
> >> 
> >> Changes from RFC v3:
> >>  - Removed the warning "fixes" patches, as they could hide potencial
> >>    bugs (Christian Brauner);
> >>  - Added "cred-specific" macros (Christian Brauner), from my side,
> >>    added a few '_' to the guards to signify that the newly introduced
> >>    helper macros are preferred.
> >>  - Changed a few guard() to scoped_guard() to fix the clang (17.0.6)
> >>    compilation error about 'goto' bypassing variable initialization;
> >> 
> >> Link to RFC v3:
> >> 
> >> https://lore.kernel.org/r/20240216051640.197378-1-vinicius.gomes@intel.com/
> >> 
> >> Changes from RFC v2:
> >>  - Added separate patches for the warnings for the discarded const
> >>    when using the cleanup macros: one for DEFINE_GUARD() and one for
> >>    DEFINE_LOCK_GUARD_1() (I am uncertain if it's better to squash them
> >>    together);
> >>  - Reordered the series so the backing file patch is the first user of
> >>    the introduced helpers (Amir Goldstein);
> >>  - Change the definition of the cleanup "class" from a GUARD to a
> >>    LOCK_GUARD_1, which defines an implicit container, that allows us
> >>    to remove some variable declarations to store the overriden
> >>    credentials (Amir Goldstein);
> >>  - Replaced most of the uses of scoped_guard() with guard(), to reduce
> >>    the code churn, the remaining ones I wasn't sure if I was changing
> >>    the behavior: either they were nested (overrides "inside"
> >>    overrides) or something calls current_cred() (Amir Goldstein).
> >> 
> >> New questions:
> >>  - The backing file callbacks are now called with the "light"
> >>    overriden credentials, so they are kind of restricted in what they
> >>    can do with their credentials, is this acceptable in general?
> >
> > Until we grow additional users, I think yes. Just needs to be
> > documented.
> >
> 
> Will add some documentation for it, then.
> 
> >>  - in ovl_rename() I had to manually call the "light" the overrides,
> >>    both using the guard() macro or using the non-light version causes
> >>    the workload to crash the kernel. I still have to investigate why
> >>    this is happening. Hints are appreciated.
> >
> > Do you have a reproducer? Do you have a splat from dmesg?
> 
> Just to be sure, with this version of the series the crash doesn't
> happen. It was only happening when I was using the guard() macro
> everywhere.
> 
> I just looked at my crash collection and couldn't find the splats, from
> what I remember I lost connection to the machine, and wasn't able to
> retrieve the splat.
> 
> I believe the crash and clang 17 compilation error point to the same
> problem, that in ovl_rename() some 'goto' skips the declaration of the
> (implicit) variable that the guard() macro generates. And it ends up
> doing a revert_creds_light() on garbage memory when ovl_rename()
> returns.

If this is a compiler bug this warrants at least a comment in the commit
message because right now people will be wondering why that place
doesn't use a guard. Ideally we can just use guards everywhere though
and report this as a bug against clang, I think.

> 
> (if you want I can try and go back to "guard() everywhere" and try a bit
> harder to get a splat)
> 
> Does that make sense?

Yes.

