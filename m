Return-Path: <linux-fsdevel+bounces-29512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F897A5BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1491C2769F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D591598F4;
	Mon, 16 Sep 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSi9rUnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14930155C98;
	Mon, 16 Sep 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502882; cv=none; b=YfepXuXthnKf9PwNw6YsQNH5PuZMqwQkgR0x55N2X5IfA0virzCpRi7zXVWhBKTDa8AzDyLBO5FcEVyUdG/xUcAKMOx8JfYzSOqar6biL9PTESD7QtN09ONUw8APejOVpZm06gA+I55C6tkLpBy8dE6wjaTq9TiwKZpYHorQpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502882; c=relaxed/simple;
	bh=SWTvLUexMhFlY181nJ/U8NnITWW9fyYDLU1b0tWo3xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdGWPSNSSalPGmV1hlEGD5Lco9s+ixq4IdW3iqFCPq8hN9YIOUd1DDW3+/yKctaeAo9DMf64pDQDH3jIRFiY2I7TRaD0/3HsuK3b4v41U/fs0aa4rhr+sNSpHsa8UBwQg5nulUImQU2Lo8xCHBbdB+nwNspjDEu7wJBXnw2Sg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSi9rUnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C5C4CEC5;
	Mon, 16 Sep 2024 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726502881;
	bh=SWTvLUexMhFlY181nJ/U8NnITWW9fyYDLU1b0tWo3xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSi9rUnhjnilk07rjUOY4raDWQMon8jbujKcgOberEG9A4tTNd68VwAREvC8DtEHm
	 6IuP2d8VH0ZfYEZmc7YIdLgJ4yX6dGRrVptQLtLTjrvfWNm6l9RWgZMCbBHdCDE5RK
	 jVL11Vq2itVqnTrLPkZrp50AverAoqW3I/JcUoP4pNiTyER8uB8xPA4JukJabefOMh
	 4r/vofE/exFGW6DObcWLVjFM0GXYHBIgf8DXhoOEdBvgYx8rds6TitWeku8oTMEWAJ
	 VH0DqZp5SD1sByHncw4o7YrPpm7YWo5c7HEG153grmlHfHcfEQMqDHnThH7lAR63oI
	 kMSPh7S32kQCg==
Date: Mon, 16 Sep 2024 09:08:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240916160801.GA182194@frogsfrogsfrogs>
References: <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
 <20240807150503.GF6051@frogsfrogsfrogs>
 <20240827033506.GH865349@frogsfrogsfrogs>
 <20240905081241.GM4723@noisy.programming.kicks-ass.net>
 <20240905091605.GE4928@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905091605.GE4928@noisy.programming.kicks-ass.net>

On Thu, Sep 05, 2024 at 11:16:05AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 05, 2024 at 10:12:41AM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 26, 2024 at 08:35:06PM -0700, Darrick J. Wong wrote:
> 
> > > [33965.988873] ------------[ cut here ]------------
> > > [33966.013870] WARNING: CPU: 1 PID: 8992 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> 
> > > [33966.040184] pc : __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> > > [33966.042845] lr : __static_key_slow_dec_cpuslocked.part.0+0x48/0xc0
> 
> > > [33966.072840] Call trace:
> > > [33966.073838]  __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> > > [33966.076105]  static_key_slow_dec+0x48/0x88
> 
> > > This corresponds to the:
> > > 
> > > 	WARN_ON_ONCE(!static_key_slow_try_dec(key));
> > 
> > But but but,... my patch killed that function. So are you sure it is
> > applied ?!
> > 
> > Because this sounds like exactly that issue again.
> > 
> > Anyway, it appears I had totally forgotten about this issue again due to
> > holidays, sorry. Let me stare hard at Thomas' patch and make a 'pretty'
> > one that does boot.
> 
> I've taken tglx's version with a small change (added comment) and boot
> tested it and queued it here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent
> 
> Could you please double check on both x86_64 and arm64?

Will send this out on the test farm tonight, thanks for the patch.

> If green by with the build robots and your own testing I'll push this
> into tip/locking/urgent to be sent to Linus on Sunday. Hopefully finally
> resolving this issue.

Sorry I didn't get to this earlier; I've been on vacation since the end
of August.  Now to get to the ~1300 fsdevel emails... ;)

--D

