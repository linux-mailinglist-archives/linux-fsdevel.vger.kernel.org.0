Return-Path: <linux-fsdevel+bounces-29605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C172C97B538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ADC284A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1B193062;
	Tue, 17 Sep 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Feq9E+mP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C051925A3;
	Tue, 17 Sep 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608576; cv=none; b=WNV9EO7rt6XBYHw2u+BCjEciQFA8bMnEQBZYIQ3lXdBRPEDRGLWRYmSJFXCqejTWFzl+6iVI7YgRvOJx8TMCB+uo7Y4xf1Iv6k/fzT6cUpxA/h8EruskoPECyVJaiEGNYIAVTrtRU+1bLA5mXbimHa+RLcTsp0u1tRA0fw3zhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608576; c=relaxed/simple;
	bh=9oizcgefJXn2A/n2URFPYzu03ElkfcxTmK8MQYXe9xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9se3SKI6v3IbtQ6fQeHUy5jqttIa4JnArl1KXSnZdzK6p2Bw9QpMYUwcqy1bfftShNUWtvHvJW6KApO5VKp5VRCte0oWtuf46PqU/V05Nemmv97OegEM8QZpnDIZM20U6wTwM1tu274GbItDzHVhtqFmhL1dDWM+7nZdTWOZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Feq9E+mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F96C4CED0;
	Tue, 17 Sep 2024 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726608576;
	bh=9oizcgefJXn2A/n2URFPYzu03ElkfcxTmK8MQYXe9xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Feq9E+mPeDxpS4TNLYUkIkwwYtDQUwUjOdFadPGugiXapB50tsyzfSGkMNrKsRFp6
	 9ZGqnPHnkcNUF9zBVqi1IDv5AO/pZEUNr2Hys9h0Wtgs/3fJoYTPEMkjhtGYVgf4nh
	 1VMxBL3gQ2q4QtmrVhj5/lJtgEMcVv2xjtU6qU20AN6/WmsjC5E8YfV+x6MtvN8tVM
	 yj+6G6ata86sw5umXDNwUlR4FoLddeb2yH45B/oenxPcAzWPLRhMLdn9CdsnxxZScC
	 M20WbgK0v6Uq2Qsd6gsopeeo970yIEq1Xvm/FEjSf44CE6aXIh9l3JeKD2oWhkJ+Ri
	 di+kFyUnQoCZw==
Date: Tue, 17 Sep 2024 14:29:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] iomap: zeroing already holds invalidate_lock
Message-ID: <20240917212935.GE182177@frogsfrogsfrogs>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910043949.3481298-9-hch@lst.de>

On Tue, Sep 10, 2024 at 07:39:10AM +0300, Christoph Hellwig wrote:
> All callers of iomap_zero_range already hold invalidate_lock, so we can't
> take it again in iomap_file_buffered_write_punch_delalloc.
> 
> Use the passed in flags argument to detect if we're called from a zeroing
> operation and don't take the lock again in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 52f285ae4bddcb..3d7e69a542518a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1188,8 +1188,13 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  	 * folios and dirtying them via ->page_mkwrite whilst we walk the
>  	 * cache and perform delalloc extent removal. Failing to do this can
>  	 * leave dirty pages with no space reservation in the cache.
> +	 *
> +	 * For zeroing operations the callers already hold invalidate_lock.
>  	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> +	if (flags & IOMAP_ZERO)
> +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);

Does the other iomap_zero_range user (gfs2) take the invalidate lock?
AFAICT it doesn't.  Shouldn't we annotate iomap_zero_range to say that
callers have to hold i_rwsem and the invalidate_lock?

--D

> +	else
> +		filemap_invalidate_lock(inode->i_mapping);
>  	while (start_byte < scan_end_byte) {
>  		loff_t		data_end;
>  
> @@ -1240,7 +1245,8 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		punch(inode, punch_start_byte, end_byte - punch_start_byte,
>  				iomap);
>  out_unlock:
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	if (!(flags & IOMAP_ZERO))
> +		filemap_invalidate_unlock(inode->i_mapping);
>  }
>  
>  /*
> -- 
> 2.45.2
> 
> 

