Return-Path: <linux-fsdevel+bounces-18119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31228B5F21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CC0B221A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCF85922;
	Mon, 29 Apr 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfyk3HIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B284A58;
	Mon, 29 Apr 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408552; cv=none; b=HHd617YptkU6m9QSFDYltqt679yOVQWTITWeKi2c14iRM0NwuUmvMEXFfGiA71mnWvXruje78SkEBvEZ5uiqzLtsvXp52IIGNk1J3GBfg2rljJzpJJBMOECQXao5u0kJBj4rafsfM5V2m7PoJwWf6rUQOQ8WVz41dUAL6SohsOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408552; c=relaxed/simple;
	bh=Tkte1ZXDpuj4Yqy27Z3wPjS9EO/uFnFgnqfi4bNHG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJGaTy3tTlw8x+K1L8weL62vVaubWuBgcRpLpDt9kC8Pz4KsApvwmA7PWl/BeGPZ/IlSY+jVEQYfzzWUgwIHads2Q+ATJHDLyafcIAfnRBeyBj4vFpFy7qH+TLrJce4GlJpajSlGCRoTUu5Ws2opCORqeuN6cIe30dcsWsHxXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfyk3HIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227E5C4AF1B;
	Mon, 29 Apr 2024 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408552;
	bh=Tkte1ZXDpuj4Yqy27Z3wPjS9EO/uFnFgnqfi4bNHG7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tfyk3HIAkPaEoXfOOGrrEaB5tW1bz7aRk3cWP14ZeP46WJdATa87w21AzjSsd5XOP
	 9aAOl3HGR6hWceZU5qvZJZMdiGk5A4Nr6+8yrfV04aBsOPH/DlBQs4ilNz6DpPm7uC
	 EFxbgs/hfvIeVST9N5+AXHJQDZgPwTTBJasg61wGHHAzHJWdB01bR7+2ZWzAJcngp6
	 8rPHFraWAYOlwAg53a4OLJR1UJUV+mswKC4qg11Dqc7k/ln/jVNIEj6qg3oF2cGS0e
	 s1tqMtoGqozJx9XRsK1qY1e31XYnEPMhIhWOgZnNq9mg91JnnosYT3uBHbDZvovioA
	 1DQNdueqv8gNQ==
Date: Mon, 29 Apr 2024 09:35:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/13] fsverity: remove system-wide workqueue
Message-ID: <20240429163551.GD360898@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
 <20240405031407.GJ1958@quark.localdomain>
 <20240424180520.GJ360919@frogsfrogsfrogs>
 <j6a357qbjsf346khicummgmutjvkircf7ff7gd7for2ajn4k7q@q6dw22io6dcp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j6a357qbjsf346khicummgmutjvkircf7ff7gd7for2ajn4k7q@q6dw22io6dcp>

On Mon, Apr 29, 2024 at 12:15:55PM +0200, Andrey Albershteyn wrote:
> On 2024-04-24 11:05:20, Darrick J. Wong wrote:
> > On Thu, Apr 04, 2024 at 11:14:07PM -0400, Eric Biggers wrote:
> > > On Fri, Mar 29, 2024 at 05:35:48PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Now that we've made the verity workqueue per-superblock, we don't need
> > > > the systemwide workqueue.  Get rid of the old implementation.
> > > 
> > > This commit message needs to be rephrased because this commit isn't just
> > > removing unused code.  It's also converting ext4 and f2fs over to the new
> > > workqueue type.  (Maybe these two parts belong as separate patches?)
> > 
> > Yes, will fix that.
> > 
> > > Also, if there are any changes in the workqueue flags that are being used for
> > > ext4 and f2fs, that needs to be documented.
> > 
> > Hmm.  The current codebase does this:
> > 
> > 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> > 						  WQ_HIGHPRI,
> > 						  num_online_cpus());
> > 
> > Looking at commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from
> > fsverity read workqueue"), I guess you want a bound workqueue so that
> > the CPU that handles the readahead ioend will also handle the verity
> > validation?
> > 
> > Why do you set max_active to num_online_cpus()?  Is that because the
> > verity hash is (probably?) being computed on the CPUs, and there's only
> > so many of those to go around, so there's little point in making more?
> > Or is it to handle systems with more than WQ_DFL_ACTIVE (~256) CPUs?
> > Maybe there's a different reason?
> > 
> > If you add more CPUs to the system later, does this now constrain the
> > number of CPUs that can be participating in verity validation?  Why not
> > let the system try to process as many read ioends as are ready to be
> > processed, rather than introducing a constraint here?
> > 
> > As for WQ_HIGHPRI, I wish Dave or Andrey would chime in on why this
> > isn't appropriate for XFS.  I think they have a reason for this, but the
> > most I can do is speculate that it's to avoid blocking other things in
> > the system.
> 
> The log uses WQ_HIGHPRI for journal IO completion
> log->l_ioend_workqueue, as far I understand some data IO completion
> could require a transaction which make a reservation which
> could lead to data IO waiting for journal IO. But if data IO
> completion will be scheduled first this could be a possible
> deadlock... I don't see a particular example, but also I'm not sure
> why to make fs-verity high priority in XFS.

Ah, ok.  I'll add a comment about that to my patch then.

> > In Andrey's V5 patch, XFS creates its own the workqueue like this:
> > https://lore.kernel.org/linux-xfs/20240304191046.157464-10-aalbersh@redhat.com/
> > 
> > 	struct workqueue_struct *wq = alloc_workqueue(
> > 		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> > 
> > I don't grok this either -- read ioend workqueues aren't usually
> > involved in memory reclaim at all, and I can't see why you'd want to
> > freeze the verity workqueue during suspend.  Reads are allowed on frozen
> > filesystems, so I don't see why verity would be any different.
> 
> Yeah maybe freezable can go away, initially I picked those flags as
> most of the other workqueues in xfs are in same configuration.

<nod>

--D

> -- 
> - Andrey
> 
> 

