Return-Path: <linux-fsdevel+bounces-27379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80103960F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F621F246EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB31CDA0E;
	Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwN6BOjT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717951C4601;
	Tue, 27 Aug 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770559; cv=none; b=CoHVBdZpHIggciTsOWGm/JeooFcFRlrl+sM9ryYJjHnQlkRQ3TL5T+r+9UiMdvlqGBCEZD7wvuMusHh+MK35JNUvQTdZea+BFikT4iW8G6bGks5ZVUUSBbO/nOhfLWSPLnkK9vZ7/62uetA/pkoogA9v3kpc9sI6OQlPA7+J+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770559; c=relaxed/simple;
	bh=b5GtFrJGQS5jW6k7u3z9DCJgRbL8Vj68G83vjLoQK2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y20be0rfhGNfTVF000rAALYZS8LSsjTdOjaN62SXqCW5cCvHOqZKMdMKzGeYIQUut25+qBkOArvDT5ub2vX/ydDQK/Mna3jiv+/NMsXZyHGg2lpUkXu5PU88qRQR/JLP5c6LHr5FKXDxE/hOnR0GXqfTWwGcyWj8Pyq08pz7b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwN6BOjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D027C4E699;
	Tue, 27 Aug 2024 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770559;
	bh=b5GtFrJGQS5jW6k7u3z9DCJgRbL8Vj68G83vjLoQK2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwN6BOjTX31eIxtGeUolAwPKV5PdGsT+tRA5mgzyKbd2fWbaPEd0hhMQuXj4dDuHE
	 zYQ9dNkeDdAGVp7IeJJHUm6iprQtcjLHVTAcvTKyglPSXIhh6GdbvSFj7c3lB6RxvI
	 PEQZoO9foIiifW1HcGnqju5grBWOICvmqo7UrRrg66GfyYZSqkYoEhIXB1YHwd1854
	 476Heq7WFMfode5Qr5d8ZS6VMI6if+OnZOqiDR86gKp0wYsRNxf+QhTTz6/BIwziSC
	 T61hX4DAUopnyqLZCnDd8Gj7zlpedZDkfasNvjYzCByVbWtNAYM760kKVyajuJ/pE1
	 1a4T7wqrS6POw==
Date: Tue, 27 Aug 2024 07:55:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
Message-ID: <20240827145558.GQ865349@frogsfrogsfrogs>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-2-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:45AM +0200, Christoph Hellwig wrote:
> While the FALLOC_FL_NO_HIDE_STALE value has been registered, it has
> always been rejected by vfs_fallocate before making it into
> blkdev_fallocate because it isn't in the supported mask.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, I guess that never worked.  Oh well.  BLKDISCARD it is.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  block/fops.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 9825c1713a49a9..7f48f03a62e9a8 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -771,7 +771,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  #define	BLKDEV_FALLOC_FL_SUPPORTED					\
>  		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
> -		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> +		 FALLOC_FL_ZERO_RANGE)
>  
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
> @@ -830,14 +830,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL,
>  					     BLKDEV_ZERO_NOFALLBACK);
>  		break;
> -	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
> -		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
> -		if (error)
> -			goto fail;
> -
> -		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					     len >> SECTOR_SHIFT, GFP_KERNEL);
> -		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  	}
> -- 
> 2.43.0
> 
> 

