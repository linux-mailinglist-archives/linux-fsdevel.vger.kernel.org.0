Return-Path: <linux-fsdevel+bounces-35711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4409D76D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D201641EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15927DA6F;
	Sun, 24 Nov 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTN6jRi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9191CD2C;
	Sun, 24 Nov 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470278; cv=none; b=mDEaReLV1flyQEjIbwHCL4xcgc64YckAJx1OQ13/cmFR0/jFy6EsLhBJNeb+xSSREcSCUrvNr1fah5Vk6Y1Gts/eIH6nx6ZuUiueglpoFCOXFaeP+0NqL2BCZ8BDPm/EvvD08XOGDduzTTPsQ4suoL/47m7W3xBLAHeuFh5C9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470278; c=relaxed/simple;
	bh=fercOjFNHDcJrQshc2SZmcawxZCMd4Jne3ttXXPpezo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiszYwMlNVmyq1lWZwWunXx5fvFjx67o/4pbWi+Nd+afNUXSma/MPJIGt2O8b7NXpwWPiRg3BVUNm+AmGIJcsYSLcwNOBqjIxalyUY+P5bn9g5rNCxzRdMZRNUEntNrwla94shl70NJvdltYMRrkpB1Q9SjsQiYmOEs+5SZWD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTN6jRi3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB49C4CECC;
	Sun, 24 Nov 2024 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732470277;
	bh=fercOjFNHDcJrQshc2SZmcawxZCMd4Jne3ttXXPpezo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTN6jRi3NyNQaXDU0bEwP9WcuUsYY+0bEDv1yCs40HX3N530rRLPBr4oW44efwemd
	 8YiZhFgTv6HbcMC6NwaCGiRct9QmLqt0XW2xZJuo7Ic9Gw8183KnDTOOvhwNax3SQo
	 ogm90f3mhxpmulW5wGDANe9113QAPrPMUn6UNMEODGbhLPrL5jin6N3J2aoABATtIM
	 0+AqqGsoUWp9BeA4MPtEv2A6yS96Ov+PNXVOaPZQNiRIZrAMMHoebhyYEg/El6DxXX
	 YcietdPSwZwLbBSa9aKA4+PCY1c1l3tMu7WCLc+In8XVX7KTDBtSXqKA5R8OTRSRvQ
	 uDItzgpnk9C3A==
Date: Sun, 24 Nov 2024 09:44:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Subject: Re: [PATCH v4] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <20241124174435.GB620578@frogsfrogsfrogs>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>

On Sun, Nov 24, 2024 at 05:42:53PM +0800, Hao-ran Zheng wrote:
> A data race may occur when the function `inode_set_ctime_to_ts()` and
> the function `inode_get_ctime_sec()` are executed concurrently. When
> two threads call `aio_read` and `aio_write` respectively, they will
> be distributed to the read and write functions of the corresponding
> file system respectively. Taking the btrfs file system as an example,
> the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
> finally called. These two functions created a data race when they
> finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
> The specific call stack that appears during testing is as follows:
> 
> ============DATA_RACE============
> btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
> btrfs_update_inode+0x45e/0xbb0 [btrfs]
> btrfs_dirty_inode+0x2b8/0x530 [btrfs]
> btrfs_update_time+0x1ad/0x230 [btrfs]
> touch_atime+0x211/0x440
> filemap_read+0x90f/0xa20
> btrfs_file_read_iter+0xeb/0x580 [btrfs]
> aio_read+0x275/0x3a0
> io_submit_one+0xd22/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ============OTHER_INFO============
> btrfs_write_check+0xa15/0x1390 [btrfs]
> btrfs_buffered_write+0x52f/0x29d0 [btrfs]
> btrfs_do_write_iter+0x53d/0x1590 [btrfs]
> btrfs_file_write_iter+0x41/0x60 [btrfs]
> aio_write+0x41e/0x5f0
> io_submit_one+0xd42/0x1ce0
> __se_sys_io_submit+0xb3/0x250
> do_syscall_64+0xc1/0x190
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> To address this issue, it is recommended to add WRITE_ONCE
> and READ_ONCE when reading or writing the `inode->i_ctime_sec`
> and `inode->i_ctime_nsec` variable.

