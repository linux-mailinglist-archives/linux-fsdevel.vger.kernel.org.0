Return-Path: <linux-fsdevel+bounces-27660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F89634A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AB828674B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0B1AC8A9;
	Wed, 28 Aug 2024 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCeoCepV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6501A76B9;
	Wed, 28 Aug 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883745; cv=none; b=ojsewdcdW5EBFl8seNxQu32G2QitQbZcUGTZ2war+TQBCdDifeyTkdm1Hsyf3jFIQvd666F6RKI0taohTTSY9//+25kX/GeXzssep4FXrldCLsH4tYk858X0YyArA58+l4jxUstrWJQVfuG2vG/w+6hoE0bzAseX3rV+NeB7Nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883745; c=relaxed/simple;
	bh=uaRq3lgyla0tm6OWnaXtSL8VHv25JXRSqRWdpjHtVNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWMCdA58tywfTfs2Oz14YowpRCMjJgzAvVEUW6N1o1UvXtSbslAjNKPPxew9kjDg/jExsXzcr4rbuPpcAb9b0Lk3LPaAQCPbVh1TfDHu+OhI2x5jr8qWWizzUBMTTwOa1pW9zX5VKb53Ir1uhix+l/Dp6w7jHjIYf2wLrr84g7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCeoCepV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7F6C4CEC0;
	Wed, 28 Aug 2024 22:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724883743;
	bh=uaRq3lgyla0tm6OWnaXtSL8VHv25JXRSqRWdpjHtVNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCeoCepV0gG4cuOVF3ks5Bp5aeJVeAasvq4W39MZU3wY3Ey+v+JM9cE3OIHmhhXAZ
	 7Ce3oBXIfZbJtqP1KkjoaQWkldvMtMFQKXaIaItKWsWTmryqMof+LVNpHiMCQ9/yzc
	 8m8bGAThpRfeLap6i1uqTTLwdmaVkSKYbYV9rfSRYqqvlCNapEnFSc4mNWTTLejX8M
	 ae6ckGvyYHaoFdt5BlxslBZj4d0Ia/M1logiy3nwxR2lZDbrYg9vw4J73zDPwssgTg
	 qbkwV7588hbSGth3gaOcG7HRe4OB6ws/CyIAVowC0U/hUCuLPUN/eH/RfXE4K+XRtz
	 MtuJTrfrKZHhA==
Date: Wed, 28 Aug 2024 15:22:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH v2 1/2] iomap: fix handling of dirty folios over
 unwritten extents
Message-ID: <20240828222222.GB6224@frogsfrogsfrogs>
References: <20240828181912.41517-1-bfoster@redhat.com>
 <20240828181912.41517-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828181912.41517-2-bfoster@redhat.com>

On Wed, Aug 28, 2024 at 02:19:10PM -0400, Brian Foster wrote:
> The iomap zero range implementation doesn't properly handle dirty
> pagecache over unwritten mappings. It skips such mappings as if they
> were pre-zeroed. If some part of an unwritten mapping is dirty in
> pagecache from a previous write, the data in cache should be zeroed
> as well. Instead, the data is left in cache and creates a stale data
> exposure problem if writeback occurs sometime after the zero range.
> 
> Most callers are unaffected by this because the higher level
> filesystem contexts that call zero range typically perform a filemap
> flush of the target range for other reasons. A couple contexts that
> don't otherwise need to flush are write file size extension and
> truncate in XFS. The former path is currently susceptible to the
> stale data exposure problem and the latter performs a flush
> specifically to work around it.
> 
> This is clearly inconsistent and incomplete. As a first step toward
> correcting behavior, lift the XFS workaround to iomap_zero_range()
> and unconditionally flush the range before the zero range operation
> proceeds. While this appears to be a bit of a big hammer, most all
> users already do this from calling context save for the couple of
> exceptions noted above. Future patches will optimize or elide this
> flush while maintaining functional correctness.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Brian Foster <bfoster@redhat.com>

I wonder why gfs2 (aka the other iomap_zero_range user) doesn't have a
truncate-down flush hammer, but maybe it doesn't support unwritten
extents?  I didn't find anything obvious when I looked, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

(but you might want to see if Andreas has any loud objections to this)

--D

> ---
>  fs/iomap/buffered-io.c | 10 ++++++++++
>  fs/xfs/xfs_iops.c      | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f420c53d86ac..3e846f43ff48 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1451,6 +1451,16 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	};
>  	int ret;
>  
> +	/*
> +	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
> +	 * pagecache must be flushed to ensure stale data from previous
> +	 * buffered writes is not exposed.
> +	 */
> +	ret = filemap_write_and_wait_range(inode->i_mapping,
> +			pos, pos + len - 1);
> +	if (ret)
> +		return ret;
> +
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_zero_iter(&iter, did_zero);
>  	return ret;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1cdc8034f54d..ddd3697e6ecd 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -870,16 +870,6 @@ xfs_setattr_size(
>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>  				&did_zeroing);
>  	} else {
> -		/*
> -		 * iomap won't detect a dirty page over an unwritten block (or a
> -		 * cow block over a hole) and subsequently skips zeroing the
> -		 * newly post-EOF portion of the page. Flush the new EOF to
> -		 * convert the block before the pagecache truncate.
> -		 */
> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> -						     newsize);
> -		if (error)
> -			return error;
>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
> -- 
> 2.45.0
> 
> 

