Return-Path: <linux-fsdevel+bounces-51049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA29AD2387
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292D1188803F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD32192FA;
	Mon,  9 Jun 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aze4D2TO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92B1C6FE1;
	Mon,  9 Jun 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485810; cv=none; b=cvwIIwUTbOhYJ7ylbqCkf3TcuTtLXDlEv6nx2PbDJwUzjjqCipw0Ahz9nqvM7O2LeFrPG7aZ9j3UphdVeyvpH+HGdoMZk77NpJTAPPYIFk3mE2x8/LlrFgbktVtC+suTgxFFmB1FJTliGmYcgSvf+ZMdO6K49RzD+A7jFABT3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485810; c=relaxed/simple;
	bh=a5yNf70th7PfRA6xSLN9zz87BrnzItNsGibksd2xWXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zti7RQIY+7n0tKXnyZsf86RSO/ntwD1WdUn52HY2jy/Uq5CM6IVMyWR2wQbDH5gAO4NVXv02lOMnx5R3KXvc1be5FNjzkerihopxajil3heWImfTZTnR+n3UFI2cnjFtFQRD0tp2BCHz+nmeIqkRBXTtmk8QbFvi3+2tGA3YWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aze4D2TO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF23C4CEEB;
	Mon,  9 Jun 2025 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485810;
	bh=a5yNf70th7PfRA6xSLN9zz87BrnzItNsGibksd2xWXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aze4D2TOOl1hFddI/gLa5cdCvzXcKO/8m4ISRTbckDQjO8MJhUMdV0RoHk/FqZLn3
	 3NDBPL9MKmwhFp0nfw0yXf/nSS0vof/VCO9swjxquxbWzKkNlqfVuIPbhgkd5x4B8g
	 oPYuE8p8nErm/LC6Co9nEVRXs7pExrC+DBv8F898q7CJA52FutgPdTvCv4ZAtoooZ5
	 LTyd8uir2CkLuL6hi1d2Ul0fHfkQSsuzh8tMFV8SnxqwcGdZwuo4BJPjfa2qEV93MJ
	 sFBuWrxUHo3aWgWKOxN6qY4hKWgDD8cv4wjytlPMxnXTltLBSmdE6Bpxd3GPFh+K9z
	 VWCIMDDJxWz3A==
Date: Mon, 9 Jun 2025 09:16:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/7] iomap: move pos+len BUG_ON() to after folio lookup
Message-ID: <20250609161649.GF6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-2-bfoster@redhat.com>

On Thu, Jun 05, 2025 at 01:33:51PM -0400, Brian Foster wrote:
> The bug checks at the top of iomap_write_begin() assume the pos/len
> reflect exactly the next range to process. This may no longer be the
> case once the get folio path is able to process a folio batch from
> the filesystem. Move the check a bit further down after the folio
> lookup and range trim to verify everything lines up with the current
> iomap.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3729391a18f3..16499655e7b0 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -805,15 +805,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	loff_t pos = iter->pos;
> +	loff_t pos;
>  	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
>  	struct folio *folio;
>  	int status = 0;
>  
>  	len = min_not_zero(len, *plen);
> -	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> -	if (srcmap != &iter->iomap)
> -		BUG_ON(pos + len > srcmap->offset + srcmap->length);

Hmm.  Do we even /need/ these checks?

len is already basically just min(SIZE_MAX, iter->len,
iomap->offset + iomap->length, srcmap->offset + srcmap->length)

So by definition they should never trigger, right?

--D

>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -843,6 +840,9 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  	}
>  
>  	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
> +	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> +	if (srcmap != &iter->iomap)
> +		BUG_ON(pos + len > srcmap->offset + srcmap->length);
>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		status = iomap_write_begin_inline(iter, folio);
> -- 
> 2.49.0
> 
> 

