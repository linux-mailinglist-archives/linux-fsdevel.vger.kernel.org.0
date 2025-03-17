Return-Path: <linux-fsdevel+bounces-44166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677DA64104
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A5F7A75C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3D21A425;
	Mon, 17 Mar 2025 06:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B1219A70;
	Mon, 17 Mar 2025 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192130; cv=none; b=Yf1mxProINWXXPsmwFV4sr/KEHz1BQqs17DYXly1AwVIFwhywtgO5amfHPwHWIB4SeUJ+hy217+kU0PLVy6zn04MyD013b64zXXnucY6azu48z8bpjZ4/oTXgPNjvNqdgdD9SFC6BO4plExDpVexCQuCw2Cy/NirztB+bFEZ6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192130; c=relaxed/simple;
	bh=s4r599GrsZAEDwj3X5rQvXvdxQbADoFI1g7gRcr7DFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEEgMCRNxRc/sM8ZBJcCb0z4pr/3WlIfsGzr1bKXwoPJsxOappC6vBIdGMstXcJyaBflHSBfV/MOq1XFU53VaGXxyb3zpr00JoaPRrmD+hLtB08ttJaJWvhvTsGUSAp65QYrJtKOGnpZ1kXJL4mnin8yDhMCwmdERJEqBSWUwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0C7268AFE; Mon, 17 Mar 2025 07:15:23 +0100 (CET)
Date: Mon, 17 Mar 2025 07:15:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 04/13] xfs: pass flags to xfs_reflink_allocate_cow()
Message-ID: <20250317061523.GD27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-5-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 05:13:01PM +0000, John Garry wrote:
> @@ -823,6 +824,9 @@ xfs_direct_write_iomap_begin(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> +	if (flags & IOMAP_DIRECT || IS_DAX(inode))
> +		reflink_flags |= XFS_REFLINK_CONVERT_UNWRITTEN;

Given that this is where the policy is implemented now, this comment:

	/*
	 * COW fork extents are supposed to remain unwritten until we're ready
         * to initiate a disk write.  For direct I/O we are going to write the
	 * data and need the conversion, but for buffered writes we're done.
         */        

from xfs_reflink_convert_unwritten should probably move here now.

> -	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
> +	return xfs_reflink_convert_unwritten(ip, imap, cmap,
> +			flags & XFS_REFLINK_CONVERT_UNWRITTEN);

I'd probably thread the flags argument all the way through
xfs_reflink_convert_unwritten as that documents the intent better.

> +/*
> + * Flags for xfs_reflink_allocate_cow() and callees
> + */

And the full sentence with a .?


