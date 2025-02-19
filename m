Return-Path: <linux-fsdevel+bounces-42133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E2A3CC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1221B189CE2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4CF25A2BD;
	Wed, 19 Feb 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecaz0Zzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431025A2B5;
	Wed, 19 Feb 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004495; cv=none; b=AM4es0D5Pbdjd/SFHeWUJ38lEJpXW6BxyrMqlGQELr3dqGo5re/Y6kOaw5gAhE4B+IO91JBDx1mXuKiG+MHv3lDlTW2eyeoWLHXm1LfOfvXFfWI8v2Is/5mA47T3e1WUkaVnahiL9ubt0QnqB9yZC6LfPXG+kQs2F3JCqm/fMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004495; c=relaxed/simple;
	bh=y0ojLiemQzadfsqOtg+sV/+d0Btwts3qstg9FgRttHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P//fdNYN8TRmoBdCowu5vmSY8t7qpT37FeCEQumAp6Qb3CzFNce5SfhTGl7Uhzv1oRjKD9Z+HKe/Fi+kVYvHz4CMgXBgjvajLqgfgPcOcf4B7HmubURPhrVi8RavOwpeU41T509hMlIVXyacZ+SsB0uCzXnih9tgQ5eaJbSgmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecaz0Zzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E377AC4CED1;
	Wed, 19 Feb 2025 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004495;
	bh=y0ojLiemQzadfsqOtg+sV/+d0Btwts3qstg9FgRttHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecaz0ZzfsXvtJe1dT9d+dFNkC4gtuxQ2NZBaerkG5d6el4pLzPTFKoKmKCO1n5cTF
	 QdspQqst3bJQzuT/ROWNMhiypsuJTztXBRLv9o78O1vn4tMDAnwYABrdPnQ/iRBi1s
	 dcMYj33yb33Q+YMwzG927aXNNfX2btW/q6lfdR2eG8104wWkcJ0tKxlY3J2uwza8+f
	 e9V1et9gytNB9gjWZIPr8vcHieThtFoUujq0a8bbOo6jSmdanXTJmY6qGF9WfWuVsl
	 n+OshI9VVVn/5OxMQebTk5eOUIwywSD1jaw1ft0W5K2MqxQcGs61anI+aMx+y7xpMq
	 rIBka6CAs3LKA==
Date: Wed, 19 Feb 2025 14:34:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 06/12] dax: advance the iomap_iter on zero range
Message-ID: <20250219223454.GL21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-7-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:44PM -0500, Brian Foster wrote:
> Update the DAX zero range iomap iter handler to advance the iter
> directly. Advance by the full length in the hole/unwritten case, or
> otherwise advance incrementally in the zeroing loop. In either case,
> return 0 or an error code for success or failure.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Pretty straightforward
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 139e299e53e6..f4d8c8c10086 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1358,13 +1358,12 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	const struct iomap *iomap = &iter->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	loff_t pos = iter->pos;
>  	u64 length = iomap_length(iter);
> -	s64 written = 0;
> +	s64 ret;
>  
>  	/* already zeroed?  we're done. */
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> -		return length;
> +		return iomap_iter_advance(iter, &length);
>  
>  	/*
>  	 * invalidate the pages whose sharing state is to be changed
> @@ -1372,33 +1371,35 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	 */
>  	if (iomap->flags & IOMAP_F_SHARED)
>  		invalidate_inode_pages2_range(iter->inode->i_mapping,
> -					      pos >> PAGE_SHIFT,
> -					      (pos + length - 1) >> PAGE_SHIFT);
> +				iter->pos >> PAGE_SHIFT,
> +				(iter->pos + length - 1) >> PAGE_SHIFT);
>  
>  	do {
> +		loff_t pos = iter->pos;
>  		unsigned offset = offset_in_page(pos);
> -		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>  		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> -		long rc;
>  		int id;
>  
> +		length = min_t(u64, PAGE_SIZE - offset, length);
> +
>  		id = dax_read_lock();
> -		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> +		if (IS_ALIGNED(pos, PAGE_SIZE) && length == PAGE_SIZE)
> +			ret = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>  		else
> -			rc = dax_memzero(iter, pos, size);
> +			ret = dax_memzero(iter, pos, length);
>  		dax_read_unlock(id);
>  
> -		if (rc < 0)
> -			return rc;
> -		pos += size;
> -		length -= size;
> -		written += size;
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = iomap_iter_advance(iter, &length);
> +		if (ret)
> +			return ret;
>  	} while (length > 0);
>  
>  	if (did_zero)
>  		*did_zero = true;
> -	return written;
> +	return ret;
>  }
>  
>  int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> -- 
> 2.48.1
> 
> 

