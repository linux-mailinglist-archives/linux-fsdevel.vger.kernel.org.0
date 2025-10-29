Return-Path: <linux-fsdevel+bounces-66336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A835BC1C33C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47A2E589283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223EB354AC8;
	Wed, 29 Oct 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elq99ej+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78D35470D;
	Wed, 29 Oct 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753673; cv=none; b=TVoSfyP4Lfy1MQ0wCxqSY73W/UBvPfoBxgSmvYeEx4A31twib38ag7uvUp1Em7sbv2SlFrngq/iEixZtycX9DqxXjJdeEphq0Suc+Itjs96oXm+hoRWLjwKi2qBogkUy39/Nac5NB52X1B4EVAldHn6WwkNWn8Lb/1aqU3tgVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753673; c=relaxed/simple;
	bh=3vuvuxbp2D3rSBsSe0LIAeWtEdZFTpQ44jA3h2ArYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni2WGkaQUtyHKF3CxriPPTZEdjWbRtOueHg7swx69AvbK3YAHhlDj2Rs+4dK15qQWW6yn0LXCyUzlOJt13dRXNz+u6zDZLuS/kOHYV5+oEryYbtD6nGI/JE+kQCQ8DIScUgTEcqzwhalNJo4D+ff4KyedKYD12PVG7Vvm997r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elq99ej+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0CAC4CEF7;
	Wed, 29 Oct 2025 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753673;
	bh=3vuvuxbp2D3rSBsSe0LIAeWtEdZFTpQ44jA3h2ArYZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elq99ej+LrJrNzw+yNeRp9JwUpl9kOKeYZdOHyS4MCk+1ApYNm3v0nmcNABe0P1Je
	 hgISnmXUt5RsUAJdGnpWMCVPVKeP8SjDLgogM6InzUMx9udIoPoLRTBBiuLHQcSj4/
	 hh4mP2hY7LniKki/cnmMy8pc+9Jl6g2XB3YCFNSBWrFBRGeKbvH9Glu/8N9ONVb6/Q
	 yky4SIkV15hgCX/00m7g3PleET0IsRzELoOrWC1YIBf+CrCCuGUn9E7D0o1YMD0X1B
	 F0JGUQMUqqnxOFVKPz2uZjJ31rbQzvTn+FS6+/8XV77C+h0r8ZIkfgBA4UyEAYPq5Z
	 vkPjSCxwa+YoQ==
Date: Wed, 29 Oct 2025 09:01:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] fs: replace FOP_DIO_PARALLEL_WRITE with a fmode bits
Message-ID: <20251029160112.GF3356773@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029071537.1127397-2-hch@lst.de>

On Wed, Oct 29, 2025 at 08:15:02AM +0100, Christoph Hellwig wrote:
> To properly handle the direct to buffered I/O fallback for devices that
> require stable writes, we need to be able to set the DIO_PARALLEL_WRITE
> on a per-file basis and no statically for a given file_operations
> instance.
> 
> This effectively reverts a part of 210a03c9d51a ("fs: claw back a few
> FMODE_* bits").
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/file.c      | 2 +-
>  fs/xfs/xfs_file.c   | 4 ++--
>  include/linux/fs.h  | 7 ++-----
>  io_uring/io_uring.c | 2 +-
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..b484e98b9c78 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -924,6 +924,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
>  		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  
>  	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	filp->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>  	return dquot_file_open(inode, filp);
>  }
>  
> @@ -978,7 +979,6 @@ const struct file_operations ext4_file_operations = {
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= ext4_fallocate,
>  	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
> -			  FOP_DIO_PARALLEL_WRITE |
>  			  FOP_DONTCACHE,
>  };
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 2702fef2c90c..5703b6681b1d 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1553,6 +1553,7 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	file->f_mode |= FMODE_DIO_PARALLEL_WRITE;
>  	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
>  		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
> @@ -1951,8 +1952,7 @@ const struct file_operations xfs_file_operations = {
>  	.fadvise	= xfs_file_fadvise,
>  	.remap_file_range = xfs_file_remap_range,
>  	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
> -			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
> -			  FOP_DONTCACHE,
> +			  FOP_BUFFER_WASYNC | FOP_DONTCACHE,
>  };
>  
>  const struct file_operations xfs_dir_file_operations = {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..09b47effc55e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -128,9 +128,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define FMODE_WRITE_RESTRICTED	((__force fmode_t)(1 << 6))
>  /* File supports atomic writes */
>  #define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)(1 << 7))
> -
> -/* FMODE_* bit 8 */
> -
> +/* Supports non-exclusive O_DIRECT writes from multiple threads */
> +#define FMODE_DIO_PARALLEL_WRITE ((__force fmode_t)(1 << 8))
>  /* 32bit hashes as llseek() offset (for directories) */
>  #define FMODE_32BITHASH         ((__force fmode_t)(1 << 9))
>  /* 64bit hashes as llseek() offset (for directories) */
> @@ -2317,8 +2316,6 @@ struct file_operations {
>  #define FOP_BUFFER_WASYNC	((__force fop_flags_t)(1 << 1))
>  /* Supports synchronous page faults for mappings */
>  #define FOP_MMAP_SYNC		((__force fop_flags_t)(1 << 2))
> -/* Supports non-exclusive O_DIRECT writes from multiple threads */
> -#define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
>  /* Contains huge pages */
>  #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
>  /* Treat loff_t as unsigned (e.g., /dev/mem) */
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 296667ba712c..668937da27e8 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -469,7 +469,7 @@ static void io_prep_async_work(struct io_kiocb *req)
>  
>  		/* don't serialize this request if the fs doesn't need it */
>  		if (should_hash && (req->file->f_flags & O_DIRECT) &&
> -		    (req->file->f_op->fop_flags & FOP_DIO_PARALLEL_WRITE))
> +		    (req->file->f_mode & FMODE_DIO_PARALLEL_WRITE))
>  			should_hash = false;
>  		if (should_hash || (ctx->flags & IORING_SETUP_IOPOLL))
>  			io_wq_hash_work(&req->work, file_inode(req->file));
> -- 
> 2.47.3
> 
> 

