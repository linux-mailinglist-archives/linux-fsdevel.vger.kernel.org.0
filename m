Return-Path: <linux-fsdevel+bounces-44172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A1A641EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93613AC328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8EA219A8D;
	Mon, 17 Mar 2025 06:41:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF17219A94;
	Mon, 17 Mar 2025 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193677; cv=none; b=O4p9yTnMYNP7DusIkl6gpgUWY2+VUPHUvDL6h9mujSB0scbus/Q18pb0aP0QJC8diIb5D7pfVmOPOvx+PVwrOdxt/4OUdeC2ssOinrKSTCzNmsxKRsWECHcHWCWGnQZO7MLDFRnEtnVRTF0JYJM+Cfu3EIUbDvh7MWzA8owqy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193677; c=relaxed/simple;
	bh=UzNG0vduuTIJXJO0fevzcrUf3hXDEWG7g+A54iZTIAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSm2IeHoPyQdv8wTcWI4kjUtRimjcBhjK4dd6rmnvm0rHobaimiUv5SfOqfWC7a06B3Tb6QsXNFox0nWuobdNDW6hlGuiR0b5nuSPSAKhdyLWNHQ2l+yhaP6EhYlO435KKAzyXk4UYeTkv3YPpKAq6baguofKkSJDiv/AgAIs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46E9C68AFE; Mon, 17 Mar 2025 07:41:09 +0100 (CET)
Date: Mon, 17 Mar 2025 07:41:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250317064109.GA27621@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-12-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 05:13:08PM +0000, John Garry wrote:
> + * REQ_ATOMIC-based is the preferred method, and is attempted first. If this
> + * method fails due to REQ_ATOMIC-related constraints, then we retry with the
> + * COW-based method. The REQ_ATOMIC-based method typically will fail if the
> + * write spans multiple extents or the disk blocks are misaligned.

It is only preferred if actually supported by the underlying hardware.
If it isn't it really shouldn't even be tried, as that is just a waste
of cycles.

Also a lot of comment should probably be near the code not on top
of the function as that's where people would look for them.

> +static noinline ssize_t
> +xfs_file_dio_write_atomic(
> +	struct xfs_inode	*ip,
> +	struct kiocb		*iocb,
> +	struct iov_iter		*from)
> +{
> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
> +	unsigned int		dio_flags = 0;
> +	const struct iomap_ops	*dops = &xfs_direct_write_iomap_ops;
> +	ssize_t			ret;
> +
> +retry:
> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
> +	if (ret)
> +		return ret;
> +
> +	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
> +		inode_dio_wait(VFS_I(ip));
> +
> +	trace_xfs_file_direct_write(iocb, from);
> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
> +			dio_flags, NULL, 0);

The normal direct I/O path downgrades the iolock to shared before
doing the I/O here.  Why isn't that done here?

> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
> +	    dops == &xfs_direct_write_iomap_ops) {

This should probably explain the unusual use of EGAIN.  Although I
still feel that picking a different error code for the fallback would
be much more maintainable.

> +		xfs_iunlock(ip, iolock);
> +		dio_flags = IOMAP_DIO_FORCE_WAIT;

I notice the top of function comment mentions the IOMAP_DIO_FORCE_WAIT
flag.  Maybe use the chance to write a full sentence here or where
it is checked to explain the logic a bit better?

>   * Handle block unaligned direct I/O writes
>   *
> @@ -840,6 +909,10 @@ xfs_file_dio_write(
>  		return xfs_file_dio_write_unaligned(ip, iocb, from);
>  	if (xfs_is_zoned_inode(ip))
>  		return xfs_file_dio_write_zoned(ip, iocb, from);
> +
> +	if (iocb->ki_flags & IOCB_ATOMIC)
> +		return xfs_file_dio_write_atomic(ip, iocb, from);
> +

Either keep space between all the conditional calls or none.  I doubt
just stick to the existing style.


