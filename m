Return-Path: <linux-fsdevel+bounces-14222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6587991B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C920AB228B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DD7E586;
	Tue, 12 Mar 2024 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLEJEeKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD047E562;
	Tue, 12 Mar 2024 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261393; cv=none; b=KzRmMuwXEVTFvan/LFzod3lKJHkosf/dmRRALzGW/JF0BsUh33IpbwuN0R4pjh+IAvfC2uiLzwrag9gR+o9sj/kvc6/zDaaCprz1ejKrf/oUdoKo8pdMaAFjentHj6MmqxAqvsIIFJ+0Wakd+ptn9tQONkppeOM21GKvL7qhkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261393; c=relaxed/simple;
	bh=zsxbOvHfyLUuMu8xagpDsyR46O8ifg/IpPWSKsT3oos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d37JKZp/r010W/0i2ZbtoWI+/O8W2lcaFaHsrNMWftkPJHkg9ipN0xoA8TRuO2PFOejoskupbIqHx9xMUAryLMLj+JAVIbYIwXcnNjKUAOXut88RDtJ0/99IZm7/mqcP3J1SZPxybBr2UuZzv+EBaONIrgMvxb2YoyuYKDkQBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLEJEeKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB0C433F1;
	Tue, 12 Mar 2024 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261393;
	bh=zsxbOvHfyLUuMu8xagpDsyR46O8ifg/IpPWSKsT3oos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLEJEeKsHVccLEgiZriXl/WBg+4vic1e0IUnhMCI14r3tfXFSCbgbarkI2NqSxifT
	 TnkUFutLSFRYMh03OdIadEV3DDVs7hEOCfYHhHSIxpy3REg9HKewvsy5IiSG5HrBXz
	 SoSTXCKwFdh70pQvex5rd7LIZKHZ6YA6oYzZ/jU0jgyezulGU4nYtUgNonyCQPSetD
	 k5ObdYop1X1M03gcljXQDRWZekQf5zOE8g+IipjeqXlkjV24f4HBQhhLdlZZkKswU6
	 PkeoGFYTQMvJ4mR4UvJPcvMTgL/qsnYG0jTIU13Fb3sBvbiVA9zxFllo+D+j1Hyojo
	 50uvQYkRf7Hdw==
Date: Tue, 12 Mar 2024 09:36:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 20/24] xfs: disable direct read path for fs-verity
 files
Message-ID: <20240312163632.GE1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-22-aalbersh@redhat.com>
 <20240307221108.GX1927156@frogsfrogsfrogs>
 <w23uzzjqhu7mt4qp532vwjd3c7triq6vfftzsmi6ofium34qic@fghx7nfarmke>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w23uzzjqhu7mt4qp532vwjd3c7triq6vfftzsmi6ofium34qic@fghx7nfarmke>

On Tue, Mar 12, 2024 at 01:02:52PM +0100, Andrey Albershteyn wrote:
> On 2024-03-07 14:11:08, Darrick J. Wong wrote:
> > On Mon, Mar 04, 2024 at 08:10:43PM +0100, Andrey Albershteyn wrote:
> > > The direct path is not supported on verity files. Attempts to use direct
> > > I/O path on such files should fall back to buffered I/O path.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 17404c2e7e31..af3201075066 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -281,7 +281,8 @@ xfs_file_dax_read(
> > >  	struct kiocb		*iocb,
> > >  	struct iov_iter		*to)
> > >  {
> > > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > >  	ssize_t			ret = 0;
> > >  
> > >  	trace_xfs_file_dax_read(iocb, to);
> > > @@ -334,10 +335,18 @@ xfs_file_read_iter(
> > >  
> > >  	if (IS_DAX(inode))
> > >  		ret = xfs_file_dax_read(iocb, to);
> > > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> > >  		ret = xfs_file_dio_read(iocb, to);
> > > -	else
> > > +	else {
> > 
> > I think the earlier cases need curly braces {} too.
> > 
> > > +		/*
> > > +		 * In case fs-verity is enabled, we also fallback to the
> > > +		 * buffered read from the direct read path. Therefore,
> > > +		 * IOCB_DIRECT is set and need to be cleared (see
> > > +		 * generic_file_read_iter())
> > > +		 */
> > > +		iocb->ki_flags &= ~IOCB_DIRECT;
> > 
> > I'm curious that you added this flag here; how have we gotten along
> > this far without clearing it?
> > 
> > --D
> 
> Do you know any better place? Not sure if that should be somewhere
> before. I've made it same as ext4 does it.

It's not the placement that I'm wondering about, it's /only/ the
clearing of IOCB_DIRECT.

Notice how directio writes (xfs_file_write_iter) fall back to buffered
without clearing that flag:


	if (iocb->ki_flags & IOCB_DIRECT) {
		/*
		 * Allow a directio write to fall back to a buffered
		 * write *only* in the case that we're doing a reflink
		 * CoW.  In all other directio scenarios we do not
		 * allow an operation to fall back to buffered mode.
		 */
		ret = xfs_file_dio_write(iocb, from);
		if (ret != -ENOTBLK)
			return ret;
	}

	return xfs_file_buffered_write(iocb, from);

Or is the problem here that generic_file_read_iter will trip over it?
Oh, haha, yes it will.

Maybe we should call filemap_read directly then?  But I guess this
(clearing IOCB_DIRECT) is fine the way it is.

--D

> -- 
> - Andrey
> 
> 

