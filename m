Return-Path: <linux-fsdevel+bounces-42498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF677A42DE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7FA7A8D70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6F9262804;
	Mon, 24 Feb 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maAiH6VF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEC242928;
	Mon, 24 Feb 2025 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429149; cv=none; b=pb+hx+RaZqBfDgZcp77jixoUNpZVoPEmVkt434+QXHpdE14/mQGEyrpXlr68+8N0hC5DuHFPEAhdSfwUqDHueQUwfnIMliaRBvd/LxnCyUo5DbttdxIaE9IJtiJ9ATiPnDddHQEd4tECQh9M8ZrGFeai/6YakPiIYMqGB4ukeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429149; c=relaxed/simple;
	bh=IgK5DDbUjJI07SiT5NHbpZJflCa2im0htozDqhkJ/u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwn5qBpT9SCu6sHGqkUS8Z0/GYhIexNJ2SRPpXmnT/uCk+TJ/DK0Vda1hi0QDyu6TvYav7gQZlYIUFNX/C1S7V3CzRHuEYKIWi8mNtRomgx8nDD/m2kW9BMBlEoO6C91mcGIW8DyyN8nz9XIOiqBYxRVqp7hiQoY2QEhdqEzp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maAiH6VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE95C4CED6;
	Mon, 24 Feb 2025 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429148;
	bh=IgK5DDbUjJI07SiT5NHbpZJflCa2im0htozDqhkJ/u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maAiH6VFtRxwnXRQ2BkmaV41LwfhdMhJ4jfszviC0E2txLHPBQwfHteEx+073uMTH
	 PJS6zfthEHP8XYIyrEucrAV6XXzPa1BefN/fVhFbHH6junE34QzQMrEAp1luiaE+Rm
	 hMqH5J9qZrHy2Vt9r0BGUaOKM2EPxlJbMnye48L5OKvqdaKKB2lkklSjCBCruPHIqi
	 Df8W9vuLtF0vlP9POXj8RCfSpX1AJPqsPbSGSidp3Dm5gnCD5PbA44BETRXLxwK87T
	 Hh8IGDjiQHr4JbuDfwH81tbQTzebxcqJoP07pXNr/SWXEeFp01xhdB/QekFi3dymkb
	 1zJsLlWgMKSAQ==
Date: Mon, 24 Feb 2025 12:32:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 06/11] xfs: Reflink CoW-based atomic write support
Message-ID: <20250224203228.GI21808@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213135619.1148432-7-john.g.garry@oracle.com>

On Thu, Feb 13, 2025 at 01:56:14PM +0000, John Garry wrote:
> For CoW-based atomic write support, always allocate a cow hole in
> xfs_reflink_allocate_cow() to write the new data.
> 
> The semantics is that if @atomic is set, we will be passed a CoW fork
> extent mapping for no error returned.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iomap.c   |  2 +-
>  fs/xfs/xfs_reflink.c | 12 +++++++-----
>  fs/xfs/xfs_reflink.h |  2 +-
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d61460309a78..ab79f0080288 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>  				&lockmode,
> -				(flags & IOMAP_DIRECT) || IS_DAX(inode));
> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);

Now I'm /really/ think it's time for some reflink allocation flags,
because the function signature now involves two booleans...

>  		if (error)
>  			goto out_unlock;
>  		if (shared)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 8428f7b26ee6..3dab3ba900a3 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
>  	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	uint			*lockmode,
> -	bool			convert_now)
> +	bool			convert_now,
> +	bool			atomic)

...but this can come later.  Also, is atomic==true only for the
ATOMIC_SW operation?  I think so, but that's the unfortunate thing about
booleans.

>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_trans	*tp;
> @@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
>  	*lockmode = XFS_ILOCK_EXCL;
>  
>  	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
> -	if (error || !*shared)
> +	if (error || (!*shared && !atomic))
>  		goto out_trans_cancel;
>  
>  	if (found) {
> @@ -566,7 +567,8 @@ xfs_reflink_allocate_cow(
>  	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	uint			*lockmode,
> -	bool			convert_now)
> +	bool			convert_now,
> +	bool 			atomic)

Nit:        ^ space before tab.

If the answer to the question above is 'yes' then with that nit fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  {
>  	int			error;
>  	bool			found;
> @@ -578,7 +580,7 @@ xfs_reflink_allocate_cow(
>  	}
>  
>  	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
> -	if (error || !*shared)
> +	if (error || (!*shared && !atomic))
>  		return error;
>  
>  	/* CoW fork has a real extent */
> @@ -592,7 +594,7 @@ xfs_reflink_allocate_cow(
>  	 */
>  	if (cmap->br_startoff > imap->br_startoff)
>  		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
> -				lockmode, convert_now);
> +				lockmode, convert_now, atomic);
>  
>  	/*
>  	 * CoW fork has a delalloc reservation. Replace it with a real extent.
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index cc4e92278279..754d2bb692d3 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -32,7 +32,7 @@ int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>  
>  int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>  		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
> -		bool convert_now);
> +		bool convert_now, bool atomic);
>  extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count);
>  
> -- 
> 2.31.1
> 
> 

