Return-Path: <linux-fsdevel+bounces-74511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2052AD3B4BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65D23301EE0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287038BDA7;
	Mon, 19 Jan 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2DDq3E2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25ED32ED31;
	Mon, 19 Jan 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844629; cv=none; b=tToPHFX9w4gprh29DI8NReEQd5yudzWM1hN6CLArMfqk9bEpKVOfVmu6RAD2ht9iiPzbHmfTnrkAJ8VKmCLo4UGk+XLU64v+DeC0cTYOn2qxaY7MKLyi99nqx/EIcjUbIGneJvnP/fDuELgf9rhE4cJJAzBlLJjZ7SM4BC6qKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844629; c=relaxed/simple;
	bh=d7J1vG6900d7X6UoBLXZqj6Q1ZfHWd3yMebKn+tpc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ongd1h9XZ9dyl1Nu4BFz+4m2jgz1GqDxmKwjTLBe3asFQMVvmG6tORrsLteySfgnzoKNr7q5acawkZtm1nWxmLIkAV6q/K7897Gmndnl4VEKszEH01wLBe2GtXq1oxr3yFHey4tvvjy5q0nMz/wqycQKzT3kroVT6TfWwPiU+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2DDq3E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062DC116C6;
	Mon, 19 Jan 2026 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844628;
	bh=d7J1vG6900d7X6UoBLXZqj6Q1ZfHWd3yMebKn+tpc2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2DDq3E2noPiSegWGDu16tpv+hmqXD8qH6V8yAk435dEWFCd6sTdV6iD1nXKrOAZB
	 db7WQ0R0qPXrCgsO5+h9GZEBfRDOjCW1Caed+30uokpRBSRK/jSfSvw5KmDfkxl/kJ
	 /tHd4VjqxwhQc7RtzGmUteOkahd15LahfBUleR5gzw4W43ZrGN70pXCM66yvrjV9oA
	 E156a3ZksKgyGCyCSJE4ENhZw5c4I0GdAbD6u/OJrtN6oe2+yoJO+QBfg8kOu/O3qy
	 sENn3w1/UZwfiPhmyLkQIBvze3tw6OIGrBPvm2g1z712Hy1bpQssANNpEXe/12gTxk
	 NwXlOo/6+g30A==
Date: Mon, 19 Jan 2026 09:43:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/14] iomap: free the bio before completing the dio
Message-ID: <20260119174348.GC15551@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-11-hch@lst.de>

On Mon, Jan 19, 2026 at 08:44:17AM +0100, Christoph Hellwig wrote:
> There are good arguments for processing the user completions ASAP vs.
> freeing resources ASAP, but freeing the bio first here removes potential
> use after free hazards when checking flags, and will simplify the
> upcoming bounce buffer support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1d5db85c8c7..d4d52775ce25 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -214,7 +214,15 @@ static void iomap_dio_done(struct iomap_dio *dio)
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
> +
> +	/* Do not touch bio below, we just gave up our reference. */

Thanks for adding this!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  
>  	if (atomic_dec_and_test(&dio->ref)) {
>  		/*
> @@ -225,13 +233,6 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
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

