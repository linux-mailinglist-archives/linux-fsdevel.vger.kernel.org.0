Return-Path: <linux-fsdevel+bounces-19296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072418C2F61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE00B2849CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 03:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96B36AFE;
	Sat, 11 May 2024 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZwzBI6Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9821A04
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398590; cv=none; b=N4X/UK9BIawwRiMtg1Xn4AkEmVaksci0V+iHAZKB4jns0eAkqrYGZtx5b/G09IeOQPrQUYgg4yHjNQi43b0qAnxOir0MWMK8mkympcAh+5YvKZgyQ7tPWO/PdOE4IUXETSJjjOrQY3Kwhi8cMHpO84QURRXVcn6mM1QO0I+iQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398590; c=relaxed/simple;
	bh=XzUqIkDUv3jxPHBE6rhptdczpeAXralYPUsv5HLlY7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPpVsX+fBocwd0SgDzSgKRsTiawvxHRAvwQ8v2IeCuMr7YXRNGhimlizsz52oHAvRLSpRedtHvm7jKINFeTbOhKmpVoHZEMQP7fRFr6rgylr6XQpEnPbvJOv320UPfImX7VstHGeg7MgPSub+icNc071IsbRh3dBY3t459zDMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZwzBI6Rw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Evxrh8g1D17dCUEUHoXQ4vovRP4QBU+NL956A3oGEpU=; b=ZwzBI6RwVua/f1zPxq+Kcdt+3Q
	pa2t10wNLvaw+rHVbV7UIB+syUdf3x3pgE1VGOM4Sk93ZcpvaOnquzobBe8VbbKneKH37Lx9lNlZg
	FLKoaH0pcb00CTqNEDealZ5U4rpiRbiReetG6f8TtSky+Sbz82A/1NRlSFT0wpEYDWsaxDFfzwwuj
	VQkeRq15nivZc2qPLR9J3Nk5PEgXlMel1HFpWbHcPOIJIaE7E1JLVPOXOZ3oCCu0+/W0ymKA04tA+
	71PQxCJ+TFSTzZNIFysWrZ9NyNF09Czmp2kRnf7OPURqqZ4n6RmAbRdHY5paaiMR0C82M3rThIluK
	LpsjUNaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5dX1-003FLL-1z;
	Sat, 11 May 2024 03:36:19 +0000
Date: Sat, 11 May 2024 04:36:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
Message-ID: <20240511033619.GZ2118490@ZenIV>
References: <20240511022729.35144-1-laoar.shao@gmail.com>
 <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 07:53:49PM -0700, Linus Torvalds wrote:

> although I think Al needs to ACK this, and I suspect that unhashing
> the dentry also makes that
> 
>                 dentry->d_flags &= ~DCACHE_CANT_MOUNT;
> 
> pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
> just won't matter).
> 
> I do worry that there are loads that actually love our current
> behavior, but maybe it's worth doing the simple unconditional "make
> d_delete() always unhash" and only worry about whether that causes
> performance problems for people who commonly create a new file in its
> place when we get such a report.
> 
> IOW, the more complex thing might be to actually take other behavior
> into account (eg "do we have so many negative dentries that we really
> don't want to create new ones").
> 
> Al - can you please step in and tell us what else I've missed, and why
> my suggested version of the patch is also broken garbage?

Need to RTFS and think for a while; I think it should be OK, but I'll need
to dig through the tree to tell if there's anything nasty for e.g. network
filesystems.

Said that, I seriously suspect that there are loads where it would become
painful.  unlink() + creat() is _not_ a rare sequence, and this would
shove an extra negative lookup into each of those.

I would like to see the details on original posters' setup.  Note that
successful rmdir() evicts all children, so that it would seem that their
arseloads of negative dentries come from a bunch of unlinks in surviving
directories.

It would be interesting to see if using something like
	mkdir graveyard
	rename victim over there, then unlink in new place
	rename next victim over there, then unlink in new place
	....
	rmdir graveyard
would change the situation with memory pressure - it would trigger
eviction of all those negatives at controlled point(s) (rmdir).
I'm not saying that it's a good mitigation, but it would get more
details on that memory pressure.

