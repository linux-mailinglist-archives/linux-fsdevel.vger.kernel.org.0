Return-Path: <linux-fsdevel+bounces-40793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772DDA27B53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A4E7A27FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D38204C09;
	Tue,  4 Feb 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKoWgeEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE03213E71;
	Tue,  4 Feb 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738697457; cv=none; b=N7UOHGeIj7XDPQ/KwpLeutNnVEI/dOgdqhIi5mokHkNN9Mq+IULA+mAf+6AXr7YOUeutPZP/emWUv+hqyZDB4pi1T1kso+qVghsEMub2LCPJ3jVfeYQNKMED9FXRkY0uq1j6DeuYw+WhEPhw12QT8jB+ZbYVOPaVuGzTw+jrW/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738697457; c=relaxed/simple;
	bh=wK/ICJs34ylxLkSuB4ky/HA7vGnRT0untt070y2Lh9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idUkAxuak4CB0Pd3Lz08QlzsQKdRuleJm8cmLwnCsbET4evPJNx5MNFl4tXUj9L5iKHF0D//V1GxcGJYO/G9CEHG29kE7DHvJYcFhZevIN8QltI9UGYHtYFbVGmET+uXznGp7G8R31u/ab0DU9E6FtjxDYgKRmT7/GX/ajqDUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKoWgeEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36325C4CEE3;
	Tue,  4 Feb 2025 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738697457;
	bh=wK/ICJs34ylxLkSuB4ky/HA7vGnRT0untt070y2Lh9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKoWgeEPlXw+CYh6iWv0K48F5D25b+mymjMrbmYZLG2Bw1NOQacYznHbdNFb3HdKt
	 /HQ24A3WJUZmDIwdsCUeP/taFmWC97qtqF3qZr8S/kyhM1TmP+1q5yqskAa3MbsUra
	 FqfNwlNsNxtFzMHPTFe+tanItG05kyQGiqX7vyFaS9ErI9WURxlQfY9x8i2fxvBTEY
	 eHeGMN4oocK4XdDTx26+4kVmMW9l5itDeAg2gMDbQyZLSbJR3MdFC6RSdZJjPM23gA
	 Bg2b5tdjOgmtmz+wPdUINijqrGIv2yD+r18z5LA0a/7rMpH1c17DclBnQiCze/oGjX
	 LHVlpEizxYN+w==
Date: Tue, 4 Feb 2025 11:30:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 02/10] iomap: split out iomap check and reset logic
 from iter advance
Message-ID: <20250204193056.GD21808@frogsfrogsfrogs>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-3-bfoster@redhat.com>

On Tue, Feb 04, 2025 at 08:30:36AM -0500, Brian Foster wrote:
> In preparation for more granular iomap_iter advancing, break out
> some of the logic associated with higher level iteration from
> iomap_advance_iter(). Specifically, factor the iomap reset code into
> a separate helper and lift the iomap.length check into the calling
> code, similar to how ->iomap_end() calls are handled.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/iter.c | 49 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 3790918646af..731ea7267f27 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -7,6 +7,13 @@
>  #include <linux/iomap.h>
>  #include "trace.h"
>  
> +static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> +{
> +	iter->processed = 0;
> +	memset(&iter->iomap, 0, sizeof(iter->iomap));
> +	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> +}
> +
>  /*
>   * Advance to the next range we need to map.
>   *
> @@ -14,32 +21,24 @@
>   * processed - it was aborted because the extent the iomap spanned may have been
>   * changed during the operation. In this case, the iteration behaviour is to
>   * remap the unprocessed range of the iter, and that means we may need to remap
> - * even when we've made no progress (i.e. iter->processed = 0). Hence the
> - * "finished iterating" case needs to distinguish between
> - * (processed = 0) meaning we are done and (processed = 0 && stale) meaning we
> - * need to remap the entire remaining range.
> + * even when we've made no progress (i.e. count = 0). Hence the "finished
> + * iterating" case needs to distinguish between (count = 0) meaning we are done
> + * and (count = 0 && stale) meaning we need to remap the entire remaining range.
>   */
> -static inline int iomap_iter_advance(struct iomap_iter *iter)
> +static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
>  {
>  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
>  	int ret = 1;
>  
> -	/* handle the previous iteration (if any) */
> -	if (iter->iomap.length) {
> -		if (iter->processed < 0)
> -			return iter->processed;
> -		if (WARN_ON_ONCE(iter->processed > iomap_length(iter)))
> -			return -EIO;
> -		iter->pos += iter->processed;
> -		iter->len -= iter->processed;
> -		if (!iter->len || (!iter->processed && !stale))
> -			ret = 0;
> -	}
> +	if (count < 0)
> +		return count;
> +	if (WARN_ON_ONCE(count > iomap_length(iter)))
> +		return -EIO;
> +	iter->pos += count;
> +	iter->len -= count;
> +	if (!iter->len || (!count && !stale))
> +		ret = 0;
>  
> -	/* clear the per iteration state */
> -	iter->processed = 0;
> -	memset(&iter->iomap, 0, sizeof(iter->iomap));
> -	memset(&iter->srcmap, 0, sizeof(iter->srcmap));

Are there any consequences to not resetting the iter if
iter->iomap.length is zero?  I think the answer is "no" because callers
are supposed to initialize the iter with zeroes and filesystems are
never supposed to return zero-length iomaps from ->begin_iomap, right?

If the answers are "no" and "yes" then
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	return ret;
>  }
>  
> @@ -82,10 +81,14 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  			return ret;
>  	}
>  
> +	/* advance and clear state from the previous iteration */
>  	trace_iomap_iter(iter, ops, _RET_IP_);
> -	ret = iomap_iter_advance(iter);
> -	if (ret <= 0)
> -		return ret;
> +	if (iter->iomap.length) {
> +		ret = iomap_iter_advance(iter, iter->processed);
> +		iomap_iter_reset_iomap(iter);
> +		if (ret <= 0)
> +			return ret;
> +	}
>  
>  	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
>  			       &iter->iomap, &iter->srcmap);
> -- 
> 2.48.1
> 
> 

