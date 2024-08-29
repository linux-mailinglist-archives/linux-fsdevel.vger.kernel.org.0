Return-Path: <linux-fsdevel+bounces-27757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EA963914
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FD1C24973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40C12D766;
	Thu, 29 Aug 2024 03:54:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A547A62;
	Thu, 29 Aug 2024 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903652; cv=none; b=fdQjd+B6e+9nBviqzXnUzgHHWvhMe5/xd9+mbZX1tgoqyqmsIQ7Sd/M1B1OqjbLucny7nn0nacmDx5egpfZy3N0HhJWKIeooJKAJL/kCkhVRKijamREj/nPKrJENBaOltmQXXfWuGsxePUJIMBzlV/yk/cqG4lXLqJZ16ZUWIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903652; c=relaxed/simple;
	bh=qu4NduUQBplLke25mz1v3+IjcMSiAuCcWapGX5opDxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUE28Wa6+Yf52ckPmC6t5lJSRDPXaXB40IaBXJ9SjBnjf2ozvZ3iHne3sEA08rRJcXDES05RksX2xKEse5kaEhb+kBxDpCiTOTOnrvCCZ3GMqhtt25jvuXLWqlr3JwqhVMWa+hYUpVByKWCRWbc0c8OXlG43E0CybS7wPk0m35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0987968AA6; Thu, 29 Aug 2024 05:54:07 +0200 (CEST)
Date: Thu, 29 Aug 2024 05:54:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: call xfs_flush_unmap_range from
 xfs_free_file_space
Message-ID: <20240829035406.GB4023@lst.de>
References: <20240827065123.1762168-1-hch@lst.de> <20240827065123.1762168-5-hch@lst.de> <Zs/lA5FJoF0Zd9Ip@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs/lA5FJoF0Zd9Ip@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 29, 2024 at 01:03:31PM +1000, Dave Chinner wrote:
> > @@ -848,6 +848,14 @@ xfs_free_file_space(
> >  	if (len <= 0)	/* if nothing being freed */
> >  		return 0;
> >  
> > +	/*
> > +	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
> > +	 * the cached range over the first operation we are about to run.
> > +	 */
> > +	error = xfs_flush_unmap_range(ip, offset, len);
> > +	if (error)
> > +		return error;
> > +
> >  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
> >  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
> 
> Ok, so if we ever change the zeroing implementation to not punch a
> hole first, we're going to have to make sure we add this to whatever
> new zeroing implementation we have.
> 
> Can you leave a comment in the FALLOC_FL_ZERO_RANGE implementation
> code that notes it currently relies on the xfs_flush_unmap_range()
> in xfs_free_file_space() for correct operation?

Sure.


