Return-Path: <linux-fsdevel+bounces-42129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E009BA3CC58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403CA7A50C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF87259495;
	Wed, 19 Feb 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/U0cIbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1317CA12;
	Wed, 19 Feb 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004305; cv=none; b=vGgJNUuyoszutSECIstVETCM+ygILdnQGK3Ph380IF5qESqvjY8XbOXL1KUdJuTGtZSv69+y2nwpbHd+B+8+z4YFkiXV82Bcs7Ppx8atPVq9b64vCMchlev3jHVnlCzlqaLsDRHgPue5IMP5SrS3wi52GxMpH0EoQrOUSYx6blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004305; c=relaxed/simple;
	bh=rjSUNO4FBfyczkNOrpnaKO1/3mMyZPB4f6E+zbJobb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8Sow1k3eK0Edk+4uss0DhDqoZrMpC7gRu2AqOSUugOHCtVnq4Jd3zddT5Zeh9sqDRL1SADzagzSwdC/0NeL7U3f2Zwewa11NVNvrmq38zugPEPVY4eqVG+4Ei2vTQJDQoZ0r9VObWhV0Vd+mLqzwer5sP6GNmYzRk7HhAm1r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/U0cIbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AC5C4CED1;
	Wed, 19 Feb 2025 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004305;
	bh=rjSUNO4FBfyczkNOrpnaKO1/3mMyZPB4f6E+zbJobb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/U0cIbGvZlIIdF7wVL4bdsv01qrfUlAkE7buOO/aiDblUfGUkFm4kubdK65pQF1n
	 vUtQjjky8XwFQDLmVbaFOF9mSto67WKF5s0JfhpZ0gXWVALaz2o8p5xvZLRgG/M5c2
	 qv5KjecULUorrDFpoHa3rNVjOUeRMru2XO48DfcGK6L5qQephYhdNBdsNCEvfZMPME
	 HRO7E6W8/vDpCPISAgnmyIgW+8Dc75CIqI9GRC+hwC7ccHVgdo/BJO/3/ec5m95iu0
	 9H1KiP+G85k2mCBu0K6DLlheKS648u/v5QevgHJQbr2MWIV1/1hjCbMya32UHOQpNa
	 Pw/zZZl+WUaRw==
Date: Wed, 19 Feb 2025 14:31:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/12] iomap: advance the iter directly on buffered
 read
Message-ID: <20250219223144.GH21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-2-bfoster@redhat.com>
 <20250219222235.GB21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219222235.GB21808@frogsfrogsfrogs>

On Wed, Feb 19, 2025 at 02:22:35PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 19, 2025 at 12:50:39PM -0500, Brian Foster wrote:
> > iomap buffered read advances the iter via iter.processed. To
> > continue separating iter advance from return status, update
> > iomap_readpage_iter() to advance the iter instead of returning the
> > number of bytes processed. In turn, drop the offset parameter and
> > sample the updated iter->pos at the start of the function. Update
> > the callers to loop based on remaining length in the current
> > iteration instead of number of bytes processed.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/buffered-io.c | 45 +++++++++++++++++++-----------------------
> >  1 file changed, 20 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ec227b45f3aa..215866ba264d 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -366,15 +366,14 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> >  		pos >= i_size_read(iter->inode);
> >  }
> >  
> > -static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> > -		struct iomap_readpage_ctx *ctx, loff_t offset)
> > +static loff_t iomap_readpage_iter(struct iomap_iter *iter,
> 
> I wonder, do we really need to return loff_t from some of these
> functions now?  I thought the only return codes were the -EIO/0 from
> iomap_iter_advance?

And that's provided in the last patch so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> 
> --D
> 
> > +		struct iomap_readpage_ctx *ctx)
> >  {
> >  	const struct iomap *iomap = &iter->iomap;
> > -	loff_t pos = iter->pos + offset;
> > -	loff_t length = iomap_length(iter) - offset;
> > +	loff_t pos = iter->pos;
> > +	loff_t length = iomap_length(iter);
> >  	struct folio *folio = ctx->cur_folio;
> >  	struct iomap_folio_state *ifs;
> > -	loff_t orig_pos = pos;
> >  	size_t poff, plen;
> >  	sector_t sector;
> >  
> > @@ -438,25 +437,22 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> >  	 * we can skip trailing ones as they will be handled in the next
> >  	 * iteration.
> >  	 */
> > -	return pos - orig_pos + plen;
> > +	length = pos - iter->pos + plen;
> > +	return iomap_iter_advance(iter, &length);
> >  }
> >  
> > -static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
> >  		struct iomap_readpage_ctx *ctx)
> >  {
> > -	struct folio *folio = ctx->cur_folio;
> > -	size_t offset = offset_in_folio(folio, iter->pos);
> > -	loff_t length = min_t(loff_t, folio_size(folio) - offset,
> > -			      iomap_length(iter));
> > -	loff_t done, ret;
> > -
> > -	for (done = 0; done < length; done += ret) {
> > -		ret = iomap_readpage_iter(iter, ctx, done);
> > -		if (ret <= 0)
> > +	loff_t ret;
> > +
> > +	while (iomap_length(iter)) {
> > +		ret = iomap_readpage_iter(iter, ctx);
> > +		if (ret)
> >  			return ret;
> >  	}
> >  
> > -	return done;
> > +	return 0;
> >  }
> >  
> >  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
> > @@ -493,15 +489,14 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_read_folio);
> >  
> > -static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> > +static loff_t iomap_readahead_iter(struct iomap_iter *iter,
> >  		struct iomap_readpage_ctx *ctx)
> >  {
> > -	loff_t length = iomap_length(iter);
> > -	loff_t done, ret;
> > +	loff_t ret;
> >  
> > -	for (done = 0; done < length; done += ret) {
> > +	while (iomap_length(iter)) {
> >  		if (ctx->cur_folio &&
> > -		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
> > +		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
> >  			if (!ctx->cur_folio_in_bio)
> >  				folio_unlock(ctx->cur_folio);
> >  			ctx->cur_folio = NULL;
> > @@ -510,12 +505,12 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> >  			ctx->cur_folio = readahead_folio(ctx->rac);
> >  			ctx->cur_folio_in_bio = false;
> >  		}
> > -		ret = iomap_readpage_iter(iter, ctx, done);
> > -		if (ret <= 0)
> > +		ret = iomap_readpage_iter(iter, ctx);
> > +		if (ret)
> >  			return ret;
> >  	}
> >  
> > -	return done;
> > +	return 0;
> >  }
> >  
> >  /**
> > -- 
> > 2.48.1
> > 
> > 
> 

