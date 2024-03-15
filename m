Return-Path: <linux-fsdevel+bounces-14420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668A87C7CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 04:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA131F22C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B891D27A;
	Fri, 15 Mar 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4m5uex+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD54DDA3;
	Fri, 15 Mar 2024 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471599; cv=none; b=Cm1w+puCx617O3vTQnfpOiwCTSJ9EHLhmEBdjMgRBzwVbCv5VyTEoJ+IAu5X4cbfjcH34sR6LZ+BaiEVwr9NI/by4Cg03vzViP04Aw6aJyxNwGSIGUG0gtPBjSBewgvJedxN+xWgXGbQU93Ag2ccalGPkGo0wWvaFLloKVsJE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471599; c=relaxed/simple;
	bh=Ip4m2q25TU6UcwznB7KKcnF1wm/xAIQfgUUxRpAckCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIbPIFpRxb5LqS3sJwC/EtZuDc0EovHUEIZl49DN1QZ7X43D4cBZy3Zx8Eo4hIFdKE7yXHrXCkFwoo3bPmkSJnQWPN5MPVhmAwhp1qLZVYh2Y+3BtsrCMe1OY1jgUUXzEXfmtuNODYagq31maL3EnDeQzTCXnpfkJxRAAqtDi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4m5uex+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA5C433C7;
	Fri, 15 Mar 2024 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710471599;
	bh=Ip4m2q25TU6UcwznB7KKcnF1wm/xAIQfgUUxRpAckCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4m5uex+3/2PV0S/VEzfFJG3ffbUAsa06ofDg/HgIayzirTpoCM4LIS4RXPE2tR6c
	 eiU6P1OniQbbdwH8AgpU98/rpIFuAqXd59uhZJChHjgwwlu8R/YtMl4yP3xOsfTe7q
	 rlTipkbIWBjXa2vecxuOkzHYx8q4u0YPw2Kro3R8D1lsHaBsYdL7utUpBmMmHE0DJp
	 ewQf7aPfaa442EYZ614bwHZKDbehubZztxyKw89APhk5j+yv6dbtHoSEYQp8/PqS+m
	 sx2Fi6nPckumcFLhdONTo5RKyidFMGlIH8UecmTvoMFUkYatxERuWBKgep9EGuSxCy
	 uRpJwgAUyYsAQ==
Date: Thu, 14 Mar 2024 19:59:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 21/29] xfs: add fs-verity support
Message-ID: <20240315025958.GP6184@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223693.2613863.3986547716372413007.stgit@frogsfrogsfrogs>
 <20240314170620.GR1927156@frogsfrogsfrogs>
 <lveodvnohv4orprbr7xte2c3bbspd3ttmx2e5f5bvtf3353kfa@qsjqrliz4urs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lveodvnohv4orprbr7xte2c3bbspd3ttmx2e5f5bvtf3353kfa@qsjqrliz4urs>

On Thu, Mar 14, 2024 at 06:16:02PM +0100, Andrey Albershteyn wrote:
> On 2024-03-14 10:06:20, Darrick J. Wong wrote:
> > On Wed, Mar 13, 2024 at 10:58:03AM -0700, Darrick J. Wong wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > Add integration with fs-verity. The XFS store fs-verity metadata in
> > > the extended file attributes. The metadata consist of verity
> > > descriptor and Merkle tree blocks.
> > > 
> > > The descriptor is stored under "vdesc" extended attribute. The
> > > Merkle tree blocks are stored under binary indexes which are offsets
> > > into the Merkle tree.
> > > 
> > > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > > flag is set meaning that the Merkle tree is being build. The
> > > initialization ends with storing of verity descriptor and setting
> > > inode on-disk flag (XFS_DIFLAG2_VERITY).
> > > 
> > > The verification on read is done in read path of iomap.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > [djwong: replace caching implementation with an xarray, other cleanups]
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > I started writing more of userspace (xfs_db decoding of verity xattrs,
> > repair/scrub support) so I think I want to make one more change to this.
> 
> Just to note, I have a version of xfs_db with a few modification to
> make it work with xfstests and make it aware of fs-verity:
> 
> https://github.com/alberand/xfsprogs/tree/fsverity-v5

<nod> I implemented online and offline repair today and made a few more
tweaks; after I let it run through QA overnight I'll send that out to
the list.

Note that I moved the to_disk/from_disk helpers back to xfs_da_format.h
and added some more hooks to fsverity so that online fsck can do some
basic checks for stale merkle tree blocks and the like.

Also I modified xfs_verity_write_merkle to skip trailing zeroes to save
space, and changed the hash function to use the merkle tree offset so
that the merkle blocks get written out in linear(ish) order with fewer
hash collisions in the xattr index.

That said, I think we're close to finished on this one. :)

--D

> -- 
> - Andrey
> 
> 

