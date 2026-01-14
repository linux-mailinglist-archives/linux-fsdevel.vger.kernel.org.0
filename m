Return-Path: <linux-fsdevel+bounces-73839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EBD219F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 799C6301D1C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE83B5312;
	Wed, 14 Jan 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeTB3veu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DA35502A;
	Wed, 14 Jan 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430160; cv=none; b=OnmVyg0c0byOGh0WupfPEXctnSsL6LwQZPK2QXTtrfR0U1kba2PDfcbZ/qpVVcNOWYIz0QX+wCRpjTQJXRkLKHw0/5OxlvS6Eq5Q8akIBW6/IZpdI7R/d8XtRW/50hWyqr7cnAELEXFVwSDajOSyOEfUlxsJ2J0sHpmHz5TAp14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430160; c=relaxed/simple;
	bh=b5/3DQjQA9EXl8io9tA//lDMRsaMGLjSrpkfvbD0DYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atpBUvo2ADARdhRNUuDmwrcRRtwPz1FJp6A1JUh6Pfnlf0WQ2mB5YBxixvNOIBkM0O+e9ccQ1C1Tbwn0nps0ciG0dI1tBTlmYSBO9g+lu/hrRzgGfpD5PTJCtlC4QI9pjpgJbtkcNknpCq8C7D7NtKYw/wgzxQuH775cttx2bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeTB3veu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35CEC4CEF7;
	Wed, 14 Jan 2026 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768430158;
	bh=b5/3DQjQA9EXl8io9tA//lDMRsaMGLjSrpkfvbD0DYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AeTB3veulDOxVFJA7q/2kxNU/YOfNDPHu6RWoNwbDb+p52Lqp2vufat85saIIZbG4
	 a70VwG02F+CwP/YQo+ALxKJXoIlIZICbdotxgLb3Hq3M2w9oCAxB7JJy4wEBJ3fyUE
	 gqINc4CIzOOj/K7fTPLWP9NL4IAcqebt1QnbpGcwmZ19mrTaw5+Q8e9/TCqDDuRVF4
	 r1yiAWVnJLrWxqgufgOn5ligfu34K6+YwW3R3NGCtEFh1sD2swvknfS8ErF2jbknIr
	 +nTcRcYGw+5vHLr3linYgLbDJyzc1aUHNcTuiXOr+w2+gZ00CKCHZlojcKG+e0BuHL
	 Wtf0oHrXpl6Hw==
Date: Wed, 14 Jan 2026 14:35:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/14] iomap: fix submission side handling of completion
 side errors
Message-ID: <20260114223558.GK15551@frogsfrogsfrogs>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074145.3396036-7-hch@lst.de>

On Wed, Jan 14, 2026 at 08:41:04AM +0100, Christoph Hellwig wrote:
> The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
> more bios when a completion already return an error.  Commit cfe057f7db1f
> ("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
> "copied", which is very wrong given that we've already consumed that
> range and submitted a bio for it.

Is it possible for the error to be ENOTBLK and the caller wants to fall
back to buffered IO?  I /think/ the answer is "no" because only the
->iomap_begin methods (and therefore iomap_iter()) should be doing that,
and we mask the ENOTBLK and pretend it's a short write.  Right?

--D

> Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/direct-io.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8e273408453a..6ec4940e019c 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -442,9 +442,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
> -		if (dio->error) {
> -			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +
> +		/*
> +		 * If completions already occurred and reported errors, give up now and
> +		 * don't bother submitting more bios.
> +		 */
> +		if (unlikely(data_race(dio->error))) {
> +			ret = 0;
>  			goto out;
>  		}
>  
> -- 
> 2.47.3
> 
> 

