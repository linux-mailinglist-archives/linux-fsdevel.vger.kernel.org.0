Return-Path: <linux-fsdevel+bounces-41233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38251A2C9F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D7167C31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692519259D;
	Fri,  7 Feb 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+7h3mWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503818DB2E;
	Fri,  7 Feb 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948713; cv=none; b=LvA8/raLdpezaOyQPgVpjKZP3YJmuVXY/y1nJ5h2o8INPk5TkhRIHyf80NgpUflfI+ANAmYCUdYVxgF2Q4/znpXqqitgoNzx5LTZxVUwGCiDGrWSucyrjRpn1qTp6Jd0i1fRRbiYoyU+sOKKnB7dRr4Rdks+mLnCnMvnNPLczmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948713; c=relaxed/simple;
	bh=9/IUlzFG4Oqnd1R1zDDADylxpqTqS4Cecuwb7v+KW4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob8JezsdiHIPHYTrELGiFbUpD+tBMG9RX/HoAJvxhkWA9Rb+PMUIS+Pam5FzypzSWf2X2osiwTPQ3RZb+07EQc5quYcPw9m8nufmiVQVvYojWBguwyh87+tu7EtCy4dca7ZyA8RVuXgXLmTnPE6tPQgYaphBJAb6IFzEjZZ133U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+7h3mWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF8DC4CED1;
	Fri,  7 Feb 2025 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738948713;
	bh=9/IUlzFG4Oqnd1R1zDDADylxpqTqS4Cecuwb7v+KW4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+7h3mWFfHwwzaWhddSjHb6ZkWyGaDGKr8abxJ57fRg0hIao4FMlP8rGFFK1chWoA
	 QBLEVN+/TL0frj7qI4/7gj7ZeZr8solFWiFVX44F+bjbaejSP7+XSgvopc0Q/rryGc
	 FxyHaRxIAJdCtBOy+V9/NbYELEOd8Z70cgk3ZgE4PTL5KxvOtbmUD1WqjBU7D2RcrB
	 /+tk0FN75dQ54M1R9bqBiKjGYBqQwHIZ0xgfDamDu++8/7NZlIrHir0A4PyBULXn9N
	 QKNim+9yMEbVj4Fe6y2kIquBRDAqeAGQVKlYwMQpDJd84oROGrJKJhLeh/EjP+Ipa+
	 rKorA6QED7k7A==
Date: Fri, 7 Feb 2025 09:18:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 07/10] iomap: support incremental iomap_iter advances
Message-ID: <20250207171832.GY21808@frogsfrogsfrogs>
References: <20250207143253.314068-1-bfoster@redhat.com>
 <20250207143253.314068-8-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207143253.314068-8-bfoster@redhat.com>

