Return-Path: <linux-fsdevel+bounces-30299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26298988DDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 06:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9319B20E6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 04:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C71B19AA41;
	Sat, 28 Sep 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUOypE8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280419A28B;
	Sat, 28 Sep 2024 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727498640; cv=none; b=Gb6j96wP37vYelFtX+b7buVXiBC1GEwNRWqx9WT5Ay9c1ZgM9eY4KEh1OH1lLTZ41injxh6bjn0U5Qoas7BCeXrIbY/rKR7kRxwtwiK7gjeEH0CJarHR65FZvI2h2qlCAQqrt7ARZhkwP0ibB9RWGtiPO71T5DRXOHLUSLUHCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727498640; c=relaxed/simple;
	bh=Ugeo2BHOgYL84BLxp7+mymmTqHWfdd2WfTZ5oSkFj9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcHJTf4aHXihoYRkM9qWhAHrxqZvs5rAMixJ6zNrc5aeGZemNl8R80nfjBQVjstWD5/UsBUL0zMlVeMsJSQYltXPBYrIc6FQvIYhVWDs/bZaZane5HOMo+67YVeaeJnXkYGSi7UnjtOX5xGHEhLT0E5CkqhsvJnNZYd0uFxEOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUOypE8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63642C4CEC3;
	Sat, 28 Sep 2024 04:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727498639;
	bh=Ugeo2BHOgYL84BLxp7+mymmTqHWfdd2WfTZ5oSkFj9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUOypE8AlqU78PSDrPL/0b9pXc3RNbPDUghcJYzwSVchLcxNxIUrwyqi6OXdnHSIZ
	 bL3AsiNzF9E0oA2B2dpWGKDRIPZ28Xy0HeaGeApfNNmdd3RCY6zvEVIQbXvJLWYC7v
	 AfiNGL3WzBgZN2MqiedRCePPbMVo079xyIJvpFY5vtMp8s1gJs4AQ7LxC+ynDYLyot
	 alSvtuDIE6WMaRBWSV2CCfwjbqZ71o2FONw2Sq2FNyGtJqD7qnR0pHPiGIJ9HvCoWr
	 HNOjEuTEcB27I9WIdaOMk1DtBROckRrXWMEh2j1pzP7CI/RBcLIlVBf5XvOCvZd+xA
	 0HVtotdX3JR+w==
Date: Fri, 27 Sep 2024 21:43:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hch@lst.de, syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com,
	Dave Chinner <david@fromorbit.com>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] xfs: do not unshare any blocks beyond eof
Message-ID: <20240928044358.GV21877@frogsfrogsfrogs>
References: <20240927065344.2628691-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927065344.2628691-1-sunjunchao2870@gmail.com>

[cc linux-xfs]

On Fri, Sep 27, 2024 at 02:53:44PM +0800, Julian Sun wrote:
> Attempting to unshare extents beyond EOF will trigger
> the need zeroing case, which in turn triggers a warning.
> Therefore, let's skip the unshare process if blocks are
> beyond EOF.
> 
> This patch passed the xfstests using './check -g quick', without
> causing any additional failure
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/xfs/xfs_iomap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 72c981e3dc92..81a0514b8652 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -976,6 +976,7 @@ xfs_buffered_write_iomap_begin(

I'm unsure about why this correction is in
xfs_buffered_write_iomap_begin.  If extent size hints are enabled, this
function delegates to xfs_direct_write_iomap_begin, which means that
this isn't a complete fix.

Shouldn't it suffice to clamp offset/len in xfs_reflink_unshare?

--D

>  	int			error = 0;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
>  	u64			seq;
> +	xfs_fileoff_t eof_fsb;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1016,6 +1017,13 @@ xfs_buffered_write_iomap_begin(
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
>  
> +	/* Don't try to unshare any blocks beyond EOF. */
> +	eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +	if (flags & IOMAP_UNSHARE && end_fsb > eof_fsb) {
> +		xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
> +		end_fsb = eof_fsb;
> +	}
> +
>  	/* We never need to allocate blocks for zeroing or unsharing a hole. */
>  	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
>  	    imap.br_startoff > offset_fsb) {
> @@ -1030,7 +1038,6 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
>  	    isnullstartblock(imap.br_startblock)) {
> -		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
>  
>  		if (offset_fsb >= eof_fsb)
>  			goto convert_delay;
> -- 
> 2.39.2
> 

