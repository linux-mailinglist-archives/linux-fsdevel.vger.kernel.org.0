Return-Path: <linux-fsdevel+bounces-45538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD1A792D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983577A307C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B918E050;
	Wed,  2 Apr 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBwp1eXJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6A189520;
	Wed,  2 Apr 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610443; cv=none; b=aj1jvBRwYSCVgHYGPUDbNholQjSfQVil4LKTovMwVL4q7OaGJmEAMA0QVdoW6fRAW6z2AMJFQV8w/reGTG6S5vJsHtbWB+ExXmpYabMlKHw7aw7kMizil96YYRVLIqcQfceHVXUrU0TE8pdxavFecEEjqfh7IFdN1q8J00nzVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610443; c=relaxed/simple;
	bh=BDz9DieseZE2NYrLe9TFMsGy80I7PfALxCP3FvqP4mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr3+wxlxymYm1Ls8MK/tXOYqAj0yvEINtjrC4HVfWioFgyNSPyFquYm3FmOqcO4C4D4MfjOJgkxsXtB1DP8KSoQmN0wz5EogIVxwpZmYfiKuCFQfHNhDXVj/IeZoRIpnWgcUPGTbL+s1CY/YhkqB084cEfhe7z4vxEOgfL3o9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBwp1eXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D44C4CEDD;
	Wed,  2 Apr 2025 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743610442;
	bh=BDz9DieseZE2NYrLe9TFMsGy80I7PfALxCP3FvqP4mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBwp1eXJ1AF/yBKz44O+zRJm9o0+h06th/Lm9kldsJS3Omg5DLivhddD8sfQEJaE3
	 w9Ct7Wbf7n859hCSmdtPIksYh5ZbQYpqyvPCB9BpYDHOBS9PHjYswbUxKPAnfzs3+l
	 r/iqpkXy2uwZ4qpyVsfnHTLaf+5vZ29NBa86XUQpKFGh4dWhdbQEdhxTwDBhb+uUaL
	 iXe0/P5iafBPf6+RXLabc3Jv4rhmRBTbN0PqpBEcTZZboPoCvlMlxzuAQYYAVINNnf
	 5sEv6AYQc1tN4apHwDCCu8TVOqAurmS1uickJD/2BiWo9Q5YUEMYxhFaB+RzeV/ueU
	 4KJZZOTHyOVxg==
Date: Wed, 2 Apr 2025 18:13:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: jack@suse.cz, peterz@infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs: allow all writers to be frozen
Message-ID: <20250402-gutbesuchten-miniatur-7d8be831e3d0@brauner>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>
 <20250402-melden-kindisch-8ea1b8c62bb4@brauner>
 <69225f4021ded9337a80cd926856ff3c05774427.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69225f4021ded9337a80cd926856ff3c05774427.camel@HansenPartnership.com>

On Wed, Apr 02, 2025 at 12:03:24PM -0400, James Bottomley wrote:
> On Wed, 2025-04-02 at 17:32 +0200, Christian Brauner wrote:
> [...]
> > Jan, one more thought about freezability here. We know that there
> > will can be at least one process during hibernation that ends up
> > generating page faults and that's systemd-journald. When systemd-
> > sleep requests writing a hibernation image via /sys/power/ files it
> > will inevitably end up freezing systemd-journald and it may be
> > generating a page fault with ->mmap_lock held. systemd-journald is
> > now sleeping with SB_FREEZE_PAGEFAULT and TASK_FREEZABLE. We know
> > this can cause hibernation to fail. That part is fine. What isn't is
> > that we will very likely always trigger:
> > 
> > #ifdef CONFIG_LOCKDEP
> >         /*
> >          * It's dangerous to freeze with locks held; there be dragons
> > there.
> >          */
> >         if (!(state & __TASK_FREEZABLE_UNSAFE))
> >                 WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > #endif
> > 
> > with lockdep enabled.
> > 
> > So we really actually need percpu_rswem_read_freezable_unsafe(),
> > i.e., TASK_FREEZABLE_UNSAFE.
> 
> The sched people have pretty strong views about people not doing this,
> expressed in the comment in sched.h and commit f5d39b020809
> ("freezer,sched: Rewrite core freezer logic") where most of the _unsafe
> variants got removed with prejudice.
> 
> If we do get into this situation the worst that can happen is that
> another upper lock acquisition triggers a hibernate failure and we thaw
> everything, thus we can never truly deadlock, which is the fear, so

Yes, I know that it's harmless but we need to not generate misleading
lockdep splats when lockdep is turned on and confuse users.

> perhaps they might be OK with this.  Note that Rafael's solution to
> this was to disable lockdep around hibernate/suspend and resume, which
> is another possibility.

It can be done as a follow-up. I'm just saying it needs treatment.