On Fri, Feb 07, 2025 at 09:32:50AM -0500, Brian Foster wrote:
> The current iomap_iter iteration model reads the mapping from the
> filesystem, processes the subrange of the operation associated with
> the current mapping, and returns the number of bytes processed back
> to the iteration code. The latter advances the position and
> remaining length of the iter in preparation for the next iteration.
> 
> At the _iter() handler level, this tends to produce a processing
> loop where the local code pulls the current position and remaining
> length out of the iter, iterates it locally based on file offset,
> and then breaks out when the associated range has been fully
> processed.
> 
> This works well enough for current handlers, but upcoming
> enhancements require a bit more flexibility in certain situations.
> Enhancements for zero range will lead to a situation where the
> processing loop is no longer a pure ascending offset walk, but
> rather dictated by pagecache state and folio lookup. Since folio
> lookup and write preparation occur at different levels, it is more
> difficult to manage position and length outside of the iter.
> 
> To provide more flexibility to certain iomap operations, introduce
> support for incremental iomap_iter advances from within the
> operation itself. This allows more granular advances for operations
> that might not use the typical file offset based walk.
> 
> Note that the semantics for operations that use incremental advances
> is slightly different than traditional operations. Operations that
> advance the iter directly are expected to return success or failure
> (i.e. 0 or negative error code) in iter.processed rather than the
> number of bytes processed.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for the documentation update, even if some of it is temporary.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c       | 32 +++++++++++++++++++++++++-------
>  include/linux/iomap.h |  8 ++++++--
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 544cd7a5a16b..0ebcabc7df52 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -35,6 +35,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>  	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
>  	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
>  
> +	iter->iter_start_pos = iter->pos;
> +
>  	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
>  	if (iter->srcmap.type != IOMAP_HOLE)
>  		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
> @@ -58,6 +60,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  {
>  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> +	ssize_t advanced = iter->processed > 0 ? iter->processed : 0;
> +	u64 olen = iter->len;
>  	s64 processed;
>  	int ret;
>  
> @@ -66,11 +70,22 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	if (!iter->iomap.length)
>  		goto begin;
>  
> +	/*
> +	 * If iter.processed is zero, the op may still have advanced the iter
> +	 * itself. Calculate the advanced and original length bytes based on how
> +	 * far pos has advanced for ->iomap_end().
> +	 */
> +	if (!advanced) {
> +		advanced = iter->pos - iter->iter_start_pos;
> +		olen += advanced;
> +	}
> +
>  	if (ops->iomap_end) {
> -		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
> -				iter->processed > 0 ? iter->processed : 0,
> -				iter->flags, &iter->iomap);
> -		if (ret < 0 && !iter->processed)
> +		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
> +				iomap_length_trim(iter, iter->iter_start_pos,
> +						  olen),
> +				advanced, iter->flags, &iter->iomap);
> +		if (ret < 0 && !advanced)
>  			return ret;
>  	}
>  
> @@ -81,8 +96,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	}
>  
>  	/*
> -	 * Advance the iter and clear state from the previous iteration. Use
> -	 * iter->len to determine whether to continue onto the next mapping.
> +	 * Advance the iter and clear state from the previous iteration. This
> +	 * passes iter->processed because that reflects the bytes processed but
> +	 * not yet advanced by the iter handler.
> +	 *
> +	 * Use iter->len to determine whether to continue onto the next mapping.
>  	 * Explicitly terminate in the case where the current iter has not
>  	 * advanced at all (i.e. no work was done for some reason) unless the
>  	 * mapping has been marked stale and needs to be reprocessed.
> @@ -90,7 +108,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	ret = iomap_iter_advance(iter, &processed);
>  	if (!ret && iter->len > 0)
>  		ret = 1;
> -	if (ret > 0 && !iter->processed && !stale)
> +	if (ret > 0 && !advanced && !stale)
>  		ret = 0;
>  	iomap_iter_reset_iomap(iter);
>  	if (ret <= 0)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f304c602e5fe..d832a540cc72 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -211,8 +211,11 @@ struct iomap_ops {
>   *	calls to iomap_iter().  Treat as read-only in the body.
>   * @len: The remaining length of the file segment we're operating on.
>   *	It is updated at the same time as @pos.
> - * @processed: The number of bytes processed by the body in the most recent
> - *	iteration, or a negative errno. 0 causes the iteration to stop.
> + * @iter_start_pos: The original start pos for the current iomap. Used for
> + *	incremental iter advance.
> + * @processed: The number of bytes the most recent iteration needs iomap_iter()
> + *	to advance the iter, zero if the iter was already advanced, or a
> + *	negative errno for an error during the operation.
>   * @flags: Zero or more of the iomap_begin flags above.
>   * @iomap: Map describing the I/O iteration
>   * @srcmap: Source map for COW operations
> @@ -221,6 +224,7 @@ struct iomap_iter {
>  	struct inode *inode;
>  	loff_t pos;
>  	u64 len;
> +	loff_t iter_start_pos;
>  	s64 processed;
>  	unsigned flags;
>  	struct iomap iomap;
> -- 
> 2.48.1
> 
> 

