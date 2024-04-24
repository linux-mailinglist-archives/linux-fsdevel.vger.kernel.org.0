Return-Path: <linux-fsdevel+bounces-17658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E631B8B11AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D4C1F27A1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97E16D9C7;
	Wed, 24 Apr 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efB4MlTY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02A16D4E5;
	Wed, 24 Apr 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981921; cv=none; b=nIAYAeERa9d7LzEanQXNBcB/wqbfl1ginK2Qya15fdAtW/83vFswcq6sxMK/spbdb7iCPrl8z4nuBd+zkjF+ne7beSoG+QL0/gg5mrBsx0gb/vTCOY3fsPpwzWfPLIFQALw0DABy6QM8lR43G6xb9289pN4DBKCtdscrfbWTU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981921; c=relaxed/simple;
	bh=zq0zHx53sTHh6Nsl6y6RNxf2hPcfnIHynYrrmGqJJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6pPmckEvKuMF4ReZmi5/vmVRhPzM7fU6uU1Sk3EDEt1LCdxD5pNpGQurxdOSML3p8Rf5VQXSGq3k8bK2kucau9yuOExqR9ohbRHTF+jhcGwlDabmkoAs0emc6EQcgcsV1QJKWH3bGOBaSUCp3pgDx7YZxu/FJGbJyerdeo1AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efB4MlTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B919BC113CD;
	Wed, 24 Apr 2024 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713981920;
	bh=zq0zHx53sTHh6Nsl6y6RNxf2hPcfnIHynYrrmGqJJgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efB4MlTYeTwU/9WwZRvNGuCeNTtOoLkTBH7D0+kPf90N/hJjHAwoDS8ZArAT2+WoR
	 aa+a7sOQzJ+Zxnhxii1rsunX+rrRZy3ZoRRI8rDqQ2rahWnjCEhdrxbioDjaJagEnG
	 EgJMPVxG5Ki9LXOMdUxe5VXz9hSMCH9T2TGZWxy6frWUyuAMabBGcbevNBLxz6oRgj
	 X4WC2V835o4bISKSS33WHp/nISpcD5wG+VvBckf11V1pme0dxXlsG+jmXI1FpmCGDh
	 A09uKNZw+9lO2uBYmtc+MDpWTWPhuMGWUThHP4qPr05q1yHM6Gzdd8KT4Jv62IelRB
	 mYDQhp0yEPxZA==
Date: Wed, 24 Apr 2024 11:05:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/13] fsverity: remove system-wide workqueue
Message-ID: <20240424180520.GJ360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
 <20240405031407.GJ1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405031407.GJ1958@quark.localdomain>

On Thu, Apr 04, 2024 at 11:14:07PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:35:48PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Now that we've made the verity workqueue per-superblock, we don't need
> > the systemwide workqueue.  Get rid of the old implementation.
> 
> This commit message needs to be rephrased because this commit isn't just
> removing unused code.  It's also converting ext4 and f2fs over to the new
> workqueue type.  (Maybe these two parts belong as separate patches?)

Yes, will fix that.

> Also, if there are any changes in the workqueue flags that are being used for
> ext4 and f2fs, that needs to be documented.

Hmm.  The current codebase does this:

	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
						  WQ_HIGHPRI,
						  num_online_cpus());

Looking at commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from
fsverity read workqueue"), I guess you want a bound workqueue so that
the CPU that handles the readahead ioend will also handle the verity
validation?

Why do you set max_active to num_online_cpus()?  Is that because the
verity hash is (probably?) being computed on the CPUs, and there's only
so many of those to go around, so there's little point in making more?
Or is it to handle systems with more than WQ_DFL_ACTIVE (~256) CPUs?
Maybe there's a different reason?

If you add more CPUs to the system later, does this now constrain the
number of CPUs that can be participating in verity validation?  Why not
let the system try to process as many read ioends as are ready to be
processed, rather than introducing a constraint here?

As for WQ_HIGHPRI, I wish Dave or Andrey would chime in on why this
isn't appropriate for XFS.  I think they have a reason for this, but the
most I can do is speculate that it's to avoid blocking other things in
the system.

In Andrey's V5 patch, XFS creates its own the workqueue like this:
https://lore.kernel.org/linux-xfs/20240304191046.157464-10-aalbersh@redhat.com/

	struct workqueue_struct *wq = alloc_workqueue(
		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);

I don't grok this either -- read ioend workqueues aren't usually
involved in memory reclaim at all, and I can't see why you'd want to
freeze the verity workqueue during suspend.  Reads are allowed on frozen
filesystems, so I don't see why verity would be any different.

In the end, I think I might change this to:

int __fsverity_init_verify_wq(struct super_block *sb,
			      unsigned int wq_flags,
			      int max_active)
{
	wq = alloc_workqueue("fsverity/%s", wq_flags, max_active, sb->s_id);
	...
}

So that XFS can have what I think makes sense (wq_flags == 0,
max_active == 0), and ext4/f2fs can continue the same way they do now.

--D

> - Eric
> 

