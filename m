Return-Path: <linux-fsdevel+bounces-18951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D68BEEBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09842817A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6DF74433;
	Tue,  7 May 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5MvJLhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BD187326;
	Tue,  7 May 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116391; cv=none; b=Hnh21CmUJRzP+ZLw/p9xQ26jd30cbQ9d5z1LuuuplYDz8v7gwPUKtxaQEN2h9olDqmhxqCZoxPJ0hq1DDuFPw24QVfo2vrnjSZfBcoaYm6kmbNoIlRWKtsi6crnoRT6DPjBXw38gVjSskWYSFQvgsyH5XZZu5G7ZlsodUyInAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116391; c=relaxed/simple;
	bh=TrK/HQl6cRzmC2myzYV+mRcGrE69UCP6jKEvenXWgnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il8Z2ggSFXkQpvIAjBSuwQNUWdYNKmJ5pFHViRetlemQag7TFdClkSaA7qVGLeDHNssM5iPv4jt/fHKyvoC46gkuEWOAjIoIODH24G8bIEez8dW7MvatyE+nMuvGkjJhGUmja0/mCFec+yxJYfeHzFPjrW0vTV9UK7FB9qBKQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5MvJLhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16510C2BBFC;
	Tue,  7 May 2024 21:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715116391;
	bh=TrK/HQl6cRzmC2myzYV+mRcGrE69UCP6jKEvenXWgnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5MvJLhyKfV8u/qyAsvf2tSznMLAqpQHln891YiqiPBldbclCZO1XL1eXx2jpD0Rn
	 Ji16VjrUx9yyjmFN25KCetsvxb+165k7+rG7VfxV+q6pdtfq0iBZM/XPIbWIjdVTyW
	 vJfTwYXK1+BkPzSepiOF0qCAYfJanyStbFUteGbLBnezH6dj4CajsC0mv0gVnyGUqu
	 y4t7AtOfWyAkMLv0Gc4K2dh5GBk5j97unEIGpMI8VR6IitKp1EAzH9I38e2UAZLY09
	 ctCXei+OdYArXRug+Usmau5Dk7tFwNl83w/d8VHO2QbZvU9xm1508Fru7LMxUup7fx
	 7xCre+ouriTYA==
Date: Tue, 7 May 2024 14:13:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240507211310.GW360919@frogsfrogsfrogs>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-11-mcgrof@kernel.org>
 <b3a3e9c1-91ca-4c7f-81a7-03f905ee0bd8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a3e9c1-91ca-4c7f-81a7-03f905ee0bd8@oracle.com>

On Tue, May 07, 2024 at 09:40:58AM +0100, John Garry wrote:
> On 03/05/2024 10:53, Luis Chamberlain wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> > make the calculation generic so that page cache count can be calculated
> > correctly for LBS.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >   fs/xfs/xfs_mount.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > index df370eb5dc15..56d71282972a 100644
> > --- a/fs/xfs/xfs_mount.c
> > +++ b/fs/xfs/xfs_mount.c
> > @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
> >   {
> >   	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> >   	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> > +	uint64_t max_index;
> > +	uint64_t max_bytes;

Extra nit: the  ^ indentation of the names should have tabs, like the
other xfs functions.

--D

> nit: any other XFS code which I have seen puts the declarations before any
> ASSERT() calls
> 
> > +
> > +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> > +		return -EFBIG;
> >   	/* Limited by ULONG_MAX of page cache index */
> > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > +	max_index = max_bytes >> PAGE_SHIFT;
> > +
> > +	if (max_index > ULONG_MAX)
> >   		return -EFBIG;
> >   	return 0;
> >   }
> 
> 

