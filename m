Return-Path: <linux-fsdevel+bounces-27412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D28961435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C8A1C23311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD91CDFC4;
	Tue, 27 Aug 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyTZWfDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0B54767;
	Tue, 27 Aug 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776737; cv=none; b=YlXTRsauSwVWCibcZXWUDtOOM2fvTsEsLtQCsgvcmUXo5mlgBwSZgJTcHSV+nyRf8XawoY6v9c08gjjdKHWuoQJLnWBDiEPyPG4taMsgzukz0gEv4yAfyNAynXs6fJDKCFUtuMBXizewmz7GD2j42rR1rPFJcyDqiv7e4mpyOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776737; c=relaxed/simple;
	bh=4BgrvTiyAvVY/mr4WiAPphx+VLnfc/W2cDsr1zDg9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZyLocTweU09TePs7WAGQ5hCCB9LKSyY8Vbngofaf+djnllfgq4yTVxQ0BDRCPmK9wTTMy9r97ghuhp03qqxVUd9AqWCyrBPqHyd4xMbI8R/gZ5Oh0d6z5jePhMlY7L+uam7PoWk+IogXh3OGXJR3qIwSp3w28Xf9phonS+2CR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyTZWfDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B712CC4AF09;
	Tue, 27 Aug 2024 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776736;
	bh=4BgrvTiyAvVY/mr4WiAPphx+VLnfc/W2cDsr1zDg9RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyTZWfDSI6ihRmAGQbQVAZOIsagLzqPjcbQIRK1774LL2akA1RZC1DjP55EuyNH4y
	 hyNjf+MFcIADy4OakxZ2BJs6TiGD2pwDwaOFHuqoHMOaGjFBePPmpmj0VEaOptzk9X
	 /9DVDl2IzETX96EhC9StnoXnRKHJryhMvu01tbEdvn74SnDYitW9rxhTrlYF1u+lyb
	 T+s4ql4SEjIriuIeSl96xHK9eTE5zMqOhOUb0hvhHGPMRIOVtCydc6z+FoEPEmg2n2
	 /1C4D1ybrCbeYJk8+bzgHuHdcM26giQuObDylxOn87iZLyWmTzurJ+vBrAaNG5z7hZ
	 tv/PPOiifZStg==
Date: Tue, 27 Aug 2024 09:38:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] xfs: share a bit more code in
 xfs_buffered_write_iomap_begin
Message-ID: <20240827163856.GC865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-9-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:55AM +0200, Christoph Hellwig wrote:
> Introduce a local iomap_flags variable so that the code allocating new
> delalloc blocks in the data fork can fall through to the found_imap
> label and reuse the code to unlock and fill the iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That looks pretty straightforward
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 24d69c8c168aeb..e0dc6393686c01 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -975,6 +975,7 @@ xfs_buffered_write_iomap_begin(
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
> +	unsigned int		iomap_flags = 0;
>  	u64			seq;
>  
>  	if (xfs_is_shutdown(mp))
> @@ -1145,6 +1146,11 @@ xfs_buffered_write_iomap_begin(
>  		}
>  	}
>  
> +	/*
> +	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
> +	 * them out if the write happens to fail.
> +	 */
> +	iomap_flags |= IOMAP_F_NEW;
>  	if (allocfork == XFS_COW_FORK) {
>  		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
>  				end_fsb - offset_fsb, prealloc_blocks, &cmap,
> @@ -1162,19 +1168,11 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> -	/*
> -	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
> -	 * them out if the write happens to fail.
> -	 */
> -	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
> -	xfs_iunlock(ip, lockmode);
>  	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
> -
>  found_imap:
> -	seq = xfs_iomap_inode_sequence(ip, 0);
> +	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
>  	xfs_iunlock(ip, lockmode);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
>  
>  convert_delay:
>  	xfs_iunlock(ip, lockmode);
> -- 
> 2.43.0
> 
> 

