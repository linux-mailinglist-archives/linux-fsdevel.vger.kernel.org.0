Return-Path: <linux-fsdevel+bounces-40810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D6A27C3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD4516233D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A021A457;
	Tue,  4 Feb 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oArsMZp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74A204F7F;
	Tue,  4 Feb 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698742; cv=none; b=IQPjN9ZLxz7EbGbwRLf7zGasupX2gosPIeM7QNcCwR5jkLeOZN0Fnne8zlMOy3ktRgoBRPkEeVEfmgGTe4embFqTK2tjIxLACz+GQpJMtycPAROL1xA0n3f4q/lGQbbQ2gj03cjMgeo+FIdZ/EsCJ8p10zKKt4zhf1fZ+U0NzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698742; c=relaxed/simple;
	bh=8wzxGNV7ip+iLOJg7XVsZXSg2+EaqkKL3tac0+ZElt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCe0RAnM8cZHlWkq8B3VqCgZvpV/OplQwbq9+6eN9WMPaSeyT5f2BYWESqUAJjDCnZhB/6fBqA86h4QFFO93uxmvm/gVRJR4S5t2VcG22sfOGsWPSRMHE+pbvrw9wusp2fiOzN50KORfeyUwBU/mGIfIRCqXCn22uy9N9OYv+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oArsMZp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E8CC4CEDF;
	Tue,  4 Feb 2025 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738698741;
	bh=8wzxGNV7ip+iLOJg7XVsZXSg2+EaqkKL3tac0+ZElt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oArsMZp8DbMBUI+0tBWPNWxsceM1lcKE9Fr6RBtgHGS0xKQORURpfuHRe+5U0Lwrh
	 2OOHKonQDbI4EVUQtOER1TZalHXV7c60aHK1ZHrwH5KZuZLYvjgJRHkNZQsw8g+Ghx
	 o2pmqzNuEWB2wclWNoB/KalXnrdh232jBGsowFBkmUZNRV4TpNaKvELcjxLOr73Xa2
	 LEVI7ZclqKjfXO85NVkySdleO9iP+HeICZTThLhn40awh2OiY+uqgQRHk21Azisn0T
	 cJmpiJY810r/HDK3dfjzgqW0xlACO2d0LJ/PAPjOUuQrEZFiCu4PtnIeLd5BAf1Dtv
	 f9d8S5IZZPh7Q==
Date: Tue, 4 Feb 2025 11:52:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 05/10] iomap: lift iter termination logic from
 iomap_iter_advance()
Message-ID: <20250204195220.GE21808@frogsfrogsfrogs>
References: <20250204133044.80551-1-bfoster@redhat.com>
 <20250204133044.80551-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204133044.80551-6-bfoster@redhat.com>

On Tue, Feb 04, 2025 at 08:30:39AM -0500, Brian Foster wrote:
> The iter termination logic in iomap_iter_advance() is only needed by
> iomap_iter() to determine whether to proceed with the next mapping
> for an ongoing operation. The old logic sets ret to 1 and then
> terminates if the operation is complete (iter->len == 0) or the
> previous iteration performed no work and the mapping has not been
> marked stale. The stale check exists to allow operations to
> retry the current mapping if an inconsistency has been detected.
> 
> To further genericize iomap_iter_advance(), lift the termination
> logic into iomap_iter() and update the former to return success (0)
> or an error code. iomap_iter() continues on successful advance and
> non-zero iter->len or otherwise terminates in the no progress (and
> not stale) or error cases.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/iter.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index fcc8d75dd22f..04bd39ee5d47 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -27,17 +27,11 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>   */
>  static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
>  {
> -	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> -	int ret = 1;
> -
>  	if (WARN_ON_ONCE(count > iomap_length(iter)))
>  		return -EIO;
>  	iter->pos += count;
>  	iter->len -= count;
> -	if (!iter->len || (!count && !stale))
> -		ret = 0;
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static inline void iomap_iter_done(struct iomap_iter *iter)
> @@ -69,6 +63,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>   */
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  {
> +	bool stale = iter->iomap.flags & IOMAP_F_STALE;
>  	int ret;
>  
>  	trace_iomap_iter(iter, ops, _RET_IP_);
> @@ -89,8 +84,18 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  		return iter->processed;
>  	}
>  
> -	/* advance and clear state from the previous iteration */
> +	/*
> +	 * Advance the iter and clear state from the previous iteration. Use
> +	 * iter->len to determine whether to continue onto the next mapping.
> +	 * Explicitly terminate in the case where the current iter has not
> +	 * advanced at all (i.e. no work was done for some reason) unless the
> +	 * mapping has been marked stale and needs to be reprocessed.
> +	 */
>  	ret = iomap_iter_advance(iter, iter->processed);
> +	if (!ret && iter->len > 0)
> +		ret = 1;
> +	if (ret > 0 && !iter->processed && !stale)

How can ret be greater than zero here other than the previous line
setting it?  I /think/ this is the same as:

	if (!ret && iter->len > 0) {
		if (iter->processed || stale)
			ret = 1;
	}

but then I wonder if it's really necessary to reset the iter state on
error, or if we've finished the whole thing, or if we've done no work
and didn't set STALE?  What do you think about:

	ret = iomap_iter_advance(...);
	if (ret || !iter->len)
		return ret;
	if (!iter->processed && !stale)
		return 0;

	iomap_iter_reset_iomap(iter);
	ret = ops->iomap_begin(...);

--D

> +		ret = 0;
>  	iomap_iter_reset_iomap(iter);
>  	if (ret <= 0)
>  		return ret;
> -- 
> 2.48.1
> 
> 

