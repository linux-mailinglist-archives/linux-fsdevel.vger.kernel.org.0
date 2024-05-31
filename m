Return-Path: <linux-fsdevel+bounces-20628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFBD8D63EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56640285AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA83115B56F;
	Fri, 31 May 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFFsw1KE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E169155C8E;
	Fri, 31 May 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164239; cv=none; b=LOpEhtEgVZlvn6mlLMWOgQDv+lPcrkd6X88dqLIJPY3OVB1MPT4O3FPaJ3PONbecqB6JkrPXwuiNWAlDQ059xMaPTn/KvZB7F1gi84DSKzQy2zDrm789FT3uowOxfXUbxcKQJbw+kuIQ9GWrUqTWxNj2gYl+qjNX6cn/Qum3Yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164239; c=relaxed/simple;
	bh=OR5TcAid10nxVjMKvTnf5psawQ+kB4xK6BcAmRyea1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXDB1+mptQJQL2xu7Uubqy6d3WU8VyoIT+ilXP8Rzd6iNCf2wYSRiUDH4kiBz17kcQXENCwuQEXPF/rPc3fcRufWFJ2Pi5cC2xIbs/3N8g8QnA/t+L5XlGdJSixZdKFj/6Lz++nFlvaI64Zro4ZBkcV1p1HiUuvnTnQKOau+CEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFFsw1KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBC4C116B1;
	Fri, 31 May 2024 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717164238;
	bh=OR5TcAid10nxVjMKvTnf5psawQ+kB4xK6BcAmRyea1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFFsw1KE13cBSVF2ZFI9uk0KAKuzlQrCqop/BEXWXprSV00dzWLST+9JnszVIsWKB
	 tH9cq83udcxZf0UltjzdgnB3b5T5dWP3WSNGu8tyN27taocyat5DgxNPuP4HfYx8lU
	 aAPdQ+2D99XHoOnjBMZtPUYW1AHLkhd2bGBG6XUO72abikZAqYjXKY2MBlHAQbmEgo
	 IoNNvhJOtuHSzihshNNXKT/sGQGNkhogqagJ+UnuSisaIfwQooFxKw2wRBJDJ4JnAO
	 YufkmiWK8XyOOMDLvW/ShbkkUhXegNilrcpc3UaM5Nha7dZHxud3Pj2oHSqUBklnN6
	 P1LErz+lf8k8g==
Date: Fri, 31 May 2024 07:03:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 1/8] iomap: zeroing needs to be pagecache aware
Message-ID: <20240531140358.GF52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-2-yi.zhang@huaweicloud.com>
 <ZlnMfSJcm5k6Dg_e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnMfSJcm5k6Dg_e@infradead.org>

On Fri, May 31, 2024 at 06:11:25AM -0700, Christoph Hellwig wrote:
> On Wed, May 29, 2024 at 05:51:59PM +0800, Zhang Yi wrote:
> > XXX: how do we detect a iomap containing a cow mapping over a hole
> > in iomap_zero_iter()? The XFS code implies this case also needs to
> > zero the page cache if there is data present, so trigger for page
> > cache lookup only in iomap_zero_iter() needs to handle this case as
> > well.
> 
> If there is no data in the page cache and either a whole or unwritten
> extent it really should not matter what is in the COW fork, a there
> obviously isn't any data we could zero.
> 
> If there is data in the page cache for something that is marked as
> a hole in the srcmap, but we have data in the COW fork due to
> COW extsize preallocation we'd need to zero it, but as the
> xfs iomap ops don't return a separate srcmap for that case we
> should be fine.  Or am I missing something?

It might be useful to skip the scan for dirty pagecache if both forks
have holes, since (in theory) that's never possible on xfs.

OTOH maybe there are filesystems that allow dirty pagecache over a hole?

