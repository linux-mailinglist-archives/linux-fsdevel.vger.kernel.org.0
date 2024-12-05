Return-Path: <linux-fsdevel+bounces-36514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9733D9E4D9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B4168FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8642019645D;
	Thu,  5 Dec 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVjYU5lA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC59391;
	Thu,  5 Dec 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733380231; cv=none; b=UrZA1gx/uvvTHqPhbiDrtlUtX6pTs34L5OIVkbmsEuBMzs7vlQJo19hcYz1CMmRAH+FRj4pGYnC1O9LqDcMrHgio3Gk8XjheV2chJXznNCciNOWCwgVFbDRg2cZr5S8xtG6K+8UGaYGULp5FOlS147jWDZZpGY80SR+Y6gocJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733380231; c=relaxed/simple;
	bh=pHDzzAf3v8GSZ8qKguo0Q6fJBH+b3rMdeW/GCZUwYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkYQTK987kDR+tgorOe7av4XlGWp0YxZQsNdigJ8B0OTsGGt38zCbmaL/fXEErz/S2XnHxJOadn/ISMWZlvk0ijMZX3980bI4Seai+dSnyiKuyXWBKSF4o0CkjfJ+rDePnPbWKjSrM4uVHxzDlzRV+RaWPTVGT7Bc51TE2TsoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVjYU5lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536BAC4CED1;
	Thu,  5 Dec 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733380230;
	bh=pHDzzAf3v8GSZ8qKguo0Q6fJBH+b3rMdeW/GCZUwYyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVjYU5lA4++A+Z7dpc+iCMzgvUix6Nx63lkjGX3Q1v8ycKQk/taEKXBtbMHThMugd
	 X1o8Px/4ajCQbiC1wYLKbFsGi90Oo9qGbuPk62YKxCYrVQqi1LLA13aH0E2aSkZIjy
	 +BX9PHvk5Q7pxLdyvIPZTUgie0KzG3yyLcP3T6B//nc+9DcAL/o89OuK5/h1lE7zlh
	 /z995HcrnitzPJ0tNCGKhU79raKkzbf3pRJRn+lznMX5LaUyNAIBS12EbdpYCMUfZV
	 dUMGozq7OrklvgdU+fHG4vVl75DuG86LUaw16Y9eDRo4OnLvBGGQ0RnmGEt6IwaNGy
	 JhXMEp2iYgf0g==
Date: Wed, 4 Dec 2024 22:30:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20241205063029.GB7820@frogsfrogsfrogs>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1C9IfLgB_jDCF18@dread.disaster.area>

On Thu, Dec 05, 2024 at 07:35:45AM +1100, Dave Chinner wrote:
> On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > Filesystems like ext4 can submit writes in multiples of blocksizes.
> > But we still can't allow the writes to be split into multiple BIOs. Hence
> > let's check if the iomap_length() is same as iter->len or not.
> > 
> > It is the responsibility of userspace to ensure that a write does not span
> > mixed unwritten and mapped extents (which would lead to multiple BIOs).
> 
> How is "userspace" supposed to do this?
> 
> No existing utility in userspace is aware of atomic write limits or
> rtextsize configs, so how does "userspace" ensure everything is
> laid out in a manner compatible with atomic writes?
> 
> e.g. restoring a backup (or other disaster recovery procedures) is
> going to have to lay the files out correctly for atomic writes.
> backup tools often sparsify the data set and so what gets restored
> will not have the same layout as the original data set...
> 
> Where's the documentation that outlines all the restrictions on
> userspace behaviour to prevent this sort of problem being triggered?
> Common operations such as truncate, hole punch, buffered writes,
> reflinks, etc will trip over this, so application developers, users
> and admins really need to know what they should be doing to avoid
> stepping on this landmine...

I'm kinda assuming that this requires forcealign to get the extent
alignments correct, and writing zeroes non-atomically if the extent
state gets mixed up before retrying the untorn write.  John?

> Further to that, what is the correction process for users to get rid
> of this error? They'll need some help from an atomic write
> constraint aware utility that can resilver the file such that these
> failures do not occur again. Can xfs_fsr do this? Or maybe the new
> exchangr-range code? Or does none of this infrastructure yet exist?

TBH aside from databases doing pure overwrites to storage hardware, I
think everyone else would be better served by start_commit /
commit_range since it's /much/ more flexible.

> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > jpg: tweak commit message
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/iomap/direct-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index b521eb15759e..3dd883dd77d2 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	size_t copied = 0;
> >  	size_t orig_count;
> >  
> > -	if (atomic && length != fs_block_size)
> > +	if (atomic && length != iter->len)
> >  		return -EINVAL;
> 
> Given this is now rejecting IOs that are otherwise well formed from
> userspace, this situation needs to have a different errno now. The
> userspace application has not provided an invalid set of
> IO parameters for this IO - the IO has been rejected because
> the previously set up persistent file layout was screwed up by
> something in the past.
> 
> i.e. This is not an application IO submission error anymore, hence
> EINVAL is the wrong error to be returning to userspace here.

Admittedly it would be useful to add at least a couple of new errnos for
alignment issues and incorrect file storage mapping states.  How
difficult is it to get a new errno code added to uapi and then plumbed
into glibc?  Are new errno additions to libc still gate-kept by Ulrich
or is my knowlege 15 years out of date?

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

