Return-Path: <linux-fsdevel+bounces-17661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807448B1285
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A121C239DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7217C7C;
	Wed, 24 Apr 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IePWjqjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80E168C7;
	Wed, 24 Apr 2024 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984074; cv=none; b=sj8Yz9JyVu9Sh5O75p48o0DOczSAlH8wbQQmDIfOh6gpKEx0MGDFhVlzkLXrz+qTpI8x6u2dGq/6NLk7Kq0uEoc/Wh9jrO68MR8sqfzlhuup/DQTfjb2uTq5YLEeVOC3wo+3dJw0pVTuKiVBiT45EOrDKwuMfDN5gtBY/M7ww/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984074; c=relaxed/simple;
	bh=eB9EQyBDF0uTJ+LFQlzjPq7kaLkEhXwifiQYH0LwTJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSBvupSBSABFA3W71q3sL8Q0ufK8cs4MEu/vrkC0P6b48QOkeIjnXfyXwayc/+oU8wxW+/+E7hjN6LCshQsrDI2U+BC7kq8HFhYxWoPQqfU+wk6kYx035l74PypCoxwcVCIfj+n28+zzxS2MFB0AoBrLYK6iNwdVZJG9e/Rmu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IePWjqjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA8C113CD;
	Wed, 24 Apr 2024 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984074;
	bh=eB9EQyBDF0uTJ+LFQlzjPq7kaLkEhXwifiQYH0LwTJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IePWjqjJpHQOfTr1dOhCkB4B1U2pSeWoO/7X3H7jDAxdcFqtQjvu/3GBRwGcGLp4Z
	 bpbqWPy0aVxuhwLvNMa3kg7uNZ3/dNVpCpt9YJ+kLzlt5Tji8qCo9Cs3+AqZpcbY9P
	 5FNJTNRIiFEnwPEnCWyHn68umxWC7TCT+yRmHGEI+ikQIPgiobkv6vXulTnAjtockQ
	 a8I5HJKXBJdnTd5z1So/KXx80t/t3XAaYDhwjvF/1tvxOGkBueomDGx/WTNbFaCtjM
	 jWCWhR2lYGDBxV6PklSOgBFjo172tMsyvpKUnw4VEtilw8XrSyg6YiULeIOOlVhgD6
	 9F5W/rZEZ7jaw==
Date: Wed, 24 Apr 2024 18:41:12 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/13] fsverity: remove system-wide workqueue
Message-ID: <20240424184112.GA693059@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
 <20240405031407.GJ1958@quark.localdomain>
 <20240424180520.GJ360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424180520.GJ360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 11:05:20AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 04, 2024 at 11:14:07PM -0400, Eric Biggers wrote:
> > On Fri, Mar 29, 2024 at 05:35:48PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Now that we've made the verity workqueue per-superblock, we don't need
> > > the systemwide workqueue.  Get rid of the old implementation.
> > 
> > This commit message needs to be rephrased because this commit isn't just
> > removing unused code.  It's also converting ext4 and f2fs over to the new
> > workqueue type.  (Maybe these two parts belong as separate patches?)
> 
> Yes, will fix that.
> 
> > Also, if there are any changes in the workqueue flags that are being used for
> > ext4 and f2fs, that needs to be documented.
> 
> Hmm.  The current codebase does this:
> 
> 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> 						  WQ_HIGHPRI,
> 						  num_online_cpus());
> 
> Looking at commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from
> fsverity read workqueue"), I guess you want a bound workqueue so that
> the CPU that handles the readahead ioend will also handle the verity
> validation?

That was the intent of that commit.  Hashing is fast enough on modern CPUs that
it seemed best to just do the work on the CPU that the interrupt comes in on,
instead of taking the performance hit of migrating the work to a different CPU.
The cost of CPU migration was measured to be very significant on arm64.

However, new information has come in indicating that the switch to a bound
workqueue is harmful in some cases.  Specifically, on some systems all storage
interrupts happen on the same CPU, and if the fsverity (or dm-verity -- this
applies there too) work takes too long due to having to read a lot of Merkle
tree blocks, too much work ends up queued up on that one CPU.

So this is an area that's under active investigation.  For example, some
improvements to unbound workqueues were upstreamed in v6.6, and I'll be taking a
look at those and checking whether switching back to an appropriately-configured
unbound workqueue would help.

> Why do you set max_active to num_online_cpus()?  Is that because the
> verity hash is (probably?) being computed on the CPUs, and there's only
> so many of those to go around, so there's little point in making more?
> Or is it to handle systems with more than WQ_DFL_ACTIVE (~256) CPUs?
> Maybe there's a different reason?
> 
> If you add more CPUs to the system later, does this now constrain the
> number of CPUs that can be participating in verity validation?  Why not
> let the system try to process as many read ioends as are ready to be
> processed, rather than introducing a constraint here?

I'm afraid that not much thought has been put into the value of max_active.
dm-crypt has long used an unbound workqueue with max_active=num_online_cpus(),
and I think I had just copied it from there.  Then commit f959325e6ac3 just
didn't change it when removing WQ_UNBOUND.

According to Documentation/core-api/workqueue.rst, max_active is a per-CPU
attribute.  So I doubt that num_online_cpus() makes sense regardless of bound or
unbound.  It probably should just use the default value of 256 (which is
specified by passing max_active=0).

> As for WQ_HIGHPRI, I wish Dave or Andrey would chime in on why this
> isn't appropriate for XFS.  I think they have a reason for this, but the
> most I can do is speculate that it's to avoid blocking other things in
> the system.

I think it's been shown that neither option (WQ_HIGHPRI or !WQ_HIGHPRI) is best
in all cases.  Ideally, the work for each individual I/O request would get
scheduled at a priority that is appropriate for that particular I/O.  This same
problem shows up for dm-crypt, dm-verity, etc.

So if you have a reason to use !WQ_HIGHPRI for now, that seems reasonable, but
really all these subsystems need to be much smarter about scheduling their work.

- Eric