> > + * Note: when zeroing unwritten extents, we might have data in the page cache
> > + * over an unwritten extent. In this case, we want to do a pure lookup on the
> > + * page cache and not create a new folio as we don't need to perform zeroing on
> > + * unwritten extents if there is no cached data over the given range.
> >   */
> >  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
> >  {
> >  	fgf_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
> >  
> > +	if (iter->flags & IOMAP_ZERO) {
> > +		const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > +
> > +		if (srcmap->type == IOMAP_UNWRITTEN)
> > +			fgp &= ~FGP_CREAT;
> > +	}
> 
> Nit:  The comment would probably stand out a little better if it was
> right next to the IOMAP_ZERO conditional instead of above the
> function.

Agreed.

> > +		if (status) {
> > +			if (status == -ENOENT) {
> > +				/*
> > +				 * Unwritten extents need to have page cache
> > +				 * lookups done to determine if they have data
> > +				 * over them that needs zeroing. If there is no
> > +				 * data, we'll get -ENOENT returned here, so we
> > +				 * can just skip over this index.
> > +				 */
> > +				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
> 
> I'd return -EIO if the WARN_ON triggers.
> 
> > +loop_continue:
> 
> While I'm no strange to gotos for loop control something trips me
> up about jumping to the end of the loop.  Here is what I could come
> up with instead.  Not arguing it's objectively better, but I somehow
> like it a little better:
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 700b22d6807783..81378f7cd8d7ff 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1412,49 +1412,56 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		bool ret;
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (status) {
> -			if (status == -ENOENT) {
> -				/*
> -				 * Unwritten extents need to have page cache
> -				 * lookups done to determine if they have data
> -				 * over them that needs zeroing. If there is no
> -				 * data, we'll get -ENOENT returned here, so we
> -				 * can just skip over this index.
> -				 */
> -				WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN);
> -				if (bytes > PAGE_SIZE - offset_in_page(pos))
> -					bytes = PAGE_SIZE - offset_in_page(pos);
> -				goto loop_continue;
> -			}
> +		if (status && status != -ENOENT)
>  			return status;
> -		}
> -		if (iter->iomap.flags & IOMAP_F_STALE)
> -			break;
>  
> -		offset = offset_in_folio(folio, pos);
> -		if (bytes > folio_size(folio) - offset)
> -			bytes = folio_size(folio) - offset;
> +		if (status == -ENOENT) {
> +			/*
> +			 * If we end up here, we did not find a folio in the
> +			 * page cache for an unwritten extent and thus can
> +			 * skip over the range.
> +			 */
> +			if (WARN_ON_ONCE(srcmap->type != IOMAP_UNWRITTEN))
> +				return -EIO;
>  
> -		/*
> -		 * If the folio over an unwritten extent is clean (i.e. because
> -		 * it has been read from), then it already contains zeros. Hence
> -		 * we can just skip it.
> -		 */
> -		if (srcmap->type == IOMAP_UNWRITTEN &&
> -		    !folio_test_dirty(folio)) {
> -			folio_unlock(folio);
> -			goto loop_continue;
> +			/*
> +			 * XXX: It would be nice if we could get the offset of
> +			 * the next entry in the pagecache so that we don't have
> +			 * to iterate one page at a time here.
> +			 */
> +			offset = offset_in_page(pos);
> +			if (bytes > PAGE_SIZE - offset)
> +				bytes = PAGE_SIZE - offset;

Why is it PAGE_SIZE here and not folio_size() like below?

(I know you're just copying the existing code; I'm merely wondering if
this is some minor bug.)

--D

> +		} else {
> +			if (iter->iomap.flags & IOMAP_F_STALE)
> +				break;
> +
> +			offset = offset_in_folio(folio, pos);
> +			if (bytes > folio_size(folio) - offset)
> +				bytes = folio_size(folio) - offset;
> +		
> +			/*
> +			 * If the folio over an unwritten extent is clean (i.e.
> +			 * because it has only been read from), then it already
> +			 * contains zeros.  Hence we can just skip it.
> +			 */
> +			if (srcmap->type == IOMAP_UNWRITTEN &&
> +			    !folio_test_dirty(folio)) {
> +				folio_unlock(folio);
> +				status = -ENOENT;
> +			}
>  		}
>  
> -		folio_zero_range(folio, offset, bytes);
> -		folio_mark_accessed(folio);
> +		if (status != -ENOENT) {
> +			folio_zero_range(folio, offset, bytes);
> +			folio_mark_accessed(folio);
>  
> -		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
> -		__iomap_put_folio(iter, pos, bytes, folio);
> -		if (WARN_ON_ONCE(!ret))
> -			return -EIO;
> +			ret = iomap_write_end(iter, pos, bytes, bytes, folio);
> +			__iomap_put_folio(iter, pos, bytes, folio);
> +			if (WARN_ON_ONCE(!ret))
> +				return -EIO;
> +		}
>  
> -loop_continue:
>  		pos += bytes;
>  		length -= bytes;
>  		written += bytes;
> 

