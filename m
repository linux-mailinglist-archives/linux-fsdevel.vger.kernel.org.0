Return-Path: <linux-fsdevel+bounces-73845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2ED21ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24442301D5C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01A38B995;
	Wed, 14 Jan 2026 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpnB9AoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EE361674;
	Wed, 14 Jan 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431355; cv=none; b=hMDvdnFUemqEUXsrNcZpM2hBa0IQf7V7lZJGSsqgDt6s5GNo2ArMy5lvFM8amAJyKKcUeFvHIoGanow2Radujxy+MI9JEL+eKkHsXPaQrBK0vhrhNAFFeX/Rj8ZqjNz8z0pDbyY8SyySdgmWp7BBdg4lDO+u/PEeUUkOXBMtzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431355; c=relaxed/simple;
	bh=UGJPLNxSVZiJeAk2BQvFOYSGdLhrd/PBMmQNaNppzQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNCFW6XxZCeb7xI6as62w+zaZzRxiveLPcbUVISy/fVNfhg7inc0uXpLAF+umhW+VJREVDp6RMum7VrV/nzNTD6rHcIzfTyY3DGaYI3rSJ9mLqCgndRTFZe+hZ7rm2aUT2/W314A58sUv95qg9DkY+7hcAEe7RM/gtKdUaBXdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpnB9AoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EA7C4CEF7;
	Wed, 14 Jan 2026 22:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431355;
	bh=UGJPLNxSVZiJeAk2BQvFOYSGdLhrd/PBMmQNaNppzQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpnB9AoSurQ9ei54RQZ2qJsg1XiZwJnaRrAWyyA9FcYdWhF+50BjgPOXnl1ghFZM3
	 t24UcjO/OssWVcRqfRtfVKn0mKiIvDZFd4UxtU+SxmotqVJ3mTVl2spG4sJxUonwOr
	 EPMUWBv9RrLGw4FrvddZ5aBNdQE7UAe58w1lP4B9tmvCHDLeGUtwqUZcMEDmqPdqdk
	 v06MEnrWIFRTIAWiDONypaP7PbOnImpumWZH3U2pOqQv2zlvPbDitOJL63eb8Dq7xq
	 iuGSGlfUIht+xJkBYPIBL3Jo7abQXpW1FFk7FJrqXeaILiMe+EztXcgPG1mDgePgUz
	 WqQYE0WrVJx2w==
Date: Wed, 14 Jan 2026 14:55:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/14] iomap: free the bio before completing the dio
Message-ID: <20260114225554.GO15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-11-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:08AM +0100, Christoph Hellwig wrote:
> There are good arguments for processing the user completions ASAP vs.
> freeing resources ASAP, but freeing the bio first here removes potential
> use after free hazards when checking flags, and will simplify the
> upcoming bounce buffer support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bf59241a090b..6f7036e72b23 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -213,7 +213,13 @@ static void iomap_dio_done(struct iomap_dio *dio)
>  static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
> -	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> +
> +	if (dio->flags & IOMAP_DIO_DIRTY) {
> +		bio_check_pages_dirty(bio);
> +	} else {
> +		bio_release_pages(bio, false);
> +		bio_put(bio);
> +	}

/me wonders if we ought to set bio = NULL to make "thou shalt not touch
bio" here explicit?  Otherwise seems it seems fine to me to make this
change.

--D

>  
>  	if (atomic_dec_and_test(&dio->ref)) {
>  		/*
> @@ -224,13 +230,6 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  			dio->flags &= ~IOMAP_DIO_COMP_WORK;
>  		iomap_dio_done(dio);
>  	}
> -
> -	if (should_dirty) {
> -		bio_check_pages_dirty(bio);
> -	} else {
> -		bio_release_pages(bio, false);
> -		bio_put(bio);
> -	}
>  }
>  
>  void iomap_dio_bio_end_io(struct bio *bio)
> -- 
> 2.47.3
> 
> 

