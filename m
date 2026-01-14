Return-Path: <linux-fsdevel+bounces-73844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B660D21AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2626F3030932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D79357717;
	Wed, 14 Jan 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYaaGFTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F52F546D;
	Wed, 14 Jan 2026 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431246; cv=none; b=POFNnRp0SV6HjqIpjsRcvgITK4z7QPGP14mjcnKeKEPeEaK2fBV8/gVycYl/mksCBUgatMvyIt2O4l0rnfiJH/BzHnNE9+y/B3cffcuMxSYkNdT09s2BTLQqUENkUFqRIOfRCOxw1S+EJr3K4FBgSFEa1GMFhksHwmwD4dhnDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431246; c=relaxed/simple;
	bh=64U1iyAeIYB+2Lt1+F6pPh05YejgAytL/G7aT+A9dYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1ZUrS09rQeTTDBTOMVhwFVFq0Swu+oKW+nBAbyE+AD5FmJx2oicdfsdrkgtibZDyOnaUxGq1K3yfiFCWb230DIQXKjsDpx5XDlpTaCk2UM655O15xy7mhtCom13kQN7nQC+s3QKeTnHrg2Ff7EOWFdrOS6Bw7d7cEiXPybvXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYaaGFTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D8C4CEF7;
	Wed, 14 Jan 2026 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768431246;
	bh=64U1iyAeIYB+2Lt1+F6pPh05YejgAytL/G7aT+A9dYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYaaGFTwgxNrmcIeksB6EueQ1YbTC8nmiAmE85r/+xCrWqgYohJVJR7TuPDdu/kPh
	 zBtHwuRNkZJRwTJPhVLpFdTrmBQhBP1J2JjU65woqRd5Q1hhyAYR1aICYRRKO/St9+
	 BeUkkaLEwY1mRE7ouqaTEG3mAB2PnwhBOQ/rI3LEd0EQHSJnw0G2UMgnyrPwjc4zXN
	 f8jlIrgx5m197rYflTMp0enUOvfUTCCHtKkQwNkJKLe2TT1u31Up581l3GouOw6a5v
	 G1RWFgSoGQ5UIBwh5GFk20uJ8ypx4aR9m/9ZMbUvGeKRTtaSjNgoq/QJ6hyMibW1Zs
	 fahrtsLv2GmHg==
Date: Wed, 14 Jan 2026 14:54:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/14] iomap: share code between iomap_dio_bio_end_io and
 iomap_finish_ioend_direct
Message-ID: <20260114225405.GN15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-10-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:07AM +0100, Christoph Hellwig wrote:
> Refactor the two per-bio completion handlers to share common code using
> a new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 63374ba83b55..bf59241a090b 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -210,16 +210,20 @@ static void iomap_dio_done(struct iomap_dio *dio)
>  	iomap_dio_complete_work(&dio->aio.work);
>  }
>  
> -void iomap_dio_bio_end_io(struct bio *bio)
> +static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
>  	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
>  
> -	if (bio->bi_status)
> -		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
> -
> -	if (atomic_dec_and_test(&dio->ref))
> +	if (atomic_dec_and_test(&dio->ref)) {
> +		/*
> +		 * Avoid another context switch for the completion when already
> +		 * called from the ioend completion workqueue.
> +		 */
> +		if (inline_completion)
> +			dio->flags &= ~IOMAP_DIO_COMP_WORK;
>  		iomap_dio_done(dio);
> +	}
>  
>  	if (should_dirty) {
>  		bio_check_pages_dirty(bio);
> @@ -228,33 +232,25 @@ void iomap_dio_bio_end_io(struct bio *bio)
>  		bio_put(bio);
>  	}
>  }
> +
> +void iomap_dio_bio_end_io(struct bio *bio)
> +{
> +	struct iomap_dio *dio = bio->bi_private;
> +
> +	if (bio->bi_status)
> +		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
> +	__iomap_dio_bio_end_io(bio, false);
> +}
>  EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
>  
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend)
>  {
>  	struct iomap_dio *dio = ioend->io_bio.bi_private;
> -	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
>  	u32 vec_count = ioend->io_bio.bi_vcnt;
>  
>  	if (ioend->io_error)
>  		iomap_dio_set_error(dio, ioend->io_error);
> -
> -	if (atomic_dec_and_test(&dio->ref)) {
> -		/*
> -		 * Try to avoid another context switch for the completion given
> -		 * that we are already called from the ioend completion
> -		 * workqueue.
> -		 */
> -		dio->flags &= ~IOMAP_DIO_COMP_WORK;
> -		iomap_dio_done(dio);
> -	}
> -
> -	if (should_dirty) {
> -		bio_check_pages_dirty(&ioend->io_bio);
> -	} else {
> -		bio_release_pages(&ioend->io_bio, false);
> -		bio_put(&ioend->io_bio);
> -	}
> +	__iomap_dio_bio_end_io(&ioend->io_bio, true);
>  
>  	/*
>  	 * Return the number of bvecs completed as even direct I/O completions
> -- 
> 2.47.3
> 
> 