Excuse my ignorance, but how exactly does this annotation fix the race?
Does it prevent reordering of the memory accesses or something?  "it is
recommended" is not enough for dunces such as myself to figure out why
this fixes the problem. :(

--D

> Signed-off-by: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>
> ---
> V3 -> V4: Fixed patch for latest code
> V2 -> V3: Added READ_ONCE in inode_get_ctime_nsec() and addressed review comments
> V1 -> V2: Added READ_ONCE in inode_get_ctime_sec()
> ---
>  fs/inode.c | 16 ++++++++--------
>  fs/stat.c  |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index b13b778257ae..bfab370c8622 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2713,8 +2713,8 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
>  {
>  	trace_inode_set_ctime_to_ts(inode, &ts);
>  	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
> -	inode->i_ctime_sec = ts.tv_sec;
> -	inode->i_ctime_nsec = ts.tv_nsec;
> +	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
> +	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
>  	return ts;
>  }
>  EXPORT_SYMBOL(inode_set_ctime_to_ts);
> @@ -2788,7 +2788,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  	 */
>  	cns = smp_load_acquire(&inode->i_ctime_nsec);
>  	if (cns & I_CTIME_QUERIED) {
> -		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
> +		struct timespec64 ctime = { .tv_sec = READ_ONCE(inode->i_ctime_sec),
>  					    .tv_nsec = cns & ~I_CTIME_QUERIED };
>  
>  		if (timespec64_compare(&now, &ctime) <= 0) {
> @@ -2809,7 +2809,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  	/* Try to swap the nsec value into place. */
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
>  		/* If swap occurred, then we're (mostly) done */
> -		inode->i_ctime_sec = now.tv_sec;
> +		WRITE_ONCE(inode->i_ctime_sec, now.tv_sec);
>  		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
>  		mgtime_counter_inc(mg_ctime_swaps);
>  	} else {
> @@ -2824,7 +2824,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  			goto retry;
>  		}
>  		/* Otherwise, keep the existing ctime */
> -		now.tv_sec = inode->i_ctime_sec;
> +		now.tv_sec = READ_ONCE(inode->i_ctime_sec);
>  		now.tv_nsec = cur & ~I_CTIME_QUERIED;
>  	}
>  out:
> @@ -2857,7 +2857,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
>  	/* pairs with try_cmpxchg below */
>  	cur = smp_load_acquire(&inode->i_ctime_nsec);
>  	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> -	cur_ts.tv_sec = inode->i_ctime_sec;
> +	cur_ts.tv_sec = READ_ONCE(inode->i_ctime_sec);
>  
>  	/* If the update is older than the existing value, skip it. */
>  	if (timespec64_compare(&update, &cur_ts) <= 0)
> @@ -2883,7 +2883,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
>  retry:
>  	old = cur;
>  	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
> -		inode->i_ctime_sec = update.tv_sec;
> +		WRITE_ONCE(inode->i_ctime_sec, update.tv_sec);
>  		mgtime_counter_inc(mg_ctime_swaps);
>  		return update;
>  	}
> @@ -2899,7 +2899,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
>  		goto retry;
>  
>  	/* Otherwise, it was a new timestamp. */
> -	cur_ts.tv_sec = inode->i_ctime_sec;
> +	cur_ts.tv_sec = READ_ONCE(inode->i_ctime_sec);
>  	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
>  	return cur_ts;
>  }
> diff --git a/fs/stat.c b/fs/stat.c
> index 0870e969a8a0..e39c78cd62f3 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -53,7 +53,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
>  	}
>  
>  	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime.tv_sec = inode->i_ctime_sec;
> +	stat->ctime.tv_sec = READ_ONCE(inode->i_ctime_sec);
>  	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
>  	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
>  		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
> -- 
> 2.34.1
> 
> 

