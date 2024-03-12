Return-Path: <linux-fsdevel+bounces-14238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4E879C8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09E1B2181A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182B1428E8;
	Tue, 12 Mar 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0UFOkfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555D14264A;
	Tue, 12 Mar 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273865; cv=none; b=gKGkd1FaDC+tQHYZmkNtXWlTOT3clWajo7WvXEdyTpSTmqEobipqiSkAh/J8qQy+w5vLn3qaOXlXmzWkmH9swss3CEWBCicTGT/jc43FfB/oExvbalcMA24L/ppeIUlWrG4sKUhL89YAgdgs+TX4kNl5nakDZPi8BCA3d+RxR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273865; c=relaxed/simple;
	bh=wGKWClSQQRwZy90nShMoXFRc7nVDMa4c4zEHzuS5hJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlNfmAEtxbIF4/M/vtIpgT9d+GSc4zWT0aDJrOhzUE7ndsu9/OK4HuqoV+zGNltR+X79ohLsUiY9nVl4Y+7h+3sVOkNPJtPA5rWPDJ91Q3bWw0EuEXNgUDj/iZHtKJMs3L10dBY58vwVgLkXK6txje1aidASP+gKjv4XNB5Ke0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0UFOkfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142AC433F1;
	Tue, 12 Mar 2024 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710273864;
	bh=wGKWClSQQRwZy90nShMoXFRc7nVDMa4c4zEHzuS5hJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0UFOkfgVLcQFOIoyLAkMKvtZb1tebcgwx77x0A61rz5z8m73KrqNWztlks9tFBA4
	 AoISAlxtovLNTnk07oq26xIL+jMacN1Z/0Ps3yuGF3eOfpv/n7HUjLQQY68E2TQ++v
	 I6rWnFLE/TF1JOn3mFj+NuMzil3d0mgE0ySZL7/ol8t9XwAKv65h4rto7DWmqFQM5C
	 5TnHrBjHB2RqhjNPcvpMKS5LLp6aiwpDijK+eoI9YYRFAbkDHkfSiMZ2mGWjlVQxfz
	 GItbDnAy5DDCctulxfB9AdZJKkmLGvabQZuf3lwxGcbVWSeuAe8fRPPM71gdHioSXm
	 k5PWZXIZRW+zg==
Date: Tue, 12 Mar 2024 13:04:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240312200424.GH1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
 <20240312024507.GY1927156@frogsfrogsfrogs>
 <Ze/9rdVsnwyksHmi@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze/9rdVsnwyksHmi@dread.disaster.area>

On Tue, Mar 12, 2024 at 06:01:01PM +1100, Dave Chinner wrote:
> On Mon, Mar 11, 2024 at 07:45:07PM -0700, Darrick J. Wong wrote:
> > On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:
> > > > But, if a generic blob cache is what it takes to move this forwards,
> > > > so be it.
> > > 
> > > Not necessarily. ;)
> > 
> > And here's today's branch, with xfs_blobcache.[ch] removed and a few
> > more cleanups:
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=fsverity-cleanups-6.9_2024-03-11
> 
> Walking all the inodes counting all the verity blobs in the shrinker
> is going to be -expensive-. Shrinkers are run very frequently and
> with high concurrency under memory pressure by direct reclaim, and
> every single shrinker execution is going to run that traversal even
> if it is decided there is nothing that can be shrunk.
> 
> IMO, it would be better to keep a count of reclaimable objects
> either on the inode itself (protected by the xa_lock when
> adding/removing) to avoid needing to walk the xarray to count the
> blocks on the inode. Even better would be a counter in the perag or
> a global percpu counter in the mount of all caches objects. Both of
> those pretty much remove all the shrinker side counting overhead.

I went with a global percpu counter, let's see if lockdep/kasan have
anything to say about my new design. :P

> Couple of other small things.
> 
> - verity shrinker belongs in xfs_verity.c, not xfs_icache.c. It
>   really has nothing to do with the icache other than calling
>   xfs_icwalk(). That gets rid of some of the config ifdefs.

Done.

> - SHRINK_STOP is what should be returned by the scan when
>   xfs_verity_shrinker_scan() wants the shrinker to immediately stop,
>   not LONG_MAX.

Aha.  Ok, thanks for the tipoff. ;)

> - In xfs_verity_cache_shrink_scan(), the nr_to_scan is a count of
>   how many object to try to free, not how many we must free. i.e.
>   even if we can't free objects, they are still objects that got
>   scanned and so should decement nr_to_scan...

<nod>

Is there any way for ->scan_objects to tell its caller how much memory
it actually freed?  Or does it only know about objects?  I suppose
"number of bytes freed" wouldn't be that helpful since someone else
could allocate all the freed memory immediately anyway.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

