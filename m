Return-Path: <linux-fsdevel+bounces-42126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B9A3CC51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF90F189A76C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4B625A2AA;
	Wed, 19 Feb 2025 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/nBpLBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557925A2A8;
	Wed, 19 Feb 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004211; cv=none; b=BI3uJEpenerObNXgoKfTVsoFrfYBiZX4vSLfJUSI2qV01jmGYM6IcRb4b3p24qvPHAkyf8Fz5Git+AHGZibh2wis5u4aIeEV1LBCFya3aHLrqxJg/w+RcpbLsb+F25TeVOqueGed1FsnYE1rAb6KxPuFxQJtsoPUzTjQCgjmBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004211; c=relaxed/simple;
	bh=jT/hi98KFRJ3eDFi7f1Go+cv/WfxUn68KH5ijfWZCTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj97STsOG0F0/5MvRBJg6TcvKv28zxSUFyeYhk7EDdVHFUzSF8Hj8LZGXYgDR370ixdnZm+2/fVlmtvkxZNALQDOgLiTcHPuED+oos0qonYxHXDdInE5aMUK0JfzsI/ihJ6K7FgDeZSo+k9P16LwjUGAGpHhddoZ4tIeVb0VJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/nBpLBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B51C4CED1;
	Wed, 19 Feb 2025 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004210;
	bh=jT/hi98KFRJ3eDFi7f1Go+cv/WfxUn68KH5ijfWZCTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/nBpLBWKg51U0XpGKc29jXyd6lVBWTzBn/yHFXllTJcoYEiN/UWvD2ZaM/qNvzDg
	 TDSu2Eu1HNBTg2oXEbLi4xXrAwGR+qlQXc75wEVjeY/8aW4w3K0LnyWrpxGzP9sOh6
	 2Fjwg+5shNo8sLNkby8Cs7kD93QQx1SB/upknsdcihIStZiAOHswWCzOF3tKvl5wV0
	 nXcGfX/7TnI3+TcGZ9Kaov+dcgZZ1eV3BZAbkRPaBrA4wAvs6HYKL4v8GSvgnwqbKv
	 8s4Jfp/jNjPOiclJ249QCRzUZ3alKW42SnokIurGyunH7IEVwD7/+e09/e/zRBfIh2
	 RcBcoMxVEmF/A==
Date: Wed, 19 Feb 2025 14:30:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 10/12] iomap: remove unnecessary advance from
 iomap_iter()
Message-ID: <20250219223010.GE21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-11-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-11-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:48PM -0500, Brian Foster wrote:
> At this point, all iomap operations have been updated to advance the
> iomap_iter directly before returning to iomap_iter(). Therefore, the
> complexity of handling both the old and new semantics is no longer
> required and can be removed from iomap_iter().
> 
> Update iomap_iter() to expect success or failure status in
> iter.processed. As a precaution and developer hint to prevent
> inadvertent use of old semantics, warn on a positive return code and
> fail the operation. Remove the unnecessary advance and simplify the
> termination logic.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks reasonable,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 0ebcabc7df52..e4dfe64029cc 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -60,9 +60,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  {
>  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> -	ssize_t advanced = iter->processed > 0 ? iter->processed : 0;
> -	u64 olen = iter->len;
> -	s64 processed;
> +	ssize_t advanced;
> +	u64 olen;
>  	int ret;
>  
>  	trace_iomap_iter(iter, ops, _RET_IP_);
> @@ -71,14 +70,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  		goto begin;
>  
>  	/*
> -	 * If iter.processed is zero, the op may still have advanced the iter
> -	 * itself. Calculate the advanced and original length bytes based on how
> -	 * far pos has advanced for ->iomap_end().
> +	 * Calculate how far the iter was advanced and the original length bytes
> +	 * for ->iomap_end().
>  	 */
> -	if (!advanced) {
> -		advanced = iter->pos - iter->iter_start_pos;
> -		olen += advanced;
> -	}
> +	advanced = iter->pos - iter->iter_start_pos;
> +	olen = iter->len + advanced;
>  
>  	if (ops->iomap_end) {
>  		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
> @@ -89,27 +85,22 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  			return ret;
>  	}
>  
> -	processed = iter->processed;
> -	if (processed < 0) {
> -		iomap_iter_reset_iomap(iter);
> -		return processed;
> -	}
> +	/* detect old return semantics where this would advance */
> +	if (WARN_ON_ONCE(iter->processed > 0))
> +		iter->processed = -EIO;
>  
>  	/*
> -	 * Advance the iter and clear state from the previous iteration. This
> -	 * passes iter->processed because that reflects the bytes processed but
> -	 * not yet advanced by the iter handler.
> -	 *
>  	 * Use iter->len to determine whether to continue onto the next mapping.
> -	 * Explicitly terminate in the case where the current iter has not
> +	 * Explicitly terminate on error status or if the current iter has not
>  	 * advanced at all (i.e. no work was done for some reason) unless the
>  	 * mapping has been marked stale and needs to be reprocessed.
>  	 */
> -	ret = iomap_iter_advance(iter, &processed);
> -	if (!ret && iter->len > 0)
> -		ret = 1;
> -	if (ret > 0 && !advanced && !stale)
> +	if (iter->processed < 0)
> +		ret = iter->processed;
> +	else if (iter->len == 0 || (!advanced && !stale))
>  		ret = 0;
> +	else
> +		ret = 1;
>  	iomap_iter_reset_iomap(iter);
>  	if (ret <= 0)
>  		return ret;
> -- 
> 2.48.1
> 
> 

