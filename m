Return-Path: <linux-fsdevel+bounces-14840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC68806A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A90DB21D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BFD3FBAF;
	Tue, 19 Mar 2024 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLSYEA8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF53FB2F;
	Tue, 19 Mar 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883067; cv=none; b=cV8gm2HCT0LzUnt8ClgEuUUs1oZIji72afwq736ZRWXGmuJtFUjldAhmL46E0wZ6DLZl8LznFPxye5aJnrGs8E6AftIh0LEMY7ZtHVxcu73kAXr65kvpgBPWfIuYfNpvaT9EF+DUiBesMX5EJGCDSvdiIwH6d1NKrmbsVoU6tOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883067; c=relaxed/simple;
	bh=36O9vw9EBtZzC6TQxml09VKdUquslgZ2K9MadCGJOjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZUbk2iVrEFj+PY0cfkfRORDKtty7JrMztxDiyuwiiGU5cDvFjFSclYps9sElYCTjRWyJlOBSPRwEKU+d29pXDQlGdPF4hbA0uVRduCez9ErsjvB3c602xDGkAQzqwzOaUeCDZbAhJkZyqrqcPpzH+IpJ0wpCH89mT3cX3cWfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLSYEA8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1FFC43390;
	Tue, 19 Mar 2024 21:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883067;
	bh=36O9vw9EBtZzC6TQxml09VKdUquslgZ2K9MadCGJOjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLSYEA8vW3d8FQAvkBwx8Q3kdLJVvG77T4i71PCYA8JvV1kkWypUyFo3BVvvOxBIq
	 fGGc9dWa3kEqaQ1B8FzaNNJ1UxjXCx+m2q7v8FhKP81wcaPQpLbDOoqyuavSgFYmuI
	 pUUq5fhVW6dW3HcLbapi759oO+yRY2Su/HQkPs9RUa9r/820Gn7whZ4b5S190Tu+MI
	 fIp6KynVOP5GYTMvxik3qR+QBiSz68qpEaHP0xl7KGGByXc6WI8Hzr+dZheatQEhyH
	 v46YlrpXtgWQO4hksEEnYcfczWG0Iskt+Xb8KlGZ+lPG4XhDQSmALPNXNLFsz//mhx
	 oY+xMvhfb64YQ==
Date: Tue, 19 Mar 2024 14:17:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 24/40] xfs: disable direct read path for fs-verity files
Message-ID: <20240319211746.GO1927156@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246296.2684506.17423583037447505680.stgit@frogsfrogsfrogs>
 <eb7rlbfslyht2vmn7ocqcx5fkjyrle4ocgex6hmjxzs4gtkkgm@mvmsrj7sgojd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7rlbfslyht2vmn7ocqcx5fkjyrle4ocgex6hmjxzs4gtkkgm@mvmsrj7sgojd>

On Mon, Mar 18, 2024 at 08:48:47PM +0100, Andrey Albershteyn wrote:
> On 2024-03-17 09:29:39, Darrick J. Wong wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > The direct path is not supported on verity files. Attempts to use direct
> > I/O path on such files should fall back to buffered I/O path.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > [djwong: fix braces]
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/xfs_file.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 74dba917be93..0ce51a020115 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -281,7 +281,8 @@ xfs_file_dax_read(
> >  	struct kiocb		*iocb,
> >  	struct iov_iter		*to)
> >  {
> > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > +	struct xfs_inode	*ip = XFS_I(inode);
> >  	ssize_t			ret = 0;
> >  
> >  	trace_xfs_file_dax_read(iocb, to);
> > @@ -334,10 +335,18 @@ xfs_file_read_iter(
> >  
> >  	if (IS_DAX(inode))
> >  		ret = xfs_file_dax_read(iocb, to);
> > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> 
> Brackets missing

Oops, will fix that.  Thanks!

--D

> >  		ret = xfs_file_dio_read(iocb, to);
> > -	else
> > +	else {
> > +		/*
> > +		 * In case fs-verity is enabled, we also fallback to the
> > +		 * buffered read from the direct read path. Therefore,
> > +		 * IOCB_DIRECT is set and need to be cleared (see
> > +		 * generic_file_read_iter())
> > +		 */
> > +		iocb->ki_flags &= ~IOCB_DIRECT;
> >  		ret = xfs_file_buffered_read(iocb, to);
> > +	}
> >  
> >  	if (ret > 0)
> >  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> > 
> > 
> 
> -- 
> - Andrey
> 
> 

