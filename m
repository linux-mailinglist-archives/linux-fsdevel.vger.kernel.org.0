Return-Path: <linux-fsdevel+bounces-19128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15E8C0597
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C86282C2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A3130AFE;
	Wed,  8 May 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWeWglbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AD225D9;
	Wed,  8 May 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199964; cv=none; b=B7GHgOg/qvXsPoZl2WRtCDavMmzyWDDvegQgnjm5grHc1mdVxWyd6wRdnfejzryiUsupyCMgKgAMCy5vaNc+80RFryGFZ741tsmTr7L155pl1eSOQgEtCdGGT3k4McIBZxZuRDVcwqdCIR8pj//TbnUuyTr1ZlRB307pUHFBrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199964; c=relaxed/simple;
	bh=6M7QmQ2qdk76tVQwOg9zL5ApxEyFjT3pY7zUyU5IX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsj249mHZkz2yUwI68wFMETXDQusvbgs7KnOHXhTkAjt/fcIyVPuf1Vx/B4lhF/FVpRG4shh0mycdggHqcNYnT/Ub65KwYtUHCvTuDNxps3X0yu26Lwg4SEq6cY3jXdkLYwve8/kznfo+gHqhohPGphHnnwG3YN2elH2e/rrA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWeWglbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E3C113CC;
	Wed,  8 May 2024 20:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199964;
	bh=6M7QmQ2qdk76tVQwOg9zL5ApxEyFjT3pY7zUyU5IX2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWeWglbOilt/ShTFpvhe2XS/Cg1aaP6pGL4OzyjbcL6zT6XyPkNmhAUKg3lo1gMvp
	 3hVVIpCOmnJYkLDMETHp+rbEoGHNmu6ReNBMuChEiYOvp8MFE779IEziZUrd2e/b/z
	 /mpuq488gBJIqgSGmoikAbUqnGmZsLyy8xinyKv+s5+hdfcjXIm06hQwopAav6FQ2h
	 s4vWe3DaBFci5EcFr/4jxC6zdSDogvDdPRJk3l8JzZR13QDPhG9AwH8SC54Q/Pd4cB
	 oXMhIP6cDfAuwQiK7Lv464V1d00fZ+N+WNT+QsktEEd+ifn5euP4UX0M0yQm3sEkRS
	 X4uonCd3jhd8A==
Date: Wed, 8 May 2024 13:26:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240508202603.GC360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjtmVIST_ujh_ld6@infradead.org>

On Wed, May 08, 2024 at 04:47:32AM -0700, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 02:24:54PM -0700, Darrick J. Wong wrote:
> > Since we know the size of the merkle data ahead of time, we could also
> > preallocate space in the attr fork and create a remote ATTR_VERITY xattr
> > named "merkle" that points to the allocated space.  Then we don't have
> > to have magic meanings for the high bit.
> 
> Note that high bit was just an example, a random high offset
> might be a better choice, sized with some space to spare for the maximum
> verify data.

I guess we could make it really obvious by allocating range in the
mapping starting at MAX_FILEOFF and going downwards.  Chances are pretty
good that with the xattr info growing upwards they're never going to
meet.

> > Will we ever have a merkle tree larger than 2^32-1 bytes in length?  If
> > that's possible, then either we shard the merkle tree, or we have to rev
> > the ondisk xfs_attr_leaf_name_remote structure.
> 
> If we did that would be yet another indicator that they aren't attrs
> but something else.  But maybe I should stop banging that drum and
> agree that everything is a nail if all you got is a hammer.. :)

Hammer?  All I've got is a big block of cheese. :P

FWIW the fsverity code seems to cut us off at U32_MAX bytes of merkle
data so that's going to be the limit until they rev the ondisk format.

> > I think we have to rev the format anyway, since with nrext64==1 we can
> > have attr fork extents that start above 2^32 blocks, and the codebase
> > will blindly truncate the 64-bit quantity returned by
> > xfs_bmap_first_unused.
> 
> Or we decide the space above 2^32 blocks can't be used by attrs,
> and only by other users with other means of discover.  Say the
> verify hashes..

Well right now they can't be used by attrs because xfs_dablk_t isn't big
enough to fit a larger value.  The dangerous part here is that the code
silently truncates the outparam of xfs_bmap_first_unused, so I'll fix
that too.

--D

