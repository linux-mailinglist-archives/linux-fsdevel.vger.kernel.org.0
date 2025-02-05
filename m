Return-Path: <linux-fsdevel+bounces-40964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C1A299A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F761885C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B81FF5FB;
	Wed,  5 Feb 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQvh4808"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90C1FF1AC;
	Wed,  5 Feb 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782021; cv=none; b=Jqd3itHzsuYkpSGRMH8WVmYQ06KKXiCF1sQdp1ZG+89ExJkzO3EOETytGUYMe3f11q8uOvb4XAK58IgrnAklKL47ZZ/iz6Ps9hDv8wpCsrJLdDFIeT/y5KvmVm/txE3FyU7SMrhpAk1kxbACcDWWpVYB8WsMadFauZjhHnjn138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782021; c=relaxed/simple;
	bh=ngu12aWjiC63cUJmNd3YKm1NFBVq7v2RxdYy4C80fbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6z4xLtLuB1zNdhkZ1rP7T4ouKKHprGXzQ6dDL6x0OdMQjq5JUmu+j5tuH4EEHKnbzfq6ybQl8/BMD8ZTjyMtrKO/rCn3YFKbPcMjwAD7LBll7jWCYIO8zzD31brqWkyQUZ65E1liSFFTI1tipuG38DkUQyu/yF3D1G+33eNUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQvh4808; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AA0C4CEDD;
	Wed,  5 Feb 2025 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782020;
	bh=ngu12aWjiC63cUJmNd3YKm1NFBVq7v2RxdYy4C80fbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQvh4808crFbsLQfNehZkGy8GShpTCXFafpTDXu/ZG7nAosIA1VAYPApbCjYLCBUc
	 iOneMHMBSmewpkXIuPCwztaOPpD7rFqk2Ar9Mf3Nj/F7rjP0cjFPSuqs7PzEUWSmX1
	 ixyEj9QRHIaNh7u+TT0/P6izzdQUD6/7EsfsPI3WAZrihjKpr6NVxTMLz4r05yEHph
	 N55Ca3E4slCMlEM9nYrdqySIycj2EJXRsJ9nHdgQosFGxSOePWdAiI1JerABZKP56a
	 yfYhMPMlB2GZtWY5XzZ4NrJhCAc3kR7cnglCjcDthnvxsm2bFH2HXz5PEhOmTHxgg3
	 YHMN/VsENGHeA==
Date: Wed, 5 Feb 2025 11:00:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 05/10] iomap: lift iter termination logic from
 iomap_iter_advance()
Message-ID: <20250205190020.GP21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-6-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:16AM -0500, Brian Foster wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/iter.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 1db16be7b9f0..8e0746ad80bd 100644
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
>  	s64 processed;
>  	int ret;
>  
> @@ -91,8 +86,18 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  		return processed;
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
>  	ret = iomap_iter_advance(iter, processed);
> +	if (!ret && iter->len > 0)
> +		ret = 1;
> +	if (ret > 0 && !iter->processed && !stale)
> +		ret = 0;

I guess I'll wait to see what the rest of the conversion series looks
like...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	iomap_iter_reset_iomap(iter);
>  	if (ret <= 0)
>  		return ret;
> -- 
> 2.48.1
> 
> 

