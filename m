Return-Path: <linux-fsdevel+bounces-4794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E937803D39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DFBB209FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482F2FC3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBX05rBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28932EAE0;
	Mon,  4 Dec 2023 18:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E2DC433C7;
	Mon,  4 Dec 2023 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701713844;
	bh=Fi3pCbX8xBLieIUl9i0+l3BnMEoZrFImzIzLlsbdmlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBX05rBXcx3ydA9sc8mTA1ymvmz4Tbzz4ipYsOMzJwDp1ClUWoLQipwGJy1B2ADNR
	 YkmKuZ/Lqx86w+MELHqE7hN5P9AVRcAPrpwA7neD/d19X4kRo7PdpNTUupwLmn1Qwe
	 6lUjhNpN/xXHzmSxNbvhGgyGB5/RcsEuLlTFfM9AhlTDYdcgkRXdABeUgl4DZhzENz
	 xL4IUZsGH0M10mKsRlQj1A1tLf3ODzjze5ZGrjJgqE0Swe1YxLiscoZJ1wBVU93r+L
	 LIO9sv41gm4RohmK+Qfx20R7yOGMPoKjm6cgaLxOnYOQKe28gj5s3EaFRVNHZYBOfg
	 wsvkI/ci8fS+Q==
Date: Mon, 4 Dec 2023 10:17:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Message-ID: <20231204181723.GW361584@frogsfrogsfrogs>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
 <ZWpZJicSjW2XqMmp@dread.disaster.area>
 <2aced048-4d4b-4a48-9a45-049f73763697@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aced048-4d4b-4a48-9a45-049f73763697@oracle.com>

On Mon, Dec 04, 2023 at 09:02:56AM +0000, John Garry wrote:
> On 01/12/2023 22:07, Dave Chinner wrote:
> > > Sure, and I think that we need a better story for supporting buffered IO for
> > > atomic writes.
> > > 
> > > Currently we have:
> > > - man pages tell us RWF_ATOMIC is only supported for direct IO
> > > - statx gives atomic write unit min/max, not explicitly telling us it's for
> > > direct IO
> > > - RWF_ATOMIC is ignored for !O_DIRECT
> > > 
> > > So I am thinking of expanding statx support to enable querying of atomic
> > > write capabilities for buffered IO and direct IO separately.
> > You're over complicating this way too much by trying to restrict the
> > functionality down to just what you want to implement right now.
> > 
> > RWF_ATOMIC is no different to RWF_NOWAIT. The API doesn't decide
> > what can be supported - the filesystems themselves decide what part
> > of the API they can support and implement those pieces.
> 
> Sure, but for RWF_ATOMIC we still have the associated statx call to tell us
> whether atomic writes are supported for a file and the specific range
> capability.
> 
> > 
> > TO go back to RWF_NOWAIT, for a long time we (XFS) only supported
> > RWF_NOWAIT on DIO, and buffered reads and writes were given
> > -EOPNOTSUPP by the filesystem. Then other filesystems started
> > supporting DIO with RWF_NOWAIT. Then buffered read support was added
> > to the page cache and XFS, and as other filesystems were converted
> > they removed the RWF_NOWAIT exclusion check from their read IO
> > paths.
> > 
> > We are now in the same place with buffered write support for
> > RWF_NOWAIT. XFS, the page cache and iomap allow buffered writes w/
> > RWF_NOWAIT, but ext4, btrfs and f2fs still all return -EOPNOTSUPP
> > because they don't support non-blocking buffered writes yet.
> > 
> > This is the same model we should be applying with RWF_ATOMIC - we
> > know that over time we'll be able to expand support for atomic
> > writes across both direct and buffered IO, so we should not be
> > restricting the API or infrastructure to only allow RWF_ATOMIC w/
> > DIO.
> 
> Agreed.
> 
> > Just have the filesystems reject RWF_ATOMIC w/ -EOPNOTSUPP if
> > they don't support it,
> 
> Yes, I was going to add this regardless.
> 
> > and for those that do it is conditional on
> > whther the filesystem supports it for the given type of IO being
> > done.
> > 
> > Seriously - an application can easily probe for RWF_ATOMIC support
> > without needing information to be directly exposed in statx() - just
> > open a O_TMPFILE, issue the type of RWF_ATOMIC IO you require to be
> > supported, and if it returns -EOPNOTSUPP then it you can't use
> > RWF_ATOMIC optimisations in the application....
> 
> ok, if that is the done thing.
> 
> So I can't imagine that atomic write unit range will be different for direct
> IO and buffered IO (ignoring for a moment Christoph's idea for CoW always
> for no HW offload) when supported. But it seems that we may have a scenario
> where statx tells is that atomic writes are supported for a file, and a DIO
> write succeeds and a buffered IO write may return -EOPNOTSUPP. If that's
> acceptable then I'll work towards that.
> 
> If we could just run statx on a file descriptor here then that would be
> simpler...

statx(fd, "", AT_EMPTY_PATH, ...); ?

--D

> Thanks,
> John
> 
> 
> 

